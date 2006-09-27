Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030832AbWI0VI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030832AbWI0VI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030854AbWI0VI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:08:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030832AbWI0VI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:08:27 -0400
Date: Wed, 27 Sep 2006 14:08:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
 pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-Id: <20060927140808.2aece78e.akpm@osdl.org>
In-Reply-To: <20060927090902.GC24857@elf.ucw.cz>
References: <20060925071338.GD9869@suse.de>
	<1159220043.12814.30.camel@nigel.suspend2.net>
	<20060925144558.878c5374.akpm@osdl.org>
	<20060925224500.GB2540@elf.ucw.cz>
	<20060925160648.de96b6fa.akpm@osdl.org>
	<20060925232151.GA1896@elf.ucw.cz>
	<20060925172240.5c389c25.akpm@osdl.org>
	<20060926102434.GA2134@elf.ucw.cz>
	<20060926094607.815d126f.akpm@osdl.org>
	<20060927090902.GC24857@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 11:09:02 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > > Is "swapoff -a; echo disk > /sys/power/state" slow for you? If so, we
> > > have something reasonably easy to debug, if not, we'll try something
> > > else...
> > 
> > sony:/home/akpm# swapoff -a 
> > sony:/home/akpm# time (echo disk > /sys/power/state) 
> > echo: write error: no such device
> > (; echo disk > /sys/power/state; )  0.00s user 0.08s system 1% cpu 5.259 total
> > 
> > It took an additional two-odd seconds to bring the X UI back into a serviceable
> > state.
> 
> Console switches take long... yes it would be nice to fix X :-).
> 
> But we did not reproduce that 12 seconds problem. Can you try patches
> from
> 
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115506915023030&q=raw
> 

OK, that compiles.

I think we should get this documented and merge it (or something like it) into
mainline.  This is one area where it's worth investing in debugging tools.

If you agree, are we happy with it in its present form?



From: "Rafael J. Wysocki" <rjw@sisk.pl>

Add a swsusp debugging mode.  This does everything that's needed for a suspend
except for actually suspending.  So we can look in the log messages and work
out a) what code is being slow and b) which drivers are misbehaving.


(1)
# echo testproc > /sys/power/disk
# echo disk > /sys/power/state

This should turn off the non-boot CPU, freeze all processes, wait for 5
seconds and then thaw the processes and the CPU.

(2)
# echo test > /sys/power/disk
# echo disk > /sys/power/state

This should turn off the non-boot CPU, freeze all processes, shrink
memory, suspend all devices, wait for 5 seconds, resume the devices etc.

Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/pm.h  |    4 +++-
 kernel/power/disk.c |   37 ++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff -puN include/linux/pm.h~swsusp-debugging include/linux/pm.h
--- a/include/linux/pm.h~swsusp-debugging
+++ a/include/linux/pm.h
@@ -116,7 +116,9 @@ typedef int __bitwise suspend_disk_metho
 #define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
 #define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
 #define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
-#define	PM_DISK_MAX		((__force suspend_disk_method_t) 5)
+#define	PM_DISK_TEST		((__force suspend_disk_method_t) 5)
+#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 6)
+#define	PM_DISK_MAX		((__force suspend_disk_method_t) 7)
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
diff -puN kernel/power/disk.c~swsusp-debugging kernel/power/disk.c
--- a/kernel/power/disk.c~swsusp-debugging
+++ a/kernel/power/disk.c
@@ -72,7 +72,7 @@ static inline void platform_finish(void)
 
 static int prepare_processes(void)
 {
-	int error;
+	int error = 0;
 
 	pm_prepare_console();
 
@@ -85,6 +85,12 @@ static int prepare_processes(void)
 		goto thaw;
 	}
 
+	if (pm_disk_mode == PM_DISK_TESTPROC) {
+		printk("swsusp debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		goto thaw;
+	}
+
 	/* Free memory before shutting down devices. */
 	if (!(error = swsusp_shrink_memory()))
 		return 0;
@@ -121,13 +127,21 @@ int pm_suspend_disk(void)
 	if (error)
 		return error;
 
+	if (pm_disk_mode == PM_DISK_TESTPROC)
+		goto Thaw;
+
 	suspend_console();
 	error = device_suspend(PMSG_FREEZE);
 	if (error) {
 		resume_console();
 		printk("Some devices failed to suspend\n");
-		unprepare_processes();
-		return error;
+		goto Thaw;
+	}
+
+	if (pm_disk_mode == PM_DISK_TEST) {
+		printk("swsusp debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		goto Done;
 	}
 
 	pr_debug("PM: snapshotting memory.\n");
@@ -144,16 +158,17 @@ int pm_suspend_disk(void)
 			power_down(pm_disk_mode);
 		else {
 			swsusp_free();
-			unprepare_processes();
-			return error;
+			goto Thaw;
 		}
-	} else
+	} else {
 		pr_debug("PM: Image restored successfully.\n");
+	}
 
 	swsusp_free();
  Done:
 	device_resume();
 	resume_console();
+ Thaw:
 	unprepare_processes();
 	return error;
 }
@@ -250,6 +265,8 @@ static const char * const pm_disk_modes[
 	[PM_DISK_PLATFORM]	= "platform",
 	[PM_DISK_SHUTDOWN]	= "shutdown",
 	[PM_DISK_REBOOT]	= "reboot",
+	[PM_DISK_TEST]		= "test",
+	[PM_DISK_TESTPROC]	= "testproc",
 };
 
 /**
@@ -304,17 +321,19 @@ static ssize_t disk_store(struct subsyst
 		}
 	}
 	if (mode) {
-		if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT)
+		if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT ||
+		     mode == PM_DISK_TEST || mode == PM_DISK_TESTPROC) {
 			pm_disk_mode = mode;
-		else {
+		} else {
 			if (pm_ops && pm_ops->enter &&
 			    (mode == pm_ops->pm_disk_mode))
 				pm_disk_mode = mode;
 			else
 				error = -EINVAL;
 		}
-	} else
+	} else {
 		error = -EINVAL;
+	}
 
 	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
 		 pm_disk_modes[mode]);
_

