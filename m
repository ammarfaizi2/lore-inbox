Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTJWXkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTJWXkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:40:49 -0400
Received: from gprs147-238.eurotel.cz ([160.218.147.238]:13440 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261893AbTJWXkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:40:42 -0400
Date: Fri, 24 Oct 2003 01:40:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: john stultz <johnstul@us.ibm.com>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031023234019.GB714@elf.ucw.cz>
References: <20031022233306.GA6461@elf.ucw.cz> <1066866741.1114.71.camel@cog.beaverton.ibm.com> <20031023081750.GB854@openzaurus.ucw.cz> <3F9838B4.5010401@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9838B4.5010401@mvista.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Forgive me, I'm not totally familiar w/ the sysfs/pm stuff, but normally
> >>you need to have the xtime_lock to safely manipulate xtime. Also,
> >>couldn't you just call settimeofday() instead?  The bit about manually
> >>setting the timezone also confuses me, as we don't normally do this at
> >>bootup in the kernel.  
> >>
> >
> >
> >I took it straight from apm.c... But it is well possible that it needs
> >some locking. OTOH this runs with interrupts disabled, perhaps
> >thats enough?
> 
> I lost (never saw) the first of this thread, BUT, if this is 2.6, I 
> strongly recommend that settimeofday() NOT be called.  It will try to 
> adjust wall_to_motonoic, but, as this appears to be a correction for time 
> lost while sleeping, wall_to_monotonic should not change.
> 
> As to locking, ints off for UP, but you need the full lock for SMP systems.

Okay, suspend is currently not supported on SMP, but we should play it
safe. What about this one? [Compile tested only, have to get some sleep.]

								Pavel

--- clean/arch/i386/kernel/time.c	2003-10-09 00:13:14.000000000 +0200
+++ linux/arch/i386/kernel/time.c	2003-10-24 01:38:04.000000000 +0200
@@ -271,16 +271,37 @@
 	unsigned long retval;
 
 	spin_lock(&rtc_lock);
-
 	retval = mach_get_cmos_time();
-
 	spin_unlock(&rtc_lock);
 
 	return retval;
 }
 
+static long clock_cmos_diff;
+
+static int pit_suspend(struct sys_device *dev, u32 state)
+{
+	/*
+	 * Estimate time zone so that set_time can update the clock
+	 */
+	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff += get_seconds();
+	return 0;
+}
+
+static int pit_resume(struct sys_device *dev)
+{
+	write_seqlock_irq(&xtime_lock);
+	xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
+	xtime.tv_nsec = 0; 
+	write_sequnlock_irq(&xtime_lock);
+	return 0;
+}
+
 static struct sysdev_class pit_sysclass = {
 	set_kset_name("pit"),
+	.resume = pit_resume,
+	.suspend = pit_suspend,
 };
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
