Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbTBRJTB>; Tue, 18 Feb 2003 04:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbTBRJTB>; Tue, 18 Feb 2003 04:19:01 -0500
Received: from shyguy.smb.utfors.se ([195.58.112.21]:6306 "EHLO
	shyguy.smb.utfors.se") by vger.kernel.org with ESMTP
	id <S267743AbTBRJS7>; Tue, 18 Feb 2003 04:18:59 -0500
Date: Tue, 18 Feb 2003 10:28:57 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: [PATCH]  crc32 improvements for 2.5, more optimizations
In-reply-to: <1044365707.4067.4.camel@passion.cambridge.redhat.com>
To: torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>,
       David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Reply-to: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEFJFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is another update(against BK curr) for crc32(). A kind soul pointed out
the optimizations below.

lib/crc32defs.h:
 - Make it possible to define new values for CRC_LE_BITS/CRC_BE_BITS without
   modifying the source.

lib/crc32.c:
 - Eliminate the need for ENDIAN_SHIFT. Saves a 24 bit shift in the byte
   loops.

 - Swap the XOR expression in DO_CRC. gcc for x86 can not do that simple
   optimization itself(gcc 3.2.2 and RH gcc 2.96 tested). Will improve
   performance with 20-25% on x86.
 
           Joakim Tjernlund

--- lib/crc32defs.h	Wed Jan  8 01:35:35 2003
+++ lib/new.crc32defs.h	Tue Feb 18 09:38:08 2003
@@ -8,8 +8,12 @@
 
 /* How many bits at a time to use.  Requires a table of 4<<CRC_xx_BITS bytes. */
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


--- lib/crc32.c	Tue Feb 18 09:29:46 2003
+++ lib/new.crc32.c	Tue Feb 18 09:43:15 2003
@@ -90,19 +90,16 @@
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
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
-			DO_CRC;
+			DO_CRC(*((u8 *)b)++);
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >= 4)){
@@ -112,10 +109,10 @@
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
 
@@ -195,19 +191,16 @@
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
 	if(unlikely(((long)b)&3 && len)){
 		do {
-			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
-			DO_CRC;
+			DO_CRC(*((u8 *)b)++);
 		} while ((--len) && ((long)b)&3 );
 	}
 	if(likely(len >= 4)){
@@ -217,10 +210,10 @@
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


