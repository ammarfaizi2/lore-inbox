Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWCIQL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWCIQL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWCIQL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:11:57 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:61876 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932222AbWCIQL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:11:57 -0500
Date: Thu, 9 Mar 2006 11:11:56 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: Miles Lane <miles.lane@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       <cpufreq@lists.linux.org.uk>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.16-rc5-mm3 -- BUG: sleeping function called from invalid
 context at include/linux/rwsem.h:43 in_atomic():0, irqs_disabled():1
In-Reply-To: <20060309023234.02ba4517.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0603091046080.5232-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2006, Andrew Morton wrote:

> "Miles Lane" <miles.lane@gmail.com> wrote:
> >
> > Apologies.  This bug caused my video to get messed up.  I was able to
> > run Gnome, but the apps weren't rendering correctly, so I couldn't be
> > sure my subject line was correct.
> > I would have edited out some of the context info, but that was tough
> > as well.  Here's the BUG message by itself.  Perhaps all the dmesg
> > output in the previous message will be helpful.
> > As you can see in the dmesg output, I hit this by suspending and
> > resuming.  I am running Fedora Core 5 Test 3 + all yum updates.
> > Andrew, the full dmesg output is in the LKML message with the subject
> > line set to "v".  Let me know if you would like me to send it directly
> > to you.
> > 
> > BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
> > in_atomic():0, irqs_disabled():1
> >  <c1003f81> show_trace+0xd/0xf   <c100401b> dump_stack+0x17/0x19
> >  <c1015f77> __might_sleep+0x86/0x90   <c1024738>
> > blocking_notifier_call_chain+0x1b/0x4d
> >  <c1183bb2> cpufreq_resume+0xf5/0x11d   <c112b27c> __sysdev_resume+0x23/0x57
> >  <c112b3c9> sysdev_resume+0x19/0x4b   <c112f736> device_power_up+0x8/0xf
> >  <c1033339> swsusp_suspend+0x6e/0x8b   <c1033918> pm_suspend_disk+0x51/0xf3
> >  <c10328c7> enter_state+0x53/0x1c1   <c1032abe> state_store+0x89/0x97
> >  <c108af00> subsys_attr_store+0x20/0x25   <c108b020> sysfs_write_file+0xb5/0xdc
> >  <c1056578> vfs_write+0xab/0x154   <c1056aa3> sys_write+0x3b/0x60
> >  <c1002b43> syscall_call+0x7/0xb
> > PM: Image restored success
> 
> ho-hum.  That's swsusp insisting on running things which it shouldn't run
> with local interrupts disabled.
> 
> I wouldn't expect this to cause the display to get mucked up though.

This problem arises because the cpufreq transition notifier chain is
classified as blocking, but it gets called with interrupts disabled during
cpufreq_suspend() and cpufreq_resume().  In fact, those routines include
this comment:

	/* we may be lax here as interrupts are off. Nonetheless
	 * we need to grab the correct cpu policy, as to check
	 * whether we really run on this CPU.
	 */

Now this is odd, because the main path for calling that notifier chain,
cpufreq_notify_transition(), includes the line

	BUG_ON(irqs_disabled());

In other words, cpufreq seems to be of two minds about whether or not 
interrupts should be enabled when the transition notifier chain gets run.

Note that in at least one driver, drivers/pcmcia/soc_common.c, a callout
routine on that chain does a down().  So it looks like interrupts should
always be enabled.  Or maybe I'm reading too much into a simple mistake.

Part of the problem may be that cpufreq seems to expect interrupts to be
on when the chain is called with val = CPUFREQ_PRECHANGE or
CPUFREQ_POSTCHANGE, and interrupts to be off when the chain is called with
CPUFREQ_SUSPENDCHANGE or CPUFREQ_RESUMECHANGE.  This is a rather fragile
way of doing things.

I don't know what the proper way is to fix this; someone involved with 
cpufreq development will have to handle it.  Perhaps there should be two 
distinct notifier chains, one for suspend/resume and one for everything 
else.

Alan Stern

