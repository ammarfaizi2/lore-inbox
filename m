Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTE0LN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTE0LN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:13:28 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:40397 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263258AbTE0LNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:13:25 -0400
Subject: Re: [PATCH] Shared crc32 for 2.4.
From: David Woodhouse <dwmw2@infradead.org>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <03ee01c320b4$c3040ad0$020120b0@jockeXP>
References: <03ee01c320b4$c3040ad0$020120b0@jockeXP>
Content-Type: text/plain
Organization: 
Message-Id: <1054034796.2082.82.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 27 May 2003 12:26:36 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 23:51, Joakim Tjernlund wrote:
> David, please use my latest crc32 mods in the 2.5 tree.
> I think I sent them to you too.
> It is a cleanup and optimization for x86.

Oops, sorry I thought I had, but in fact I'd used a slightly older
version. BK tree (and linux-2.4.21-rc4-shared-crc32.patch on
ftp.kernel.org) updated accordingly...

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1226.1.1 -> 1.1226.1.2
#	         lib/crc32.c	1.3     -> 1.4    
#	     lib/crc32defs.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/27	dwmw2@infradead.org	1.1226.1.2
# Back-port Jocke's CRC32 optimisations from 2.5.
# --------------------------------------------
#
diff -Nru a/lib/crc32.c b/lib/crc32.c
--- a/lib/crc32.c	Tue May 27 11:45:55 2003
+++ b/lib/crc32.c	Tue May 27 11:45:55 2003
@@ -90,32 +90,29 @@
 	const u32      *tab = crc32table_le;
 
 # ifdef __LITTLE_ENDIAN
-#  define DO_CRC crc = (crc>>8) ^ tab[ crc & 255 ]
-#  define ENDIAN_SHIFT 0
+#  define DO_CRC(x) crc = tab[ (crc ^ (x)) & 255 ] ^ (crc>>8)
 # else
-#  define DO_CRC crc = (crc<<8) ^ tab[ crc >> 24 ]
-#  define ENDIAN_SHIFT 24
+#  define DO_CRC(x) crc = tab[ ((crc >> 24) ^ (x)) & 255] ^ (crc<<8)
 # endif
 
 	crc = __cpu_to_le32(crc);
 	/* Align it */
-	if( ((u32)b)&3 && len){
+	if(unlikely(((long)b)&3 && len)){
 		do {
-			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
-			DO_CRC;
-		} while ((--len) && ((u32)b)&3 );
+			DO_CRC(*((u8 *)b)++);
+		} while ((--len) && ((long)b)&3 );
 	}
-	if(len >= 4){
+	if(likely(len >= 4)){
 		/* load data 32 bits wide, xor data 32 bits wide. */
 		size_t save_len = len & 3;
 	        len = len >> 2;
 		--b; /* use pre increment below(*++b) for speed */
 		do {
 			crc ^= *++b;
-			DO_CRC;
-			DO_CRC;
-			DO_CRC;
-			DO_CRC;
+			DO_CRC(0);
+			DO_CRC(0);
+			DO_CRC(0);
+			DO_CRC(0);
 		} while (--len);
 		b++; /* point to next byte(s) */
 		len = save_len;
@@ -123,8 +120,7 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
-			DO_CRC;
+			DO_CRC(*((u8 *)b)++);
 		} while (--len);
 	}
 
@@ -195,32 +191,29 @@
 	const u32      *tab = crc32table_be;
 
 # ifdef __LITTLE_ENDIAN
-#  define DO_CRC crc = (crc>>8) ^ tab[ crc & 255 ]
-#  define ENDIAN_SHIFT 24
+#  define DO_CRC(x) crc = tab[ (crc ^ (x)) & 255 ] ^ (crc>>8)
 # else
-#  define DO_CRC crc = (crc<<8) ^ tab[ crc >> 24 ]
-#  define ENDIAN_SHIFT 0
+#  define DO_CRC(x) crc = tab[ ((crc >> 24) ^ (x)) & 255] ^ (crc<<8)
 # endif
 
 	crc = __cpu_to_be32(crc);
 	/* Align it */
-	if( ((u32)b)&3 && len){
+	if(unlikely(((long)b)&3 && len)){
 		do {
-			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
-			DO_CRC;
-		} while ((--len) && ((u32)b)&3 );
+			DO_CRC(*((u8 *)b)++);
+		} while ((--len) && ((long)b)&3 );
 	}
-	if(len >= 4){
+	if(likely(len >= 4)){
 		/* load data 32 bits wide, xor data 32 bits wide. */
 		size_t save_len = len & 3;
 	        len = len >> 2;
 		--b; /* use pre increment below(*++b) for speed */
 		do {
 			crc ^= *++b;
-			DO_CRC;
-			DO_CRC;
-			DO_CRC;
-			DO_CRC;
+			DO_CRC(0);
+			DO_CRC(0);
+			DO_CRC(0);
+			DO_CRC(0);
 		} while (--len);
 		b++; /* point to next byte(s) */
 		len = save_len;
@@ -228,8 +221,7 @@
 	/* And the last few bytes */
 	if(len){
 		do {
-			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
-			DO_CRC;
+			DO_CRC(*((u8 *)b)++);
 		} while (--len);
 	}
 	return __be32_to_cpu(crc);
diff -Nru a/lib/crc32defs.h b/lib/crc32defs.h
--- a/lib/crc32defs.h	Tue May 27 11:45:55 2003
+++ b/lib/crc32defs.h	Tue May 27 11:45:55 2003
@@ -8,8 +8,12 @@
 
 /* How many bits at a time to use.  Requires a table of 4<<CRC_xx_BITS
bytes. */
 /* For less performance-sensitive, use 4 */
-#define CRC_LE_BITS 8
-#define CRC_BE_BITS 8
+#ifndef CRC_LE_BITS 
+# define CRC_LE_BITS 8
+#endif
+#ifndef CRC_BE_BITS
+# define CRC_BE_BITS 8
+#endif
 
 /*
  * Little-endian CRC computation.  Used with serial bit streams sent



-- 
dwmw2

