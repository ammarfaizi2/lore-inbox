Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbTHUPct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbTHUPct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:32:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10643
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262749AbTHUPcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:32:47 -0400
Date: Thu, 21 Aug 2003 17:33:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Hannes.Reinecke@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: BKL on reboot ?
Message-ID: <20030821153359.GD29612@dualathlon.random>
References: <3F434BD1.9050704@suse.de> <20030820112918.0f7ce4fe.akpm@osdl.org> <20030820113520.281fe8bb.davem@redhat.com> <1061411024.9371.33.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061411024.9371.33.camel@nighthawk>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 01:23:44PM -0700, Dave Hansen wrote:
> On Wed, 2003-08-20 at 11:35, David S. Miller wrote:
> > On Wed, 20 Aug 2003 11:29:18 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > > Where exactly does the rebooting CPU get stuck in machine_restart()?  If
> > > someone has done lock_kernel() with local interrupts disabled then yes,
> > > it'll deadlock.  But that's unlikely?  Confused.
> 
> I thought it was legal to do that.  The normal interrupts-off spinlock
> deadlock happens because a thread does a spin_lock() with no irq
> disable, then gets interrupted.  The interrupt handler tries to take the
> lock, and gets stuck.  

that's the regular spinlock case but it has nothing to do with the big
kernel lock during smp_call_function. holding the big kernel lock while
broadcasting the IPI with smp_call_function is perfectly legal. Infact
if something it's safer (and it can't explain any deadlock), and since
it's a so low performance path, where scalability doesn't matter,
leaving the BKL around that code can be acceptable.

The only illegal thing is to call smp_call_function with _local_irqs_
disabled (as Andrew noted above). the big kernel lock doesn't matter for
the smp_call_function callers.

> If the BKL is put in that situation, the interrupt handler will see
> current->lock_depth > 0, and not actually take the spinlock; it will
> just increment the lock_depth.  It won't deadlock.
> 
> Or, are you saying that a CPU could have the BKL, and have
> stop_this_cpu() called on it?  I guess we could add
> release_kernel_lock() to stop_this_cpu().

the *real* bug IMHO is that machine_restart isn't shutting down the
other cpus properly in smp, it has nothing to do with lock_kernel in
kernel/, the bug is in arch/. Dropping the big kernel lock in kernel/
can hide the bug, but it will showup again later in any other spinlock.

The problem is that machine_restart in arch/s390 (and arch/i386 too) can
easily hang a cpu in the IPI handler while it had zillon of spinlocks
held, that may later interfere with the main "reboot" cpu.

So at the very least a better fix than the one that drops the big kernel
lock from kernel/ is to execute current->lock_depth = -1 before entering
the infinite loop in the arch/ code.

A real fix would be to use the unplug cpu framework to allow all cpus to
reach the quiescent point, in this case it's easily doable even w/o
using RCU and w/o the pluggable cpu framework in 2.4, by simply spawning
a kernel thread bind to interesting cpu, and having this kernel thread
setting the bitflag after it become runnable (cut and pasting the
spawn_ksoftirqd will do the trick). The kernel thread will only execute
the infinite loop then. Hanging a cpu forever in a IPI is simply
deadlock prone for all other cpus, and that's the real bug.

Andrea
