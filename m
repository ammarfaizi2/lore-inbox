Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTKZH1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 02:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTKZH1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 02:27:20 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:63437 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262324AbTKZH1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 02:27:18 -0500
Date: Tue, 25 Nov 2003 21:14:32 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>
cc: Jack Steiner <steiner@sgi.com>, Anton Blanchard <anton@samba.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <1590000.1069823671@[10.10.2.4]>
In-Reply-To: <20031126035953.GF8039@holomorphy.com>
References: <20031125231108.GA5675@sgi.com> <Pine.LNX.4.44.0311252238140.22777-100000@chimarrao.boston.redhat.com> <20031126035953.GF8039@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Speaking of which, no one's bothered fixing the X crashes on i386
> discontigmem. Untested patch below.
> 
> 
> -- wli
> 
> 
> diff -prauN linux-2.6.0-test10/include/asm-i386/mmzone.h pfn_valid-2.6.0-test10/include/asm-i386/mmzone.h
> --- linux-2.6.0-test10/include/asm-i386/mmzone.h	2003-11-23 17:31:56.000000000 -0800
> +++ pfn_valid-2.6.0-test10/include/asm-i386/mmzone.h	2003-11-25 19:54:31.000000000 -0800
> @@ -85,13 +85,19 @@ extern struct pglist_data *node_data[];
>  })
>  #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
>  /*
> - * pfn_valid should be made as fast as possible, and the current definition 
> - * is valid for machines that are NUMA, but still contiguous, which is what
> - * is currently supported. A more generalised, but slower definition would
> - * be something like this - mbligh:
> - * ( pfn_to_pgdat(pfn) && ((pfn) < node_end_pfn(pfn_to_nid(pfn))) ) 
> + * pfn_valid must absolutely be correct, regardless of speed concerns.
>   */ 
> -#define pfn_valid(pfn)          ((pfn) < num_physpages)
> +#define pfn_valid(pfn)							\
> +({									\
> +	unsigned long __pfn__ = pfn;					\
> +	u8 __nid__ = pfn_to_nid(__pfn__);				\
> +	pg_data_t *__pgdat__;						\
> +	__pgdat__ = __nid__ < MAX_NUMNODES ? NODE_DATA(__nid__) : NULL;	\
> +	__pgdat__ &&							\
> +		__pfn__ >= __pgdat__->node_start_pfn &&			\
> +		__pfn__ - __pgdat__->node_start_pfn			\
> +				< __pgdat__->node_spanned_pages;	\
> +})
>  
>  /*
>   * generic node memory support, the following assumptions apply:

Would it not be rather more readable as something along the lines of:

static inline int pfn_valid (int pfn) {
        int nid = pfn_to_nid(pfn);
        pg_data_t *pgdat;

        if (nid >= MAX_NUMNODES)
                return 0;		/* node invalid */
        pgdat = NODE_DATA(nid);
        if (!pgdat)
                return 0;		/* pgdat invalid */
        if (pfn < pgdat->node_start_pfn)
                return 0;		/* before start of node */
        if (pfn - pgdat->node_start_pfn >= pgdat->node_spanned_pages)
                return 0;		/* past end of node */
        return 1;
}

However, I'm curious as to why this crashes X, as I don't see how this
code change makes a difference in practice. I didn't think we had any i386
NUMA with memory holes between nodes at the moment, though perhaps the x440
does.

M.

PS. No, I haven't tested my rephrasing of your patch either.

