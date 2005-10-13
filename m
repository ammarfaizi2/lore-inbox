Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVJMT46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVJMT46 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVJMT46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:56:58 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:46222 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751103AbVJMT45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:56:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=fKPfHVq4D7OXszPH6VUdwFBSIGfXGPlJdBF67YbmAKqD+Fw1/RcSRAoYfl78CaXjoduXMebypPR2NQ6GgFfGOk8/XqU2CQELhY/Py1mwjX3f7GT8GMcln+RaTHxJ05NfWV9n2DbXlgtEgG7Om7VCl10HZrn1jfok91Uy0D+HlDM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/14] Big kfree NULL check cleanup - fs
Date: Thu, 13 Oct 2005 21:59:51 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200510132159.51440.jesper.juhl@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, it seems that all the other patches hit LKML just fine, just not this one
perhaps the CC list was too long.
Resending to just LKML and Andrew.

---


This is the fs/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in fs/.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 fs/9p/trans_sock.c      |    3 -
 fs/affs/super.c         |   16 +++------
 fs/afs/file.c           |    3 -
 fs/autofs/waitq.c       |    6 +--
 fs/autofs4/inode.c      |    6 +--
 fs/autofs4/waitq.c      |    6 +--
 fs/befs/linuxvfs.c      |   12 ++-----
 fs/binfmt_elf.c         |    3 -
 fs/binfmt_elf_fdpic.c   |   15 ++------
 fs/cifs/asn1.c          |    3 -
 fs/cifs/connect.c       |   81 ++++++++++++++++--------------------------------
 fs/cifs/link.c          |   23 ++++---------
 fs/cifs/misc.c          |   15 ++------
 fs/cifs/xattr.c         |   15 ++------
 fs/compat_ioctl.c       |    3 +
 fs/devfs/base.c         |    6 +--
 fs/ext2/acl.c           |    6 +--
 fs/hostfs/hostfs_kern.c |    3 -
 fs/hpfs/dnode.c         |    8 ++--
 fs/hpfs/super.c         |   10 ++---
 fs/isofs/inode.c        |   12 ++-----
 fs/jbd/commit.c         |    6 +--
 fs/jbd/transaction.c    |    9 +----
 fs/jffs/intrep.c        |   18 ++++------
 fs/jffs2/readinode.c    |    8 +---
 fs/jffs2/wbuf.c         |    3 -
 fs/lockd/clntproc.c     |    3 -
 fs/mbcache.c            |    3 -
 fs/nfs/delegation.c     |    3 -
 fs/nfs/inode.c          |   15 ++------
 fs/nfs/nfs4state.c      |    9 +----
 fs/nfs/proc.c           |    3 -
 fs/nfs/unlink.c         |    3 -
 fs/nfsd/export.c        |    6 +--
 fs/nfsd/nfs4xdr.c       |    9 +----
 fs/nfsd/nfscache.c      |    3 -
 fs/openpromfs/inode.c   |    3 -
 fs/reiserfs/super.c     |   27 +++++-----------
 fs/reiserfs/xattr_acl.c |    3 -
 fs/udf/udf_sb.h         |    3 -
 fs/ufs/super.c          |   14 ++++----
 fs/xattr.c              |    9 +----
 42 files changed, 148 insertions(+), 267 deletions(-)

--- linux-2.6.14-rc4-orig/fs/9p/trans_sock.c	2005-10-11 22:41:22.000000000 +0200
+++ linux-2.6.14-rc4/fs/9p/trans_sock.c	2005-10-13 10:42:04.000000000 +0200
@@ -269,8 +269,7 @@ static void v9fs_sock_close(struct v9fs_
 		dprintk(DEBUG_TRANS, "socket closed\n");
 	}
 
-	if (ts)
-		kfree(ts);
+	kfree(ts);
 
 	trans->priv = NULL;
 }
--- linux-2.6.14-rc4-orig/fs/afs/file.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/afs/file.c	2005-10-13 10:42:11.000000000 +0200
@@ -295,8 +295,7 @@ static int afs_file_releasepage(struct p
 		page->private = 0;
 		ClearPagePrivate(page);
 
-		if (pageio)
-			kfree(pageio);
+		kfree(pageio);
 	}
 
 	_leave(" = 0");
--- linux-2.6.14-rc4-orig/fs/jbd/transaction.c	2005-10-11 22:41:24.000000000 +0200
+++ linux-2.6.14-rc4/fs/jbd/transaction.c	2005-10-13 10:42:40.000000000 +0200
@@ -227,8 +227,7 @@ repeat_locked:
 	spin_unlock(&transaction->t_handle_lock);
 	spin_unlock(&journal->j_state_lock);
 out:
-	if (new_transaction)
-		kfree(new_transaction);
+	kfree(new_transaction);
 	return ret;
 }
 
@@ -725,8 +724,7 @@ done:
 	journal_cancel_revoke(handle, jh);
 
 out:
-	if (frozen_buffer)
-		kfree(frozen_buffer);
+	kfree(frozen_buffer);
 
 	JBUFFER_TRACE(jh, "exit");
 	return error;
@@ -905,8 +903,7 @@ repeat:
 	jbd_unlock_bh_state(bh);
 out:
 	journal_put_journal_head(jh);
-	if (committed_data)
-		kfree(committed_data);
+	kfree(committed_data);
 	return err;
 }
 
--- linux-2.6.14-rc4-orig/fs/jbd/commit.c	2005-10-11 22:41:24.000000000 +0200
+++ linux-2.6.14-rc4/fs/jbd/commit.c	2005-10-13 10:43:13.000000000 +0200
@@ -261,10 +261,8 @@ void journal_commit_transaction(journal_
 			struct buffer_head *bh = jh2bh(jh);
 
 			jbd_lock_bh_state(bh);
-			if (jh->b_committed_data) {
-				kfree(jh->b_committed_data);
-				jh->b_committed_data = NULL;
-			}
+			kfree(jh->b_committed_data);
+			jh->b_committed_data = NULL;
 			jbd_unlock_bh_state(bh);
 		}
 		journal_refile_buffer(journal, jh);
--- linux-2.6.14-rc4-orig/fs/nfs/unlink.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/nfs/unlink.c	2005-10-13 10:43:31.000000000 +0200
@@ -52,8 +52,7 @@ nfs_put_unlinkdata(struct nfs_unlinkdata
 {
 	if (--data->count == 0) {
 		nfs_detach_unlinkdata(data);
-		if (data->name.name != NULL)
-			kfree(data->name.name);
+		kfree(data->name.name);
 		kfree(data);
 	}
 }
--- linux-2.6.14-rc4-orig/fs/nfs/proc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/nfs/proc.c	2005-10-13 10:43:45.000000000 +0200
@@ -331,8 +331,7 @@ nfs_proc_unlink_done(struct dentry *dir,
 {
 	struct rpc_message *msg = &task->tk_msg;
 	
-	if (msg->rpc_argp)
-		kfree(msg->rpc_argp);
+	kfree(msg->rpc_argp);
 	return 0;
 }
 
--- linux-2.6.14-rc4-orig/fs/nfs/delegation.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/nfs/delegation.c	2005-10-13 10:43:55.000000000 +0200
@@ -111,8 +111,7 @@ int nfs_inode_set_delegation(struct inod
 		}
 	}
 	spin_unlock(&clp->cl_lock);
-	if (delegation != NULL)
-		kfree(delegation);
+	kfree(delegation);
 	return status;
 }
 
--- linux-2.6.14-rc4-orig/fs/nfs/inode.c	2005-10-11 22:41:24.000000000 +0200
+++ linux-2.6.14-rc4/fs/nfs/inode.c	2005-10-13 10:44:38.000000000 +0200
@@ -1605,8 +1605,7 @@ static void nfs_kill_super(struct super_
 
 	rpciod_down();		/* release rpciod */
 
-	if (server->hostname != NULL)
-		kfree(server->hostname);
+	kfree(server->hostname);
 	kfree(server);
 }
 
@@ -1848,8 +1847,7 @@ nfs_copy_user_string(char *dst, struct n
 			return ERR_PTR(-ENOMEM);
 	}
 	if (copy_from_user(dst, src->data, maxlen)) {
-		if (p != NULL)
-			kfree(p);
+		kfree(p);
 		return ERR_PTR(-EFAULT);
 	}
 	dst[maxlen] = '\0';
@@ -1940,10 +1938,8 @@ static struct super_block *nfs4_get_sb(s
 out_err:
 	s = (struct super_block *)p;
 out_free:
-	if (server->mnt_path)
-		kfree(server->mnt_path);
-	if (server->hostname)
-		kfree(server->hostname);
+	kfree(server->mnt_path);
+	kfree(server->hostname);
 	kfree(server);
 	return s;
 }
@@ -1963,8 +1959,7 @@ static void nfs4_kill_super(struct super
 
 	destroy_nfsv4_state(server);
 
-	if (server->hostname != NULL)
-		kfree(server->hostname);
+	kfree(server->hostname);
 	kfree(server);
 }
 
--- linux-2.6.14-rc4-orig/fs/nfs/nfs4state.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/nfs/nfs4state.c	2005-10-13 10:45:00.000000000 +0200
@@ -69,10 +69,8 @@ init_nfsv4_state(struct nfs_server *serv
 void
 destroy_nfsv4_state(struct nfs_server *server)
 {
-	if (server->mnt_path) {
-		kfree(server->mnt_path);
-		server->mnt_path = NULL;
-	}
+	kfree(server->mnt_path);
+	server->mnt_path = NULL;
 	if (server->nfs4_state) {
 		nfs4_put_client(server->nfs4_state);
 		server->nfs4_state = NULL;
@@ -308,8 +306,7 @@ struct nfs4_state_owner *nfs4_get_state_
 		new = NULL;
 	}
 	spin_unlock(&clp->cl_lock);
-	if (new)
-		kfree(new);
+	kfree(new);
 	if (sp != NULL)
 		return sp;
 	put_rpccred(cred);
--- linux-2.6.14-rc4-orig/fs/udf/udf_sb.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/udf/udf_sb.h	2005-10-13 10:46:37.000000000 +0200
@@ -39,8 +39,7 @@ static inline struct udf_sb_info *UDF_SB
 {\
 	if (UDF_SB(X))\
 	{\
-		if (UDF_SB_PARTMAPS(X))\
-			kfree(UDF_SB_PARTMAPS(X));\
+		kfree(UDF_SB_PARTMAPS(X));\
 		UDF_SB_PARTMAPS(X) = NULL;\
 	}\
 }
--- linux-2.6.14-rc4-orig/fs/ufs/super.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/ufs/super.c	2005-10-13 10:48:01.000000000 +0200
@@ -472,13 +472,14 @@ static int ufs_read_cylinder_structures 
 	return 1;
 
 failed:
-	if (base) kfree (base);
+	kfree (base);
 	if (sbi->s_ucg) {
 		for (i = 0; i < uspi->s_ncg; i++)
-			if (sbi->s_ucg[i]) brelse (sbi->s_ucg[i]);
+			if (sbi->s_ucg[i])
+				brelse (sbi->s_ucg[i]);
 		kfree (sbi->s_ucg);
 		for (i = 0; i < UFS_MAX_GROUP_LOADED; i++)
-			if (sbi->s_ucpi[i]) kfree (sbi->s_ucpi[i]);
+			kfree (sbi->s_ucpi[i]);
 	}
 	UFSD(("EXIT (FAILED)\n"))
 	return 0;
@@ -981,9 +982,10 @@ magic_found:
 dalloc_failed:
 	iput(inode);
 failed:
-	if (ubh) ubh_brelse_uspi (uspi);
-	if (uspi) kfree (uspi);
-	if (sbi) kfree(sbi);
+	if (ubh)
+		ubh_brelse_uspi (uspi);
+	kfree (uspi);
+	kfree(sbi);
 	sb->s_fs_info = NULL;
 	UFSD(("EXIT (FAILED)\n"))
 	return -EINVAL;
--- linux-2.6.14-rc4-orig/fs/affs/super.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/affs/super.c	2005-10-13 10:48:49.000000000 +0200
@@ -35,8 +35,7 @@ affs_put_super(struct super_block *sb)
 		mark_buffer_dirty(sbi->s_root_bh);
 	}
 
-	if (sbi->s_prefix)
-		kfree(sbi->s_prefix);
+	kfree(sbi->s_prefix);
 	affs_free_bitmap(sb);
 	affs_brelse(sbi->s_root_bh);
 	kfree(sbi);
@@ -198,10 +197,9 @@ parse_options(char *options, uid_t *uid,
 			*mount_opts |= SF_MUFS;
 			break;
 		case Opt_prefix:
-			if (*prefix) {		/* Free any previous prefix */
-				kfree(*prefix);
-				*prefix = NULL;
-			}
+			/* Free any previous prefix */
+			kfree(*prefix);
+			*prefix = NULL;
 			*prefix = match_strdup(&args[0]);
 			if (!*prefix)
 				return 0;
@@ -462,11 +460,9 @@ got_root:
 out_error:
 	if (root_inode)
 		iput(root_inode);
-	if (sbi->s_bitmap)
-		kfree(sbi->s_bitmap);
+	kfree(sbi->s_bitmap);
 	affs_brelse(root_bh);
-	if (sbi->s_prefix)
-		kfree(sbi->s_prefix);
+	kfree(sbi->s_prefix);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 	return -EINVAL;
--- linux-2.6.14-rc4-orig/fs/befs/linuxvfs.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/befs/linuxvfs.c	2005-10-13 10:49:46.000000000 +0200
@@ -731,20 +731,16 @@ parse_options(char *options, befs_mount_
 static void
 befs_put_super(struct super_block *sb)
 {
-	if (BEFS_SB(sb)->mount_opts.iocharset) {
-		kfree(BEFS_SB(sb)->mount_opts.iocharset);
-		BEFS_SB(sb)->mount_opts.iocharset = NULL;
-	}
+	kfree(BEFS_SB(sb)->mount_opts.iocharset);
+	BEFS_SB(sb)->mount_opts.iocharset = NULL;
 
 	if (BEFS_SB(sb)->nls) {
 		unload_nls(BEFS_SB(sb)->nls);
 		BEFS_SB(sb)->nls = NULL;
 	}
 
-	if (sb->s_fs_info) {
-		kfree(sb->s_fs_info);
-		sb->s_fs_info = NULL;
-	}
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 	return;
 }
 
--- linux-2.6.14-rc4-orig/fs/cifs/connect.c	2005-10-11 22:41:22.000000000 +0200
+++ linux-2.6.14-rc4/fs/cifs/connect.c	2005-10-13 10:52:36.000000000 +0200
@@ -1187,8 +1187,7 @@ connect_to_dfs_path(int xid, struct cifs
 		the helper that resolves tcp names, mount to it, try to 
 		tcon to it unmount it if fail */
 
-	if(referrals)
-		kfree(referrals);
+	kfree(referrals);
 
 	return rc;
 }
@@ -1445,10 +1444,8 @@ cifs_mount(struct super_block *sb, struc
 	
 	memset(&volume_info,0,sizeof(struct smb_vol));
 	if (cifs_parse_mount_options(mount_data, devname, &volume_info)) {
-		if(volume_info.UNC)
-			kfree(volume_info.UNC);
-		if(volume_info.password)
-			kfree(volume_info.password);
+		kfree(volume_info.UNC);
+		kfree(volume_info.password);
 		FreeXid(xid);
 		return -EINVAL;
 	}
@@ -1461,10 +1458,8 @@ cifs_mount(struct super_block *sb, struc
 		cifserror("No username specified ");
         /* In userspace mount helper we can get user name from alternate
            locations such as env variables and files on disk */
-		if(volume_info.UNC)
-			kfree(volume_info.UNC);
-		if(volume_info.password)
-			kfree(volume_info.password);
+		kfree(volume_info.UNC);
+		kfree(volume_info.password);
 		FreeXid(xid);
 		return -EINVAL;
 	}
@@ -1483,10 +1478,8 @@ cifs_mount(struct super_block *sb, struc
        
 		if(rc <= 0) {
 			/* we failed translating address */
-			if(volume_info.UNC)
-				kfree(volume_info.UNC);
-			if(volume_info.password)
-				kfree(volume_info.password);
+			kfree(volume_info.UNC);
+			kfree(volume_info.password);
 			FreeXid(xid);
 			return -EINVAL;
 		}
@@ -1497,19 +1490,15 @@ cifs_mount(struct super_block *sb, struc
 	} else if (volume_info.UNCip){
 		/* BB using ip addr as server name connect to the DFS root below */
 		cERROR(1,("Connecting to DFS root not implemented yet"));
-		if(volume_info.UNC)
-			kfree(volume_info.UNC);
-		if(volume_info.password)
-			kfree(volume_info.password);
+		kfree(volume_info.UNC);
+		kfree(volume_info.password);
 		FreeXid(xid);
 		return -EINVAL;
 	} else /* which servers DFS root would we conect to */ {
 		cERROR(1,
 		       ("CIFS mount error: No UNC path (e.g. -o unc=//192.168.1.100/public) specified  "));
-		if(volume_info.UNC)
-			kfree(volume_info.UNC);
-		if(volume_info.password)
-			kfree(volume_info.password);
+		kfree(volume_info.UNC);
+		kfree(volume_info.password);
 		FreeXid(xid);
 		return -EINVAL;
 	}
@@ -1522,10 +1511,8 @@ cifs_mount(struct super_block *sb, struc
 		cifs_sb->local_nls = load_nls(volume_info.iocharset);
 		if(cifs_sb->local_nls == NULL) {
 			cERROR(1,("CIFS mount error: iocharset %s not found",volume_info.iocharset));
-			if(volume_info.UNC)
-				kfree(volume_info.UNC);
-			if(volume_info.password)
-				kfree(volume_info.password);
+			kfree(volume_info.UNC);
+			kfree(volume_info.password);
 			FreeXid(xid);
 			return -ELIBACC;
 		}
@@ -1540,10 +1527,8 @@ cifs_mount(struct super_block *sb, struc
 			&sin_server6.sin6_addr,
 			volume_info.username, &srvTcp);
 	else {
-		if(volume_info.UNC)
-			kfree(volume_info.UNC);
-		if(volume_info.password)
-			kfree(volume_info.password);
+		kfree(volume_info.UNC);
+		kfree(volume_info.password);
 		FreeXid(xid);
 		return -EINVAL;
 	}
@@ -1562,10 +1547,8 @@ cifs_mount(struct super_block *sb, struc
 			       ("Error connecting to IPv4 socket. Aborting operation"));
 			if(csocket != NULL)
 				sock_release(csocket);
-			if(volume_info.UNC)
-				kfree(volume_info.UNC);
-			if(volume_info.password)
-				kfree(volume_info.password);
+			kfree(volume_info.UNC);
+			kfree(volume_info.password);
 			FreeXid(xid);
 			return rc;
 		}
@@ -1574,10 +1557,8 @@ cifs_mount(struct super_block *sb, struc
 		if (srvTcp == NULL) {
 			rc = -ENOMEM;
 			sock_release(csocket);
-			if(volume_info.UNC)
-				kfree(volume_info.UNC);
-			if(volume_info.password)
-				kfree(volume_info.password);
+			kfree(volume_info.UNC);
+			kfree(volume_info.password);
 			FreeXid(xid);
 			return rc;
 		} else {
@@ -1600,10 +1581,8 @@ cifs_mount(struct super_block *sb, struc
 			if(rc < 0) {
 				rc = -ENOMEM;
 				sock_release(csocket);
-				if(volume_info.UNC)
-					kfree(volume_info.UNC);
-				if(volume_info.password)
-					kfree(volume_info.password);
+				kfree(volume_info.UNC);
+				kfree(volume_info.password);
 				FreeXid(xid);
 				return rc;
 			} else
@@ -1616,8 +1595,7 @@ cifs_mount(struct super_block *sb, struc
 	if (existingCifsSes) {
 		pSesInfo = existingCifsSes;
 		cFYI(1, ("Existing smb sess found "));
-		if(volume_info.password)
-			kfree(volume_info.password);
+		kfree(volume_info.password);
 		/* volume_info.UNC freed at end of function */
 	} else if (!rc) {
 		cFYI(1, ("Existing smb sess not found "));
@@ -1647,8 +1625,7 @@ cifs_mount(struct super_block *sb, struc
 			if(!rc)
 				atomic_inc(&srvTcp->socketUseCount);
 		} else
-			if(volume_info.password)
-				kfree(volume_info.password);
+			kfree(volume_info.password);
 	}
     
 	/* search for existing tcon to this server share */
@@ -1711,8 +1688,7 @@ cifs_mount(struct super_block *sb, struc
 							"", cifs_sb->local_nls,
 							cifs_sb->mnt_cifs_flags & 
 							  CIFS_MOUNT_MAP_SPECIAL_CHR);
-					if(volume_info.UNC)
-						kfree(volume_info.UNC);
+					kfree(volume_info.UNC);
 					FreeXid(xid);
 					return -ENODEV;
 				} else {
@@ -1791,8 +1767,7 @@ cifs_mount(struct super_block *sb, struc
 	(in which case it is not needed anymore) but when new sesion is created
 	the password ptr is put in the new session structure (in which case the
 	password will be freed at unmount time) */
-	if(volume_info.UNC)
-		kfree(volume_info.UNC);
+	kfree(volume_info.UNC);
 	FreeXid(xid);
 	return rc;
 }
@@ -3140,8 +3115,7 @@ CIFSTCon(unsigned int xid, struct cifsSe
 			if ((bcc_ptr + (2 * length)) -
 			     pByteArea(smb_buffer_response) <=
 			    BCC(smb_buffer_response)) {
-				if(tcon->nativeFileSystem)
-					kfree(tcon->nativeFileSystem);
+				kfree(tcon->nativeFileSystem);
 				tcon->nativeFileSystem =
 				    kzalloc(length + 2, GFP_KERNEL);
 				cifs_strfromUCS_le(tcon->nativeFileSystem,
@@ -3158,8 +3132,7 @@ CIFSTCon(unsigned int xid, struct cifsSe
 			if ((bcc_ptr + length) -
 			    pByteArea(smb_buffer_response) <=
 			    BCC(smb_buffer_response)) {
-				if(tcon->nativeFileSystem)
-					kfree(tcon->nativeFileSystem);
+				kfree(tcon->nativeFileSystem);
 				tcon->nativeFileSystem =
 				    kzalloc(length + 1, GFP_KERNEL);
 				strncpy(tcon->nativeFileSystem, bcc_ptr,
--- linux-2.6.14-rc4-orig/fs/cifs/asn1.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/cifs/asn1.c	2005-10-13 10:52:56.000000000 +0200
@@ -552,8 +552,7 @@ decode_negTokenInit(unsigned char *secur
 					   *(oid + 3)));
 					rc = compare_oid(oid, oidlen, NTLMSSP_OID,
 						 NTLMSSP_OID_LEN);
-					if(oid)
-						kfree(oid);
+					kfree(oid);
 					if (rc)
 						use_ntlmssp = TRUE;
 				}
--- linux-2.6.14-rc4-orig/fs/cifs/link.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/cifs/link.c	2005-10-13 10:53:40.000000000 +0200
@@ -84,10 +84,8 @@ cifs_hardlink(struct dentry *old_file, s
 	cifsInode->time = 0;	/* will force revalidate to go get info when needed */
 
 cifs_hl_exit:
-	if (fromName)
-		kfree(fromName);
-	if (toName)
-		kfree(toName);
+	kfree(fromName);
+	kfree(toName);
 	FreeXid(xid);
 	return rc;
 }
@@ -203,8 +201,7 @@ cifs_symlink(struct inode *inode, struct
 		}
 	}
 
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 	return rc;
 }
@@ -250,8 +247,7 @@ cifs_readlink(struct dentry *direntry, c
 		len = buflen;
 	tmpbuffer = kmalloc(len,GFP_KERNEL);   
 	if(tmpbuffer == NULL) {
-		if (full_path)
-			kfree(full_path);
+		kfree(full_path);
 		FreeXid(xid);
 		return -ENOMEM;
 	}
@@ -300,8 +296,7 @@ cifs_readlink(struct dentry *direntry, c
 							strncpy(tmpbuffer, referrals, len-1);                            
 						}
 					}
-					if(referrals)
-						kfree(referrals);
+					kfree(referrals);
 					kfree(tmp_path);
 }
 				/* BB add code like else decode referrals then memcpy to
@@ -320,12 +315,8 @@ cifs_readlink(struct dentry *direntry, c
 		      rc));
 	}
 
-	if (tmpbuffer) {
-		kfree(tmpbuffer);
-	}
-	if (full_path) {
-		kfree(full_path);
-	}
+	kfree(tmpbuffer);
+	kfree(full_path);
 	FreeXid(xid);
 	return rc;
 }
--- linux-2.6.14-rc4-orig/fs/cifs/misc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/cifs/misc.c	2005-10-13 10:54:10.000000000 +0200
@@ -98,14 +98,10 @@ sesInfoFree(struct cifsSesInfo *buf_to_f
 	atomic_dec(&sesInfoAllocCount);
 	list_del(&buf_to_free->cifsSessionList);
 	write_unlock(&GlobalSMBSeslock);
-	if (buf_to_free->serverOS)
-		kfree(buf_to_free->serverOS);
-	if (buf_to_free->serverDomain)
-		kfree(buf_to_free->serverDomain);
-	if (buf_to_free->serverNOS)
-		kfree(buf_to_free->serverNOS);
-	if (buf_to_free->password)
-		kfree(buf_to_free->password);
+	kfree(buf_to_free->serverOS);
+	kfree(buf_to_free->serverDomain);
+	kfree(buf_to_free->serverNOS);
+	kfree(buf_to_free->password);
 	kfree(buf_to_free);
 }
 
@@ -144,8 +140,7 @@ tconInfoFree(struct cifsTconInfo *buf_to
 	atomic_dec(&tconInfoAllocCount);
 	list_del(&buf_to_free->cifsConnectionList);
 	write_unlock(&GlobalSMBSeslock);
-	if (buf_to_free->nativeFileSystem)
-		kfree(buf_to_free->nativeFileSystem);
+	kfree(buf_to_free->nativeFileSystem);
 	kfree(buf_to_free);
 }
 
--- linux-2.6.14-rc4-orig/fs/cifs/xattr.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/cifs/xattr.c	2005-10-13 10:54:33.000000000 +0200
@@ -87,8 +87,7 @@ int cifs_removexattr(struct dentry * dir
 			cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MAP_SPECIAL_CHR);
 	}
 remove_ea_exit:
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 #endif
 	return rc;
@@ -132,8 +131,7 @@ int cifs_setxattr(struct dentry * dirent
 		returns as xattrs */
 	if(value_size > MAX_EA_VALUE_SIZE) {
 		cFYI(1,("size of EA value too large"));
-		if(full_path)
-			kfree(full_path);
+		kfree(full_path);
 		FreeXid(xid);
 		return -EOPNOTSUPP;
 	}
@@ -195,8 +193,7 @@ int cifs_setxattr(struct dentry * dirent
 	}
 
 set_ea_exit:
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 #endif
 	return rc;
@@ -298,8 +295,7 @@ ssize_t cifs_getxattr(struct dentry * di
 		rc = -EOPNOTSUPP; 
 
 get_ea_exit:
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 #endif
 	return rc;
@@ -345,8 +341,7 @@ ssize_t cifs_listxattr(struct dentry * d
 				cifs_sb->mnt_cifs_flags & 
 					CIFS_MOUNT_MAP_SPECIAL_CHR);
 
-	if (full_path)
-		kfree(full_path);
+	kfree(full_path);
 	FreeXid(xid);
 #endif
 	return rc;
--- linux-2.6.14-rc4-orig/fs/ext2/acl.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/ext2/acl.c	2005-10-13 10:55:22.000000000 +0200
@@ -194,8 +194,7 @@ ext2_get_acl(struct inode *inode, int ty
 		acl = NULL;
 	else
 		acl = ERR_PTR(retval);
-	if (value)
-		kfree(value);
+	kfree(value);
 
 	if (!IS_ERR(acl)) {
 		switch(type) {
@@ -262,8 +261,7 @@ ext2_set_acl(struct inode *inode, int ty
 
 	error = ext2_xattr_set(inode, name_index, "", value, size, 0);
 
-	if (value)
-		kfree(value);
+	kfree(value);
 	if (!error) {
 		switch(type) {
 			case ACL_TYPE_ACCESS:
--- linux-2.6.14-rc4-orig/fs/hpfs/dnode.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/hpfs/dnode.c	2005-10-13 10:56:58.000000000 +0200
@@ -244,12 +244,12 @@ static int hpfs_add_to_dnode(struct inod
 	go_up:
 	if (namelen >= 256) {
 		hpfs_error(i->i_sb, "hpfs_add_to_dnode: namelen == %d", namelen);
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
 	if (!(d = hpfs_map_dnode(i->i_sb, dno, &qbh))) {
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 1;
 	}
@@ -257,7 +257,7 @@ static int hpfs_add_to_dnode(struct inod
 	if (hpfs_sb(i->i_sb)->sb_chk)
 		if (hpfs_stop_cycles(i->i_sb, dno, &c1, &c2, "hpfs_add_to_dnode")) {
 			hpfs_brelse4(&qbh);
-			if (nd) kfree(nd);
+			kfree(nd);
 			kfree(nname);
 			return 1;
 		}
@@ -270,7 +270,7 @@ static int hpfs_add_to_dnode(struct inod
 		for_all_poss(i, hpfs_pos_subst, 5, t + 1);
 		hpfs_mark_4buffers_dirty(&qbh);
 		hpfs_brelse4(&qbh);
-		if (nd) kfree(nd);
+		kfree(nd);
 		kfree(nname);
 		return 0;
 	}
--- linux-2.6.14-rc4-orig/fs/hpfs/super.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/hpfs/super.c	2005-10-13 10:57:36.000000000 +0200
@@ -75,7 +75,7 @@ void hpfs_error(struct super_block *s, c
 		} else if (s->s_flags & MS_RDONLY) printk("; going on - but anything won't be destroyed because it's read-only\n");
 		else printk("; corrupted filesystem mounted read/write - your computer will explode within 20 seconds ... but you wanted it so!\n");
 	} else printk("\n");
-	if (buf) kfree(buf);
+	kfree(buf);
 	hpfs_sb(s)->sb_was_error = 1;
 }
 
@@ -102,8 +102,8 @@ int hpfs_stop_cycles(struct super_block 
 static void hpfs_put_super(struct super_block *s)
 {
 	struct hpfs_sb_info *sbi = hpfs_sb(s);
-	if (sbi->sb_cp_table) kfree(sbi->sb_cp_table);
-	if (sbi->sb_bmp_dir) kfree(sbi->sb_bmp_dir);
+	kfree(sbi->sb_cp_table);
+	kfree(sbi->sb_bmp_dir);
 	unmark_dirty(s);
 	s->s_fs_info = NULL;
 	kfree(sbi);
@@ -654,8 +654,8 @@ bail3:	brelse(bh1);
 bail2:	brelse(bh0);
 bail1:
 bail0:
-	if (sbi->sb_bmp_dir) kfree(sbi->sb_bmp_dir);
-	if (sbi->sb_cp_table) kfree(sbi->sb_cp_table);
+	kfree(sbi->sb_bmp_dir);
+	kfree(sbi->sb_cp_table);
 	s->s_fs_info = NULL;
 	kfree(sbi);
 	return -EINVAL;
--- linux-2.6.14-rc4-orig/fs/jffs/intrep.c	2005-10-11 22:41:24.000000000 +0200
+++ linux-2.6.14-rc4/fs/jffs/intrep.c	2005-10-13 10:58:49.000000000 +0200
@@ -462,7 +462,7 @@ jffs_checksum_flash(struct mtd_info *mtd
 	}
 
 	/* Free read buffer */
-	kfree (read_buf);
+	kfree(read_buf);
 
 	/* Return result */
 	D3(printk("checksum result: 0x%08x\n", sum));
@@ -1011,12 +1011,12 @@ jffs_scan_flash(struct jffs_control *c)
 						       offset , fmc->sector_size);
 
 						flash_safe_release(fmc->mtd);
-						kfree (read_buf);
+						kfree(read_buf);
 						return -1; /* bad, bad, bad! */
 
 					}
 					flash_safe_release(fmc->mtd);
-					kfree (read_buf);
+					kfree(read_buf);
 
 					return -EAGAIN; /* erased offending sector. Try mount one more time please. */
 				}
@@ -1112,7 +1112,7 @@ jffs_scan_flash(struct jffs_control *c)
 		if (!node) {
 			if (!(node = jffs_alloc_node())) {
 				/* Free read buffer */
-				kfree (read_buf);
+				kfree(read_buf);
 
 				/* Release the flash device */
 				flash_safe_release(fmc->mtd);
@@ -1269,7 +1269,7 @@ jffs_scan_flash(struct jffs_control *c)
 				DJM(no_jffs_node--);
 
 				/* Free read buffer */
-				kfree (read_buf);
+				kfree(read_buf);
 
 				/* Release the flash device */
 				flash_safe_release(fmc->mtd);
@@ -1296,7 +1296,7 @@ jffs_scan_flash(struct jffs_control *c)
 					flash_safe_release(fmc->flash_part);
 
 					/* Free read buffer */
-					kfree (read_buf);
+					kfree(read_buf);
 
 					return -ENOMEM;
 				}
@@ -1324,7 +1324,7 @@ jffs_scan_flash(struct jffs_control *c)
 	jffs_build_end(fmc);
 
 	/* Free read buffer */
-	kfree (read_buf);
+	kfree(read_buf);
 
 	if(!num_free_space){
 	        printk(KERN_WARNING "jffs_scan_flash(): Did not find even a single "
@@ -1747,9 +1747,7 @@ jffs_find_child(struct jffs_file *dir, c
 		}
 		printk("jffs_find_child(): Didn't find the file \"%s\".\n",
 		       (copy ? copy : ""));
-		if (copy) {
-			kfree(copy);
-		}
+		kfree(copy);
 	});
 
 	return f;
--- linux-2.6.14-rc4-orig/fs/nfsd/export.c	2005-10-11 22:41:24.000000000 +0200
+++ linux-2.6.14-rc4/fs/nfsd/export.c	2005-10-13 10:59:19.000000000 +0200
@@ -190,8 +190,7 @@ static int expkey_parse(struct cache_det
  out:
 	if (dom)
 		auth_domain_put(dom);
-	if (buf)
-		kfree(buf);
+	kfree(buf);
 	return err;
 }
 
@@ -428,8 +427,7 @@ static int svc_export_parse(struct cache
 		path_release(&nd);
 	if (dom)
 		auth_domain_put(dom);
-	if (buf)
-		kfree(buf);
+	kfree(buf);
 	return err;
 }
 
--- linux-2.6.14-rc4-orig/fs/nfsd/nfs4xdr.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/nfsd/nfs4xdr.c	2005-10-13 10:59:50.000000000 +0200
@@ -151,8 +151,7 @@ static u32 *read_buf(struct nfsd4_compou
 	if (nbytes <= sizeof(argp->tmp))
 		p = argp->tmp;
 	else {
-		if (argp->tmpp)
-			kfree(argp->tmpp);
+		kfree(argp->tmpp);
 		p = argp->tmpp = kmalloc(nbytes, GFP_KERNEL);
 		if (!p)
 			return NULL;
@@ -2476,10 +2475,8 @@ void nfsd4_release_compoundargs(struct n
 		kfree(args->ops);
 		args->ops = args->iops;
 	}
-	if (args->tmpp) {
-		kfree(args->tmpp);
-		args->tmpp = NULL;
-	}
+	kfree(args->tmpp);
+	args->tmpp = NULL;
 	while (args->to_free) {
 		struct tmpbuf *tb = args->to_free;
 		args->to_free = tb->next;
--- linux-2.6.14-rc4-orig/fs/nfsd/nfscache.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/nfsd/nfscache.c	2005-10-13 11:00:13.000000000 +0200
@@ -93,8 +93,7 @@ nfsd_cache_shutdown(void)
 
 	cache_disabled = 1;
 
-	if (hash_list)
-		kfree (hash_list);
+	kfree (hash_list);
 	hash_list = NULL;
 }
 
--- linux-2.6.14-rc4-orig/fs/reiserfs/super.c	2005-10-11 22:41:25.000000000 +0200
+++ linux-2.6.14-rc4/fs/reiserfs/super.c	2005-10-13 11:02:14.000000000 +0200
@@ -1024,12 +1024,8 @@ static int reiserfs_parse_options(struct
 				strcpy(REISERFS_SB(s)->s_qf_names[qtype], arg);
 				*mount_options |= 1 << REISERFS_QUOTA;
 			} else {
-				if (REISERFS_SB(s)->s_qf_names[qtype]) {
-					kfree(REISERFS_SB(s)->
-					      s_qf_names[qtype]);
-					REISERFS_SB(s)->s_qf_names[qtype] =
-					    NULL;
-				}
+				kfree(REISERFS_SB(s)->s_qf_names[qtype]);
+				REISERFS_SB(s)->s_qf_names[qtype] = NULL;
 			}
 		}
 		if (c == 'f') {
@@ -1158,11 +1154,10 @@ static int reiserfs_remount(struct super
 	if (!reiserfs_parse_options
 	    (s, arg, &mount_options, &blocks, NULL, &commit_max_age)) {
 #ifdef CONFIG_QUOTA
-		for (i = 0; i < MAXQUOTAS; i++)
-			if (REISERFS_SB(s)->s_qf_names[i]) {
-				kfree(REISERFS_SB(s)->s_qf_names[i]);
-				REISERFS_SB(s)->s_qf_names[i] = NULL;
-			}
+		for (i = 0; i < MAXQUOTAS; i++) {
+			kfree(REISERFS_SB(s)->s_qf_names[i]);
+			REISERFS_SB(s)->s_qf_names[i] = NULL;
+		}
 #endif
 		return -EINVAL;
 	}
@@ -1939,14 +1934,10 @@ static int reiserfs_fill_super(struct su
 	if (SB_BUFFER_WITH_SB(s))
 		brelse(SB_BUFFER_WITH_SB(s));
 #ifdef CONFIG_QUOTA
-	for (j = 0; j < MAXQUOTAS; j++) {
-		if (sbi->s_qf_names[j])
-			kfree(sbi->s_qf_names[j]);
-	}
+	for (j = 0; j < MAXQUOTAS; j++)
+		kfree(sbi->s_qf_names[j]);
 #endif
-	if (sbi != NULL) {
-		kfree(sbi);
-	}
+	kfree(sbi);
 
 	s->s_fs_info = NULL;
 	return errval;
--- linux-2.6.14-rc4-orig/fs/reiserfs/xattr_acl.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/reiserfs/xattr_acl.c	2005-10-13 11:02:25.000000000 +0200
@@ -296,8 +296,7 @@ reiserfs_set_acl(struct inode *inode, in
 		}
 	}
 
-	if (value)
-		kfree(value);
+	kfree(value);
 
 	if (!error) {
 		/* Release the old one */
--- linux-2.6.14-rc4-orig/fs/devfs/base.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/devfs/base.c	2005-10-13 11:02:48.000000000 +0200
@@ -2738,10 +2738,8 @@ static int devfsd_close(struct inode *in
 	entry = fs_info->devfsd_first_event;
 	fs_info->devfsd_first_event = NULL;
 	fs_info->devfsd_last_event = NULL;
-	if (fs_info->devfsd_info) {
-		kfree(fs_info->devfsd_info);
-		fs_info->devfsd_info = NULL;
-	}
+	kfree(fs_info->devfsd_info);
+	fs_info->devfsd_info = NULL;
 	spin_unlock(&fs_info->devfsd_buffer_lock);
 	fs_info->devfsd_pgrp = 0;
 	fs_info->devfsd_task = NULL;
--- linux-2.6.14-rc4-orig/fs/jffs2/readinode.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/jffs2/readinode.c	2005-10-13 11:03:06.000000000 +0200
@@ -490,7 +490,7 @@ int jffs2_do_crccheck_inode(struct jffs2
 		up(&f->sem);
 		jffs2_do_clear_inode(c, f);
 	}
-	kfree (f);
+	kfree(f);
 	return ret;
 }
 
@@ -742,10 +742,8 @@ void jffs2_do_clear_inode(struct jffs2_s
 
 	/* For symlink inodes we us f->dents to store the target path name */
 	if (S_ISLNK(OFNI_EDONI_2SFFJ(f)->i_mode)) {
-		if (f->dents) {
-			kfree(f->dents);
-			f->dents = NULL;
-		}
+		kfree(f->dents);
+		f->dents = NULL;
 	} else {
 		fds = f->dents;
 
--- linux-2.6.14-rc4-orig/fs/jffs2/wbuf.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/jffs2/wbuf.c	2005-10-13 11:04:39.000000000 +0200
@@ -325,8 +325,7 @@ static void jffs2_wbuf_recover(struct jf
 		c->wbuf_ofs = ofs + towrite;
 		memmove(c->wbuf, rewrite_buf + towrite, c->wbuf_len);
 		/* Don't muck about with c->wbuf_inodes. False positives are harmless. */
-		if (buf)
-			kfree(buf);
+		kfree(buf);
 	} else {
 		/* OK, now we're left with the dregs in whichever buffer we're using */
 		if (buf) {
--- linux-2.6.14-rc4-orig/fs/isofs/inode.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/isofs/inode.c	2005-10-13 11:16:40.000000000 +0200
@@ -855,8 +855,7 @@ root_found:
 	if (opt.check == 'r') table++;
 	s->s_root->d_op = &isofs_dentry_ops[table];
 
-	if (opt.iocharset)
-		kfree(opt.iocharset);
+	kfree(opt.iocharset);
 
 	return 0;
 
@@ -895,8 +894,7 @@ out_unknown_format:
 out_freebh:
 	brelse(bh);
 out_freesbi:
-	if (opt.iocharset)
-		kfree(opt.iocharset);
+	kfree(opt.iocharset);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return -EINVAL;
@@ -1164,8 +1162,7 @@ out_nomem:
 
 out_noread:
 	printk(KERN_INFO "ISOFS: unable to read i-node block %lu\n", block);
-	if (tmpde)
-		kfree(tmpde);
+	kfree(tmpde);
 	return -EIO;
 
 out_toomany:
@@ -1334,8 +1331,7 @@ static void isofs_read_inode(struct inod
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
 
 out:
-	if (tmpde)
-		kfree(tmpde);
+	kfree(tmpde);
 	if (bh)
 		brelse(bh);
 	return;
--- linux-2.6.14-rc4-orig/fs/lockd/clntproc.c	2005-10-11 22:41:24.000000000 +0200
+++ linux-2.6.14-rc4/fs/lockd/clntproc.c	2005-10-13 11:17:00.000000000 +0200
@@ -112,8 +112,7 @@ static struct nlm_lockowner *nlm_find_lo
 		}
 	}
 	spin_unlock(&host->h_lock);
-	if (new != NULL)
-		kfree(new);
+	kfree(new);
 	return res;
 }
 
--- linux-2.6.14-rc4-orig/fs/binfmt_elf_fdpic.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/binfmt_elf_fdpic.c	2005-10-13 11:18:54.000000000 +0200
@@ -418,16 +418,11 @@ error:
 		allow_write_access(interpreter);
 		fput(interpreter);
 	}
-	if (interpreter_name)
-		kfree(interpreter_name);
-	if (exec_params.phdrs)
-		kfree(exec_params.phdrs);
-	if (exec_params.loadmap)
-		kfree(exec_params.loadmap);
-	if (interp_params.phdrs)
-		kfree(interp_params.phdrs);
-	if (interp_params.loadmap)
-		kfree(interp_params.loadmap);
+	kfree(interpreter_name);
+	kfree(exec_params.phdrs);
+	kfree(exec_params.loadmap);
+	kfree(interp_params.phdrs);
+	kfree(interp_params.loadmap);
 	return retval;
 
 	/* unrecoverable error - kill the process */
--- linux-2.6.14-rc4-orig/fs/compat_ioctl.c	2005-10-11 22:41:22.000000000 +0200
+++ linux-2.6.14-rc4/fs/compat_ioctl.c	2005-10-13 11:20:03.000000000 +0200
@@ -2235,7 +2235,8 @@ static int fd_ioctl_trans(unsigned int f
 	if (err)
 		err = -EFAULT;
 
-out:	if (karg) kfree(karg);
+out:
+	kfree(karg);
 	return err;
 }
 
--- linux-2.6.14-rc4-orig/fs/autofs/waitq.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/autofs/waitq.c	2005-10-13 11:20:24.000000000 +0200
@@ -150,10 +150,8 @@ int autofs_wait(struct autofs_sb_info *s
 	if ( sbi->catatonic ) {
 		/* We might have slept, so check again for catatonic mode */
 		wq->status = -ENOENT;
-		if ( wq->name ) {
-			kfree(wq->name);
-			wq->name = NULL;
-		}
+		kfree(wq->name);
+		wq->name = NULL;
 	}
 
 	if ( wq->name ) {
--- linux-2.6.14-rc4-orig/fs/mbcache.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/mbcache.c	2005-10-13 11:20:41.000000000 +0200
@@ -301,8 +301,7 @@ fail:
 	if (cache) {
 		while (--m >= 0)
 			kfree(cache->c_indexes_hash[m]);
-		if (cache->c_block_hash)
-			kfree(cache->c_block_hash);
+		kfree(cache->c_block_hash);
 		kfree(cache);
 	}
 	return NULL;
--- linux-2.6.14-rc4-orig/fs/hostfs/hostfs_kern.c	2005-10-11 22:41:23.000000000 +0200
+++ linux-2.6.14-rc4/fs/hostfs/hostfs_kern.c	2005-10-13 11:21:44.000000000 +0200
@@ -294,8 +294,7 @@ static void hostfs_delete_inode(struct i
 
 static void hostfs_destroy_inode(struct inode *inode)
 {
-	if(HOSTFS_I(inode)->host_filename)
-		kfree(HOSTFS_I(inode)->host_filename);
+	kfree(HOSTFS_I(inode)->host_filename);
 
 	/*XXX: This should not happen, probably. The check is here for
 	 * additional safety.*/
--- linux-2.6.14-rc4-orig/fs/binfmt_elf.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/binfmt_elf.c	2005-10-13 11:22:08.000000000 +0200
@@ -1007,8 +1007,7 @@ out_free_dentry:
 	if (interpreter)
 		fput(interpreter);
 out_free_interp:
-	if (elf_interpreter)
-		kfree(elf_interpreter);
+	kfree(elf_interpreter);
 out_free_file:
 	sys_close(elf_exec_fileno);
 out_free_fh:
--- linux-2.6.14-rc4-orig/fs/autofs4/waitq.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/autofs4/waitq.c	2005-10-13 11:22:31.000000000 +0200
@@ -243,10 +243,8 @@ int autofs4_wait(struct autofs_sb_info *
 	if ( sbi->catatonic ) {
 		/* We might have slept, so check again for catatonic mode */
 		wq->status = -ENOENT;
-		if ( wq->name ) {
-			kfree(wq->name);
-			wq->name = NULL;
-		}
+		kfree(wq->name);
+		wq->name = NULL;
 	}
 
 	if ( wq->name ) {
--- linux-2.6.14-rc4-orig/fs/autofs4/inode.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/autofs4/inode.c	2005-10-13 11:22:58.000000000 +0200
@@ -22,10 +22,8 @@
 
 static void ino_lnkfree(struct autofs_info *ino)
 {
-	if (ino->u.symlink) {
-		kfree(ino->u.symlink);
-		ino->u.symlink = NULL;
-	}
+	kfree(ino->u.symlink);
+	ino->u.symlink = NULL;
 }
 
 struct autofs_info *autofs4_init_ino(struct autofs_info *ino,
--- linux-2.6.14-rc4-orig/fs/xattr.c	2005-10-11 22:41:25.000000000 +0200
+++ linux-2.6.14-rc4/fs/xattr.c	2005-10-13 11:23:17.000000000 +0200
@@ -74,8 +74,7 @@ setxattr(struct dentry *d, char __user *
 	}
 out:
 	up(&d->d_inode->i_sem);
-	if (kvalue)
-		kfree(kvalue);
+	kfree(kvalue);
 	return error;
 }
 
@@ -169,8 +168,7 @@ getxattr(struct dentry *d, char __user *
 		error = -E2BIG;
 	}
 out:
-	if (kvalue)
-		kfree(kvalue);
+	kfree(kvalue);
 	return error;
 }
 
@@ -255,8 +253,7 @@ listxattr(struct dentry *d, char __user 
 		error = -E2BIG;
 	}
 out:
-	if (klist)
-		kfree(klist);
+	kfree(klist);
 	return error;
 }
 
--- linux-2.6.14-rc4-orig/fs/openpromfs/inode.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/openpromfs/inode.c	2005-10-13 11:23:42.000000000 +0200
@@ -1088,8 +1088,7 @@ static void __exit exit_openprom_fs(void
 	unregister_filesystem(&openprom_fs_type);
 	free_pages ((unsigned long)nodes, alloced);
 	for (i = 0; i < aliases_nodes; i++)
-		if (alias_names [i])
-			kfree (alias_names [i]);
+		kfree (alias_names [i]);
 	nodes = NULL;
 }
 
