Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265849AbUAKLxY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 06:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265850AbUAKLws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 06:52:48 -0500
Received: from gprs214-122.eurotel.cz ([160.218.214.122]:31616 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265849AbUAKLwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 06:52:35 -0500
Date: Sun, 11 Jan 2004 12:53:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suspend/resume support for PIT (time.c)
Message-ID: <20040111115349.GA831@elf.ucw.cz>
References: <20040110200332.GA1327@elf.ucw.cz> <20040110144624.1571488f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110144624.1571488f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +static int pit_resume(struct sys_device *dev)
> >  +{
> >  +	write_seqlock_irq(&xtime_lock);
> >  +	xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
> >  +	xtime.tv_nsec = 0; 
> >  +	write_sequnlock_irq(&xtime_lock);
> >  +	return 0;
> >  +}
> 
> Have you checked the lock ranking here?  get_cmos_time() takes a ton of
> locks, especially if EFI is enabled.  Do all those rank inside xtime_lock?
> 
> It _looks_ right, but perhaps it would be saner to move the get_coms_time()
> call outside the lock?

Yes, good idea, I do not want to check every change in
get_cmos_time().
							Pavel
Index: linux/arch/i386/kernel/time.c
===================================================================
--- linux.orig/arch/i386/kernel/time.c	2004-01-09 20:26:08.000000000 +0100
+++ linux/arch/i386/kernel/time.c	2004-01-11 12:12:48.000000000 +0100
@@ -307,7 +307,31 @@
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
+	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	write_seqlock_irq(&xtime_lock);
+	xtime.tv_sec = sec;
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
