Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUAJUCN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUAJUCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:02:13 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:14208 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265366AbUAJUCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:02:04 -0500
Date: Sat, 10 Jan 2004 21:03:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: suspend/resume support for PIT (time.c)
Message-ID: <20040110200332.GA1327@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds proper suspend/resume support for PIT. That means that clock
are actually correct after suspend/resume. Please apply,

								Pavel

Index: linux/arch/i386/kernel/time.c
===================================================================
--- linux.orig/arch/i386/kernel/time.c	2004-01-09 20:26:08.000000000 +0100
+++ linux/arch/i386/kernel/time.c	2004-01-09 20:33:05.000000000 +0100
@@ -307,7 +307,30 @@
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
+	.resume = pit_resume,
+	.suspend = pit_suspend,
 	set_kset_name("pit"),
 };
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
