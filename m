Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVBMPo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVBMPo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 10:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVBMPo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 10:44:58 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:62856 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261280AbVBMPoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 10:44:55 -0500
Date: Sun, 13 Feb 2005 16:44:16 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Steve Frenchs <french@samba.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6] Check return value of copy_to_user in fs/cifs/file.c [Re: Linux 2.6.11-rc4]
Message-ID: <20050213154416.GA26396@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> ha scritto:
> this is hopefully the last -rc kernel before the real 2.6.11, so please 
> give it a whirl, and complain loudly about anything broken.

The following patch against 2.6.11-rc4 fixes this compile time warning:

 CC [M]  fs/cifs/file.o
fs/cifs/file.c: In function `cifs_user_read':
fs/cifs/file.c:1168: warning: ignoring return value of
`copy_to_user', declared with attribute warn_unused_result

I also added an explicit check for errors other than -EAGAIN, since
CIFSSMBRead may return -ENOMEM if it's unable to allocate smb_com_read_rsp;
in that case we don't want to call copy_to_user with a NULL pointer.

Signed-off-by: Luca Tettamanti <kronoz@kronoz.cjb.net>

--- a/fs/cifs/file.c	2005-02-03 17:58:07.000000000 +0100
+++ b/fs/cifs/file.c	2005-02-03 18:17:37.000000000 +0100
@@ -1151,7 +1151,7 @@
 		current_read_size = min_t(const int,read_size - total_read,cifs_sb->rsize);
 		rc = -EAGAIN;
 		smb_read_data = NULL;
-		while(rc == -EAGAIN) {
+		while(1) {
 			if ((open_file->invalidHandle) && (!open_file->closePend)) {
 				rc = cifs_reopen_file(file->f_dentry->d_inode,
 					file,TRUE);
@@ -1164,13 +1164,22 @@
 				 current_read_size, *poffset,
 				 &bytes_read, &smb_read_data);
 
+			if (rc == -EAGAIN)
+				continue;
+			else
+				break;
+
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
+			rc = copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
 				+ le16_to_cpu(pSMBr->DataOffset), bytes_read);
 			if(smb_read_data) {
 				cifs_buf_release(smb_read_data);
 				smb_read_data = NULL;
 			}
+			if (rc) {
+				FreeXid(xid);
+				return -EFAULT;
+			}
 		}
 		if (rc || (bytes_read == 0)) {
 			if (total_read) {



Luca
-- 
Home: http://kronoz.cjb.net
Se non sei parte della soluzione, allora sei parte del problema.
