Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289466AbSBEL7D>; Tue, 5 Feb 2002 06:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289380AbSBEL6v>; Tue, 5 Feb 2002 06:58:51 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:59140 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289466AbSBEL6k>; Tue, 5 Feb 2002 06:58:40 -0500
Date: Tue, 5 Feb 2002 14:58:38 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs to correctly deal with stale nfs handles
Message-ID: <20020205145838.A1191@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    This is to fix a case where stale NFS handles are correctly detected as
    stale, but inodes assotiated with them are still valid and present in cache,    hence there is no way to deal with files, these handles are attached to.
    Bug was found and explained by
    Anne Milicia <milicia@missioncriticallinux.com>

Bye,
    Oleg

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfs_stale_inode_access.diff"

--- linux/fs/reiserfs/inode.c.o	Fri Feb  1 14:08:22 2002
+++ linux/fs/reiserfs/inode.c	Fri Feb  1 14:09:40 2002
@@ -1156,6 +1156,7 @@
 	/* a stale NFS handle can trigger this without it being an error */
 	pathrelse (&path_to_sd);
 	make_bad_inode(inode) ;
+	inode->i_nlink = 0;
 	return;
     }
 
@@ -1188,6 +1189,27 @@
 
 }
 
+/**
+ * reiserfs_find_actor() - "find actor" reiserfs supplies to iget4().
+ *
+ * @inode:    inode from hash table to check
+ * @inode_no: inode number we are looking for
+ * @opaque:   "cookie" passed to iget4(). This is &reiserfs_iget4_args.
+ *
+ * This function is called by iget4() to distinguish reiserfs inodes
+ * having the same inode numbers. Such inodes can only exist due to some
+ * error condition. One of them should be bad. Inodes with identical
+ * inode numbers (objectids) are distinguished by parent directory ids.
+ *
+ */
+static int reiserfs_find_actor( struct inode *inode, 
+				unsigned long inode_no, void *opaque )
+{
+    struct reiserfs_iget4_args *args;
+
+    args = opaque;
+    return INODE_PKEY( inode ) -> k_dir_id == args -> objectid;
+}
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)
 {
@@ -1195,7 +1217,8 @@
     struct reiserfs_iget4_args args ;
 
     args.objectid = key->on_disk_key.k_dir_id ;
-    inode = iget4 (s, key->on_disk_key.k_objectid, 0, (void *)(&args));
+    inode = iget4 (s, key->on_disk_key.k_objectid, 
+		   reiserfs_find_actor, (void *)(&args));
     if (!inode) 
 	return ERR_PTR(-ENOMEM) ;
 

--OgqxwSJOaUobr8KG--
