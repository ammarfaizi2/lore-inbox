Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263207AbVCKG44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbVCKG44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 01:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVCKG44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 01:56:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:43226 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263224AbVCKGzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 01:55:37 -0500
Subject: [PATCH] ppc64: Add basic support for the SMU chip in iMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 17:55:20 +1100
Message-Id: <1110524120.5751.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The iMac G5 and latest single-cpu PowerMac G5 have seen the venerable
PMU (Power Management Unit) chip been sent to well deserved retirement.
It has been replaced by a newcomer, the SMU (System Management Unit ?)
which is of course totally undocumented and has no open source darwin
driver... The SMU chip is responsible of initializing the chipset & CPU
(boot process), power supply control, real time clock, fan control,
provides some i2c busses, etc... etc... etc...

This is a very basic driver based on the Open Firmware methods for
accessing this chip. It provides synchronous functions only, and does
restart, shutdown, and real time clock access. There is still no fan
control, at least not until we have figured out how to access the fans
via the SMU.

The initial code was written by J. Mayer <l_indien@magic.fr>, I mostly
rewrote it to better adhere to our coding style standards ;)

The patch also updates the g5_defconfig to include the SMU support by
default.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/arch/ppc64/Kconfig
===================================================================
--- linux-work.orig/arch/ppc64/Kconfig	2005-03-07 10:10:13.000000000 +1100
+++ linux-work/arch/ppc64/Kconfig	2005-03-10 16:56:16.000000000 +1100
@@ -81,7 +81,6 @@
 	depends on PPC_MULTIPLATFORM
 	bool "  Apple G5 based machines"
 	default y
-	select ADB_PMU
 	select U3_DART
 
 config PPC_MAPLE
Index: linux-work/arch/ppc64/kernel/misc.S
===================================================================
--- linux-work.orig/arch/ppc64/kernel/misc.S	2005-03-07 14:00:11.000000000 +1100
+++ linux-work/arch/ppc64/kernel/misc.S	2005-03-10 17:39:22.000000000 +1100
@@ -292,6 +292,26 @@
 	isync
 	blr
 
+_GLOBAL(flush_inval_dcache_range)	
+ 	ld	r10,PPC64_CACHES@toc(r2)
+	lwz	r7,DCACHEL1LINESIZE(r10)	/* Get dcache line size */
+	addi	r5,r7,-1
+	andc	r6,r3,r5		/* round low to line bdy */
+	subf	r8,r6,r4		/* compute length */
+	add	r8,r8,r5		/* ensure we get enough */
+	lwz	r9,DCACHEL1LOGLINESIZE(r10)/* Get log-2 of dcache line size */
+	srw.	r8,r8,r9		/* compute line count */
+	beqlr				/* nothing to do? */
+	sync
+	isync
+	mtctr	r8
+0:	dcbf	0,r6
+	add	r6,r6,r7
+	bdnz	0b
+	sync
+	isync
+	blr
+
 
 /*
  * Flush a particular page from the data cache to RAM.
Index: linux-work/arch/ppc64/kernel/pmac_setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_setup.c	2005-03-10 13:43:01.000000000 +1100
+++ linux-work/arch/ppc64/kernel/pmac_setup.c	2005-03-10 16:56:16.000000000 +1100
@@ -70,6 +70,7 @@
 #include <asm/time.h>
 #include <asm/of_device.h>
 #include <asm/lmb.h>
+#include <asm/smu.h>
 
 #include "pmac.h"
 #include "mpic.h"
@@ -80,13 +81,20 @@
 #define DBG(fmt...)
 #endif
 
-
 static int current_root_goodness = -1;
 #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
 
 extern  int powersave_nap;
 int sccdbg;
 
+sys_ctrler_t sys_ctrler;
+EXPORT_SYMBOL(sys_ctrler);
+
+#ifdef CONFIG_PMAC_SMU
+unsigned long smu_cmdbuf_abs;
+EXPORT_SYMBOL(smu_cmdbuf_abs);
+#endif
+
 extern void udbg_init_scc(struct device_node *np);
 
 void __pmac pmac_show_cpuinfo(struct seq_file *m)
@@ -155,8 +163,14 @@
 	/* We can NAP */
 	powersave_nap = 1;
 
-	/* Initialize the PMU */
+#ifdef CONFIG_ADB_PMU
+	/* Initialize the PMU if any */
 	find_via_pmu();
+#endif
+#ifdef CONFIG_PMAC_SMU
+	/* Initialize the SMU if any */
+	smu_init();
+#endif
 
 	/* Init NVRAM access */
 	pmac_nvram_init();
@@ -216,12 +230,39 @@
 
 void __pmac pmac_restart(char *cmd)
 {
-	pmu_restart();
+	switch(sys_ctrler) {
+#ifdef CONFIG_ADB_PMU
+	case SYS_CTRLER_PMU:
+		pmu_restart();
+		break;
+#endif
+
+#ifdef CONFIG_PMAC_SMU
+	case SYS_CTRLER_SMU:
+		smu_restart();
+		break;
+#endif
+	default:
+		;
+	}
 }
 
 void __pmac pmac_power_off(void)
 {
-	pmu_shutdown();
+	switch(sys_ctrler) {
+#ifdef CONFIG_ADB_PMU
+	case SYS_CTRLER_PMU:
+		pmu_shutdown();
+		break;
+#endif
+#ifdef CONFIG_PMAC_SMU
+	case SYS_CTRLER_SMU:
+		smu_shutdown();
+		break;
+#endif
+	default:
+		;
+	}
 }
 
 void __pmac pmac_halt(void)
@@ -426,7 +467,6 @@
 {
 	if (platform != PLATFORM_POWERMAC)
 		return 0;
-
 	/*
 	 * On U3, the DART (iommu) must be allocated now since it
 	 * has an impact on htab_initialize (due to the large page it
@@ -435,6 +475,15 @@
 	 */
 	alloc_u3_dart_table();
 
+#ifdef CONFIG_PMAC_SMU
+	/*
+	 * SMU based G5s need some memory below 2Gb, at least the current
+	 * driver needs that. We have to allocate it now. We allocate 4k
+	 * (1 small page) for now.
+	 */
+	smu_cmdbuf_abs = lmb_alloc_base(4096, 4096, 0x80000000UL);
+#endif /* CONFIG_PMAC_SMU */
+
 	return 1;
 }
 
Index: linux-work/drivers/macintosh/Kconfig
===================================================================
--- linux-work.orig/drivers/macintosh/Kconfig	2005-01-31 14:18:21.000000000 +1100
+++ linux-work/drivers/macintosh/Kconfig	2005-03-10 16:56:16.000000000 +1100
@@ -78,6 +78,14 @@
 	  this device; you should do so if your machine is one of those
 	  mentioned above.
 
+config PMAC_SMU
+	bool "Support for SMU  based PowerMacs"
+	depends on PPC_PMAC64
+	help
+	  This option adds support for the newer G5 iMacs and PowerMacs based
+	  on the "SMU" system control chip which replaces the old PMU.
+	  If you don't know, say Y.
+
 config PMAC_PBOOK
 	bool "Power management support for PowerBooks"
 	depends on ADB_PMU
Index: linux-work/drivers/macintosh/Makefile
===================================================================
--- linux-work.orig/drivers/macintosh/Makefile	2005-01-31 14:18:21.000000000 +1100
+++ linux-work/drivers/macintosh/Makefile	2005-03-10 16:56:16.000000000 +1100
@@ -15,6 +15,7 @@
 obj-$(CONFIG_ADB_PMU)		+= via-pmu.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o
 obj-$(CONFIG_PMAC_APM_EMU)	+= apm_emu.o
+obj-$(CONFIG_PMAC_SMU)		+= smu.o
 
 obj-$(CONFIG_ADB)		+= adb.o
 obj-$(CONFIG_ADB_MACII)		+= via-macii.o
Index: linux-work/drivers/macintosh/smu.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/macintosh/smu.c	2005-03-10 17:40:09.000000000 +1100
@@ -0,0 +1,364 @@
+/*
+ * PowerMac G5 SMU driver
+ *
+ * Copyright 2004 J. Mayer <l_indien@magic.fr>
+ * Copyright 2005 Benjamin Herrenschmidt, IBM Corp.
+ *
+ * Released under the term of the GNU GPL v2.
+ */
+
+/*
+ * For now, this driver includes:
+ * - RTC get & set
+ * - reboot & shutdown commands
+ * all synchronous with IRQ disabled (ugh)
+ *
+ * TODO:
+ *   rework in a way the PMU driver works, that is asynchronous
+ *   with a queue of commands. I'll do that as soon as I have an
+ *   SMU based machine at hand. Some more cleanup is needed too,
+ *   like maybe fitting it into a platform device, etc...
+ *   Also check what's up with cache coherency, and if we really
+ *   can't do better than flushing the cache, maybe build a table
+ *   of command len/reply len like the PMU driver to only flush
+ *   what is actually necessary.
+ *   --BenH.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/dmapool.h>
+#include <linux/bootmem.h>
+#include <linux/vmalloc.h>
+#include <linux/highmem.h>
+#include <linux/jiffies.h>
+#include <linux/interrupt.h>
+#include <linux/rtc.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+#include <asm/smu.h>
+#include <asm/sections.h>
+#include <asm/abs_addr.h>
+
+#define DEBUG_SMU 1
+
+#ifdef DEBUG_SMU
+#define DPRINTK(fmt, args...) do { printk(KERN_DEBUG fmt , ##args); } while (0)
+#else
+#define DPRINTK(fmt, args...) do { } while (0)
+#endif
+
+/*
+ * This is the command buffer passed to the SMU hardware
+ */
+struct smu_cmd_buf {
+	u8 cmd;
+	u8 length;
+	u8 data[0x0FFE];
+};
+
+struct smu_device {
+	spinlock_t		lock;
+	struct device_node	*of_node;
+	int			db_ack;		/* doorbell ack GPIO */
+	int			db_req;		/* doorbell req GPIO */
+	u32 __iomem		*db_buf;	/* doorbell buffer */
+	struct smu_cmd_buf	*cmd_buf;	/* command buffer virtual */
+	u32			cmd_buf_abs;	/* command buffer absolute */
+};
+
+/*
+ * I don't think there will ever be more than one SMU, so
+ * for now, just hard code that
+ */
+static struct smu_device	*smu;
+
+/*
+ * SMU low level communication stuff
+ */
+static inline int smu_cmd_stat(struct smu_cmd_buf *cmd_buf, u8 cmd_ack)
+{
+	rmb();
+	return cmd_buf->cmd == cmd_ack && cmd_buf->length != 0;
+}
+
+static inline u8 smu_save_ack_cmd(struct smu_cmd_buf *cmd_buf)
+{
+	return (~cmd_buf->cmd) & 0xff;
+}
+
+static void smu_send_cmd(struct smu_device *dev)
+{
+	/* SMU command buf is currently cacheable, we need a physical
+	 * address. This isn't exactly a DMA mapping here, I suspect
+	 * the SMU is actually communicating with us via i2c to the
+	 * northbridge or the CPU to access RAM.
+	 */
+	writel(dev->cmd_buf_abs, dev->db_buf);
+
+	/* Ring the SMU doorbell */
+	pmac_do_feature_call(PMAC_FTR_WRITE_GPIO, NULL, dev->db_req, 4);
+	pmac_do_feature_call(PMAC_FTR_READ_GPIO, NULL, dev->db_req, 4);
+}
+
+static int smu_cmd_done(struct smu_device *dev)
+{
+	unsigned long wait = 0;
+	int gpio;
+    
+	/* Check the SMU doorbell */
+	do  {
+		gpio = pmac_do_feature_call(PMAC_FTR_READ_GPIO,
+					    NULL, dev->db_ack);
+		if ((gpio & 7) == 7)
+			return 0;
+		udelay(100);
+	} while(++wait < 10000);
+
+	printk(KERN_ERR "SMU timeout !\n");
+	return -ENXIO;
+}
+
+static int smu_do_cmd(struct smu_device *dev)
+{
+	int rc;
+	u8 cmd_ack;
+    
+	DPRINTK("SMU do_cmd %02x len=%d %02x\n",
+		dev->cmd_buf->cmd, dev->cmd_buf->length,
+		dev->cmd_buf->data[0]);
+
+	cmd_ack = smu_save_ack_cmd(dev->cmd_buf);
+
+	/* Clear cmd_buf cache lines */
+	flush_inval_dcache_range((unsigned long)dev->cmd_buf,
+				 ((unsigned long)dev->cmd_buf) +
+				 sizeof(struct smu_cmd_buf));
+	smu_send_cmd(dev);
+	rc = smu_cmd_done(dev);
+	if (rc == 0)
+		rc = smu_cmd_stat(dev->cmd_buf, cmd_ack) ? 0 : -1;
+
+	DPRINTK("SMU do_cmd %02x len=%d %02x => %d (%02x)\n",
+		dev->cmd_buf->cmd, dev->cmd_buf->length,
+		dev->cmd_buf->data[0], rc, cmd_ack);
+
+	return rc;
+}
+
+/* RTC low level commands */
+static inline int bcd2hex (int n)
+{
+	return (((n & 0xf0) >> 4) * 10) + (n & 0xf);
+}
+
+static inline int hex2bcd (int n)
+{
+	return ((n / 10) << 4) + (n % 10);
+}
+
+#if 0
+static inline void smu_fill_set_pwrup_timer_cmd(struct smu_cmd_buf *cmd_buf)
+{
+	cmd_buf->cmd = 0x8e;
+	cmd_buf->length = 8;
+	cmd_buf->data[0] = 0x00;
+	memset(cmd_buf->data + 1, 0, 7);
+}
+
+static inline void smu_fill_get_pwrup_timer_cmd(struct smu_cmd_buf *cmd_buf)
+{
+	cmd_buf->cmd = 0x8e;
+	cmd_buf->length = 1;
+	cmd_buf->data[0] = 0x01;
+}
+
+static inline void smu_fill_dis_pwrup_timer_cmd(struct smu_cmd_buf *cmd_buf)
+{
+	cmd_buf->cmd = 0x8e;
+	cmd_buf->length = 1;
+	cmd_buf->data[0] = 0x02;
+}
+#endif
+
+static inline void smu_fill_set_rtc_cmd(struct smu_cmd_buf *cmd_buf,
+					struct rtc_time *time)
+{
+	cmd_buf->cmd = 0x8e;
+	cmd_buf->length = 8;
+	cmd_buf->data[0] = 0x80;
+	cmd_buf->data[1] = hex2bcd(time->tm_sec);
+	cmd_buf->data[2] = hex2bcd(time->tm_min);
+	cmd_buf->data[3] = hex2bcd(time->tm_hour);
+	cmd_buf->data[4] = time->tm_wday;
+	cmd_buf->data[5] = hex2bcd(time->tm_mday);
+	cmd_buf->data[6] = hex2bcd(time->tm_mon) + 1;
+	cmd_buf->data[7] = hex2bcd(time->tm_year - 100);
+}
+
+static inline void smu_fill_get_rtc_cmd(struct smu_cmd_buf *cmd_buf)
+{
+	cmd_buf->cmd = 0x8e;
+	cmd_buf->length = 1;
+	cmd_buf->data[0] = 0x81;
+}
+
+static void smu_parse_get_rtc_reply(struct smu_cmd_buf *cmd_buf,
+				    struct rtc_time *time)
+{
+	time->tm_sec = bcd2hex(cmd_buf->data[0]);
+	time->tm_min = bcd2hex(cmd_buf->data[1]);
+	time->tm_hour = bcd2hex(cmd_buf->data[2]);
+	time->tm_wday = bcd2hex(cmd_buf->data[3]);
+	time->tm_mday = bcd2hex(cmd_buf->data[4]);
+	time->tm_mon = bcd2hex(cmd_buf->data[5]) - 1;
+	time->tm_year = bcd2hex(cmd_buf->data[6]) + 100;
+}
+
+int smu_get_rtc_time(struct rtc_time *time)
+{
+	unsigned long flags;
+	int rc;
+
+	if (smu == NULL)
+		return -ENODEV;
+
+	memset(time, 0, sizeof(struct rtc_time));
+	spin_lock_irqsave(&smu->lock, flags);
+	smu_fill_get_rtc_cmd(smu->cmd_buf);
+	rc = smu_do_cmd(smu);
+	if (rc == 0)
+		smu_parse_get_rtc_reply(smu->cmd_buf, time);
+	spin_unlock_irqrestore(&smu->lock, flags);
+
+	return rc;
+}
+
+int smu_set_rtc_time(struct rtc_time *time)
+{
+	unsigned long flags;
+	int rc;
+
+	if (smu == NULL)
+		return -ENODEV;
+
+	spin_lock_irqsave(&smu->lock, flags);
+	smu_fill_set_rtc_cmd(smu->cmd_buf, time);
+	rc = smu_do_cmd(smu);
+	spin_unlock_irqrestore(&smu->lock, flags);
+
+	return rc;
+}
+
+void smu_shutdown(void)
+{
+	const unsigned char *command = "SHUTDOWN";
+	unsigned long flags;
+
+	if (smu == NULL)
+		return;
+
+	spin_lock_irqsave(&smu->lock, flags);
+	smu->cmd_buf->cmd = 0xaa;
+	smu->cmd_buf->length = strlen(command);
+	strcpy(smu->cmd_buf->data, command);
+	smu_do_cmd(smu);
+	for (;;)
+		;
+	spin_unlock_irqrestore(&smu->lock, flags);
+}
+
+void smu_restart(void)
+{
+	const unsigned char *command = "RESTART";
+	unsigned long flags;
+
+	if (smu == NULL)
+		return;
+
+	spin_lock_irqsave(&smu->lock, flags);
+	smu->cmd_buf->cmd = 0xaa;
+	smu->cmd_buf->length = strlen(command);
+	strcpy(smu->cmd_buf->data, command);
+	smu_do_cmd(smu);
+	for (;;)
+		;
+	spin_unlock_irqrestore(&smu->lock, flags);
+}
+
+int smu_present(void)
+{
+	return smu != NULL;
+}
+
+
+int smu_init (void)
+{
+	struct device_node *np;
+	u32 *data;
+
+        np = of_find_node_by_type(NULL, "smu");
+        if (np == NULL)
+		return -ENODEV;
+
+	if (smu_cmdbuf_abs == 0) {
+		printk(KERN_ERR "SMU: Command buffer not allocated !\n");
+		return -EINVAL;
+	}
+
+	smu = alloc_bootmem(sizeof(struct smu_device));
+	if (smu == NULL)
+		return -ENOMEM;
+	memset(smu, 0, sizeof(*smu));
+
+	spin_lock_init(&smu->lock);
+	smu->of_node = np;
+	/* smu_cmdbuf_abs is in the low 2G of RAM, can be converted to a
+	 * 32 bits value safely
+	 */
+	smu->cmd_buf_abs = (u32)smu_cmdbuf_abs;
+	smu->cmd_buf = (struct smu_cmd_buf *)abs_to_virt(smu_cmdbuf_abs);
+	
+	np = of_find_node_by_name(NULL, "smu-doorbell");
+	if (np == NULL) {
+		printk(KERN_ERR "SMU: Can't find doorbell GPIO !\n");
+		goto fail;
+	}
+	data = (u32 *)get_property(np, "reg", NULL);
+	of_node_put(np);
+	if (data == NULL) {
+		printk(KERN_ERR "SMU: Can't find doorbell GPIO address !\n");
+		goto fail;
+	}
+
+	/* Current setup has one doorbell GPIO that does both doorbell
+	 * and ack. GPIOs are at 0x50, best would be to find that out
+	 * in the device-tree though.
+	 */
+	smu->db_req = 0x50 + *data;	
+	smu->db_ack = 0x50 + *data;
+
+	/* Doorbell buffer is currently hard-coded, I didn't find a proper
+	 * device-tree entry giving the address. Best would probably to use
+	 * an offset for K2 base though, but let's do it that way for now.
+	 */
+	smu->db_buf = ioremap(0x8000860c, 0x1000);
+	if (smu->db_buf == NULL) {
+		printk(KERN_ERR "SMU: Can't map doorbell buffer pointer !\n");
+		goto fail;
+	}
+
+	sys_ctrler = SYS_CTRLER_SMU;
+	return 0;
+
+ fail:
+	smu = NULL;
+	return -ENXIO;
+
+}
Index: linux-work/include/asm-ppc64/cacheflush.h
===================================================================
--- linux-work.orig/include/asm-ppc64/cacheflush.h	2005-03-07 14:00:11.000000000 +1100
+++ linux-work/include/asm-ppc64/cacheflush.h	2005-03-10 16:56:16.000000000 +1100
@@ -28,6 +28,7 @@
 
 extern void flush_dcache_range(unsigned long start, unsigned long stop);
 extern void flush_dcache_phys_range(unsigned long start, unsigned long stop);
+extern void flush_inval_dcache_range(unsigned long start, unsigned long stop);
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
 do { memcpy(dst, src, len); \
Index: linux-work/include/asm-ppc/machdep.h
===================================================================
--- linux-work.orig/include/asm-ppc/machdep.h	2005-01-31 14:18:44.000000000 +1100
+++ linux-work/include/asm-ppc/machdep.h	2005-03-10 16:56:16.000000000 +1100
@@ -121,6 +121,7 @@
 	SYS_CTRLER_UNKNOWN = 0,
 	SYS_CTRLER_CUDA = 1,
 	SYS_CTRLER_PMU = 2,
+	SYS_CTRLER_SMU = 3,
 } sys_ctrler_t;
 
 extern sys_ctrler_t sys_ctrler;
Index: linux-work/include/asm-ppc64/smu.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/asm-ppc64/smu.h	2005-03-10 16:56:16.000000000 +1100
@@ -0,0 +1,22 @@
+/*
+ * Definitions for talking to the SMU chip in newer G5 PowerMacs
+ */
+
+#include <linux/config.h>
+
+/*
+ * Basic routines for use by architecture. To be extended as
+ * we understand more of the chip
+ */
+extern int smu_init(void);
+extern int smu_present(void);
+extern void smu_shutdown(void);
+extern void smu_restart(void);
+extern int smu_get_rtc_time(struct rtc_time *time);
+extern int smu_set_rtc_time(struct rtc_time *time);
+
+/*
+ * SMU command buffer absolute address, exported by pmac_setup,
+ * this is allocated very early during boot.
+ */
+extern unsigned long smu_cmdbuf_abs;
Index: linux-work/include/asm-ppc64/machdep.h
===================================================================
--- linux-work.orig/include/asm-ppc64/machdep.h	2005-03-07 10:10:14.000000000 +1100
+++ linux-work/include/asm-ppc64/machdep.h	2005-03-10 16:56:16.000000000 +1100
@@ -135,6 +135,23 @@
 extern struct machdep_calls ppc_md;
 extern char cmd_line[COMMAND_LINE_SIZE];
 
+#ifdef CONFIG_PPC_PMAC
+/*
+ * Power macintoshes have either a CUDA, PMU or SMU controlling
+ * system reset, power, NVRAM, RTC.
+ */
+typedef enum sys_ctrler_kind {
+	SYS_CTRLER_UNKNOWN = 0,
+	SYS_CTRLER_CUDA = 1,
+	SYS_CTRLER_PMU = 2,
+	SYS_CTRLER_SMU = 3,
+} sys_ctrler_t;
+extern sys_ctrler_t sys_ctrler;
+
+#endif /* CONFIG_PPC_PMAC */
+
+
+
 /* Functions to produce codes on the leds.
  * The SRC code should be unique for the message category and should
  * be limited to the lower 24 bits (the upper 8 are set by these funcs),
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-03-07 10:10:13.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu.c	2005-03-10 16:56:16.000000000 +1100
@@ -367,9 +367,7 @@
 	printk(KERN_INFO "PMU driver %d initialized for %s, firmware: %02x\n",
 	       PMU_DRIVER_VERSION, pbook_type[pmu_kind], pmu_version);
 	       
-#ifndef CONFIG_PPC64
 	sys_ctrler = SYS_CTRLER_PMU;
-#endif
 	
 	return 1;
 }
@@ -1745,6 +1743,9 @@
 {
 	struct adb_request req;
 
+	if (via == NULL)
+		return;
+
 	local_irq_disable();
 
 	drop_interrupts = 1;
@@ -1767,6 +1768,9 @@
 {
 	struct adb_request req;
 
+	if (via == NULL)
+		return;
+
 	local_irq_disable();
 
 	drop_interrupts = 1;
Index: linux-work/arch/ppc64/kernel/pmac_time.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_time.c	2005-01-31 14:18:14.000000000 +1100
+++ linux-work/arch/ppc64/kernel/pmac_time.c	2005-03-10 16:56:16.000000000 +1100
@@ -6,6 +6,8 @@
  *
  * Paul Mackerras	August 1996.
  * Copyright (C) 1996 Paul Mackerras.
+ * Copyright (C) 2003-2005 Benjamin Herrenschmidt.
+ *
  */
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -28,6 +30,7 @@
 #include <asm/machdep.h>
 #include <asm/time.h>
 #include <asm/nvram.h>
+#include <asm/smu.h>
 
 #undef DEBUG
 
@@ -55,54 +58,86 @@
 
 void __pmac pmac_get_rtc_time(struct rtc_time *tm)
 {
-	struct adb_request req;
-	unsigned int now;
-
-	/* Get the time from the RTC */
-	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
-		return;
-	while (!req.complete)
-		pmu_poll();
-	if (req.reply_len != 4)
-		printk(KERN_ERR "pmac_get_rtc_time: got %d byte reply\n",
-		       req.reply_len);
-	now = (req.reply[0] << 24) + (req.reply[1] << 16)
-		+ (req.reply[2] << 8) + req.reply[3];
-	DBG("get: %u -> %u\n", (int)now, (int)(now - RTC_OFFSET));
-	now -= RTC_OFFSET;
-
-	to_tm(now, tm);
-	tm->tm_year -= 1900;
-	tm->tm_mon -= 1;
+	switch(sys_ctrler) {
+#ifdef CONFIG_ADB_PMU
+	case SYS_CTRLER_PMU: {
+		/* TODO: Move that to a function in the PMU driver */
+		struct adb_request req;
+		unsigned int now;
+
+		if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
+			return;
+		pmu_wait_complete(&req);
+		if (req.reply_len != 4)
+			printk(KERN_ERR "pmac_get_rtc_time: PMU returned a %d"
+			       " bytes reply\n", req.reply_len);
+		now = (req.reply[0] << 24) + (req.reply[1] << 16)
+			+ (req.reply[2] << 8) + req.reply[3];
+		DBG("get: %u -> %u\n", (int)now, (int)(now - RTC_OFFSET));
+		now -= RTC_OFFSET;
+
+		to_tm(now, tm);
+		tm->tm_year -= 1900;
+		tm->tm_mon -= 1;
 	
-	DBG("-> tm_mday: %d, tm_mon: %d, tm_year: %d, %d:%02d:%02d\n",
-	       tm->tm_mday, tm->tm_mon, tm->tm_year,
-	       tm->tm_hour, tm->tm_min, tm->tm_sec);
+		DBG("-> tm_mday: %d, tm_mon: %d, tm_year: %d, %d:%02d:%02d\n",
+		    tm->tm_mday, tm->tm_mon, tm->tm_year,
+		    tm->tm_hour, tm->tm_min, tm->tm_sec);
+		break;
+	}
+#endif /* CONFIG_ADB_PMU */
+
+#ifdef CONFIG_PMAC_SMU
+	case SYS_CTRLER_SMU:
+		smu_get_rtc_time(tm);
+		break;
+#endif /* CONFIG_PMAC_SMU */
+	default:
+		;
+	}
 }
 
 int __pmac pmac_set_rtc_time(struct rtc_time *tm)
 {
-	struct adb_request req;
-	unsigned int nowtime;
-
-	DBG("set: tm_mday: %d, tm_mon: %d, tm_year: %d, %d:%02d:%02d\n",
-	       tm->tm_mday, tm->tm_mon, tm->tm_year,
-	       tm->tm_hour, tm->tm_min, tm->tm_sec);
-
-	nowtime = mktime(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
-			 tm->tm_hour, tm->tm_min, tm->tm_sec);
-	DBG("-> %u -> %u\n", (int)nowtime, (int)(nowtime + RTC_OFFSET));
-	nowtime += RTC_OFFSET;
-
-	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
-			nowtime >> 24, nowtime >> 16, nowtime >> 8, nowtime) < 0)
+	switch(sys_ctrler) {
+#ifdef CONFIG_ADB_PMU
+	case SYS_CTRLER_PMU: {
+		/* TODO: Move that to a function in the PMU driver */
+		struct adb_request req;
+		unsigned int nowtime;
+
+		DBG("set: tm_mday: %d, tm_mon: %d, tm_year: %d,"
+		    " %d:%02d:%02d\n",
+		    tm->tm_mday, tm->tm_mon, tm->tm_year,
+		    tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+		nowtime = mktime(tm->tm_year + 1900, tm->tm_mon + 1,
+				 tm->tm_mday, tm->tm_hour, tm->tm_min,
+				 tm->tm_sec);
+
+		DBG("-> %u -> %u\n", (int)nowtime,
+		    (int)(nowtime + RTC_OFFSET));
+		nowtime += RTC_OFFSET;
+
+		if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
+				nowtime >> 24, nowtime >> 16,
+				nowtime >> 8, nowtime) < 0)
+			return -ENXIO;
+		pmu_wait_complete(&req);
+		if (req.reply_len != 0)
+			printk(KERN_ERR "pmac_set_rtc_time: PMU returned a %d"
+			       " bytes reply\n", req.reply_len);
 		return 0;
-	while (!req.complete)
-		pmu_poll();
-	if (req.reply_len != 0)
-		printk(KERN_ERR "pmac_set_rtc_time: got %d byte reply\n",
-		       req.reply_len);
-	return 1;
+	}
+#endif /* CONFIG_ADB_PMU */
+
+#ifdef CONFIG_PMAC_SMU
+	case SYS_CTRLER_SMU:
+		return smu_set_rtc_time(tm);
+#endif /* CONFIG_PMAC_SMU */
+	default:
+		return -ENODEV;
+	}
 }
 
 void __init pmac_get_boot_time(struct rtc_time *tm)
Index: linux-work/arch/ppc64/configs/g5_defconfig
===================================================================
--- linux-work.orig/arch/ppc64/configs/g5_defconfig	2005-03-07 10:10:13.000000000 +1100
+++ linux-work/arch/ppc64/configs/g5_defconfig	2005-03-10 16:56:16.000000000 +1100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc3-bk6
-# Wed Feb  9 23:34:53 2005
+# Linux kernel version: 2.6.11
+# Thu Mar 10 16:47:04 2005
 #
 CONFIG_64BIT=y
 CONFIG_MMU=y
@@ -30,6 +30,7 @@
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
@@ -39,6 +40,7 @@
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -48,6 +50,7 @@
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -94,6 +97,7 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
+# CONFIG_HOTPLUG_CPU is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -279,6 +283,7 @@
 # CONFIG_SCSI_ATA_PIIX is not set
 # CONFIG_SCSI_SATA_NV is not set
 # CONFIG_SCSI_SATA_PROMISE is not set
+# CONFIG_SCSI_SATA_QSTOR is not set
 # CONFIG_SCSI_SATA_SX4 is not set
 # CONFIG_SCSI_SATA_SIL is not set
 # CONFIG_SCSI_SATA_SIS is not set
@@ -373,6 +378,7 @@
 #
 CONFIG_ADB=y
 CONFIG_ADB_PMU=y
+CONFIG_PMAC_SMU=y
 # CONFIG_PMAC_PBOOK is not set
 # CONFIG_PMAC_BACKLIGHT is not set
 # CONFIG_INPUT_ADBHID is not set
@@ -697,6 +703,11 @@
 CONFIG_MAX_RAW_DEVS=256
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
 # I2C support
 #
 CONFIG_I2C=y
@@ -724,6 +735,7 @@
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_SCx200_ACB is not set
@@ -747,7 +759,9 @@
 # CONFIG_SENSORS_ASB100 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
 # CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
 # CONFIG_SENSORS_LM75 is not set
@@ -761,6 +775,7 @@
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SIS5595 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
@@ -885,6 +900,8 @@
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_UHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
 
@@ -905,7 +922,7 @@
 CONFIG_USB_STORAGE_FREECOM=y
 CONFIG_USB_STORAGE_ISD200=y
 CONFIG_USB_STORAGE_DPCM=y
-CONFIG_USB_STORAGE_HP8200e=y
+# CONFIG_USB_STORAGE_USBAT is not set
 CONFIG_USB_STORAGE_SDDR09=y
 CONFIG_USB_STORAGE_SDDR55=y
 CONFIG_USB_STORAGE_JUMPSHOT=y
@@ -976,6 +993,7 @@
 # USB Network Adapters
 #
 CONFIG_USB_AX8817X=y
+CONFIG_USB_MON=y
 
 #
 # USB port drivers
@@ -1038,6 +1056,7 @@
 # CONFIG_USB_PHIDGETKIT is not set
 # CONFIG_USB_PHIDGETSERVO is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1253,6 +1272,7 @@
 #
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
@@ -1284,6 +1304,7 @@
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
+# CONFIG_CRYPTO_TGR192 is not set
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m


