Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264611AbTE1IQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264612AbTE1IQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:16:39 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:29416 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S264611AbTE1IQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:16:35 -0400
Subject: Re: Linux 2.4.21-rc4-ac1
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200305271626.h4RGQ7v10151@devserv.devel.redhat.com>
References: <200305271626.h4RGQ7v10151@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054110589.2082.129.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Wed, 28 May 2003 09:29:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> o	Add CRC32 libraries backport	(David Woodhouse, Duncan Sands)

This fixes the 'CONFIG_CRC32=y but nothing references it' case, and also
merges the optimisations made by Joakim Tjernlund in 2.5's version.

diff -uNr linux-2.4.21-rc4-ac1/kernel/ksyms.c linux-2.4.21-rc4-ac1-crc/kernel/ksyms.c
--- linux-2.4.21-rc4-ac1/kernel/ksyms.c	Wed May 28 09:19:53 2003
+++ linux-2.4.21-rc4-ac1-crc/kernel/ksyms.c	Wed May 28 09:23:34 2003
@@ -49,6 +49,7 @@
 #include <linux/completion.h>
 #include <linux/seq_file.h>
 #include <linux/dnotify.h>
+#include <linux/crc32.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -575,6 +576,12 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+
+#ifdef CONFIG_CRC32
+EXPORT_SYMBOL(crc32_le);
+EXPORT_SYMBOL(crc32_be);
+EXPORT_SYMBOL(bitreverse);
+#endif
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_hi_vec);
diff -uNr linux-2.4.21-rc4-ac1/lib/Makefile linux-2.4.21-rc4-ac1-crc/lib/Makefile
--- linux-2.4.21-rc4-ac1/lib/Makefile	Wed May 28 09:19:53 2003
+++ linux-2.4.21-rc4-ac1-crc/lib/Makefile	Wed May 28 09:23:34 2003
@@ -8,7 +8,8 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o crc32.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
+	       rbtree.o crc32.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o dump_stack.o
diff -uNr linux-2.4.21-rc4-ac1/lib/crc32.c linux-2.4.21-rc4-ac1-crc/lib/crc32.c
--- linux-2.4.21-rc4-ac1/lib/crc32.c	Wed May 28 09:19:53 2003
+++ linux-2.4.21-rc4-ac1-crc/lib/crc32.c	Wed May 28 09:23:34 2003
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
@@ -266,9 +258,12 @@
 	return x;
 }
 
+#ifdef MODULE /* These are exported from kernel/ksyms.c in the non-module
+		 case, to ensure that this file is pulled in from lib/lib.a */
 EXPORT_SYMBOL(crc32_le);
 EXPORT_SYMBOL(crc32_be);
 EXPORT_SYMBOL(bitreverse);
+#endif
 
 /*
  * A brief CRC tutorial.
diff -uNr linux-2.4.21-rc4-ac1/lib/crc32defs.h linux-2.4.21-rc4-ac1-crc/lib/crc32defs.h
--- linux-2.4.21-rc4-ac1/lib/crc32defs.h	Wed May 28 09:19:53 2003
+++ linux-2.4.21-rc4-ac1-crc/lib/crc32defs.h	Wed May 28 09:23:34 2003
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



-- 
dwmw2

