Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVLaBOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVLaBOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVLaBOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:14:22 -0500
Received: from hera.kernel.org ([140.211.167.34]:25766 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932067AbVLaBOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:14:21 -0500
Date: Fri, 30 Dec 2005 23:13:24 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 1/9] clockpro-nonresident.patch
Message-ID: <20051231011324.GB4913@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet> <20051230224222.765.32499.sendpatchset@twins.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230224222.765.32499.sendpatchset@twins.localnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 11:42:44PM +0100, Peter Zijlstra wrote:
> 
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> Originally started by Rik van Riel, I heavily modified the code
> to suit my needs.
> 
> The nonresident code approximates a clock but sacrifices precision in order
> to accomplish faster lookups.
> 
> The actual datastructure is a hash of small clocks, so that, assuming an 
> equal distribution by the hash function, each clock has comparable order.
> 
> TODO:
>  - remove the ARC requirements.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

<snip>

> + *
> + *
> + * Modified to work with ARC like algorithms who:
> + *  - need to balance two FIFOs; |b1| + |b2| = c,
> + *
> + * The bucket contains four single linked cyclic lists (CLOCKS) and each
> + * clock has a tail hand. By selecting a victim clock upon insertion it
> + * is possible to balance them.
> + *
> + * The first two lists are used for B1/B2 and a third for a free slot list.
> + * The fourth list is unused.
> + *
> + * The slot looks like this:
> + * struct slot_t {
> + *         u32 cookie : 24; // LSB
> + *         u32 index  :  6;
> + *         u32 listid :  2;
> + * };

8 and 16 bit accesses are slower than 32 bit on i386 (Arjan pointed this out sometime ago).

Might be faster to load a full word and shape it as necessary, will see if I can do 
something instead of talking. ;)

> +/*
> + * For interactive workloads, we remember about as many non-resident pages
> + * as we have actual memory pages.  For server workloads with large inter-
> + * reference distances we could benefit from remembering more. 
> + */

This comment is bogus. Interactive or server loads have nothing to do
with the inter reference distance. To the contrary, interactive loads
have a higher chance to contain large inter reference distances, and
many common server loads have strong locality.

<snip>

> +++ linux-2.6-git/include/linux/swap.h
> @@ -152,6 +152,31 @@ extern void out_of_memory(gfp_t gfp_mask
>  /* linux/mm/memory.c */
>  extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
>  
> +/* linux/mm/nonresident.c */
> +#define NR_b1		0
> +#define NR_b2		1
> +#define NR_free		2
> +#define NR_lost		3

What is the meaning of "NR_lost" ? 

> +
> +#define NR_listid	3
> +#define NR_found	0x80000000
