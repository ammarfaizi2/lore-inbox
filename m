Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752463AbWCQAfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbWCQAfY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbWCQAfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:35:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5506 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752459AbWCQAfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:35:23 -0500
Date: Thu, 16 Mar 2006 16:37:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, hch@lst.de, cotte@de.ibm.com,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
Message-Id: <20060316163728.06f49c00.akpm@osdl.org>
In-Reply-To: <yq0k6auuy5n.fsf@jaguar.mkp.net>
References: <yq0k6auuy5n.fsf@jaguar.mkp.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> wrote:
>
> Hi,
> 
> This is an updated version of the mspec driver (special memory
> support), formerly known as fetchop.
> 
> With this version I have implemented a do_no_pfn() handler, similar to
> the do_no_page() handler but for pages which are not backed by a
> struct page.

hm.  Is that a superset of ->nopage?  Should we be looking at
migrating over to ->nopfn, retire ->nopage?

<looks at the ghastly stuff in do_no_page>

Maybe not...

> This avoids the trick used in earlier versions where the
> driver was allocating a dumy page returning it back to the
> do_no_page() handler which would the free it immediately. Hopefully
> this addresses the main concern there were with this driver in the
> past.
> 
> The reason for taking the do_no_pfn() approch rather than
> remap_pfn_range() is that it needs to benefit from node locality of
> the pages on NUMA systems.
> 
> While the driver is currently only used on SN2 hardware, it is placed
> in drivers/char as it should be possible and beneficial for other
> architectures to implement and use the uncached mode.
> 
> Please let me know if there are any objections or comments etc. to
> this approach. If preferred I can split out the do_no_pfn part into a
> seperate patch.

That would probably be best.

> +#include <linux/config.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/miscdevice.h>
> +#include <linux/spinlock.h>
> +#include <linux/mm.h>
> +#include <linux/proc_fs.h>
> +#include <linux/vmalloc.h>
> +#include <linux/bitops.h>
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include <linux/seq_file.h>
> +#include <linux/efi.h>
> +#include <linux/numa.h>
> +#include <asm/page.h>
> +#include <asm/pal.h>
> +#include <asm/system.h>
> +#include <asm/pgtable.h>
> +#include <asm/atomic.h>
> +#include <asm/tlbflush.h>
> +#include <asm/uncached.h>
> +#include <asm/sn/addrs.h>
> +#include <asm/sn/arch.h>
> +#include <asm/sn/mspec.h>
> +#include <asm/sn/sn_cpuid.h>
> +#include <asm/sn/io.h>
> +#include <asm/sn/bte.h>
> +#include <asm/sn/shubio.h>

Wow.

> +static inline int
> +mspec_zero_block(unsigned long addr, int len)
> +{
> +	int status;
> +
> +	if (ia64_platform_is("sn2")) {

ia64 uses strcmp() in hotpaths to work out what sort of platform it's
running on?  Surely someone has cached this info in a __read_mostly integer
somewhere?

> +static __inline__ pmd_t *

`inline', please.

> +mspec_get_pmd(struct mm_struct *mm, u64 address)

This function has no callers.

> +static int __init
> +mspec_init(void)
> +{
> +	int ret;
> +	int nid;
> +
> +	/*
> +	 * The fetchop device only works on SN2 hardware, uncached and cached
> +	 * memory drivers should both be valid on all ia64 hardware
> +	 */
> +	if (ia64_platform_is("sn2")) {
> +		if (is_shub2()) {
> +			ret = -ENOMEM;
> +			for_each_online_node(nid) {
> +				int actual_nid;
> +
> +				scratch_page[nid] = uncached_alloc_page(nid);
> +				if (scratch_page[nid] == 0)
> +					goto free_scratch_pages;
> +				actual_nid = nasid_to_cnodeid(get_node_number(__pa(scratch_page[nid])));
> +				if (actual_nid != nid)
> +					goto free_scratch_pages;
> +			}
> +		}
> +
> +		ret = misc_register(&fetchop_miscdev);
> +		if (ret) {
> +			printk(KERN_ERR
> +			       "%s: failed to register device %i\n",
> +			       FETCHOP_ID, ret);
> +			goto free_scratch_pages;
> +		}
> +	}
> +	ret = misc_register(&cached_miscdev);
> +	if (ret) {
> +		printk(KERN_ERR "%s: failed to register device %i\n",
> +		       CACHED_ID, ret);
> +		misc_deregister(&fetchop_miscdev);

You don't know that fetchop_miscdev was registered.


