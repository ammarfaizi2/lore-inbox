Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbRBGRY0>; Wed, 7 Feb 2001 12:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129315AbRBGRYQ>; Wed, 7 Feb 2001 12:24:16 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:15620 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129289AbRBGRYC>; Wed, 7 Feb 2001 12:24:02 -0500
Date: Wed, 7 Feb 2001 11:19:00 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207111900.E27089@vger.timpanogas.org>
In-Reply-To: <20010206190624.C23960@vger.timpanogas.org> <E14QQoH-0008CH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14QQoH-0008CH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 07, 2001 at 09:22:43AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 09:22:43AM +0000, Alan Cox wrote:
> > kernel on gcc 2.91, running SCI benchmarks, then compiling on RedHat 
> > 7.1 (Fischer) with gcc 2.96, the 2.96 build DROPPED 30% in throughput
> > from the gcc 2.91 compiled version on the identical SAME 2.4.1 
> > source tree. 
> 
> 30% is too big to be caused by a compiler. Way too big.I suggest you review
> your code.

I went back and looked at what was being generated.  for the sci copy testing,
the MTRR settings are changed to enable write combining, which causes the 
PCI bus to burst data whenever the SCI mapped page hits a cache line 
during copy operations -- speeds it up by 20-30% over DMA methods using 
the same adapters.  

I looked into this, and discovered that the gcc 2.96 compiler turned my 
rep movsd code into a rep movsb (???) with some evil looking C++ style 
jump table in the assembler code that jumped all over the place, which 
is what caused the performance test numbers to drop.  DMA numbers were 
the same on both kernels with the dma_test benchmark -- they were not 
with the sci_bench2 program.   

They deviated by 30%, indicating that my MTRR write combining optimization
was not working properly in sci copy mode.  

Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
