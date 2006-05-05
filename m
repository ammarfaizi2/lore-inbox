Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWEEPGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWEEPGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWEEPGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:06:47 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:23978 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750770AbWEEPGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:06:47 -0400
Date: Fri, 5 May 2006 17:05:09 +0200
X-OfflineIMAP-1477436014-52656d6f7465-494e424f58: 1146841521-0199946930514-v4.0.11
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3-mm1
Message-ID: <20060505150509.GA16562@ens-lyon.fr>
References: <20060501014737.54ee0dd5.akpm@osdl.org> <40f323d00605030211t78e41d18h298c8be3721a135a@mail.gmail.com> <20060503064816.ef7ec2b7.akpm@osdl.org> <1146665732.27820.75.camel@localhost.localdomain> <20060503144318.GA5505@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503144318.GA5505@ens-lyon.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2006 at 04:43:18PM +0200, Benoit Boissinot wrote:
> On Wed, May 03, 2006 at 04:15:32PM +0200, Thomas Gleixner wrote:
> > On Wed, 2006-05-03 at 06:48 -0700, Andrew Morton wrote:
> > > > Since a few -mm releases I am seeing processes stuck in a
> > > > nanosleep({0, 0}, NULL) syscall. Sometimes, they unfreeze after
> > > > several hours.
> > >
> > > Thanks.   Yes, please test mainline first - it will probably occur there.
> > > 
> > > And it's a nanosleep(zero) all the time?  The obvious answer would be that
> > > a clock tick came in at the right time and we end up trying to sleep for -1
> > > units.  But if that was the case, things wouldn't unsleep after just
> > > several hours.
> > 
> > I don't see how that should happen. The expiry time is stored in
> > absolute time format when nanosleep is started and compared against
> > current time in the softirq. We might miss one tick, but not more.
> > 
> > Benoit, can you please mail me .config and a boot log ?
> 
> they are attached (the faulting process is urxvtd).
> 
I added the following debug code:

Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -426,6 +426,7 @@ hrtimer_start(struct hrtimer *timer, kti
 	struct hrtimer_base *base, *new_base;
 	unsigned long flags;
 	int ret;
+	ktime_t save = tim;
 
 	base = lock_hrtimer_base(timer, &flags);
 
@@ -437,6 +438,12 @@ hrtimer_start(struct hrtimer *timer, kti
 
 	if (mode == HRTIMER_REL) {
 		tim = ktime_add(tim, new_base->get_time());
+		if(save.tv64 == 0) {
+			char comm[TASK_COMM_LEN];
+			ktime_t curr = new_base->get_time();
+			get_task_comm(comm, current);
+			printk("%s: empty nanosleep %lld %lld\n", comm, curr.tv64, tim.tv64);
+		}
 		/*
 		 * CONFIG_TIME_LOW_RES is a temporary way for architectures
 		 * to signal that they simply return xtime in


and when urxvtd hanged I had the following in dmesg:
[  356.696000] urxvtd: empty nanosleep 356726124322 17948911854451

So I suppose something is wrong in ktime_add()

regards,

Benoit

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
