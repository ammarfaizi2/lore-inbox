Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWDGFi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWDGFi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 01:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDGFi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 01:38:56 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:27017 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932286AbWDGFiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 01:38:55 -0400
Date: Fri, 7 Apr 2006 14:40:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jbarnes@sgi.com, jes@trained-monkey.org,
       nickpiggin@yahoo.com.au, tony.luck@intel.com,
       mm-commits@vger.kernel.org
Subject: Re: + pg_uncached-is-ia64-only.patch added to -mm tree
Message-Id: <20060407144033.8e02ad64.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060406215242.245340de.akpm@osdl.org>
References: <200604070421.k374LXFs011197@shell0.pdx.osdl.net>
	<20060407134827.91a47e69.kamezawa.hiroyu@jp.fujitsu.com>
	<20060406215242.245340de.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006 21:52:42 -0700
Andrew Morton <akpm@osdl.org> wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> -#define FLAGS_RESERVED		32
> +#define FLAGS_RESERVED		24
>
  
Oh..we get more 8bits flags on 64bit machines !!!
but could you reserve 30bits now ?

This is my understanding..
==
At the first look, SPARSEMEM with ia64

#define SECTION_SIZE_BITS       (30)
#define MAX_PHYSMEM_BITS        (50)

so SECTIONS_SHIFT = 50 - 30 = 20bits.

20bits of page->flags is used for SPARSEMEM's section id.

sgi have NODES_SHIFT=8, and always ZONES_SHIFT=2 .

At worst, 20 + 8 + 2 = 30bits should be used. but..

extra code is here..
==
#if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT <= FLAGS_RESERVED
#define NODES_WIDTH             NODES_SHIFT
#else
#define NODES_WIDTH             0
#endif
==
So, node-id is not encoded into flags.
In this case, 
==
<snip>
#define FLAGS_HAS_NODE          (NODES_WIDTH > 0 || NODES_SHIFT == 0)

<snip>
static inline unsigned long page_to_nid(struct page *page)
{
        if (FLAGS_HAS_NODE)
                return (page->flags >> NODES_PGSHIFT) & NODES_MASK;
        else
                return page_zone(page)->zone_pgdat->node_id;
}
==
page_zone(page) looks up zone from zone_table[].
If FLAGS_HAS_NODE=0, zone_table indexing is this.
==

(page->flags >> (offset of zone bit)) & ((1 << (SECTIONS_SHIFT + ZONES_SHIFT)) - 1)

See above, SECTIONS_SHIFT + ZONES_SHIFT = 22bits.

so, many ia64 people has to use 32M(22bits * 8bytes) zone_table[] ???
please fix if I'm wrong ...this is complicated.

-Kame
