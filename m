Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUIZUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUIZUwy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 16:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUIZUwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 16:52:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:43183 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263664AbUIZUwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 16:52:49 -0400
Message-ID: <41572B34.3010209@suse.de>
Date: Sun, 26 Sep 2004 22:48:52 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
References: <200409251214.28743.rjw@sisk.pl> <200409261906.10635.rjw@sisk.pl> <20040926183449.GA28810@elf.ucw.cz> <200409262125.38271.rjw@sisk.pl>
In-Reply-To: <200409262125.38271.rjw@sisk.pl>
Content-Type: multipart/mixed;
 boundary="------------090000070101040101050905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090000070101040101050905
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit

Rafael J. Wysocki wrote:

>>Try to unload all modules etc, see if it goes away.
> 
> I guess it will, but I'll check.

please try attached patch first. The comments should explain it pretty
well. It seems to have helped me: without it, sysrq-p during writing
(even if not that slow) almost always was in pccardd, now it is idling
in swapper task.
Maybe i am totally wrong but you may give it a shot.

>>If not, fix sysrq  to work for you, and look at backtrace.
> 
> This would be more time-consuming. :-)

maybe you just press wrong keys? On my Dell D600, although SysRQ is in
blue on PrtSc, no Fn-Key is needed but only ALT-PrtSc.
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX AG Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."

--------------090000070101040101050905
Content-Type: text/x-patch;
 name="swsusp-disable-irqs-before-writing-image.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-disable-irqs-before-writing-image.diff"

Only in kernel/power/: .built-in.o.cmd
Only in kernel/power/: .console.o.cmd
Only in kernel/power/: .disk.o.cmd
Only in kernel/power/: .main.o.cmd
Only in kernel/power/: .pm.o.cmd
Only in kernel/power/: .poweroff.o.cmd
Only in kernel/power/: .process.o.cmd
Only in kernel/power/: .swsusp.o.cmd
Only in kernel/power/: built-in.o
Only in kernel/power/: console.o
diff -up ../linux-2.6.8-14/kernel/power/disk.c kernel/power/disk.c
--- ../linux-2.6.8-14/kernel/power/disk.c	2004-09-23 02:22:50.000000000 +0200
+++ kernel/power/disk.c	2004-09-26 22:41:14.735864464 +0200
@@ -182,6 +182,13 @@ int pm_suspend_disk(void)
 		goto Done;
 
 	if (in_suspend) {
+		/*
+		 * during swsusp_suspend, the machine basically suspends,
+		 * does the atomic copy and then resumes again. This is
+		 * why we have to disable irqs again or there may be trouble.
+		 */
+		local_irq_disable();
+
 		pr_debug("PM: writing image.\n");
 
 		/*
Only in kernel/power/: disk.o
Only in kernel/power/: main.o
Only in kernel/power/: pm.o
Only in kernel/power/: poweroff.o
Only in kernel/power/: process.o
diff -up ../linux-2.6.8-14/kernel/power/swsusp.c kernel/power/swsusp.c
--- ../linux-2.6.8-14/kernel/power/swsusp.c	2004-09-23 02:22:51.000000000 +0200
+++ kernel/power/swsusp.c	2004-09-26 22:45:24.027966304 +0200
@@ -853,7 +853,10 @@ int swsusp_suspend(void)
 	local_irq_disable();
 	save_processor_state();
 	error = swsusp_arch_suspend();
-	/* Restore control flow magically appears here */
+	/* Restore control flow magically appears here during resume.
+	 * During suspend, this is not the end! We still have to write
+	 * the image to disk and power off.
+	 */
 	restore_processor_state();
 	restore_highmem();
 	local_irq_enable();
Only in kernel/power/: swsusp.c-orig
Only in kernel/power/: swsusp.o

--------------090000070101040101050905--
