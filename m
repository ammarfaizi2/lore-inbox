Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319128AbSHMW6r>; Tue, 13 Aug 2002 18:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319121AbSHMW5Y>; Tue, 13 Aug 2002 18:57:24 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:3323 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319101AbSHMW4p>; Tue, 13 Aug 2002 18:56:45 -0400
Date: Tue, 13 Aug 2002 19:00:33 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 11/38: CLIENT: changes to mount path in fs/nfs/inode.c
Message-ID: <Pine.SOL.4.44.0208131900140.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes the mount path in fs/nfs/inode.c in accordance
with the new mount_data fields defined in the previous patch.

First, some minor input validation (such as checking strings for
null-termination) is done on the new fields.  Second, new fields
are defined in the private area of the NFS superblock to remember
the values of the new fields.  Since one of these is dynamically
allocated, we make sure to clean up with kfree() on unmount.

Since we're adding fields to the private area of the NFS superblock
here, we also add fields 'lease_time', 'last_renewal' which will
be used by NFSv4 (no meaning for NFSv2/v3 mounts).

--- old/include/linux/nfs_fs_sb.h	Wed Jul 24 16:03:32 2002
+++ new/include/linux/nfs_fs_sb.h	Mon Jul 29 11:50:09 2002
@@ -29,6 +29,15 @@ struct nfs_server {
 				lru_busy;
 	struct nfs_fh		fh;
 	struct sockaddr_in	addr;
+#if CONFIG_NFS_V4
+	/* Our own IP address, as a null-terminated string.
+	 * This is used to generate the clientid, and the callback address. */
+	char			ip_addr[16];
+	char *			mnt_path;
+	struct nfs4_client *	nfs4_state;	/* all NFSv4 state starts here */
+	unsigned long		lease_time;     /* in jiffies */
+	unsigned long		last_renewal;   /* in jiffies */
+#endif
 };

 #endif
--- old/include/linux/nfs_fs.h	Thu Aug  8 11:49:20 2002
+++ new/include/linux/nfs_fs.h	Thu Aug  8 15:33:01 2002
@@ -26,6 +26,7 @@
 #include <linux/nfs3.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_xdr.h>
+#include <linux/nfs_mount.h>

 /*
  * Enable debugging support for nfs client.
@@ -448,6 +449,40 @@ nfs_async_handle_jukebox(struct rpc_task
 }
 #endif /* CONFIG_NFS_V3 */

+#ifdef CONFIG_NFS_V4
+
+extern struct nfs4_client *nfs4_get_client(void);
+extern void nfs4_put_client(struct nfs4_client *clp);
+
+static inline int
+create_nfsv4_state(struct nfs_server *server, struct nfs_mount_data *data)
+{
+	server->mnt_path = kmalloc(strlen(data->mnt_path) + 1, GFP_KERNEL);
+	if (!server->mnt_path)
+		return -ENOMEM;
+	strcpy(server->mnt_path, data->mnt_path);
+	strcpy(server->ip_addr, data->ip_addr);
+	server->nfs4_state = NULL;
+	return 0;
+}
+
+static inline void
+destroy_nfsv4_state(struct nfs_server *server)
+{
+	if (server->mnt_path) {
+		kfree(server->mnt_path);
+		server->mnt_path = NULL;
+	}
+	if (server->nfs4_state) {
+		nfs4_put_client(server->nfs4_state);
+		server->nfs4_state = NULL;
+	}
+}
+#else
+#define create_nfsv4_state(server, data)  0
+#define destroy_nfsv4_state(server)       do { } while (0)
+#endif /* CONFIG_NFS_V4 */
+
 #endif /* __KERNEL__ */

 /*
--- old/fs/nfs/inode.c	Thu Aug  8 12:00:17 2002
+++ new/fs/nfs/inode.c	Thu Aug  8 09:34:16 2002
@@ -153,6 +153,7 @@ nfs_put_super(struct super_block *sb)
 		lockd_down();	/* release rpc.lockd */
 	rpciod_down();		/* release rpciod */

+	destroy_nfsv4_state(server);
 	kfree(server->hostname);
 }

@@ -277,6 +278,8 @@ int nfs_fill_super(struct super_block *s
 	INIT_LIST_HEAD(&server->lru_dirty);
 	INIT_LIST_HEAD(&server->lru_commit);
 	INIT_LIST_HEAD(&server->lru_busy);
+	if (create_nfsv4_state(server, data))
+		goto out_free_host;

  nfsv3_try_again:
 	/* Check NFS protocol revision and initialize RPC op vector
@@ -457,6 +460,7 @@ out_no_xprt:

 out_free_host:
 	nfs_reqlist_free(server);
+	destroy_nfsv4_state(server);
 	kfree(server->hostname);
 out_unlock:
 	goto out_fail;
@@ -1186,6 +1190,17 @@ static struct super_block *nfs_get_sb(st
 			root->size = NFS2_FHSIZE;
 			memcpy(root->data, data->old_root.data, NFS2_FHSIZE);
 		}
+		if (data->version < 5) {
+			data->flags &= ~NFS_MOUNT_VER4;
+			memset(data->mnt_path, 0, sizeof(data->mnt_path));
+			memset(data->ip_addr, 0, sizeof(data->ip_addr));
+		}
+	}
+
+	if ((data->flags & NFS_MOUNT_VER3) && (data->flags & NFS_MOUNT_VER4)) {
+		printk(KERN_INFO "NFS: mount program specifed both NFSv3 and NFSv4?!\n");
+		kfree(server);
+		return ERR_PTR(-EINVAL);
 	}

 	if (root->size > sizeof(root->data)) {
@@ -1199,6 +1214,18 @@ static struct super_block *nfs_get_sb(st
 		kfree(server);
 		return ERR_PTR(-EINVAL);
 	}
+
+	/* Check that mount path and ip address are null-terminated. */
+	if (!memchr(data->mnt_path, 0, sizeof(data->mnt_path))) {
+		printk("NFS: mount path not null-terminated!\n");
+		kfree(server);
+		return ERR_PTR(-EINVAL);
+	}
+	if (!memchr(data->ip_addr, 0, sizeof(data->ip_addr))) {
+		printk("NFS: ip_addr not null-terminated!\n");
+		kfree(server);
+		return ERR_PTR(-EINVAL);
+	}

 	s = sget(fs_type, nfs_compare_super, nfs_set_super, server);


