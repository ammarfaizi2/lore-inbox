Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVAON0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVAON0b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 08:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVAON0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 08:26:30 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:50855 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262276AbVAONZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 08:25:52 -0500
Subject: [PATCH 1/6] cifs: copy_to_user and copy_from_user fixes
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: sfrench@samba.org
Cc: linux-kernel@vger.kernel.org
Date: Sat, 15 Jan 2005 15:25:46 +0200
Message-Id: <1105795546.9555.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check return value for copy_to_user() and copy_from_user().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 cifssmb.c |   37 ++++++++++++++++++++++---------------
 file.c    |    6 +++++-
 2 files changed, 27 insertions(+), 16 deletions(-)

Index: linux/fs/cifs/cifssmb.c
===================================================================
--- linux.orig/fs/cifs/cifssmb.c	2005-01-12 19:43:26.012611064 +0200
+++ linux/fs/cifs/cifssmb.c	2005-01-12 20:03:29.307682408 +0200
@@ -886,25 +886,29 @@
 	pSMB->Reserved = 0xFFFFFFFF;
 	pSMB->WriteMode = 0;
 	pSMB->Remaining = 0;
-	/* BB can relax this if buffer is big enough in some cases - ie we can 
-	send more  if LARGE_WRITE_X capability returned by the server and if
-	our buffer is big enough or if we convert to iovecs on socket writes
-	and eliminate the copy to the CIFS buffer */
+	/*
+	 * BB can relax this if buffer is big enough in some cases - ie we can 
+	 * send more  if LARGE_WRITE_X capability returned by the server and if
+	 * our buffer is big enough or if we convert to iovecs on socket writes
+	 * and eliminate the copy to the CIFS buffer
+	 */
 	bytes_sent = (tcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE) & ~0xFF;
 	if (bytes_sent > count)
 		bytes_sent = count;
 	pSMB->DataLengthHigh = 0;
 	pSMB->DataOffset =
 	    cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
-    if(buf)
-	    memcpy(pSMB->Data,buf,bytes_sent);
-	else if(ubuf)
-		copy_from_user(pSMB->Data,ubuf,bytes_sent);
-    else {
-		/* No buffer */
-		if(pSMB)
-			cifs_buf_release(pSMB);
-		return -EINVAL;
+
+	if (buf)
+		memcpy(pSMB->Data, buf, bytes_sent);
+	else if (ubuf) {
+		if (copy_from_user(pSMB->Data, ubuf, bytes_sent)) {
+			rc = -EFAULT;
+			goto out_release;
+		}
+	} else {
+		rc = -EINVAL;
+		goto out_release;
 	}
 
 	byte_count = bytes_sent + 1 /* pad */ ;
@@ -921,11 +925,14 @@
 	} else
 		*nbytes = le16_to_cpu(pSMBr->Count);
 
+ out_release:
 	if (pSMB)
 		cifs_buf_release(pSMB);
 
-	/* Note: On -EAGAIN error only caller can retry on handle based calls 
-		since file handle passed in no longer valid */
+	/*
+	 * Note: On -EAGAIN error only caller can retry on handle based calls
+	 * since file handle passed in no longer valid
+	 */
 
 	return rc;
 }
Index: linux/fs/cifs/file.c
===================================================================
--- linux.orig/fs/cifs/file.c	2005-01-12 19:43:26.018610152 +0200
+++ linux/fs/cifs/file.c	2005-01-12 20:02:29.110833720 +0200
@@ -1165,8 +1165,12 @@
 				 &bytes_read, &smb_read_data);
 
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			copy_to_user(current_offset,smb_read_data + 4/* RFC1001 hdr*/
+			rc = copy_to_user(current_offset, smb_read_data + 4 /* RFC1001 hdr */
 				+ le16_to_cpu(pSMBr->DataOffset), bytes_read);
+			if (rc) {
+				FreeXid(xid);
+				return -EFAULT;
+			}
 			if(smb_read_data) {
 				cifs_buf_release(smb_read_data);
 				smb_read_data = NULL;


