Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268020AbTBMLDb>; Thu, 13 Feb 2003 06:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268022AbTBMLDb>; Thu, 13 Feb 2003 06:03:31 -0500
Received: from snifit.smb.utfors.se ([195.58.112.20]:65434 "EHLO
	snifit.smb.utfors.se") by vger.kernel.org with ESMTP
	id <S268020AbTBMLD1>; Thu, 13 Feb 2003 06:03:27 -0500
Date: Thu, 13 Feb 2003 12:13:16 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: [PATCH]  crc32 improvements for 2.5 [RESEND]
In-reply-to: <1044365707.4067.4.camel@passion.cambridge.redhat.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Reply-to: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEDMFKAA.joakim.tjernlund@lumentis.se>
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

[This is a resend, feedback welcome]

Hi

I did the optimizations in the crc32 patch Brian Murphy submitted a while ago.
Now I have cleaned it up a little and made some more optimizations.

gcc is quite bad at loop optimizations (at least for PPC) so I have
rewritten them to make gcc to generate better code. Even recent gcc's(3.2.x) produces
better code.

Also reduced the unrolling since it did not make a noticeable difference. 

           Joakim Tjernlund

--- lib/crc32.c.org	Thu Jan  9 00:19:02 2003
+++ lib/crc32.c	Tue Feb  4 19:05:01 2003
@@ -87,55 +87,51 @@
 {
 # if CRC_LE_BITS == 8
 	const u32      *b =(u32 *)p;
-	const u32      *e;
-	/* load data 32 bits wide, xor data 32 bits wide. */
+	const u32      *tab = crc32table_le;
 
-	crc = __cpu_to_le32(crc);
-	/* Align it */
-	for ( ; ((long)b)&3 && len ; len--){
-# ifdef __LITTLE_ENDIAN
-		crc = (crc>>8) ^ crc32table_le[ (crc ^ *((u8 *)b)++) & 0xff ];
-# else
-		crc = (crc<<8) ^ crc32table_le[ crc>>24 ^ *((u8 *)b)++ ];
-# endif
-	}
-	e = (u32 *) ( (u8 *)b + (len & ~7));
-	while (b < e) {
-		crc ^= *b++;
-# ifdef __LITTLE_ENDIAN
-		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
-# else
-		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
-# endif
-		crc ^= *b++;
 # ifdef __LITTLE_ENDIAN
-		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_le[ crc & 0xff ];
+#  define DO_CRC crc = (crc>>8) ^ tab[ crc & 255 ]
+#  define ENDIAN_SHIFT 0
 # else
-		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_le[ crc >> 24 ];
+#  define DO_CRC crc = (crc<<8) ^ tab[ crc >> 24 ]
+#  define ENDIAN_SHIFT 24
 # endif
+
+	crc = __cpu_to_le32(crc);
+	/* Align it */
+	if(unlikely(((long)b)&3 && len)){
+		do {
+			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
+			DO_CRC;
+		} while ((--len) && ((long)b)&3 );
+	}
+	if(likely(len >= 4)){
+		/* load data 32 bits wide, xor data 32 bits wide. */
+		size_t save_len = len & 3;
+	        len = len >> 2;
+		--b; /* use pre increment below(*++b) for speed */
+		do {
+			crc ^= *++b;
+			DO_CRC;
+			DO_CRC;
+			DO_CRC;
+			DO_CRC;
+		} while (--len);
+		b++; /* point to next byte(s) */
+		len = save_len;
 	}
 	/* And the last few bytes */
-	e = (u32 *)((u8 *)b + (len & 7));
-	while (b < e){
-# ifdef __LITTLE_ENDIAN
-		crc = (crc>>8) ^ crc32table_le[ (crc ^ *((u8 *)b)++) & 0xff ];
-# else
-		crc = (crc<<8) ^ crc32table_le[ crc>>24 ^ *((u8 *)b)++ ];
-# endif
+	if(len){
+		do {
+			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
+			DO_CRC;
+		} while (--len);
 	}
-	return __le32_to_cpu(crc) ;
+
+	return __le32_to_cpu(crc);
+#undef ENDIAN_SHIFT
+#undef DO_CRC
+
 # elif CRC_LE_BITS == 4
 	while (len--) {
 		crc ^= *p++;
@@ -196,55 +192,50 @@
 {
 # if CRC_BE_BITS == 8
 	const u32      *b =(u32 *)p;
-	const u32      *e;
-	/* load data 32 bits wide, xor data 32 bits wide. */
+	const u32      *tab = crc32table_be;
 
-	crc = __cpu_to_be32(crc);
-	/* Align it */
-	for ( ; ((long)b)&3 && len ; len--){
-# ifdef __LITTLE_ENDIAN
-		crc = (crc>>8) ^ crc32table_be[ (crc ^ *((u8 *)b)++) & 0xff ];
-# else
-		crc = (crc<<8) ^ crc32table_be[ crc>>24 ^ *((u8 *)b)++ ];
-# endif
-	}
-	e = (u32 *) ( (u8 *)b + (len & ~7));
-	while (b < e) {
-		crc ^= *b++;
-# ifdef __LITTLE_ENDIAN
-		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
-# else
-		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
-# endif
-		crc ^= *b++;
 # ifdef __LITTLE_ENDIAN
-		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
-		crc = (crc>>8) ^ crc32table_be[ crc & 0xff ];
+#  define DO_CRC crc = (crc>>8) ^ tab[ crc & 255 ]
+#  define ENDIAN_SHIFT 24
 # else
-		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
-		crc = (crc<<8) ^ crc32table_be[ crc >> 24 ];
+#  define DO_CRC crc = (crc<<8) ^ tab[ crc >> 24 ]
+#  define ENDIAN_SHIFT 0
 # endif
+
+	crc = __cpu_to_be32(crc);
+	/* Align it */
+	if(unlikely(((long)b)&3 && len)){
+		do {
+			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
+			DO_CRC;
+		} while ((--len) && ((long)b)&3 );
+	}
+	if(likely(len >= 4)){
+		/* load data 32 bits wide, xor data 32 bits wide. */
+		size_t save_len = len & 3;
+	        len = len >> 2;
+		--b; /* use pre increment below(*++b) for speed */
+		do {
+			crc ^= *++b;
+			DO_CRC;
+			DO_CRC;
+			DO_CRC;
+			DO_CRC;
+		} while (--len);
+		b++; /* point to next byte(s) */
+		len = save_len;
 	}
 	/* And the last few bytes */
-	e = (u32 *)((u8 *)b + (len & 7));
-	while (b < e){
-# ifdef __LITTLE_ENDIAN
-		crc = (crc>>8) ^ crc32table_be[ (crc ^ *((u8 *)b)++) & 0xff ];
-# else
-		crc = (crc<<8) ^ crc32table_be[ crc>>24 ^ *((u8 *)b)++ ];
-# endif
-	}
-	return __be32_to_cpu(crc) ;
+	if(len){
+		do {
+			crc ^= *((u8 *)b)++ << ENDIAN_SHIFT;
+			DO_CRC;
+		} while (--len);
+	}
+	return __be32_to_cpu(crc);
+#undef ENDIAN_SHIFT
+#undef DO_CRC
+
 # elif CRC_BE_BITS == 4
 	while (len--) {
 		crc ^= *p++ << 24;


