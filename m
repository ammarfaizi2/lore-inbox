Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVCDQji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVCDQji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbVCDQji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:39:38 -0500
Received: from mail.dif.dk ([193.138.115.101]:10389 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262936AbVCDQjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:39:00 -0500
Date: Fri, 4 Mar 2005 17:39:51 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <sfrench@us.ibm.com>
Cc: samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luca Tettamanti <kronoz@kronoz.cjb.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: [PATCH][resend] copy_to_user return value check in fs/cifs/file.c
Message-ID: <Pine.LNX.4.62.0503041729310.2794@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

Back around the time of 2.6.10 I submitted a patch to fix the compile 
warning about copy_to_user in fs/cifs/file.c. The patch generated some 
comments and suggestions from several people and I subsequently cut a new 
patch that took care of the issues raised. Allan Cox then Ack'ed that new 
patch and then discussion died out. Aparently the patch never made it into 
2.6.11, so I've re-diffed it against that and hereby submit it to you for 
inclusion once more.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-orig/fs/cifs/file.c	2005-03-02 08:38:34.000000000 +0100
+++ linux-2.6.11/fs/cifs/file.c	2005-03-04 16:38:36.000000000 +0100
@@ -1148,6 +1148,7 @@ cifs_user_read(struct file * file, char 
 
 	for (total_read = 0,current_offset=read_data; read_size > total_read;
 				total_read += bytes_read,current_offset+=bytes_read) {
+		unsigned residue;
 		current_read_size = min_t(const int,read_size - total_read,cifs_sb->rsize);
 		rc = -EAGAIN;
 		smb_read_data = NULL;
@@ -1165,12 +1166,17 @@ cifs_user_read(struct file * file, char 
 				 &bytes_read, &smb_read_data);
 
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
+			residue = copy_to_user(current_offset, smb_read_data + 4 /* RFC1001 hdr */
 				+ le16_to_cpu(pSMBr->DataOffset), bytes_read);
 			if(smb_read_data) {
 				cifs_buf_release(smb_read_data);
 				smb_read_data = NULL;
 			}
+			if (residue) {
+				total_read += bytes_read - residue;
+				rc = -EFAULT;
+				break;
+			}
 		}
 		if (rc || (bytes_read == 0)) {
 			if (total_read) {


