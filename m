Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVAZGtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVAZGtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 01:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVAZGtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 01:49:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15047 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262368AbVAZGpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 01:45:40 -0500
Date: Wed, 26 Jan 2005 01:45:39 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Remove sched.h inclusion from module.h
Message-ID: <20050126064539.GA17853@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I resurrected this ancient patch I did about 9 months ago
that fell by the wayside.  module.h pulls in sched.h,
which means that anything built as a module pulls in
a zillion (mostly unneeded) include files.

When I benchmarked the difference back last year, I'm fairly
sure it was on the order of 2 minutes faster after the
untangling below. Today, I'm only able to squeeze out
a 30 second improvement on make allmodconfig. Maybe I had
less RAM back then. *shrug*.

Build tested on x86/x86-64 only, other archs will likely
need minor fixups in arch/.

		Dave

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/26 00:52:17-05:00 davej@redhat.com 
#   [INCLUDE] Remove sched.h inclusion from module.h.
#   Also move some capability bits to capability.h, and break
#   out some of sched.h to wakeup.h
#   
#   Build checked for make all modconfig,yesconfig,noconfig
#   
#   Signed-off-by: Dave Jones <davej@redhat.com>
# 

diff -Nru a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
--- a/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2005-01-26 01:36:57 -05:00
+++ b/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2005-01-26 01:36:57 -05:00
@@ -31,6 +31,7 @@
 #include <linux/cpufreq.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/sched.h>	/* current */
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/uaccess.h>
diff -Nru a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2005-01-26 01:36:57 -05:00
+++ b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2005-01-26 01:36:57 -05:00
@@ -28,6 +28,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/cpumask.h>
+#include <linux/sched.h>	/* current / set_cpus_allowed() */
 
 #include <asm/processor.h> 
 #include <asm/msr.h>
diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-01-26 01:36:57 -05:00
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-01-26 01:36:57 -05:00
@@ -30,6 +30,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/sched.h>	/* for current / set_cpus_allowed() */
 
 #include <asm/msr.h>
 #include <asm/io.h>
diff -Nru a/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- a/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-01-26 01:36:57 -05:00
+++ b/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-01-26 01:36:57 -05:00
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/config.h>
+#include <linux/sched.h>	/* current */
 #include <linux/delay.h>
 #include <linux/compiler.h>
 
diff -Nru a/arch/i386/kernel/cpu/mtrr/if.c b/arch/i386/kernel/cpu/mtrr/if.c
--- a/arch/i386/kernel/cpu/mtrr/if.c	2005-01-26 01:36:57 -05:00
+++ b/arch/i386/kernel/cpu/mtrr/if.c	2005-01-26 01:36:57 -05:00
@@ -3,6 +3,7 @@
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/capability.h>
 #include <asm/uaccess.h>
 
 #define LINE_SIZE 80
diff -Nru a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/acpi/processor_idle.c	2005-01-26 01:36:57 -05:00
@@ -35,6 +35,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
+#include <linux/sched.h>	/* need_resched() */
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff -Nru a/drivers/block/paride/paride.c b/drivers/block/paride/paride.c
--- a/drivers/block/paride/paride.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/block/paride/paride.c	2005-01-26 01:36:57 -05:00
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/sched.h>	/* TASK_* */
 
 #ifdef CONFIG_PARPORT_MODULE
 #define CONFIG_PARPORT
diff -Nru a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/block/paride/pg.c	2005-01-26 01:36:57 -05:00
@@ -162,6 +162,8 @@
 #include <linux/mtio.h>
 #include <linux/pg.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* current, TASK_* */
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 
diff -Nru a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/block/paride/pt.c	2005-01-26 01:36:57 -05:00
@@ -146,6 +146,7 @@
 #include <linux/slab.h>
 #include <linux/mtio.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* current, TASK_*, schedule_timeout() */
 
 #include <asm/uaccess.h>
 
diff -Nru a/drivers/char/i8k.c b/drivers/char/i8k.c
--- a/drivers/char/i8k.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/char/i8k.c	2005-01-26 01:36:57 -05:00
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/apm_bios.h>
+#include <linux/capability.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -Nru a/drivers/char/watchdog/cpu5wdt.c b/drivers/char/watchdog/cpu5wdt.c
--- a/drivers/char/watchdog/cpu5wdt.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/char/watchdog/cpu5wdt.c	2005-01-26 01:36:57 -05:00
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/char/watchdog/mixcomwd.c	2005-01-26 01:36:57 -05:00
@@ -45,6 +45,8 @@
 #include <linux/fs.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/char/watchdog/pcwd.c	2005-01-26 01:36:57 -05:00
@@ -66,7 +66,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
-
+#include <linux/sched.h>	/* TASK_INTERRUPTIBLE, set_current_state() and friends */
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/char/watchdog/sc520_wdt.c	2005-01-26 01:36:57 -05:00
@@ -63,6 +63,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/char/watchdog/softdog.c	2005-01-26 01:36:57 -05:00
@@ -47,6 +47,8 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+
 #include <asm/uaccess.h>
 
 #define PFX "SoftDog: "
diff -Nru a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
--- a/drivers/infiniband/core/cache.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/infiniband/core/cache.c	2005-01-26 01:36:57 -05:00
@@ -36,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/sched.h>	/* INIT_WORK, schedule_work(), flush_scheduled_work() */
 
 #include "core_priv.h"
 
diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/gameport/gameport.c	2005-01-26 01:36:57 -05:00
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/delay.h>
+#include <linux/sched.h>	/* HZ */
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Generic gameport layer");
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/a3d.c	2005-01-26 01:36:57 -05:00
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("FP-Gaming Assasin 3D joystick driver");
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/adi.c	2005-01-26 01:36:57 -05:00
@@ -36,6 +36,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Logitech ADI joystick family driver");
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/analog.c	2005-01-26 01:36:57 -05:00
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 #include <asm/timex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
diff -Nru a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
--- a/drivers/input/joystick/cobra.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/cobra.c	2005-01-26 01:36:57 -05:00
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Creative Labs Blaster GamePad Cobra driver");
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/gf2k.c	2005-01-26 01:36:57 -05:00
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Genius Flight 2000 joystick driver");
diff -Nru a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
--- a/drivers/input/joystick/grip.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/grip.c	2005-01-26 01:36:57 -05:00
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Gravis GrIP protocol joystick driver");
diff -Nru a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
--- a/drivers/input/joystick/grip_mp.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/grip_mp.c	2005-01-26 01:36:57 -05:00
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Brian Bonnlander");
 MODULE_DESCRIPTION("Gravis Grip Multiport driver");
diff -Nru a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
--- a/drivers/input/joystick/guillemot.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/guillemot.c	2005-01-26 01:36:57 -05:00
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Guillemot Digital joystick driver");
diff -Nru a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
--- a/drivers/input/joystick/interact.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/interact.c	2005-01-26 01:36:57 -05:00
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("InterAct digital joystick driver");
diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/sidewinder.c	2005-01-26 01:36:57 -05:00
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Microsoft SideWinder joystick family driver");
diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/input/joystick/tmdc.c	2005-01-26 01:36:57 -05:00
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("ThrustMaster DirectConnect joystick driver");
diff -Nru a/drivers/isdn/capi/capifs.c b/drivers/isdn/capi/capifs.c
--- a/drivers/isdn/capi/capifs.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/isdn/capi/capifs.c	2005-01-26 01:36:57 -05:00
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ctype.h>
+#include <linux/sched.h>	/* current */
 
 MODULE_DESCRIPTION("CAPI4Linux: /dev/capi/ filesystem");
 MODULE_AUTHOR("Carsten Paeth");
diff -Nru a/drivers/media/radio/miropcm20-rds.c b/drivers/media/radio/miropcm20-rds.c
--- a/drivers/media/radio/miropcm20-rds.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/media/radio/miropcm20-rds.c	2005-01-26 01:36:57 -05:00
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/sched.h>	/* current, TASK_*, schedule_timeout() */
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include "miropcm20-rds-core.h"
diff -Nru a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/mtd/mtdblock.c	2005-01-26 01:36:57 -05:00
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/sched.h>	/* TASK_* */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/blktrans.h>
 
diff -Nru a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/mtd/mtdchar.c	2005-01-26 01:36:57 -05:00
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/sched.h>	/* TASK_* */
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_DEVFS_FS
diff -Nru a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
--- a/drivers/mtd/mtdconcat.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/mtd/mtdconcat.c	2005-01-26 01:36:57 -05:00
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-
+#include <linux/sched.h>	/* TASK_* */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/concat.h>
 
diff -Nru a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
--- a/drivers/scsi/scsi_transport_fc.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/scsi/scsi_transport_fc.c	2005-01-26 01:36:57 -05:00
@@ -19,6 +19,7 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sched.h>	/* workqueue stuff, HZ */
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h>
diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c	2005-01-26 01:36:57 -05:00
+++ b/drivers/w1/w1_family.c	2005-01-26 01:36:57 -05:00
@@ -21,6 +21,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/sched.h>	/* schedule_timeout() */
 #include <linux/delay.h>
 
 #include "w1_family.h"
diff -Nru a/fs/filesystems.c b/fs/filesystems.c
--- a/fs/filesystems.c	2005-01-26 01:36:57 -05:00
+++ b/fs/filesystems.c	2005-01-26 01:36:57 -05:00
@@ -12,6 +12,7 @@
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/sched.h>	/* for 'current' */
 #include <asm/uaccess.h>
 
 /*
diff -Nru a/fs/jffs2/background.c b/fs/jffs2/background.c
--- a/fs/jffs2/background.c	2005-01-26 01:36:57 -05:00
+++ b/fs/jffs2/background.c	2005-01-26 01:36:57 -05:00
@@ -15,6 +15,7 @@
 #include <linux/jffs2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/completion.h>
+#include <linux/sched.h>
 #include "nodelist.h"
 
 
diff -Nru a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
--- a/fs/jffs2/wbuf.c	2005-01-26 01:36:57 -05:00
+++ b/fs/jffs2/wbuf.c	2005-01-26 01:36:57 -05:00
@@ -18,6 +18,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/crc32.h>
 #include <linux/mtd/nand.h>
+#include <linux/jiffies.h>
+
 #include "nodelist.h"
 
 /* For testing write failures */
diff -Nru a/include/linux/capability.h b/include/linux/capability.h
--- a/include/linux/capability.h	2005-01-26 01:36:57 -05:00
+++ b/include/linux/capability.h	2005-01-26 01:36:57 -05:00
@@ -357,6 +357,21 @@
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
 
+#ifdef CONFIG_SECURITY
+/* code is in security.c */
+extern int capable(int cap);
+#else
+static inline int capable(int cap)
+{
+	if (cap_raised(current->cap_effective, cap)) {
+		current->flags |= PF_SUPERPRIV;
+		return 1;
+	}
+	return 0;
+}
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* !_LINUX_CAPABILITY_H */
+
diff -Nru a/include/linux/cpufreq.h b/include/linux/cpufreq.h
--- a/include/linux/cpufreq.h	2005-01-26 01:36:57 -05:00
+++ b/include/linux/cpufreq.h	2005-01-26 01:36:57 -05:00
@@ -23,6 +23,7 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/cpumask.h>
+#include <asm/div64.h>
 
 #define CPUFREQ_NAME_LEN 16
 
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-01-26 01:36:57 -05:00
+++ b/include/linux/i2c.h	2005-01-26 01:36:57 -05:00
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
+#include <linux/sched.h>	/* for completion */
 #include <asm/semaphore.h>
 
 /* --- General options ------------------------------------------------	*/
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	2005-01-26 01:36:57 -05:00
+++ b/include/linux/module.h	2005-01-26 01:36:57 -05:00
@@ -7,7 +7,6 @@
  * Rewritten again by Rusty Russell, 2002
  */
 #include <linux/config.h>
-#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/stat.h>
@@ -18,8 +17,9 @@
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
-#include <asm/local.h>
+#include <linux/wait.h>
 
+#include <asm/local.h>
 #include <asm/module.h>
 
 /* Not Yet Implemented */
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2005-01-26 01:36:57 -05:00
+++ b/include/linux/sched.h	2005-01-26 01:36:57 -05:00
@@ -818,15 +818,8 @@
 
 extern void do_timer(struct pt_regs *);
 
-extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
-extern int FASTCALL(wake_up_process(struct task_struct * tsk));
-extern void FASTCALL(wake_up_new_task(struct task_struct * tsk,
-						unsigned long clone_flags));
-#ifdef CONFIG_SMP
- extern void kick_process(struct task_struct *tsk);
-#else
- static inline void kick_process(struct task_struct *tsk) { }
-#endif
+#include <linux/wait.h>
+
 extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
 
@@ -894,20 +887,6 @@
 		: on_sig_stack(sp) ? SS_ONSTACK : 0);
 }
 
-
-#ifdef CONFIG_SECURITY
-/* code is in security.c */
-extern int capable(int cap);
-#else
-static inline int capable(int cap)
-{
-	if (cap_raised(current->cap_effective, cap)) {
-		current->flags |= PF_SUPERPRIV;
-		return 1;
-	}
-	return 0;
-}
-#endif
 
 /*
  * Routines for handling mm_structs
diff -Nru a/include/linux/wait.h b/include/linux/wait.h
--- a/include/linux/wait.h	2005-01-26 01:36:57 -05:00
+++ b/include/linux/wait.h	2005-01-26 01:36:57 -05:00
@@ -147,6 +147,16 @@
 int FASTCALL(out_of_line_wait_on_bit_lock(void *, int, int (*)(void *), unsigned));
 wait_queue_head_t *FASTCALL(bit_waitqueue(void *, int));
 
+extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
+extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+extern void FASTCALL(wake_up_new_task(struct task_struct * tsk,
+			unsigned long clone_flags));
+#ifdef CONFIG_SMP
+ extern void kick_process(struct task_struct *tsk);
+#else
+ static inline void kick_process(struct task_struct *tsk) { }
+#endif
+
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
 #define wake_up_all(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, NULL)
diff -Nru a/include/pcmcia/ss.h b/include/pcmcia/ss.h
--- a/include/pcmcia/ss.h	2005-01-26 01:36:57 -05:00
+++ b/include/pcmcia/ss.h	2005-01-26 01:36:57 -05:00
@@ -19,6 +19,7 @@
 #include <pcmcia/cs.h>
 #include <pcmcia/bulkmem.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* task_struct, completion */
 
 /* Definitions for card status flags for GetStatus */
 #define SS_WRPROT	0x0001
diff -Nru a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
--- a/include/scsi/scsi_cmnd.h	2005-01-26 01:36:57 -05:00
+++ b/include/scsi/scsi_cmnd.h	2005-01-26 01:36:57 -05:00
@@ -4,6 +4,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
 #include <linux/types.h>
+#include <linux/timer.h>
 
 struct request;
 struct scatterlist;
diff -Nru a/include/scsi/scsi_transport_fc.h b/include/scsi/scsi_transport_fc.h
--- a/include/scsi/scsi_transport_fc.h	2005-01-26 01:36:57 -05:00
+++ b/include/scsi/scsi_transport_fc.h	2005-01-26 01:36:57 -05:00
@@ -21,6 +21,7 @@
 #define SCSI_TRANSPORT_FC_H
 
 #include <linux/config.h>
+#include <linux/sched.h>	/* work_struct */
 
 struct scsi_transport_template;
 
diff -Nru a/kernel/kallsyms.c b/kernel/kallsyms.c
--- a/kernel/kallsyms.c	2005-01-26 01:36:57 -05:00
+++ b/kernel/kallsyms.c	2005-01-26 01:36:57 -05:00
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/sched.h>	/* for cond_resched */
 #include <linux/mm.h>
 
 #include <asm/sections.h>
diff -Nru a/sound/oss/ac97_codec.c b/sound/oss/ac97_codec.c
--- a/sound/oss/ac97_codec.c	2005-01-26 01:36:57 -05:00
+++ b/sound/oss/ac97_codec.c	2005-01-26 01:36:57 -05:00
@@ -55,6 +55,7 @@
 #include <linux/pci.h>
 #include <linux/ac97_codec.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
 #define CODEC_ID_BUFSZ 14
 
