Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268921AbTBSOre>; Wed, 19 Feb 2003 09:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268923AbTBSOre>; Wed, 19 Feb 2003 09:47:34 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:4224 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S268921AbTBSOqo>; Wed, 19 Feb 2003 09:46:44 -0500
Date: Wed, 19 Feb 2003 23:54:45 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update PC-9800 file in 2.5.61-ac1
Message-ID: <20030219145445.GA2308@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates files for PC-9800 in 2.5.61-ac1, to get
compatibilty with 2.5.61.  Please aplly.

 arch/i386/Makefile                        |   14 
 arch/i386/boot98/Makefile                 |   22 
 arch/i386/boot98/compressed/Makefile      |    3 
 arch/i386/kernel/i8259.c                  |    2 
 arch/i386/mach-pc9800/Makefile            |   10 
 arch/i386/mach-pc9800/setup.c             |    8 
 arch/i386/mach-pc9800/topology.c          |   68 ++
 drivers/block/Kconfig                     |    8 
 drivers/block/Makefile                    |    5 
 drivers/block/floppy98.c                  |  102 ++-
 drivers/char/Kconfig                      |    6 
 drivers/char/Makefile                     |    2 
 drivers/char/lp_old98.c                   |  303 ++++------
 drivers/char/upd4990a.c                   |   25 
 drivers/input/keyboard/Kconfig            |    2 
 drivers/input/mouse/98busmouse.c          |    7 
 drivers/input/mouse/Kconfig               |    2 
 drivers/input/serio/98kbd-io.c            |   13 
 drivers/input/serio/Kconfig               |    2 
 drivers/pci/quirks.c                      |    2 
 drivers/video/console/Makefile            |    1 
 drivers/video/console/gdccon.c            |  833 +++++++++++++++++++++++++++++
 drivers/video/gdccon.c                    |  834 ------------------------------
 include/asm-i386/gdc.h                    |  144 ++---
 include/asm-i386/mach-pc9800/entry_arch.h |    1 
 include/asm-i386/mach-pc9800/mach_apic.h  |    1 
 include/asm-i386/serial.h                 |    4 
 include/asm-i386/upd4990a.h               |    6 
 28 files changed, 1238 insertions(+), 1192 deletions(-)

--
Osamu Tomita

diff -Nru linux-2.5.61-ac1/arch/i386/Makefile linux98-2.5.61-ac1/arch/i386/Makefile
--- linux-2.5.61-ac1/arch/i386/Makefile	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61-ac1/arch/i386/Makefile	2003-02-18 20:59:16.000000000 +0900
@@ -65,6 +65,10 @@
 mflags-$(CONFIG_X86_NUMAQ)	:= -Iinclude/asm-i386/mach-numaq
 mcore-$(CONFIG_X86_NUMAQ)	:= mach-default
 
+# PC-9800 subarch support
+mflags-$(CONFIG_X86_PC9800)	:= -Iinclude/asm-i386/mach-pc9800
+mcore-$(CONFIG_X86_PC9800)	:= mach-pc9800
+
 # BIGSMP subarch support
 mflags-$(CONFIG_X86_BIGSMP)	:= -Iinclude/asm-i386/mach-bigsmp
 mcore-$(CONFIG_X86_BIGSMP)	:= mach-default
@@ -103,14 +107,18 @@
 AFLAGS_vmlinux.lds.o += -DNO_X86_HAL_INCLUDES
 endif
 
+ifeq ($(CONFIG_X86_PC9800),y)
+boot := arch/i386/boot98
+else
 boot := arch/i386/boot
+endif
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install
 
 all: bzImage
 
-BOOTIMAGE=arch/i386/boot/bzImage
-zImage zlilo zdisk: BOOTIMAGE=arch/i386/boot/zImage
+BOOTIMAGE=$(boot)/bzImage
+zImage zlilo zdisk: BOOTIMAGE=$(boot)/zImage
 
 zImage bzImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(BOOTIMAGE)
@@ -131,7 +139,7 @@
 	$(Q)$(MAKE) $(clean)=arch/i386/boot98
 
 define archhelp
-  echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
+  echo  '* bzImage	- Compressed kernel image ($(boot)/bzImage)'
   echo  '  install	- Install kernel using'
   echo  '		   (your) ~/bin/installkernel or'
   echo  '		   (distribution) /sbin/installkernel or'
diff -Nru linux98-2.5.61ac1/arch/i386/boot98/Makefile linux98-2.5.61-ac1/arch/i386/boot98/Makefile
--- linux98-2.5.61ac1/arch/i386/boot98/Makefile	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61-ac1/arch/i386/boot98/Makefile	2003-02-18 08:58:20.000000000 +0900
@@ -32,11 +32,9 @@
 
 host-progs	:= tools/build
 
-# 	Default
-
-boot: bzImage
-
-include $(TOPDIR)/Rules.make
+ifdef CONFIG_X86_HAL
+AFLAGS += -DNO_X86_HAL_INCLUDES
+endif
 
 # ---------------------------------------------------------------------------
 
@@ -53,6 +51,7 @@
 $(obj)/zImage $(obj)/bzImage: $(obj)/bootsect $(obj)/setup \
 			      $(obj)/vmlinux.bin $(obj)/tools/build FORCE
 	$(call if_changed,image)
+	@echo 'Kernel: $@ is ready'
 
 $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -64,9 +63,8 @@
 	$(call if_changed,ld)
 
 $(obj)/compressed/vmlinux: FORCE
-	+@$(call descend,$(obj)/compressed,IMAGE_OFFSET=$(IMAGE_OFFSET) \
-		$(obj)/compressed/vmlinux)
-
+	$(Q)$(MAKE) -f scripts/Makefile.build obj=$(obj)/compressed \
+					IMAGE_OFFSET=$(IMAGE_OFFSET) $@
 
 zdisk: $(BOOTIMAGE)
 	dd bs=8192 if=$(BOOTIMAGE) of=/dev/fd0
@@ -80,11 +78,3 @@
 
 install: $(BOOTIMAGE)
 	sh $(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
-
-archhelp:
-	@echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
-	@echo  '  install	- Install kernel using'
-	@echo  '                  (your) ~/bin/installkernel or'
-	@echo  '                  (distribution) /sbin/installkernel or'
-	@echo  '        	  install to $$(INSTALL_PATH) and run lilo'
-
diff -Nru linux98-2.5.61ac1/arch/i386/boot98/compressed/Makefile linux98-2.5.61/arch/i386/boot98/compressed/Makefile
--- linux98-2.5.61ac1/arch/i386/boot98/compressed/Makefile	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61/arch/i386/boot98/compressed/Makefile	2003-02-17 14:20:54.000000000 +0900
@@ -7,12 +7,11 @@
 EXTRA_TARGETS	:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS	:= -traditional
 
-include $(TOPDIR)/Rules.make
-
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -e startup_32
 
 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
+	@:
 
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
diff -Nru linux-2.5.61-ac1/arch/i386/kernel/i8259.c linux98-2.5.61/arch/i386/kernel/i8259.c
--- linux-2.5.61-ac1/arch/i386/kernel/i8259.c	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61/arch/i386/kernel/i8259.c	2003-02-18 13:33:13.000000000 +0900
@@ -328,7 +328,7 @@
 static void math_error_irq(int cpl, void *dev_id, struct pt_regs *regs)
 {
 	extern void math_error(void *);
-#ifndef CONFIG_PC9800
+#ifndef CONFIG_X86_PC9800
 	outb(0,0xF0);
 #endif
 	if (ignore_fpu_irq || !boot_cpu_data.hard_math)
diff -Nru linux-2.5.61-ac1/arch/i386/mach-pc9800/Makefile linux98-2.5.61/arch/i386/mach-pc9800/Makefile
--- linux-2.5.61-ac1/arch/i386/mach-pc9800/Makefile	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61/arch/i386/mach-pc9800/Makefile	2003-02-18 10:03:24.000000000 +0900
@@ -1,15 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-# Note! Dependencies are done automagically by 'make dep', which also
-# removes any old dependencies. DON'T put your own dependencies here
-# unless it's something special (ie not a .c file).
-#
-# Note 2! The CFLAGS definitions are now in the main makefile...
 
 EXTRA_CFLAGS	+= -I../kernel
-export-objs     := 
-
-obj-y				:= setup.o
 
-include $(TOPDIR)/Rules.make
+obj-y				:= setup.o topology.o
diff -Nru linux-2.5.61-ac1/arch/i386/mach-pc9800/setup.c linux98-2.5.61/arch/i386/mach-pc9800/setup.c
--- linux-2.5.61-ac1/arch/i386/mach-pc9800/setup.c	2003-02-18 08:58:20.000000000 +0900
+++ linux98-2.5.61/arch/i386/mach-pc9800/setup.c	2003-02-18 10:03:32.000000000 +0900
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/apm_bios.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 
@@ -16,9 +17,6 @@
 	unsigned char table[0];
 };
 
-/* Indicates PC-9800 architecture  No:0 Yes:1 */
-extern int pc98;
-
 /**
  * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
  *
@@ -68,7 +66,9 @@
 {
 	SYS_DESC_TABLE.length = 0;
 	MCA_bus = 0;
-	pc98 = 1;
+	/* In PC-9800, APM BIOS version is written in BCD...?? */
+	APM_BIOS_INFO.version = (APM_BIOS_INFO.version & 0xff00)
+				| ((APM_BIOS_INFO.version & 0x00f0) >> 4);
 }
 
 /**
diff -Nru linux-2.5.61/arch/i386/mach-pc9800/topology.c linux98-2.5.61/arch/i386/mach-pc9800/topology.c
--- linux-2.5.61/arch/i386/mach-pc9800/topology.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.61/arch/i386/mach-pc9800/topology.c	2003-02-16 17:19:03.000000000 +0900
@@ -0,0 +1,68 @@
+/*
+ * arch/i386/mach-generic/topology.c - Populate driverfs with topology information
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
+ *
+ * Copyright (C) 2002, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/cpu.h>
+
+struct i386_cpu cpu_devices[NR_CPUS];
+
+#ifdef CONFIG_NUMA
+#include <linux/mmzone.h>
+#include <asm/node.h>
+#include <asm/memblk.h>
+
+struct i386_node node_devices[MAX_NUMNODES];
+struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < num_online_nodes(); i++)
+		arch_register_node(i);
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	for (i = 0; i < num_online_memblks(); i++)
+		arch_register_memblk(i);
+	return 0;
+}
+
+#else /* !CONFIG_NUMA */
+
+static int __init topology_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_possible(i)) arch_register_cpu(i);
+	return 0;
+}
+
+#endif /* CONFIG_NUMA */
+
+subsys_initcall(topology_init);
diff -Nru linux98-2.5.61-ac1/drivers/block/Kconfig linux98-2.5.61/drivers/block/Kconfig
--- linux98-2.5.61-ac1/drivers/block/Kconfig	2003-02-15 08:51:20.000000000 +0900
+++ linux98-2.5.61/drivers/block/Kconfig	2003-02-17 14:20:56.000000000 +0900
@@ -6,6 +6,7 @@
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
+	depends on !X86_PC9800
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
@@ -27,6 +28,13 @@
 	tristate "Atari floppy support"
 	depends on ATARI
 
+config BLK_DEV_FD98
+	tristate "NEC PC-9800 floppy disk support"
+	depends on X86_PC9800
+	---help---
+	  If you want to use the floppy disk drive(s) of NEC PC-9801/PC-9821,
+	  say Y.
+
 config BLK_DEV_SWIM_IOP
 	bool "Macintosh IIfx/Quadra 900/Quadra 950 floppy support (EXPERIMENTAL)"
 	depends on MAC && EXPERIMENTAL
diff -Nru linux98-2.5.61-ac1/drivers/block/Makefile linux98-2.5.61/drivers/block/Makefile
--- linux98-2.5.61-ac1/drivers/block/Makefile	2003-02-18 08:58:22.000000000 +0900
+++ linux98-2.5.61/drivers/block/Makefile	2003-02-17 14:20:56.000000000 +0900
@@ -11,11 +11,8 @@
 obj-y	:= elevator.o ll_rw_blk.o ioctl.o genhd.o scsi_ioctl.o deadline-iosched.o
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
-ifneq ($(CONFIG_PC9800),y)
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
-else
-obj-$(CONFIG_BLK_DEV_FD)	+= floppy98.o
-endif
+obj-$(CONFIG_BLK_DEV_FD98)	+= floppy98.o
 obj-$(CONFIG_AMIGA_FLOPPY)	+= amiflop.o
 obj-$(CONFIG_ATARI_FLOPPY)	+= ataflop.o
 obj-$(CONFIG_BLK_DEV_SWIM_IOP)	+= swim_iop.o
diff -Nru linux-2.5.61-ac1/drivers/block/floppy98.c linux98-2.5.61/drivers/block/floppy98.c
--- linux-2.5.61-ac1/drivers/block/floppy98.c	2003-02-18 08:58:22.000000000 +0900
+++ linux98-2.5.61/drivers/block/floppy98.c	2003-02-17 14:20:56.000000000 +0900
@@ -167,6 +167,7 @@
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <linux/version.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
 
@@ -254,7 +255,6 @@
 void floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs);
 static int set_mode(char mask, char data);
 static void register_devfs_entries (int drive) __init;
-static devfs_handle_t devfs_handle;
 
 #define K_64	0x10000		/* 64KB */
 
@@ -275,9 +275,8 @@
 static int irqdma_allocated;
 
 #define LOCAL_END_REQUEST
-#define MAJOR_NR FLOPPY_MAJOR
 #define DEVICE_NAME "floppy"
-#define DEVICE_NR(device) ( (minor(device) & 3) | ((minor(device) & 0x80 ) >> 5 ))
+
 #include <linux/blk.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h> /* for the compatibility eject ioctl */
@@ -2354,7 +2353,7 @@
 	if (end_that_request_first(req, uptodate, current_count_sectors))
 		return;
 	add_disk_randomness(req->rq_disk);
-	floppy_off((int)req->rq_disk->private_data);
+	floppy_off((long)req->rq_disk->private_data);
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 
@@ -2687,7 +2686,7 @@
 		return 0;
 	}
 
-	set_fdc((int)current_req->rq_disk->private_data);
+	set_fdc((long)current_req->rq_disk->private_data);
 
 	raw_cmd = &default_raw_cmd;
 	raw_cmd->flags = FD_RAW_SPIN | FD_RAW_NEED_DISK | FD_RAW_NEED_DISK |
@@ -2967,7 +2966,11 @@
 
 	for (;;) {
 		if (!current_req) {
-			struct request *req = elv_next_request(&floppy_queue);
+			struct request *req;
+
+			spin_lock_irq(floppy_queue.queue_lock);
+			req = elv_next_request(&floppy_queue);
+			spin_unlock_irq(floppy_queue.queue_lock);
 			if (!req) {
 				do_floppy = NULL;
 				unlock_fdc();
@@ -2975,7 +2978,7 @@
 			}
 			current_req = req;
 		}
-		drive = (int)current_req->rq_disk->private_data;
+		drive = (long)current_req->rq_disk->private_data;
 		set_fdc(drive);
 		reschedule_timeout(current_reqD, "redo fd request", 0);
 
@@ -3354,7 +3357,7 @@
 static int invalidate_drive(struct block_device *bdev)
 {
 	/* invalidate the buffer track to force a reread */
-	set_bit(DRIVE(to_kdev_t(bdev->bd_dev)), &fake_change);
+	set_bit((long)bdev->bd_disk->private_data, &fake_change);
 	process_fd_request();
 	check_disk_change(bdev);
 	return 0;
@@ -3902,7 +3905,7 @@
  */
 static int check_floppy_change(struct gendisk *disk)
 {
-	int drive = (int)disk->private_data;
+	int drive = (long)disk->private_data;
 
 #ifdef PC9800_DEBUG_FLOPPY
 	printk("check_floppy_change: MINOR=%d\n", minor(dev));
@@ -4009,7 +4012,7 @@
  * geometry formats */
 static int floppy_revalidate(struct gendisk *disk)
 {
-	int drive=(int)disk->private_data;
+	int drive=(long)disk->private_data;
 #define NO_GEOM (!current_type[drive] && !ITYPE(UDRS->fd_device))
 	int cf;
 	int res = 0;
@@ -4058,27 +4061,28 @@
 	.revalidate_disk= floppy_revalidate,
 };
 
-static void __init register_devfs_entries (int drive)
-{
-    int base_minor, i;
-    static char *table[] =
-    {"",
+static char *table[] =
+{"",
 #if 0
-     "d360", 
+"d360", 
 #else
-     "h1232",
+"h1232",
 #endif
-     "h1200", "u360", "u720", "h360", "h720",
-     "u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
-     "u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
-     "h880", "u1040", "u1120", "h1600", "u1760", "u1920",
-     "u3200", "u3520", "u3840", "u1840", "u800", "u1600",
-     NULL
-    };
-    static int t360[] = {1,0}, t1200[] = {2,5,6,10,12,14,16,18,20,23,0},
-      t3in[] = {8,9,26,27,28, 7,11,15,19,24,25,29,31, 3,4,13,17,21,22,30,0};
-    static int *table_sup[] = 
-    {NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in};
+"h1200", "u360", "u720", "h360", "h720",
+"u1440", "u2880", "CompaQ", "h1440", "u1680", "h410",
+"u820", "h1476", "u1722", "h420", "u830", "h1494", "u1743",
+"h880", "u1040", "u1120", "h1600", "u1760", "u1920",
+"u3200", "u3520", "u3840", "u1840", "u800", "u1600",
+NULL
+};
+static int t360[] = {1,0}, t1200[] = {2,5,6,10,12,14,16,18,20,23,0},
+t3in[] = {8,9,26,27,28, 7,11,15,19,24,25,29,31, 3,4,13,17,21,22,30,0};
+static int *table_sup[] = 
+{NULL, t360, t1200, t3in+5+8, t3in+5, t3in, t3in};
+
+static void __init register_devfs_entries (int drive)
+{
+    int base_minor, i;
 
     base_minor = (drive < 4) ? drive : (124 + drive);
     if (UDP->cmos < NUMBER(default_drive_params)) {
@@ -4086,8 +4090,8 @@
 	do {
 	    char name[16];
 
-	    sprintf (name, "%d%s", drive, table[table_sup[UDP->cmos][i]]);
-	    devfs_register (devfs_handle, name, DEVFS_FL_DEFAULT, MAJOR_NR,
+	    sprintf(name, "floppy/%d%s", drive, table[table_sup[UDP->cmos][i]]);
+	    devfs_register(NULL, name, DEVFS_FL_DEFAULT, FLOPPY_MAJOR,
 			    base_minor + (table_sup[UDP->cmos][i] << 2),
 			    S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |S_IWGRP,
 			    &floppy_fops, NULL);
@@ -4268,21 +4272,21 @@
 			goto Enomem;
 	}
 
-	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
-	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
-		printk("Unable to get major %d for floppy\n",MAJOR_NR);
+	devfs_mk_dir (NULL, "floppy", NULL);
+	if (register_blkdev(FLOPPY_MAJOR,"fd",&floppy_fops)) {
+		printk("Unable to get major %d for floppy\n",FLOPPY_MAJOR);
 		err = -EBUSY;
 		goto out;
 	}
 
 	for (i=0; i<N_DRIVE; i++) {
-		disks[i]->major = MAJOR_NR;
+		disks[i]->major = FLOPPY_MAJOR;
 		disks[i]->first_minor = TOMINOR(i);
 		disks[i]->fops = &floppy_fops;
 		sprintf(disks[i]->disk_name, "fd%d", i);
 	}
 
-	blk_register_region(MKDEV(MAJOR_NR, 0), 256, THIS_MODULE,
+	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
 				floppy_find, NULL, NULL);
 
 	for (i=0; i<256; i++)
@@ -4390,7 +4394,7 @@
 		if (fdc_state[FDC(drive)].version == FDC_NONE)
 			continue;
 		/* to be cleaned up... */
-		disks[drive]->private_data = (void*)drive;
+		disks[drive]->private_data = (void*)(long)drive;
 		disks[drive]->queue = &floppy_queue;
 		add_disk(disks[drive]);
 	}
@@ -4401,8 +4405,8 @@
 out1:
 	del_timer(&fd_timeout);
 out2:
-	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
-	unregister_blkdev(MAJOR_NR,"fd");
+	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
+	unregister_blkdev(FLOPPY_MAJOR,"fd");
 	blk_cleanup_queue(&floppy_queue);
 out:
 	for (i=0; i<N_DRIVE; i++)
@@ -4592,6 +4596,18 @@
 
 char *floppy;
 
+static void unregister_devfs_entries (int drive)
+{
+    int i;
+
+    if (UDP->cmos < NUMBER(default_drive_params)) {
+	i = 0;
+	do {
+	    devfs_remove("floppy/%d%s", drive, table[table_sup[UDP->cmos][i]]);
+	} while (table_sup[UDP->cmos][i++]);
+    }
+}
+
 static void __init parse_floppy_cfg_string(char *cfg)
 {
 	char *ptr;
@@ -4621,15 +4637,17 @@
 	int drive;
 		
 	platform_device_unregister(&floppy_device);
-	devfs_unregister (devfs_handle);
-	blk_unregister_region(MKDEV(MAJOR_NR, 0), 256);
-	unregister_blkdev(MAJOR_NR, "fd");
+	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
+	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	for (drive = 0; drive < N_DRIVE; drive++) {
 		if ((allowed_drive_mask & (1 << drive)) &&
-		    fdc_state[FDC(drive)].version != FDC_NONE)
+		    fdc_state[FDC(drive)].version != FDC_NONE) {
 			del_gendisk(disks[drive]);
+			unregister_devfs_entries(drive);
+		}
 		put_disk(disks[drive]);
 	}
+	devfs_remove("floppy");
 
 	blk_cleanup_queue(&floppy_queue);
 	/* eject disk, if any */
diff -Nru linux-2.5.61-ac1/drivers/char/Kconfig linux98-2.5.61/drivers/char/Kconfig
--- linux-2.5.61-ac1/drivers/char/Kconfig	2003-02-18 08:58:22.000000000 +0900
+++ linux98-2.5.61/drivers/char/Kconfig	2003-02-17 14:20:55.000000000 +0900
@@ -577,7 +577,7 @@
 
 config PC9800_OLDLP
 	tristate "NEC PC-9800 old-style printer port support"
-	depends on PC9800 && !PARPORT
+	depends on X86_PC9800 && !PARPORT
 	---help---
 	  If you intend to attach a printer to the parallel port of NEC PC-9801
 	  /PC-9821 with OLD compatibility mode, Say Y.
@@ -785,7 +785,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !PC9800
+	depends on !PPC32 && !PARISC && !IA64 && !X86_PC9800
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
@@ -846,7 +846,7 @@
 
 config RTC98
 	tristate "NEC PC-9800 Real Time Clock Support"
-	depends on PC9800
+	depends on X86_PC9800
 	default y
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
diff -Nru linux-2.5.60/drivers/char/Makefile linux98-2.5.60/drivers/char/Makefile
--- linux-2.5.60/drivers/char/Makefile	2003-02-11 03:38:54.000000000 +0900
+++ linux98-2.5.60/drivers/char/Makefile	2003-02-11 11:19:09.000000000 +0900
@@ -44,6 +44,7 @@
 
 obj-$(CONFIG_PRINTER) += lp.o
 obj-$(CONFIG_TIPAR) += tipar.o
+obj-$(CONFIG_PC9800_OLDLP) += lp_old98.o
 
 obj-$(CONFIG_BUSMOUSE) += busmouse.o
 obj-$(CONFIG_DTLK) += dtlk.o
@@ -51,6 +52,7 @@
 obj-$(CONFIG_APPLICOM) += applicom.o
 obj-$(CONFIG_SONYPI) += sonypi.o
 obj-$(CONFIG_RTC) += rtc.o
+obj-$(CONFIG_RTC98) += upd4990a.o
 obj-$(CONFIG_GEN_RTC) += genrtc.o
 obj-$(CONFIG_EFI_RTC) += efirtc.o
 ifeq ($(CONFIG_PPC),)
diff -Nru linux-2.5.61-ac1/drivers/char/lp_old98.c linux98-2.5.61/drivers/char/lp_old98.c
--- linux-2.5.61-ac1/drivers/char/lp_old98.c	2003-02-18 08:58:22.000000000 +0900
+++ linux98-2.5.61/drivers/char/lp_old98.c	2003-02-19 23:34:12.000000000 +0900
@@ -10,45 +10,35 @@
  * generic PC printer port driver.
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
 #include <linux/delay.h>
 #include <linux/console.h>
 #include <linux/version.h>
+#include <linux/fs.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-#if !defined(CONFIG_PC9800) && !defined(CONFIG_PC98)
-#error This driver works only for NEC PC-9800 series
-#endif
-
-#if LINUX_VERSION_CODE < 0x20200
-# define LP_STATS
-#endif
-
-#if LINUX_VERSION_CODE >= 0x2030b
-# define CONFIG_RESOURCE98
-#endif
-
 #include <linux/lp.h>
 
 /*
  *  I/O port numbers
  */
 #define	LP_PORT_DATA	0x40
-#define	LP_PORT_STATUS	(LP_PORT_DATA+2)
-#define	LP_PORT_STROBE	(LP_PORT_DATA+4)
-#define LP_PORT_CONTROL	(LP_PORT_DATA+6)
+#define	LP_PORT_STATUS	(LP_PORT_DATA + 2)
+#define	LP_PORT_STROBE	(LP_PORT_DATA + 4)
+#define LP_PORT_CONTROL	(LP_PORT_DATA + 6)
 
 #define	LP_PORT_H98MODE	0x0448
 #define	LP_PORT_EXTMODE	0x0149
@@ -72,40 +62,25 @@
 
 /* PC-9800s have at least and at most one old-style printer port. */
 static struct lp_struct lp = {
-	/* Following `TAG: INITIALIZER' notations are GNU CC extension. */
-	flags:	LP_EXIST | LP_ABORTOPEN,
-	chars:	LP_INIT_CHAR,
-	time:	LP_INIT_TIME,
-	wait:	LP_INIT_WAIT,
+	.flags	= LP_EXIST | LP_ABORTOPEN,
+	.chars	= LP_INIT_CHAR,
+	.time	= LP_INIT_TIME,
+	.wait	= LP_INIT_WAIT,
 };
 
-static	int	dc1_check	= 1000;
+static	int	dc1_check	= 0;
+static spinlock_t lp_old98_lock = SPIN_LOCK_UNLOCKED;
 
-#undef LP_OLD98_DEBUG
-
-#ifndef __udelay_val
-# define __udelay_val current_cpu_data.loops_per_sec
-#endif
 
-static inline void nanodelay(unsigned long nanosecs)	/* Evil ? */
-{
-	if( nanosecs ) {
-		nanosecs *= (unsigned long)((1ULL << 40) / 1000000000ULL);
-		__asm__("mul%L2 %2"
-			: "=d"(nanosecs) : "a"(nanosecs), "g"(__udelay_val));
-		__delay(nanosecs >> 8);
-	}
-}
+#undef LP_OLD98_DEBUG
 
 #ifdef CONFIG_PC9800_OLDLP_CONSOLE
 static struct console lp_old98_console;		/* defined later */
-static __typeof__(lp_old98_console.flags) saved_console_flags;
+static short saved_console_flags;
 #endif
 
 static DECLARE_WAIT_QUEUE_HEAD (lp_old98_waitq);
 
-static void lp_old98_timer_function(unsigned long data);
-
 static void lp_old98_timer_function(unsigned long data)
 {
 	if (inb(LP_PORT_STATUS) & LP_MASK_nBUSY)
@@ -118,15 +93,14 @@
 	}
 }
 
-static inline int
-lp_old98_wait_ready(void)
+static inline int lp_old98_wait_ready(void)
 {
 	struct timer_list timer;
 
 	init_timer(&timer);
 	timer.function = lp_old98_timer_function;
 	timer.expires = jiffies + 1;
-	timer.data = (unsigned long) &timer;
+	timer.data = (unsigned long)&timer;
 	add_timer(&timer);
 	interruptible_sleep_on(&lp_old98_waitq);
 	del_timer(&timer);
@@ -140,7 +114,7 @@
 	int tmp;
 #endif
 
-	while( !(inb(LP_PORT_STATUS) & LP_MASK_nBUSY) ) {
+	while (!(inb(LP_PORT_STATUS) & LP_MASK_nBUSY)) {
 		count++;
 		if (count >= lp.chars)
 			return 0;
@@ -153,7 +127,7 @@
 	 *  Update lp statsistics here (and between next two outb()'s).
 	 *  Time to compute it is part of storobe delay.
 	 */
-	if( count > lp.stats.maxwait ) {
+	if (count > lp.stats.maxwait) {
 #ifdef LP_OLD98_DEBUG
 		printk(KERN_DEBUG "lp_old98: success after %d counts.\n",
 		       count);
@@ -162,10 +136,10 @@
 	}
 	count *= 256;
 	tmp = count - lp.stats.meanwait;
-	if( tmp < 0 )
+	if (tmp < 0)
 		tmp = -tmp;
 #endif
-	nanodelay(lp.wait);
+	__const_udelay(lp.wait * 4);
     
 	/* negate PSTB# (activate strobe)	*/
 	outb(LP_CONTROL_ASSERT_STROBE, LP_PORT_CONTROL);
@@ -173,10 +147,10 @@
 #ifdef LP_STATS
 	lp.stats.meanwait = (255 * lp.stats.meanwait + count + 128) / 256;
 	lp.stats.mdev = (127 * lp.stats.mdev + tmp + 64) / 128;
-	lp.stats.chars++;
+	lp.stats.chars ++;
 #endif
 
-	nanodelay(lp.wait);
+	__const_udelay(lp.wait * 4);
 
 	/* assert PSTB# (deactivate strobe)	*/
 	outb(LP_CONTROL_NEGATE_STROBE, LP_PORT_CONTROL);
@@ -184,14 +158,9 @@
 	return 1;
 }
 
-#if LINUX_VERSION_CODE < 0x20200
-static long lp_old98_write(struct inode * inode, struct file * file,
-			   const char * buf, unsigned long count)
-#else
 static ssize_t lp_old98_write(struct file * file,
 			      const char * buf, size_t count,
 			      loff_t *dummy)
-#endif    
 {
 	unsigned long total_bytes_written = 0;
 
@@ -199,7 +168,7 @@
 		return -EFAULT;
 
 #ifdef LP_STATS
-	if( jiffies - lp.lastcall > lp.time )
+	if (jiffies - lp.lastcall > lp.time)
 		lp.runchars = 0;
 	lp.lastcall = jiffies;
 #endif
@@ -212,17 +181,17 @@
 		if (__copy_from_user(lp.lp_buffer, buf, copy_size))
 			return -EFAULT;
 
-		while( bytes_written < copy_size ) {
-			if( lp_old98_char(lp.lp_buffer[bytes_written]) )
-				bytes_written++;
+		while (bytes_written < copy_size) {
+			if (lp_old98_char(lp.lp_buffer[bytes_written]))
+				bytes_written ++;
 			else {
 #ifdef LP_STATS
 				int rc = lp.runchars + bytes_written;
 
-				if( rc > lp.stats.maxrun )
+				if (rc > lp.stats.maxrun)
 					lp.stats.maxrun = rc;
 
-				lp.stats.sleeps++;
+				lp.stats.sleeps ++;
 #endif
 #ifdef LP_OLD98_DEBUG
 				printk(KERN_DEBUG
@@ -243,29 +212,21 @@
 		lp.runchars += bytes_written;
 #endif
 		count -= bytes_written;
-	} while( count > 0 );
+	} while (count > 0);
 
 	return total_bytes_written;
 }
 
-static long long lp_old98_llseek(struct file * file,
-				long long offset, int whence)
-{
-	return -ESPIPE;	/* cannot seek like pipe */
-}
-
 static int lp_old98_open(struct inode * inode, struct file * file)
 {
-	if( MINOR(inode->i_rdev) != 0 )
+	if (minor(inode->i_rdev) != 0)
 		return -ENXIO;
-	if( lp.flags & LP_BUSY )
-		return -EBUSY;
 
-	if ((lp.lp_buffer = kmalloc(LP_BUFFER_SIZE, GFP_KERNEL)) == NULL)
-		return -ENOMEM;
+	if (lp.flags & LP_BUSY)
+		return -EBUSY;
 
 	if (dc1_check && (lp.flags & LP_ABORTOPEN)
-	    && !(file->f_flags & O_NONBLOCK) ) {
+	    && !(file->f_flags & O_NONBLOCK)) {
 		/*
 		 *  Check whether printer is on-line.
 		 *  PC-9800's old style port have only BUSY# as status input,
@@ -284,32 +245,34 @@
 		 *		`PC-9801 Super Technique', Ascii, 1992.
 		 */
 		int count;
-		unsigned long eflags;
+		unsigned long flags;
 
-		save_flags(eflags);
-		cli();		/* interrupts while check is fairly bad */
+		/* interrupts while check is fairly bad */
+		spin_lock_irqsave(&lp_old98_lock, flags);
 
 		if (!lp_old98_char(DC1)) {
-			restore_flags(eflags);
+			spin_unlock_irqrestore(&lp_old98_lock, flags);
 			return -EBUSY;
 		}
 		count = (unsigned int)dc1_check > 10000 ? 10000 : dc1_check;
-		while( inb(LP_PORT_STATUS) & LP_MASK_nBUSY )
-			if( --count == 0 ) {
-				restore_flags(eflags);
+		while (inb(LP_PORT_STATUS) & LP_MASK_nBUSY) {
+			if (--count == 0) {
+				spin_unlock_irqrestore(&lp_old98_lock, flags);
 				return -ENODEV;
 			}
-		restore_flags(eflags);
+		}
+		spin_unlock_irqrestore(&lp_old98_lock, flags);
 	}
 
+	if ((lp.lp_buffer = kmalloc(LP_BUFFER_SIZE, GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
 	lp.flags |= LP_BUSY;
 
 #ifdef CONFIG_PC9800_OLDLP_CONSOLE
 	saved_console_flags = lp_old98_console.flags;
 	lp_old98_console.flags &= ~CON_ENABLED;
 #endif
-
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -321,7 +284,6 @@
 #ifdef CONFIG_PC9800_OLDLP_CONSOLE
 	lp_old98_console.flags = saved_console_flags;
 #endif
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -329,14 +291,14 @@
 {
 	unsigned char data;
 
-	if( (data = inb(LP_PORT_EXTMODE)) != 0xFF && (data & 0x10) ) {
+	if ((data = inb(LP_PORT_EXTMODE)) != 0xFF && (data & 0x10)) {
 		printk(KERN_INFO
 		       "lp_old98: shutting down extended parallel port mode...\n");
 		outb(data & ~0x10, LP_PORT_EXTMODE);
 	}
 #ifdef	PC98_HW_H98
-	if( (pc98_hw_flags & PC98_HW_H98)
-	    && ((data = inb(LP_PORT_H98MODE)) & 0x01) ) {
+	if ((pc98_hw_flags & PC98_HW_H98)
+	    && ((data = inb(LP_PORT_H98MODE)) & 0x01)) {
 		printk(KERN_INFO
 		       "lp_old98: shutting down H98 full centronics mode...\n");
 		outb(data & ~0x01, LP_PORT_H98MODE);
@@ -345,20 +307,12 @@
 	return 0;
 }
 
-/*
- *  Many use of `put_user' macro enlarge code size...
- */
-static /* not inline */ int lp_old98_put_user(int val, int *addr)
-{
-	return put_user(val, addr);
-}
-
 static int lp_old98_ioctl(struct inode *inode, struct file *file,
 			  unsigned int command, unsigned long arg)
 {
 	int retval = 0;
 
-	switch ( command ) {
+	switch (command) {
 	case LPTIME:
 		lp.time = arg * HZ/100;
 		break;
@@ -366,13 +320,13 @@
 		lp.chars = arg;
 		break;
 	case LPABORT:
-		if( arg )
+		if (arg)
 			lp.flags |= LP_ABORT;
 		else
 			lp.flags &= ~LP_ABORT;
 		break;
 	case LPABORTOPEN:
-		if( arg )
+		if (arg)
 			lp.flags |= LP_ABORTOPEN;
 		else
 			lp.flags &= ~LP_ABORTOPEN;
@@ -384,33 +338,31 @@
 		lp.wait = arg;
 		break;
 	case LPGETIRQ:
-		retval = lp_old98_put_user(0, (int *)arg);
+		retval = put_user(0, (int *)arg);
 		break;
 	case LPGETSTATUS:
 		/*
 		 * convert PC-9800's status to IBM PC's one, so that tunelp(8)
 		 * works in the same way on this driver.
 		 */
-		retval = lp_old98_put_user((inb(LP_PORT_STATUS)
-					    & LP_MASK_nBUSY)
-					   ? (LP_PBUSY | LP_PERRORP)
-					   : LP_PERRORP,
-					   (int *)arg);
+		retval = put_user((inb(LP_PORT_STATUS) & LP_MASK_nBUSY)
+					? (LP_PBUSY | LP_PERRORP) : LP_PERRORP,
+					(int *)arg);
 		break;
 	case LPRESET:
 		retval = lp_old98_init_device();
 		break;
 #ifdef LP_STATS
 	case LPGETSTATS:
-		if( copy_to_user((struct lp_stats *)arg, &lp.stats,
-				 sizeof(struct lp_stats)) )
+		if (copy_to_user((struct lp_stats *)arg, &lp.stats,
+				 sizeof(struct lp_stats)))
 			retval = -EFAULT;
 		else if (suser())
 			memset(&lp.stats, 0, sizeof(struct lp_stats));
 		break;
 #endif
 	case LPGETFLAGS:
-		retval = lp_old98_put_user(lp.flags, (int *)arg);
+		retval = put_user(lp.flags, (int *)arg);
 		break;
 	case LPSETIRQ: 
 	default:
@@ -420,15 +372,13 @@
 }
 
 static struct file_operations lp_old98_fops = {
-	owner:	THIS_MODULE,
-	llseek:	lp_old98_llseek,
-	read:	NULL,
-	write:	lp_old98_write,
-	ioctl:	lp_old98_ioctl,
-	open:	lp_old98_open,
-	release:lp_old98_release,
+	.owner		= THIS_MODULE,
+	.write		= lp_old98_write,
+	.ioctl		= lp_old98_ioctl,
+	.open		= lp_old98_open,
+	.release	= lp_old98_release,
 };
-
+
 /*
  *  Support for console on lp_old98
  */
@@ -449,9 +399,8 @@
 
 	while (count) {
 		/* wait approx 1.2 seconds */
-		for (i = 2000000;
-		     !(inb(LP_PORT_STATUS) & LP_MASK_nBUSY);
-		     io_delay())
+		for (i = 2000000; !(inb(LP_PORT_STATUS) & LP_MASK_nBUSY);
+								io_delay())
 			if (!--i) {
 				if (++timeout_run >= 10)
 					/* disable forever... */
@@ -472,8 +421,8 @@
 			io_delay();
 			io_delay();
 			for (i = 1000000;
-			     !(inb(LP_PORT_STATUS) & LP_MASK_nBUSY);
-			     io_delay())
+					!(inb(LP_PORT_STATUS) & LP_MASK_nBUSY);
+					io_delay())
 				if (!--i)
 					return;
 		}
@@ -494,67 +443,69 @@
 
 static kdev_t lp_old98_console_device(struct console *console)
 {
-	return MKDEV(LP_MAJOR, 0);
+	return mk_kdev(LP_MAJOR, 0);
 }
 
 static struct console lp_old98_console = {
-	name:	"lp_old98",
-	write:	lp_old98_console_write,
-	device:	lp_old98_console_device,
-	flags:	CON_PRINTBUFFER,
-	index:	-1,
+	.name	= "lp_old98",
+	.write	= lp_old98_console_write,
+	.device	= lp_old98_console_device,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
 };
 
 #endif	/* console on lp_old98 */
-
-#ifdef MODULE
-#define lp_old98_init init_module
-#endif
 
-int __init lp_old98_init(void)
+static int __init lp_old98_init(void)
 {
-	if (check_region(LP_PORT_DATA, 1) || check_region(LP_PORT_STATUS, 1)
-	    || check_region(LP_PORT_STROBE, 1)
-#ifdef	PC98_HW_H98
-	    || ((pc98_hw_flags & PC98_HW_H98)
-		&& check_region(LP_PORT_H98MODE, 1))
-#endif
-	    || check_region(LP_PORT_EXTMODE, 1)) {
-		printk(KERN_ERR
-		       "lp_old98: I/O ports already occupied, giving up.\n");
-		return -EBUSY;
-	}
-	if (register_chrdev(LP_MAJOR, "lp", &lp_old98_fops)) {
-		printk(KERN_ERR "lp_old98: unable to get major %d\n",
-		       LP_MAJOR);
-		return -EBUSY;
-	}
+	char *errmsg = "I/O ports already occupied, giving up.";
 
+#ifdef	PC98_HW_H98
+	if (pc98_hw_flags & PC98_HW_H98)
+	    if (!request_region(LP_PORT_H98MODE, 1, "lp_old98")
+		goto err1;
+#endif
+	if (!request_region(LP_PORT_DATA,   1, "lp_old98"))
+		goto err2;
+	if (!request_region(LP_PORT_STATUS, 1, "lp_old98"))
+		goto err3;
+	if (!request_region(LP_PORT_STROBE, 1, "lp_old98"))
+		goto err4;
+	if (!request_region(LP_PORT_EXTMODE, 1, "lp_old98"))
+		goto err5;
+	if (!register_chrdev(LP_MAJOR, "lp", &lp_old98_fops)) {
 #ifdef CONFIG_PC9800_OLDLP_CONSOLE
-	register_console(&lp_old98_console);
-	printk(KERN_INFO "lp_old98: console ready\n");
+		register_console(&lp_old98_console);
+		printk(KERN_INFO "lp_old98: console ready\n");
 #endif
+		/*
+		 * rest are not needed by this driver,
+		 * but for locking out other printer drivers...
+		 */
+		lp_old98_init_device();
+		return 0;
+	} else
+		errmsg = "unable to register device";
 
-	request_region(LP_PORT_DATA,   1, "lp_old98");
-	request_region(LP_PORT_STATUS, 1, "lp_old98");
-	request_region(LP_PORT_STROBE, 1, "lp_old98");
-
-	/*
-	 * rest are not needed by this driver,
-	 * but for locking out other printer drivers...
-	 */
+	release_region(LP_PORT_EXTMODE, 1);
+	err5:
+	release_region(LP_PORT_STROBE, 1);
+	err4:
+	release_region(LP_PORT_STATUS, 1);
+	err3:
+	release_region(LP_PORT_DATA, 1);
+	err2:
 #ifdef	PC98_HW_H98
-	if( pc98_hw_flags & PC98_HW_H98 )
-		request_region(LP_PORT_H98MODE, 1, "lp_old98");
-#endif
-	request_region(LP_PORT_EXTMODE, 1, "lp_old98");
-	lp_old98_init_device();
+	if (pc98_hw_flags & PC98_HW_H98)
+	    release_region(LP_PORT_H98MODE, 1);
 
-	return 0;
+	err1:
+#endif
+	printk(KERN_ERR "lp_old98: %s\n", errmsg);
+	return -EBUSY;
 }
 
-#ifdef MODULE
-void cleanup_module(void)
+static void __exit lp_old98_exit(void)
 {
 #ifdef CONFIG_PC9800_OLDLP_CONSOLE
 	unregister_console(&lp_old98_console);
@@ -565,13 +516,29 @@
 	release_region(LP_PORT_STATUS, 1);
 	release_region(LP_PORT_STROBE, 1);
 #ifdef	PC98_HW_H98
-	if( pc98_hw_flags & PC98_HW_H98 )
+	if (pc98_hw_flags & PC98_HW_H98)
 		release_region(LP_PORT_H98MODE, 1);
 #endif
 	release_region(LP_PORT_EXTMODE, 1);
 }
 
-MODULE_PARM(dc1_check, "1i");
-MODULE_AUTHOR("Kousuke Takai <tak@kmc.kyoto-u.ac.jp>");
+#ifndef MODULE
+static int __init lp_old98_setup(char *str)
+{
+        int ints[4];
 
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0)
+		dc1_check = ints[1];
+        return 1;
+}
+__setup("lp_old98_dc1_check=", lp_old98_setup);
 #endif
+
+MODULE_PARM(dc1_check, "i");
+MODULE_AUTHOR("Kousuke Takai <tak@kmc.kyoto-u.ac.jp>");
+MODULE_DESCRIPTION("PC-9800 old printer port driver");
+MODULE_LICENSE("GPL");
+
+module_init(lp_old98_init);
+module_exit(lp_old98_exit);
diff -Nru linux-2.5.61-ac1/drivers/char/upd4990a.c linux98-2.5.61/drivers/char/upd4990a.c
--- linux-2.5.61-ac1/drivers/char/upd4990a.c	2003-02-18 08:58:23.000000000 +0900
+++ linux98-2.5.61/drivers/char/upd4990a.c	2003-02-17 14:20:55.000000000 +0900
@@ -51,8 +51,6 @@
 static struct timer_list rtc_uie_timer;
 static u8 old_refclk;
 
-static long long rtc_llseek(struct file *file, loff_t offset, int origin);
-
 static int rtc_ioctl(struct inode *inode, struct file *file,
 			unsigned int cmd, unsigned long arg);
 
@@ -114,11 +112,6 @@
  *	Now all the various file operations that we export.
  */
 
-static long long rtc_llseek(struct file *file, loff_t offset, int origin)
-{
-	return -ESPIPE;
-}
-
 static ssize_t rtc_read(struct file *file, char *buf,
 			size_t count, loff_t *ppos)
 {
@@ -335,14 +328,14 @@
  */
 
 static struct file_operations rtc_fops = {
-	owner:		THIS_MODULE,
-	llseek:		rtc_llseek,
-	read:		rtc_read,
-	poll:		rtc_poll,
-	ioctl:		rtc_ioctl,
-	open:		rtc_open,
-	release:	rtc_release,
-	fasync:		rtc_fasync,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= rtc_read,
+	.poll		= rtc_poll,
+	.ioctl		= rtc_ioctl,
+	.open		= rtc_open,
+	.release	= rtc_release,
+	.fasync		= rtc_fasync,
 };
 
 static struct miscdevice rtc_dev=
@@ -389,8 +382,6 @@
 module_exit (rtc_exit);
 #endif
 
-EXPORT_NO_SYMBOLS;
-
 /*
  *	Info exported via "/proc/driver/rtc".
  */
diff -Nru linux-2.5.61-ac1/drivers/input/keyboard/Kconfig linux98-2.5.61/drivers/input/keyboard/Kconfig
--- linux-2.5.61-ac1/drivers/input/keyboard/Kconfig	2003-02-18 08:58:23.000000000 +0900
+++ linux98-2.5.61/drivers/input/keyboard/Kconfig	2003-02-17 14:20:56.000000000 +0900
@@ -92,7 +92,7 @@
 
 config KEYBOARD_98KBD
 	tristate "NEC PC-9800 Keyboard support"
-	depends on PC9800 && INPUT && INPUT_KEYBOARD && SERIO
+	depends on X86_PC9800 && INPUT && INPUT_KEYBOARD && SERIO
 	help
 	  Say Y here if you want to use the NEC PC-9801/PC-9821 keyboard (or
 	  compatible) on your system. 
diff -Nru linux-2.5.61-ac1/drivers/input/mouse/98busmouse.c linux98-2.5.61/drivers/input/mouse/98busmouse.c
--- linux-2.5.61-ac1/drivers/input/mouse/98busmouse.c	2003-02-18 08:58:23.000000000 +0900
+++ linux98-2.5.61/drivers/input/mouse/98busmouse.c	2003-02-17 14:20:56.000000000 +0900
@@ -31,15 +31,16 @@
  * 
  */
 
-#include <asm/io.h>
-#include <asm/irq.h>
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
 
 MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
 MODULE_DESCRIPTION("PC-9801 busmouse driver");
diff -Nru linux-2.5.61-ac1/drivers/input/mouse/Kconfig linux98-2.5.61/drivers/input/mouse/Kconfig
--- linux-2.5.61-ac1/drivers/input/mouse/Kconfig	2003-02-18 08:58:23.000000000 +0900
+++ linux98-2.5.61/drivers/input/mouse/Kconfig	2003-02-17 14:20:56.000000000 +0900
@@ -123,7 +123,7 @@
 
 config MOUSE_PC9800
 	tristate "NEC PC-9800 busmouse"
-	depends on PC9800 && INPUT && INPUT_MOUSE && ISA
+	depends on X86_PC9800 && INPUT && INPUT_MOUSE && ISA
 	help
 	  Say Y here if you have NEC PC-9801/PC-9821 computer and want its
 	  native mouse supported.
diff -Nru linux-2.5.61-ac1/drivers/input/serio/98kbd-io.c linux98-2.5.61/drivers/input/serio/98kbd-io.c
--- linux-2.5.61-ac1/drivers/input/serio/98kbd-io.c	2003-02-18 08:58:23.000000000 +0900
+++ linux98-2.5.61/drivers/input/serio/98kbd-io.c	2003-02-17 14:20:56.000000000 +0900
@@ -11,16 +11,17 @@
  * the Free Software Foundation.
  */
 
-#include <asm/io.h>
-
+#include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/serio.h>
 #include <linux/sched.h>
 
+#include <asm/io.h>
+
 MODULE_AUTHOR("Osamu Tomita <tomita@cinet.co.jp>");
 MODULE_DESCRIPTION("NEC PC-9801 keyboard controller driver");
 MODULE_LICENSE("GPL");
@@ -147,15 +148,11 @@
 	unsigned long flags;
 	unsigned char data;
 
-#ifdef CONFIG_VT
-	kbd_pt_regs = regs;
-#endif
-
 	spin_lock_irqsave(&kbd98io_lock, flags);
 
 	data = inb(KBD98_DATA_REG);
 	spin_unlock_irqrestore(&kbd98io_lock, flags);
-	serio_interrupt(&kbd98_port, data, 0);
+	serio_interrupt(&kbd98_port, data, 0, regs);
 
 }
 
diff -Nru linux-2.5.61-ac1/drivers/input/serio/Kconfig linux98-2.5.61/drivers/input/serio/Kconfig
--- linux-2.5.61-ac1/drivers/input/serio/Kconfig	2003-02-18 08:58:23.000000000 +0900
+++ linux98-2.5.61/drivers/input/serio/Kconfig	2003-02-17 14:20:56.000000000 +0900
@@ -109,7 +109,7 @@
 
 config SERIO_98KBD
 	tristate "NEC PC-9800 keyboard controller"
-	depends on PC9800 && SERIO
+	depends on X86_PC9800 && SERIO
 	help
 	  Say Y here if you have the NEC PC-9801/PC-9821 and want to use its
 	  standard keyboard connected to its keyboard controller.
diff -Nru linux-2.5.61-ac1/drivers/pci/quirks.c linux98-2.5.61-ac1/drivers/pci/quirks.c
--- linux-2.5.61-ac1/drivers/pci/quirks.c	2003-02-18 08:58:25.000000000 +0900
+++ linux98-2.5.61-ac1/drivers/pci/quirks.c	2003-02-18 14:58:45.000000000 +0900
@@ -560,6 +560,8 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C596,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82371SB_0,  quirk_isa_dma_hangs },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_1,	quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	quirk_isa_dma_hangs },
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_dma_hangs },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82437, 	quirk_triton }, 
diff -Nru linux-2.5.60/drivers/video/console/Makefile linux98-2.5.60/drivers/video/console/Makefile
--- linux-2.5.60/drivers/video/console/Makefile	2003-02-11 03:38:30.000000000 +0900
+++ linux98-2.5.60/drivers/video/console/Makefile	2003-02-11 09:47:18.000000000 +0900
@@ -19,6 +19,7 @@
 # Each configuration option enables a list of files.
 
 obj-$(CONFIG_DUMMY_CONSOLE)       += dummycon.o
+obj-$(CONFIG_GDC_CONSOLE)         += gdccon.o
 obj-$(CONFIG_SGI_NEWPORT_CONSOLE) += newport_con.o
 obj-$(CONFIG_PROM_CONSOLE)        += promcon.o promcon_tbl.o
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
diff -Nru linux-2.5.61/drivers/video/console/gdccon.c linux98-2.5.61/drivers/video/console/gdccon.c
--- linux-2.5.61/drivers/video/console/gdccon.c	1970-01-01 09:00:00.000000000 +0900
+++ linux98-2.5.61/drivers/video/console/gdccon.c	2003-02-16 17:19:03.000000000 +0900
@@ -0,0 +1,833 @@
+/*
+ * linux/drivers/video/gdccon.c
+ * Low level GDC based console driver for NEC PC-9800 series
+ *
+ * Created 24 Dec 1998 by Linux/98 project
+ *
+ * based on:
+ * linux/drivers/video/vgacon.c in Linux 2.1.131 by Geert Uytterhoeven
+ * linux/char/gdc.c in Linux/98 2.1.57 by Linux/98 project
+ * linux/char/console.c in Linux/98 2.1.57 by Linux/98 project
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/kd.h>
+#include <linux/slab.h>
+#include <linux/vt_kern.h>
+#include <linux/selection.h>
+#include <linux/spinlock.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/pc9800.h>
+
+static spinlock_t gdc_lock = SPIN_LOCK_UNLOCKED;
+
+static char str_gdc_master[] = "GDC (master)";
+static char str_gdc_slave[] = "GDC (slave)";
+static char str_crtc[] = "crtc";
+static struct resource gdc_console_resources[] = {
+    {str_gdc_master, 0x60, 0x60, 0},
+    {str_gdc_master, 0x62, 0x62, 0},
+    {str_gdc_master, 0x64, 0x64, 0},
+    {str_gdc_master, 0x66, 0x66, 0},
+    {str_gdc_master, 0x68, 0x68, 0},
+    {str_gdc_master, 0x6a, 0x6a, 0},
+    {str_gdc_master, 0x6c, 0x6c, 0},
+    {str_gdc_master, 0x6e, 0x6e, 0},
+    {str_crtc, 0x70, 0x70, 0},
+    {str_crtc, 0x72, 0x72, 0},
+    {str_crtc, 0x74, 0x74, 0},
+    {str_crtc, 0x76, 0x76, 0},
+    {str_crtc, 0x78, 0x78, 0},
+    {str_crtc, 0x7a, 0x7a, 0},
+    {str_gdc_slave, 0xa0, 0xa0, 0},
+    {str_gdc_slave, 0xa2, 0xa2, 0},
+    {str_gdc_slave, 0xa4, 0xa4, 0},
+    {str_gdc_slave, 0xa6, 0xa6, 0},
+};
+
+#define GDC_CONSOLE_RESOURCES (sizeof(gdc_console_resources)/sizeof(struct resource))
+
+#define BLANK 0x0020
+#define BLANK_ATTR 0x00e1
+
+/* GDC/GGDC port# */
+#define GDC_COMMAND 0x62
+#define GDC_PARAM 0x60
+#define GDC_STAT 0x60
+#define GDC_DATA 0x62
+
+#define MODE_FF1	(0x0068)	/* mode F/F register 1 */
+
+#define  MODE_FF1_ATR_SEL	(0x00)	/* 0: vertical line 1: 8001 graphic */
+#define  MODE_FF1_GRAPHIC_MODE	(0x02)	/* 0: color 1: mono */
+#define  MODE_FF1_COLUMN_WIDTH	(0x04)	/* 0: 80col 1: 40col */
+#define  MODE_FF1_FONT_SEL	(0x06)	/* 0: 6x8 1: 7x13 */
+#define  MODE_FF1_GRP_MODE	(0x08)	/* 0: display odd-y raster 1: not */
+#define  MODE_FF1_KAC_MODE	(0x0a)	/* 0: code access 1: dot access */
+#define  MODE_FF1_NVMW_PERMIT	(0x0c)	/* 0: protect 1: permit */
+#define  MODE_FF1_DISP_ENABLE	(0x0e)	/* 0: enable 1: disable */
+
+#define GGDC_COMMAND 0xa2
+#define GGDC_PARAM 0xa0
+#define GGDC_STAT 0xa0
+#define GGDC_DATA 0xa2
+
+/* GDC status */
+#define GDC_DATA_READY		(1 << 0)
+#define GDC_FIFO_FULL		(1 << 1)
+#define GDC_FIFO_EMPTY		(1 << 2)
+#define GGDC_FIFO_EMPTY		GDC_FIFO_EMPTY
+#define GDC_DRAWING		(1 << 3)
+#define GDC_DMA_EXECUTE		(1 << 4)	/* nonsense on 98 */
+#define GDC_VERTICAL_SYNC	(1 << 5)
+#define GDC_HORIZONTAL_BLANK	(1 << 6)
+#define GDC_LIGHTPEN_DETECT	(1 << 7)	/* nonsense on 98 */
+
+#define ATTR_G		(1U << 7)
+#define ATTR_R		(1U << 6)
+#define ATTR_B		(1U << 5)
+#define ATTR_GRAPHIC	(1U << 4)
+#define ATTR_VERTBAR	ATTR_GRAPHIC	/* vertical bar */
+#define ATTR_UNDERLINE	(1U << 3)
+#define ATTR_REVERSE	(1U << 2)
+#define ATTR_BLINK	(1U << 1)
+#define ATTR_NOSECRET	(1U << 0)
+#define AMASK_NOCOLOR	(ATTR_GRAPHIC | ATTR_UNDERLINE | ATTR_REVERSE \
+			 | ATTR_BLINK | ATTR_NOSECRET)
+
+/*
+ *  Interface used by the world
+ */
+static const char *gdccon_startup(void);
+static void gdccon_init(struct vc_data *c, int init);
+static void gdccon_deinit(struct vc_data *c);
+static void gdccon_cursor(struct vc_data *c, int mode);
+static int gdccon_switch(struct vc_data *c);
+static int gdccon_blank(struct vc_data *c, int blank);
+static int gdccon_scrolldelta(struct vc_data *c, int lines);
+static int gdccon_set_origin(struct vc_data *c);
+static void gdccon_save_screen(struct vc_data *c);
+static int gdccon_scroll(struct vc_data *c, int t, int b, int dir, int lines);
+static u8 gdccon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse);
+static void gdccon_invert_region(struct vc_data *c, u16 *p, int count);
+static unsigned long gdccon_uni_pagedir[2];
+
+/* Description of the hardware situation */
+static unsigned long   gdc_vram_base;		/* Base of video memory */
+static unsigned long   gdc_vram_end;		/* End of video memory */
+static unsigned int    gdc_video_num_columns = 80;
+						/* Number of text columns */
+static unsigned int    gdc_video_num_lines = 25;
+						/* Number of text lines */
+static int	       gdc_can_do_color = 1;	/* Do we support colors? */
+static unsigned char   gdc_video_type;		/* Card type */
+static unsigned char   gdc_hardscroll_enabled;
+static unsigned char   gdc_hardscroll_user_enable = 1;
+static int	       gdc_vesa_blanked = 0;
+static unsigned int    gdc_rolled_over = 0;
+
+#define DISP_FREQ_AUTO 0
+#define DISP_FREQ_25k  1
+#define DISP_FREQ_31k  2
+
+static unsigned int    gdc_disp_freq = DISP_FREQ_AUTO;
+
+#define gdc_attr_offset(x) ((typeof(x))((unsigned long)(x)+0x2000))
+
+#define	gdc_outb(val, port)	outb_p((val), (port))
+#define	gdc_inb(port)		inb_p(port)
+
+#define __gdc_write_command(cmd)	gdc_outb((cmd), GDC_COMMAND)
+#define __gdc_write_param(param)	gdc_outb((param), GDC_PARAM)
+
+static const char * __init gdccon_startup(void)
+{
+	const char *display_desc = NULL;
+	unsigned long hdots = gdc_video_num_lines * 16;
+	int i;
+
+	while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+	while (!(inb_p(GGDC_STAT) & GDC_FIFO_EMPTY));
+	spin_lock_irq(&gdc_lock);	
+	outb_p(0x0c, GDC_COMMAND);	/* STOP */
+	outb_p(0x0c, GGDC_COMMAND);	/* STOP */
+	if (PC9800_9821_P() && gdc_disp_freq == DISP_FREQ_AUTO) {
+		if (gdc_video_num_lines >= 30 || (inb(0x9a8) & 0x01)) {
+			gdc_disp_freq = DISP_FREQ_31k;
+		}
+	}
+
+	if (PC9800_9821_P() && gdc_disp_freq == DISP_FREQ_31k) {
+		outb_p(0x01, 0x9a8);   /* 31.47KHz */
+		outb_p(0x0e, GDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x4b, GDC_PARAM);  /* VSL = 2(3) ; HS = 11 */
+		outb_p(0x0c, GDC_PARAM);  /* HFP = 3    ; VSH = 0(VS=2) */
+		outb_p(0x03, GDC_PARAM);  /* DS, PH = 0 ; HBP = 3 */
+		outb_p(0x06, GDC_PARAM);  /* VH, VL = 0 ; VFP = 6 */
+		outb_p(hdots & 0xff, GDC_PARAM);  /* LFL */
+		outb_p(0x94 | ((hdots >> 8) & 0x03), GDC_PARAM);
+						/* VBP = 37   ; LFH */
+		outb_p(0x47, GDC_COMMAND);  /* PITCH */
+		outb_p(0x50, GDC_PARAM);
+
+		outb_p(0x70, GDC_COMMAND);  /* SCROLL */
+		outb_p(0x00, GDC_PARAM);
+		outb_p(0x00, GDC_PARAM);
+		outb_p((hdots << 4) & 0xf0, GDC_PARAM);  /* SL1=592 (0x250) */
+		outb_p((hdots >> 4) & 0x3f, GDC_PARAM);
+
+		outb_p(0x0e, GGDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GGDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GGDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x4b, GGDC_PARAM);  /* VSL = 2(3) ; HS = 11 */
+		outb_p(0x0c, GGDC_PARAM);  /* HFP = 3    ; VSH = 0(VS=2) */
+		outb_p(0x03, GGDC_PARAM);  /* DS, PH = 0 ; HBP = 3 */
+		outb_p(0x06, GGDC_PARAM);  /* VH, VL = 0 ; VFP = 6 */
+		outb_p(hdots & 0xff, GGDC_PARAM);  /* LFL */
+		outb_p(0x94 | ((hdots >> 8) & 0x03), GGDC_PARAM);
+						/* VBP = 37   ; LFH */
+	} else {
+		outb_p(0x00, 0x9a8);   /* 24.83 KHz */
+		outb_p(0x0e, GDC_COMMAND);  /* SYNC, DE deny */
+		outb_p(0x00, GDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
+		outb_p(0x4e, GDC_PARAM);  /* C/R = 78 (80 chars) */
+		outb_p(0x07, GDC_PARAM);  /* VSL = 0(3) ; HS = 7 */
+		outb_p(0x25, GDC_PARAM);  /* HFP = 9    ; VSH = 1(VS=8) */
+		outb_p(0x07, GDC_PARAM);  /* DS, PH = 0 ; HBP = 7 */
+		outb_p(0x07, GDC_PARAM);  /* VH, VL = 0 ; VFP = 7 */
+		outb_p(hdots & 0xff, GDC_PARAM);  /* LFL */
+		outb_p(0x64 | ((hdots >> 8) & 0x03), GDC_PARAM);
+						/* VBP = 25   ; LFH */
+		outb_p(0x47, GDC_COMMAND);  /* PITCH */
+		outb_p(0x50, GDC_PARAM);
+
+		outb_p(0x70, GDC_COMMAND);  /* SCROLL */
+		outb_p(0x00, GDC_PARAM);
+		outb_p(0x00, GDC_PARAM);
+		outb_p((hdots << 4) & 0xf0, GDC_PARAM);  /* SL1=592 (0x250) */
+		outb_p((hdots >> 4) & 0x3f, GDC_PARAM);
+
+		outb_p(0x0e, GGDC_COMMAND);  /* SYNC */
+		outb_p(0x00, GGDC_PARAM);
+		outb_p(0x4e, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(0x25, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(0x07, GGDC_PARAM);
+		outb_p(hdots & 0xff, GGDC_PARAM);  /* LFL */
+		outb_p(0x64 | ((hdots >> 8) & 0x03), GGDC_PARAM);
+						/* VBP = 25   ; LFH */
+	}
+
+	outb_p(0x47, GGDC_COMMAND);  /* PITCH */ 
+	outb_p(0x28, GGDC_PARAM);
+
+	outb_p(0x0d, GDC_COMMAND);	/* START */
+	outb_p(0x0d, GGDC_COMMAND);	/* START */
+	spin_unlock_irq(&gdc_lock);	
+
+	gdc_vram_base = (unsigned long)phys_to_virt(0xa0000);
+	/* Last few bytes of text VRAM area are for NVRAM. */
+	gdc_vram_end = gdc_vram_base + 0x1fe0;
+
+	if (!PC9800_HIGHRESO_P()) {
+		gdc_video_type = VIDEO_TYPE_98NORMAL;
+		display_desc = "NEC PC-9800 Normal";
+	} else {
+		gdc_video_type = VIDEO_TYPE_98HIRESO;
+		display_desc = "NEC PC-9800 High Resolution";
+	}
+
+	gdc_hardscroll_enabled = gdc_hardscroll_user_enable;
+	
+	for (i = 0; i < GDC_CONSOLE_RESOURCES; i++)
+		request_resource(&ioport_resource, gdc_console_resources + i);
+
+	return display_desc;
+}
+
+static void gdccon_init(struct vc_data *c, int init)
+{
+	unsigned long p;
+	
+	/* We cannot be loaded as a module, therefore init is always 1 */
+	c->vc_can_do_color = gdc_can_do_color;
+	c->vc_cols = gdc_video_num_columns;
+	c->vc_rows = gdc_video_num_lines;
+	c->vc_complement_mask = ATTR_REVERSE << 8;
+	p = *c->vc_uni_pagedir_loc;
+	if (c->vc_uni_pagedir_loc == &c->vc_uni_pagedir
+	    || !--c->vc_uni_pagedir_loc[1])
+		con_free_unimap(c->vc_num);
+
+	c->vc_uni_pagedir_loc = gdccon_uni_pagedir;
+	gdccon_uni_pagedir[1]++;
+	if (!gdccon_uni_pagedir[0] && p)
+		con_set_default_unimap(c->vc_num);
+}
+
+static inline void gdc_set_mem_top(struct vc_data *c)
+{
+	unsigned long flags;
+	unsigned long origin = (c->vc_visible_origin - gdc_vram_base) / 2;
+
+	spin_lock_irqsave(&gdc_lock, flags);
+	while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+	__gdc_write_command(0x70);			/* SCROLL */
+	__gdc_write_param(origin);			/* SAD1 (L) */
+	__gdc_write_param((origin >> 8) & 0x1f);	/* SAD1 (H) */
+	spin_unlock_irqrestore(&gdc_lock, flags);
+}
+
+static void gdccon_deinit(struct vc_data *c)
+{
+	/* When closing the last console, reset video origin */
+	if (!--gdccon_uni_pagedir[1]) {
+		c->vc_visible_origin = gdc_vram_base;
+		gdc_set_mem_top(c);
+		con_free_unimap(c->vc_num);
+	}
+
+	c->vc_uni_pagedir_loc = &c->vc_uni_pagedir;
+	con_set_default_unimap(c->vc_num);
+}
+
+#if 0
+/* Translate ANSI terminal color code to GDC color code.  */
+#define BGR_TO_GRB(bgr)	((((bgr) & 4) >> 2) | (((bgr) & 3) << 1))
+#else
+#define RGB_TO_GRB(rgb)	((((rgb) & 4) >> 1) | (((rgb) & 2) << 1) | ((rgb) & 1))
+#endif
+
+static const u8 gdccon_color_table[] = {
+#define C(color)	((RGB_TO_GRB (color) << 5) | ATTR_NOSECRET)
+	C(0), C(1), C(2), C(3), C(4), C(5), C(6), C(7)
+#undef C
+};
+
+static u8 gdccon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse)
+{
+	u8 attr = gdccon_color_table[color & 0x07];
+
+	if (!gdc_can_do_color)
+		attr = (intensity == 0 ? 0x61
+			: intensity == 2 ? 0xe1 : 0xa1);
+
+	if (underline)
+		attr |= 0x08;
+
+	/* ignore intensity */
+#if 0
+	if(intensity == 0)
+		;
+	else if (intensity == 2)
+		attr |= 0x10; /* virtical line */
+#else
+	if (intensity == 0) {
+		if (attr == c->vc_def_attr)
+			attr = c->vc_half_attr;
+		else
+			attr |= c->vc_half_attr & AMASK_NOCOLOR;
+	} else if (intensity == 2) {
+		if (attr == c->vc_def_attr)
+			attr = c->vc_bold_attr;
+		else
+			attr |= c->vc_bold_attr & AMASK_NOCOLOR;
+	}
+#endif
+	if (reverse)
+		attr |= ATTR_REVERSE;
+
+	if ((color & 0x07) == 0) {	/* foreground color == black */
+		/* Fake background color by reversed character
+		   as GDC cannot set background color.  */
+		attr |= gdccon_color_table[(color >> 4) & 0x07];
+		attr ^= ATTR_REVERSE;
+	}
+
+	if (blink)
+		attr |= ATTR_BLINK;
+
+	return attr;
+}
+
+static void gdccon_invert_region(struct vc_data *c, u16 *p, int count)
+{
+	while (count--) {
+		*((u16 *)(gdc_attr_offset(p))) ^= ATTR_REVERSE;
+		p++;
+	}
+}
+
+static u8 gdc_csrform_lr = 15;			/* Lines/Row */
+static u16 gdc_csrform_bl_bd = ((12 << 6)	/* BLinking Rate */
+				| (0 << 5));	/* Blinking Disable */
+
+static inline void gdc_hide_cursor(void)
+{
+    __gdc_write_command(0x4b);		/* CSRFORM */
+    __gdc_write_param(gdc_csrform_lr);	/* CS = 0, CE = 0, L/R = ? */
+}
+
+static inline void gdc_show_cursor(int cursor_start, int cursor_finish)
+{
+    __gdc_write_command(0x4b);		/* CSRFORM */
+    __gdc_write_param(0x80 | gdc_csrform_lr);		/* CS = 1 */
+    __gdc_write_param(cursor_start | gdc_csrform_bl_bd);
+    __gdc_write_param((cursor_finish << 3) | (gdc_csrform_bl_bd >> 8));
+}
+
+static void gdccon_cursor(struct vc_data *c, int mode)
+{
+    unsigned long flags;
+    u16 ead;
+
+    if (c->vc_origin != c->vc_visible_origin)
+	gdccon_scrolldelta(c, 0);
+
+    spin_lock_irqsave(&gdc_lock, flags);
+    while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
+    spin_unlock_irqrestore(&gdc_lock, flags);
+    switch (mode) {
+	case CM_ERASE:
+	    gdc_hide_cursor();
+	    break;
+
+	case CM_MOVE:
+	case CM_DRAW:
+	    switch (c->vc_cursor_type & 0x0f) {
+		case CUR_UNDERLINE:
+		    gdc_show_cursor(14, 15);	/* XXX font height */
+		    break;
+
+		case CUR_TWO_THIRDS:
+		    gdc_show_cursor(5, 15);	/* XXX */
+		    break;
+
+		case CUR_LOWER_THIRD:
+		    gdc_show_cursor(11, 15);	/* XXX */
+		    break;
+
+		case CUR_LOWER_HALF:
+		    gdc_show_cursor(8, 15);	/* XXX */
+		    break;
+
+		case CUR_NONE:
+		    gdc_hide_cursor();
+		    break;
+
+          	default:
+		    gdc_show_cursor(0, 15);	/* XXX */
+		    break;
+	    }
+
+	    spin_lock_irqsave(&gdc_lock, flags);
+	    __gdc_write_command(0x49);		/* CSRW */
+	    ead = (c->vc_pos - gdc_vram_base) >> 1;
+	    __gdc_write_param(ead);
+	    __gdc_write_param((ead >> 8) & 0x1f);
+	    spin_unlock_irqrestore(&gdc_lock, flags);
+	    break;
+    }
+
+}
+
+static int gdccon_switch(struct vc_data *c)
+{
+	/*
+	 * We need to save screen size here as it's the only way
+	 * we can spot the screen has been resized and we need to
+	 * set size of freshly allocated screens ourselves.
+	 */
+	gdc_video_num_columns = c->vc_cols;
+	gdc_video_num_lines = c->vc_rows;
+	if (c->vc_origin != (unsigned long)c->vc_screenbuf
+	    && gdc_vram_base <= c->vc_origin && c->vc_origin < gdc_vram_end) {
+		_scr_memcpyw_to((u16 *)c->vc_origin,
+				(u16 *)c->vc_screenbuf,
+				c->vc_screenbuf_size);
+		_scr_memcpyw_to((u16 *)gdc_attr_offset(c->vc_origin),
+				(u16 *)((char *)c->vc_screenbuf
+					 + c->vc_screenbuf_size),
+				c->vc_screenbuf_size);
+	} else
+		printk(KERN_WARNING
+			"gdccon: switch (vc #%d) called on origin=%lx\n",
+			c->vc_num, c->vc_origin);
+
+	return 0;	/* Redrawing not needed */
+}
+
+static int gdccon_set_palette(struct vc_data *c, unsigned char *table)
+{
+	return -EINVAL;
+}
+
+#define RELAY0		0x01
+#define RELAY0_GDC	0x00
+#define RELAY0_ACCEL	0x01
+#define RELAY1		0x02
+#define RELAY1_INTERNAL	0x00
+#define RELAY1_EXTERNAL	0x02
+#define IO_RELAY	0x0fac
+#define IO_DPMS		0x09a2
+static unsigned char relay_mode = RELAY0_GDC | RELAY1_INTERNAL;
+
+static void gdc_vesa_blank(int mode)
+{
+    unsigned char stat;
+
+    spin_lock_irq(&gdc_lock);
+
+    relay_mode = inb_p(IO_RELAY);
+    if ((relay_mode & (RELAY0 | RELAY1)) != (RELAY0_GDC | RELAY1_INTERNAL)) {
+#ifdef CONFIG_DONTTOUCHRELAY
+	spin_unlock_irq(&gdc_lock);
+	return;
+#else
+	outb_p((relay_mode & ~(RELAY0 | RELAY1)) |
+	       RELAY0_GDC | RELAY1_INTERNAL , IO_RELAY);
+#endif
+    }
+
+    if (mode & VESA_VSYNC_SUSPEND) {
+	stat = inb_p(IO_DPMS);
+	outb_p(stat | 0x80, IO_DPMS);
+    }
+    if (mode & VESA_HSYNC_SUSPEND) {
+	stat = inb_p(IO_DPMS);
+	outb_p(stat | 0x40, IO_DPMS);
+    }
+
+    spin_unlock_irq(&gdc_lock);
+}
+
+static void gdc_vesa_unblank(void)
+{
+    unsigned char stat;
+
+#ifdef CONFIG_DONTTOUCHRELAY
+    if (relay_mode & (RELAY0 | RELAY1))
+	return;
+#endif
+
+    spin_lock_irq(&gdc_lock);
+
+    stat = inb_p(0x09a2);
+    outb_p(stat & ~0xc0, IO_DPMS);
+    if (relay_mode & (RELAY0 | RELAY1))
+	outb_p(relay_mode, IO_RELAY);
+
+    spin_unlock_irq(&gdc_lock);
+}
+
+static int gdccon_blank(struct vc_data *c, int blank)
+{
+	switch (blank) {
+	case 0:				/* Unblank */
+		if (gdc_vesa_blanked) {
+			gdc_vesa_unblank();
+			gdc_vesa_blanked = 0;
+		}
+
+		outb(MODE_FF1_DISP_ENABLE | 1, MODE_FF1);
+
+		/* Tell console.c that it need not to restore the screen */
+		return 0;
+
+	case 1:				/* Normal blanking */
+		/* Disable displaying */
+		outb(MODE_FF1_DISP_ENABLE | 0, MODE_FF1);
+
+		/* Tell console.c that it need not to reset origin */
+		return 0;
+
+	case -1:			/* Entering graphic mode */
+		return 1;
+
+	default:			/* VESA blanking */
+		if (gdc_video_type == VIDEO_TYPE_98NORMAL
+		    || gdc_video_type == VIDEO_TYPE_9840
+		    || gdc_video_type == VIDEO_TYPE_98HIRESO) {
+			gdc_vesa_blank(blank - 1);
+			gdc_vesa_blanked = blank;
+		}
+
+		return 0;
+	}
+}
+
+static int gdccon_font_op(struct vc_data *c, struct console_font_op *op)
+{
+	return -ENOSYS;
+}
+
+static int gdccon_scrolldelta(struct vc_data *c, int lines)
+{
+	if (!lines)			/* Turn scrollback off */
+		c->vc_visible_origin = c->vc_origin;
+	else {
+		int vram_size = gdc_vram_end - gdc_vram_base;
+		int margin = c->vc_size_row /* * 4 */;
+		int ul, we, p, st;
+
+		if (gdc_rolled_over > c->vc_scr_end - gdc_vram_base + margin) {
+			ul = c->vc_scr_end - gdc_vram_base;
+			we = gdc_rolled_over + c->vc_size_row;
+		} else {
+			ul = 0;
+			we = vram_size;
+		}
+
+		p = (c->vc_visible_origin - gdc_vram_base - ul + we)
+			% we + lines * c->vc_size_row;
+		st = (c->vc_origin - gdc_vram_base - ul + we) % we;
+		if (p < margin)
+			p = 0;
+
+		if (p > st - margin)
+			p = st;
+		c->vc_visible_origin = gdc_vram_base + (p + ul) % we;
+	}
+
+	gdc_set_mem_top(c);
+	return 1;
+}
+
+static int gdccon_set_origin(struct vc_data *c)
+{
+	c->vc_origin = c->vc_visible_origin = gdc_vram_base;
+	gdc_set_mem_top(c);
+	gdc_rolled_over = 0;
+	return 1;
+}
+
+static void gdccon_save_screen(struct vc_data *c)
+{
+	static int gdc_bootup_console = 0;
+
+	if (!gdc_bootup_console) {
+		/* This is a gross hack, but here is the only place we can
+		 * set bootup console parameters without messing up generic
+		 * console initialization routines.
+		 */
+		gdc_bootup_console = 1;
+		c->vc_x = ORIG_X;
+		c->vc_y = ORIG_Y;
+	}
+
+	_scr_memcpyw_from((u16 *)c->vc_screenbuf,
+				(u16 *)c->vc_origin, c->vc_screenbuf_size);
+	_scr_memcpyw_from((u16 *)((char *)c->vc_screenbuf + c->vc_screenbuf_size), (u16 *)gdc_attr_offset(c->vc_origin), c->vc_screenbuf_size);
+}
+
+static int gdccon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
+{
+	unsigned long oldo;
+	unsigned int delta;
+
+	if (t || b != c->vc_rows)
+		return 0;
+
+	if (c->vc_origin != c->vc_visible_origin)
+		gdccon_scrolldelta(c, 0);
+
+	if (!gdc_hardscroll_enabled || lines >= c->vc_rows / 2)
+		return 0;
+
+	oldo = c->vc_origin;
+	delta = lines * c->vc_size_row;
+	if (dir == SM_UP) {
+		if (c->vc_scr_end + delta >= gdc_vram_end) {
+			_scr_memcpyw((u16 *)gdc_vram_base,
+				    (u16 *)(oldo + delta),
+				    c->vc_screenbuf_size - delta);
+			_scr_memcpyw((u16 *)gdc_attr_offset(gdc_vram_base),
+				    (u16 *)gdc_attr_offset(oldo + delta),
+				    c->vc_screenbuf_size - delta);
+			c->vc_origin = gdc_vram_base;
+			gdc_rolled_over = oldo - gdc_vram_base;
+		} else
+			c->vc_origin += delta;
+
+		_scr_memsetw((u16 *)(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char & 0xff, delta);
+		_scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char >> 8, delta);
+	} else {
+		if (oldo - delta < gdc_vram_base) {
+			_scr_memmovew((u16 *)(gdc_vram_end - c->vc_screenbuf_size + delta), (u16 *)oldo, c->vc_screenbuf_size - delta);
+			_scr_memmovew((u16 *)gdc_attr_offset(gdc_vram_end - c->vc_screenbuf_size + delta), (u16 *)gdc_attr_offset(oldo), c->vc_screenbuf_size - delta);
+			c->vc_origin = gdc_vram_end - c->vc_screenbuf_size;
+			gdc_rolled_over = 0;
+		} else
+			c->vc_origin -= delta;
+
+		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
+		_scr_memsetw((u16 *)(c->vc_origin), c->vc_video_erase_char & 0xff, delta);
+		_scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin), c->vc_video_erase_char >> 8, delta);
+	}
+
+	c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
+	c->vc_visible_origin = c->vc_origin;
+	gdc_set_mem_top(c);
+	c->vc_pos = (c->vc_pos - oldo) + c->vc_origin;
+	return 1;
+}
+
+static int gdccon_setterm_command(struct vc_data *c)
+{
+	switch (c->vc_par[0]) {
+	case 1: /* set attr for underline mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_ul_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		} else {
+			if (c->vc_par[2] < 256)
+				c->vc_ul_attr = c->vc_par[2];
+		}
+
+		if (c->vc_underline)
+			goto update_attr;
+
+		return 1;
+
+	case 2:	/* set attr for half intensity mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_half_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		}
+		else {
+			if (c->vc_par[2] < 256)
+				c->vc_half_attr = c->vc_par[2];
+		}
+
+		if (c->vc_intensity == 0)
+			goto update_attr;
+
+		return 1;
+
+	case 3: /* set color for bold mode */
+		if (c->vc_npar < 2) {
+			if (c->vc_par[1] < 16)
+				c->vc_bold_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
+		} else {
+			if (c->vc_par[2] < 256)
+				c->vc_bold_attr = c->vc_par[2];
+		}
+
+		if (c->vc_intensity == 2)
+			goto update_attr;
+
+		return 1;
+	}
+
+	return 0;
+
+update_attr:
+	c->vc_attr = gdccon_build_attr(c,
+					c->vc_color, c->vc_intensity,
+					c->vc_blink, c->vc_underline,
+					c->vc_reverse);
+	return 1;
+}
+
+/*
+ *  The console `switch' structure for the GDC based console
+ */
+
+static int gdccon_dummy(struct vc_data *c)
+{
+	return 0;
+}
+
+#define DUMMY (void *) gdccon_dummy
+
+const struct consw gdc_con = {
+	.con_startup =		gdccon_startup,
+	.con_init =		gdccon_init,
+	.con_deinit =		gdccon_deinit,
+	.con_clear =		DUMMY,
+	.con_putc =		DUMMY,
+	.con_putcs =		DUMMY,
+	.con_cursor =		gdccon_cursor,
+	.con_scroll =		gdccon_scroll,
+	.con_bmove =		DUMMY,
+	.con_switch =		gdccon_switch,
+	.con_blank =		gdccon_blank,
+	.con_font_op =		gdccon_font_op,
+	.con_set_palette =	gdccon_set_palette,
+	.con_scrolldelta =	gdccon_scrolldelta,
+	.con_set_origin =	gdccon_set_origin,
+	.con_save_screen =	gdccon_save_screen,
+	.con_build_attr =	gdccon_build_attr,
+	.con_invert_region =	gdccon_invert_region,
+	.con_setterm_command =	gdccon_setterm_command
+};
+
+static int __init gdc_setup(char *str)
+{
+	unsigned long tmp_ulong;
+	char *opt, *orig_opt, *endp;
+
+	while ((opt = strsep(&str, ",")) != NULL) {
+		int force = 0;
+
+		orig_opt = opt;
+		if (!strncmp(opt, "force", 5)) {
+			force = 1;
+			opt += 5;
+		}
+
+		if (!strcmp(opt, "mono"))
+			gdc_can_do_color = 0;
+		else if ((tmp_ulong = simple_strtoul(opt, &endp, 0)) > 0) {
+			if (!strcmp(endp, "lines")
+			    || (!strcmp(endp, "linesforce") && (force == 1))) {
+				if (!force
+				    && (tmp_ulong < 20
+					|| (!PC9800_9821_P()
+					    && 25 < tmp_ulong)
+					|| 37 < tmp_ulong))
+					printk(KERN_ERR
+						"gdccon: %d is out of bound"
+						" for number of lines\n",
+						(int)tmp_ulong);
+				else
+					gdc_video_num_lines = tmp_ulong;
+			} else if (!strcmp(endp, "kHz")) {
+				if (tmp_ulong == 24 || tmp_ulong == 25)
+					gdc_disp_freq = DISP_FREQ_25k;
+				else
+					printk(KERN_ERR "gdccon: `%s' ignored\n",
+						orig_opt);
+			} else
+				printk(KERN_ERR "gdccon: unknown option `%s'\n",
+					orig_opt);
+		} else
+			printk(KERN_ERR "gdccon: unknown option `%s'\n",
+				orig_opt);
+	}
+
+	return 1; 
+}
+
+__setup("gdccon=", gdc_setup);
+
+/*
+ * We will follow Linus's indenting style...
+ *
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -Nru linux-2.5.61-ac1/drivers/video/gdccon.c linux98-2.5.61-ac1/drivers/video/gdccon.c
--- linux-2.5.61-ac1/drivers/video/gdccon.c	2003-02-18 08:58:26.000000000 +0900
+++ linux98-2.5.61-ac1/drivers/video/gdccon.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,834 +0,0 @@
-/*
- * linux/drivers/video/gdccon.c
- * Low level GDC based console driver for NEC PC-9800 series
- *
- * Created 24 Dec 1998 by Linux/98 project
- *
- * based on:
- * linux/drivers/video/vgacon.c in Linux 2.1.131 by Geert Uytterhoeven
- * linux/char/gdc.c in Linux/98 2.1.57 by Linux/98 project
- * linux/char/console.c in Linux/98 2.1.57 by Linux/98 project
- */
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/fs.h>
-#include <linux/kernel.h>
-#include <linux/tty.h>
-#include <linux/console.h>
-#include <linux/console_struct.h>
-#include <linux/string.h>
-#include <linux/kd.h>
-#include <linux/slab.h>
-#include <linux/vt_kern.h>
-#include <linux/selection.h>
-#include <linux/spinlock.h>
-#include <linux/ioport.h>
-#include <linux/init.h>
-
-#include <asm/io.h>
-#include <asm/pc9800.h>
-
-static spinlock_t gdc_lock = SPIN_LOCK_UNLOCKED;
-
-static char str_gdc_master[] = "GDC (master)";
-static char str_gdc_slave[] = "GDC (slave)";
-static char str_crtc[] = "crtc";
-static struct resource gdc_console_resources[] = {
-    {str_gdc_master, 0x60, 0x60, 0},
-    {str_gdc_master, 0x62, 0x62, 0},
-    {str_gdc_master, 0x64, 0x64, 0},
-    {str_gdc_master, 0x66, 0x66, 0},
-    {str_gdc_master, 0x68, 0x68, 0},
-    {str_gdc_master, 0x6a, 0x6a, 0},
-    {str_gdc_master, 0x6c, 0x6c, 0},
-    {str_gdc_master, 0x6e, 0x6e, 0},
-    {str_crtc, 0x70, 0x70, 0},
-    {str_crtc, 0x72, 0x72, 0},
-    {str_crtc, 0x74, 0x74, 0},
-    {str_crtc, 0x76, 0x76, 0},
-    {str_crtc, 0x78, 0x78, 0},
-    {str_crtc, 0x7a, 0x7a, 0},
-    {str_gdc_slave, 0xa0, 0xa0, 0},
-    {str_gdc_slave, 0xa2, 0xa2, 0},
-    {str_gdc_slave, 0xa4, 0xa4, 0},
-    {str_gdc_slave, 0xa6, 0xa6, 0},
-};
-
-#define GDC_CONSOLE_RESOURCES (sizeof(gdc_console_resources)/sizeof(struct resource))
-
-#define BLANK 0x0020
-#define BLANK_ATTR 0x00e1
-
-/* GDC/GGDC port# */
-#define GDC_COMMAND 0x62
-#define GDC_PARAM 0x60
-#define GDC_STAT 0x60
-#define GDC_DATA 0x62
-
-#define MODE_FF1	(0x0068)	/* mode F/F register 1 */
-
-#define  MODE_FF1_ATR_SEL	(0x00)	/* 0: vertical line 1: 8001 graphic */
-#define  MODE_FF1_GRAPHIC_MODE	(0x02)	/* 0: color 1: mono */
-#define  MODE_FF1_COLUMN_WIDTH	(0x04)	/* 0: 80col 1: 40col */
-#define  MODE_FF1_FONT_SEL	(0x06)	/* 0: 6x8 1: 7x13 */
-#define  MODE_FF1_GRP_MODE	(0x08)	/* 0: display odd-y raster 1: not */
-#define  MODE_FF1_KAC_MODE	(0x0a)	/* 0: code access 1: dot access */
-#define  MODE_FF1_NVMW_PERMIT	(0x0c)	/* 0: protect 1: permit */
-#define  MODE_FF1_DISP_ENABLE	(0x0e)	/* 0: enable 1: disable */
-
-#define GGDC_COMMAND 0xa2
-#define GGDC_PARAM 0xa0
-#define GGDC_STAT 0xa0
-#define GGDC_DATA 0xa2
-
-/* GDC status */
-#define GDC_DATA_READY		(1 << 0)
-#define GDC_FIFO_FULL		(1 << 1)
-#define GDC_FIFO_EMPTY		(1 << 2)
-#define GGDC_FIFO_EMPTY		GDC_FIFO_EMPTY
-#define GDC_DRAWING		(1 << 3)
-#define GDC_DMA_EXECUTE		(1 << 4)	/* nonsense on 98 */
-#define GDC_VERTICAL_SYNC	(1 << 5)
-#define GDC_HORIZONTAL_BLANK	(1 << 6)
-#define GDC_LIGHTPEN_DETECT	(1 << 7)	/* nonsense on 98 */
-
-#define ATTR_G		(1U << 7)
-#define ATTR_R		(1U << 6)
-#define ATTR_B		(1U << 5)
-#define ATTR_GRAPHIC	(1U << 4)
-#define ATTR_VERTBAR	ATTR_GRAPHIC	/* vertical bar */
-#define ATTR_UNDERLINE	(1U << 3)
-#define ATTR_REVERSE	(1U << 2)
-#define ATTR_BLINK	(1U << 1)
-#define ATTR_NOSECRET	(1U << 0)
-#define AMASK_NOCOLOR	(ATTR_GRAPHIC | ATTR_UNDERLINE | ATTR_REVERSE \
-			 | ATTR_BLINK | ATTR_NOSECRET)
-
-/*
- *  Interface used by the world
- */
-static const char *gdccon_startup(void);
-static void gdccon_init(struct vc_data *c, int init);
-static void gdccon_deinit(struct vc_data *c);
-static void gdccon_cursor(struct vc_data *c, int mode);
-static int gdccon_switch(struct vc_data *c);
-static int gdccon_blank(struct vc_data *c, int blank);
-static int gdccon_scrolldelta(struct vc_data *c, int lines);
-static int gdccon_set_origin(struct vc_data *c);
-static void gdccon_save_screen(struct vc_data *c);
-static int gdccon_scroll(struct vc_data *c, int t, int b, int dir, int lines);
-static u8 gdccon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse);
-static void gdccon_invert_region(struct vc_data *c, u16 *p, int count);
-static unsigned long gdccon_uni_pagedir[2];
-
-/* Description of the hardware situation */
-static unsigned long   gdc_vram_base;		/* Base of video memory */
-static unsigned long   gdc_vram_end;		/* End of video memory */
-static unsigned int    gdc_video_num_columns = 80;
-						/* Number of text columns */
-static unsigned int    gdc_video_num_lines = 25;
-						/* Number of text lines */
-static int	       gdc_can_do_color = 1;	/* Do we support colors? */
-static unsigned char   gdc_video_type;		/* Card type */
-static unsigned char   gdc_hardscroll_enabled;
-static unsigned char   gdc_hardscroll_user_enable = 1;
-static int	       gdc_vesa_blanked = 0;
-static unsigned int    gdc_rolled_over = 0;
-
-#define DISP_FREQ_AUTO 0
-#define DISP_FREQ_25k  1
-#define DISP_FREQ_31k  2
-
-static unsigned int    gdc_disp_freq = DISP_FREQ_AUTO;
-
-#define gdc_attr_offset(x) ((typeof(x))((unsigned long)(x)+0x2000))
-
-#define	gdc_outb(val, port)	outb_p((val), (port))
-#define	gdc_inb(port)		inb_p(port)
-
-#define __gdc_write_command(cmd)	gdc_outb((cmd), GDC_COMMAND)
-#define __gdc_write_param(param)	gdc_outb((param), GDC_PARAM)
-
-static const char * __init gdccon_startup(void)
-{
-	const char *display_desc = NULL;
-	unsigned long hdots = gdc_video_num_lines * 16;
-	int i;
-
-	while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
-	while (!(inb_p(GGDC_STAT) & GDC_FIFO_EMPTY));
-	spin_lock_irq(&gdc_lock);	
-	outb_p(0x0c, GDC_COMMAND);	/* STOP */
-	outb_p(0x0c, GGDC_COMMAND);	/* STOP */
-	if (PC9800_9821_P() && gdc_disp_freq == DISP_FREQ_AUTO) {
-		if (gdc_video_num_lines >= 30 || (inb(0x9a8) & 0x01)) {
-			gdc_disp_freq = DISP_FREQ_31k;
-		}
-	}
-
-	if (PC9800_9821_P() && gdc_disp_freq == DISP_FREQ_31k) {
-		outb_p(0x01, 0x9a8);   /* 31.47KHz */
-		outb_p(0x0e, GDC_COMMAND);  /* SYNC, DE deny */
-		outb_p(0x00, GDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
-		outb_p(0x4e, GDC_PARAM);  /* C/R = 78 (80 chars) */
-		outb_p(0x4b, GDC_PARAM);  /* VSL = 2(3) ; HS = 11 */
-		outb_p(0x0c, GDC_PARAM);  /* HFP = 3    ; VSH = 0(VS=2) */
-		outb_p(0x03, GDC_PARAM);  /* DS, PH = 0 ; HBP = 3 */
-		outb_p(0x06, GDC_PARAM);  /* VH, VL = 0 ; VFP = 6 */
-		outb_p(hdots & 0xff, GDC_PARAM);  /* LFL */
-		outb_p(0x94 | ((hdots >> 8) & 0x03), GDC_PARAM);
-						/* VBP = 37   ; LFH */
-		outb_p(0x47, GDC_COMMAND);  /* PITCH */
-		outb_p(0x50, GDC_PARAM);
-
-		outb_p(0x70, GDC_COMMAND);  /* SCROLL */
-		outb_p(0x00, GDC_PARAM);
-		outb_p(0x00, GDC_PARAM);
-		outb_p((hdots << 4) & 0xf0, GDC_PARAM);  /* SL1=592 (0x250) */
-		outb_p((hdots >> 4) & 0x3f, GDC_PARAM);
-
-		outb_p(0x0e, GGDC_COMMAND);  /* SYNC, DE deny */
-		outb_p(0x00, GGDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
-		outb_p(0x4e, GGDC_PARAM);  /* C/R = 78 (80 chars) */
-		outb_p(0x4b, GGDC_PARAM);  /* VSL = 2(3) ; HS = 11 */
-		outb_p(0x0c, GGDC_PARAM);  /* HFP = 3    ; VSH = 0(VS=2) */
-		outb_p(0x03, GGDC_PARAM);  /* DS, PH = 0 ; HBP = 3 */
-		outb_p(0x06, GGDC_PARAM);  /* VH, VL = 0 ; VFP = 6 */
-		outb_p(hdots & 0xff, GGDC_PARAM);  /* LFL */
-		outb_p(0x94 | ((hdots >> 8) & 0x03), GGDC_PARAM);
-						/* VBP = 37   ; LFH */
-	} else {
-		outb_p(0x00, 0x9a8);   /* 24.83 KHz */
-		outb_p(0x0e, GDC_COMMAND);  /* SYNC, DE deny */
-		outb_p(0x00, GDC_PARAM);  /* CHR, F, I, D, G, S = 0 */
-		outb_p(0x4e, GDC_PARAM);  /* C/R = 78 (80 chars) */
-		outb_p(0x07, GDC_PARAM);  /* VSL = 0(3) ; HS = 7 */
-		outb_p(0x25, GDC_PARAM);  /* HFP = 9    ; VSH = 1(VS=8) */
-		outb_p(0x07, GDC_PARAM);  /* DS, PH = 0 ; HBP = 7 */
-		outb_p(0x07, GDC_PARAM);  /* VH, VL = 0 ; VFP = 7 */
-		outb_p(hdots & 0xff, GDC_PARAM);  /* LFL */
-		outb_p(0x64 | ((hdots >> 8) & 0x03), GDC_PARAM);
-						/* VBP = 25   ; LFH */
-		outb_p(0x47, GDC_COMMAND);  /* PITCH */
-		outb_p(0x50, GDC_PARAM);
-
-		outb_p(0x70, GDC_COMMAND);  /* SCROLL */
-		outb_p(0x00, GDC_PARAM);
-		outb_p(0x00, GDC_PARAM);
-		outb_p((hdots << 4) & 0xf0, GDC_PARAM);  /* SL1=592 (0x250) */
-		outb_p((hdots >> 4) & 0x3f, GDC_PARAM);
-
-		outb_p(0x0e, GGDC_COMMAND);  /* SYNC */
-		outb_p(0x00, GGDC_PARAM);
-		outb_p(0x4e, GGDC_PARAM);
-		outb_p(0x07, GGDC_PARAM);
-		outb_p(0x25, GGDC_PARAM);
-		outb_p(0x07, GGDC_PARAM);
-		outb_p(0x07, GGDC_PARAM);
-		outb_p(hdots & 0xff, GGDC_PARAM);  /* LFL */
-		outb_p(0x64 | ((hdots >> 8) & 0x03), GGDC_PARAM);
-						/* VBP = 25   ; LFH */
-	}
-
-	outb_p(0x47, GGDC_COMMAND);  /* PITCH */ 
-	outb_p(0x28, GGDC_PARAM);
-
-	outb_p(0x0d, GDC_COMMAND);	/* START */
-	outb_p(0x0d, GGDC_COMMAND);	/* START */
-	spin_unlock_irq(&gdc_lock);	
-
-	gdc_vram_base = (unsigned long)phys_to_virt(0xa0000);
-	/* Last few bytes of text VRAM area are for NVRAM. */
-	gdc_vram_end = gdc_vram_base + 0x1fe0;
-
-	if (!PC9800_HIGHRESO_P()) {
-		gdc_video_type = VIDEO_TYPE_98NORMAL;
-		display_desc = "NEC PC-9800 Normal";
-	} else {
-		gdc_video_type = VIDEO_TYPE_98HIRESO;
-		display_desc = "NEC PC-9800 High Resolution";
-	}
-
-	gdc_hardscroll_enabled = gdc_hardscroll_user_enable;
-	
-	for (i = 0; i < GDC_CONSOLE_RESOURCES; i++)
-		request_resource(&ioport_resource, gdc_console_resources + i);
-
-	return display_desc;
-}
-
-static void gdccon_init(struct vc_data *c, int init)
-{
-	unsigned long p;
-	
-	/* We cannot be loaded as a module, therefore init is always 1 */
-	c->vc_can_do_color = gdc_can_do_color;
-	c->vc_cols = gdc_video_num_columns;
-	c->vc_rows = gdc_video_num_lines;
-	c->vc_complement_mask = ATTR_REVERSE << 8;
-	p = *c->vc_uni_pagedir_loc;
-	if (c->vc_uni_pagedir_loc == &c->vc_uni_pagedir
-	    || !--c->vc_uni_pagedir_loc[1])
-		con_free_unimap(c->vc_num);
-
-	c->vc_uni_pagedir_loc = gdccon_uni_pagedir;
-	gdccon_uni_pagedir[1]++;
-	if (!gdccon_uni_pagedir[0] && p)
-		con_set_default_unimap(c->vc_num);
-}
-
-static inline void gdc_set_mem_top(struct vc_data *c)
-{
-	unsigned long flags;
-	unsigned long origin = (c->vc_visible_origin - gdc_vram_base) / 2;
-
-	spin_lock_irqsave(&gdc_lock, flags);
-	while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
-	__gdc_write_command(0x70);			/* SCROLL */
-	__gdc_write_param(origin);			/* SAD1 (L) */
-	__gdc_write_param((origin >> 8) & 0x1f);	/* SAD1 (H) */
-	spin_unlock_irqrestore(&gdc_lock, flags);
-}
-
-static void gdccon_deinit(struct vc_data *c)
-{
-	/* When closing the last console, reset video origin */
-	if (!--gdccon_uni_pagedir[1]) {
-		c->vc_visible_origin = gdc_vram_base;
-		gdc_set_mem_top(c);
-		con_free_unimap(c->vc_num);
-	}
-
-	c->vc_uni_pagedir_loc = &c->vc_uni_pagedir;
-	con_set_default_unimap(c->vc_num);
-}
-
-#if 0
-/* Translate ANSI terminal color code to GDC color code.  */
-#define BGR_TO_GRB(bgr)	((((bgr) & 4) >> 2) | (((bgr) & 3) << 1))
-#else
-#define RGB_TO_GRB(rgb)	((((rgb) & 4) >> 1) | (((rgb) & 2) << 1) | ((rgb) & 1))
-#endif
-
-static const u8 gdccon_color_table[] = {
-#define C(color)	((RGB_TO_GRB (color) << 5) | ATTR_NOSECRET)
-	C(0), C(1), C(2), C(3), C(4), C(5), C(6), C(7)
-#undef C
-};
-
-static u8 gdccon_build_attr(struct vc_data *c, u8 color, u8 intensity, u8 blink, u8 underline, u8 reverse)
-{
-	u8 attr = gdccon_color_table[color & 0x07];
-
-	if (!gdc_can_do_color)
-		attr = (intensity == 0 ? 0x61
-			: intensity == 2 ? 0xe1 : 0xa1);
-
-	if (underline)
-		attr |= 0x08;
-
-	/* ignore intensity */
-#if 0
-	if(intensity == 0)
-		;
-	else if (intensity == 2)
-		attr |= 0x10; /* virtical line */
-#else
-	if (intensity == 0) {
-		if (attr == c->vc_def_attr)
-			attr = c->vc_half_attr;
-		else
-			attr |= c->vc_half_attr & AMASK_NOCOLOR;
-	} else if (intensity == 2) {
-		if (attr == c->vc_def_attr)
-			attr = c->vc_bold_attr;
-		else
-			attr |= c->vc_bold_attr & AMASK_NOCOLOR;
-	}
-#endif
-	if (reverse)
-		attr |= ATTR_REVERSE;
-
-	if ((color & 0x07) == 0) {	/* foreground color == black */
-		/* Fake background color by reversed character
-		   as GDC cannot set background color.  */
-		attr |= gdccon_color_table[(color >> 4) & 0x07];
-		attr ^= ATTR_REVERSE;
-	}
-
-	if (blink)
-		attr |= ATTR_BLINK;
-
-	return attr;
-}
-
-static void gdccon_invert_region(struct vc_data *c, u16 *p, int count)
-{
-	while (count--) {
-		*((u16 *)(gdc_attr_offset(p))) ^= ATTR_REVERSE;
-		p++;
-	}
-}
-
-static u8 gdc_csrform_lr = 15;			/* Lines/Row */
-static u16 gdc_csrform_bl_bd = ((12 << 6)	/* BLinking Rate */
-				| (0 << 5));	/* Blinking Disable */
-
-static inline void gdc_hide_cursor(void)
-{
-    __gdc_write_command(0x4b);		/* CSRFORM */
-    __gdc_write_param(gdc_csrform_lr);	/* CS = 0, CE = 0, L/R = ? */
-}
-
-static inline void gdc_show_cursor(int cursor_start, int cursor_finish)
-{
-    __gdc_write_command(0x4b);		/* CSRFORM */
-    __gdc_write_param(0x80 | gdc_csrform_lr);		/* CS = 1 */
-    __gdc_write_param(cursor_start | gdc_csrform_bl_bd);
-    __gdc_write_param((cursor_finish << 3) | (gdc_csrform_bl_bd >> 8));
-}
-
-static void gdccon_cursor(struct vc_data *c, int mode)
-{
-    unsigned long flags;
-    u16 ead;
-
-    if (c->vc_origin != c->vc_visible_origin)
-	gdccon_scrolldelta(c, 0);
-
-    spin_lock_irqsave(&gdc_lock, flags);
-    while (!(inb_p(GDC_STAT) & GDC_FIFO_EMPTY));
-    spin_unlock_irqrestore(&gdc_lock, flags);
-    switch (mode) {
-	case CM_ERASE:
-	    gdc_hide_cursor();
-	    break;
-
-	case CM_MOVE:
-	case CM_DRAW:
-	    switch (c->vc_cursor_type & 0x0f) {
-		case CUR_UNDERLINE:
-		    gdc_show_cursor(14, 15);	/* XXX font height */
-		    break;
-
-		case CUR_TWO_THIRDS:
-		    gdc_show_cursor(5, 15);	/* XXX */
-		    break;
-
-		case CUR_LOWER_THIRD:
-		    gdc_show_cursor(11, 15);	/* XXX */
-		    break;
-
-		case CUR_LOWER_HALF:
-		    gdc_show_cursor(8, 15);	/* XXX */
-		    break;
-
-		case CUR_NONE:
-		    gdc_hide_cursor();
-		    break;
-
-          	default:
-		    gdc_show_cursor(0, 15);	/* XXX */
-		    break;
-	    }
-
-	    spin_lock_irqsave(&gdc_lock, flags);
-	    __gdc_write_command(0x49);		/* CSRW */
-	    ead = (c->vc_pos - gdc_vram_base) >> 1;
-	    __gdc_write_param(ead);
-	    __gdc_write_param((ead >> 8) & 0x1f);
-	    spin_unlock_irqrestore(&gdc_lock, flags);
-	    break;
-    }
-
-}
-
-static int gdccon_switch(struct vc_data *c)
-{
-	/*
-	 * We need to save screen size here as it's the only way
-	 * we can spot the screen has been resized and we need to
-	 * set size of freshly allocated screens ourselves.
-	 */
-	gdc_video_num_columns = c->vc_cols;
-	gdc_video_num_lines = c->vc_rows;
-	if (c->vc_origin != (unsigned long)c->vc_screenbuf
-	    && gdc_vram_base <= c->vc_origin && c->vc_origin < gdc_vram_end) {
-		_scr_memcpyw_to((u16 *)c->vc_origin,
-				(u16 *)c->vc_screenbuf,
-				c->vc_screenbuf_size);
-		_scr_memcpyw_to((u16 *)gdc_attr_offset(c->vc_origin),
-				(u16 *)((char *)c->vc_screenbuf
-					 + c->vc_screenbuf_size),
-				c->vc_screenbuf_size);
-	} else
-		printk(KERN_WARNING
-			"gdccon: switch (vc #%d) called on origin=%lx\n",
-			c->vc_num, c->vc_origin);
-
-	return 0;	/* Redrawing not needed */
-}
-
-static int gdccon_set_palette(struct vc_data *c, unsigned char *table)
-{
-	return -EINVAL;
-}
-
-#define RELAY0		0x01
-#define RELAY0_GDC	0x00
-#define RELAY0_ACCEL	0x01
-#define RELAY1		0x02
-#define RELAY1_INTERNAL	0x00
-#define RELAY1_EXTERNAL	0x02
-#define IO_RELAY	0x0fac
-#define IO_DPMS		0x09a2
-static unsigned char relay_mode = RELAY0_GDC | RELAY1_INTERNAL;
-
-static void gdc_vesa_blank(int mode)
-{
-    unsigned char stat;
-
-    spin_lock_irq(&gdc_lock);
-
-    relay_mode = inb_p(IO_RELAY);
-    if ((relay_mode & (RELAY0 | RELAY1)) != (RELAY0_GDC | RELAY1_INTERNAL)) {
-#ifdef CONFIG_DONTTOUCHRELAY
-	spin_unlock_irq(&gdc_lock);
-	return;
-#else
-	outb_p((relay_mode & ~(RELAY0 | RELAY1)) |
-	       RELAY0_GDC | RELAY1_INTERNAL , IO_RELAY);
-#endif
-    }
-
-    if (mode & VESA_VSYNC_SUSPEND) {
-	stat = inb_p(IO_DPMS);
-	outb_p(stat | 0x80, IO_DPMS);
-    }
-    if (mode & VESA_HSYNC_SUSPEND) {
-	stat = inb_p(IO_DPMS);
-	outb_p(stat | 0x40, IO_DPMS);
-    }
-
-    spin_unlock_irq(&gdc_lock);
-}
-
-static void gdc_vesa_unblank(void)
-{
-    unsigned char stat;
-
-#ifdef CONFIG_DONTTOUCHRELAY
-    if (relay_mode & (RELAY0 | RELAY1))
-	return;
-#endif
-
-    spin_lock_irq(&gdc_lock);
-
-    stat = inb_p(0x09a2);
-    outb_p(stat & ~0xc0, IO_DPMS);
-    if (relay_mode & (RELAY0 | RELAY1))
-	outb_p(relay_mode, IO_RELAY);
-
-    spin_unlock_irq(&gdc_lock);
-}
-
-static int gdccon_blank(struct vc_data *c, int blank)
-{
-	switch (blank) {
-	case 0:				/* Unblank */
-		if (gdc_vesa_blanked) {
-			gdc_vesa_unblank();
-			gdc_vesa_blanked = 0;
-		}
-
-		outb(MODE_FF1_DISP_ENABLE | 1, MODE_FF1);
-
-		/* Tell console.c that it need not to restore the screen */
-		return 0;
-
-	case 1:				/* Normal blanking */
-		/* Disable displaying */
-		outb(MODE_FF1_DISP_ENABLE | 0, MODE_FF1);
-
-		/* Tell console.c that it need not to reset origin */
-		return 0;
-
-	case -1:			/* Entering graphic mode */
-		return 1;
-
-	default:			/* VESA blanking */
-		if (gdc_video_type == VIDEO_TYPE_98NORMAL
-		    || gdc_video_type == VIDEO_TYPE_9840
-		    || gdc_video_type == VIDEO_TYPE_98HIRESO) {
-			gdc_vesa_blank(blank - 1);
-			gdc_vesa_blanked = blank;
-		}
-
-		return 0;
-	}
-}
-
-static int gdccon_font_op(struct vc_data *c, struct console_font_op *op)
-{
-	return -ENOSYS;
-}
-
-static int gdccon_scrolldelta(struct vc_data *c, int lines)
-{
-	if (!lines)			/* Turn scrollback off */
-		c->vc_visible_origin = c->vc_origin;
-	else {
-		int vram_size = gdc_vram_end - gdc_vram_base;
-		int margin = c->vc_size_row /* * 4 */;
-		int ul, we, p, st;
-
-		if (gdc_rolled_over > c->vc_scr_end - gdc_vram_base + margin) {
-			ul = c->vc_scr_end - gdc_vram_base;
-			we = gdc_rolled_over + c->vc_size_row;
-		} else {
-			ul = 0;
-			we = vram_size;
-		}
-
-		p = (c->vc_visible_origin - gdc_vram_base - ul + we)
-			% we + lines * c->vc_size_row;
-		st = (c->vc_origin - gdc_vram_base - ul + we) % we;
-		if (p < margin)
-			p = 0;
-
-		if (p > st - margin)
-			p = st;
-		c->vc_visible_origin = gdc_vram_base + (p + ul) % we;
-	}
-
-	gdc_set_mem_top(c);
-	return 1;
-}
-
-static int gdccon_set_origin(struct vc_data *c)
-{
-	c->vc_origin = c->vc_visible_origin = gdc_vram_base;
-	gdc_set_mem_top(c);
-	gdc_rolled_over = 0;
-	return 1;
-}
-
-static void gdccon_save_screen(struct vc_data *c)
-{
-	static int gdc_bootup_console = 0;
-
-	if (!gdc_bootup_console) {
-		/* This is a gross hack, but here is the only place we can
-		 * set bootup console parameters without messing up generic
-		 * console initialization routines.
-		 */
-		gdc_bootup_console = 1;
-		c->vc_x = ORIG_X;
-		c->vc_y = ORIG_Y;
-	}
-
-	_scr_memcpyw_from((u16 *)c->vc_screenbuf,
-				(u16 *)c->vc_origin, c->vc_screenbuf_size);
-	_scr_memcpyw_from((u16 *)((char *)c->vc_screenbuf + c->vc_screenbuf_size), (u16 *)gdc_attr_offset(c->vc_origin), c->vc_screenbuf_size);
-}
-
-static int gdccon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
-{
-	unsigned long oldo;
-	unsigned int delta;
-
-	if (t || b != c->vc_rows)
-		return 0;
-
-	if (c->vc_origin != c->vc_visible_origin)
-		gdccon_scrolldelta(c, 0);
-
-	if (!gdc_hardscroll_enabled || lines >= c->vc_rows / 2)
-		return 0;
-
-	oldo = c->vc_origin;
-	delta = lines * c->vc_size_row;
-	if (dir == SM_UP) {
-		if (c->vc_scr_end + delta >= gdc_vram_end) {
-			_scr_memcpyw((u16 *)gdc_vram_base,
-				    (u16 *)(oldo + delta),
-				    c->vc_screenbuf_size - delta);
-			_scr_memcpyw((u16 *)gdc_attr_offset(gdc_vram_base),
-				    (u16 *)gdc_attr_offset(oldo + delta),
-				    c->vc_screenbuf_size - delta);
-			c->vc_origin = gdc_vram_base;
-			gdc_rolled_over = oldo - gdc_vram_base;
-		} else
-			c->vc_origin += delta;
-
-		_scr_memsetw((u16 *)(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char & 0xff, delta);
-		_scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin + c->vc_screenbuf_size - delta), c->vc_video_erase_char >> 8, delta);
-	} else {
-		if (oldo - delta < gdc_vram_base) {
-			_scr_memmovew((u16 *)(gdc_vram_end - c->vc_screenbuf_size + delta), (u16 *)oldo, c->vc_screenbuf_size - delta);
-			_scr_memmovew((u16 *)gdc_attr_offset(gdc_vram_end - c->vc_screenbuf_size + delta), (u16 *)gdc_attr_offset(oldo), c->vc_screenbuf_size - delta);
-			c->vc_origin = gdc_vram_end - c->vc_screenbuf_size;
-			gdc_rolled_over = 0;
-		} else
-			c->vc_origin -= delta;
-
-		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
-		_scr_memsetw((u16 *)(c->vc_origin), c->vc_video_erase_char & 0xff, delta);
-		_scr_memsetw((u16 *)gdc_attr_offset(c->vc_origin), c->vc_video_erase_char >> 8, delta);
-	}
-
-	c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
-	c->vc_visible_origin = c->vc_origin;
-	gdc_set_mem_top(c);
-	c->vc_pos = (c->vc_pos - oldo) + c->vc_origin;
-	return 1;
-}
-
-static int gdccon_setterm_command(struct vc_data *c)
-{
-	switch (c->vc_par[0]) {
-	case 1: /* set attr for underline mode */
-		if (c->vc_npar < 2) {
-			if (c->vc_par[1] < 16)
-				c->vc_ul_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
-		} else {
-			if (c->vc_par[2] < 256)
-				c->vc_ul_attr = c->vc_par[2];
-		}
-
-		if (c->vc_underline)
-			goto update_attr;
-
-		return 1;
-
-	case 2:	/* set attr for half intensity mode */
-		if (c->vc_npar < 2) {
-			if (c->vc_par[1] < 16)
-				c->vc_half_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
-		}
-		else {
-			if (c->vc_par[2] < 256)
-				c->vc_half_attr = c->vc_par[2];
-		}
-
-		if (c->vc_intensity == 0)
-			goto update_attr;
-
-		return 1;
-
-	case 3: /* set color for bold mode */
-		if (c->vc_npar < 2) {
-			if (c->vc_par[1] < 16)
-				c->vc_bold_attr = gdccon_color_table[color_table[c->vc_par[1]] & 7];
-		} else {
-			if (c->vc_par[2] < 256)
-				c->vc_bold_attr = c->vc_par[2];
-		}
-
-		if (c->vc_intensity == 2)
-			goto update_attr;
-
-		return 1;
-	}
-
-	return 0;
-
-update_attr:
-	c->vc_attr = gdccon_build_attr(c,
-					c->vc_color, c->vc_intensity,
-					c->vc_blink, c->vc_underline,
-					c->vc_reverse);
-	return 1;
-}
-
-/*
- *  The console `switch' structure for the GDC based console
- */
-
-static int gdccon_dummy(struct vc_data *c)
-{
-	return 0;
-}
-
-#define DUMMY (void *) gdccon_dummy
-
-const struct consw gdc_con = {
-	.con_startup =		gdccon_startup,
-	.con_init =		gdccon_init,
-	.con_deinit =		gdccon_deinit,
-	.con_clear =		DUMMY,
-	.con_putc =		DUMMY,
-	.con_putcs =		DUMMY,
-	.con_cursor =		gdccon_cursor,
-	.con_scroll =		gdccon_scroll,
-	.con_bmove =		DUMMY,
-	.con_switch =		gdccon_switch,
-	.con_blank =		gdccon_blank,
-	.con_font_op =		gdccon_font_op,
-	.con_set_palette =	gdccon_set_palette,
-	.con_scrolldelta =	gdccon_scrolldelta,
-	.con_set_origin =	gdccon_set_origin,
-	.con_save_screen =	gdccon_save_screen,
-	.con_build_attr =	gdccon_build_attr,
-	.con_invert_region =	gdccon_invert_region,
-	.con_setterm_command =	gdccon_setterm_command
-};
-
-static int __init gdc_setup(char *str)
-{
-	unsigned long tmp_ulong;
-	char *opt, *orig_opt, *endp;
-
-	while ((opt = strsep(&str, ",")) != NULL) {
-		int force = 0;
-
-		orig_opt = opt;
-		if (!strncmp(opt, "force", 5)) {
-			force = 1;
-			opt += 5;
-		}
-
-		if (!strcmp(opt, "mono"))
-			gdc_can_do_color = 0;
-		else if ((tmp_ulong = simple_strtoul(opt, &endp, 0)) > 0) {
-			if (!strcmp(endp, "lines")
-			    || (!strcmp(endp, "linesforce") && (force == 1))) {
-				if (!force
-				    && (tmp_ulong < 20
-					|| (!PC9800_9821_P()
-					    && 25 < tmp_ulong)
-					|| 37 < tmp_ulong))
-					printk(KERN_ERR
-						"gdccon: %d is out of bound"
-						" for number of lines\n",
-						(int)tmp_ulong);
-				else
-					gdc_video_num_lines = tmp_ulong;
-			} else if (!strcmp(endp, "kHz")) {
-				if (tmp_ulong == 24 || tmp_ulong == 25)
-					gdc_disp_freq = DISP_FREQ_25k;
-				else
-					printk(KERN_ERR "gdccon: `%s' ignored\n",
-						orig_opt);
-			} else
-				printk(KERN_ERR "gdccon: unknown option `%s'\n",
-					orig_opt);
-		} else
-			printk(KERN_ERR "gdccon: unknown option `%s'\n",
-				orig_opt);
-	}
-
-	return 1; 
-}
-
-__setup("gdccon=", gdc_setup);
-
-/*
- * We will follow Linus's indenting style...
- *
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
diff -Nru linux-2.5.61-ac1/include/asm-i386/gdc.h linux98-2.5.61/include/asm-i386/gdc.h
--- linux98-2.5.61-ac1/include/asm-i386/gdc.h	2003-02-18 08:58:29.000000000 +0900
+++ linux98-2.5.61/include/asm-i386/gdc.h	2003-02-17 14:20:58.000000000 +0900
@@ -55,26 +55,29 @@
 _scr_memsetw(u16 *s, u16 c, unsigned int count)
 {
 #ifdef CONFIG_GDC_32BITACCESS
-	__asm__ __volatile__ ("shr%L1 %1
-	jz 2f
-" /*	cld	kernel code now assumes DF = 0 any time */ "\
-	test%L0 %3,%0
-	jz 1f
-	stos%W2
-	dec%L1 %1
-1:	shr%L1 %1
-	rep
-	stos%L2
-	jnc 2f
-	stos%W2
-	rep
-	stos%W2
-2:"
+	__asm__ __volatile__ (
+	"shr%L1 %1\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	kernel code now assumes DF = 0 any time */
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"stos%W2\n\t"
+	"dec%L1 %1\n"
+"1:	shr%L1 %1\n\t"
+	"rep\n\t"
+	"stos%L2\n\t"
+	"jnc 2f\n\t"
+	"stos%W2\n\t"
+	"rep\n\t"
+	"stos%W2\n"
+"2:"
 			      : "=D"(s), "=c"(count)
 			      : "a"((((u32) c) << 16) | c), "g"(2),
 			        "0"(s), "1"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tstosw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"stosw"
 			      : "=D"(s), "=c"(count)
 			      : "0"(s), "1"(count / 2), "a"(c));
 #endif	
@@ -92,23 +95,26 @@
 _scr_memcpyw(u16 *d, u16 *s, unsigned int count)
 {
 #if 1 /* def CONFIG_GDC_32BITACCESS */
-	__asm__ __volatile__ ("shr%L2 %2
-	jz 2f
-" /*	cld	*/ "\
-	test%L0 %3,%0
-	jz 1f
-	movs%W0
-	dec%L2 %2
-1:	shr%L2 %2
-	rep
-	movs%L0
-	jnc 2f
-	movs%W0
-2:"
+	__asm__ __volatile__ (
+	"shr%L2 %2\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	*/
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"movs%W0\n\t"
+	"dec%L2 %2\n"
+"1:	shr%L2 %2\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 2f\n\t"
+	"movs%W0\n"
+"2:"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "0"(d), "1"(s), "2"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tmovsw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"movsw"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"(d), "1"(s), "2"(count / 2));
 #endif
@@ -126,30 +132,35 @@
 #if 1 /* def CONFIG_GDC_32BITACCESS */
 	u16 tmp;
 
-	__asm__ __volatile__ ("shr%L3 %3
-	jz 2f
-	std
-	lea%L1 -4(%1,%3,2),%1
-	lea%L2 -4(%2,%3,2),%2
-	test%L1 %4,%1
-	jz 1f
-	mov%W0 2(%2),%0
-	sub%L2 %4,%2
-	dec%L3 %3
-	mov%W0 %0,2(%1)
-	sub%L1 %4,%1
-1:	shr%L3 %3
-	rep
-	movs%L0
-	jnc 3f
-	mov%W0 2(%2),%0
-	mov%W0 %0,2(%1)
-3:	cld
-2:"
+	__asm__ __volatile__ (
+	"shr%L3 %3\n\t"
+	"jz 2f\n\t"
+	"std\n\t"
+	"lea%L1 -4(%1,%3,2),%1\n\t"
+	"lea%L2 -4(%2,%3,2),%2\n\t"
+	"test%L1 %4,%1\n\t"
+	"jz 1f\n\t"
+	"mov%W0 2(%2),%0\n\t"
+	"sub%L2 %4,%2\n\t"
+	"dec%L3 %3\n\t"
+	"mov%W0 %0,2(%1)\n\t"
+	"sub%L1 %4,%1\n"
+"1:	shr%L3 %3\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 3f\n\t"
+	"mov%W0 2(%2),%0\n\t"
+	"mov%W0 %0,2(%1)\n"
+"3:	cld\n"
+"2:"
 			      : "=r"(tmp), "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "1"(d), "2"(s), "3"(count));
 #else
-	__asm__ __volatile__ ("std\n\trep\n\tmovsw\n\tcld"
+	__asm__ __volatile__ (
+	"std\n\t"
+	"rep\n\t"
+	"movsw\n\t"
+	"cld"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"((void *) d + count - 2),
 			        "1"((void *) s + count - 2), "2"(count / 2));
@@ -179,23 +190,26 @@
 #ifdef CONFIG_GDC_32BITACCESS
 	/* VRAM is quite slow, so we align source pointer (%esi)
 	   to double-word alignment. */
-	__asm__ __volatile__ ("shr%L2 %2
-	jz 2f
-" /*	cld	*/ "\
-	test%L0 %3,%0
-	jz 1f
-	movs%W0
-	dec%L2 %2
-1:	shr%L2 %2
-	rep
-	movs%L0
-	jnc 2f
-	movs%W0
-2:"
+	__asm__ __volatile__ (
+	"shr%L2 %2\n\t"
+	"jz 2f\n\t"
+ /*	"cld\n\t"	*/
+	"test%L0 %3,%0\n\t"
+	"jz 1f\n\t"
+	"movs%W0\n\t"
+	"dec%L2 %2\n"
+"1:	shr%L2 %2\n\t"
+	"rep\n\t"
+	"movs%L0\n\t"
+	"jnc 2f\n\t"
+	"movs%W0\n"
+"2:"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "g"(2), "0"(d), "1"(s), "2"(count));
 #else
-	__asm__ __volatile__ ("rep\n\tmovsw"
+	__asm__ __volatile__ (
+	"rep\n\t"
+	"movsw"
 			      : "=D"(d), "=S"(s), "=c"(count)
 			      : "0"(d), "1"(s), "2"(count / 2));
 #endif
diff -Nru linux-2.5.61-ac1/include/asm-i386/mach-pc9800/entry_arch.h linux98-2.5.61/include/asm-i386/mach-pc9800/entry_arch.h
--- linux-2.5.61-ac1/include/asm-i386/mach-pc9800/entry_arch.h	2003-02-18 08:58:29.000000000 +0900
+++ linux98-2.5.61/include/asm-i386/mach-pc9800/entry_arch.h	1970-01-01 09:00:00.000000000 +0900
@@ -1 +0,0 @@
-#include "../mach-generic/entry_arch.h"
diff -Nru linux-2.5.61-ac1/include/asm-i386/mach-pc9800/mach_apic.h linux98-2.5.61/include/asm-i386/mach-pc9800/mach_apic.h
--- linux-2.5.61-ac1/include/asm-i386/mach-pc9800/mach_apic.h	2003-02-18 08:58:29.000000000 +0900
+++ linux98-2.5.61/include/asm-i386/mach-pc9800/mach_apic.h	1970-01-01 09:00:00.000000000 +0900
@@ -1 +0,0 @@
-#include "../mach-generic/mach_apic.h"
diff -Nru linux-2.5.61-ac1/include/asm-i386/serial.h linux98-2.5.61/include/asm-i386/serial.h
--- linux-2.5.61-ac1/include/asm-i386/serial.h	2003-02-18 08:58:30.000000000 +0900
+++ linux98-2.5.61/include/asm-i386/serial.h	2003-02-18 15:20:20.000000000 +0900
@@ -50,7 +50,7 @@
 
 #define C_P(card,port) (((card)<<6|(port)<<3) + 1)
 
-#ifndef CONFIG_PC9800
+#ifndef CONFIG_X86_PC9800
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
@@ -62,7 +62,7 @@
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x30, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x238, 5, STD_COM_FLAGS },	/* ttyS1 */
-#endif /* CONFIG_PC9800 */
+#endif /* CONFIG_X86_PC9800 */
 
 
 #ifdef CONFIG_SERIAL_MANY_PORTS
diff -Nru linux-2.5.61-ac1/include/asm-i386/upd4990a.h linux98-2.5.61/include/asm-i386/upd4990a.h
--- linux-2.5.61-ac1/include/asm-i386/upd4990a.h	2003-02-18 08:58:30.000000000 +0900
+++ linux98-2.5.61/include/asm-i386/upd4990a.h	2003-02-17 14:20:55.000000000 +0900
@@ -13,10 +13,6 @@
 #ifndef _ASM_I386_uPD4990A_H
 #define _ASM_I386_uPD4990A_H
 
-#include <linux/config.h>
-
-#ifdef CONFIG_PC9800
-
 #include <asm/io.h>
 
 #define UPD4990A_IO		(0x0020)
@@ -53,6 +49,4 @@
 /* Caller should ignore all bits except bit0 */
 #define UPD4990A_READ_DATA()	inb(UPD4990A_IO_DATAOUT)
 
-#endif /* CONFIG_PC9800 */
-
 #endif
