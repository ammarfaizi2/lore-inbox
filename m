Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSFNRbZ>; Fri, 14 Jun 2002 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSFNRbY>; Fri, 14 Jun 2002 13:31:24 -0400
Received: from [208.246.182.58] ([208.246.182.58]:62980 "EHLO inspiron.random")
	by vger.kernel.org with ESMTP id <S313060AbSFNRbX>;
	Fri, 14 Jun 2002 13:31:23 -0400
Date: Fri, 14 Jun 2002 12:31:33 -0500
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020614173133.GH2314@inspiron.paqnet.com>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com> <20020614032429.A19018@wotan.suse.de> <20020613213724.C21542@redhat.com> <20020614040025.GA2093@inspiron.birch.net> <20020614001726.D21542@redhat.com> <20020614062754.A11232@wotan.suse.de> <20020614112849.A22888@redhat.com> <20020614181328.A18643@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 06:13:28PM +0200, Andi Kleen wrote:
> +#ifdef CONFIG_HIGHMEM
> +	/* Hopefully not be mapped anywhere else. */
> +	if (page >= highmem_start_page) 
> +		return 0;
> +#endif

there's no hope here. If you don't want to code it right because nobody
is exercising such path and flush both any per-cpu kmap-atomic slot and
the page->virtual, please place a BUG() there or any more graceful
failure notification.

> +int change_page_attr(struct page *page, int numpages, pgprot_t prot)
> +{

this API not the best, again I would recommend something on these lines:

	struct page ** physical_alias_alloc_pages(int numpages, unsigned int gfp_mask);
	void physical_alias_free_pages(struct page **);

the semantics are trivial, agp_gart_alloc_pages() will return an array
of numpages entries (allocated with kmalloc), that points to all the
pages that are been prepared from the architectural call (of course
those two func are in arch/) for the generation of a physical alias.

This allows the arch to allocate the pages with order >0, this way the
number of fragmented 4/2m pages will be reduced.

The only requirement is that you know the number of pages that you're
going to allocate, if some doesn't we can add also this additional api:

	struct page * physical_alias_alloc_page(unsigned int gfp_mask);
	void physical_alias_free_pages(struct page *);

Andrea
