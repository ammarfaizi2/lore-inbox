Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRESTMg>; Sat, 19 May 2001 15:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbRESTM1>; Sat, 19 May 2001 15:12:27 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:45061 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261969AbRESTMV>; Sat, 19 May 2001 15:12:21 -0400
Date: Sat, 19 May 2001 23:11:31 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010519231131.A2840@jurassic.park.msu.ru>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010519155502.A16482@athlon.random>; from andrea@suse.de on Sat, May 19, 2001 at 03:55:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2001 at 03:55:02PM +0200, Andrea Arcangeli wrote:
> Reading the tsunami specs I learnt 1 tlb entry caches 8 pagetables (not 1)
> so the tlb flush will be invalidate immediatly by any PCI DMA run after
> the flush on any of the other 7 mappings cached in the same tlb entry.

I have neither tsunami docs nor the tsunami box to play with :-(
so my guesses might be totally wrong...
But -- assuming that tsunami is similar to cia/pyxis, that is incorrect.
We're invalidating not the cached ptes, but the TLB tags, with all 4 (on
pyxis, and 8 on tsunami, I guess) associated ptes. The reason why we
align new entries at 4*PAGE_SIZE on cia/pyxis is a hardware bug -- if cached
pte is invalid, it doesn't cause TLB miss. I wouldn't be surprised at all if
tsunami has the same bug; in this case your fix is urgently needed, of course.
BTW, look at Richard's code in core_cia.c/verify_tb_operation() for
"valid tag invalid pte reload" test, it could be easily ported to tsunami.

> then I also enlarged the pci SG space to 1G beause runing out of entries
> right now breaks the whole world:

It would just delay the painful death, I think ;-)
I'm almost sure that all these "pci_map_sg failed" reports are caused
by some buggy driver[s], which calls pci_map_xx() without proper
pci_unmap_xx(). This is harmless on i386, and on alpha if all IO is going
through direct-access windows.
I've got some debugging code checking for this (perhaps it worth
posting or even porting to i386 ;-)
For now I can confirm that all drivers I'm currently using are fine
wrt pci_map/unmap:
3c59x, tulip, sym53c8xx, IDE.

Ivan.
