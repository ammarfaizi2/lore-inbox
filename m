Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbRFRTIj>; Mon, 18 Jun 2001 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbRFRTIU>; Mon, 18 Jun 2001 15:08:20 -0400
Received: from fungus.teststation.com ([212.32.186.211]:43013 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S262610AbRFRTIB>; Mon, 18 Jun 2001 15:08:01 -0400
Date: Mon, 18 Jun 2001 21:07:42 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [patch] smbfs-2.4.6-pre3 - win95 flush & NetApp lastname
Message-ID: <Pine.LNX.4.30.0106182058330.1765-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hej

A less painful workaround than what I added during 2.4.5-pre for the
win9x-lies-about-filesizes-on-open-files problem. Replaces constant
flush'es with seek to end, and only when necessary.

Also, a fix where smbfs doesn't follow protocol and fails to return
'lastname' for all "infolevels", which breaks with NetApps.

Patch vs -pre1, but is fine vs -pre3. Please apply.

/Urban


diff -urN -X exclude linux-2.4.6-pre1-orig/fs/smbfs/ChangeLog linux-2.4.6-pre1-smbfs/fs/smbfs/ChangeLog
--- linux-2.4.6-pre1-orig/fs/smbfs/ChangeLog	Wed May 30 21:57:15 2001
+++ linux-2.4.6-pre1-smbfs/fs/smbfs/ChangeLog	Tue Jun 12 20:34:32 2001
@@ -1,5 +1,10 @@
 ChangeLog for smbfs.
 
+2001-06-12 Urban Widmark <urban@teststation.com>
+
+	* proc.c: replace the win95-flush fix with smb_seek, when needed.
+	* proc.c: readdir 'lastname' bug (NetApp dir listing fix)
+
 2001-05-08 Urban Widmark <urban@teststation.com>
 
 	* inode.c: Fix for changes on the server side not being detected
diff -urN -X exclude linux-2.4.6-pre1-orig/fs/smbfs/file.c linux-2.4.6-pre1-smbfs/fs/smbfs/file.c
--- linux-2.4.6-pre1-orig/fs/smbfs/file.c	Wed May 30 21:57:15 2001
+++ linux-2.4.6-pre1-smbfs/fs/smbfs/file.c	Wed Jun  6 23:00:02 2001
@@ -151,6 +151,7 @@
 		 * Update the inode now rather than waiting for a refresh.
 		 */
 		inode->i_mtime = inode->i_atime = CURRENT_TIME;
+		inode->u.smbfs_i.flags |= SMB_F_LOCALWRITE;
 		if (offset > inode->i_size)
 			inode->i_size = offset;
 	} while (count);
diff -urN -X exclude linux-2.4.6-pre1-orig/fs/smbfs/inode.c linux-2.4.6-pre1-smbfs/fs/smbfs/inode.c
--- linux-2.4.6-pre1-orig/fs/smbfs/inode.c	Wed May 30 21:57:15 2001
+++ linux-2.4.6-pre1-smbfs/fs/smbfs/inode.c	Wed Jun  6 23:00:02 2001
@@ -141,8 +141,8 @@
 	inode->u.smbfs_i.oldmtime = jiffies;
 
 	if (inode->i_mtime != last_time || inode->i_size != last_sz) {
-		VERBOSE("%s/%s changed, old=%ld, new=%ld, oz=%ld, nz=%ld\n",
-			DENTRY_PATH(dentry),
+		VERBOSE("%ld changed, old=%ld, new=%ld, oz=%ld, nz=%ld\n",
+			inode->i_ino,
 			(long) last_time, (long) inode->i_mtime,
 			(long) last_sz, (long) inode->i_size);
 
diff -urN -X exclude linux-2.4.6-pre1-orig/fs/smbfs/proc.c linux-2.4.6-pre1-smbfs/fs/smbfs/proc.c
--- linux-2.4.6-pre1-orig/fs/smbfs/proc.c	Wed May 30 21:57:15 2001
+++ linux-2.4.6-pre1-smbfs/fs/smbfs/proc.c	Thu Jun  7 21:20:59 2001
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
@@ -1210,11 +1235,6 @@
 	if (result >= 0)
 		result = WVAL(server->packet, smb_vwv0);
 
-	/* flush to disk, to trigger win9x to update its filesize */
-	/* FIXME: this will be rather costly, won't it? */
-	if (server->mnt->flags & SMB_MOUNT_WIN95)
-		smb_proc_flush(server, fileid);
-
 	smb_unlock_server(server);
 	return result;
 }
@@ -1858,6 +1878,7 @@
 		result = mask_len;
 		goto unlock_return;
 	}
+	mask_len--;	/* mask_len is strlen, not #bytes */
 	first = 1;
 	VERBOSE("starting mask_len=%d, mask=%s\n", mask_len, mask);
 
@@ -1946,18 +1967,28 @@
 		 * Note that some servers (win95?) point to the filename and
 		 * others (NT4, Samba using NT1) to the dir entry. We assume
 		 * here that those who do not point to a filename do not need
-		 * this info to continue the listing. OS/2 needs this, but it
-		 * talks "infolevel 1"
+		 * this info to continue the listing.
+		 *
+		 * OS/2 needs this and talks infolevel 1
+		 * NetApps want lastname with infolevel 260
+		 *
+		 * Both are happy if we return the data they point to. So we do.
 		 */
 		mask_len = 0;
-		if (info_level == 1 && ff_lastname > 0 &&
-		    ff_lastname < resp_data_len) {
+		if (ff_lastname > 0 && ff_lastname < resp_data_len) {
 			lastname = resp_data + ff_lastname;
 
-			/* lastname points to a length byte */
-			mask_len = *lastname++;
-			if (ff_lastname + 1 + mask_len > resp_data_len)
-				mask_len = resp_data_len-ff_lastname-1;
+			switch (info_level) {
+			case 260:
+				mask_len = resp_data_len - ff_lastname;
+				break;
+			case 1:
+				/* lastname points to a length byte */
+				mask_len = *lastname++;
+				if (ff_lastname + 1 + mask_len > resp_data_len)
+					mask_len = resp_data_len - ff_lastname - 1;
+				break;
+			}
 
 			/*
 			 * Update the mask string for the next message.
@@ -2062,7 +2093,7 @@
 	DSET(param, 8, 0);
 
 	result = smb_trans2_request(server, TRANSACT2_FINDFIRST,
-				    0, NULL, 12 + mask_len + 1, param,
+				    0, NULL, 12 + mask_len, param,
 				    &resp_data_len, &resp_data,
 				    &resp_param_len, &resp_param);
 	if (result < 0)
@@ -2246,6 +2277,7 @@
 		    struct smb_fattr *fattr)
 {
 	int result;
+	struct inode *inode = dir->d_inode;
 
 	smb_init_dirent(server, fattr);
 
@@ -2261,6 +2293,21 @@
 			result = smb_proc_getattr_ff(server, dir, fattr);
 		else
 			result = smb_proc_getattr_trans2(server, dir, fattr);
+	}
+
+	/*
+	 * None of the getattr versions here can make win9x return the right
+	 * filesize if there are changes made to an open file.
+	 * A seek-to-end does return the right size, but we only need to do
+	 * that on files we have written.
+	 */
+	if (server->mnt->flags & SMB_MOUNT_WIN95 &&
+	    inode &&
+	    inode->u.smbfs_i.flags & SMB_F_LOCALWRITE &&
+	    smb_is_open(inode))
+	{
+		__u16 fileid = inode->u.smbfs_i.fileid;
+		fattr->f_size = smb_proc_seek(server, fileid, 2, 0);
 	}
 
 	smb_finish_dirent(server, fattr);
diff -urN -X exclude linux-2.4.6-pre1-orig/include/linux/smb_fs.h linux-2.4.6-pre1-smbfs/include/linux/smb_fs.h
--- linux-2.4.6-pre1-orig/include/linux/smb_fs.h	Wed Jun  6 22:47:48 2001
+++ linux-2.4.6-pre1-smbfs/include/linux/smb_fs.h	Wed Jun  6 23:10:20 2001
@@ -93,6 +93,11 @@
 
 #endif /* DEBUG_SMB_MALLOC */
 
+/*
+ * Flags for the in-memory inode
+ */
+#define SMB_F_LOCALWRITE	0x02	/* file modified locally */
+
 
 /* NT1 protocol capability bits */
 #define SMB_CAP_RAW_MODE         0x0001
diff -urN -X exclude linux-2.4.6-pre1-orig/include/linux/smb_fs_i.h linux-2.4.6-pre1-smbfs/include/linux/smb_fs_i.h
--- linux-2.4.6-pre1-orig/include/linux/smb_fs_i.h	Wed Jun  6 22:38:15 2001
+++ linux-2.4.6-pre1-smbfs/include/linux/smb_fs_i.h	Wed Jun  6 23:00:02 2001
@@ -26,6 +26,7 @@
 	__u16 attr;		/* Attribute fields, DOS value */
 
 	__u16 access;		/* Access mode */
+	__u16 flags;
 	unsigned long oldmtime;	/* last time refreshed */
 	unsigned long closed;	/* timestamp when closed */
 	unsigned openers;	/* number of fileid users */

