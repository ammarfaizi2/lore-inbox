Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbSJCQTp>; Thu, 3 Oct 2002 12:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSJCQTp>; Thu, 3 Oct 2002 12:19:45 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:31678 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261336AbSJCQTn>; Thu, 3 Oct 2002 12:19:43 -0400
Date: Thu, 3 Oct 2002 12:25:10 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: virt_to_page(pci_alloc_consistent())
Message-ID: <20021003122509.B8147@devserv.devel.redhat.com>
References: <20021003023814.A5856@devserv.devel.redhat.com> <20021003.010344.123986131.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003.010344.123986131.davem@redhat.com>; from davem@redhat.com on Thu, Oct 03, 2002 at 01:03:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 03 Oct 2002 01:03:44 -0700 (PDT)
> From: "David S. Miller" <davem@redhat.com>

>    From: Pete Zaitcev <zaitcev@redhat.com>
>    Date: Thu, 3 Oct 2002 02:38:14 -0400
> 
>    I just noticed that sound drivers use the address from
>    pci_alloc_consistent() as the input to virt_to_page() all
>    over the place. I looked into the Documentation/DMA-mapping.txt,
>    and it says:
>    
>      This routine will allocate RAM for that region, so it acts similarly to
>      __get_free_pages (but takes size instead of a page order).
>    
>    I know for fact I got it wrong in sparc in whole 2.4, and it seems
>    RMK got it wrong in arm. I suggest other architecture maintainers
>    to look at it ASAP. May even be oopsabe, by indexing outside of
>    mem_map[] with a suitable sound driver.
> 
> I think we MUST allow architectures to do what SPARC and ARM
> do, there is simply no other way to change the page protections
> easily for these kinds of systems.

I can fix sparc, dunno about others. Do you have a problem
on sparc64? Are you using a huge page to map the kernel?

> So please instead change the DMA-mapping.txt documentation and
> propose pci_consistent_to_page(ptr) API additions.  Next, inform
> the subsytems trying to use virt_to_page() on this memory that
> they need to use the new interface.

It's hell on earth trying to find them without __pa barfing
on addresses outside of linear area. Don't you think it may
be time to add a BUG_ON there, at least for 2.5?

I also toyed with idea of __pa which walks page tables.
The problem now is that every Joe Driver Writer on the street
started to use pte_offset(pmd_offset(pgd_offset())), which they
duly copy from bttv. Of course, highmem or other changes break
that, because it was not an API meant to be exposed. We kinda
let Kraxel to do it because there was no other way for V4L.

The idea of some virtual addresses more equial than others is
extremely hard to impart into heads of driver writers, in my
expirience. At least we have to invent a new term for vmalloc
area, such as "logical" address, and make Corbet to fix THE BOOK.

-- Pete
