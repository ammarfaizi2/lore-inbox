Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267808AbRGRCvM>; Tue, 17 Jul 2001 22:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbRGRCux>; Tue, 17 Jul 2001 22:50:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20237 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267808AbRGRCut>; Tue, 17 Jul 2001 22:50:49 -0400
Date: Tue, 17 Jul 2001 22:19:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.33.0107171904250.1181-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107172137190.7949-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Jul 2001, Linus Torvalds wrote:

> 
> On Tue, 17 Jul 2001, Marcelo Tosatti wrote:
> >
> > This fixes most of the highmem problems (I'm not able to deadlock a 4GB
> > machine running memory-intensive programs with the patch anymore. I've
> > also received one success report from Dirk Wetter running two 2GB
> > simulations on a 4GB machine).
> 
> Do you have any really compelling reasons for adding the zone parameter to
> swap-out?

Avoid the page-faults and unecessary swap space allocation.

> At worst, we get a few more page-faults (not IO). 

Don't think its just a "few more" depending on the setup... I've seen
"__get_swap_page()" using 99%CPU time of the system due to DMA specific
inactive shortage while the kernel was aging/unmapping pte's pointing to
normal/highmem pages during quite some time. As soon as the DMA inactive
shortage is gone, the problem goes away.

That is the main reason why I did zone specific pte scanning.

> At best, NOT doing this should generate a more complete picture of the
> VM state.

Indeed. Thats the price we have to pay...

> I'd really prefer the VM scanning to not be zone-aware..

Right, but think about small/big zones on the same machine. 

If we have a _specific_ inactive shortage on the DMA zone on a highmem
machine with shitloads of memory, its not worth to potentially unmap
all pte's pointing to all high/normal memory.

Practical example: 4GB machine, running two "fillmem" (2GB each).

The following stats are for DMA specific "swap_out()" calls. 

vm_pteskipzone 2534665 <-- Number of pte's skipped because they pointed to
non-DMA zones.
vm_ptescan 13984  <-- Number of pte's pointing to DMA pages scanned. 
vm_pteunmap 6320  <-- From "vm_ptescan", how many pte's have been
succesfully unmapped.

Now imagine that on a 16GB machine. Its a big storm of unecessary
softfaults/swap space allocation.

Its a tradeoff: I think the unecessary pte unmap's are a bigger problem
than the "not complete picture" of the VM state.



