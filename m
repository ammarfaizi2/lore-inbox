Return-Path: <linux-kernel-owner+w=401wt.eu-S1751039AbXAFBGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbXAFBGz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 20:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbXAFBGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 20:06:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2522 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751040AbXAFBGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 20:06:53 -0500
Date: Sat, 6 Jan 2007 02:06:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI seagate.c: remove SEAGATE_USE_ASM
Message-ID: <20070106010656.GF20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using assembler code for performance in drivers might have been a good 
idea 15 years ago when this code was written, but with today's compilers 
that's unlikely to be an advantage.

Besides this, it also hurts the readability.

Simply use the C code that was already there as an alternative.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/Makefile  |    2 
 drivers/scsi/seagate.c |  148 -----------------------------------------
 2 files changed, 1 insertion(+), 149 deletions(-)

--- linux-2.6.20-rc3-mm1/drivers/scsi/Makefile.old	2007-01-05 23:01:12.000000000 +0100
+++ linux-2.6.20-rc3-mm1/drivers/scsi/Makefile	2007-01-05 23:01:51.000000000 +0100
@@ -16,7 +16,7 @@
 
 CFLAGS_aha152x.o =   -DAHA152X_STAT -DAUTOCONF
 CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
-CFLAGS_seagate.o =   -DARBITRATE -DPARITY -DSEAGATE_USE_ASM
+CFLAGS_seagate.o =   -DARBITRATE -DPARITY
 
 subdir-$(CONFIG_PCMCIA)		+= pcmcia
 
--- linux-2.6.20-rc3-mm1/drivers/scsi/seagate.c.old	2007-01-05 23:02:03.000000000 +0100
+++ linux-2.6.20-rc3-mm1/drivers/scsi/seagate.c	2007-01-05 23:03:11.000000000 +0100
@@ -60,10 +60,6 @@
  * -DPARITY  
  *      This will enable parity.
  *
- * -DSEAGATE_USE_ASM
- *      Will use older seagate assembly code. should be (very small amount)
- *      Faster.
- *
  * -DSLOW_RATE=50
  *      Will allow compatibility with broken devices that don't
  *      handshake fast enough (ie, some CD ROM's) for the Seagate
@@ -132,10 +128,6 @@
 #error Please use -DCONTROLLER=SEAGATE or -DCONTROLLER=FD to override controller type
 #endif
 
-#ifndef __i386__
-#undef SEAGATE_USE_ASM
-#endif
-
 /*
 	Thanks to Brian Antoine for the example code in his Messy-Loss ST-01
 		driver, and Mitsugu Suzuki for information on the ST-01
@@ -539,9 +531,6 @@
 #ifdef PARITY
 		" PARITY"
 #endif
-#ifdef SEAGATE_USE_ASM
-		" SEAGATE_USE_ASM"
-#endif
 #ifdef SLOW_RATE
 		" SLOW_RATE"
 #endif
@@ -1139,30 +1128,7 @@
 						 data);
 
 			/* SJT: Start. Fast Write */
-#ifdef SEAGATE_USE_ASM
-					__asm__ ("cld\n\t"
-#ifdef FAST32
-						 "shr $2, %%ecx\n\t"
-						 "1:\t"
-						 "lodsl\n\t"
-						 "movl %%eax, (%%edi)\n\t"
-#else
-						 "1:\t"
-						 "lodsb\n\t"
-						 "movb %%al, (%%edi)\n\t"
-#endif
-						 "loop 1b;"
-				      /* output */ :
-				      /* input */ :"D" (st0x_dr),
-						 "S"
-						 (data),
-						 "c" (SCint->transfersize)
-/* clobbered */
-				      :	 "eax", "ecx",
-						 "esi");
-#else				/* SEAGATE_USE_ASM */
 					memcpy_toio(st0x_dr, data, transfersize);
-#endif				/* SEAGATE_USE_ASM */
 /* SJT: End */
 					len -= transfersize;
 					data += transfersize;
@@ -1175,49 +1141,6 @@
 					 */
 
 /* SJT: Start. Slow Write. */
-#ifdef SEAGATE_USE_ASM
-
-					int __dummy_1, __dummy_2;
-
-/*
- *      We loop as long as we are in a data out phase, there is data to send, 
- *      and BSY is still active.
- */
-/* Local variables : len = ecx , data = esi, 
-                     st0x_cr_sr = ebx, st0x_dr =  edi
-*/
-					__asm__ (
-							/* Test for any data here at all. */
-							"orl %%ecx, %%ecx\n\t"
-							"jz 2f\n\t" "cld\n\t"
-/*                    "movl st0x_cr_sr, %%ebx\n\t"  */
-/*                    "movl st0x_dr, %%edi\n\t"  */
-							"1:\t"
-							"movb (%%ebx), %%al\n\t"
-							/* Test for BSY */
-							"test $1, %%al\n\t"
-							"jz 2f\n\t"
-							/* Test for data out phase - STATUS & REQ_MASK should be 
-							   REQ_DATAOUT, which is 0. */
-							"test $0xe, %%al\n\t"
-							"jnz 2f\n\t"
-							/* Test for REQ */
-							"test $0x10, %%al\n\t"
-							"jz 1b\n\t"
-							"lodsb\n\t"
-							"movb %%al, (%%edi)\n\t"
-							"loop 1b\n\t" "2:\n"
-				      /* output */ :"=S" (data), "=c" (len),
-							"=b"
-							(__dummy_1),
-							"=D" (__dummy_2)
-/* input */
-				      :		"0" (data), "1" (len),
-							"2" (st0x_cr_sr),
-							"3" (st0x_dr)
-/* clobbered */
-				      :		"eax");
-#else				/* SEAGATE_USE_ASM */
 					while (len) {
 						unsigned char stat;
 
@@ -1231,7 +1154,6 @@
 							--len;
 						}
 					}
-#endif				/* SEAGATE_USE_ASM */
 /* SJT: End. */
 				}
 
@@ -1277,30 +1199,7 @@
 						 data);
 
 /* SJT: Start. Fast Read */
-#ifdef SEAGATE_USE_ASM
-					__asm__ ("cld\n\t"
-#ifdef FAST32
-						 "shr $2, %%ecx\n\t"
-						 "1:\t"
-						 "movl (%%esi), %%eax\n\t"
-						 "stosl\n\t"
-#else
-						 "1:\t"
-						 "movb (%%esi), %%al\n\t"
-						 "stosb\n\t"
-#endif
-						 "loop 1b\n\t"
-				      /* output */ :
-				      /* input */ :"S" (st0x_dr),
-						 "D"
-						 (data),
-						 "c" (SCint->transfersize)
-/* clobbered */
-				      :	 "eax", "ecx",
-						 "edi");
-#else				/* SEAGATE_USE_ASM */
 					memcpy_fromio(data, st0x_dr, len);
-#endif				/* SEAGATE_USE_ASM */
 /* SJT: End */
 					len -= transfersize;
 					data += transfersize;
@@ -1324,52 +1223,6 @@
  */
 
 /* SJT: Start. */
-#ifdef SEAGATE_USE_ASM
-
-					int __dummy_3, __dummy_4;
-
-/* Dummy clobbering variables for the new gcc-2.95 */
-
-/*
- *      We loop as long as we are in a data in phase, there is room to read, 
- *      and BSY is still active
- */
-					/* Local variables : ecx = len, edi = data
-					   esi = st0x_cr_sr, ebx = st0x_dr */
-					__asm__ (
-							/* Test for room to read */
-							"orl %%ecx, %%ecx\n\t"
-							"jz 2f\n\t" "cld\n\t"
-/*                "movl st0x_cr_sr, %%esi\n\t"  */
-/*                "movl st0x_dr, %%ebx\n\t"  */
-							"1:\t"
-							"movb (%%esi), %%al\n\t"
-							/* Test for BSY */
-							"test $1, %%al\n\t"
-							"jz 2f\n\t"
-							/* Test for data in phase - STATUS & REQ_MASK should be REQ_DATAIN, 
-							   = STAT_IO, which is 4. */
-							"movb $0xe, %%ah\n\t"
-							"andb %%al, %%ah\n\t"
-							"cmpb $0x04, %%ah\n\t"
-							"jne 2f\n\t"
-							/* Test for REQ */
-							"test $0x10, %%al\n\t"
-							"jz 1b\n\t"
-							"movb (%%ebx), %%al\n\t"
-							"stosb\n\t"
-							"loop 1b\n\t" "2:\n"
-				      /* output */ :"=D" (data), "=c" (len),
-							"=S"
-							(__dummy_3),
-							"=b" (__dummy_4)
-/* input */
-				      :		"0" (data), "1" (len),
-							"2" (st0x_cr_sr),
-							"3" (st0x_dr)
-/* clobbered */
-				      :		"eax");
-#else				/* SEAGATE_USE_ASM */
 					while (len) {
 						unsigned char stat;
 
@@ -1383,7 +1236,6 @@
 							--len;
 						}
 					}
-#endif				/* SEAGATE_USE_ASM */
 /* SJT: End. */
 #if (DEBUG & PHASE_DATAIN)
 					printk ("scsi%d: transfered -= %d\n", hostno, len);

