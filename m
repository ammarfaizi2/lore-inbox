Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbSJYXZY>; Fri, 25 Oct 2002 19:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSJYXZY>; Fri, 25 Oct 2002 19:25:24 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:40322 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261677AbSJYXZW>;
	Fri, 25 Oct 2002 19:25:22 -0400
Date: Fri, 25 Oct 2002 16:26:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Message-ID: <515310000.1035588399@flay>
In-Reply-To: <200210251015.46388.efocht@ess.nec.de>
References: <200210242351.56719.efocht@ess.nec.de> <2862423467.1035473915@[10.10.2.3]> <200210251015.46388.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're talking about one of the first 2.5 versions of the patch. It
> changed a lot since then, thanks to your feedback, too.

Right. But I've been struggling to boot anything later than that ;-)
 
> I thought this problem is well understood! For some reasons independent of
> my patch you have to boot your machines with the "notsc" option. This
> leaves the cache_decay_ticks variable initialized to zero which my patch
> doesn't like. I'm trying to deal with this inside the patch but there is
> still a small window when the variable is zero. In my opinion this needs
> to be fixed somewhere in arch/i386/kernel/smpboot.c. Booting a machine
> with cache_decay_ticks=0 is pure nonsense, as it switches off cache
> affinity which you absolutely need! So even if "notsc" is a legal option,
> it should be fixed such that it doesn't leave your machine without cache
> affinity. That would anyway give you a falsified behavior of the O(1)
> scheduler.

OK, well we seem to have it working on one machine, but not on another.
Those should be identical, I suspect it's a timing thing. I'm playing around
with the differences. First major thing I noticed is that the working box has
gcc 3.1, and the non-working gcc 2.95.4 (debian woody). I suspect it's
a subtle timing thing, or something equally horrible.

Changing the non-working box to gcc 3.1 instead (which I *really* don't
want to do long term unless we prove there's a bug in 2.95 ... gcc 3.x
is disgustingly slow) resulted in it getting a little further, but then got the 
following oops ... does this provide any clues?

CPU 7 IS NOW UP!
Starting migration thread for cpu 7
Bringing up 8
CPU 8 IS NOW UP!
Starting migration thread for cpu 8
divide error: 0000
 
CPU:    4
EIP:    0060:[<c011ac38>]    Not tainted
EFLAGS: 00010002
EIP is at task_to_steal+0x118/0x260
eax: 00000001   ebx: f01c5040   ecx: 00000000   edx: 00000000
esi: 00000063   edi: f01c5020   ebp: f0197ee8   esp: f0197eac
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=f0196000 task=f01bf060)
Stack: 00000000 f01b4120 00000000 c02ec940 f0197ed4 00000004 00000000 c02ecd3c 
       c02ec93c 00000000 00000001 0000007d c02ec4a0 00000001 00000004 f0197f1c 
       c011829c c02ec4a0 00000004 00000004 00000001 00000000 c39376c0 00000000 
Call Trace:
 [<c011829c>] load_balance+0x8c/0x140
 [<c0118588>] scheduler_tick+0x238/0x360
 [<c0123347>] tasklet_hi_action+0x77/0xc0
 [<c0105420>] default_idle+0x0/0x50
 [<c0126bd5>] update_process_times+0x45/0x60
 [<c0113faa>] smp_apic_timer_interrupt+0x11a/0x120
 [<c0105420>] default_idle+0x0/0x50
 [<c010815e>] apic_timer_interrupt+0x1a/0x20
 [<c0105420>] default_idle+0x0/0x50
 [<c0105420>] default_idle+0x0/0x50
 [<c010544a>] default_idle+0x2a/0x50
 [<c01054ea>] cpu_idle+0x3a/0x50
 [<c011db20>] printk+0x140/0x180

Code: f7 75 cc 8b 55 c8 83 f8 64 0f 4c f0 39 4d ec 8d 46 64 0f 44 

This is 2.5.44-mm4 + your patches 1,2,3,5, I think.

M.

