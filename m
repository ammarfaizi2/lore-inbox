Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSG3MIW>; Tue, 30 Jul 2002 08:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318241AbSG3MIW>; Tue, 30 Jul 2002 08:08:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44816 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318240AbSG3MIV>; Tue, 30 Jul 2002 08:08:21 -0400
Date: Tue, 30 Jul 2002 13:11:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@zip.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: page table page->index
Message-ID: <20020730131142.A6809@flint.arm.linux.org.uk>
References: <15684.52231.710183.242098@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15684.52231.710183.242098@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Jul 29, 2002 at 03:00:55PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 03:00:55PM +1000, Paul Mackerras wrote:
> Is this a problem in practice?  On i386, ppc, and the 64-bit
> architectures it isn't since user addresses can't go anywhere near
> ~0UL, but what about arm or m68k for instance?

Ok, let me provide a description of the virtual address space we have for
Linux on ARM CPUs:

 +----------------------+ <=== 4GB
 | "remapped" stuff [2] |
 +----------------------+ <=== 4GB - 64K
 |  static mapped MMIO  |
 +----------------------+ <=== (sub-architecture defined limit [3])
 |       ioremap,       |
 |       modules,       |
 | pci_alloc_consistent |
 |         heap         |
 +----------------------+
 | kernel direct mapped |
 |     ram & kernel     |
 +----------------------+ <=== (normally 3GB, may be as low as 1GB)
 |                      |
 /         User         /
 /                      /
 |                      |
 +----------------------+ <=== 4K
 |   CPU vectors [1]    |
 +----------------------+ <=== 0K

[1] CPU vectors are fixed at virtual address 0 on many CPUs.  However,
    later CPUs support an alternative virtual address of 4GB-64K

[2] This area is split into two areas; the top 32K is available for
    CPU implementation specific optimisations (eg, remapping pages
    for copy_user_page, clear_user_page).  The lower 32K is for
    alternate CPU vectors, and "generic" ARM kernel use (maybe
    remapping page tables for uncached access.)

[3] This is normally around 3.5GB or 3.75GB.

As far as Linux 2.5 is concerned, a pgd entry maps 2MB (the hardware
PGD maps 1MB, but to make rmap and 2nd level page table stuff simple,
we group two hardware pgd entries together to make one Linux pgd entry.)

So, to answer your question, remap_page_range shouldn't go anywhere
near the top-most PGD entry, so wrap around shouldn't be a problem
on ARM.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

