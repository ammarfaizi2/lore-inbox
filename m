Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbULZXNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbULZXNi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 18:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbULZXNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 18:13:38 -0500
Received: from mail.dif.dk ([193.138.115.101]:46494 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261254AbULZXNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 18:13:20 -0500
Date: Mon, 27 Dec 2004 00:24:16 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>
Cc: samba-technical <samba-technical@lists.samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] copy_to_user check and whitespace cleanups in fs/cifs/file.c
Message-ID: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Patch below adds a check for the copy_to_user return value and makes a few 
whitespace cleanups in  fs/cifs/file.c::cifs_user_read()
I hope bundling two different things together in one patch is OK when the 
change is as small as this, but if you want it spplit in two patches, then 
just say so.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-orig/fs/cifs/file.c linux-2.6.10/fs/cifs/file.c
--- linux-2.6.10-orig/fs/cifs/file.c	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.10/fs/cifs/file.c	2004-12-27 00:18:35.000000000 +0100
@@ -1141,20 +1141,21 @@ cifs_user_read(struct file * file, char 
 	}
 	open_file = (struct cifsFileInfo *)file->private_data;
 
-	if((file->f_flags & O_ACCMODE) == O_WRONLY) {
-		cFYI(1,("attempting read on write only file instance"));
+	if ((file->f_flags & O_ACCMODE) == O_WRONLY) {
+		cFYI(1, ("attempting read on write only file instance"));
 	}
 
-	for (total_read = 0,current_offset=read_data; read_size > total_read;
-				total_read += bytes_read,current_offset+=bytes_read) {
-		current_read_size = min_t(const int,read_size - total_read,cifs_sb->rsize);
+	for (total_read = 0, current_offset = read_data; read_size > total_read;
+			total_read += bytes_read, current_offset += bytes_read) {
+		current_read_size = min_t(const int, read_size - total_read, 
+			cifs_sb->rsize);
 		rc = -EAGAIN;
 		smb_read_data = NULL;
-		while(rc == -EAGAIN) {
+		while (rc == -EAGAIN) {
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file,TRUE);
-				if(rc != 0)
+				if (rc != 0)
 					break;
 			}
 
@@ -1164,9 +1165,13 @@ cifs_user_read(struct file * file, char 
 				 &bytes_read, &smb_read_data);
 
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
-				+ le16_to_cpu(pSMBr->DataOffset), bytes_read);
-			if(smb_read_data) {
+			if (copy_to_user(current_offset,smb_read_data + 4 /* RFC1001 hdr*/
+					+ le16_to_cpu(pSMBr->DataOffset), bytes_read)) {
+				FreeXid(xid);
+				return -EFAULT;
+			}
+				
+			if (smb_read_data) {
 				cifs_buf_release(smb_read_data);
 				smb_read_data = NULL;
 			}




Please keep me on CC.

