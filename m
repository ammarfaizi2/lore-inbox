Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbTBQWj5>; Mon, 17 Feb 2003 17:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbTBQWj5>; Mon, 17 Feb 2003 17:39:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:64386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267617AbTBQWj4>;
	Mon, 17 Feb 2003 17:39:56 -0500
Subject: [PATCH] Fix warnings from CIFS on 2.5.61
From: Stephen Hemminger <shemminger@osdl.org>
To: sfrench@samba.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1045522192.12947.90.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 17 Feb 2003 14:49:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets rid of the following warnings.

fs/cifs/cifssmb.c: In function `CIFSSMBRead':
fs/cifs/cifssmb.c:489: warning: duplicate `const'
fs/cifs/cifssmb.c: In function `CIFSSMBUnixQuerySymLink':
fs/cifs/cifssmb.c:1030: warning: duplicate `const'
fs/cifs/cifssmb.c:1044: warning: duplicate `const'
fs/cifs/cifssmb.c: In function `CIFSSMBQueryReparseLinkInfo':
fs/cifs/cifssmb.c:1120: warning: duplicate `const'

diff -Nru a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
--- a/fs/cifs/cifssmb.c	Mon Feb 17 14:16:15 2003
+++ b/fs/cifs/cifssmb.c	Mon Feb 17 14:16:15 2003
@@ -504,9 +504,10 @@
 	pSMB->OffsetLow = cpu_to_le32(lseek & 0xFFFFFFFF);
 	pSMB->OffsetHigh = cpu_to_le32(lseek >> 32);
 	pSMB->Remaining = 0;
-	pSMB->MaxCount = cpu_to_le16(min(count,
-					 (tcon->ses->server->maxBuf -
-					  MAX_CIFS_HDR_SIZE) & 0xFFFFFF00));
+	pSMB->MaxCount = cpu_to_le16(min_t(const int, 
+					   count,
+					   (tcon->ses->server->maxBuf -
+					    MAX_CIFS_HDR_SIZE) & 0xFFFFFF00));
 	pSMB->MaxCountHigh = 0;
 	pSMB->ByteCount = 0;  /* no need to do le conversion since it is 0 */
 
@@ -1045,9 +1046,10 @@
 								   Protocol +
 								   pSMBr->
 								   DataOffset),
-						      min(buflen,
-							  (int) pSMBr->
-							  DataCount) / 2);
+						      min_t(const int,
+							    buflen,
+							    pSMBr->
+							    DataCount) / 2);
 				cifs_strfromUCS_le(symlinkinfo,
 						   (wchar_t *) ((char *)
 								&pSMBr->
@@ -1059,9 +1061,9 @@
 			} else {
 				strncpy(symlinkinfo,
 					(char *) &pSMBr->hdr.Protocol +
-					pSMBr->DataOffset, min(buflen, (int)
-							       pSMBr->
-							       DataCount));
+					pSMBr->DataOffset, 
+					min_t(const int,
+						buflen,pSMBr->DataCount));
 			}
 			symlinkinfo[buflen] = 0;
 	/* just in case so calling code does not go off the end of buffer */
@@ -1137,7 +1139,8 @@
 				} else { /* ASCII names */
 					strncpy(symlinkinfo,reparse_buf->LinkNamesBuf + 
 						reparse_buf->TargetNameOffset, 
-						min(buflen, (int)reparse_buf->TargetNameLen));
+						min_t(const int,
+						      buflen, reparse_buf->TargetNameLen));
 				}
 			} else {
 				rc = -EIO;



