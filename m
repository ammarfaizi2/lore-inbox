Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVIXLET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVIXLET (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 07:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVIXLET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 07:04:19 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:32654 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S932165AbVIXLES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 07:04:18 -0400
Date: Sat, 24 Sep 2005 13:04:02 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] fix missing includes
Message-ID: <Pine.LNX.4.53.0509241258460.2235@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently picked up my older work to remove unnecessary #includes of
sched.h, starting from a patch by Dave Jones to not include sched.h
from module.h. This reduces the number of indirect includes of sched.h
by ~300. Another ~400 pointless direct includes can be removed after
this disentangling (patch to follow later).
However, quite a few indirect includes need to be fixed up for this.

In order to feed the patches through -mm with as little disturbance
as possible, I've split out the fixes I accumulated up to now (complete
for i386 and x86_64, more archs to follow later) and post them before
the real patch. This way this large part of the patch is kept simple
with only adding #includes, and all hunks are independent of each other.
So if any hunk rejects or gets in the way of other patches, just drop it.
My scripts will pick it up again in the next round.

thanks,
Tim



Fix missing includes. Based on a patch by Dave Jones.
This is a preparatory step for not including sched.h from module.h.

Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>

--- linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2005-09-24 10:47:21.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2005-09-24 10:56:04.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/compiler.h>
+#include <linux/sched.h>	/* current */
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/uaccess.h>

diff -urp linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux-2.6.14-rc2-mm1-sr-dj6/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2005-09-24 10:53:20.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/cpumask.h>
+#include <linux/sched.h>	/* current / set_cpus_allowed() */

 #include <asm/processor.h>
 #include <asm/msr.h>

--- linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-09-24 10:52:00.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-09-24 10:53:20.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/cpumask.h>
+#include <linux/sched.h>	/* for current / set_cpus_allowed() */

 #include <asm/msr.h>
 #include <asm/io.h>

--- linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-09-24 10:47:21.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2005-09-24 10:53:20.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/config.h>
+#include <linux/sched.h>	/* current */
 #include <linux/delay.h>
 #include <linux/compiler.h>


--- linux-2.6.14-rc2-mm1/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-09-24 10:52:00.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-09-24 10:53:20.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/compiler.h>
 #include <linux/cpu.h>
+#include <linux/sched.h>

 #include <asm/processor.h>
 #include <asm/smp.h>

--- linux-2.6.14-rc2-mm1/drivers/acpi/processor_idle.c	2005-09-24 10:52:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/acpi/processor_idle.c	2005-09-24 10:53:20.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/moduleparam.h>
+#include <linux/sched.h>	/* need_resched() */

 #include <asm/io.h>
 #include <asm/uaccess.h>

--- linux-2.6.14-rc2-mm1/drivers/base/sys.c	2005-09-24 10:47:24.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/base/sys.c	2005-09-24 10:53:20.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pm.h>
+#include <asm/semaphore.h>

 extern struct subsystem devices_subsys;


--- linux-2.6.14-rc2-mm1/drivers/block/paride/paride.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/block/paride/paride.c	2005-09-24 10:53:20.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/sched.h>	/* TASK_* */

 #ifdef CONFIG_PARPORT_MODULE
 #define CONFIG_PARPORT

--- linux-2.6.14-rc2-mm1/drivers/block/paride/pg.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/block/paride/pg.c	2005-09-24 10:53:20.000000000 +0200
@@ -162,6 +162,8 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_SLV,
 #include <linux/mtio.h>
 #include <linux/pg.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* current, TASK_* */
+#include <linux/jiffies.h>

 #include <asm/uaccess.h>


--- linux-2.6.14-rc2-mm1/drivers/block/paride/pt.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/block/paride/pt.c	2005-09-24 10:53:20.000000000 +0200
@@ -146,6 +146,7 @@ static int (*drives[4])[6] = {&drive0, &
 #include <linux/slab.h>
 #include <linux/mtio.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* current, TASK_*, schedule_timeout() */

 #include <asm/uaccess.h>


--- linux-2.6.14-rc2-mm1/drivers/char/watchdog/cpu5wdt.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/watchdog/cpu5wdt.c	2005-09-24 10:53:20.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>


--- linux-2.6.14-rc2-mm1/drivers/char/watchdog/mixcomwd.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/watchdog/mixcomwd.c	2005-09-24 10:53:20.000000000 +0200
@@ -45,6 +45,8 @@
 #include <linux/fs.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>


--- linux-2.6.14-rc2-mm1/drivers/char/watchdog/pcwd.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/watchdog/pcwd.c	2005-09-24 10:53:20.000000000 +0200
@@ -66,7 +66,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
-
+#include <linux/sched.h>	/* TASK_INTERRUPTIBLE, set_current_state() and friends */
 #include <asm/uaccess.h>
 #include <asm/io.h>


--- linux-2.6.14-rc2-mm1/drivers/char/watchdog/sc520_wdt.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/watchdog/sc520_wdt.c	2005-09-24 10:53:20.000000000 +0200
@@ -63,6 +63,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>

 #include <asm/io.h>
 #include <asm/uaccess.h>

--- linux-2.6.14-rc2-mm1/drivers/char/watchdog/softdog.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/char/watchdog/softdog.c	2005-09-24 10:53:20.000000000 +0200
@@ -47,6 +47,8 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+
 #include <asm/uaccess.h>

 #define PFX "SoftDog: "

--- linux-2.6.14-rc2-mm1/drivers/infiniband/core/cache.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/infiniband/core/cache.c	2005-09-24 10:53:20.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/sched.h>	/* INIT_WORK, schedule_work(), flush_scheduled_work() */

 #include <rdma/ib_cache.h>


--- linux-2.6.14-rc2-mm1/drivers/input/gameport/gameport.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/gameport/gameport.c	2005-09-24 10:53:20.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/sched.h>	/* HZ */

 /*#include <asm/io.h>*/


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/a3d.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/a3d.c	2005-09-24 10:53:20.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"FP-Gaming Assasin 3D joystick driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/adi.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/adi.c	2005-09-24 10:53:20.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"Logitech ADI joystick family driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/analog.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/analog.c	2005-09-24 10:53:20.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 #include <asm/timex.h>

 #define DRIVER_DESC	"Analog joystick and gamepad driver"

--- linux-2.6.14-rc2-mm1/drivers/input/joystick/cobra.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/cobra.c	2005-09-24 10:53:20.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"Creative Labs Blaster GamePad Cobra driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/gf2k.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/gf2k.c	2005-09-24 10:53:20.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"Genius Flight 2000 joystick driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/grip.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/grip.c	2005-09-24 10:53:20.000000000 +0200
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"Gravis GrIP protocol joystick driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/grip_mp.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/grip_mp.c	2005-09-24 10:53:20.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"Gravis Grip Multiport driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/guillemot.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/guillemot.c	2005-09-24 10:53:20.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"Guillemot Digital joystick driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/interact.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/interact.c	2005-09-24 10:53:20.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"InterAct digital joystick driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/sidewinder.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/sidewinder.c	2005-09-24 10:53:20.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"Microsoft SideWinder joystick family driver"


--- linux-2.6.14-rc2-mm1/drivers/input/joystick/tmdc.c	2005-09-24 10:47:25.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/joystick/tmdc.c	2005-09-24 10:53:20.000000000 +0200
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>

 #define DRIVER_DESC	"ThrustMaster DirectConnect joystick driver"


--- linux-2.6.14-rc2-mm1/drivers/input/serio/hp_sdc_mlc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/input/serio/hp_sdc_mlc.c	2005-09-24 10:53:20.000000000 +0200
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
+#include <asm/semaphore.h>

 #define PREFIX "HP SDC MLC: "


--- linux-2.6.14-rc2-mm1/drivers/isdn/capi/capifs.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/isdn/capi/capifs.c	2005-09-24 10:53:20.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ctype.h>
+#include <linux/sched.h>	/* current */

 MODULE_DESCRIPTION("CAPI4Linux: /dev/capi/ filesystem");
 MODULE_AUTHOR("Carsten Paeth");

--- linux-2.6.14-rc2-mm1/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/dvb-core/dvb_ca_en50221.c	2005-09-24 10:53:20.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/rwsem.h>
+#include <linux/sched.h>

 #include "dvb_ca_en50221.h"
 #include "dvb_ringbuffer.h"

--- linux-2.6.14-rc2-mm1/drivers/media/dvb/frontends/bcm3510.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/bcm3510.c	2005-09-24 10:53:20.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/moduleparam.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/jiffies.h>

 #include "dvb_frontend.h"
 #include "bcm3510.h"

--- linux-2.6.14-rc2-mm1/drivers/media/dvb/frontends/s5h1420.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/s5h1420.c	2005-09-24 10:53:20.000000000 +0200
@@ -26,6 +26,8 @@ Foundation, Inc., 675 Mass Ave, Cambridg
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <asm/div64.h>

 #include "dvb_frontend.h"
 #include "s5h1420.h"

--- linux-2.6.14-rc2-mm1/drivers/media/dvb/frontends/stv0297.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/stv0297.c	2005-09-24 10:53:20.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>

 #include "dvb_frontend.h"
 #include "stv0297.h"

--- linux-2.6.14-rc2-mm1/drivers/media/dvb/frontends/stv0299.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/stv0299.c	2005-09-24 10:53:20.000000000 +0200
@@ -48,6 +48,7 @@
 #include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <asm/div64.h>

 #include "dvb_frontend.h"

--- linux-2.6.14-rc2-mm1/drivers/media/dvb/frontends/tda1004x.c	2005-09-24 10:47:26.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/tda1004x.c	2005-09-24 10:53:20.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/device.h>
+#include <linux/jiffies.h>
 #include "dvb_frontend.h"
 #include "tda1004x.h"


--- linux-2.6.14-rc2-mm1/drivers/media/dvb/frontends/tda8083.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/dvb/frontends/tda8083.c	2005-09-24 10:53:20.000000000 +0200
@@ -30,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include "dvb_frontend.h"
 #include "tda8083.h"


--- linux-2.6.14-rc2-mm1/drivers/media/radio/miropcm20-rds.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/media/radio/miropcm20-rds.c	2005-09-24 10:53:20.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/sched.h>	/* current, TASK_*, schedule_timeout() */
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include "miropcm20-rds-core.h"

--- linux-2.6.14-rc2-mm1/drivers/mtd/mtdblock.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/mtdblock.c	2005-09-24 10:53:20.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/sched.h>	/* TASK_* */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/blktrans.h>


--- linux-2.6.14-rc2-mm1/drivers/mtd/mtdchar.c	2005-09-24 10:52:02.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/mtdchar.c	2005-09-24 10:53:20.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/sched.h>	/* TASK_* */
 #include <asm/uaccess.h>

 #include <linux/device.h>

--- linux-2.6.14-rc2-mm1/drivers/mtd/mtdconcat.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/mtd/mtdconcat.c	2005-09-24 10:53:20.000000000 +0200
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-
+#include <linux/sched.h>	/* TASK_* */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/concat.h>


--- linux-2.6.14-rc2-mm1/drivers/scsi/scsi_transport_fc.c	2005-09-24 10:47:29.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/scsi/scsi_transport_fc.c	2005-09-24 10:53:20.000000000 +0200
@@ -26,6 +26,7 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sched.h>	/* workqueue stuff, HZ */
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h>

--- linux-2.6.14-rc2-mm1/drivers/usb/host/ohci-pxa27x.c	2005-09-24 10:52:03.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/usb/host/ohci-pxa27x.c	2005-09-24 10:53:20.000000000 +0200
@@ -20,6 +20,7 @@
  */

 #include <linux/device.h>
+#include <linux/signal.h>
 #include <asm/mach-types.h>
 #include <asm/hardware.h>
 #include <asm/arch/pxa-regs.h>

--- linux-2.6.14-rc2-mm1/drivers/w1/w1_family.c	2005-09-24 10:47:30.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/drivers/w1/w1_family.c	2005-09-24 10:53:20.000000000 +0200
@@ -21,6 +21,7 @@

 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/sched.h>	/* schedule_timeout() */
 #include <linux/delay.h>

 #include "w1_family.h"

--- linux-2.6.14-rc2-mm1/fs/filesystems.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/fs/filesystems.c	2005-09-24 10:53:20.000000000 +0200
@@ -12,6 +12,7 @@
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/sched.h>	/* for 'current' */
 #include <asm/uaccess.h>

 /*

--- linux-2.6.14-rc2-mm1/fs/jffs2/background.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/fs/jffs2/background.c	2005-09-24 10:53:20.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/jffs2.h>
 #include <linux/mtd/mtd.h>
 #include <linux/completion.h>
+#include <linux/sched.h>
 #include "nodelist.h"



--- linux-2.6.14-rc2-mm1/fs/jffs2/wbuf.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/fs/jffs2/wbuf.c	2005-09-24 10:53:20.000000000 +0200
@@ -18,6 +18,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/crc32.h>
 #include <linux/mtd/nand.h>
+#include <linux/jiffies.h>
+
 #include "nodelist.h"

 /* For testing write failures */

--- linux-2.6.14-rc2-mm1/include/linux/cpufreq.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/include/linux/cpufreq.h	2005-09-24 10:53:20.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/completion.h>
 #include <linux/workqueue.h>
 #include <linux/cpumask.h>
+#include <asm/div64.h>

 #define CPUFREQ_NAME_LEN 16


--- linux-2.6.14-rc2-mm1/include/linux/gameport.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/include/linux/gameport.h	2005-09-24 10:53:20.000000000 +0200
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <linux/list.h>
 #include <linux/device.h>
+#include <linux/timer.h>

 struct gameport {


--- linux-2.6.14-rc2-mm1/include/linux/i2c.h	2005-09-24 10:47:34.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/include/linux/i2c.h	2005-09-24 10:53:20.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
+#include <linux/sched.h>	/* for completion */
 #include <asm/semaphore.h>

 /* --- For i2c-isa ---------------------------------------------------- */

--- linux-2.6.14-rc2-mm1/include/linux/kobj_map.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/include/linux/kobj_map.h	2005-09-24 10:53:20.000000000 +0200
@@ -1,5 +1,7 @@
 #ifdef __KERNEL__

+#include <asm/semaphore.h>
+
 typedef struct kobject *kobj_probe_t(dev_t, int *, void *);
 struct kobj_map;


--- linux-2.6.14-rc2-mm1/include/pcmcia/ss.h	2005-09-24 10:52:10.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/include/pcmcia/ss.h	2005-09-24 10:53:20.000000000 +0200
@@ -17,6 +17,7 @@

 #include <linux/config.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* task_struct, completion */

 #include <pcmcia/cs_types.h>
 #include <pcmcia/cs.h>

--- linux-2.6.14-rc2-mm1/include/scsi/scsi_cmnd.h	2005-09-24 10:47:34.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/include/scsi/scsi_cmnd.h	2005-09-24 10:53:20.000000000 +0200
@@ -4,6 +4,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/list.h>
 #include <linux/types.h>
+#include <linux/timer.h>

 struct request;
 struct scatterlist;

--- linux-2.6.14-rc2-mm1/include/scsi/scsi_transport_fc.h	2005-09-24 10:52:10.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/include/scsi/scsi_transport_fc.h	2005-09-24 10:53:20.000000000 +0200
@@ -28,6 +28,7 @@
 #define SCSI_TRANSPORT_FC_H

 #include <linux/config.h>
+#include <linux/sched.h>	/* work_struct */

 struct scsi_transport_template;


--- linux-2.6.14-rc2-mm1/kernel/kallsyms.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/kernel/kallsyms.c	2005-09-24 10:53:20.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/sched.h>	/* for cond_resched */
 #include <linux/mm.h>

 #include <asm/sections.h>

--- linux-2.6.14-rc2-mm1/lib/smp_processor_id.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/lib/smp_processor_id.c	2005-09-24 10:53:20.000000000 +0200
@@ -5,6 +5,7 @@
  */
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/sched.h>

 unsigned int debug_smp_processor_id(void)
 {

--- linux-2.6.14-rc2-mm1/sound/oss/ac97_codec.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc2-mm1-sr-dj6/sound/oss/ac97_codec.c	2005-09-24 10:53:20.000000000 +0200
@@ -55,6 +55,7 @@
 #include <linux/pci.h>
 #include <linux/ac97_codec.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>

 #define CODEC_ID_BUFSZ 14

