Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266784AbUBGFCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 00:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUBGFCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 00:02:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:39116 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266784AbUBGFCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 00:02:21 -0500
Date: Fri, 6 Feb 2004 21:04:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Manfreds patch to distribute boot allocations across nodes
Message-Id: <20040206210428.17ee63db.akpm@osdl.org>
In-Reply-To: <20040207042559.GP19011@krispykreme>
References: <20040207042559.GP19011@krispykreme>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> Manfred had a patch to distribute kmallocs across nodes during boot.

He's a handy guy.

> ...
> 
> Change in free memory due to patch:
> 
> Node 7 -54.08 MB
> Node 6  -6.33 MB
> Node 5  -6.09 MB
> Node 4  -6.14 MB
> Node 3 -22.15 MB
> Node 2  -6.05 MB
> Node 1  -6.12 MB
> Node 0 107.35 MB

OK.

> +#ifdef CONFIG_NUMA

Is this a thing which all NUMA machines want to be doing?

> +static __init unsigned long get_boot_pages(unsigned int gfp_mask, unsigned int order)
> +{
> +static int nodenr;
> +	int i = nodenr;
> +	struct page *page;
> +
> +	for (;;) {
> +		if (i > nodenr + numnodes)
> +			return 0;
> +		if (node_present_pages(i%numnodes)) {
> +			struct zone **z;
> +			/* The node contains memory. Check that there is 
> +			 * memory in the intended zonelist.
> +			 */
> +			z = NODE_DATA(i%numnodes)->node_zonelists[gfp_mask & GFP_ZONEMASK].zones;
> +			while (*z) {
> +				if ( (*z)->free_pages > (1UL<<order))
> +					goto found_node;
> +				z++;
> +			}
> +		}
> +		i++;
> +	}
> +found_node:
> +	nodenr = i+1;
> +	page = alloc_pages_node(i%numnodes, gfp_mask, order);
> +	if (!page)
> +		return 0;
> +	return (unsigned long) page_address(page);
> +}
> +#endif

Should this not search for the emptiest node?

> @@ -688,6 +724,10 @@
>  {
>  	struct page * page;
>  
> +#ifdef CONFIG_NUMA
> +	if (unlikely(!system_running))
> +		return get_boot_pages(gfp_mask, order);
> +#endif

Is non-__init code allowed to call __init code?  I thought that caused
linkage errors on some setups.  Pretty sure about that.  I think, maybe.
