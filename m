Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264564AbRGIOoH>; Mon, 9 Jul 2001 10:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264924AbRGIOn5>; Mon, 9 Jul 2001 10:43:57 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:18573 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264564AbRGIOnt>; Mon, 9 Jul 2001 10:43:49 -0400
Message-ID: <3B49C300.185DFCA4@uow.edu.au>
Date: Tue, 10 Jul 2001 00:43:12 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: msync() bug
In-Reply-To: <20010709105044.A29658@crystal.2d3d.co.za> <3B49A44B.F5E3C6A7@uow.edu.au>,
		<3B49A44B.F5E3C6A7@uow.edu.au>; from andrewm@uow.edu.au on Mon, Jul 09, 2001 at 10:32:11PM +1000 <20010709162131.F1594@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Wrong fix, `page' is just garbage if some non memory was mapped in
> userspace (like framebuffers or similar mmio regions were mapped etc..).

Now we're getting somewhere.  Thanks.  Tell me if this is right:
 

> if (VALID_PAGE(page)

If the physical address of the page is somewhere inside our
working RAM.

> !PageReserved(page)

And it's not a reserved page (discontigmem?)

> ptep_test_and_clear_dirty(ptep))

And if it was modified via this mapping

> +                       flush_tlb_page(vma, address);
> +                       set_page_dirty(page);

Question:  What happens if a program mmap's a part of /dev/mem
which passes all of these tests?   Couldn't it then pick some
arbitrary member of mem_map[] which may or may not have
a non-zero ->mapping?
