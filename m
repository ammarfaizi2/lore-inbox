Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318786AbSHLR7f>; Mon, 12 Aug 2002 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318787AbSHLR7f>; Mon, 12 Aug 2002 13:59:35 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:37270
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S318786AbSHLR71>; Mon, 12 Aug 2002 13:59:27 -0400
Date: Mon, 12 Aug 2002 11:03:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cleanup (BIN|BCD)_TO_(BCD|BIN) usage/macros
Message-ID: <20020812180308.GH9603@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now there's a bit of a mess with all of the BIN_TO_BCD/BCD_TO_BIN
macros in the kernel.  It's defined in a half dozen places, and worse
yet, not all places use them the same way.  Most users do something
like:
if ( ... )
   BIN_TO_BCD(x);

But in a few places, it's used as:
if ( ... )
   y = BIN_TO_BCD(x);

The following creates include/linux/bcd.h which has the 'normal'
BIN_TO_BCD macros, as well as CONVERT_{BIN,BCD}_TO_{BCD,BIN}, which are
for the second case.  This patch removes all other defines, adds
<linux/bcd.h> to <linux/mc146818rtc.h> for compatibility, and adds
<linux/bcd.h> directly to anything which was implicitly including
<linux/mc146818rtc.h> before.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/arm/kernel/time.c 1.8 vs edited =====
--- 1.8/arch/arm/kernel/time.c	Sat Aug  3 06:39:48 2002
+++ edited/arch/arm/kernel/time.c	Wed Aug  7 11:32:12 2002
@@ -47,14 +47,6 @@
 /* change this if you have some constant time drift */
 #define USECS_PER_JIFFY	(1000000/HZ)
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 static int dummy_set_rtc(void)
 {
 	return 0;
===== arch/cris/drivers/ds1302.c 1.3 vs edited =====
--- 1.3/arch/cris/drivers/ds1302.c	Tue Feb  5 08:24:37 2002
+++ edited/arch/cris/drivers/ds1302.c	Wed Aug  7 11:32:12 2002
@@ -97,6 +97,7 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/delay.h>
+#include <linux/bcd.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
===== arch/cris/kernel/time.c 1.6 vs edited =====
--- 1.6/arch/cris/kernel/time.c	Sun Jun 16 17:39:47 2002
+++ edited/arch/cris/kernel/time.c	Wed Aug  7 11:32:12 2002
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/delay.h>
+#include <linux/bcd.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
===== arch/m68k/sun3x/time.c 1.3 vs edited =====
--- 1.3/arch/m68k/sun3x/time.c	Sun Feb 24 05:50:59 2002
+++ edited/arch/m68k/sun3x/time.c	Wed Aug  7 11:33:14 2002
@@ -11,6 +11,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
 #include <linux/rtc.h>
+#include <linux/bcd.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -36,9 +37,6 @@
 #define C_SIGN    0x20
 #define C_CALIB   0x1f
 
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-#define BIN_TO_BCD(val) (((val/10) << 4) | (val % 10))
-
 int sun3x_hwclk(int set, struct rtc_time *t)
 {
 	volatile struct mostek_dt *h = 
@@ -49,23 +47,23 @@
 	
 	if(set) {
 		h->csr |= C_WRITE;
-		h->sec = BIN_TO_BCD(t->tm_sec);
-		h->min = BIN_TO_BCD(t->tm_min);
-		h->hour = BIN_TO_BCD(t->tm_hour);
-		h->wday = BIN_TO_BCD(t->tm_wday);
-		h->mday = BIN_TO_BCD(t->tm_mday);
-		h->month = BIN_TO_BCD(t->tm_mon);
-		h->year = BIN_TO_BCD(t->tm_year);
+		h->sec = CONVERT_BIN_TO_BCD(t->tm_sec);
+		h->min = CONVERT_BIN_TO_BCD(t->tm_min);
+		h->hour = CONVERT_BIN_TO_BCD(t->tm_hour);
+		h->wday = CONVERT_BIN_TO_BCD(t->tm_wday);
+		h->mday = CONVERT_BIN_TO_BCD(t->tm_mday);
+		h->month = CONVERT_BIN_TO_BCD(t->tm_mon);
+		h->year = CONVERT_BIN_TO_BCD(t->tm_year);
 		h->csr &= ~C_WRITE;
 	} else {
 		h->csr |= C_READ;
-		t->tm_sec = BCD_TO_BIN(h->sec);
-		t->tm_min = BCD_TO_BIN(h->min);
-		t->tm_hour = BCD_TO_BIN(h->hour);
-		t->tm_wday = BCD_TO_BIN(h->wday);
-		t->tm_mday = BCD_TO_BIN(h->mday);
-		t->tm_mon = BCD_TO_BIN(h->month);
-		t->tm_year = BCD_TO_BIN(h->year);
+		t->tm_sec = CONVERT_BCD_TO_BIN(h->sec);
+		t->tm_min = CONVERT_BCD_TO_BIN(h->min);
+		t->tm_hour = CONVERT_BCD_TO_BIN(h->hour);
+		t->tm_wday = CONVERT_BCD_TO_BIN(h->wday);
+		t->tm_mday = CONVERT_BCD_TO_BIN(h->mday);
+		t->tm_mon = CONVERT_BCD_TO_BIN(h->month);
+		t->tm_year = CONVERT_BCD_TO_BIN(h->year);
 		h->csr &= ~C_READ;
 	}
 
===== arch/mips/ddb5xxx/common/rtc_ds1386.c 1.1 vs edited =====
--- 1.1/arch/mips/ddb5xxx/common/rtc_ds1386.c	Tue Feb  5 13:17:17 2002
+++ edited/arch/mips/ddb5xxx/common/rtc_ds1386.c	Wed Aug  7 11:33:47 2002
@@ -20,6 +20,7 @@
 
 #include <linux/types.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
 
 #include <asm/time.h>
 #include <asm/addrspace.h>
@@ -28,12 +29,6 @@
 
 #define	EPOCH		2000
 
-#undef BCD_TO_BIN
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-
-#undef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
-
 #define	READ_RTC(x)	*(volatile unsigned char*)(rtc_base+x)
 #define	WRITE_RTC(x, y)	*(volatile unsigned char*)(rtc_base+x) = y
 
@@ -52,11 +47,11 @@
 	WRITE_RTC(0xB, byte);
 
 	/* read time data */
-	year = BCD_TO_BIN(READ_RTC(0xA)) + EPOCH;
-	month = BCD_TO_BIN(READ_RTC(0x9) & 0x1f);
-	day = BCD_TO_BIN(READ_RTC(0x8));
-	minute = BCD_TO_BIN(READ_RTC(0x2));
-	second = BCD_TO_BIN(READ_RTC(0x1));
+	year = CONVERT_BCD_TO_BIN(READ_RTC(0xA)) + EPOCH;
+	month = CONVERT_BCD_TO_BIN(READ_RTC(0x9) & 0x1f);
+	day = CONVERT_BCD_TO_BIN(READ_RTC(0x8));
+	minute = CONVERT_BCD_TO_BIN(READ_RTC(0x2));
+	second = CONVERT_BCD_TO_BIN(READ_RTC(0x1));
 
 	/* hour is special - deal with it later */
 	temp = READ_RTC(0x4);
@@ -68,11 +63,11 @@
 	/* calc hour */
 	if (temp & 0x40) {
 		/* 12 hour format */
-		hour = BCD_TO_BIN(temp & 0x1f);
+		hour = CONVERT_BCD_TO_BIN(temp & 0x1f);
 		if (temp & 0x20) hour += 12; 		/* PM */
 	} else {
 		/* 24 hour format */
-		hour = BCD_TO_BIN(temp & 0x3f);
+		hour = CONVERT_BCD_TO_BIN(temp & 0x3f);
 	}
 
 	return mktime(year, month, day, hour, minute, second);
@@ -95,19 +90,19 @@
 	to_tm(t, &tm);
 
 	/* check each field one by one */
-	year = BIN_TO_BCD(tm.tm_year - EPOCH);
+	year = CONVERT_BIN_TO_BCD(tm.tm_year - EPOCH);
 	if (year != READ_RTC(0xA)) {
 		WRITE_RTC(0xA, year);
 	}
 
 	temp = READ_RTC(0x9);
-	month = BIN_TO_BCD(tm.tm_mon);
+	month = CONVERT_BIN_TO_BCD(tm.tm_mon);
 	if (month != (temp & 0x1f)) {
 		WRITE_RTC( 0x9,
 			   (month & 0x1f) | (temp & ~0x1f) );
 	}
 
-	day = BIN_TO_BCD(tm.tm_mday);
+	day = CONVERT_BIN_TO_BCD(tm.tm_mday);
 	if (day != READ_RTC(0x8)) {
 		WRITE_RTC(0x8, day);
 	}
@@ -117,22 +112,22 @@
 		/* 12 hour format */
 		hour = 0x40;
 		if (tm.tm_hour > 12) {
-			hour |= 0x20 | (BIN_TO_BCD(hour-12) & 0x1f);
+			hour |= 0x20 | (CONVERT_BIN_TO_BCD(hour-12) & 0x1f);
 		} else {
-			hour |= BIN_TO_BCD(tm.tm_hour);
+			hour |= CONVERT_BIN_TO_BCD(tm.tm_hour);
 		}
 	} else {
 		/* 24 hour format */
-		hour = BIN_TO_BCD(tm.tm_hour) & 0x3f;
+		hour = CONVERT_BIN_TO_BCD(tm.tm_hour) & 0x3f;
 	}
 	if (hour != temp) WRITE_RTC(0x4, hour);
 
-	minute = BIN_TO_BCD(tm.tm_min);
+	minute = CONVERT_BIN_TO_BCD(tm.tm_min);
 	if (minute != READ_RTC(0x2)) {
 		WRITE_RTC(0x2, minute);
 	}
 
-	second = BIN_TO_BCD(tm.tm_sec);
+	second = CONVERT_BIN_TO_BCD(tm.tm_sec);
 	if (second != READ_RTC(0x1)) {
 		WRITE_RTC(0x1, second);
 	}
===== arch/mips64/sgi-ip27/ip27-rtc.c 1.4 vs edited =====
--- 1.4/arch/mips64/sgi-ip27/ip27-rtc.c	Thu May 23 09:06:16 2002
+++ edited/arch/mips64/sgi-ip27/ip27-rtc.c	Wed Aug  7 11:32:16 2002
@@ -35,6 +35,7 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/bcd.h>
 
 #include <asm/m48t35.h>
 #include <asm/sn/ioc3.h>
===== arch/mips64/sgi-ip27/ip27-timer.c 1.2 vs edited =====
--- 1.2/arch/mips64/sgi-ip27/ip27-timer.c	Tue Feb  5 00:45:04 2002
+++ edited/arch/mips64/sgi-ip27/ip27-timer.c	Wed Aug  7 11:32:16 2002
@@ -11,6 +11,7 @@
 #include <linux/param.h>
 #include <linux/timex.h>
 #include <linux/mm.h>		
+#include <linux/bcd.h>
 
 #include <asm/pgtable.h>
 #include <asm/sgialib.h>
===== arch/ppc/iSeries/mf.c 1.2 vs edited =====
--- 1.2/arch/ppc/iSeries/mf.c	Sun Jun  2 23:49:59 2002
+++ edited/arch/ppc/iSeries/mf.c	Mon Aug 12 08:23:19 2002
@@ -40,6 +40,7 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/uaccess.h>
 #include <linux/pci.h>
+#include <linux/bcd.h>
 
 
 /*
===== arch/ppc/kernel/todc_time.c 1.1 vs edited =====
--- 1.1/arch/ppc/kernel/todc_time.c	Sun Feb 10 04:20:03 2002
+++ edited/arch/ppc/kernel/todc_time.c	Mon Aug 12 08:23:36 2002
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <linux/bcd.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
===== arch/ppc/platforms/gemini_setup.c 1.11 vs edited =====
--- 1.11/arch/ppc/platforms/gemini_setup.c	Mon May 27 08:05:50 2002
+++ edited/arch/ppc/platforms/gemini_setup.c	Wed Aug  7 11:38:35 2002
@@ -27,6 +27,7 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/bcd.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
===== arch/ppc/platforms/prep_time.c 1.6 vs edited =====
--- 1.6/arch/ppc/platforms/prep_time.c	Sun Feb 10 04:41:25 2002
+++ edited/arch/ppc/platforms/prep_time.c	Wed Aug  7 11:38:51 2002
@@ -22,6 +22,7 @@
 #include <linux/timex.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
 
 #include <asm/sections.h>
 #include <asm/segment.h>
===== arch/ppc64/kernel/mf.c 1.2 vs edited =====
--- 1.2/arch/ppc64/kernel/mf.c	Wed Apr 24 21:46:36 2002
+++ edited/arch/ppc64/kernel/mf.c	Wed Aug  7 11:32:17 2002
@@ -40,6 +40,7 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/uaccess.h>
 #include <linux/pci.h>
+#include <linux/bcd.h>
 
 extern struct pci_dev * iSeries_vio_dev;
 
===== arch/sh/kernel/rtc.c 1.5 vs edited =====
--- 1.5/arch/sh/kernel/rtc.c	Tue Feb  5 08:24:41 2002
+++ edited/arch/sh/kernel/rtc.c	Wed Aug  7 11:32:17 2002
@@ -9,17 +9,10 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
 
 #include <asm/io.h>
 #include <asm/rtc.h>
-
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
 
 void sh_rtc_gettimeofday(struct timeval *tv)
 {
===== arch/sparc64/kernel/time.c 1.13 vs edited =====
--- 1.13/arch/sparc64/kernel/time.c	Mon Jul 22 12:54:56 2002
+++ edited/arch/sparc64/kernel/time.c	Fri Aug  2 13:01:06 2002
@@ -312,14 +312,6 @@
 	return (data1 == data2);	/* Was the write blocked? */
 }
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
-#endif
-
 /* Probe for the real time clock chip. */
 static void __init set_system_time(void)
 {
===== drivers/scsi/sr_vendor.c 1.5 vs edited =====
--- 1.5/drivers/scsi/sr_vendor.c	Thu Mar  7 11:34:09 2002
+++ edited/drivers/scsi/sr_vendor.c	Wed Aug  7 11:32:19 2002
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/bcd.h>
 
 #include <linux/blk.h>
 #include "scsi.h"
@@ -148,8 +149,6 @@
 /* This function gets called after a media change. Checks if the CD is
    multisession, asks for offset etc. */
 
-#define BCD_TO_BIN(x)    ((((int)x & 0xf0) >> 4)*10 + ((int)x & 0x0f))
-
 int sr_cd_check(struct cdrom_device_info *cdi)
 {
 	Scsi_CD *SCp = cdi->handle;
@@ -214,9 +213,9 @@
 				no_multi = 1;
 				break;
 			}
-			min = BCD_TO_BIN(buffer[15]);
-			sec = BCD_TO_BIN(buffer[16]);
-			frame = BCD_TO_BIN(buffer[17]);
+			min = CONVERT_BCD_TO_BIN(buffer[15]);
+			sec = CONVERT_BCD_TO_BIN(buffer[16]);
+			frame = CONVERT_BCD_TO_BIN(buffer[17]);
 			sector = min * CD_SECS * CD_FRAMES + sec * CD_FRAMES + frame;
 			break;
 		}
@@ -240,9 +239,9 @@
 			}
 			if (rc != 0)
 				break;
-			min = BCD_TO_BIN(buffer[1]);
-			sec = BCD_TO_BIN(buffer[2]);
-			frame = BCD_TO_BIN(buffer[3]);
+			min = CONVERT_BCD_TO_BIN(buffer[1]);
+			sec = CONVERT_BCD_TO_BIN(buffer[2]);
+			frame = CONVERT_BCD_TO_BIN(buffer[3]);
 			sector = min * CD_SECS * CD_FRAMES + sec * CD_FRAMES + frame;
 			if (sector)
 				sector -= CD_MSF_OFFSET;
===== drivers/sgi/char/ds1286.c 1.4 vs edited =====
--- 1.4/drivers/sgi/char/ds1286.c	Tue Feb  5 00:44:52 2002
+++ edited/drivers/sgi/char/ds1286.c	Wed Aug  7 11:32:19 2002
@@ -36,6 +36,7 @@
 #include <linux/poll.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
+#include <linux/bcd.h>
 
 #include <asm/ds1286.h>
 #include <asm/io.h>
===== include/asm-cris/rtc.h 1.2 vs edited =====
--- 1.2/include/asm-cris/rtc.h	Tue Feb  5 00:40:14 2002
+++ edited/include/asm-cris/rtc.h	Wed Aug  7 11:32:19 2002
@@ -39,11 +39,6 @@
 #define RTC_INIT() (-1)
 #endif
 
-/* conversions to and from the stupid RTC internal format */
-
-#define BCD_TO_BIN(x) x = (((x & 0xf0) >> 3) * 5 + (x & 0xf))
-#define BIN_TO_BCD(x) x = (x % 10) | ((x / 10) << 4) 
-
 /*
  * The struct used to pass data via the following ioctl. Similar to the
  * struct tm in <time.h>, but it needs to be here so that the kernel 
===== include/asm-mips/ds1286.h 1.1 vs edited =====
--- 1.1/include/asm-mips/ds1286.h	Tue Feb  5 10:39:45 2002
+++ edited/include/asm-mips/ds1286.h	Wed Aug  7 11:32:19 2002
@@ -57,15 +57,4 @@
 #define RTC_IPSW		0x40
 #define RTC_TE			0x80
 
-/*
- * Conversion between binary and BCD.
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _ASM_DS1286_h */
===== include/asm-mips64/ds1286.h 1.2 vs edited =====
--- 1.2/include/asm-mips64/ds1286.h	Tue Feb  5 00:45:05 2002
+++ edited/include/asm-mips64/ds1286.h	Wed Aug  7 11:32:19 2002
@@ -56,15 +56,4 @@
 #define RTC_IPSW		0x40
 #define RTC_TE			0x80
 
-/*
- * Conversion between binary and BCD.
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _ASM_DS1286_h */
===== include/asm-mips64/m48t35.h 1.1 vs edited =====
--- 1.1/include/asm-mips64/m48t35.h	Tue Feb  5 10:39:55 2002
+++ edited/include/asm-mips64/m48t35.h	Wed Aug  7 11:32:19 2002
@@ -21,12 +21,4 @@
 #define M48T35_RTC_STOPPED  0x80
 #define M48T35_RTC_READ     0x40
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(x)   ((x)=((x)&15) + ((x)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(x)   ((x)=(((x)/10)<<4) + (x)%10)
-#endif
-
 #endif
===== include/asm-ppc/m48t35.h 1.3 vs edited =====
--- 1.3/include/asm-ppc/m48t35.h	Tue Feb  5 00:54:05 2002
+++ edited/include/asm-ppc/m48t35.h	Wed Aug  7 11:32:19 2002
@@ -76,14 +76,4 @@
 #define M48T35_RTC_STOPPED  0x80
 #define M48T35_RTC_READ     0x40
 
-
-/* read/write conversions */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(x)   ((x)=((x)&15) + ((x)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(x)   ((x)=(((x)/10)<<4) + (x)%10)
-#endif
-
 #endif
===== include/asm-ppc/mk48t59.h 1.2 vs edited =====
--- 1.2/include/asm-ppc/mk48t59.h	Tue Feb  5 00:40:23 2002
+++ edited/include/asm-ppc/mk48t59.h	Wed Aug  7 11:32:19 2002
@@ -27,12 +27,4 @@
 #define MK48T59_RTC_CONTROLB		0x1FF9
 #define MK48T59_RTC_CB_STOP		0x80
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _PPC_MK48T59_H */
===== include/asm-ppc/nvram.h 1.2 vs edited =====
--- 1.2/include/asm-ppc/nvram.h	Tue Feb  5 00:40:23 2002
+++ edited/include/asm-ppc/nvram.h	Wed Aug  7 11:32:19 2002
@@ -26,14 +26,6 @@
 #define MOTO_RTC_CONTROLA            0x1FF8
 #define MOTO_RTC_CONTROLB            0x1FF9
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 /* PowerMac specific nvram stuffs */
 
 enum {
===== include/asm-ppc/todc.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/todc.h	Sun Feb 10 03:45:43 2002
+++ edited/include/asm-ppc/todc.h	Wed Aug  7 11:41:08 2002
@@ -355,14 +355,6 @@
 	todc_info->flags         = clock_type ##_FLAGS;			\
 }
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 extern todc_info_t *todc_info;
 
 unsigned char todc_direct_read_val(int addr);
===== include/asm-ppc64/nvram.h 1.2 vs edited =====
--- 1.2/include/asm-ppc64/nvram.h	Fri Mar 15 19:14:30 2002
+++ edited/include/asm-ppc64/nvram.h	Wed Aug  7 11:32:19 2002
@@ -28,12 +28,4 @@
 #define MOTO_RTC_CONTROLA       0x1FF8
 #define MOTO_RTC_CONTROLB       0x1FF9
 
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _PPC64_NVRAM_H */
===== include/linux/mc146818rtc.h 1.2 vs edited =====
--- 1.2/include/linux/mc146818rtc.h	Tue Feb  5 00:45:03 2002
+++ edited/include/linux/mc146818rtc.h	Wed Aug  7 11:32:19 2002
@@ -14,6 +14,7 @@
 #include <asm/io.h>
 #include <linux/rtc.h>			/* get the user-level API */
 #include <linux/spinlock.h>		/* spinlock_t */
+#include <linux/bcd.h>			/* (BIN|BCD)_TO_(BCD|BIN) */
 #include <asm/mc146818rtc.h>		/* register access macros */
 
 extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
@@ -86,16 +87,5 @@
 #define RTC_VALID	RTC_REG_D
 # define RTC_VRT 0x80		/* valid RAM and time */
 /**********************************************************************/
-
-/* example: !(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY) 
- * determines if the following two #defines are needed
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=(((val)/10)<<4) + (val)%10)
-#endif
 
 #endif /* _MC146818RTC_H */
--- a/dev/null	1969-12-31 17:00:00.000000000 -0700
+++ b/include/linux/bcd.h	2002-08-07 11:28:11.000000000 -0700
@@ -0,0 +1,28 @@
+/*
+ * include/linux/bcd.h:	Macros to convert to/from Binary Coded Decimals.
+ *
+ * Originally in numerous files throughout the kernel.
+ *
+ * Author: Tom Rini
+ * 		trini@mvista.com
+ * Copyright 2002 MontaVista Software Inc.
+ *
+ * Please read the COPYING file for all license details.
+ */
+
+#ifndef __LINUX_BCD_H__
+#define __LINUX_BCD_H__
+
+/*
+ * Just convert the value, and don't change the original.
+ */
+#define CONVERT_BIN_TO_BCD(val) ((((val) / 10) << 4) + (val) % 10)
+#define CONVERT_BCD_TO_BIN(val) (((val) & 15) + ((val) >> 4) * 10)
+
+/* 
+ * Change the variable 'val' from one to the other.
+ */
+#define BIN_TO_BCD(val)		((val) = CONVERT_BIN_TO_BCD((val)))
+#define BCD_TO_BIN(val)		((val) = CONVERT_BCD_TO_BIN((val)))
+
+#endif /* __LINUX_BCD_H__ */
