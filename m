Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWARH2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWARH2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWARH2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:28:31 -0500
Received: from thorn.pobox.com ([208.210.124.75]:4227 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1030286AbWARH23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:28:29 -0500
Date: Wed, 18 Jan 2006 01:28:15 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060118072815.GR2846@localhost.localdomain>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <200601180032.46867.michael@ellerman.id.au> <20060117140050.GA13188@elte.hu> <200601181119.39872.michael@ellerman.id.au> <20060118033239.GA621@cs.umn.edu> <20060118063732.GA21003@elte.hu> <20060117225304.4b6dd045.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117225304.4b6dd045.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> > - so buggy early bootup code which relies on interrupts being 
> > off might be surprised by it.
> 
> I don't think it's necessarily buggy that bootup code needs interrupts
> disabled.  It _is_ buggy that bootup code which needs interrupts disabled
> is calling lock_cpu_hotplug().

I guess I don't understand -- why is it wrong for code that runs only
in early early bootup, when there is only one process context, to use
common code to e.g. register a hotplug cpu notifier?  Should the
powerpc numa code be made to wait to register its notifier until
initcall time or something?

> > The fact that you observed that it's 
> > somehow related to the timer interrupt seems to strengthen this 
> > suspicion. DEBUG_MUTEXES=n on the other hand should have no such 
> > interrupt-enabling effects.
> > 
> > [ if this indeed is the case then i'll add irqs_off() checks to
> >   DEBUG_MUTEXES=y, to ensure that the mutex APIs are never called with 
> >   interrupts disabled. ]
> 
> Yes, I suppose so.  But we're already calling might_sleep(), and
> might_sleep() checks for that.  Perhaps the might_sleep() check is being
> defeated by the nasty system_running check.

Yes, which would be why this code never triggered a warning when
cpucontrol was a semaphore.
