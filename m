Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVDAMrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVDAMrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVDAMra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:47:30 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:13506 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S262729AbVDAMnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:43:25 -0500
Subject: [RFC] : remove unreliable, unused and unmainained arch from kernel.
In-Reply-To: <1112357493492@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 16:11:33 +0400
Message-Id: <11123574931907@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Fri, 01 Apr 2005 16:43:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -ru ./linux-2.6.9-orig/drivers/scsi/in2000.h ./linux-2.6.9/drivers/scsi/in2000.h
--- ./linux-2.6.9-orig/drivers/scsi/in2000.h	2005-03-31 16:26:50.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/in2000.h	2005-03-31 17:09:52.000000000 +0400
@@ -34,11 +34,6 @@
 #define DEBUGGING_ON       /* enable command-line debugging bitmask */
 #define DEBUG_DEFAULTS 0   /* default bitmask - change from command-line */
 
-#ifdef __i386__
-#define FAST_READ_IO       /* No problems with these on my machine */
-#define FAST_WRITE_IO
-#endif
-
 #ifdef DEBUGGING_ON
 #define DB(f,a) if (hostdata->args & (f)) a;
 #define CHECK_NULL(p,s) /* if (!(p)) {printk("\n"); while (1) printk("NP:%s\r",(s));} */
@@ -54,47 +49,6 @@
 #define write1_io(b,a)  (outb((b),hostdata->io_base+(a)))
 #define write2_io(w,a)  (outw((w),hostdata->io_base+(a)))
 
-#ifdef __i386__
-/* These inline assembly defines are derived from a patch
- * sent to me by Bill Earnest. He's done a lot of very
- * valuable thinking, testing, and coding during his effort
- * to squeeze more speed out of this driver. I really think
- * that we are doing IO at close to the maximum now with
- * the fifo. (And yes, insw uses 'edi' while outsw uses
- * 'esi'. Thanks Bill!)
- */
-
-#define FAST_READ2_IO()    \
-({ \
-int __dummy_1,__dummy_2; \
-   __asm__ __volatile__ ("\n \
-   cld                    \n \
-   orl %%ecx, %%ecx       \n \
-   jz 1f                  \n \
-   rep                    \n \
-   insw (%%dx),%%es:(%%edi) \n \
-1: "                       \
-   : "=D" (sp) ,"=c" (__dummy_1) ,"=d" (__dummy_2)  /* output */   \
-   : "2" (f), "0" (sp), "1" (i)  /* input */    \
-   );       /* trashed */ \
-})
-
-#define FAST_WRITE2_IO()   \
-({ \
-int __dummy_1,__dummy_2; \
-   __asm__ __volatile__ ("\n \
-   cld                    \n \
-   orl %%ecx, %%ecx       \n \
-   jz 1f                  \n \
-   rep                    \n \
-   outsw %%ds:(%%esi),(%%dx) \n \
-1: "                       \
-   : "=S" (sp) ,"=c" (__dummy_1) ,"=d" (__dummy_2)/* output */   \
-   : "2" (f), "0" (sp), "1" (i)  /* input */    \
-   );       /* trashed */ \
-})
-#endif
-
 /* IN2000 io_port offsets */
 #define IO_WD_ASR       0x00     /* R - 3393 auxstat reg */
 #define     ASR_INT        0x80
diff -ru ./linux-2.6.9-orig/drivers/scsi/ips.c ./linux-2.6.9/drivers/scsi/ips.c
--- ./linux-2.6.9-orig/drivers/scsi/ips.c	2005-03-31 16:26:50.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/ips.c	2005-03-31 17:10:17.000000000 +0400
@@ -210,8 +210,8 @@
 #define IPS_VERSION_HIGH        "7.10"
 #define IPS_VERSION_LOW         ".18 "
 
-#if !defined(__i386__) && !defined(__ia64__) && !defined(__x86_64__)
-#warning "This driver has only been tested on the x86/ia64/x86_64 platforms"
+#if !defined(__ia64__) && !defined(__x86_64__)
+#warning "This driver has only been tested on the ia64/x86_64 platforms"
 #endif
 
 #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
diff -ru ./linux-2.6.9-orig/drivers/scsi/Kconfig ./linux-2.6.9/drivers/scsi/Kconfig
--- ./linux-2.6.9-orig/drivers/scsi/Kconfig	2005-03-31 16:26:51.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/Kconfig	2005-03-31 17:15:17.000000000 +0400
@@ -1163,7 +1163,7 @@
 	help
 	  This option allows you to enable profiling information gathering.
 	  These statistics are not very accurate due to the low frequency
-	  of the kernel clock (100 Hz on i386) and have performance impact
+	  of the kernel clock (100 Hz on normal arch) and have performance impact
 	  on systems that use very fast devices.
 
 	  The normal answer therefore is N.
diff -ru ./linux-2.6.9-orig/drivers/scsi/NCR5380.h ./linux-2.6.9/drivers/scsi/NCR5380.h
--- ./linux-2.6.9-orig/drivers/scsi/NCR5380.h	2005-03-31 16:26:51.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/NCR5380.h	2005-03-31 17:14:34.000000000 +0400
@@ -321,7 +321,7 @@
 
 #if (defined(REAL_DMA) || defined(REAL_DMA_POLL))
 
-#if defined(i386) || defined(__alpha__)
+#if defined(__alpha__)
 
 /**
  *	NCR5380_pc_dma_setup		-	setup ISA DMA
@@ -425,7 +425,7 @@
 	
 	return tmp;
 }
-#endif				/* defined(i386) || defined(__alpha__) */
+#endif				/* defined(__alpha__) */
 #endif				/* defined(REAL_DMA)  */
 #endif				/* __KERNEL__ */
 #endif				/* ndef ASM */
diff -ru ./linux-2.6.9-orig/drivers/scsi/NCR53C9x.h ./linux-2.6.9/drivers/scsi/NCR53C9x.h
--- ./linux-2.6.9-orig/drivers/scsi/NCR53C9x.h	2005-03-31 16:26:51.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/NCR53C9x.h	2005-03-31 17:40:02.000000000 +0400
@@ -141,7 +141,7 @@
  * Yet, they all live within the same IO space.
  */
 
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 
 #ifndef MULTIPLE_PAD_SIZES
 
@@ -233,7 +233,7 @@
 
 #endif
 
-#else /* !defined(__i386__) && !defined(__x86_64__) */
+#else /* !defined(__x86_64__) */
 
 #define esp_write(__reg, __val) outb((__val), (__reg))
 #define esp_read(__reg) inb((__reg))
@@ -268,7 +268,7 @@
 #define esp_fgrnd   io_addr + 15 /* rw  Data base for fifo             0x3c  */
 };
 
-#endif /* !defined(__i386__) && !defined(__x86_64__) */
+#endif /* !defined(__x86_64__) */
 
 /* Various revisions of the ESP board. */
 enum esp_rev {
diff -ru ./linux-2.6.9-orig/drivers/scsi/scsi_ioctl.c ./linux-2.6.9/drivers/scsi/scsi_ioctl.c
--- ./linux-2.6.9-orig/drivers/scsi/scsi_ioctl.c	2005-03-31 16:26:52.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/scsi_ioctl.c	2005-03-31 17:16:48.000000000 +0400
@@ -193,7 +193,7 @@
  * Notes:
  *   -  The SCSI command length is determined by examining the 1st byte
  *      of the given command. There is no way to override this.
- *   -  Data transfers are limited to PAGE_SIZE (4K on i386, 8K on alpha).
+ *   -  Data transfers are limited to PAGE_SIZE (4K on normal arch, 8K on alpha).
  *   -  The length (x + y) must be at least OMAX_SB_LEN bytes long to
  *      accommodate the sense buffer when an error occurs.
  *      The sense buffer is truncated to OMAX_SB_LEN (16) bytes so that
diff -ru ./linux-2.6.9-orig/drivers/scsi/seagate.c ./linux-2.6.9/drivers/scsi/seagate.c
--- ./linux-2.6.9-orig/drivers/scsi/seagate.c	2005-03-31 16:26:51.000000000 +0400
+++ ./linux-2.6.9/drivers/scsi/seagate.c	2005-03-31 17:13:20.000000000 +0400
@@ -129,9 +129,7 @@
 #error Please use -DCONTROLLER=SEAGATE or -DCONTROLLER=FD to override controller type
 #endif
 
-#ifndef __i386__
 #undef SEAGATE_USE_ASM
-#endif
 
 /*
 	Thanks to Brian Antoine for the example code in his Messy-Loss ST-01
@@ -535,9 +533,6 @@
 #ifdef PARITY
 		" PARITY"
 #endif
-#ifdef SEAGATE_USE_ASM
-		" SEAGATE_USE_ASM"
-#endif
 #ifdef SLOW_RATE
 		" SLOW_RATE"
 #endif
@@ -1134,32 +1129,7 @@
 						 SCint->transfersize, len,
 						 data);
 
-			/* SJT: Start. Fast Write */
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
-/* SJT: End */
 					len -= transfersize;
 					data += transfersize;
 					DPRINTK (DEBUG_FAST, "scsi%d : FAST transfer complete len = %d data = %08x\n", hostno, len, data);
@@ -1170,50 +1140,6 @@
 					 *    send, and BSY is still active.
 					 */
 
-/* SJT: Start. Slow Write. */
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
 
@@ -1227,8 +1153,6 @@
 							--len;
 						}
 					}
-#endif				/* SEAGATE_USE_ASM */
-/* SJT: End. */
 				}
 
 				if (!len && nobuffs) {
@@ -1272,32 +1196,7 @@
 						 SCint->transfersize, len,
 						 data);
 
-/* SJT: Start. Fast Read */
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
-/* SJT: End */
 					len -= transfersize;
 					data += transfersize;
 #if (DEBUG & PHASE_DATAIN)
@@ -1319,53 +1218,6 @@
  *      and BSY is still active
  */
 
-/* SJT: Start. */
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
 
@@ -1379,8 +1231,6 @@
 							--len;
 						}
 					}
-#endif				/* SEAGATE_USE_ASM */
-/* SJT: End. */
 #if (DEBUG & PHASE_DATAIN)
 					printk ("scsi%d: transfered -= %d\n", hostno, len);
 					transfered -= len;	/* Since we assumed all of Len got  *
diff -ru ./linux-2.6.9-orig/drivers/serial/8250.c ./linux-2.6.9/drivers/serial/8250.c
--- ./linux-2.6.9-orig/drivers/serial/8250.c	2005-03-31 16:26:47.000000000 +0400
+++ ./linux-2.6.9/drivers/serial/8250.c	2005-03-31 17:05:44.000000000 +0400
@@ -782,14 +782,8 @@
 		 */
 		scratch = serial_inp(up, UART_IER);
 		serial_outp(up, UART_IER, 0);
-#ifdef __i386__
-		outb(0xff, 0x080);
-#endif
 		scratch2 = serial_inp(up, UART_IER);
 		serial_outp(up, UART_IER, 0x0F);
-#ifdef __i386__
-		outb(0, 0x080);
-#endif
 		scratch3 = serial_inp(up, UART_IER);
 		serial_outp(up, UART_IER, scratch);
 		if (scratch2 != 0 || scratch3 != 0x0F) {
diff -ru ./linux-2.6.9-orig/drivers/serial/8250.h ./linux-2.6.9/drivers/serial/8250.h
--- ./linux-2.6.9-orig/drivers/serial/8250.h	2005-03-31 16:26:46.000000000 +0400
+++ ./linux-2.6.9/drivers/serial/8250.h	2005-03-31 17:05:22.000000000 +0400
@@ -52,15 +52,7 @@
 
 #undef SERIAL_DEBUG_PCI
 
-#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
-#define SERIAL_INLINE
-#endif
-  
-#ifdef SERIAL_INLINE
-#define _INLINE_ inline
-#else
 #define _INLINE_
-#endif
 
 #define PROBE_RSA	(1 << 0)
 #define PROBE_ANY	(~0)
diff -ru ./linux-2.6.9-orig/drivers/serial/sunsu.c ./linux-2.6.9/drivers/serial/sunsu.c
--- ./linux-2.6.9-orig/drivers/serial/sunsu.c	2005-03-31 16:26:47.000000000 +0400
+++ ./linux-2.6.9/drivers/serial/sunsu.c	2005-03-31 17:05:55.000000000 +0400
@@ -1151,14 +1151,8 @@
 		 */
 		scratch = serial_inp(up, UART_IER);
 		serial_outp(up, UART_IER, 0);
-#ifdef __i386__
-		outb(0xff, 0x080);
-#endif
 		scratch2 = serial_inp(up, UART_IER);
 		serial_outp(up, UART_IER, 0x0f);
-#ifdef __i386__
-		outb(0, 0x080);
-#endif
 		scratch3 = serial_inp(up, UART_IER);
 		serial_outp(up, UART_IER, scratch);
 		if (scratch2 != 0 || scratch3 != 0x0F)
diff -ru ./linux-2.6.9-orig/drivers/usb/core/devices.c ./linux-2.6.9/drivers/usb/core/devices.c
--- ./linux-2.6.9-orig/drivers/usb/core/devices.c	2005-03-31 16:26:49.000000000 +0400
+++ ./linux-2.6.9/drivers/usb/core/devices.c	2005-03-31 17:06:33.000000000 +0400
@@ -473,7 +473,7 @@
 	
 	if (level > MAX_TOPO_LEVEL)
 		return total_written;
-	/* allocate 2^1 pages = 8K (on i386); should be more than enough for one device */
+	/* allocate 2^1 pages = 8K (on the normal arch); should be more than enough for one device */
         if (!(pages_start = (char*) __get_free_pages(GFP_KERNEL,1)))
                 return -ENOMEM;
 		
diff -ru ./linux-2.6.9-orig/drivers/usb/media/ov511.c ./linux-2.6.9/drivers/usb/media/ov511.c
--- ./linux-2.6.9-orig/drivers/usb/media/ov511.c	2005-03-31 16:26:47.000000000 +0400
+++ ./linux-2.6.9/drivers/usb/media/ov511.c	2005-03-31 17:06:11.000000000 +0400
@@ -47,10 +47,6 @@
 #include <linux/mm.h>
 #include <linux/device.h>
 
-#if defined (__i386__)
-	#include <asm/cpufeature.h>
-#endif
-
 #include "ov511.h"
 
 /*
@@ -214,7 +210,7 @@
 static int i2c_detect_tries = 5;
 
 /* MMX support is present in kernel and CPU. Checked upon decomp module load. */
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__x86_64__)
 #define ov51x_mmx_available (cpu_has_mmx)
 #else
 #define ov51x_mmx_available (0)
diff -ru ./linux-2.6.9-orig/drivers/video/aty/atyfb_base.c ./linux-2.6.9/drivers/video/aty/atyfb_base.c
--- ./linux-2.6.9-orig/drivers/video/aty/atyfb_base.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/aty/atyfb_base.c	2005-03-31 17:21:40.000000000 +0400
@@ -2988,287 +2988,6 @@
 
 #else /* __sparc__ */
 
-#ifdef __i386__
-#ifdef CONFIG_FB_ATY_GENERIC_LCD
-void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
-{
-	u32 driv_inf_tab, sig;
-	u16 lcd_ofs;
-
-	/* To support an LCD panel, we should know it's dimensions and
-	 *  it's desired pixel clock.
-	 * There are two ways to do it:
-	 *  - Check the startup video mode and calculate the panel
-	 *    size from it. This is unreliable.
-	 *  - Read it from the driver information table in the video BIOS.
-	*/
-	/* Address of driver information table is at offset 0x78. */
-	driv_inf_tab = bios_base + *((u16 *)(bios_base+0x78));
-
-	/* Check for the driver information table signature. */
-	sig = (*(u32 *)driv_inf_tab);
-	if ((sig == 0x54504c24) || /* Rage LT pro */
-		(sig == 0x544d5224) || /* Rage mobility */
-		(sig == 0x54435824) || /* Rage XC */
-		(sig == 0x544c5824)) { /* Rage XL */
-		PRINTKI("BIOS contains driver information table.\n");
-		lcd_ofs = (*(u16 *)(driv_inf_tab + 10));
-		par->lcd_table = 0;
-		if (lcd_ofs != 0) {
-			par->lcd_table = bios_base + lcd_ofs;
-		}
-	}
-
-	if (par->lcd_table != 0) {
-		char model[24];
-		char strbuf[16];
-		char refresh_rates_buf[100];
-		int id, tech, f, i, m, default_refresh_rate;
-		char *txtcolour;
-		char *txtmonitor;
-		char *txtdual;
-		char *txtformat;
-		u16 width, height, panel_type, refresh_rates;
-		u16 *lcdmodeptr;
-		u32 format;
-		u8 lcd_refresh_rates[16] = {50,56,60,67,70,72,75,76,85,90,100,120,140,150,160,200};
-		/* The most important information is the panel size at
-		 * offset 25 and 27, but there's some other nice information
-		 * which we print to the screen.
-		 */
-		id = *(u8 *)par->lcd_table;
-		strncpy(model,(char *)par->lcd_table+1,24);
-		model[23]=0;
-
-		width = par->lcd_width = *(u16 *)(par->lcd_table+25);
-		height = par->lcd_height = *(u16 *)(par->lcd_table+27);
-		panel_type = *(u16 *)(par->lcd_table+29);
-		if (panel_type & 1)
-			txtcolour = "colour";
-		else
-			txtcolour = "monochrome";
-		if (panel_type & 2)
-			txtdual = "dual (split) ";
-		else
-			txtdual = "";
-		tech = (panel_type>>2) & 63;
-		switch (tech) {
-		case 0:
-			txtmonitor = "passive matrix";
-			break;
-		case 1:
-			txtmonitor = "active matrix";
-			break;
-		case 2:
-			txtmonitor = "active addressed STN";
-			break;
-		case 3:
-			txtmonitor = "EL";
-			break;
-		case 4:
-			txtmonitor = "plasma";
-			break;
-		default:
-			txtmonitor = "unknown";
-		}
-		format = *(u32 *)(par->lcd_table+57);
-		if (tech == 0 || tech == 2) {
-			switch (format & 7) {
-			case 0:
-				txtformat = "12 bit interface";
-				break;
-			case 1:
-				txtformat = "16 bit interface";
-				break;
-			case 2:
-				txtformat = "24 bit interface";
-				break;
-			default:
-				txtformat = "unkown format";
-			}
-		} else {
-			switch (format & 7) {
-			case 0:
-				txtformat = "8 colours";
-				break;
-			case 1:
-				txtformat = "512 colours";
-				break;
-			case 2:
-				txtformat = "4096 colours";
-				break;
-			case 4:
-				txtformat = "262144 colours (LT mode)";
-				break;
-			case 5:
-				txtformat = "16777216 colours";
-				break;
-			case 6:
-				txtformat = "262144 colours (FDPI-2 mode)";
-				break;
-			default:
-				txtformat = "unkown format";
-			}
-		}
-		PRINTKI("%s%s %s monitor detected: %s\n",
-			txtdual ,txtcolour, txtmonitor, model);
-		PRINTKI("       id=%d, %dx%d pixels, %s\n",
-			id, width, height, txtformat);
-		refresh_rates_buf[0] = 0;
-		refresh_rates = *(u16 *)(par->lcd_table+62);
-		m = 1;
-		f = 0;
-		for (i=0;i<16;i++) {
-			if (refresh_rates & m) {
-				if (f == 0) {
-					sprintf(strbuf, "%d", lcd_refresh_rates[i]);
-					f++;
-				} else {
-					sprintf(strbuf, ",%d", lcd_refresh_rates[i]);
-				}
-				strcat(refresh_rates_buf,strbuf);
-			}
-			m = m << 1;
-		}
-		default_refresh_rate = (*(u8 *)(par->lcd_table+61) & 0xf0) >> 4;
-		PRINTKI("       supports refresh rates [%s], default %d Hz\n",
-			refresh_rates_buf, lcd_refresh_rates[default_refresh_rate]);
-		par->lcd_refreshrate = lcd_refresh_rates[default_refresh_rate];
-		/* We now need to determine the crtc parameters for the
-		 * lcd monitor. This is tricky, because they are not stored
-		 * individually in the BIOS. Instead, the BIOS contains a
-		 * table of display modes that work for this monitor.
-		 *
-		 * The idea is that we search for a mode of the same dimensions
-		 * as the dimensions of the lcd monitor. Say our lcd monitor
-		 * is 800x600 pixels, we search for a 800x600 monitor.
-		 * The CRTC parameters we find here are the ones that we need
-		 * to use to simulate other resolutions on the lcd screen.
-		 */
-		lcdmodeptr = (u16 *)(par->lcd_table + 64);
-		while (*lcdmodeptr != 0) {
-			u32 modeptr;
-			u16 mwidth, mheight, lcd_hsync_start, lcd_vsync_start;
-			modeptr = bios_base + *lcdmodeptr;
-
-			mwidth = *((u16 *)(modeptr+0));
-			mheight = *((u16 *)(modeptr+2));
-
-			if (mwidth == width && mheight == height) {
-				par->lcd_pixclock = 100000000 / *((u16 *)(modeptr+9));
-				par->lcd_htotal = *((u16 *)(modeptr+17)) & 511;
-				par->lcd_hdisp = *((u16 *)(modeptr+19)) & 511;
-				lcd_hsync_start = *((u16 *)(modeptr+21)) & 511;
-				par->lcd_hsync_dly = (*((u16 *)(modeptr+21)) >> 9) & 7;
-				par->lcd_hsync_len = *((u8 *)(modeptr+23)) & 63;
-
-				par->lcd_vtotal = *((u16 *)(modeptr+24)) & 2047;
-				par->lcd_vdisp = *((u16 *)(modeptr+26)) & 2047;
-				lcd_vsync_start = *((u16 *)(modeptr+28)) & 2047;
-				par->lcd_vsync_len = (*((u16 *)(modeptr+28)) >> 11) & 31;
-
-				par->lcd_htotal = (par->lcd_htotal + 1) * 8;
-				par->lcd_hdisp = (par->lcd_hdisp + 1) * 8;
-				lcd_hsync_start = (lcd_hsync_start + 1) * 8;
-				par->lcd_hsync_len = par->lcd_hsync_len * 8;
-
-				par->lcd_vtotal++;
-				par->lcd_vdisp++;
-				lcd_vsync_start++;
-
-				par->lcd_right_margin = lcd_hsync_start - par->lcd_hdisp;
-				par->lcd_lower_margin = lcd_vsync_start - par->lcd_vdisp;
-				par->lcd_hblank_len = par->lcd_htotal - par->lcd_hdisp;
-				par->lcd_vblank_len = par->lcd_vtotal - par->lcd_vdisp;
-				break;
-			}
-
-			lcdmodeptr++;
-		}
-		if (*lcdmodeptr == 0) {
-			PRINTKE("LCD monitor CRTC parameters not found!!!\n");
-			/* To do: Switch to CRT if possible. */
-		} else {
-			PRINTKI("       LCD CRTC parameters: %d.%d  %d %d %d %d  %d %d %d %d\n",
-				1000000 / par->lcd_pixclock, 1000000 % par->lcd_pixclock,
-				par->lcd_hdisp,
-				par->lcd_hdisp + par->lcd_right_margin,
-				par->lcd_hdisp + par->lcd_right_margin
-					+ par->lcd_hsync_dly + par->lcd_hsync_len,
-				par->lcd_htotal,
-				par->lcd_vdisp,
-				par->lcd_vdisp + par->lcd_lower_margin,
-				par->lcd_vdisp + par->lcd_lower_margin + par->lcd_vsync_len,
-				par->lcd_vtotal);
-			PRINTKI("                          : %d %d %d %d %d %d %d %d %d\n",
-				par->lcd_pixclock,
-				par->lcd_hblank_len - (par->lcd_right_margin +
-					par->lcd_hsync_dly + par->lcd_hsync_len),
-				par->lcd_hdisp,
-				par->lcd_right_margin,
-				par->lcd_hsync_len,
-				par->lcd_vblank_len - (par->lcd_lower_margin + par->lcd_vsync_len),
-				par->lcd_vdisp,
-				par->lcd_lower_margin,
-				par->lcd_vsync_len);
-		}
-	}
-}
-#endif /* CONFIG_FB_ATY_GENERIC_LCD */
-
-static int __devinit init_from_bios(struct atyfb_par *par)
-{
-	u32 bios_base, rom_addr;
-	int ret;
-
-	rom_addr = 0xc0000 + ((aty_ld_le32(SCRATCH_REG1, par) & 0x7f) << 11);
-	bios_base = (unsigned long)ioremap(rom_addr, 0x10000);
-
-	/* The BIOS starts with 0xaa55. */
-	if (*((u16 *)bios_base) == 0xaa55) {
-
-		u8 *bios_ptr;
-		u16 rom_table_offset, freq_table_offset;
-		PLL_BLOCK_MACH64 pll_block;
-
-		PRINTKI("Mach64 BIOS is located at %x, mapped at %x.\n", rom_addr, bios_base);
-
-		/* check for frequncy table */
-		bios_ptr = (u8*)bios_base;
-		rom_table_offset = (u16)(bios_ptr[0x48] | (bios_ptr[0x49] << 8));
-		freq_table_offset = bios_ptr[rom_table_offset + 16] | (bios_ptr[rom_table_offset + 17] << 8);
-		memcpy(&pll_block, bios_ptr + freq_table_offset, sizeof(PLL_BLOCK_MACH64));
-
-		PRINTKI("BIOS frequency table:\n");
-		PRINTKI("PCLK_min_freq %d, PCLK_max_freq %d, ref_freq %d, ref_divider %d\n",
-			pll_block.PCLK_min_freq, pll_block.PCLK_max_freq,
-			pll_block.ref_freq, pll_block.ref_divider);
-		PRINTKI("MCLK_pwd %d, MCLK_max_freq %d, XCLK_max_freq %d, SCLK_freq %d\n",
-			pll_block.MCLK_pwd, pll_block.MCLK_max_freq,
-			pll_block.XCLK_max_freq, pll_block.SCLK_freq);
-
-		par->pll_limits.pll_min = pll_block.PCLK_min_freq/100;
-		par->pll_limits.pll_max = pll_block.PCLK_max_freq/100;
-		par->pll_limits.ref_clk = pll_block.ref_freq/100;
-		par->pll_limits.ref_div = pll_block.ref_divider;
-		par->pll_limits.sclk = pll_block.SCLK_freq/100;
-		par->pll_limits.mclk = pll_block.MCLK_max_freq/100;
-		par->pll_limits.mclk_pm = pll_block.MCLK_pwd/100;
-		par->pll_limits.xclk = pll_block.XCLK_max_freq/100;
-#ifdef CONFIG_FB_ATY_GENERIC_LCD
-		aty_init_lcd(par, bios_base);
-#endif
-		ret = 0;
-	} else {
-		PRINTKE("no BIOS frequency table found, use parameters\n");
-		ret = -ENXIO;
-	}
-	iounmap((void* __iomem )bios_base);
-
-	return ret;
-}
-#endif /* __i386__ */
-
 static int __devinit atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info, unsigned long addr)
 {
 	struct atyfb_par *par = info->par;
@@ -3318,10 +3037,6 @@
 
 	if((ret = correct_chipset(par)))
 		goto atyfb_setup_generic_fail;
-#ifdef __i386__
-	if((ret = init_from_bios(par)))
-		goto atyfb_setup_generic_fail;
-#endif
 	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
 		par->clk_wr_offset = (inb(R_GENMO) & 0x0CU) >> 2;
 	else
diff -ru ./linux-2.6.9-orig/drivers/video/cg6.c ./linux-2.6.9/drivers/video/cg6.c
--- ./linux-2.6.9-orig/drivers/video/cg6.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/cg6.c	2005-03-31 16:42:24.000000000 +0400
@@ -562,7 +562,7 @@
 		cg6_cpu_name = "68020";
 		break;
 	default:
-		cg6_cpu_name = "i386";
+		cg6_cpu_name = "m68k";
 		break;
 	};
 	if (((conf >> CG6_FHC_REV_SHIFT) & CG6_FHC_REV_MASK) >= 11) {
diff -ru ./linux-2.6.9-orig/drivers/video/console/sticore.c ./linux-2.6.9/drivers/video/console/sticore.c
--- ./linux-2.6.9-orig/drivers/video/console/sticore.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/console/sticore.c	2005-03-31 16:41:17.000000000 +0400
@@ -834,7 +834,7 @@
 		i = __raw_readl(address+0x04);
 		if (i != 1) {
 			/* The ROM could have multiple architecture 
-			 * dependent images (e.g. i386, parisc,...) */
+			 * dependent images (e.g. parisc,...) */
 			printk(KERN_WARNING 
 				"PCI ROM is not a STI ROM type image (0x%8x)\n", i);
 			goto out_err;
diff -ru ./linux-2.6.9-orig/drivers/video/fbmem.c ./linux-2.6.9/drivers/video/fbmem.c
--- ./linux-2.6.9-orig/drivers/video/fbmem.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/fbmem.c	2005-03-31 16:37:43.000000000 +0400
@@ -961,7 +961,7 @@
 	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE|_PAGE_GUARDED;
 #elif defined(__alpha__)
 	/* Caching is off in the I/O space quadrant by design.  */
-#elif defined(__i386__) || defined(__x86_64__)
+#elif defined(__x86_64__)
 	if (boot_cpu_data.x86 > 3)
 		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 #elif defined(__mips__)
diff -ru ./linux-2.6.9-orig/drivers/video/matrox/matroxfb_base.h ./linux-2.6.9/drivers/video/matrox/matroxfb_base.h
--- ./linux-2.6.9-orig/drivers/video/matrox/matroxfb_base.h	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/matrox/matroxfb_base.h	2005-03-31 16:41:00.000000000 +0400
@@ -156,7 +156,7 @@
 }
 
 static inline void mga_memcpy_toio(vaddr_t va, const void* src, int len) {
-#if defined(__alpha__) || defined(__i386__) || defined(__x86_64__)
+#if defined(__alpha__) || defined(__x86_64__)
 	/*
 	 * memcpy_toio works for us if:
 	 *  (1) Copies data as 32bit quantities, not byte after byte,
diff -ru ./linux-2.6.9-orig/drivers/video/radeonfb.c ./linux-2.6.9/drivers/video/radeonfb.c
--- ./linux-2.6.9-orig/drivers/video/radeonfb.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/radeonfb.c	2005-03-31 16:43:14.000000000 +0400
@@ -713,67 +713,6 @@
 
 static void __iomem *radeon_find_rom(struct radeonfb_info *rinfo)
 {       
-#if defined(__i386__)
-        u32  segstart;
-        char __iomem *rom_base;
-        char __iomem *rom;
-        int  stage;
-        int  i,j;       
-        char aty_rom_sig[] = "761295520";
-        char *radeon_sig[] = {
-          "RG6",
-          "RADEON"
-        };
-                                                
-        for(segstart=0x000c0000; segstart<0x000f0000; segstart+=0x00001000) {
-                        
-                stage = 1;
-                
-                rom_base = ioremap(segstart, 0x1000);
-
-                if ((*rom_base == 0x55) && (((*(rom_base + 1)) & 0xff) == 0xaa))
-                        stage = 2;
-                
-                    
-                if (stage != 2) {
-                        iounmap(rom_base);
-                        continue;
-                }
-                                              
-                rom = rom_base;
-                     
-                for (i = 0; (i < 128 - strlen(aty_rom_sig)) && (stage != 3); i++) {
-                        if (aty_rom_sig[0] == *rom)
-                                if (strncmp(aty_rom_sig, rom,
-                                                strlen(aty_rom_sig)) == 0)
-                                        stage = 3;
-                        rom++;
-                }
-                if (stage != 3) {
-                        iounmap(rom_base);
-                        continue;
-                }
-                rom = rom_base;
-        
-                for (i = 0; (i < 512) && (stage != 4); i++) {
-                    for(j = 0;j < sizeof(radeon_sig)/sizeof(char *);j++) {
-                        if (radeon_sig[j][0] == *rom)
-                                if (strncmp(radeon_sig[j], rom,
-                                            strlen(radeon_sig[j])) == 0) {
-                                              stage = 4;
-                                              break;
-                                            }
-                    }                           
-                        rom++;
-                }       
-                if (stage != 4) {
-                        iounmap(rom_base);
-                        continue;
-                }       
-                
-                return rom_base;
-        }
-#endif          
         return NULL;
 }
 
diff -ru ./linux-2.6.9-orig/drivers/video/sgivwfb.c ./linux-2.6.9/drivers/video/sgivwfb.c
--- ./linux-2.6.9-orig/drivers/video/sgivwfb.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/sgivwfb.c	2005-03-31 16:42:54.000000000 +0400
@@ -40,7 +40,6 @@
  *  The default can be overridden if the driver is compiled as a module
  */
 
-/* set by arch/i386/kernel/setup.c */
 extern unsigned long sgivwfb_mem_phys;
 extern unsigned long sgivwfb_mem_size;
 
diff -ru ./linux-2.6.9-orig/drivers/video/sis/init.c ./linux-2.6.9/drivers/video/sis/init.c
--- ./linux-2.6.9-orig/drivers/video/sis/init.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/sis/init.c	2005-03-31 16:38:45.000000000 +0400
@@ -3455,7 +3455,7 @@
    SiSRegInit(SiS_Pr, BaseAddr);
    SiS_GetSysFlags(SiS_Pr, HwInfo);
 
-#if defined(LINUX_XF86) && (defined(i386) || defined(__i386) || defined(__i386__) || defined(__AMD64__))
+#if defined(LINUX_XF86) && defined(__AMD64__)
    if(pScrn) SiS_Pr->SiS_VGAINFO = SiS_GetSetBIOSScratch(pScrn, 0x489, 0xff);
    else
 #endif
@@ -3680,7 +3680,7 @@
    SiSRegInit(SiS_Pr, BaseAddr);
    SiSInitPtr(SiS_Pr, HwInfo);
    SiS_GetSysFlags(SiS_Pr, HwInfo);
-#if (defined(i386) || defined(__i386) || defined(__i386__) || defined(__AMD64__))
+#if defined(__AMD64__)
    SiS_Pr->SiS_VGAINFO = SiS_GetSetBIOSScratch(pScrn, 0x489, 0xff);
 #else
    SiS_Pr->SiS_VGAINFO = 0x11;
@@ -3860,7 +3860,7 @@
    SiSInitPtr(SiS_Pr, HwInfo);
    SiSRegInit(SiS_Pr, BaseAddr);
    SiS_GetSysFlags(SiS_Pr, HwInfo);
-#if (defined(i386) || defined(__i386) || defined(__i386__) || defined(__AMD64__))
+#if defined(__AMD64__)
    SiS_Pr->SiS_VGAINFO = SiS_GetSetBIOSScratch(pScrn, 0x489, 0xff);
 #else
    SiS_Pr->SiS_VGAINFO = 0x11;
diff -ru ./linux-2.6.9-orig/drivers/video/sis/sis_main.c ./linux-2.6.9/drivers/video/sis/sis_main.c
--- ./linux-2.6.9-orig/drivers/video/sis/sis_main.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/sis/sis_main.c	2005-03-31 16:40:07.000000000 +0400
@@ -138,7 +138,7 @@
 	sisfb_inverse   	= 0;
 	sisfb_fontname[0] 	= 0;
 #endif
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 	sisfb_resetcard 	= 0;
 	sisfb_videoram  	= 0;
 #endif
@@ -263,7 +263,7 @@
 static void __devinit
 sisfb_get_vga_mode_from_kernel(void)
 {
-#if (defined(__i386__) || defined(__x86_64__)) && defined(CONFIG_VIDEO_SELECT)
+#if defined(__x86_64__) && defined(CONFIG_VIDEO_SELECT)
    	char mymode[32];
 	int  mydepth = screen_info.lfb_depth;
 
@@ -3954,7 +3954,7 @@
 		        }
 		} else if(this_opt[0] >= '0' && this_opt[0] <= '9') {
 			sisfb_search_mode(this_opt, TRUE);
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 	        } else if(!strnicmp(this_opt, "resetcard", 9)) {
 		  	sisfb_resetcard = 1;
 	        } else if(!strnicmp(this_opt, "videoram:", 9)) {
@@ -3983,7 +3983,7 @@
 
 	if(!(myrombase = vmalloc(65536))) return NULL;
 
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__x86_64__)
 
         for(temp = 0x000c0000; temp < 0x000f0000; temp += 0x00001000) {
 
@@ -4324,7 +4324,7 @@
 	reg &= 0xc3;
 	outSISIDXREG(SISCR,0x35,reg);
 	outSISIDXREG(SISCR,0x83,0x00);
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 	if(sisfb_videoram) {
 	   outSISIDXREG(SISSR,0x13,0x28);  /* ? */
 	   reg = ((sisfb_videoram >> 10) - 1) | 0x40;
@@ -4341,7 +4341,7 @@
 	      outSISIDXREG(SISSR,0x13,0x28);  /* ? */
 	      outSISIDXREG(SISSR,0x14,0x47);  /* 8MB, 64bit default */
 	   }
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 	}
 #endif
 	if(ivideo->sishw_ext.UseROM) {
@@ -4967,7 +4967,7 @@
         outSISIDXREG(SISSR, 0x05, 0x86);
 
 	if( (!sisvga_enabled)
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 		  	      || (sisfb_resetcard)
 #endif
 			      			   ) {
@@ -4982,7 +4982,7 @@
 	if(reg & 0x7f) {
 		ivideo->modeprechange = reg & 0x7f;
 	} else if(sisvga_enabled) {
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__x86_64__)
 		unsigned char SIS_IOTYPE2 *tt = ioremap(0, 0x1000);
 		if(tt) {
 		   	ivideo->modeprechange = readb(tt + 0x449);
@@ -5089,7 +5089,7 @@
 #ifdef CONFIG_FB_SIS_300
 	if(ivideo->sisvga_engine == SIS_300_VGA) {
 		if( (!sisvga_enabled)
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 		    		      || (sisfb_resetcard)
 #endif
 		  					   ) {
@@ -5103,7 +5103,7 @@
 #ifdef CONFIG_FB_SIS_315
 	if(ivideo->sisvga_engine == SIS_315_VGA) {
 		if( (!sisvga_enabled)
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 		    		     || (sisfb_resetcard)
 #endif
 		  					  ) {
@@ -5733,7 +5733,7 @@
 static int	    lvdshl = -1;
 static int	    tvxposoffset = 0, tvyposoffset = 0;
 static int	    filter = -1;
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 static int	    resetcard = 0;
 static int	    videoram = 0;
 #endif
@@ -5765,7 +5765,7 @@
 MODULE_PARM(filter, "i");
 MODULE_PARM(nocrt2rate, "i");
 MODULE_PARM(inverse, "i");
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 MODULE_PARM(resetcard, "i");
 MODULE_PARM(videoram, "i");
 #endif
@@ -5793,7 +5793,7 @@
 module_param(tvyposoffset, int, 0);
 module_param(filter, int, 0);
 module_param(nocrt2rate, int, 0);
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 module_param(resetcard, int, 0);
 module_param(videoram, int, 0);
 #endif
@@ -5925,7 +5925,7 @@
 	  "does not seem to work. (default: 0)\n");
 #endif
 
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 #ifdef CONFIG_FB_SIS_300
 MODULE_PARM_DESC(resetcard,
 	"\nSet this to 1 in order to reset (POST) the card on non-x86 machines where\n"
@@ -6001,7 +6001,7 @@
 	sisfb_tvxposoffset = tvxposoffset;
 	sisfb_tvyposoffset = tvyposoffset;
 
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
  	sisfb_resetcard = (resetcard) ? 1 : 0;
 	if(videoram)    sisfb_videoram = videoram;
 #endif
diff -ru ./linux-2.6.9-orig/drivers/video/sis/sis_main.h ./linux-2.6.9/drivers/video/sis/sis_main.h
--- ./linux-2.6.9-orig/drivers/video/sis/sis_main.h	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/sis/sis_main.h	2005-03-31 16:38:00.000000000 +0400
@@ -99,7 +99,7 @@
 static int  sisfb_inverse = 0;
 static char sisfb_fontname[40];
 #endif
-#if !defined(__i386__) && !defined(__x86_64__)
+#if !defined(__x86_64__)
 static int sisfb_resetcard = 0;
 static int sisfb_videoram = 0;
 #endif
diff -ru ./linux-2.6.9-orig/drivers/video/vesafb.c ./linux-2.6.9/drivers/video/vesafb.c
--- ./linux-2.6.9-orig/drivers/video/vesafb.c	2005-03-31 16:26:36.000000000 +0400
+++ ./linux-2.6.9/drivers/video/vesafb.c	2005-03-31 16:42:03.000000000 +0400
@@ -1,9 +1,6 @@
 /*
  * framebuffer driver for VBE 2.0 compliant graphic boards
  *
- * switching to graphics mode happens at boot time (while
- * running in real mode, see arch/i386/boot/video.S).
- *
  * (c) 1998 Gerd Knorr <kraxel@goldbach.in-berlin.de>
  *
  */
@@ -19,9 +16,6 @@
 #include <linux/fb.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
-#ifdef __i386__
-#include <video/edid.h>
-#endif
 #include <asm/io.h>
 #include <asm/mtrr.h>
 
@@ -63,61 +57,12 @@
 static int vesafb_pan_display(struct fb_var_screeninfo *var,
                               struct fb_info *info)
 {
-#ifdef __i386__
-	int offset;
-
-	if (!ypan)
-		return -EINVAL;
-	if (var->xoffset)
-		return -EINVAL;
-	if (var->yoffset > var->yres_virtual)
-		return -EINVAL;
-	if ((ypan==1) && var->yoffset+var->yres > var->yres_virtual)
-		return -EINVAL;
-
-	offset = (var->yoffset * info->fix.line_length + var->xoffset) / 4;
-
-        __asm__ __volatile__(
-                "call *(%%edi)"
-                : /* no return value */
-                : "a" (0x4f07),         /* EAX */
-                  "b" (0),              /* EBX */
-                  "c" (offset),         /* ECX */
-                  "d" (offset >> 16),   /* EDX */
-                  "D" (&pmi_start));    /* EDI */
-#endif
 	return 0;
 }
 
 static void vesa_setpalette(int regno, unsigned red, unsigned green,
 			    unsigned blue)
 {
-#ifdef __i386__
-	struct { u_char blue, green, red, pad; } entry;
-	int shift = 16 - depth;
-
-	if (pmi_setpal) {
-		entry.red   = red   >> shift;
-		entry.green = green >> shift;
-		entry.blue  = blue  >> shift;
-		entry.pad   = 0;
-	        __asm__ __volatile__(
-                "call *(%%esi)"
-                : /* no return value */
-                : "a" (0x4f09),         /* EAX */
-                  "b" (0),              /* EBX */
-                  "c" (1),              /* ECX */
-                  "d" (regno),          /* EDX */
-                  "D" (&entry),         /* EDI */
-                  "S" (&pmi_pal));      /* ESI */
-	} else {
-		/* without protected mode interface, try VGA registers... */
-		outb_p(regno,       dac_reg);
-		outb_p(red   >> shift, dac_val);
-		outb_p(green >> shift, dac_val);
-		outb_p(blue  >> shift, dac_val);
-	}
-#endif
 }
 
 static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
@@ -268,10 +213,6 @@
 		size_remap = size_total;
 	vesafb_fix.smem_len = size_remap;
 
-#ifndef __i386__
-	screen_info.vesapm_seg = 0;
-#endif
-
 	if (!request_mem_region(vesafb_fix.smem_start, size_total, "vesafb")) {
 		printk(KERN_WARNING
 		       "vesafb: abort, cannot reserve video memory at 0x%lx\n",
diff -ru ./linux-2.6.9-orig/fs/binfmt_aout.c ./linux-2.6.9/fs/binfmt_aout.c
--- ./linux-2.6.9-orig/fs/binfmt_aout.c	2005-03-31 16:27:26.000000000 +0400
+++ ./linux-2.6.9/fs/binfmt_aout.c	2005-03-31 17:34:04.000000000 +0400
@@ -102,7 +102,7 @@
 #	define START_DATA(u)	((u.u_tsize << PAGE_SHIFT) + u.start_code)
 #elif defined(__sparc__)
 #       define START_DATA(u)    (u.u_tsize)
-#elif defined(__i386__) || defined(__mc68000__) || defined(__arch_um__)
+#elif defined(__mc68000__) || defined(__arch_um__)
 #       define START_DATA(u)	(u.u_tsize << PAGE_SHIFT)
 #endif
 #ifdef __sparc__
@@ -232,7 +232,7 @@
 	envp = (char __user * __user *) sp;
 	sp -= argc+1;
 	argv = (char __user * __user *) sp;
-#if defined(__i386__) || defined(__mc68000__) || defined(__arm__) || defined(__arch_um__)
+#if defined(__mc68000__) || defined(__arm__) || defined(__arch_um__)
 	put_user((unsigned long) envp,--sp);
 	put_user((unsigned long) argv,--sp);
 #endif
diff -ru ./linux-2.6.9-orig/fs/binfmt_elf_fdpic.c ./linux-2.6.9/fs/binfmt_elf_fdpic.c
--- ./linux-2.6.9-orig/fs/binfmt_elf_fdpic.c	2005-03-31 16:27:27.000000000 +0400
+++ ./linux-2.6.9/fs/binfmt_elf_fdpic.c	2005-03-31 17:34:44.000000000 +0400
@@ -480,20 +480,6 @@
 
 	u_platform = (char *) sp;
 
-#if defined(__i386__) && defined(CONFIG_SMP)
-	/* in some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
-	 * by the processes running on the same package. One thing we can do
-	 * is to shuffle the initial stack for them.
-	 *
-	 * the conditionals here are unneeded, but kept in to make the
-	 * code behaviour the same as pre change unless we have hyperthreaded
-	 * processors. This keeps Mr Marcelo Person happier but should be
-	 * removed for 2.5
-	 */
-	if (smp_num_siblings > 1)
-		sp = sp - ((current->pid % 64) << 7);
-#endif
-
 	sp &= ~7UL;
 
 	/* stack the load map(s) */
diff -ru ./linux-2.6.9-orig/fs/ncpfs/ncpsign_kernel.c ./linux-2.6.9/fs/ncpfs/ncpsign_kernel.c
--- ./linux-2.6.9-orig/fs/ncpfs/ncpsign_kernel.c	2005-03-31 16:27:26.000000000 +0400
+++ ./linux-2.6.9/fs/ncpfs/ncpsign_kernel.c	2005-03-31 17:33:08.000000000 +0400
@@ -15,11 +15,6 @@
 
 #define rol32(i,c) (((((i)&0xffffffff)<<c)&0xffffffff)| \
                     (((i)&0xffffffff)>>(32-c)))
-/* i386: 32-bit, little endian, handles mis-alignment */
-#ifdef __i386__
-#define GET_LE32(p) (*(int *)(p))
-#define PUT_LE32(p,v) { *(int *)(p)=v; }
-#else
 /* from include/ncplib.h */
 #define BVAL(buf,pos) (((__u8 *)(buf))[pos])
 #define PVAL(buf,pos) ((unsigned)BVAL(buf,pos))
@@ -50,19 +45,14 @@
 
 #define GET_LE32(p) DVAL_LH(p,0)
 #define PUT_LE32(p,v) DSET_LH(p,0,v)
-#endif
 
 static void nwsign(char *r_data1, char *r_data2, char *outdata) {
  int i;
  unsigned int w0,w1,w2,w3;
  static int rbit[4]={0, 2, 1, 3};
-#ifdef __i386__
- unsigned int *data2=(int *)r_data2;
-#else
  unsigned int data2[16];
  for (i=0;i<16;i++)
   data2[i]=GET_LE32(r_data2+(i<<2));
-#endif 
  w0=GET_LE32(r_data1);
  w1=GET_LE32(r_data1+4);
  w2=GET_LE32(r_data1+8);
diff -ru ./linux-2.6.9-orig/fs/open.c ./linux-2.6.9/fs/open.c
--- ./linux-2.6.9-orig/fs/open.c	2005-03-31 16:27:26.000000000 +0400
+++ ./linux-2.6.9/fs/open.c	2005-03-31 17:33:36.000000000 +0400
@@ -964,8 +964,7 @@
 #ifndef __alpha__
 
 /*
- * For backward compatibility?  Maybe this should be moved
- * into arch/i386 instead?
+ * For backward compatibility? 
  */
 asmlinkage long sys_creat(const char __user * pathname, int mode)
 {
diff -ru ./linux-2.6.9-orig/fs/stat.c ./linux-2.6.9/fs/stat.c
--- ./linux-2.6.9-orig/fs/stat.c	2005-03-31 16:27:26.000000000 +0400
+++ ./linux-2.6.9/fs/stat.c	2005-03-31 17:33:46.000000000 +0400
@@ -110,8 +110,7 @@
 #ifdef __ARCH_WANT_OLD_STAT
 
 /*
- * For backward compatibility?  Maybe this should be moved
- * into arch/i386 instead?
+ * For backward compatibility?
  */
 static int cp_old_stat(struct kstat *stat, struct __old_kernel_stat __user * statbuf)
 {
diff -ru ./linux-2.6.9-orig/fs/xfs/linux-2.6/xfs_linux.h ./linux-2.6.9/fs/xfs/linux-2.6/xfs_linux.h
--- ./linux-2.6.9-orig/fs/xfs/linux-2.6/xfs_linux.h	2005-03-31 16:27:23.000000000 +0400
+++ ./linux-2.6.9/fs/xfs/linux-2.6/xfs_linux.h	2005-03-31 17:32:40.000000000 +0400
@@ -260,67 +260,6 @@
 
 /* Move the kernel do_div definition off to one side */
 
-#if defined __i386__
-/* For ia32 we need to pull some tricks to get past various versions
- * of the compiler which do not like us using do_div in the middle
- * of large functions.
- */
-static inline __u32 xfs_do_div(void *a, __u32 b, int n)
-{
-	__u32	mod;
-
-	switch (n) {
-		case 4:
-			mod = *(__u32 *)a % b;
-			*(__u32 *)a = *(__u32 *)a / b;
-			return mod;
-		case 8:
-			{
-			unsigned long __upper, __low, __high, __mod;
-			__u64	c = *(__u64 *)a;
-			__upper = __high = c >> 32;
-			__low = c;
-			if (__high) {
-				__upper = __high % (b);
-				__high = __high / (b);
-			}
-			asm("divl %2":"=a" (__low), "=d" (__mod):"rm" (b), "0" (__low), "1" (__upper));
-			asm("":"=A" (c):"a" (__low),"d" (__high));
-			*(__u64 *)a = c;
-			return __mod;
-			}
-	}
-
-	/* NOTREACHED */
-	return 0;
-}
-
-/* Side effect free 64 bit mod operation */
-static inline __u32 xfs_do_mod(void *a, __u32 b, int n)
-{
-	switch (n) {
-		case 4:
-			return *(__u32 *)a % b;
-		case 8:
-			{
-			unsigned long __upper, __low, __high, __mod;
-			__u64	c = *(__u64 *)a;
-			__upper = __high = c >> 32;
-			__low = c;
-			if (__high) {
-				__upper = __high % (b);
-				__high = __high / (b);
-			}
-			asm("divl %2":"=a" (__low), "=d" (__mod):"rm" (b), "0" (__low), "1" (__upper));
-			asm("":"=A" (c):"a" (__low),"d" (__high));
-			return __mod;
-			}
-	}
-
-	/* NOTREACHED */
-	return 0;
-}
-#else
 static inline __u32 xfs_do_div(void *a, __u32 b, int n)
 {
 	__u32	mod;
@@ -355,7 +294,6 @@
 	/* NOTREACHED */
 	return 0;
 }
-#endif
 
 #undef do_div
 #define do_div(a, b)	xfs_do_div(&(a), (b), sizeof(a))
diff -ru ./linux-2.6.9-orig/Makefile ./linux-2.6.9/Makefile
--- ./linux-2.6.9-orig/Makefile	2005-03-31 16:27:40.000000000 +0400
+++ ./linux-2.6.9/Makefile	2005-03-31 16:34:43.000000000 +0400
@@ -166,7 +166,7 @@
 # then ARCH is assigned, getting whatever value it gets normally, and 
 # SUBARCH is subsequently ignored.
 
-SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
+SUBARCH := $(shell uname -m | sed -e s/i.86/x86_64/ -e s/sun4u/sparc64/ \
 				  -e s/arm.*/arm/ -e s/sa110/arm/ \
 				  -e s/s390x/s390/ -e s/parisc64/parisc/ )
 
diff -ru ./linux-2.6.9-orig/net/ipv4/netfilter/ip_conntrack_core.c ./linux-2.6.9/net/ipv4/netfilter/ip_conntrack_core.c
--- ./linux-2.6.9-orig/net/ipv4/netfilter/ip_conntrack_core.c	2005-03-31 16:27:27.000000000 +0400
+++ ./linux-2.6.9/net/ipv4/netfilter/ip_conntrack_core.c	2005-03-31 17:35:02.000000000 +0400
@@ -1151,7 +1151,7 @@
 	unsigned int i;
 	int ret;
 
-	/* Idea from tcp.c: use 1/16384 of memory.  On i386: 32MB
+	/* Idea from tcp.c: use 1/16384 of memory.  On normal machine: 32MB
 	 * machine has 256 buckets.  >= 1GB machines have 8192 buckets. */
  	if (hashsize) {
  		ip_conntrack_htable_size = hashsize;
diff -ru ./linux-2.6.9-orig/scripts/genksyms/parse.c_shipped ./linux-2.6.9/scripts/genksyms/parse.c_shipped
--- ./linux-2.6.9-orig/scripts/genksyms/parse.c_shipped	2005-03-31 16:27:31.000000000 +0400
+++ ./linux-2.6.9/scripts/genksyms/parse.c_shipped	2005-03-31 17:35:36.000000000 +0400
@@ -476,7 +476,7 @@
 #define YYSTACK_USE_ALLOCA
 #define alloca __builtin_alloca
 #else /* not GNU C.  */
-#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi) || (defined (__sun) && defined (__i386))
+#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi) || (defined (__sun))
 #define YYSTACK_USE_ALLOCA
 #include <alloca.h>
 #else /* not sparc */
diff -ru ./linux-2.6.9-orig/scripts/namespace.pl ./linux-2.6.9/scripts/namespace.pl
--- ./linux-2.6.9-orig/scripts/namespace.pl	2005-03-31 16:27:31.000000000 +0400
+++ ./linux-2.6.9/scripts/namespace.pl	2005-03-31 17:36:10.000000000 +0400
@@ -105,7 +105,6 @@
 	if (/.*\.o$/ &&
 		! (
 		m:/built-in.o$:
-		|| m:arch/i386/kernel/vsyscall-syms.o$:
 		|| m:arch/ia64/ia32/ia32.o$:
 		|| m:arch/ia64/kernel/gate-syms.o$:
 		|| m:arch/ia64/lib/__divdi3.o$:
@@ -326,13 +325,6 @@
 				&drop_def("kernel/sys.o", $name);
 				next;
 			}
-			# Special case for i386 entry code
-			if ($#{$def{$name}} == 1 && $name =~ /^__kernel_/ &&
-			    $def{$name}[0] eq "arch/i386/kernel/vsyscall-int80.o" &&
-			    $def{$name}[1] eq "arch/i386/kernel/vsyscall-sysenter.o") {
-				&drop_def("arch/i386/kernel/vsyscall-sysenter.o", $name);
-				next;
-			}
 			printf "$name is multiply defined in :-\n";
 			foreach $module (@{$def{$name}}) {
 				printf "\t$module\n";

