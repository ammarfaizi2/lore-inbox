Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbUKDRU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUKDRU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbUKDRU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:20:26 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:15785 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id S262299AbUKDRQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:16:20 -0500
Subject: Re: is killing zombies possible w/o a reboot?
From: Alex Bennee <kernel-hacker@bennee.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Russell Miller <rmiller@duskglow.com>, Jim Nelson <james4765@verizon.net>,
       DervishD <lkml@dervishd.net>, Gene Heskett <gene.heskett@verizon.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
In-Reply-To: <4189FEBF.9000800@hist.no>
References: <200411030751.39578.gene.heskett@verizon.net>
	 <20041103192648.GA23274@DervishD> <4189586E.2070409@verizon.net>
	 <200411031644.58979.rmiller@duskglow.com>  <4189FEBF.9000800@hist.no>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1099588567.2865.27.camel@cambridge>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 04 Nov 2004 17:16:07 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 10:04, Helge Hafting wrote:
> Russell Miller wrote:
> >On Wednesday 03 November 2004 16:15, Jim Nelson wrote:
> >
> >Anyway, is there a way to simply signal a syscall that it is to be interrupted 
> >and forcibly cause the syscall to end? 
> >
> There is a way.  Processes go into D state happens all the time
> when waiting for disk io or similiar.  Then the io happens a few ms later,
> and the fs or device driver tells the kernel to wake up the process
> so it gets a chance at the next scheduling opportunity. So the mechanism to
> unstick a prcess exists, and is used by every device driver that
> use sleeping.  Which is most of them.
> 
> Breakage happens when something never comes out of D-state.
> One could write a trivial syscall (or addition to "kill") that "wakes"
> processes waiting for io.  It itsn't hard to do at all - just copy the
> waking code from any device driver.  This will allow to kill and
> fully remove any process that hangs around in D-state.  This might
> also release other stuck resources as the syscall
> continues, returns to userspace, and allows the process to die.
> 
> Unfortunately, this isn't enough.  In some cases the syscall
> expects the io device interrupt handler to have done something
> vital - but this haven't happened when we forcibly wakes a process.
> We can hope for an io error, but might get a crash instead. This
> can be fixes with a lot of work - basically check at every wakeup
> if the process were woken by this new killing mechanism and
> act accordingly.  It shouldn't be hard, but _lots_ of work
> inspecting every sleeping point, at least every device driver.

Timeouts and interruptible sleeps are the two ways to solve the problem.
All good drivers should have covering timeouts in case the event they
where hoping for never happens.

If the code path that assumes magic has happened after it wakes up
doesn't check its not defensive enough. Also you can make tasks
interruptible so signals can get through:

result = wait_event_interruptible(dev->waitq,dev_irq_event(dev));
      
if (result) {
     printk(KERN_ALERT "dev_irq_wait: Interrupted by a signal\n");
     return -ERESTARTSYS;
};

As you have noted you can't always make things interruptible, but decent
timeouts should always exist. Hardware has bugs too!
-- 
Alex, Kernel Hacker: http://www.bennee.com/~alex/

In English, every word can be verbed.  Would that it were so in our
programming languages.

