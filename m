Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbSKUKJu>; Thu, 21 Nov 2002 05:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbSKUKJt>; Thu, 21 Nov 2002 05:09:49 -0500
Received: from shyguy.smb.utfors.se ([195.58.112.21]:50325 "EHLO
	shyguy.smb.utfors.se") by vger.kernel.org with ESMTP
	id <S266438AbSKUKJn>; Thu, 21 Nov 2002 05:09:43 -0500
Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <Matt_Domsch@Dell.com>, <brm@murphy.dk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Early crc32 initialization
Date: Thu, 21 Nov 2002 11:16:48 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLKEDBFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Murphy posted this on 8-Oct with no response. Quoting:

Here is a patch to the crc32 library routine to allow explicit
initialization of the tables used by the routines. 


I need this to be able to use the crc routines in the early 
start up code for my platform which saves crc protected 
information (clock speed, machine type) in an eeprom.


The option CONFIG_CRC32_EXPLICIT is defined for the platforms 
which need it in the config.in file.


I have removed dynamic allocation of memory because the 
memory subsystem is also not initialised at the stage where I
need the crc functions.


/Brian



The current crc32 library code is set up as a core_initcall because it was
being used by net, usb, fs, and bluetooth subsystem drivers. This isn't
early enough for Brian, whose mips arch CPU needs the code in setup_arch.
He's proposed two solutions:


1) Brian's first patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=103410018005672&w=2
defines CONFIG_CRC32_EXPLICIT and his code calls init_crc32() as early as
needed.
2) make an early_initcall that happens before setup_arch is called, but
which then touches all arches.


I'm leaning toward:
3) Since kmalloc() isn't available that early, he's switched to a declared
variable. Don't even bother with an init_crc32() - simply declare and fill
the arrays with their values. Add CONFIG_HISCPU to the lib/Makefile to get
it built-in or modular just as every other crc32 user does.


Thoughts?
-Matt

------------------------

Hi Matt and Brian

I have doen an optimiztion that improves scan time in JFFS2 with more that 25% for
my PPC custom board. This patch needs to use __cpu_to_be32()/__cpu_to_le32() on the
tables. That may cause problems if a static table is to be used. See below:

 Jocke

--- lib/crc32.c	Tue Nov 12 10:56:27 2002
+++ lib/crc32.c	Fri Nov 15 16:40:52 2002
@@ -111,7 +111,11 @@
 	for (i = 1 << (CRC_LE_BITS - 1); i; i >>= 1) {
 		crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
 		for (j = 0; j < 1 << CRC_LE_BITS; j += 2 * i)
+# if CRC_LE_BITS == 8 
+			crc32table_le[i + j] = __cpu_to_le32(crc) ^ crc32table_le[j];
+# else
 			crc32table_le[i + j] = crc ^ crc32table_le[j];
+# endif
 	}
 	return 0;
 }
@@ -135,22 +139,74 @@
  */
 u32 attribute((pure)) crc32_le(u32 crc, unsigned char const *p, size_t len)
 {
-	while (len--) {
 # if CRC_LE_BITS == 8
-		crc = (crc >> 8) ^ crc32table_le[(crc ^ *p++) & 255];
+	const u32      *b =(u32 *)p;
+	const u32      *e;
+	/* load data 32 bits wide, xor data 32 bits wide. */
+
+	crc = __cpu_to_le32(crc);
+	/* Align it */
+	for ( ; ((u32)b)&3 && len ; len--){
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ (crc ^ *((u8 *)b)++) & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc>>24 ^ *((u8 *)b)++ ];
+# endif
+	}
+	e = (u32 *) ( (u8 *)b + (len & ~7));
+	while (b < e) {
+		crc ^= *b++;
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+# endif
+		crc ^= *b++;
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+# endif
+	}
+	/* And the last few bytes */
+	e = (u32 *)((u8 *)b + (len & 7));
+	while (b < e){
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ (crc ^ *((u8 *)b)++) & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc>>24 ^ *((u8 *)b)++ ];
+# endif
+	}
+	return __le32_to_cpu(crc) ;
 # elif CRC_LE_BITS == 4
+	while (len--) {
 		crc ^= *p++;
 		crc = (crc >> 4) ^ crc32table_le[crc & 15];
 		crc = (crc >> 4) ^ crc32table_le[crc & 15];
+	}
+	return crc;
 # elif CRC_LE_BITS == 2
+	while (len--) {
 		crc ^= *p++;
 		crc = (crc >> 2) ^ crc32table_le[crc & 3];
 		crc = (crc >> 2) ^ crc32table_le[crc & 3];
 		crc = (crc >> 2) ^ crc32table_le[crc & 3];
 		crc = (crc >> 2) ^ crc32table_le[crc & 3];
-# endif
 	}
 	return crc;
+# endif
 }
 #endif
 
@@ -211,7 +267,11 @@
 	for (i = 1; i < 1 << CRC_BE_BITS; i <<= 1) {
 		crc = (crc << 1) ^ ((crc & 0x80000000) ? CRCPOLY_BE : 0);
 		for (j = 0; j < i; j++)
+# if CRC_BE_BITS == 8
+			crc32table_be[i + j] =  __cpu_to_be32(crc) ^ crc32table_be[j];
+# else
 			crc32table_be[i + j] = crc ^ crc32table_be[j];
+# endif
 	}
 	return 0;
 }
@@ -236,22 +296,74 @@
  */
 u32 attribute((pure)) crc32_be(u32 crc, unsigned char const *p, size_t len)
 {
-	while (len--) {
 # if CRC_BE_BITS == 8
-		crc = (crc << 8) ^ crc32table_be[(crc >> 24) ^ *p++];
+	const u32      *b =(u32 *)p;
+	const u32      *e;
+	/* load data 32 bits wide, xor data 32 bits wide. */
+
+	crc = __cpu_to_be32(crc);
+	/* Align it */
+	for ( ; ((u32)b)&3 && len ; len--){
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ (crc ^ *((u8 *)b)++) & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc>>24 ^ *((u8 *)b)++ ];
+# endif
+	}
+	e = (u32 *) ( (u8 *)b + (len & ~7));
+	while (b < e) {
+		crc ^= *b++;
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+# endif
+		crc ^= *b++;
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+# endif
+	}
+	/* And the last few bytes */
+	e = (u32 *)((u8 *)b + (len & 7));
+	while (b < e){
+# ifdef __LITTLE_ENDIAN
+		crc = (crc>>8) ^ crc32table_le[ (crc ^ *((u8 *)b)++) & 0xff ];
+# else
+		crc = (crc<<8) ^ crc32table_le[ crc>>24 ^ *((u8 *)b)++ ];
+# endif
+	}
+	return __be32_to_cpu(crc) ;
 # elif CRC_BE_BITS == 4
+	while (len--) {
 		crc ^= *p++ << 24;
 		crc = (crc << 4) ^ crc32table_be[crc >> 28];
 		crc = (crc << 4) ^ crc32table_be[crc >> 28];
+	}
+	return crc;
 # elif CRC_BE_BITS == 2
+	while (len--) {
 		crc ^= *p++ << 24;
 		crc = (crc << 2) ^ crc32table_be[crc >> 30];
 		crc = (crc << 2) ^ crc32table_be[crc >> 30];
 		crc = (crc << 2) ^ crc32table_be[crc >> 30];
 		crc = (crc << 2) ^ crc32table_be[crc >> 30];
-# endif
 	}
 	return crc;
+# endif
 }
 #endif
 


