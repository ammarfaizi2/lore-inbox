Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbUJ1WrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbUJ1WrC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 18:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUJ1Wk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 18:40:26 -0400
Received: from gprs214-13.eurotel.cz ([160.218.214.13]:21377 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263100AbUJ1WjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 18:39:05 -0400
Date: Fri, 29 Oct 2004 00:38:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: ncunningham@linuxmail.org, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: time and suspending sysdevs [was Re: Fixing MTRR smp breakage and suspending sysdevs.]
Message-ID: <20041028223838.GA2319@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com> <20041027100046.GB26265@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027100046.GB26265@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >One thing I have noticed is that by adding the sysdev suspend/resume
> > >calls, I've gained a few seconds delay. I'll see if I can track down
> > the
> > >cause.

Sysdev suspend/resume calls should be added to swsusp1, too. Can
someone verify that this fixes stuff? I should get some sleep...

								Pavel

--- clean/kernel/power/disk.c	2004-10-01 00:30:32.000000000 +0200
+++ linux/kernel/power/disk.c	2004-10-29 00:30:40.000000000 +0200
@@ -102,6 +116,7 @@
 
 static void finish(void)
 {
+	sysdev_resume();
 	device_resume();
 	platform_finish();
 	enable_nonboot_cpus();
@@ -133,8 +148,12 @@
 	free_some_memory();
 
 	disable_nonboot_cpus();
-	if ((error = device_suspend(PM_SUSPEND_DISK)))
+	if ((error = device_suspend(PM_SUSPEND_DISK))) {
+		printk("Some devices failed to suspend\n");
 		goto Finish;
+	}
+
+	sysdev_suspend(POWER_SUSPEND_DISK);
 
 	return 0;
  Finish:
--- clean/kernel/power/swsusp.c	2004-10-19 14:16:29.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-10-29 00:32:26.000000000 +0200
@@ -825,6 +812,7 @@
 int swsusp_write(void)
 {
 	int error;
+	sysdev_resume();
 	device_resume();
 	lock_swapdevices();
 	error = write_suspend_image();


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
