Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSAQO56>; Thu, 17 Jan 2002 09:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288925AbSAQO5s>; Thu, 17 Jan 2002 09:57:48 -0500
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:17742
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288919AbSAQO5j>; Thu, 17 Jan 2002 09:57:39 -0500
Message-Id: <200201171457.g0HEvTB02011@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: mingo@elte.hu
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Problems with O(1) scheduler on non-x86 arch's 
In-Reply-To: Message from Ingo Molnar <mingo@elte.hu> 
   of "Thu, 17 Jan 2002 10:50:58 +0100." <Pine.LNX.4.33.0201171046480.2000-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Jan 2002 09:57:29 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu said:
> in the long term i think the correct approach would be to always store
> the logical CPU number in p->cpu. Architectures that have some strange
> physical numbering can always do a mapping themselves. This way we
> could remove tons of cpu-id conversions from the generic code. And we
> are always going to have these problems, now that the x86 SMP boot
> code renumbers physical CPU ids to match the logical order. 

I can see for something like the x86, where the apic id bears no relationship 
to where the CPU is and there's no support for hot CPU removal, this approach 
may be the correct one.  For Voyager, each CPU has an activity light. So, from 
the physical CPU number, I can tell what the processor is doing, thus it does 
make more sense for me to keep a physical number in p->cpu rather than using 
the logical one.  The voyager architecture is less constrained about ASMP as 
well (I currently run an 8 way box with 4x66MHz and 4x33MHz CPUs).  If I'm to 
use the process or interrupt affinity features, I really need to know 
physically which CPU I want.

Think about the problems logical numbering will cause for hot processor 
removal or failure (if we get around to implementing the feature).  If p->cpu 
is physical, all I have to do is remove the mapping and decrement 
smp_num_cpus, quiesce the processor and redistribute the run queue.  In a 
logically mapped system, I'm going to have to renumber p->cpu in at least one 
other CPUs runqueue as well since the logical mapping code assumes no gaps in 
the 0...smp_num_cpus-1 sequence.

> i've checked the architectures, and besides your architecture it
> appears that only Alpha does a non-identity ID conversion. So it would
> be much cleaner for the generic kernel if we stored the logical CPU id
> in p->cpu, and all SMP interfaces towards lowlevel SMP code used the
> logical CPU ID. 

Actually, the parisc SMP code (on cvs.parisc-linux.org) uses physical 
numbering and it looks to me like the sparc SMP code does as well.

James


