Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVBMPp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVBMPp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 10:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVBMPp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 10:45:29 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:14732 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261281AbVBMPpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 10:45:18 -0500
Date: Sun, 13 Feb 2005 16:44:41 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Steve Frenchs <french@samba.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6] Check return of copy_from_user value in cifssmb.c [Re: Linux 2.6.11-rc4]
Message-ID: <20050213154441.GB26396@dreamland.darkstar.lan>
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
Il dottore mi ha detto di smettere di fare cene intime per quattro.
A meno che non ci siamo altre tre persone.
