Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVG0SfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVG0SfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbVG0SdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:33:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262450AbVG0Sag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:30:36 -0400
Date: Wed, 27 Jul 2005 11:29:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH 0/23] reboot-fixes
Message-Id: <20050727112934.0a20fffd.akpm@osdl.org>
In-Reply-To: <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<20050727025923.7baa38c9.akpm@osdl.org>
	<m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com>
	<20050727104123.7938477a.akpm@osdl.org>
	<m18xzs9ktc.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >>
> >> Andrew Morton <akpm@osdl.org> writes:
> >> 
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
> 
> My gut feel is the device_suspend calls are the right direction
> as it allows us to remove code from the drivers and possible
> kill device_shutdown completely. 
> 
> But this close to 2.6.13 I'm not certain what the correct solution
> is.  With this we have had issues with both ide and the e1000.
> But those are among the few drivers that do anything in either
> device_shutdown() or the reboot_notifier.
>
> The e1000 has been fixed.

By "fixed" do you mean Tony Luck's patch which I added to rc3-mm2?  If so,
do you think that's needed for 2.6.13?  Getting patches into e100[0] is a
bit of an exercise :(
