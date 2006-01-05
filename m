Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751961AbWAEGK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbWAEGK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbWAEGK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:10:26 -0500
Received: from xenotime.net ([66.160.160.81]:15327 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751961AbWAEGKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:10:25 -0500
Date: Wed, 4 Jan 2006 22:10:23 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Message-Id: <20060104221023.10249eb3.rdunlap@xenotime.net>
In-Reply-To: <20060105045212.GA15789@redhat.com>
References: <20060105045212.GA15789@redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 23:52:12 -0500 Dave Jones wrote:

> In my quest to get better debug data from users in Fedora bug reports,
> I came up with this patch.  A majority of users don't have serial
> consoles, so when an oops scrolls off the top of the screen,
> and locks up, they usually end up reporting a 2nd (or later) oops
> that isn't particularly helpful (or worse, some inconsequential
> info like 'sleeping whilst atomic' warnings)
> 
> With this patch, if we oops, there's a pause for a two minutes..
> which hopefully gives people enough time to grab a digital camera
> to take a screenshot of the oops.
> 
> It has an on-screen timer so the user knows what's going on,
> (and that it's going to come back to life [maybe] after the oops).
> 
> The one case this doesn't catch is the problem of oopses whilst
> in X. Previously a non-fatal oops would stall X momentarily,
> and then things continue. Now those cases will lock up completely
> for two minutes. Future patches could add some additional feedback
> during this 'stall' such as the blinky keyboard leds, or periodic speaker beeps.

That's nice.  Here's another patch^w hack.

This one delays each printk() during boot by a variable time
(from kernel command line), while system_state == SYSTEM_BOOTING.
Caveat:  it's not terribly SMP safe or SMP nice.
Any ideas for improvements (esp. in the SMP area) are appreciated.

---

From: Randy Dunlap <rdunlap@xenotime.net>

Optionally add a boot delay after each kernel printk() call,
crudely measured in milliseconds, with a maximum delay of
10 seconds per printk.

Enable CONFIG_BOOT_DELAY=y and then add (e.g.):
"lpj=loops_per_jiffy boot_delay=100"
to the kernel command line.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 init/calibrate.c  |    2 +-
 init/main.c       |   25 +++++++++++++++++++++++++
 kernel/printk.c   |   33 +++++++++++++++++++++++++++++++++
 lib/Kconfig.debug |   18 ++++++++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)

--- linux-2615-work.orig/init/main.c
+++ linux-2615-work/init/main.c
@@ -557,6 +557,31 @@ static int __init initcall_debug_setup(c
 }
 __setup("initcall_debug", initcall_debug_setup);
 
+#ifdef CONFIG_BOOT_DELAY
+
+unsigned int boot_delay = 0; /* msecs delay after each printk during bootup */
+extern long preset_lpj;
+unsigned long long printk_delay_msec = 0; /* per msec, based on boot_delay */
+
+static int __init boot_delay_setup(char *str)
+{
+	unsigned long lpj = preset_lpj ? preset_lpj : 1000000; /* some guess */
+	unsigned long long loops_per_msec = lpj / 1000 * CONFIG_HZ;
+
+	get_option(&str, &boot_delay);
+	if (boot_delay > 10 * 1000)
+		boot_delay = 0;
+
+	printk_delay_msec = loops_per_msec;
+	printk("boot_delay: %u, preset_lpj: %ld, lpj: %lu, CONFIG_HZ: %d, printk_delay_msec: %llu\n",
+		boot_delay, preset_lpj, lpj, CONFIG_HZ, printk_delay_msec);
+
+	return 1;
+}
+__setup("boot_delay=", boot_delay_setup);
+
+#endif
+
 struct task_struct *child_reaper = &init_task;
 
 extern initcall_t __initcall_start[], __initcall_end[];
--- linux-2615-work.orig/init/calibrate.c
+++ linux-2615-work/init/calibrate.c
@@ -10,7 +10,7 @@
 
 #include <asm/timex.h>
 
-static unsigned long preset_lpj;
+unsigned long preset_lpj;
 static int __init lpj_setup(char *str)
 {
 	preset_lpj = simple_strtoul(str,NULL,0);
--- linux-2615-work.orig/kernel/printk.c
+++ linux-2615-work/kernel/printk.c
@@ -23,6 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/console.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>			/* For in_interrupt() */
 #include <linux/config.h>
@@ -201,6 +202,33 @@ out:
 
 __setup("log_buf_len=", log_buf_len_setup);
 
+#ifdef CONFIG_BOOT_DELAY
+
+extern unsigned int boot_delay; /* msecs to delay after each printk during bootup */
+extern long preset_lpj;
+extern unsigned long long printk_delay_msec;
+
+static void boot_delay_msec(int millisecs)
+{
+	unsigned long long k = printk_delay_msec * millisecs;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(millisecs);
+	while (k) {
+		k--;
+		rep_nop();
+		/*
+		 * use (volatile) jiffies to prevent
+		 * compiler reduction; loop termination via jiffies
+		 * is secondary and may or may not happen.
+		 */
+		if (time_after(jiffies, timeout))
+			break;
+	}
+}
+
+#endif
+
 /*
  * Commands to do_syslog:
  *
@@ -520,6 +548,11 @@ asmlinkage int printk(const char *fmt, .
 	r = vprintk(fmt, args);
 	va_end(args);
 
+#ifdef CONFIG_BOOT_DELAY
+	if (boot_delay && system_state == SYSTEM_BOOTING)
+		boot_delay_msec(boot_delay);
+#endif
+
 	return r;
 }
 
--- linux-2615-work.orig/lib/Kconfig.debug
+++ linux-2615-work/lib/Kconfig.debug
@@ -186,6 +186,24 @@ config FRAME_POINTER
 	  some architectures or if you use external debuggers.
 	  If you don't debug the kernel, you can say N.
 
+config BOOT_DELAY
+	bool "Delay each boot message by N milliseconds"
+	depends on DEBUG_KERNEL
+	help
+	  This build option allows you to read kernel boot messages
+	  by inserting a short delay after each one.  The delay is
+	  specified in milliseconds on the kernel command line,
+	  using "boot_delay=N".
+
+	  It is likely that you would also need to use "lpj=M" to preset
+	  the "loops per jiffie" value.
+	  See a previous boot log for the "lpj" value to use for your
+	  system, and then set "lpj=M" before setting "boot_delay=N".
+	  NOTE:  Using this option may adversely affect SMP systems.
+	  I.e., processors other than the first one may not boot up.
+	  BOOT_DELAY also may cause DETECT_SOFTLOCKUP to detect
+	  what it believes to be lockup conditions.
+
 config RCU_TORTURE_TEST
 	tristate "torture tests for RCU"
 	depends on DEBUG_KERNEL

