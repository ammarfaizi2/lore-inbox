Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVG0WvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVG0WvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVG0WtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:49:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65233 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261212AbVG0WrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:47:22 -0400
Date: Thu, 28 Jul 2005 00:47:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
Message-ID: <20050727224711.GA6671@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com> <20050727025923.7baa38c9.akpm@osdl.org> <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com> <20050727104123.7938477a.akpm@osdl.org> <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>  > My fairly ordinary x86 test box gets stuck during reboot on the
> >>  > wait_for_completion() in ide_do_drive_cmd():
> >> 
> >>  Hmm. The only thing I can think of is someone started adding calls
> >>  to device_suspend() before device_shutdown().  Not understanding
> >>  where it was a good idea I made certain the calls were in there
> >>  consistently.  
> >> 
> >>  Andrew can you remove the call to device_suspend from kernel_restart
> >>  and see if this still happens?
> >
> > yup, that fixes it.
> >
> > --- devel/kernel/sys.c~a	2005-07-27 10:36:06.000000000 -0700
> > +++ devel-akpm/kernel/sys.c	2005-07-27 10:36:26.000000000 -0700
> > @@ -371,7 +371,6 @@ void kernel_restart(char *cmd)
> >  {
> >  	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
> >  	system_state = SYSTEM_RESTART;
> > -	device_suspend(PMSG_FREEZE);
> >  	device_shutdown();
> >  	if (!cmd) {
> >  		printk(KERN_EMERG "Restarting system.\n");
> > _
> >
> >
> > Presumably it unfixes Pavel's patch?
> 
> Good question.  I'm not certain if Pavel intended to add
> device_suspend(PMSG_FREEZE) to the reboot path.  It was
> there in only one instance.  Pavel comments talk only about
> the suspend path.

Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.

> My gut feel is the device_suspend calls are the right direction
> as it allows us to remove code from the drivers and possible
> kill device_shutdown completely. 
> 
> But this close to 2.6.13 I'm not certain what the correct solution
> is.  With this we have had issues with both ide and the e1000.
> But those are among the few drivers that do anything in either
> device_shutdown() or the reboot_notifier.
..
> Looking at it more closely the code is confusing because
> FREEZE and SUSPEND are actually the same message, and in
> addition to what shutdown does they place the device in

Not in -mm; I was finally able to fix that one.

> My gut feel is that device_suspend(PMSG_FREEZE) should be
> removed from kernel_restart until is a different message
> from PMSG_SUSPEND at which point it should be equivalent
> to device_shutdown and we can remove that case.

PMSG_FREEZE != PMSG_SUSPEND in current -mm, but I'm not sure if we can
push that to 2.6.13...
							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
