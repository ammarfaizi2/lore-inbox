Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVBCRbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVBCRbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbVBCRax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:30:53 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:43730 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262674AbVBCRaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:30:13 -0500
Date: Thu, 3 Feb 2005 18:30:04 +0100
From: Luca <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Steve Frenchs <french@samba.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6] Check return of copy_from_user value in cifssmb.c
Message-ID: <20050203173004.GB24747@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
the following patch against 2.6.11-rc3 fixes this compile time warning:

fs/cifs/cifssmb.c: In function `CIFSSMBWrite':
fs/cifs/cifssmb.c:902: warning: ignoring return value of
`copy_from_user', declared with attribute warn_unused_result

It also fixes the strange indentation of the code in that point. Also
note that pSMB cannot be NULL, since the return value of smb_init (which
initiliaze pSMB) is checked (see line 874).

Signed-off-by: Luca Tettamanti <kronoz@kronoz.cjb.net>

--- a/fs/cifs/cifssmb.c	2005-02-03 17:43:18.000000000 +0100
+++ b/fs/cifs/cifssmb.c	2005-02-03 17:47:29.000000000 +0100
@@ -896,14 +896,17 @@
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
+
+	if(buf)
+		memcpy(pSMB->Data, buf, bytes_sent);
+	else if(ubuf) {
+		if (copy_from_user(pSMB->Data, ubuf, bytes_sent)) {
 			cifs_buf_release(pSMB);
+			return -EFAULT;
+		}
+	} else {
+		/* No buffer */
+		cifs_buf_release(pSMB);
 		return -EINVAL;
 	}
 

Luca
-- 
Home: http://kronoz.cjb.net
Un apostolo vedendo Gesu` camminare sulle acque:
- Cazzo se e` buono 'sto fumo!!!
