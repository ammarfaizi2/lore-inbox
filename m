Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758880AbWK2WZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758880AbWK2WZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758875AbWK2WZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:25:28 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:27871 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1758881AbWK2WZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:25:26 -0500
Date: Wed, 29 Nov 2006 14:18:53 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: [PATCH] i386 add idle notifier
Message-ID: <20061129221853.GD29670@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061129162540.GL28007@frankl.hpl.hp.com> <20061129170939.GA29203@infradead.org> <20061129130944.82e3d9bb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129130944.82e3d9bb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 29, 2006 at 01:09:44PM -0800, Andrew Morton wrote:
> On Wed, 29 Nov 2006 17:09:39 +0000
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Wed, Nov 29, 2006 at 08:25:40AM -0800, Stephane Eranian wrote:
> > > Hello,
> > > 
> > > Here is a patch that adds an idle notifier to the i386 tree.
> > > The idle notifier functionalities and implementation are
> > > identical to the x86_64 idle notifier. We use the idle notifier
> > > in the context of perfmon.
> > > 
> > > The patch is against Andi Kleen's x86_64-2.6.19-rc6-061128-1.bz2
> > > kernel. It may apply to other kernels but it needs some updates
> > > to poll_idle() and default_idle() to work correctly.
> > 
> > Walking through a notifier chain on every single interrupt (including
> > timer interrupts) seems rather costly.  What do you need this for
> > exactly?
> 
Let me give you the background on this.

In system-wide mode, perfmon wants to exclude useless kernel execution
from being monitored. That execution is performed by the idle thread
when it enters its lowest loop level, i.e., poll_idle(), defaut_idle(),
mwait_idle(). It used to be that the idle loop was simply looping, waiting
for an interrupt or polling a variable. These days, it is a bit more
complex because on many processors, idle means going to a lower power state.
We want to capture useful idle thread execution such as interrupt servicing
but we want to exclude polling and low-power state.

When entering low-power, some processors systematically turn off
performance counters. But this is not necessarily the case for every processors.
Worse, for some processors it depends on the events being measured. Yet, at the
perfmon interface level, we want to guarantee a uniform behavior across architectures.
As such, we have to use software to enforce our policy.

Andi pointed out that there is an idle notifier in the x86-64 tree, and that it
could be a way to achieve our goal. 

I would tend to agree with both of you that the way the notifier is implemented may be a little
bit overkill for what we need it for. In my latest patch, I made sure that we register/unregister
an idle notification routine only when necessary. Yet, it is true that on each interrupt received
by the idle thread you go through enter_idle()/exit_idle() and atomic_call_chain().

In the current implementation, registration is global, call are obviously made for one CPU and
a RCU read lock is used, so multiple calls from different CPUs can be issued at the same time.

AFAICT, perfmon is the only user of the idle notifier. Perfmon operates on a per-cpu basis in system
wide. As such, I think we could simplify it by making the registration/call mechanism completly a
per-CPU construct. This would simplify the locking aspect. We would still need the test_and_set
to avoid a race with interrupts.

> yes, it's a worry.
> 
> Why doesn't enter_idle() do the test_and_set_bit() thing, like
> exit_idle()?

I think we could use the same test_and_set_bit(). In fact, there is  only
one place where we call enter_idle(), so just like x86-64 we could just
replace this with
	__get_cpu_var(idle_state) = 1;

-- 
-Stephane
