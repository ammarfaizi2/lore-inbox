Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTJVXdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 19:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbTJVXdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 19:33:21 -0400
Received: from gprs144-47.eurotel.cz ([160.218.144.47]:13188 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261332AbTJVXdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 19:33:19 -0400
Date: Thu, 23 Oct 2003 01:33:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [pm] fix time after suspend-to-*
Message-ID: <20031022233306.GA6461@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds suspend/resume methods for time, so that real time is
refreshed from cmos when suspend is finished. Please apply,

							Pavel
[Code was copied from apm.c, someone familiar from apm.c can probably
kill it from there -- after adding device_power_down() and
device_power_up() to right places].

--- tmp/linux/arch/i386/kernel/time.c	2003-10-09 00:13:14.000000000 +0200
+++ linux/arch/i386/kernel/time.c	2003-10-23 01:05:36.000000000 +0200
@@ -271,16 +271,39 @@
 	unsigned long retval;
 
 	spin_lock(&rtc_lock);
-
 	retval = mach_get_cmos_time();
-
 	spin_unlock(&rtc_lock);
 
 	return retval;
 }
 
+static long clock_cmos_diff;
+static int got_clock_diff;
+
+static int pit_suspend(struct sys_device *dev, u32 state)
+{
+	/*
+	 * Estimate time zone so that set_time can update the clock
+	 */
+	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff += get_seconds();
+	got_clock_diff = 1;
+	return 0;
+}
+
+static int pit_resume(struct sys_device *dev)
+{
+	if (got_clock_diff) {	/* Must know time zone in order to set clock */
+		xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
+		xtime.tv_nsec = 0; 
+	} 
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
