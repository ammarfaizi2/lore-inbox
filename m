Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262873AbREVW0a>; Tue, 22 May 2001 18:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbREVW0U>; Tue, 22 May 2001 18:26:20 -0400
Received: from fungus.teststation.com ([212.32.186.211]:54998 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S262871AbREVW0J>; Tue, 22 May 2001 18:26:09 -0400
Date: Wed, 23 May 2001 00:25:45 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Xuan Baldauf <xuan--lkml@baldauf.org>
cc: <linux-kernel@vger.kernel.org>, "James H. Puttick" <james.puttick@kvs.com>
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
In-Reply-To: <3B08F54D.F1C75D14@baldauf.org>
Message-ID: <Pine.LNX.4.30.0105230009160.23340-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Xuan Baldauf wrote:

> That is annoying, because it heavily slows down bulk transfers of small
> writes, like automatically unzipping a new mozilla build from the linux box to
> the windows box. Every write of say 100 bytes is implemented as
> 
> send write req
> recv write ack
> send flush req
> sync to disk (on the windows machine)
> recv flush ack

The only other way I have found so far to get it to return the right file
size is to do a "seek-to-end". That still means an extra SMB but it avoids
the very painful "sync to disk".

Fortunately the seek is only necessary when refreshing inode info, on a
"win95" server, on a file that is open and that we have written to.

This should be significantly better, but still works with my testcases.
patch vs 2.4.5-pre4, please test.

/Urban


diff -urN -X exclude linux-2.4.5-pre4-orig/fs/smbfs/Makefile linux-2.4.5-pre4-smbfs/fs/smbfs/Makefile
--- linux-2.4.5-pre4-orig/fs/smbfs/Makefile	Thu Feb 22 20:52:03 2001
+++ linux-2.4.5-pre4-smbfs/fs/smbfs/Makefile	Wed May 23 00:19:08 2001
@@ -16,6 +16,7 @@
 # SMBFS_PARANOIA should normally be enabled.
 
 EXTRA_CFLAGS += -DSMBFS_PARANOIA
+EXTRA_CFLAGS += -DSMB_WIN95_LOCALWRITE_FIX
 #EXTRA_CFLAGS += -DSMBFS_DEBUG
 #EXTRA_CFLAGS += -DSMBFS_DEBUG_VERBOSE
 #EXTRA_CFLAGS += -DDEBUG_SMB_MALLOC
diff -urN -X exclude linux-2.4.5-pre4-orig/fs/smbfs/file.c linux-2.4.5-pre4-smbfs/fs/smbfs/file.c
--- linux-2.4.5-pre4-orig/fs/smbfs/file.c	Sun May 20 15:20:17 2001
+++ linux-2.4.5-pre4-smbfs/fs/smbfs/file.c	Tue May 22 23:53:43 2001
@@ -151,6 +151,7 @@
 		 * Update the inode now rather than waiting for a refresh.
 		 */
 		inode->i_mtime = inode->i_atime = CURRENT_TIME;
+		inode->u.smbfs_i.flags |= SMB_F_LOCALWRITE;
 		if (offset > inode->i_size)
 			inode->i_size = offset;
 	} while (count);
diff -urN -X exclude linux-2.4.5-pre4-orig/fs/smbfs/inode.c linux-2.4.5-pre4-smbfs/fs/smbfs/inode.c
--- linux-2.4.5-pre4-orig/fs/smbfs/inode.c	Sun May 20 15:20:17 2001
+++ linux-2.4.5-pre4-smbfs/fs/smbfs/inode.c	Tue May 22 21:02:29 2001
@@ -141,8 +141,8 @@
 	inode->u.smbfs_i.oldmtime = jiffies;
 
 	if (inode->i_mtime != last_time || inode->i_size != last_sz) {
-		VERBOSE("%s/%s changed, old=%ld, new=%ld, oz=%ld, nz=%ld\n",
-			DENTRY_PATH(dentry),
+		VERBOSE("%ld changed, old=%ld, new=%ld, oz=%ld, nz=%ld\n",
+			inode->i_ino,
 			(long) last_time, (long) inode->i_mtime,
 			(long) last_sz, (long) inode->i_size);
 
diff -urN -X exclude linux-2.4.5-pre4-orig/fs/smbfs/proc.c linux-2.4.5-pre4-smbfs/fs/smbfs/proc.c
--- linux-2.4.5-pre4-orig/fs/smbfs/proc.c	Sun May 20 15:20:17 2001
+++ linux-2.4.5-pre4-smbfs/fs/smbfs/proc.c	Wed May 23 00:19:19 2001
@@ -919,6 +919,31 @@
 }
 
 /*
+ * Called with the server locked
+ */
+static int
+smb_proc_seek(struct smb_sb_info *server, __u16 fileid,
+	      __u16 mode, off_t offset)
+{
+	int result;
+
+	smb_setup_header(server, SMBlseek, 4, 0);
+	WSET(server->packet, smb_vwv0, fileid);
+	WSET(server->packet, smb_vwv1, mode);
+	DSET(server->packet, smb_vwv2, offset);
+
+	result = smb_request_ok(server, SMBlseek, 2, 0);
+	if (result < 0) {
+		result = 0;
+		goto out;
+	}
+
+	result = DVAL(server->packet, smb_vwv0);
+out:
+	return result;
+}
+
+/*
  * We're called with the server locked, and we leave it that way.
  */
 static int
@@ -1210,10 +1235,12 @@
 	if (result >= 0)
 		result = WVAL(server->packet, smb_vwv0);
 
+#ifndef SMB_WIN95_LOCALWRITE_FIX
 	/* flush to disk, to trigger win9x to update its filesize */
 	/* FIXME: this will be rather costly, won't it? */
 	if (server->mnt->flags & SMB_MOUNT_WIN95)
 		smb_proc_flush(server, fileid);
+#endif
 
 	smb_unlock_server(server);
 	return result;
@@ -2246,6 +2273,7 @@
 		    struct smb_fattr *fattr)
 {
 	int result;
+	struct inode *inode = dir->d_inode;
 
 	smb_init_dirent(server, fattr);
 
@@ -2262,6 +2290,22 @@
 		else
 			result = smb_proc_getattr_trans2(server, dir, fattr);
 	}
+
+#ifdef SMB_WIN95_LOCALWRITE_FIX
+	/*
+	 * None of the getattr versions here can make win95 return the right
+	 * filesize if there are changes made to it. A seek-to-end does return
+	 * the right size, but we only need to do that on files we have written.
+	 */
+	if (server->mnt->flags & SMB_MOUNT_WIN95 &&
+	    inode &&
+	    inode->u.smbfs_i.flags & SMB_F_LOCALWRITE &&
+	    smb_is_open(inode))
+	{
+		__u16 fileid = inode->u.smbfs_i.fileid;
+		fattr->f_size = smb_proc_seek(server, fileid, 2, 0);
+	}
+#endif
 
 	smb_finish_dirent(server, fattr);
 	return result;
diff -urN -X exclude linux-2.4.5-pre4-orig/include/linux/smb_fs.h linux-2.4.5-pre4-smbfs/include/linux/smb_fs.h
--- linux-2.4.5-pre4-orig/include/linux/smb_fs.h	Sun May 20 15:37:59 2001
+++ linux-2.4.5-pre4-smbfs/include/linux/smb_fs.h	Tue May 22 21:47:05 2001
@@ -93,6 +93,11 @@
 
 #endif /* DEBUG_SMB_MALLOC */
 
+/*
+ * Flags for the in-memory inode
+ */
+#define SMB_F_LOCALWRITE	0x02	/* file modified locally */
+
 
 /* NT1 protocol capability bits */
 #define SMB_CAP_RAW_MODE         0x0001
diff -urN -X exclude linux-2.4.5-pre4-orig/include/linux/smb_fs_i.h linux-2.4.5-pre4-smbfs/include/linux/smb_fs_i.h
--- linux-2.4.5-pre4-orig/include/linux/smb_fs_i.h	Sun May 20 15:23:22 2001
+++ linux-2.4.5-pre4-smbfs/include/linux/smb_fs_i.h	Tue May 22 20:58:03 2001
@@ -26,6 +26,7 @@
 	__u16 attr;		/* Attribute fields, DOS value */
 
 	__u16 access;		/* Access mode */
+	__u16 flags;
 	unsigned long oldmtime;	/* last time refreshed */
 	unsigned long closed;	/* timestamp when closed */
 	unsigned openers;	/* number of fileid users */

