Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUCRPTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUCRPTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:19:47 -0500
Received: from opersys.com ([64.40.108.71]:14084 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261990AbUCRPTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:19:43 -0500
Message-ID: <4059BF0B.4030404@opersys.com>
Date: Thu, 18 Mar 2004 10:23:55 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Mark Gross <mgross@linux.co.intel.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       lkml <linux-kernel@vger.kernel.org>, Philippe Gerum <rpm@xenomai.org>
Subject: Re: Call for HRT in 2.6 kernel was Re: finding out the value of HZ
 from userspace
References: <20040311141703.GE3053@luna.mooo.com> <200403161757.48786.mgross@linux.intel.com> <20040317023059.GD19564@mail.shareable.org> <200403170848.01156.mgross@linux.intel.com> <20040317200702.GA25293@mail.shareable.org> <4058F91C.9000207@opersys.com> <20040318115609.GA29382@mail.shareable.org>
In-Reply-To: <20040318115609.GA29382@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamie Lokier wrote:
> I see we have gone from a desire for soft-rt high-res timers to
> pushing hard-rt :)

:D

> In this case, it's not clear that hard-rt is desirable.  VoIP doesn't
> like occasional glitches, but it can tolerate them and must do so when
> a machine is overloaded, e.g. trying to handle too many scheduling
> objectives at once.  I don't know much about the original poster's
> problem, that's just my take on VoIP.

I agree that VoIP doesn't "require" hard-rt, I have no issue with that.
I was expanding on the specific discussion of the HRT mechanism, not
the intended usage itself. Let me know if you'd rather see this discussed
separately.

> There is also Bernard Kuhn's recent "real-time interrupts" patch for
> 2.6 which could be utilised:

The first implementation of such a mechanism for Linux was done by David
Schleef a few years back and it was called the "no-warm air" patch (long
story.) Basically, though, I think this is the wrong approach because the
resulting behavior is very much CPU-dependent (interrupt priority
mechanisms being CPU-specific.) With Adeos, you get the same API and
the same behavior regardless of underlying architecture. Adeos' pipeline
actually provides the same net effect as playing with the int controllers,
except that it's totally hardware independent. No to mention that a
nanokernel's behavior can be modified/extended while a CPU's behavior is
pretty much ... hmmm, well, fixed in silicone ...

> A couple of questions.

Sure.

> Can Adeos-registed timer callbacks call the same functions as normal
> timer callbacks, schedule userspace, and kick network I/O with near-RT
> guarantees?  Or do they run in a non-kernel context?

The Adeos-registered callbacks cannot _directly_ call kernel functions.
They can, however, trigger virtual IRQs that, once propagated to Linux,
can then take care of such calls. Here are the relevant Adeos functions
(see http://home.gna.org/adeos/doc/api/interface_8h.html for the full
API and its usage):

unsigned adeos_alloc_irq (void)
> Allocates a system-wide pipelined virtual interrupt. Virtual interrupts
> are pseudo-interrupt channels which are handled in exactly the same way
> than their hardware-generated counterparts. This is a basic, one-way
> only, inter-domain communication system allowing a domain to trigger the
> execution of a handler inside cooperating domains using the interrupt
> semantics (see adeos_trigger_irq()). A domain can trap the virtual
> interrupt using the adeos_virtualize_irq() service. Any domain can use
> adeos_virtualize_irq() on a virtual interrupt even if such interrupt was
> allocated by another domain.

int adeos_trigger_irq (unsigned irq)
> Simulates the occurrence of an interrupt. Adeos acts as if the specified
> interrupt had been received from the underlying hardware, and starts
> propagating it down the pipeline. The calling domain might be immediately
> preempted on behalf of this routine if the interrupt is delivered to a more
> prioritary domain.

Using these basic functions and the relevant callbacks it's fairly simple
to have the hard-rt component do the critical stuff and immediately signal
a Linux-aware handler to "call the same functions as normal timer callbacks,
schedule userspace, and kick network I/O with near-RT guarantees." It
should also be possible to wrap these primitives around higher-level
functions such as HRT, for example.

Side note: virtual IRQs is something CPU int controller silicone is
incapable of.

> Can Adeos itself be loaded as a module which overrides normal non-RT
> kernel interrupt and timer functions?  If it can be kept out of the
> standard kernel, but loaded when needed, that would be nice.

Sure, Adeos can be compiled as a module and loaded at runtime, but it does
require a few basic things to be modified within the kernel in order to
allow runtime loading.

> One more thing would help, IMHO, in getting any fancy interrupt system
> in: if it balanced the different execution contexts, i.e. limit total
> CPU taken in high priority, low priority interrupts, task queues
> etc. in an efficient yet fair way, such that overall throughput was
> improved over standard kernels in cases such as network overload.
> NAPI does this at the network card level, but there is no reason why
> balancing CPU among contexts cannot be done at the generic interrupt
> scheduling level, making it work for all I/O devices without special
> driver support.

Hmm... IOW, Adeos wouldn't implement a pipeline, but an interrupt
scheduler? I guess that's possible, but I can see things getting very
confusing very fast for driver developers because of the hard-rt issues,
not to mention code complexity in the interrupt scheduler for avoiding
starvation, missed deadlines, overruns, etc. Given that Adeos itself is
a nanokernel it really would make little sense for it to act as the
scheduler of any interrupts within any of its clients. It could certainly
have an OS scheduler, but that's different from you're asking for. There
is no reason, however, for not having an additional Linux-specific
mechanism for prioritizing incoming Linux interrupts. For example, if I
understand it correctly TimeSys has implemented some form of interrupt
threading in their kernel. Maybe that can be used at the Linux level in
addition to having a basic bare-bones hard-RT mechanism for delivering
interrupts. While I can't expand on this, since I haven't seen their
code, I think something similar may be better adapted in order to
preserve existing driver behavior.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

