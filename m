Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbTCHQ2S>; Sat, 8 Mar 2003 11:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbTCHQ2S>; Sat, 8 Mar 2003 11:28:18 -0500
Received: from holomorphy.com ([66.224.33.161]:49069 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262074AbTCHQ2Q>;
	Sat, 8 Mar 2003 11:28:16 -0500
Date: Sat, 8 Mar 2003 08:38:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 6/6 cacheline align files_lock
Message-ID: <20030308163824.GB20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <52550000.1047080176@flay> <20030308073535.B24272@infradead.org> <393020000.1047138100@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393020000.1047138100@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 07:41:42AM -0800, Martin J. Bligh wrote:
> Ironically, the latest scheduler changes *seem* to get rid of about
> 57% of the cost of it .... I have *no* idea why. Diffprofile between
> 64 and 64-bk is just wierd:
>       7222    45.1% page_remove_rmap
>        521    18.4% __copy_from_user_ll
>        422     8.9% __copy_to_user_ll
>        334   105.4% __wake_up
>        248    48.5% pte_alloc_one
>        243   205.9% pgd_ctor
>        211     4.6% vm_enough_memory
>        198     6.3% zap_pte_range
>        179    29.3% kmem_cache_free
>        118    12.2% clear_page_tables
>         99    13.2% __pte_chain_free
>         84     6.1% do_no_page
>         76     6.6% release_pages
>         74     9.0% strnlen_user
>         67     5.6% free_hot_cold_page
>         65    14.4% copy_page_range

The high count for pgd_ctor() is bizarre. It fiddles with less data and
should be called less often than pmd_ctor() or pte_alloc_one(), both of
which take the cache hit for constructing full pages, and pgd_ctor()
can't really hope to do better. This otherwise appears to be in order
of cacheline bounciness. DCU_MISS_OUTSTANDING and IFU_MEM_STALL?

page_remove_rmap() as usual takes top position b/c of its long list
walks; I think you've got something brewing for that already.


-- wli
