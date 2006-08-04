Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161472AbWHDX1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161472AbWHDX1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161473AbWHDX1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:27:51 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:18874 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161472AbWHDX1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:27:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Suspend on Dell D420
Date: Sat, 5 Aug 2006 01:26:56 +0200
User-Agent: KMail/1.9.3
Cc: "Steinar H. Gunderson" <sgunderson@bigfoot.com>,
       linux-kernel@vger.kernel.org
References: <20060804162300.GA26148@uio.no> <200608042327.38280.rjw@sisk.pl> <20060804151758.1d3dd6bd.akpm@osdl.org>
In-Reply-To: <20060804151758.1d3dd6bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608050126.57060.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 August 2006 00:17, Andrew Morton wrote:
> On Fri, 4 Aug 2006 23:27:38 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Friday 04 August 2006 18:23, Steinar H. Gunderson wrote:
> > > [Please Cc me on any followups]
> > > 
> > > Hi,
> > > 
> > > Suspend-to-RAM works fine on my new Dell Latitude D420 (with Core Duo) in
> > > 2.6.16, but it broke in 2.6.17 -- the machine suspends just fine, but when it
> > > resumes, the disk never spins up, the screen stays black and it just hangs.
> > > Bisecting shows that the following commit is where it broke:
> > > 
> > > commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f
> > > Author: Andrew Morton <akpm@osdl.org>
> > > Date:   Wed Mar 22 00:08:16 2006 -0800
> > >  
> > >     [PATCH] on_each_cpu(): disable local interrupts
> > >  
> > >     When on_each_cpu() runs the callback on other CPUs, it runs with local
> > >     interrupts disabled.  So we should run the function with local interrupts
> > >     disabled on this CPU, too.
> > >  
> > >     And do the same for UP, so the callback is run in the same environment on both
> > >     UP and SMP.  (strictly it should do preempt_disable() too, but I think
> > >     local_irq_disable is sufficiently equivalent).
> > >  
> > >     Also uninlines on_each_cpu().  softirq.c was the most appropriate file I could
> > >     find, but it doesn't seem to justify creating a new file.
> > >  
> > >     Oh, and fix up that comment over (under?) x86's smp_call_function().  It
> > >     drives me nuts.
> > > 
> > > Applying the patch in reverse against 2.6.17 (it doesn't apply cleanly, but
> > > I've done what seems to be the moral equivalent) makes the suspend work
> > > again.
> > > 
> > > Any ideas? It does not work with the latest git checkout as of today.
> > 
> > I guess the patch may interfere with the CPU hotplug badly.
> 
> Why do you think it would do that?

Because the non-boot CPUs are taken off early, before anything else, and the
system is effectively non-SMP during the entire suspend-resume cycle
(well, almost).  If SMP-related things go wrong during the suspend, CPU
hotplug is the first suspect. ;-)

> >  Could you please
> > check if you can take CPU1 offline/online?
> 
> If something really wants "disable irqs on the other CPUs but not on this
> CPU" semantics then it would need to use smp_call_function and a direct
> call.  But it would be a strange thing to want to do, surely?

Yes, it would, but I have a little experience with these things.

Well, looks like on_each_cpu() is run via flush_tlb_all() from
__smp_prepare_cpu() which is called by __cpu_up() and that's used by the CPU
hotplug.  Not that I can tell what goes wrong here, if anything.

Greetings,
Rafael
