Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTAUTjY>; Tue, 21 Jan 2003 14:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbTAUTjY>; Tue, 21 Jan 2003 14:39:24 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:38797 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S267184AbTAUTjT>; Tue, 21 Jan 2003 14:39:19 -0500
Date: Tue, 21 Jan 2003 11:48:14 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH (take 2)][2.5] hangcheck-timer
Message-ID: <20030121194814.GD20972@ca-server1.us.oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com> <20030121081158.A21080@infradead.org> <20030121173303.GU20972@ca-server1.us.oracle.com> <20030121184403.GY20972@ca-server1.us.oracle.com> <20030121185921.A2322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121185921.A2322@infradead.org>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 06:59:21PM +0000, Christoph Hellwig wrote:
> > +}  /* hangcheck_init() */
> 
> These comments are a bit against the usual kernel coding style,
> espececially for that short function..

	Oh, but I love 'em!  Removed, per style.

Joel

diff -uNr linux-2.5.59/drivers/char/Kconfig linux-2.5.59-hangcheck/drivers/char/Kconfig
--- linux-2.5.59/drivers/char/Kconfig	Thu Jan 16 18:21:36 2003
+++ linux-2.5.59-hangcheck/drivers/char/Kconfig	Tue Jan 21 11:45:35 2003
@@ -992,5 +992,12 @@
 	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
 	  See the raw(8) manpage for more details.
 
+config HANGCHECK_TIMER
+	tristate "Hangcheck timer"
+	help
+	  The hangcheck-timer module detects when the system has gone
+	  out to lunch past a certain margin.  It can reboot the system
+	  or merely print a warning.
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
+++ linux-2.5.59-hangcheck/drivers/char/hangcheck-timer.c	Tue Jan 21 11:44:43 2003
@@ -0,0 +1,127 @@
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
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+
+
+#define VERSION_STR "0.5.0"
+
+#define DEFAULT_IOFENCE_MARGIN 60	/* Default fudge factor, in seconds */
+#define DEFAULT_IOFENCE_TICK 180	/* Default timer timeout, in seconds */
+
+static int hangcheck_tick = DEFAULT_IOFENCE_TICK;
+static int hangcheck_margin = DEFAULT_IOFENCE_MARGIN;
+static int hangcheck_reboot;  /* Defaults to not reboot */
+
+/* Driver options */
+module_param(hangcheck_tick, int, 0);
+MODULE_PARM_DESC(hangcheck_tick, "Timer delay.");
+module_param(hangcheck_margin, int, 0);
+MODULE_PARM_DESC(hangcheck_margin, "If the hangcheck timer has been delayed more than hangcheck_margin seconds, the driver will fire.");
+module_param(hangcheck_reboot, int, 0);
+MODULE_PARM_DESC(hangcheck_reboot, "If nonzero, the machine will reboot when the timer margin is exceeded.");
+
+MODULE_AUTHOR("Joel Becker");
+MODULE_DESCRIPTION("Hangcheck-timer detects when the system has gone out to lunch past a certain margin.");
+MODULE_LICENSE("GPL");
+
+
+/* Last time scheduled */
+static unsigned long long hangcheck_tsc, hangcheck_tsc_margin;
+
+static void hangcheck_fire(unsigned long);
+
+static struct timer_list hangcheck_ticktock = {
+	.function	= hangcheck_fire,
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
+}
+
+
+static int __init hangcheck_init(void)
+{
+	printk("Hangcheck: starting hangcheck timer %s (tick is %d seconds, margin is %d seconds).\n",
+	       VERSION_STR, hangcheck_tick, hangcheck_margin);
+
+	hangcheck_tsc_margin = (unsigned long long)(hangcheck_margin + hangcheck_tick) * (unsigned long long)HZ * (unsigned long long)current_cpu_data.loops_per_jiffy;
+
+	hangcheck_tsc = get_cycles();
+	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
+
+	return 0;
+}
+
+
+static void __exit hangcheck_exit(void)
+{
+	del_timer_sync(&hangcheck_ticktock);
+}
+
+module_init(hangcheck_init);
+module_exit(hangcheck_exit);

-- 

"When choosing between two evils, I always like to try the one
 I've never tried before."
        - Mae West

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
