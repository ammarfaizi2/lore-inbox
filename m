Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUJWQpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUJWQpn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUJWQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:45:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18349 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261236AbUJWQpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:45:10 -0400
Date: Sat, 23 Oct 2004 12:17:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041023141750.GA11369@logos.cnet>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com> <20041015182352.GA4937@logos.cnet> <1097980764.13226.21.camel@localhost.localdomain> <20041019143522.GA8688@logos.cnet> <1098297838.12366.4.camel@localhost.localdomain> <20041020232424.GH24619@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020232424.GH24619@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan, Andrea,

On Thu, Oct 21, 2004 at 01:24:24AM +0200, Andrea Arcangeli wrote:
> On Wed, Oct 20, 2004 at 07:43:58PM +0100, Alan Cox wrote:
> > On Maw, 2004-10-19 at 15:35, Marcelo Tosatti wrote:
> > > > That isnt sufficient. Consider anything else taking a reference to the
> > > > page and the refcount going negative. 
> > > 
> > > You mean not going negative? The problem here as I understand here is 
> > > we dont release the count if the PageReserved is set, but we should.
> > 
> > Drivers like the OSS audio drivers move page between Reserved and 
> > unreserved. The count can thus be corrupted.
> 
> the PG_reserved goes away after VM_IO, so forbidding pages with
> PG_reserved of vmas with VM_IO isn't any different as far as I can tell,
> and since PG_reserved is the real offender sure we shouldn't leave a
> check in get_user_pages that explicitly do something if the page is
> reserved, since if the page is reserved at that point we'd need to
> return -EFAULT or BUG_ON.
> 
> Adding the VM_IO patch on top of this is sure a good idea.
> 
> --- sles/mm/memory.c.~1~	2004-10-19 19:34:10.264335488 +0200
> +++ sles/mm/memory.c	2004-10-19 19:58:47.403776160 +0200
> @@ -806,7 +806,7 @@ int get_user_pages(struct task_struct *t
>  			}
>  			if (pages) {
>  				pages[i] = get_page_map(map);
> -				if (!pages[i]) {
> +				if (!pages[i] || PageReserved(pages[i])) {
>  					spin_unlock(&mm->page_table_lock);
>  					while (i--)
>  						page_cache_release(pages[i]);
> @@ -814,8 +814,7 @@ int get_user_pages(struct task_struct *t
>  					goto out;
>  				}
>  				flush_dcache_page(pages[i]);
> -				if (!PageReserved(pages[i]))
> -					page_cache_get(pages[i]);
> +				page_cache_get(pages[i]);
>  			}
>  			if (vmas)
>  				vmas[i] = vma;
> 
> My version of the fix for 2.4 is this, but this fixes as well an issue
> with the zeropage and it's on top of some other fix for COW corruption
> in 2.4 not yet fixed in mainline 2.4. Since 2.4 never checked
> PageReserved like 2.6 does in get_user_pages, 2.4 as worse can suffer a
> memleak.

I wonder what are the consequences and dangers of not referencing 
PG_reserved pages at get_user_pages(). I agree the current behaviour 
of referencing reserved pages and not unreferencing PageReserved at
free_pages is broken.

However, access_process_vm(), used by ptrace, map_user_kiobuf() and the 
elf core dumping code rely on the additional reference count 
increased by get_user_pages() to guarantee the existance of 
the page(s). What about that?

I need to understand PG_reserved usage by drivers in more details.

Sure the above patch would fix the problem reported
(including the elf core dump memory leak).

Now Alan's case of pages being changed from/to PG_reserved 
is pretty damn nasty isnt it (uncovered by this patch from
what I understand).

