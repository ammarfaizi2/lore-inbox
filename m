Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbUDOV17 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbUDOV17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:27:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:5317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262800AbUDOV1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:27:50 -0400
Date: Thu, 15 Apr 2004 14:22:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tomita@cinet.co.jp
Subject: [PATCH] floppy98.c to build cleanly
Message-Id: <20040415142244.5fe3a903.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


floppy98.c (along with other PC-9800 files) has not been updated
lately.  It won't build currently (2.6.5).

This patch makes floppy98 build cleanly.

--
~Randy


 drivers/block/floppy98.c |   49 +++++++++++++++++++++++++++++++++--------------
 1 files changed, 35 insertions(+), 14 deletions(-)


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-265-pv/drivers/block/floppy98.c linux-265-pc98/drivers/block/floppy98.c
--- linux-265-pv/drivers/block/floppy98.c	2004-04-03 19:36:56.000000000 -0800
+++ linux-265-pc98/drivers/block/floppy98.c	2004-04-14 14:50:11.000000000 -0700
@@ -168,8 +168,11 @@ static int print_unex=1;
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/version.h>
-#define FDPATCHES
 #include <linux/fdreg.h>
+#include <linux/blkdev.h>
+#include <linux/blkpg.h>
+#include <linux/cdrom.h>	/* for the compatibility eject ioctl */
+#include <linux/completion.h>
 
 /*
  * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
@@ -179,7 +182,6 @@ static int print_unex=1;
 #include <linux/fd.h>
 #define FLOPPY98_MOTOR_MASK 0x08
 
-#define FDPATCHES
 #include <linux/hdreg.h>
 #define FD98_STATUS	(0 + FD_IOPORT )
 #define FD98_DATA	(2 + FD_IOPORT )
@@ -250,9 +252,10 @@ static int use_virtual_dma;
  */
 
 static spinlock_t floppy_lock = SPIN_LOCK_UNLOCKED;
+static struct completion device_release;
 
 static unsigned short virtual_dma_port=0x3f0;
-void floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs);
+irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs);
 static int set_mode(char mask, char data);
 static void register_devfs_entries (int drive) __init;
 
@@ -987,9 +990,9 @@ static void empty(void)
 
 static DECLARE_WORK(floppy_work, NULL, NULL);
 
-static void schedule_bh( void (*handler)(void*) )
+static void schedule_bh(void (*handler) (void))
 {
-	PREPARE_WORK(&floppy_work, handler, NULL);
+	PREPARE_WORK(&floppy_work, (void (*)(void *))handler, NULL);
 	schedule_work(&floppy_work);
 }
 
@@ -1627,7 +1630,7 @@ static void print_result(char *message, 
 }
 
 /* interrupt handler. Note that this can be called externally on the Sparc */
-void floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
 	void (*handler)(void) = do_floppy;
 	int do_print;
@@ -1648,7 +1651,7 @@ void floppy_interrupt(int irq, void *dev
 		printk("floppy interrupt on bizarre fdc %d\n",fdc);
 		printk("handler=%p\n", handler);
 		is_alive("bizarre fdc");
-		return;
+		return IRQ_NONE;
 	}
 
 	FDCS->reset = 0;
@@ -1661,7 +1664,7 @@ void floppy_interrupt(int irq, void *dev
 	 * activity.
 	 */
 
-	do_print = !handler && !initialising;
+	do_print = !handler && print_unex && !initialising;
 
 	inr = result();
 	if (inr && do_print)
@@ -1701,13 +1704,16 @@ void floppy_interrupt(int irq, void *dev
 		} while ((ST0 & 0x83) != UNIT(current_drive) && inr == 2);
 	}
 	if (handler) {
-		schedule_bh( (void *)(void *) handler);
+		schedule_bh(handler);
 	} else {
 #if 0
 		FDCS->reset = 1;
 #endif
 	}
 	is_alive("normal interrupt end");
+
+	/* FIXME! Was it really for us? */
+	return IRQ_HANDLED;
 }
 
 static void recalibrate_floppy(void)
@@ -4231,11 +4237,16 @@ static int __init floppy_setup(char *str
 
 static int have_no_fdc= -ENODEV;
 
+static void floppy_device_release(struct device *dev)
+{
+	complete(&device_release);
+}
+
 static struct platform_device floppy_device = {
 	.name		= "floppy",
 	.id		= 0,
 	.dev		= {
-		.name	= "Floppy Drive",
+			.release = floppy_device_release,
 	},
 };
 
@@ -4267,10 +4278,8 @@ int __init floppy_init(void)
 	}
 
 	devfs_mk_dir (NULL, "floppy", NULL);
-	if (register_blkdev(FLOPPY_MAJOR,"fd")) {
-		err = -EBUSY;
+	if ((err = register_blkdev(FLOPPY_MAJOR,"fd")))
 		goto out;
-	}
 
 	for (i=0; i<N_DRIVE; i++) {
 		disks[i]->major = FLOPPY_MAJOR;
@@ -4288,7 +4297,7 @@ int __init floppy_init(void)
 		else
 			floppy_sizes[i] = MAX_DISK_SIZE << 1;
 
-	floppy_queue = blk_init_queue(do_fd_request, &floppy_lock)
+	floppy_queue = blk_init_queue(do_fd_request, &floppy_lock);
 	if (!floppy_queue)
 		goto out_queue;
 
@@ -4628,10 +4637,14 @@ void cleanup_module(void)
 {
 	int drive;
 		
+	init_completion(&device_release);
 	platform_device_unregister(&floppy_device);
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
+
 	for (drive = 0; drive < N_DRIVE; drive++) {
+		del_timer_sync(&motor_off_timer[drive]);
+
 		if ((allowed_drive_mask & (1 << drive)) &&
 		    fdc_state[FDC(drive)].version != FDC_NONE) {
 			del_gendisk(disks[drive]);
@@ -4641,9 +4654,17 @@ void cleanup_module(void)
 	}
 	devfs_remove("floppy");
 
+	del_timer_sync(&fd_timeout);
+	del_timer_sync(&fd_timer);
 	blk_cleanup_queue(floppy_queue);
+
+	if (usage_count)
+		floppy_release_irq_and_dma();
+
 	/* eject disk, if any */
 	fd_eject(0);
+
+	wait_for_completion(&device_release);
 }
 
 MODULE_PARM(floppy,"s");
