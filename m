Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUALXMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUALXMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:12:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:44758 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262767AbUALXMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:12:38 -0500
Date: Mon, 12 Jan 2004 15:12:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: suspend/resume support for PIT (time.c)
Message-Id: <20040112151254.5a30baaa.akpm@osdl.org>
In-Reply-To: <20040112223915.GA204@elf.ucw.cz>
References: <20040110200332.GA1327@elf.ucw.cz>
	<1073932405.28098.43.camel@cog.beaverton.ibm.com>
	<20040112223915.GA204@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> > As none of this really has anything to do w/ the PIT, and to avoid
> > confusion w/ the PIT timesource code, could we rename this to
> > "time_suspend" and "time_resume"?
> 
> Applied, altrough I'll not try to push it for a while. (I'm not sure
> if Andrew applied previous patches and do not want to clash).

I already converted the patch.    Here's what I currently have:




From: Pavel Machek <pavel@ucw.cz>

This adds proper suspend/resume support for PIT.  That means that clock are
actually correct after suspend/resume.


---

 25-akpm/arch/i386/kernel/time.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

diff -puN arch/i386/kernel/time.c~suspend-resume-for-PIT arch/i386/kernel/time.c
--- 25/arch/i386/kernel/time.c~suspend-resume-for-PIT	Mon Jan 12 13:49:55 2004
+++ 25-akpm/arch/i386/kernel/time.c	Mon Jan 12 13:49:55 2004
@@ -307,7 +307,31 @@ unsigned long get_cmos_time(void)
 	return retval;
 }
 
+static long clock_cmos_diff;
+
+static int time_suspend(struct sys_device *dev, u32 state)
+{
+	/*
+	 * Estimate time zone so that set_time can update the clock
+	 */
+	clock_cmos_diff = -get_cmos_time();
+	clock_cmos_diff += get_seconds();
+	return 0;
+}
+
+static int time_resume(struct sys_device *dev)
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
+	.resume = time_resume,
+	.suspend = time_suspend,
 	set_kset_name("pit"),
 };
 

_

