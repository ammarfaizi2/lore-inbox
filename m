Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSIIEya>; Mon, 9 Sep 2002 00:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSIIEya>; Mon, 9 Sep 2002 00:54:30 -0400
Received: from dsl-213-023-043-054.arcor-ip.net ([213.23.43.54]:30908 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316430AbSIIEy3>;
	Mon, 9 Sep 2002 00:54:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: Calculating kernel logical address ..
Date: Sun, 8 Sep 2002 20:44:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: imran.badr@cavium.com, linux-kernel@vger.kernel.org
References: <00d301c25556$4290f5e0$9e10a8c0@IMRANPC> <E17nUee-0006Lc-00@starship> <20020907.170151.84915731.davem@redhat.com>
In-Reply-To: <20020907.170151.84915731.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oGD2-0006lP-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 September 2002 02:01, David S. Miller wrote:
>    From: Daniel Phillips <phillips@arcor.de>
>    Date: Sat, 7 Sep 2002 03:44:53 +0200
>    
>    It looks good to me.  Note that somebody has added some new voodoo in 2.5
>    so that page table pages can be in highmem, with the result that the above
>    code won't work in 2.5, whether or not highmem is configured.
> 
> The example given won't work for kernel text/data addresses on a few
> platforms (sparc64 is one).  And in fact on MIPS the KSEG0 pages lack
> any page tables.
> 
> There are only three things one can portably obtain a physical address
> of:
> 
> 1) A user address, for a known MM
> 
> 2) a kmalloc/get_free_page kernel page
> 
> 3) A vmalloc page

Actually, he was trying to obtain a kernel virtual address, which
presents its own difficulties, particularly with respect to highmem.

> For anything else you're in non-portablt land, including and
> in partiular:
> 
> 1) kernel stack addresses

Could you elaborate on what bad things happen here?

> 2) addresses within the main kernel image text/data/bss

Yep.  MIPS's KSEG0 (a stupid design if there ever was one) and i386 large
kernel image pages are just two examples of wrinkles that would need to
be handled.  The general principle is: mappings in the kernel's virtual
address space are not maintained by the faulting mechanism, they are
maintained 'by hand'; and the cross-platform N-level page tree is defined
only for addresses that can fault.

Where the page tree does define a mapping to physical memory, obviously
only a physical address may be obtained that way, and due to highmem,
this address may not be mapped into the kernel's virtual address range,
in which case a further kmapping step has to be performed to obtain a
kernel-usable address, subject to bizarre rules that tend to change on
a weekly basis.

Somebody needs to write a book about this ;-)

-- 
Daniel
