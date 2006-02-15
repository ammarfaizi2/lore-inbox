Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030627AbWBODfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbWBODfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030626AbWBODfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:35:16 -0500
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:35528 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1030627AbWBODfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:35:14 -0500
Message-ID: <43F2AE7C.7080601@austin.rr.com>
Date: Tue, 14 Feb 2006 22:30:52 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: [PATCH] [CIFS] fix cifs_user_read oops when null SMB response on
 forcedirectio mount
Content-Type: multipart/mixed;
 boundary="------------010203020808020205020207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010203020808020205020207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes an oops reported by Adrian Bunk in cifs_user_read when a null 
read response is returned on a forcedirectio mount.  

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Signed-off-by: Steve French <sfrench@us.ibm.com>

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d17c97d..675bd25 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1442,13 +1442,15 @@ ssize_t cifs_user_read(struct file *file
 					 &bytes_read, &smb_read_data,
 					 &buf_type);
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			if (copy_to_user(current_offset, 
-					 smb_read_data + 4 /* RFC1001 hdr */
-					 + le16_to_cpu(pSMBr->DataOffset), 
-					 bytes_read)) {
-				rc = -EFAULT;
-			}
 			if (smb_read_data) {
+				if (copy_to_user(current_offset,
+						smb_read_data +
+						4 /* RFC1001 length field */ +
+						le16_to_cpu(pSMBr->DataOffset),
+						bytes_read)) {
+					rc = -EFAULT;
+				}
+
 				if(buf_type == CIFS_SMALL_BUFFER)
 					cifs_small_buf_release(smb_read_data);
 				else if(buf_type == CIFS_LARGE_BUFFER)



--------------010203020808020205020207
Content-Type: text/x-patch;
 name="cifs-user-read-oops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cifs-user-read-oops.patch"

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d17c97d..675bd25 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1442,13 +1442,15 @@ ssize_t cifs_user_read(struct file *file
 					 &bytes_read, &smb_read_data,
 					 &buf_type);
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			if (copy_to_user(current_offset, 
-					 smb_read_data + 4 /* RFC1001 hdr */
-					 + le16_to_cpu(pSMBr->DataOffset), 
-					 bytes_read)) {
-				rc = -EFAULT;
-			}
 			if (smb_read_data) {
+				if (copy_to_user(current_offset,
+						smb_read_data +
+						4 /* RFC1001 length field */ +
+						le16_to_cpu(pSMBr->DataOffset),
+						bytes_read)) {
+					rc = -EFAULT;
+				}
+
 				if(buf_type == CIFS_SMALL_BUFFER)
 					cifs_small_buf_release(smb_read_data);
 				else if(buf_type == CIFS_LARGE_BUFFER)

--------------010203020808020205020207--
