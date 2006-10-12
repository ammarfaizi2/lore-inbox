Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422820AbWJLI0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422820AbWJLI0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWJLI0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:26:35 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:5777 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422820AbWJLI0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:26:34 -0400
Subject: Re: [PATCH] lockdep: annotate i386 apm
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       sfr@canb.auug.org.au
In-Reply-To: <20061012080212.GA14307@elte.hu>
References: <1160574022.2006.82.camel@taijtu>
	 <20061011141813.79fb278f.akpm@osdl.org> <1160633180.2006.94.camel@taijtu>
	 <20061011233925.c9ba117a.akpm@osdl.org>  <20061012080212.GA14307@elte.hu>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 10:26:45 +0200
Message-Id: <1160641605.2006.113.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 10:02 +0200, Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > So, say interrupts were enabled when entering apm_bios_call*(); you now
> > > save that in flags, disable interrupts, and enable them again.
> > > Upon reaching local_irq_restore(), we'll hit the else branch with irq's
> > > enabled and call trace_hardirqs_on(), which goes EEEK!
> > 
> > I'd assumed lockdep was less stupid than that ;) This?  Seems a bit 
> > overdone..
> 
> the problem is not lockdep but that the BIOS enables IRQs behind the 
> back of the kernel. Lockdep needs to be taught about that - if this 
> happens unconditionally then i'd suggest to insert an unconditional 
> trace_hardirqs_on() call to after the local_irq_save() that we do prior 
> calling the BIOS. (that will be a NOP if lockdep is not enabled)

Well, its not quite like that, the irq mess in apm does an explicit
unbalanced irq action, and lockdep rightly triggers on that.
And adding to that comes the fact that we do indeed call a BIOS routine
which can do god knows what.

So we want to save irq state and force it into a known state; normally
it will only be disable - however in this case (when
apm_info.allow_ints) we force enable it. All end scope routines expect
irqs disabled.

logically it looks something like this

local_irq_save(flags)
local_irq_enable()
...
local_irq_disable() <--- missing
local_irq_restore(flags)

except that the first two statements are blended together to avoid the
unneeded disable.

The logic is sound because local_irq_restore will just set whatever was
saved, except lockdep gets confused by the unbalanced operations - a
good thing IMHO.

