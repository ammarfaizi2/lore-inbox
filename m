Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131560AbRAQKPt>; Wed, 17 Jan 2001 05:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132816AbRAQKPn>; Wed, 17 Jan 2001 05:15:43 -0500
Received: from slc70.modem.xmission.com ([166.70.9.70]:55309 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132782AbRAQKPc>; Wed, 17 Jan 2001 05:15:32 -0500
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org,
        linux-mm@frodo.biederman.org
Subject: Re: Caches, page coloring, virtual indexed caches, and more
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org> <20010115235340.B31461@linuxcare.com> <m1itnfg7rk.fsf@frodo.biederman.org> <20010117154301.B7525@linuxcare.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Jan 2001 01:35:56 -0700
In-Reply-To: Anton Blanchard's message of "Wed, 17 Jan 2001 15:43:01 +1100"
Message-ID: <m1ae8qfudv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@linuxcare.com.au> writes:

> Hi,
>  
> > Where do you do this?  And how do you handle the case of aliases with kseg,
> > the giant kernel mapping.
> 
> Aliases between user and kernel mappings of a page are handled by
> flush_page_to_ram the old interface) or {copy,clear}_user_page,
> flush_dcache_page and update_mmu_cache (new interface). Sparc64 already
> uses the new interface and there are patches for ppc and ia64 to use it.
> 
> The new interface allows flushes to be avoided, leading to rather nice
> performance increases.
> 
> See Documentation/cachetlb.txt for more info.

Thanks,

Well they are a step in the right direction....
But they are still racy, especially on SMP.

The bad case is:
Process A in kernel space calls flush_dcache_page.
Then process B in a separate thread writes to the first word in a
cache line. The Process A writes to the last word in the cache line. 

Assuming the virtual addresses from Process A and Process B are of a
different color this gives two non overlapping writes with a well
defined meaning, which the kernel gets wrong.  In particular the ram
will only see one write or the other not both.

What it looks like to me is that SHMLBA needs to be extended to normal
mmapings, making all pages in user space
(page->index << PAGE_SHIFT) % SHMLBA 
virtually aligned.

And whenever we access a page in the page cache that is not
appropriately virtually aligned in the fixed kernel mapping, 
we can use the kmap infrastructure to map it to a better kernel
location.  If we reuse the same optimizations from flush_dcache_page
it shouldn't be any worse, and in the pathological cases it will be
faster.   While removing the races seen above.

Any thoughts?

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
