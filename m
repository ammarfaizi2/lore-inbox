Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTJTFbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 01:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbTJTFbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 01:31:46 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38889
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262282AbTJTFbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 01:31:43 -0400
Date: Mon, 20 Oct 2003 07:32:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.23-pre7 vmscan.c typo
Message-ID: <20031020053229.GC1906@velociraptor.random>
References: <20031020014025.42111.qmail@web12812.mail.yahoo.com> <20031019220005.129e5358.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019220005.129e5358.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 10:00:05PM -0700, Andrew Morton wrote:
> Shantanu Goel <sgoel01@yahoo.com> wrote:
> >
> > The following appears to be a typo in mm/vmscan.c
> > 
> 
> It sure is.  Scary.

indeed, great spotting.

> 
> --- a/mm/vmscan.c	2003-10-19 21:36:26.000000000 -0400
> +++ a/mm/vmscan.c	2003-10-19 21:37:17.000000000 -0400
> @@ -596,7 +596,7 @@
>  			continue;
>  		}
>  
> -		nr_pages--;
> +		ratio--;
>  
>  		del_page_from_active_list(page);
>  		add_page_to_inactive_list(page);
> 
> 
> 
> I note that `ratio' here is the number of pages which we try to deactivate
> rather than the number of pages which we scan.  Is this intentional?

yes, it's intentional, this ensures we refile a number of pages and that
we don't only roll the list, it won't loop forever since at the second
pass the referenced bit will be clear.

BTW, the above obviously correct patch was apparently due an half merge
error too, this is what my 2.4.22aa1 or alternatively 2.4.23pre6aa3
looks like in this area. This gets right the highmem case too, so that
we ensure to refile normal zone if the user is GFP_KERNEL and we don't
deactivate highmem unless it's worthwhile, and it has the bh-related
knwoledge, so over time it'd be better to merge these bits too.

thanks,

static void refill_inactive(int nr_pages, zone_t * classzone)
{
	struct list_head * entry;
	unsigned long ratio;

	ratio = (unsigned long) nr_pages * classzone->nr_active_pages / (((unsigned long) classzone->nr_inactive_pages * vm_lru_balance_ratio) + 1);

	entry = active_list.prev;
	while (ratio && entry != &active_list) {
		struct page * page;
		int related_metadata = 0;

		page = list_entry(entry, struct page, lru);
		entry = entry->prev;

		if (!memclass(page_zone(page), classzone)) {
			/*
			 * Hack to address an issue found by Rik. The problem is that
			 * highmem pages can hold buffer headers allocated
			 * from the slab on lowmem, and so if we are working
			 * on the NORMAL classzone here, it is correct not to
			 * try to free the highmem pages themself (that would be useless)
			 * but we must make sure to drop any lowmem metadata related to those
			 * highmem pages.
			 */
			if (page->buffers && page->mapping) { /* fast path racy check */
				if (unlikely(TryLockPage(page)))
					continue;
				if (page->buffers && page->mapping && memclass_related_bhs(page, classzone)) /* non racy check */
					related_metadata = 1;
				UnlockPage(page);
			}
			if (!related_metadata)
				continue;
		}

		if (PageTestandClearReferenced(page)) {
			list_del(&page->lru);
			list_add(&page->lru, &active_list);
			continue;
		}

		if (!related_metadata)
			ratio--;

		del_page_from_active_list(page);
		add_page_to_inactive_list(page);
		SetPageReferenced(page);
	}
	if (entry != &active_list) {
		list_del(&active_list);
		list_add(&active_list, entry);
	}
}

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
