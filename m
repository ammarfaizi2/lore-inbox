Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVCQAuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVCQAuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbVCQAtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:49:12 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:222 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262926AbVCQAix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:38:53 -0500
Subject: Re: CPU hotplug on i386
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
In-Reply-To: <200503161540.04480.rjw@sisk.pl>
References: <20050316132151.GA2227@elf.ucw.cz>
	 <200503161540.04480.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1111020048.3240.84.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 17 Mar 2005 11:40:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-03-17 at 01:40, Rafael J. Wysocki wrote:
> On Wednesday, 16 of March 2005 14:21, Pavel Machek wrote:
> > Hi!
> > 
> > I tried to solve long-standing uglyness in swsusp cmp code by calling
> > cpu hotplug... only to find out that CONFIG_CPU_HOTPLUG is not
> > available on i386. Is there way to enable CPU_HOTPLUG on i386?
> 
> Heh, that's exactly what I was thinking about.  ;-)
> 
> AFAICS we don't need the full CPU hotplug to do this.  For suspend, we need to
> enable the CPU hotplug-related code in sched.c and cpu.c, and we need to
> implement the functions __cpu_disable() and __cpu_die() (called from within
> cpu.c) on each architecture for which we want swsusp to work on SMP.
> 
> If that's acceptable, the CPU hotplug code in sched.c and cpu.c may be
> enabled by changing some #ifdefs there.  For example, we could replace the
> 
> #idef CONFIG_CPU_HOTPLUG
> 
> with
> 
> #if defined(CONFIG_CPU_HOTPLUG) || (defined(CONFIG_SOFTWARE_SUSPEND)
> 	&& defined(CONFIG_SMP))
> 
> wherever necessary.
> 
> The implementation of __cpu_disable() and __cpu_die() may be a bit more
> tricky, however.  In __cpu_disable() we need to save the settings of the local
> APIC of each CPU (on x86-64, at least) etc.  In __cpu_die() we should give the
> "frozen" CPU some "neutral" code to execute, it seems (or "hlt" it?).
> 
> I've looked at the ia64 implementation of these functions, but I haven't fully
> understood it yet.

It would be good (32 bit) if you handled MTRRs as well. Putting their
save/restore code in the driver model is racy (SMP calls). I've worked
around that in Suspend2 by removing the driver model support and making
the save/restore calls from the lowlevel code. I think this should be
considered the right thing to do.

By the way, I'm keen to test this with Suspend2 as well. I would have
done so before now, but I didn't realise Zwane had the support done.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

