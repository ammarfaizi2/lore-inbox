Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbVCXQMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVCXQMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVCXQMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:12:06 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:32727 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262847AbVCXQHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:07:25 -0500
Date: Fri, 25 Mar 2005 01:07:14 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc1-mm2] update VR41xx RTC support
Message-Id: <20050325010714.205e2ab1.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates NEC VR4100 series RTC support.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc1-mm2-orig/arch/mips/vr41xx/common/Makefile rc1-mm2/arch/mips/vr41xx/common/Makefile
--- rc1-mm2-orig/arch/mips/vr41xx/common/Makefile	Fri Mar 25 00:42:00 2005
+++ rc1-mm2/arch/mips/vr41xx/common/Makefile	Fri Mar 25 00:53:32 2005
@@ -2,7 +2,7 @@
 # Makefile for common code of the NEC VR4100 series.
 #
 
-obj-y				+= bcu.o cmu.o giu.o icu.o init.o int-handler.o ksyms.o pmu.o rtc.o
+obj-y				+= bcu.o cmu.o giu.o icu.o init.o int-handler.o pmu.o
 obj-$(CONFIG_VRC4173)		+= vrc4173.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -urN -X dontdiff rc1-mm2-orig/arch/mips/vr41xx/common/ksyms.c rc1-mm2/arch/mips/vr41xx/common/ksyms.c
--- rc1-mm2-orig/arch/mips/vr41xx/common/ksyms.c	Fri Mar 25 00:42:00 2005
+++ rc1-mm2/arch/mips/vr41xx/common/ksyms.c	Thu Jan  1 09:00:00 1970
@@ -1,30 +0,0 @@
-/*
- *   ksyms.c, Export NEC VR4100 series specific functions needed for loadable modules.
- *
- *  Copyright (C) 2003  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *  Copyright (C) 2005 Ralf Baechle (ralf@linux-mips.org)
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/module.h>
-
-#include <asm/vr41xx/vr41xx.h>
-
-EXPORT_SYMBOL(vr41xx_set_rtclong1_cycle);
-EXPORT_SYMBOL(vr41xx_read_rtclong1_counter);
-EXPORT_SYMBOL(vr41xx_set_rtclong2_cycle);
-EXPORT_SYMBOL(vr41xx_read_rtclong2_counter);
-EXPORT_SYMBOL(vr41xx_set_tclock_cycle);
-EXPORT_SYMBOL(vr41xx_read_tclock_counter);
diff -urN -X dontdiff rc1-mm2-orig/arch/mips/vr41xx/common/rtc.c rc1-mm2/arch/mips/vr41xx/common/rtc.c
--- rc1-mm2-orig/arch/mips/vr41xx/common/rtc.c	Wed Mar  2 16:38:34 2005
+++ rc1-mm2/arch/mips/vr41xx/common/rtc.c	Thu Jan  1 09:00:00 1970
@@ -1,321 +0,0 @@
-/*
- *  rtc.c, RTC(has only timer function) routines for NEC VR4100 series.
- *
- *  Copyright (C) 2003-2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/smp.h>
-#include <linux/types.h>
-
-#include <asm/io.h>
-#include <asm/time.h>
-#include <asm/vr41xx/vr41xx.h>
-
-static uint32_t rtc1_base;
-static uint32_t rtc2_base;
-
-static uint64_t previous_elapsedtime;
-static unsigned int remainder_per_sec;
-static unsigned int cycles_per_sec;
-static unsigned int cycles_per_jiffy;
-static unsigned long epoch_time;
-
-#define CYCLES_PER_JIFFY	(CLOCK_TICK_RATE / HZ)
-#define REMAINDER_PER_SEC	(CLOCK_TICK_RATE - (CYCLES_PER_JIFFY * HZ))
-#define CYCLES_PER_100USEC	((CLOCK_TICK_RATE + (10000 / 2)) / 10000)
-
-#define ETIMELREG_TYPE1		KSEG1ADDR(0x0b0000c0)
-#define TCLKLREG_TYPE1		KSEG1ADDR(0x0b0001c0)
-
-#define ETIMELREG_TYPE2		KSEG1ADDR(0x0f000100)
-#define TCLKLREG_TYPE2		KSEG1ADDR(0x0f000120)
-
-/* RTC 1 registers */
-#define ETIMELREG		0x00
-#define ETIMEMREG		0x02
-#define ETIMEHREG		0x04
-/* RFU */
-#define ECMPLREG		0x08
-#define ECMPMREG		0x0a
-#define ECMPHREG		0x0c
-/* RFU */
-#define RTCL1LREG		0x10
-#define RTCL1HREG		0x12
-#define RTCL1CNTLREG		0x14
-#define RTCL1CNTHREG		0x16
-#define RTCL2LREG		0x18
-#define RTCL2HREG		0x1a
-#define RTCL2CNTLREG		0x1c
-#define RTCL2CNTHREG		0x1e
-
-/* RTC 2 registers */
-#define TCLKLREG		0x00
-#define TCLKHREG		0x02
-#define TCLKCNTLREG		0x04
-#define TCLKCNTHREG		0x06
-/* RFU */
-#define RTCINTREG		0x1e
- #define TCLOCK_INT		0x08
- #define RTCLONG2_INT		0x04
- #define RTCLONG1_INT		0x02
- #define ELAPSEDTIME_INT	0x01
-
-#define read_rtc1(offset)	readw(rtc1_base + (offset))
-#define write_rtc1(val, offset)	writew((val), rtc1_base + (offset))
-
-#define read_rtc2(offset)	readw(rtc2_base + (offset))
-#define write_rtc2(val, offset)	writew((val), rtc2_base + (offset))
-
-static inline uint64_t read_elapsedtime_counter(void)
-{
-	uint64_t first, second;
-	uint32_t first_mid, first_low;
-	uint32_t second_mid, second_low;
-
-	do {
-		first_low = (uint32_t)read_rtc1(ETIMELREG);
-		first_mid = (uint32_t)read_rtc1(ETIMEMREG);
-		first = (uint64_t)read_rtc1(ETIMEHREG);
-		second_low = (uint32_t)read_rtc1(ETIMELREG);
-		second_mid = (uint32_t)read_rtc1(ETIMEMREG);
-		second = (uint64_t)read_rtc1(ETIMEHREG);
-	} while (first_low != second_low || first_mid != second_mid ||
-	         first != second);
-
-	return (first << 32) | (uint64_t)((first_mid << 16) | first_low);
-}
-
-static inline void write_elapsedtime_counter(uint64_t time)
-{
-	write_rtc1((uint16_t)time, ETIMELREG);
-	write_rtc1((uint16_t)(time >> 16), ETIMEMREG);
-	write_rtc1((uint16_t)(time >> 32), ETIMEHREG);
-}
-
-static inline void write_elapsedtime_compare(uint64_t time)
-{
-	write_rtc1((uint16_t)time, ECMPLREG);
-	write_rtc1((uint16_t)(time >> 16), ECMPMREG);
-	write_rtc1((uint16_t)(time >> 32), ECMPHREG);
-}
-
-void vr41xx_set_rtclong1_cycle(uint32_t cycles)
-{
-	write_rtc1((uint16_t)cycles, RTCL1LREG);
-	write_rtc1((uint16_t)(cycles >> 16), RTCL1HREG);
-}
-
-uint32_t vr41xx_read_rtclong1_counter(void)
-{
-	uint32_t first_high, first_low;
-	uint32_t second_high, second_low;
-
-	do {
-		first_low = (uint32_t)read_rtc1(RTCL1CNTLREG);
-		first_high = (uint32_t)read_rtc1(RTCL1CNTHREG);
-		second_low = (uint32_t)read_rtc1(RTCL1CNTLREG);
-		second_high = (uint32_t)read_rtc1(RTCL1CNTHREG);
-	} while (first_low != second_low || first_high != second_high);
-
-	return (first_high << 16) | first_low;
-}
-
-void vr41xx_set_rtclong2_cycle(uint32_t cycles)
-{
-	write_rtc1((uint16_t)cycles, RTCL2LREG);
-	write_rtc1((uint16_t)(cycles >> 16), RTCL2HREG);
-}
-
-uint32_t vr41xx_read_rtclong2_counter(void)
-{
-	uint32_t first_high, first_low;
-	uint32_t second_high, second_low;
-
-	do {
-		first_low = (uint32_t)read_rtc1(RTCL2CNTLREG);
-		first_high = (uint32_t)read_rtc1(RTCL2CNTHREG);
-		second_low = (uint32_t)read_rtc1(RTCL2CNTLREG);
-		second_high = (uint32_t)read_rtc1(RTCL2CNTHREG);
-	} while (first_low != second_low || first_high != second_high);
-
-	return (first_high << 16) | first_low;
-}
-
-void vr41xx_set_tclock_cycle(uint32_t cycles)
-{
-	write_rtc2((uint16_t)cycles, TCLKLREG);
-	write_rtc2((uint16_t)(cycles >> 16), TCLKHREG);
-}
-
-uint32_t vr41xx_read_tclock_counter(void)
-{
-	uint32_t first_high, first_low;
-	uint32_t second_high, second_low;
-
-	do {
-		first_low = (uint32_t)read_rtc2(TCLKCNTLREG);
-		first_high = (uint32_t)read_rtc2(TCLKCNTHREG);
-		second_low = (uint32_t)read_rtc2(TCLKCNTLREG);
-		second_high = (uint32_t)read_rtc2(TCLKCNTHREG);
-	} while (first_low != second_low || first_high != second_high);
-
-	return (first_high << 16) | first_low;
-}
-
-static void vr41xx_timer_ack(void)
-{
-	uint64_t cur;
-
-	write_rtc2(ELAPSEDTIME_INT, RTCINTREG);
-
-	previous_elapsedtime += (uint64_t)cycles_per_jiffy;
-	cycles_per_sec += cycles_per_jiffy;
-
-	if (cycles_per_sec >= CLOCK_TICK_RATE) {
-		cycles_per_sec = 0;
-		remainder_per_sec = REMAINDER_PER_SEC;
-	}
-
-	cycles_per_jiffy = 0;
-
-	do {
-		cycles_per_jiffy += CYCLES_PER_JIFFY;
-		if (remainder_per_sec > 0) {
-			cycles_per_jiffy++;
-			remainder_per_sec--;
-		}
-
-		cur = read_elapsedtime_counter();
-	} while (cur >= previous_elapsedtime + (uint64_t)cycles_per_jiffy);
-
-	write_elapsedtime_compare(previous_elapsedtime + (uint64_t)cycles_per_jiffy);
-}
-
-static void vr41xx_hpt_init(unsigned int count)
-{
-}
-
-static unsigned int vr41xx_hpt_read(void)
-{
-	uint64_t cur;
-
-	cur = read_elapsedtime_counter();
-
-	return (unsigned int)cur;
-}
-
-static unsigned long vr41xx_gettimeoffset(void)
-{
-	uint64_t cur;
-	unsigned long gap;
-
-	cur = read_elapsedtime_counter();
-	gap = (unsigned long)(cur - previous_elapsedtime);
-	gap = gap / CYCLES_PER_100USEC * 100;	/* usec */
-
-	return gap;
-}
-
-static unsigned long vr41xx_get_time(void)
-{
-	uint64_t counts;
-
-	counts = read_elapsedtime_counter();
-	counts >>= 15;
-
-	return epoch_time + (unsigned long)counts;
-
-}
-
-static int vr41xx_set_time(unsigned long sec)
-{
-	if (sec < epoch_time)
-		return -EINVAL;
-
-	sec -= epoch_time;
-
-	write_elapsedtime_counter((uint64_t)sec << 15);
-
-	return 0;
-}
-
-void vr41xx_set_epoch_time(unsigned long time)
-{
-	epoch_time = time;
-}
-
-static void __init vr41xx_time_init(void)
-{
-	switch (current_cpu_data.cputype) {
-	case CPU_VR4111:
-	case CPU_VR4121:
-		rtc1_base = ETIMELREG_TYPE1;
-		rtc2_base = TCLKLREG_TYPE1;
-		break;
-	case CPU_VR4122:
-	case CPU_VR4131:
-	case CPU_VR4133:
-		rtc1_base = ETIMELREG_TYPE2;
-		rtc2_base = TCLKLREG_TYPE2;
-		break;
-	default:
-		panic("Unexpected CPU of NEC VR4100 series");
-		break;
-	}
-
-	mips_timer_ack = vr41xx_timer_ack;
-
-	mips_hpt_init = vr41xx_hpt_init;
-	mips_hpt_read = vr41xx_hpt_read;
-	mips_hpt_frequency = CLOCK_TICK_RATE;
-
-	if (epoch_time == 0)
-		epoch_time = mktime(1970, 1, 1, 0, 0, 0);
-
-	rtc_get_time = vr41xx_get_time;
-	rtc_set_time = vr41xx_set_time;
-}
-
-static void __init vr41xx_timer_setup(struct irqaction *irq)
-{
-	do_gettimeoffset = vr41xx_gettimeoffset;
-
-	remainder_per_sec = REMAINDER_PER_SEC;
-	cycles_per_jiffy = CYCLES_PER_JIFFY;
-
-	if (remainder_per_sec > 0) {
-		cycles_per_jiffy++;
-		remainder_per_sec--;
-	}
-
-	previous_elapsedtime = read_elapsedtime_counter();
-	write_elapsedtime_compare(previous_elapsedtime + (uint64_t)cycles_per_jiffy);
-	write_rtc2(ELAPSEDTIME_INT, RTCINTREG);
-
-	setup_irq(ELAPSEDTIME_IRQ, irq);
-}
-
-static int __init vr41xx_rtc_init(void)
-{
-	board_time_init = vr41xx_time_init;
-	board_timer_setup = vr41xx_timer_setup;
-
-	return 0;
-}
-
-early_initcall(vr41xx_rtc_init);
diff -urN -X dontdiff rc1-mm2-orig/drivers/char/Kconfig rc1-mm2/drivers/char/Kconfig
--- rc1-mm2-orig/drivers/char/Kconfig	Fri Mar 25 00:43:19 2005
+++ rc1-mm2/drivers/char/Kconfig	Fri Mar 25 00:53:32 2005
@@ -779,6 +779,10 @@
 	  Samsung S3C2410. This can provide periodic interrupt rates
 	  from 1Hz to 64Hz for user programs, and wakeup from Alarm.
 
+config RTC_VR41XX
+	tristate "NEC VR4100 series Real Time Clock Support"
+	depends on CPU_VR41XX
+
 config COBALT_LCD
 	bool "Support for Cobalt LCD"
 	depends on MIPS_COBALT
diff -urN -X dontdiff rc1-mm2-orig/drivers/char/Makefile rc1-mm2/drivers/char/Makefile
--- rc1-mm2-orig/drivers/char/Makefile	Fri Mar 25 00:43:19 2005
+++ rc1-mm2/drivers/char/Makefile	Fri Mar 25 00:53:32 2005
@@ -64,6 +64,7 @@
 obj-$(CONFIG_SGI_IP27_RTC) += ip27-rtc.o
 obj-$(CONFIG_DS1302) += ds1302.o
 obj-$(CONFIG_S3C2410_RTC) += s3c2410-rtc.o
+obj-$(CONFIG_RTC_VR41XX) += vr41xx_rtc.o
 ifeq ($(CONFIG_GENERIC_NVRAM),y)
   obj-$(CONFIG_NVRAM) += generic_nvram.o
 else
diff -urN -X dontdiff rc1-mm2-orig/drivers/char/vr41xx_rtc.c rc1-mm2/drivers/char/vr41xx_rtc.c
--- rc1-mm2-orig/drivers/char/vr41xx_rtc.c	Thu Jan  1 09:00:00 1970
+++ rc1-mm2/drivers/char/vr41xx_rtc.c	Fri Mar 25 00:53:32 2005
@@ -0,0 +1,709 @@
+/*
+ *  Driver for NEC VR4100 series  Real Time Clock unit.
+ *
+ *  Copyright (C) 2003-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/mc146818rtc.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/rtc.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <asm/div64.h>
+#include <asm/io.h>
+#include <asm/time.h>
+#include <asm/uaccess.h>
+#include <asm/vr41xx/vr41xx.h>
+
+MODULE_AUTHOR("Yoichi Yuasa <yuasa@hh.iij4u.or.jp>");
+MODULE_DESCRIPTION("NEC VR4100 series RTC driver");
+MODULE_LICENSE("GPL");
+
+#define RTC1_TYPE1_START	0x0b0000c0UL
+#define RTC1_TYPE1_END		0x0b0000dfUL
+#define RTC2_TYPE1_START	0x0b0001c0UL
+#define RTC2_TYPE1_END		0x0b0001dfUL
+
+#define RTC1_TYPE2_START	0x0f000100UL
+#define RTC1_TYPE2_END		0x0f00011fUL
+#define RTC2_TYPE2_START	0x0f000120UL
+#define RTC2_TYPE2_END		0x0f00013fUL
+
+#define RTC1_SIZE		0x20
+#define RTC2_SIZE		0x20
+
+/* RTC 1 registers */
+#define ETIMELREG		0x00
+#define ETIMEMREG		0x02
+#define ETIMEHREG		0x04
+/* RFU */
+#define ECMPLREG		0x08
+#define ECMPMREG		0x0a
+#define ECMPHREG		0x0c
+/* RFU */
+#define RTCL1LREG		0x10
+#define RTCL1HREG		0x12
+#define RTCL1CNTLREG		0x14
+#define RTCL1CNTHREG		0x16
+#define RTCL2LREG		0x18
+#define RTCL2HREG		0x1a
+#define RTCL2CNTLREG		0x1c
+#define RTCL2CNTHREG		0x1e
+
+/* RTC 2 registers */
+#define TCLKLREG		0x00
+#define TCLKHREG		0x02
+#define TCLKCNTLREG		0x04
+#define TCLKCNTHREG		0x06
+/* RFU */
+#define RTCINTREG		0x1e
+ #define TCLOCK_INT		0x08
+ #define RTCLONG2_INT		0x04
+ #define RTCLONG1_INT		0x02
+ #define ELAPSEDTIME_INT	0x01
+
+#define RTC_FREQUENCY		32768
+#define MAX_PERIODIC_RATE	6553
+#define MAX_USER_PERIODIC_RATE	64
+
+static void __iomem *rtc1_base;
+static void __iomem *rtc2_base;
+
+#define rtc1_read(offset)		readw(rtc1_base + (offset))
+#define rtc1_write(offset, value)	writew((value), rtc1_base + (offset))
+
+#define rtc2_read(offset)		readw(rtc2_base + (offset))
+#define rtc2_write(offset, value)	writew((value), rtc2_base + (offset))
+
+static unsigned long epoch = 1970;	/* Jan 1 1970 00:00:00 */
+
+static spinlock_t rtc_task_lock;
+static wait_queue_head_t rtc_wait;
+static unsigned long rtc_irq_data;
+static struct fasync_struct *rtc_async_queue;
+static rtc_task_t *rtc_callback;
+static char rtc_name[] = "RTC";
+static unsigned long periodic_frequency;
+static unsigned long periodic_count;
+
+typedef enum {
+	RTC_RELEASE,
+	RTC_OPEN,
+} rtc_status_t;
+
+static rtc_status_t rtc_status;
+
+typedef enum {
+	FUNCTION_RTC_IOCTL,
+	FUNCTION_RTC_CONTROL,
+} rtc_callfrom_t;
+
+struct resource rtc_resource[2] = {
+	{	.name	= rtc_name,
+		.flags	= IORESOURCE_MEM,	},
+	{	.name	= rtc_name,
+		.flags	= IORESOURCE_MEM,	},
+};
+
+#define RTC_NUM_RESOURCES	sizeof(rtc_resource) / sizeof(struct resource)
+
+static inline unsigned long read_elapsed_second(void)
+{
+	unsigned long first_low, first_mid, first_high;
+	unsigned long second_low, second_mid, second_high;
+
+	do {
+		first_low = rtc1_read(ETIMELREG);
+		first_mid = rtc1_read(ETIMEMREG);
+		first_high = rtc1_read(ETIMEHREG);
+		second_low = rtc1_read(ETIMELREG);
+		second_mid = rtc1_read(ETIMEMREG);
+		second_high = rtc1_read(ETIMEHREG);
+	} while (first_low != second_low || first_mid != second_mid ||
+	         first_high != second_high);
+
+	return (first_high << 17) | (first_mid << 1) | (first_low >> 15);
+}
+
+static inline void write_elapsed_second(unsigned long sec)
+{
+	spin_lock_irq(&rtc_lock);
+
+	rtc1_write(ETIMELREG, (uint16_t)(sec << 15));
+	rtc1_write(ETIMEMREG, (uint16_t)(sec >> 1));
+	rtc1_write(ETIMEHREG, (uint16_t)(sec >> 17));
+
+	spin_unlock_irq(&rtc_lock);
+}
+
+static void set_alarm(struct rtc_time *time)
+{
+	unsigned long alarm_sec;
+
+	alarm_sec = mktime(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
+	                   time->tm_hour, time->tm_min, time->tm_sec);
+
+	spin_lock_irq(&rtc_lock);
+
+	rtc1_write(ECMPLREG, (uint16_t)(alarm_sec << 15));
+	rtc1_write(ECMPMREG, (uint16_t)(alarm_sec >> 1));
+	rtc1_write(ECMPHREG, (uint16_t)(alarm_sec >> 17));
+
+	spin_unlock_irq(&rtc_lock);
+}
+
+static void read_alarm(struct rtc_time *time)
+{
+	unsigned long low, mid, high;
+
+	spin_lock_irq(&rtc_lock);
+
+	low = rtc1_read(ECMPLREG);
+	mid = rtc1_read(ECMPMREG);
+	high = rtc1_read(ECMPHREG);
+
+	spin_unlock_irq(&rtc_lock);
+
+	to_tm((high << 17) | (mid << 1) | (low >> 15), time);
+	time->tm_year -= 1900;
+}
+
+static void read_time(struct rtc_time *time)
+{
+	unsigned long epoch_sec, elapsed_sec;
+
+	epoch_sec = mktime(epoch, 1, 1, 0, 0, 0);
+	elapsed_sec = read_elapsed_second();
+
+	to_tm(epoch_sec + elapsed_sec, time);
+	time->tm_year -= 1900;
+}
+
+static void set_time(struct rtc_time *time)
+{
+	unsigned long epoch_sec, current_sec;
+
+	epoch_sec = mktime(epoch, 1, 1, 0, 0, 0);
+	current_sec = mktime(time->tm_year + 1900, time->tm_mon + 1, time->tm_mday,
+	                     time->tm_hour, time->tm_min, time->tm_sec);
+
+	write_elapsed_second(current_sec - epoch_sec);
+}
+
+static ssize_t rtc_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	unsigned long irq_data;
+	int retval = 0;
+
+	if (count != sizeof(unsigned int) && count != sizeof(unsigned long))
+		return -EINVAL;
+
+	add_wait_queue(&rtc_wait, &wait);
+
+	do {
+		__set_current_state(TASK_INTERRUPTIBLE);
+
+		spin_lock_irq(&rtc_lock);
+		irq_data = rtc_irq_data;
+		rtc_irq_data = 0;
+		spin_unlock_irq(&rtc_lock);
+
+		if (irq_data != 0)
+			break;
+
+		if (file->f_flags & O_NONBLOCK) {
+			retval = -EAGAIN;
+			break;
+		}
+
+		if (signal_pending(current)) {
+			retval = -ERESTARTSYS;
+			break;
+		}
+	} while (1);
+
+	if (retval == 0) {
+		if (count == sizeof(unsigned int)) {
+			retval = put_user(irq_data, (unsigned int __user *)buf);
+			if (retval == 0)
+				retval = sizeof(unsigned int);
+		} else {
+			retval = put_user(irq_data, (unsigned long __user *)buf);
+			if (retval == 0)
+				retval = sizeof(unsigned long);
+		}
+
+	}
+
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&rtc_wait, &wait);
+
+	return retval;
+}
+
+static unsigned int rtc_poll(struct file *file, struct poll_table_struct *table)
+{
+	poll_wait(file, &rtc_wait, table);
+
+	if (rtc_irq_data != 0)
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, rtc_callfrom_t from)
+{
+	struct rtc_time time;
+	unsigned long count;
+
+	switch (cmd) {
+	case RTC_AIE_ON:
+		enable_irq(ELAPSEDTIME_IRQ);
+		break;
+	case RTC_AIE_OFF:
+		disable_irq(ELAPSEDTIME_IRQ);
+		break;
+	case RTC_PIE_ON:
+		enable_irq(RTCLONG1_IRQ);
+		break;
+	case RTC_PIE_OFF:
+		disable_irq(RTCLONG1_IRQ);
+		break;
+	case RTC_ALM_SET:
+		if (copy_from_user(&time, (struct rtc_time __user *)arg,
+		                   sizeof(struct rtc_time)))
+			return -EFAULT;
+
+		set_alarm(&time);
+		break;
+	case RTC_ALM_READ:
+		memset(&time, 0, sizeof(struct rtc_time));
+		read_alarm(&time);
+		break;
+	case RTC_RD_TIME:
+		memset(&time, 0, sizeof(struct rtc_time));
+		read_time(&time);
+		if (copy_to_user((void __user *)arg, &time, sizeof(struct rtc_time)))
+			return -EFAULT;
+		break;
+	case RTC_SET_TIME:
+		if (capable(CAP_SYS_TIME) == 0)
+			return -EACCES;
+
+		if (copy_from_user(&time, (struct rtc_time __user *)arg,
+		                   sizeof(struct rtc_time)))
+			return -EFAULT;
+
+		set_time(&time);
+		break;
+	case RTC_IRQP_READ:
+		return put_user(periodic_frequency, (unsigned long __user *)arg);
+		break;
+	case RTC_IRQP_SET:
+		if (arg > MAX_PERIODIC_RATE)
+			return -EINVAL;
+
+		if (from == FUNCTION_RTC_IOCTL && arg > MAX_USER_PERIODIC_RATE &&
+		    capable(CAP_SYS_RESOURCE) == 0)
+			return -EACCES;
+
+		periodic_frequency = arg;
+
+		count = RTC_FREQUENCY;
+		do_div(count, arg);
+
+		periodic_count = count;
+
+		spin_lock_irq(&rtc_lock);
+
+		rtc1_write(RTCL1LREG, count);
+		rtc1_write(RTCL1HREG, count >> 16);
+
+		spin_unlock_irq(&rtc_lock);
+		break;
+	case RTC_EPOCH_READ:
+		return put_user(epoch, (unsigned long __user *)arg);
+	case RTC_EPOCH_SET:
+		/* Doesn't support before 1900 */
+		if (arg < 1900)
+			return -EINVAL;
+
+		if (capable(CAP_SYS_TIME) == 0)
+			return -EACCES;
+
+		epoch = arg;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+                     unsigned long arg)
+{
+	return rtc_do_ioctl(cmd, arg, FUNCTION_RTC_IOCTL);
+}
+
+static int rtc_open(struct inode *inode, struct file *file)
+{
+	spin_lock_irq(&rtc_lock);
+	
+	if (rtc_status == RTC_OPEN) {
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+
+	rtc_status = RTC_OPEN;
+	rtc_irq_data = 0;
+
+	spin_unlock_irq(&rtc_lock);
+
+	return 0;
+}
+
+static int rtc_release(struct inode *inode, struct file *file)
+{
+	if (file->f_flags & FASYNC)
+		(void)fasync_helper(-1, file, 0, &rtc_async_queue);
+
+	spin_lock_irq(&rtc_lock);
+
+	rtc1_write(ECMPLREG, 0);
+	rtc1_write(ECMPMREG, 0);
+	rtc1_write(ECMPHREG, 0);
+	rtc1_write(RTCL1LREG, 0);
+	rtc1_write(RTCL1HREG, 0);
+
+	rtc_status = RTC_RELEASE;
+
+	spin_unlock_irq(&rtc_lock);
+
+	disable_irq(ELAPSEDTIME_IRQ);
+	disable_irq(RTCLONG1_IRQ);
+
+	return 0;
+}
+
+static int rtc_fasync(int fd, struct file *file, int on)
+{
+	return fasync_helper(fd, file, on, &rtc_async_queue);
+}
+
+static struct file_operations rtc_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= rtc_read,
+	.poll		= rtc_poll,
+	.ioctl		= rtc_ioctl,
+	.open		= rtc_open,
+	.release	= rtc_release,
+	.fasync		= rtc_fasync,
+};
+
+static irqreturn_t elapsedtime_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	spin_lock(&rtc_lock);
+	rtc2_write(RTCINTREG, ELAPSEDTIME_INT);
+
+	rtc_irq_data += 0x100;
+	rtc_irq_data &= ~0xff;
+	rtc_irq_data |= RTC_AF;
+	spin_unlock(&rtc_lock);
+
+	spin_lock(&rtc_lock);
+	if (rtc_callback)
+		rtc_callback->func(rtc_callback->private_data);
+	spin_unlock(&rtc_lock);
+
+	wake_up_interruptible(&rtc_wait);
+
+	kill_fasync(&rtc_async_queue, SIGIO, POLL_IN);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rtclong1_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long count = periodic_count;
+
+	spin_lock(&rtc_lock);
+	rtc2_write(RTCINTREG, RTCLONG1_INT);
+
+	rtc1_write(RTCL1LREG, count);
+	rtc1_write(RTCL1HREG, count >> 16);
+
+	rtc_irq_data += 0x100;
+	rtc_irq_data &= ~0xff;
+	rtc_irq_data |= RTC_PF;
+	spin_unlock(&rtc_lock);
+
+	spin_lock(&rtc_task_lock);
+	if (rtc_callback)
+		rtc_callback->func(rtc_callback->private_data);
+	spin_unlock(&rtc_task_lock);
+
+	wake_up_interruptible(&rtc_wait);
+
+	kill_fasync(&rtc_async_queue, SIGIO, POLL_IN);
+
+	return IRQ_HANDLED;
+}
+
+int rtc_register(rtc_task_t *task)
+{
+	if (task == NULL || task->func == NULL)
+		return -EINVAL;
+
+	spin_lock_irq(&rtc_lock);
+	if (rtc_status == RTC_OPEN) {
+		spin_unlock_irq(&rtc_lock);
+		return -EBUSY;
+	}
+
+	spin_lock(&rtc_task_lock);
+	if (rtc_callback != NULL) {
+		spin_unlock(&rtc_task_lock);
+		spin_unlock_irq(&rtc_task_lock);
+		return -EBUSY;
+	}
+
+	rtc_callback = task;
+	spin_unlock(&rtc_task_lock);
+
+	rtc_status = RTC_OPEN;
+
+	spin_unlock_irq(&rtc_lock);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rtc_register);
+
+int rtc_unregister(rtc_task_t *task)
+{
+	spin_lock_irq(&rtc_task_lock);
+	if (task == NULL || rtc_callback != task) {
+		spin_unlock_irq(&rtc_task_lock);
+		return -ENXIO;
+	}
+
+	spin_lock(&rtc_lock);
+
+	rtc1_write(ECMPLREG, 0);
+	rtc1_write(ECMPMREG, 0);
+	rtc1_write(ECMPHREG, 0);
+	rtc1_write(RTCL1LREG, 0);
+	rtc1_write(RTCL1HREG, 0);
+
+	rtc_status = RTC_RELEASE;
+
+	spin_unlock(&rtc_lock);
+
+	rtc_callback = NULL;
+
+	spin_unlock_irq(&rtc_task_lock);
+
+	disable_irq(ELAPSEDTIME_IRQ);
+	disable_irq(RTCLONG1_IRQ);
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(rtc_unregister);
+
+int rtc_control(rtc_task_t *task, unsigned int cmd, unsigned long arg)
+{
+	int retval = 0;
+
+	spin_lock_irq(&rtc_task_lock);
+
+	if (rtc_callback != task)
+		retval = -ENXIO;
+	else
+		rtc_do_ioctl(cmd, arg, FUNCTION_RTC_CONTROL);
+
+	spin_unlock_irq(&rtc_task_lock);
+
+	return retval;
+}
+
+EXPORT_SYMBOL_GPL(rtc_control);
+
+static struct miscdevice rtc_miscdevice = {
+	.minor	= RTC_MINOR,
+	.name	= rtc_name,
+	.fops	= &rtc_fops,
+};
+
+static int rtc_probe(struct device *dev)
+{
+	struct platform_device *pdev;
+	unsigned int irq;
+	int retval;
+
+	pdev = to_platform_device(dev);
+	if (pdev->num_resources != 2)
+		return -EBUSY;
+
+	rtc1_base = ioremap(pdev->resource[0].start, RTC1_SIZE);
+	if (rtc1_base == NULL)
+		return -EBUSY;
+
+	rtc2_base = ioremap(pdev->resource[1].start, RTC2_SIZE);
+	if (rtc2_base == NULL) {
+		iounmap(rtc1_base);
+		rtc1_base = NULL;
+		return -EBUSY;
+	}
+
+	retval = misc_register(&rtc_miscdevice);
+	if (retval < 0) {
+		iounmap(rtc1_base);
+		iounmap(rtc2_base);
+		rtc1_base = NULL;
+		rtc2_base = NULL;
+		return retval;
+	}
+
+	spin_lock_irq(&rtc_lock);
+
+	rtc1_write(ECMPLREG, 0);
+	rtc1_write(ECMPMREG, 0);
+	rtc1_write(ECMPHREG, 0);
+	rtc1_write(RTCL1LREG, 0);
+	rtc1_write(RTCL1HREG, 0);
+
+	rtc_status = RTC_RELEASE;
+	rtc_irq_data = 0;
+
+	spin_unlock_irq(&rtc_lock);
+
+	init_waitqueue_head(&rtc_wait);
+
+	irq = ELAPSEDTIME_IRQ;
+	retval = request_irq(irq, elapsedtime_interrupt, SA_INTERRUPT,
+	                     "elapsed_time", NULL);
+	if (retval == 0) {
+		irq = RTCLONG1_IRQ;
+		retval = request_irq(irq, rtclong1_interrupt, SA_INTERRUPT,
+		                     "rtclong1", NULL);
+	}
+
+	if (retval < 0) {
+		printk(KERN_ERR "rtc: IRQ%d is busy\n", irq);
+		if (irq == RTCLONG1_IRQ)
+			free_irq(ELAPSEDTIME_IRQ, NULL);
+		iounmap(rtc1_base);
+		iounmap(rtc2_base);
+		rtc1_base = NULL;
+		rtc2_base = NULL;
+		return retval;
+	}
+
+	disable_irq(ELAPSEDTIME_IRQ);
+	disable_irq(RTCLONG1_IRQ);
+
+	spin_lock_init(&rtc_task_lock);
+
+	printk(KERN_INFO "rtc: Real Time Clock of NEC VR4100 series\n");
+
+	return 0;
+}
+
+static int rtc_remove(struct device *dev)
+{
+	int retval;
+
+	retval = misc_deregister(&rtc_miscdevice);
+	if (retval < 0)
+		return retval;
+
+	free_irq(ELAPSEDTIME_IRQ, NULL);
+	free_irq(RTCLONG1_IRQ, NULL);
+	if (rtc1_base != NULL)
+		iounmap(rtc1_base);
+	if (rtc2_base != NULL)
+		iounmap(rtc2_base);
+
+	return 0;
+}
+
+static struct platform_device *rtc_platform_device;
+
+static struct device_driver rtc_device_driver = {
+	.name		= rtc_name,
+	.bus		= &platform_bus_type,
+	.probe		= rtc_probe,
+	.remove		= rtc_remove,
+};
+
+static int __devinit vr41xx_rtc_init(void)
+{
+	int retval;
+
+	switch (current_cpu_data.cputype) {
+	case CPU_VR4111:
+	case CPU_VR4121:
+		rtc_resource[0].start = RTC1_TYPE1_START;
+		rtc_resource[0].end = RTC1_TYPE1_END;
+		rtc_resource[1].start = RTC2_TYPE1_START;
+		rtc_resource[1].end = RTC2_TYPE1_END;
+		break;
+	case CPU_VR4122:
+	case CPU_VR4131:
+	case CPU_VR4133:
+		rtc_resource[0].start = RTC1_TYPE2_START;
+		rtc_resource[0].end = RTC1_TYPE2_END;
+		rtc_resource[1].start = RTC2_TYPE2_START;
+		rtc_resource[1].end = RTC2_TYPE2_END;
+		break;
+	default:
+		return -ENODEV;
+		break;
+	}
+
+	rtc_platform_device = platform_device_register_simple("RTC", -1, rtc_resource, RTC_NUM_RESOURCES);
+	if (IS_ERR(rtc_platform_device))
+		return PTR_ERR(rtc_platform_device);
+
+	retval = driver_register(&rtc_device_driver);
+	if (retval < 0)
+		platform_device_unregister(rtc_platform_device);
+
+	return retval;
+}
+
+static void __devexit vr41xx_rtc_exit(void)
+{
+	driver_unregister(&rtc_device_driver);
+
+	platform_device_unregister(rtc_platform_device);
+}
+
+module_init(vr41xx_rtc_init);
+module_exit(vr41xx_rtc_exit);
