Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUHSOnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUHSOnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266324AbUHSOnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:43:42 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:16327 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266271AbUHSOl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:41:28 -0400
Date: Thu, 19 Aug 2004 15:39:07 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: includes cleanup.
Message-ID: <20040819143907.GA4236@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that every file that could be built as a module was sucking
in sched.h (and therefore, every other include file under the sun).

This patch
- removes the sched.h from module.h
- Moves the capable() definition from sched.h to capability.h
- split out the wake_up_* stuff to linux/wakeup.h
- Removed sched.h includes from a bunch of drivers that didn't
  need it due to the above work.
- Fixes up all the breakage I was able to find under x86.
  Fixing other arch's is simple enough, they just need to include
  sched.h explicity in a few places now (or jiffies.h, or capability.h or wakeup.h))

I've not done any measurements to see if this is noticable on a compile,
as I'd expect it to be mostly in the noise anyway (though last time I
did this in 2.5.early, it did shave off the best part of a minute off
my worst-case-scenario build), but untangling the spaghetti of includes
a little should at least mean gcc uses less memory during the build.

comments?
		
		Dave


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/14 22:17:56+01:00 davej@redhat.com 
#   [INCLUDE] Remove sched.h inclusion from module.h.
#   Also move some capability bits to capability.h, and break
#   out some of sched.h to wakeup.h
#   
#   Build checked for make all modconfig,yesconfig,noconfig
#   
#   Signed-off-by: Dave Jones <davej@redhat.com>
# 
diff -Nru a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-08-14 22:18:22 +01:00
+++ b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-08-14 22:18:22 +01:00
@@ -28,6 +28,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/cpumask.h>
+#include <linux/sched.h>	/* current / set_cpus_allowed() */
 
 #include <asm/processor.h> 
 #include <asm/msr.h>
diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-08-14 22:18:22 +01:00
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2004-08-14 22:18:22 +01:00
@@ -27,6 +27,7 @@
 #include <linux/cpufreq.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/sched.h>	/* for current / set_cpus_allowed() */
 
 #include <asm/msr.h>
 #include <asm/io.h>
diff -Nru a/arch/i386/kernel/cpu/mtrr/if.c b/arch/i386/kernel/cpu/mtrr/if.c
--- a/arch/i386/kernel/cpu/mtrr/if.c	2004-08-14 22:18:22 +01:00
+++ b/arch/i386/kernel/cpu/mtrr/if.c	2004-08-14 22:18:22 +01:00
@@ -3,6 +3,7 @@
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/capability.h>
 #include <asm/uaccess.h>
 
 #define LINE_SIZE 80
diff -Nru a/drivers/block/paride/paride.c b/drivers/block/paride/paride.c
--- a/drivers/block/paride/paride.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/block/paride/paride.c	2004-08-14 22:18:22 +01:00
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/sched.h>	/* TASK_* */
 
 #ifdef CONFIG_PARPORT_MODULE
 #define CONFIG_PARPORT
diff -Nru a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/block/paride/pg.c	2004-08-14 22:18:22 +01:00
@@ -162,6 +162,8 @@
 #include <linux/mtio.h>
 #include <linux/pg.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* current, TASK_* */
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 
diff -Nru a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/block/paride/pt.c	2004-08-14 22:18:22 +01:00
@@ -146,6 +146,7 @@
 #include <linux/slab.h>
 #include <linux/mtio.h>
 #include <linux/device.h>
+#include <linux/sched.h>	/* current, TASK_*, schedule_timeout() */
 
 #include <asm/uaccess.h>
 
diff -Nru a/drivers/char/i8k.c b/drivers/char/i8k.c
--- a/drivers/char/i8k.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/char/i8k.c	2004-08-14 22:18:22 +01:00
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/apm_bios.h>
+#include <linux/capability.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -Nru a/drivers/char/watchdog/cpu5wdt.c b/drivers/char/watchdog/cpu5wdt.c
--- a/drivers/char/watchdog/cpu5wdt.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/char/watchdog/cpu5wdt.c	2004-08-14 22:18:22 +01:00
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/timer.h>
+#include <linux/jiffies.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
diff -Nru a/drivers/char/watchdog/mixcomwd.c b/drivers/char/watchdog/mixcomwd.c
--- a/drivers/char/watchdog/mixcomwd.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/char/watchdog/mixcomwd.c	2004-08-14 22:18:22 +01:00
@@ -45,6 +45,8 @@
 #include <linux/fs.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/timer.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -Nru a/drivers/char/watchdog/pcwd.c b/drivers/char/watchdog/pcwd.c
--- a/drivers/char/watchdog/pcwd.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/char/watchdog/pcwd.c	2004-08-14 22:18:22 +01:00
@@ -66,7 +66,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/reboot.h>
-
+#include <linux/sched.h>	/* TASK_INTERRUPTIBLE, set_current_state() and friends */
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
diff -Nru a/drivers/char/watchdog/sc520_wdt.c b/drivers/char/watchdog/sc520_wdt.c
--- a/drivers/char/watchdog/sc520_wdt.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/char/watchdog/sc520_wdt.c	2004-08-14 22:18:22 +01:00
@@ -63,6 +63,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/char/watchdog/softdog.c	2004-08-14 22:18:22 +01:00
@@ -47,6 +47,8 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
+
 #include <asm/uaccess.h>
 
 #define PFX "SoftDog: "
diff -Nru a/drivers/input/joystick/a3d.c b/drivers/input/joystick/a3d.c
--- a/drivers/input/joystick/a3d.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/a3d.c	2004-08-14 22:18:22 +01:00
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("FP-Gaming Assasin 3D joystick driver");
diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/adi.c	2004-08-14 22:18:22 +01:00
@@ -36,6 +36,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Logitech ADI joystick family driver");
diff -Nru a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
--- a/drivers/input/joystick/analog.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/analog.c	2004-08-14 22:18:22 +01:00
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 #include <asm/timex.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
diff -Nru a/drivers/input/joystick/cobra.c b/drivers/input/joystick/cobra.c
--- a/drivers/input/joystick/cobra.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/cobra.c	2004-08-14 22:18:22 +01:00
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Creative Labs Blaster GamePad Cobra driver");
diff -Nru a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
--- a/drivers/input/joystick/gf2k.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/gf2k.c	2004-08-14 22:18:22 +01:00
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Genius Flight 2000 joystick driver");
diff -Nru a/drivers/input/joystick/grip.c b/drivers/input/joystick/grip.c
--- a/drivers/input/joystick/grip.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/grip.c	2004-08-14 22:18:22 +01:00
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Gravis GrIP protocol joystick driver");
diff -Nru a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
--- a/drivers/input/joystick/grip_mp.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/grip_mp.c	2004-08-14 22:18:22 +01:00
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Brian Bonnlander");
 MODULE_DESCRIPTION("Gravis Grip Multiport driver");
diff -Nru a/drivers/input/joystick/guillemot.c b/drivers/input/joystick/guillemot.c
--- a/drivers/input/joystick/guillemot.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/guillemot.c	2004-08-14 22:18:22 +01:00
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Guillemot Digital joystick driver");
diff -Nru a/drivers/input/joystick/interact.c b/drivers/input/joystick/interact.c
--- a/drivers/input/joystick/interact.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/interact.c	2004-08-14 22:18:22 +01:00
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("InterAct digital joystick driver");
diff -Nru a/drivers/input/joystick/sidewinder.c b/drivers/input/joystick/sidewinder.c
--- a/drivers/input/joystick/sidewinder.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/sidewinder.c	2004-08-14 22:18:22 +01:00
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/gameport.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Microsoft SideWinder joystick family driver");
diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/input/joystick/tmdc.c	2004-08-14 22:18:22 +01:00
@@ -38,6 +38,7 @@
 #include <linux/init.h>
 #include <linux/gameport.h>
 #include <linux/input.h>
+#include <linux/jiffies.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("ThrustMaster DirectConnect joystick driver");
diff -Nru a/drivers/isdn/capi/capifs.c b/drivers/isdn/capi/capifs.c
--- a/drivers/isdn/capi/capifs.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/isdn/capi/capifs.c	2004-08-14 22:18:22 +01:00
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ctype.h>
+#include <linux/sched.h>	/* current */
 
 MODULE_DESCRIPTION("CAPI4Linux: /dev/capi/ filesystem");
 MODULE_AUTHOR("Carsten Paeth");
diff -Nru a/drivers/media/radio/miropcm20-rds.c b/drivers/media/radio/miropcm20-rds.c
--- a/drivers/media/radio/miropcm20-rds.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/media/radio/miropcm20-rds.c	2004-08-14 22:18:22 +01:00
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/sched.h>	/* current, TASK_*, schedule_timeout() */
 #include <asm/uaccess.h>
 #include "miropcm20-rds-core.h"
 
diff -Nru a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/mtd/mtdblock.c	2004-08-14 22:18:22 +01:00
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/sched.h>	/* TASK_* */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/blktrans.h>
 
diff -Nru a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/mtd/mtdchar.c	2004-08-14 22:18:22 +01:00
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/sched.h>	/* TASK_* */
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_DEVFS_FS
diff -Nru a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
--- a/drivers/mtd/mtdconcat.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/mtd/mtdconcat.c	2004-08-14 22:18:22 +01:00
@@ -14,7 +14,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-
+#include <linux/sched.h>	/* TASK_* */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/concat.h>
 
diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c	2004-08-14 22:18:22 +01:00
+++ b/drivers/w1/w1_family.c	2004-08-14 22:18:22 +01:00
@@ -21,6 +21,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/sched.h>	/* schedule_timeout() */
 
 #include "w1_family.h"
 
diff -Nru a/fs/filesystems.c b/fs/filesystems.c
--- a/fs/filesystems.c	2004-08-14 22:18:22 +01:00
+++ b/fs/filesystems.c	2004-08-14 22:18:22 +01:00
@@ -11,6 +11,7 @@
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/sched.h>	/* for 'current' */
 #include <asm/uaccess.h>
 
 /*
diff -Nru a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
--- a/fs/jffs2/wbuf.c	2004-08-14 22:18:22 +01:00
+++ b/fs/jffs2/wbuf.c	2004-08-14 22:18:22 +01:00
@@ -18,6 +18,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/crc32.h>
 #include <linux/mtd/nand.h>
+#include <linux/jiffies.h>
+
 #include "nodelist.h"
 
 /* For testing write failures */
diff -Nru a/include/linux/capability.h b/include/linux/capability.h
--- a/include/linux/capability.h	2004-08-14 22:18:22 +01:00
+++ b/include/linux/capability.h	2004-08-14 22:18:22 +01:00
@@ -353,6 +353,21 @@
 
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
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2004-08-14 22:18:22 +01:00
+++ b/include/linux/i2c.h	2004-08-14 22:18:22 +01:00
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 #include <linux/i2c-id.h>
 #include <linux/device.h>	/* for struct device */
+#include <linux/sched.h>	/* for completion */
 #include <asm/semaphore.h>
 
 /* --- General options ------------------------------------------------	*/
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	2004-08-14 22:18:22 +01:00
+++ b/include/linux/module.h	2004-08-14 22:18:22 +01:00
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
+#include <linux/wakeup.h>
 
+#include <asm/local.h>
 #include <asm/module.h>
 
 /* Not Yet Implemented */
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2004-08-14 22:18:22 +01:00
+++ b/include/linux/sched.h	2004-08-14 22:18:22 +01:00
@@ -747,19 +747,8 @@
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
 
-extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
-extern int FASTCALL(wake_up_process(struct task_struct * tsk));
-extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
-#ifdef CONFIG_SMP
- extern void kick_process(struct task_struct *tsk);
- extern void FASTCALL(wake_up_forked_thread(struct task_struct * tsk));
-#else
- static inline void kick_process(struct task_struct *tsk) { }
- static inline void wake_up_forked_thread(struct task_struct * tsk)
- {
-	wake_up_forked_process(tsk);
- }
-#endif
+#include <linux/wakeup.h>
+
 extern void FASTCALL(sched_fork(task_t * p));
 extern void FASTCALL(sched_exit(task_t * p));
 
@@ -827,21 +816,6 @@
 	return (current->sas_ss_size == 0 ? SS_DISABLE
 		: on_sig_stack(sp) ? SS_ONSTACK : 0);
 }
-
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
diff -Nru a/include/linux/wakeup.h b/include/linux/wakeup.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/wakeup.h	2004-08-14 22:18:22 +01:00
@@ -0,0 +1,17 @@
+#ifndef _LINUX_WAKEUP_H
+#define _LINUX_WAKEUP_H
+
+extern int FASTCALL(wake_up_state(struct task_struct * tsk, unsigned int state));
+extern int FASTCALL(wake_up_process(struct task_struct * tsk));
+extern void FASTCALL(wake_up_forked_process(struct task_struct * tsk));
+#ifdef CONFIG_SMP
+ extern void kick_process(struct task_struct *tsk);
+ extern void FASTCALL(wake_up_forked_thread(struct task_struct * tsk));
+#else
+ static inline void kick_process(struct task_struct *tsk) { }
+ static inline void wake_up_forked_thread(struct task_struct * tsk)
+ {
+	wake_up_forked_process(tsk);
+ }
+#endif
+#endif
diff -Nru a/kernel/kallsyms.c b/kernel/kallsyms.c
--- a/kernel/kallsyms.c	2004-08-14 22:18:22 +01:00
+++ b/kernel/kallsyms.c	2004-08-14 22:18:22 +01:00
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/proc_fs.h>
+#include <linux/sched.h>	/* for cond_resched */
 
 /* These will be re-linked against their real values during the second link stage */
 extern unsigned long kallsyms_addresses[] __attribute__((weak));
diff -Nru a/sound/oss/ac97_codec.c b/sound/oss/ac97_codec.c
--- a/sound/oss/ac97_codec.c	2004-08-14 22:18:22 +01:00
+++ b/sound/oss/ac97_codec.c	2004-08-14 22:18:22 +01:00
@@ -54,6 +54,7 @@
 #include <linux/delay.h>
 #include <linux/ac97_codec.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
 #define CODEC_ID_BUFSZ 14
 
