Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbRETCk6>; Sat, 19 May 2001 22:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbRETCks>; Sat, 19 May 2001 22:40:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:57912 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261387AbRETCkg>; Sat, 19 May 2001 22:40:36 -0400
Date: Sun, 20 May 2001 04:40:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010520044013.A18119@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010519231131.A2840@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Sat, May 19, 2001 at 11:11:31PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 11:11:31PM +0400, Ivan Kokshaysky wrote:
> On Sat, May 19, 2001 at 03:55:02PM +0200, Andrea Arcangeli wrote:
> > Reading the tsunami specs I learnt 1 tlb entry caches 8 pagetables (not 1)
> > so the tlb flush will be invalidate immediatly by any PCI DMA run after
> > the flush on any of the other 7 mappings cached in the same tlb entry.
> 
> I have neither tsunami docs nor the tsunami box to play with :-(
> so my guesses might be totally wrong...
> But -- assuming that tsunami is similar to cia/pyxis, that is incorrect.
> We're invalidating not the cached ptes, but the TLB tags, with all 4 (on
> pyxis, and 8 on tsunami, I guess) associated ptes. The reason why we

exactly.

> align new entries at 4*PAGE_SIZE on cia/pyxis is a hardware bug -- if cached
> pte is invalid, it doesn't cause TLB miss. I wouldn't be surprised at all if
> tsunami has the same bug; in this case your fix is urgently needed, of course.

It only depends on the specs if it has to be called a bug or a feature.

> BTW, look at Richard's code in core_cia.c/verify_tb_operation() for
> "valid tag invalid pte reload" test, it could be easily ported to tsunami.

I didn't checked very closely what this code is doing but it seems it's
not triggering any DMA transaction from a DMA bus master so it shouldn't
be able to trigger the race, and as far I can tell as soon as you do DMA
on an invalid pagetable cached in a tlb the machine will lock hard. So I
expect if you try to probe if you need the 8 alignment at runtime you
won't be able to finish the probe ;).

> > then I also enlarged the pci SG space to 1G beause runing out of entries
> > right now breaks the whole world:
> 
> It would just delay the painful death, I think ;-)

I _have_ to completly hide the painful death because as soon as I run
out of entries the machine crashes immedatly because lots of drivers
aren't checking for running out of ptes.

Fixing that is a brainer thing, it may need to partly redesign the
driver so you can take a fail path where you coulnd't previously, in
some place you may need to re-issue a softirq later to try again, in
others you must run_task_queue(&tq_disk) and sched_yield and try again
later (you have the guarantee those entries will return available so it
would be not deadlock prone to do that), in other places you can just
drop the skb.  Each driver has to be fixed in its right way. It seems
for a lot of cases people just replaced the virt_to_bus with the
pci_map_single and they didn't thought pci_map_single may even return
0 which _doesn't_ mean bus address 0 ;)

The reason it's not too bad to hide it is that you can usually calculate
an high bound of how many pci mappings a certain given machine may need
at the same time at runtime, so I can give you the guarantee that you
won't be able to reproduce any of that kind of driver bugs on a certain
given machine, this is the only point of the change, just to get this
guarantee on a larger subset of machines until all those bugs are fixed.

> I'm almost sure that all these "pci_map_sg failed" reports are caused
> by some buggy driver[s], which calls pci_map_xx() without proper
> pci_unmap_xx(). This is harmless on i386, and on alpha if all IO is going

I'm not talking about that kind of leak bug. The fact some driver is
leaking ptes is a completly different kind of bug.

I was only talking about when you get the "pci_map_sg failed" because
you have not 3 but 300 scsi disks connected to your system and you are
writing to all them at the same time allocating zillons of pte, and one
of your drivers (possibly not even a storage driver) is actually not
checking the reval of the pci_map_* functions. You don't need a pte
memleak to trigger it, even regardless of the fact I grown the dynamic
window to 1G which makes it 8 times harder to trigger than in mainline.

For now with a a couple of disks and a few nics and a 1G of dynamic
window size it doesn't trigger and the 1G thing gives a fairly large
margin for most machines out there. I cannot care less about the 2M-128k
memory wastage at this point in time, but as I said I wanted at least
to optimize the 2M pte arena allocation away completly if the machine
has less than 2G, that would be a very worthwhile optimization.

> I've got some debugging code checking for this (perhaps it worth
> posting or even porting to i386 ;-)
> For now I can confirm that all drivers I'm currently using are fine
> wrt pci_map/unmap:
> 3c59x, tulip, sym53c8xx, IDE.

all the drivers I'm using are definitely not leaking pte entries either,
but if you give me not 10 but 1000 scsi disks be sure I will trigger the
missing checks for pci_map_* retval without the need of any driver
leaking ptes.

The bug you are talking about is even worse and I never experienced it
myself, but I agree it's likely some driver has it too because it's not
reproducible on x86, so if you have the x86 debugging code that's
welcome so we will be able to reproduce it on a larger variety of
machines. thanks!

Andrea
