Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbULIJci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbULIJci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 04:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbULIJcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 04:32:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4507 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261159AbULIJc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 04:32:28 -0500
Date: Thu, 9 Dec 2004 10:32:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209093211.GC14516@elte.hu>
References: <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <1102526018.25841.308.camel@localhost.localdomain> <32950.192.168.1.5.1102529664.squirrel@192.168.1.5> <1102532625.25841.327.camel@localhost.localdomain> <32788.192.168.1.5.1102541960.squirrel@192.168.1.5> <1102543904.25841.356.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102543904.25841.356.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2004-12-08 at 21:39 +0000, Rui Nuno Capela wrote:
> > 
> > Almost there, perhaps not...
> > 
> > It doesn't solve the problem completely, if not at all. What was kind of a
> > deterministic failure now seems probabilistic: the fault still occur on
> > unplugging the usb-storage stick, but not everytime as before.
> > 
> 
> OK, so I would say that this is part of a fix, but there are others.
> There are lots of changes done to the slab.c file by Ingo.  The change I
> made (and that is just a quick patch, it needs real work), was only in a
> place that was obvious that there could be problems. 
> 
> Are you running an SMP machine? If so, than the patch I gave you is
> definitely not enough. 

one of Rui's boxes is an SMP system - which would explain why the bug
goes from an 'always crash' to 'spurious crash'. (if Rui's laptop
triggers this problem too then there must be something else going on as
well.)

> Ingo really scares me with all the removing of local_irq_disables in
> the rt mode. I'm not sure exactly what is going on there, and why they
> can, or should be removed. Ingo?

it is done so that the SLAB code can be fully preempted too. The SLAB
code is of central importance to the -RT project, if it's not fully
preemptible then that has a ripple effect on other subsystems (timer,
signal code, file handling, etc.).

So while making it fully preemptible was quite challenging (==dangerous,
scary), i couldnt just keep the SLAB using raw spinlocks, due to the
locking dependencies. (nor did i have any true inner desire to keep it
non-preemptible - the point of PREEMPT_RT is to have everything
preemptible. I want to see how much preemption the Linux kernel can take
=B-) It has held up surprisingly well i have to say.)

to make the SLAB code fully preemptible, there were two main aspects
that i had to fix:

 1) irq context execution
 2) process preemption

in the -RT kernel all IRQ contexts execute in a separate process
context, so the SLAB code is never called from a true IRQ context -
hence problem #1 is solved. As far as #1 is concerned, the
local_irq_disable()s are not needed anymore.

the other aspect is process<->process preemption - which can still occur
in the -RT kernel (and is the whole point of the PREEMPT_RT feature). 
This means that the per-CPU assumptions within slab.c break.

To solve this i've turned the unlocked per-CPU SLAB code to be
controlled by the cachep->spinlock. (on RT only - on non-RT kernels the
SLAB code should be largely unmodified - this is why all that _rt and
_nort API trickery is done.) Since the SLAB code is thus locked by
cachep->spinlock on PREEMPT_RT, other tasks cannot interfere with the
internal data structures.

Finally, there was still the problem of the use of smp_processor_id() -
the non-RT SLAB code (rightfully) assumes that smp_processor_id() is
constant, but this is not true for the RT code - which can be preempted
anytime (still holding the spinlock of course) and can be migrated to
another CPU.

To solve this problem i am saving smp_processor_id() once, before we use
any per-CPU data structure for the first time, and this constant CPU ID
value is cached and used throughout the whole SLAB processing pass.

[ Since in the RT case we lock the cachep exclusively, it's not a
problem if the 'old' CPU's ID is used as an index - as long as the index
is consistent. Most of the time the current CPU's ID will be used so we
preserve most of the performance advantages (==cache-hotness) of per-CPU
SLABs on SMP systems too. (except for the locking, which is serialized
on RT.) ]

SLAB draining was an oversight - it's mainly called when there is VM
pressure (which is not a stricly necessary feature, so i disabled it),
but i forgot about the module-unload case where it's a correctness
feature. Your patch is a good starting point, i'll try to fix it on SMP
too.

	Ingo
