Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTIHCxP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 22:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbTIHCxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 22:53:15 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:50816
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261158AbTIHCxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 22:53:12 -0400
Date: Sun, 7 Sep 2003 22:53:08 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Greg Kroah-Hartmann <greg@kroah.com>
Subject: [PATCH][2.6][CFT] rmmod floppy kills box fixes + default_device_remove
Message-ID: <Pine.LNX.4.53.0309072228470.14426@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy gave me the courage to delve in there... now that i'm lost to the 
world here is one picked up from bugzilla;

The crux of it is that the floppy driver isn't deleting timers before 
unloading itself. I've tested it locally somewhat, but the ioport 
busy looks very strange (although things do function). There is one part 
of this patch that i'd like Greg to look at, it's the 
default_device_release addition...

http://bugme.osdl.org/show_bug.cgi?id=1061

This is from the bugzilla and is the closest to a oops/backtrace the 
reporter could put together. 

esi: c02e1080  edi: c02e0780  ebp: c0349ef8  esp: c0349ee4
ds: 007b  es:007b  ss: 0068

Process: swapper (pid: 0, threadinfo=c034800 task=c02dd980)
Stack: 00000001 00000000 00000000 c03711c8 c0349f0c c0349f24 c0120681 c02e0780
       c02e0f88 0000001f c0349f0c c0349f0c c02ff5fc 00000001 c03711c8 0000000a
       c0349f40 c011c899 c03711c8 00000046 00000000 c0345a00 00000000 c0349f64

Call Trace:
[<c0120681>] run_timer_softirq+0x101/0x180
[<c011c899>] do_softirq+0x99/0xa0
[<c010ad68>] do_IRQ+0xe8/0x120
[<c01092dc>] common_interrupt+0x18/0x20
[<c01dfcfa>] acpi_processor_idle+0x15a/0x1ef
[<c01dfba0>] acpi_processor_idle+0x0/0x1ef
[<c0107000>] default_idle+0x0/0x30
[<c01070a1>] cpu_idle+0x31/0x40
[<c0105000>] rest_init0x0/0x30
[<c034a6ec>] start_kernel+0x15c/0x190
[<c034a460>] unknown_bootoption+0x0/0x100

Code: 94 00 b5 38 2a c0 eb bf 8d 76 00 55 89 e5 57 56 53 83 ec 08 8b 75 10 8b 7d
 08 c1 e6 03 03 75 0c 8b 1e 39 f3 74 1e 90 8d 74 26 00 <39> 7b 18 89 d8 75 22 8b
 1b 89 3c 24 89 44 24 04 e8 1b fd ff ff
 <0> kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

Index: /build/source/linux-2.6.0-test4-mm6/drivers/block/floppy.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm6/drivers/block/floppy.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 floppy.c
--- /build/source/linux-2.6.0-test4-mm6/drivers/block/floppy.c	7 Sep 2003 20:26:57 -0000	1.1.1.1
+++ /build/source/linux-2.6.0-test4-mm6/drivers/block/floppy.c	8 Sep 2003 02:40:46 -0000
@@ -4206,6 +4206,9 @@ static int have_no_fdc= -ENODEV;
 static struct platform_device floppy_device = {
 	.name		= "floppy",
 	.id		= 0,
+	.dev		= {
+			.release = default_device_release,
+	}
 };
 
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
@@ -4580,7 +4583,10 @@ void cleanup_module(void)
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
@@ -4590,7 +4596,13 @@ void cleanup_module(void)
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
 }
Index: /build/source/linux-2.6.0-test4-mm6/drivers/base/core.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm6/drivers/base/core.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 core.c
--- /build/source/linux-2.6.0-test4-mm6/drivers/base/core.c	7 Sep 2003 20:26:56 -0000	1.1.1.1
+++ /build/source/linux-2.6.0-test4-mm6/drivers/base/core.c	7 Sep 2003 23:20:48 -0000
@@ -332,6 +332,14 @@ void device_del(struct device * dev)
 }
 
 /**
+ *	@default_device_release - default null release function
+ *	@dev: device to release
+ */
+void default_device_release(struct device *dev)
+{
+}
+
+/**
  *	device_unregister - unregister device from system.
  *	@dev:	device going away.
  *
@@ -381,6 +389,7 @@ int __init devices_init(void)
 	return subsystem_register(&devices_subsys);
 }
 
+EXPORT_SYMBOL(default_device_release);
 EXPORT_SYMBOL(device_for_each_child);
 
 EXPORT_SYMBOL(device_initialize);
Index: /build/source/linux-2.6.0-test4-mm6/include/linux/device.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm6/include/linux/device.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 device.h
--- /build/source/linux-2.6.0-test4-mm6/include/linux/device.h	7 Sep 2003 20:27:50 -0000	1.1.1.1
+++ /build/source/linux-2.6.0-test4-mm6/include/linux/device.h	7 Sep 2003 23:21:58 -0000
@@ -304,6 +304,7 @@ extern void device_unregister(struct dev
 extern void device_initialize(struct device * dev);
 extern int device_add(struct device * dev);
 extern void device_del(struct device * dev);
+extern void default_device_release(struct device *dev);
 extern int device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));
 
