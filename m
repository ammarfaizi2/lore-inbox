Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTAUBLH>; Mon, 20 Jan 2003 20:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTAUBLH>; Mon, 20 Jan 2003 20:11:07 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:11654 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267254AbTAUBLA>; Mon, 20 Jan 2003 20:11:00 -0500
Date: Mon, 20 Jan 2003 17:19:54 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121011954.GO20972@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,
	Attached is a patch adding hangcheck-timer.  It is used to detect
when the system goes out to lunch for a period of time, and then
returns.  This is interesting for debugging drivers as well as for
clustering environments.
	The module sets a timer.  When the timer goes off, it then uses
get_cycles() to determine how much real time has passed.
	On a normal system, the real elapsed time will be almost
identical to the expected timer duration.  However, if a device decided
to udelay for 60 seconds (or some other circumstance), the module takes
notice.  If the margin of error passes a threshold, the driver prints a
warning or the machine is rebooted.
	There are three parameters.

	hangcheck_tick		-	Timer duration
	hangcheck_margin	-	Allowed margin of between elapsed
					jiffies and elapsed wall clock
	hangcheck_reboot	-	If nonzero, reboot if margin
					exceeded.

	When compiled statically, s/hangcheck/hcheck/ for the kernel
command line.
	Linus, please apply.

Joel

diff -uNr linux-2.5.59/drivers/char/Kconfig linux-2.5.59-hangcheck/drivers/char/Kconfig
--- linux-2.5.59/drivers/char/Kconfig	Thu Jan 16 18:21:36 2003
+++ linux-2.5.59-hangcheck/drivers/char/Kconfig	Mon Jan 20 13:35:27 2003
@@ -992,5 +992,8 @@
 	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
 	  See the raw(8) manpage for more details.
 
+config HANGCHECK_TIMER
+	tristate "Hangcheck timer"
+
 endmenu
 
diff -uNr linux-2.5.59/drivers/char/Makefile linux-2.5.59-hangcheck/drivers/char/Makefile
--- linux-2.5.59/drivers/char/Makefile	Thu Jan 16 18:22:44 2003
+++ linux-2.5.59-hangcheck/drivers/char/Makefile	Mon Jan 20 13:35:02 2003
@@ -84,6 +84,7 @@
 obj-$(CONFIG_PCMCIA) += pcmcia/
 obj-$(CONFIG_IPMI_HANDLER) += ipmi/
 
+obj-$(CONFIG_HANGCHECK_TIMER) += hangcheck-timer.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c qtronixmap.c
diff -uNr linux-2.5.59/drivers/char/hangcheck-timer.c linux-2.5.59-hangcheck/drivers/char/hangcheck-timer.c
--- linux-2.5.59/drivers/char/hangcheck-timer.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.59-hangcheck/drivers/char/hangcheck-timer.c	Mon Jan 20 13:33:42 2003
@@ -0,0 +1,173 @@
+/*
+ * hangcheck-timer.c
+ *
+ * Driver for a little io fencing timer.
+ *
+ * Copyright (C) 2002 Oracle Corporation.  All rights reserved.
+ *
+ * Author: Joel Becker <joel.becker@oracle.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License version 2 as published by the Free Software Foundation.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ * 
+ * You should have recieved a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+/*
+ * The hangcheck-timer driver uses the TSC to catch delays that
+ * jiffies does not notice.  A timer is set.  When the timer fires, it
+ * checks whether it was delayed and if that delay exceeds a given
+ * margin of error.  The hangcheck_tick module paramter takes the timer
+ * duration in seconds.  The hangcheck_margin parameter defines the
+ * margin of error, in seconds.  The defaults are 60 seconds for the
+ * timer and 180 seconds for the margin of error.  IOW, a timer is set
+ * for 60 seconds.  When the timer fires, the callback checks the
+ * actual duration that the timer waited.  If the duration exceeds the
+ * alloted time and margin (here 60 + 180, or 240 seconds), the machine
+ * is restarted.  A healthy machine will have the duration match the
+ * expected timeout very closely.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/reboot.h>
+#include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+
+#define VERSION_STR "0.5.0"
+
+static void version_hash_print (void)
+{
+	printk(KERN_INFO "I/O fencing modules %s\n", VERSION_STR);
+}
+
+#define DEFAULT_IOFENCE_MARGIN 60	/* Default fudge factor, in seconds */
+#define DEFAULT_IOFENCE_TICK 180	/* Default timer timeout, in seconds */
+
+static int hangcheck_tick = DEFAULT_IOFENCE_TICK;
+static int hangcheck_margin = DEFAULT_IOFENCE_MARGIN;
+static int hangcheck_reboot = 0;  /* Do not reboot */
+
+/* options - modular */
+MODULE_PARM(hangcheck_tick,"i");
+MODULE_PARM_DESC(hangcheck_tick, "Timer delay.");
+MODULE_PARM(hangcheck_margin,"i");
+MODULE_PARM_DESC(hangcheck_margin, "If the hangcheck timer has been delayed more than hangcheck_margin seconds, the driver will fire.");
+MODULE_PARM(hangcheck_reboot,"i");
+MODULE_PARM_DESC(hangcheck_reboot, "If nonzero, the machine will reboot when the timer margin is exceeded.");
+MODULE_LICENSE("GPL");
+
+/* options - nonmodular */
+#ifndef MODULE
+
+static int __init hangcheck_parse_tick(char *str) {
+	int par;
+	if (get_option(&str,&par))
+		hangcheck_tick = par;
+	return 1;
+}
+
+static int __init hangcheck_parse_margin(char *str) {
+	int par;
+	if (get_option(&str,&par))
+		hangcheck_margin = par;
+	return 1;
+}
+
+static int __init hangcheck_parse_reboot(char *str) {
+	int par;
+	if (get_option(&str,&par))
+		hangcheck_reboot = par;
+	return 1;
+}
+
+__setup("hcheck_tick", hangcheck_parse_tick);
+__setup("hcheck_margin", hangcheck_parse_margin);
+__setup("hcheck_reboot", hangcheck_parse_reboot);
+#endif /* not MODULE */
+
+
+/* Last time scheduled */
+static unsigned long long hangcheck_tsc, hangcheck_tsc_margin;
+
+static void hangcheck_fire(unsigned long);
+
+static struct timer_list hangcheck_ticktock = {
+	function:	hangcheck_fire,
+};
+
+
+static void hangcheck_fire(unsigned long data)
+{
+	unsigned long long cur_tsc, tsc_diff;
+
+	cur_tsc = get_cycles();
+
+	if (cur_tsc > hangcheck_tsc)
+		tsc_diff = cur_tsc - hangcheck_tsc;
+	else
+		tsc_diff = (cur_tsc + (~0ULL - hangcheck_tsc)); /* or something */
+
+#if 0
+	printk(KERN_CRIT "tsc_diff = %lu.%lu, predicted diff is %lu.%lu.\n",
+	       (unsigned long) ((tsc_diff >> 32) & 0xFFFFFFFFULL),
+	       (unsigned long) (tsc_diff & 0xFFFFFFFFULL),
+	       (unsigned long) ((hangcheck_tsc_margin >> 32) & 0xFFFFFFFFULL),
+	       (unsigned long) (hangcheck_tsc_margin & 0xFFFFFFFFULL));
+	printk(KERN_CRIT "hangcheck_margin = %lu, HZ = %lu, current_cpu_data.loops_per_jiffy = %lu.\n", hangcheck_margin, HZ, current_cpu_data.loops_per_jiffy);
+#endif
+	
+	if (tsc_diff > hangcheck_tsc_margin) {
+		if (hangcheck_reboot) {
+			printk(KERN_CRIT "Hangcheck: hangcheck is restarting the machine.\n");
+			machine_restart(NULL);
+		} else {
+			printk(KERN_CRIT "Hangcheck: hangcheck value past margin!\n");
+		}
+	}
+	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
+	hangcheck_tsc = get_cycles();
+}  /* hangcheck_fire() */
+
+
+static int __init hangcheck_init(void)
+{
+        version_hash_print();
+	printk("Hangcheck: starting hangcheck timer (tick is %d seconds, margin is %d seconds).\n",
+	       hangcheck_tick, hangcheck_margin);
+
+	hangcheck_tsc_margin = (unsigned long long)(hangcheck_margin + hangcheck_tick) * (unsigned long long)HZ * (unsigned long long)current_cpu_data.loops_per_jiffy;
+
+	hangcheck_tsc = get_cycles();
+	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
+
+	return 0;
+}  /* hangcheck_init() */
+
+
+static void __exit hangcheck_exit(void)
+{
+	printk("Stopping hangcheck timer.\n");
+
+	lock_kernel();
+	del_timer(&hangcheck_ticktock);
+	unlock_kernel();
+}  /* hangcheck_exit() */
+
+module_init(hangcheck_init);
+module_exit(hangcheck_exit);

-- 

"Friends may come and go, but enemies accumulate." 
        - Thomas Jones

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
