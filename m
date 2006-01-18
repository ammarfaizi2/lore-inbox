Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWARGyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWARGyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWARGxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:53:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40585 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932128AbWARGxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:53:36 -0500
Date: Tue, 17 Jan 2006 22:53:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: michael@ellerman.id.au, serue@us.ibm.com, linuxppc64-dev@ozlabs.org,
       paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-Id: <20060117225304.4b6dd045.akpm@osdl.org>
In-Reply-To: <20060118063732.GA21003@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com>
	<200601180032.46867.michael@ellerman.id.au>
	<20060117140050.GA13188@elte.hu>
	<200601181119.39872.michael@ellerman.id.au>
	<20060118033239.GA621@cs.umn.edu>
	<20060118063732.GA21003@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Dave C Boutcher <sleddog@us.ibm.com> wrote:
> 
> > On Wed, Jan 18, 2006 at 11:19:36AM +1100, Michael Ellerman wrote:
> > > It booted fine _with_ the patch applied, with DEBUG_MUTEXES=y and n.
> > > 
> > > Boutcher, to be clear, you can't boot with kernel-kernel-cpuc-to-mutexes.patch 
> > > applied and DEBUG_MUTEXES=y ?
> > > 
> > > But if you revert kernel-kernel-cpuc-to-mutexes.patch it boots ok?
> > > 
> > > This is looking quite similar to another hang we're seeing on Power4 iSeries 
> > > on mainline git:
> > > http://ozlabs.org/pipermail/linuxppc64-dev/2006-January/007679.html
> > 
> > Correct...I die in exactly the same place every time with 
> > DEBUG_MUTEXES=Y.  I posted a backtrace that points into the _lock_cpu 
> > code, but I haven't really dug into the issue yet.  I believe this is 
> > very timing related (Serge was dying slightly differently).
> 
> so my question still is: _without_ the workaround patch, i.e. with 
> vanilla -mm4, and DEBUG_MUTEXES=n, do you get a hang?
> 
> the reason for my question is that DEBUG_MUTEXES=y will e.g. enable 
> interrupts

That used to kill ppc64 and yes, it died in timer interrupts.

> - so buggy early bootup code which relies on interrupts being 
> off might be surprised by it.

I don't think it's necessarily buggy that bootup code needs interrupts
disabled.  It _is_ buggy that bootup code which needs interrupts disabled
is calling lock_cpu_hotplug().

> The fact that you observed that it's 
> somehow related to the timer interrupt seems to strengthen this 
> suspicion. DEBUG_MUTEXES=n on the other hand should have no such 
> interrupt-enabling effects.
> 
> [ if this indeed is the case then i'll add irqs_off() checks to
>   DEBUG_MUTEXES=y, to ensure that the mutex APIs are never called with 
>   interrupts disabled. ]

Yes, I suppose so.  But we're already calling might_sleep(), and
might_sleep() checks for that.  Perhaps the might_sleep() check is being
defeated by the nasty system_running check.

There's a sad story behind that system_running check in might_sleep(). 
Because the kernel early boot is running in an in_atomic() state, a great
number of bogus might_sleep() warnings come out because of various code
doing potentially-sleepy things.  I ended up adding the system_running
test, with the changelog "OK, I give up.  Kill all the might_sleep warnings
from the early boot process." Undoing that and fixing up the fallout would
be a lot of nasty work.


