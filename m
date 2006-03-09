Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWCIMCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWCIMCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWCIMCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:02:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751876AbWCIMCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:02:52 -0500
Date: Thu, 9 Mar 2006 04:00:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH: 004/017](RFC) Memory hotplug for new nodes v.3.
 (generic alloc pgdat)
Message-Id: <20060309040045.17dbf286.akpm@osdl.org>
In-Reply-To: <20060308212719.002A.Y-GOTO@jp.fujitsu.com>
References: <20060308212719.002A.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yasunori Goto <y-goto@jp.fujitsu.com> wrote:
>
> For node hotplug, basically we have to allocate new pgdat.
> But, there are several types of implementations of pgdat.
> 
> 1. Allocate only pgdat.
>    This style allocate only pgdat area.
>    And its address is recorded in node_data[].
>    It is most popular style.
> 
> 2. Static array of pgdat
>    In this case, all of pgdats are static array.
>    Some archs use this style.
> 
> 3. Allocate not only pgdat, but also per node data.
>    To increase performance, each node has copy of some data as
>    a per node data. So, this area must be allocated too.
> 
>    Ia64 is this style. Ia64 has the copies of node_data[] array
>    on each per node data to increase performance.
> 
> In this series of patches, treat (1) as generic arch.
> 
> generic archs can use generic function. (2) and (3) should have
> its own if necessary. 
> 
> This patch defines pgdat allocator.
> Updating NODE_DATA() macro function is in other patch.
> 
> ( I'll post another patch for (3).
>   I don't know (2) which can use memory hotplug.
>   So, there is not patch for (2). )
> 
> ...
>
> +#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
> +/*
> + * For supporint node-hotadd, we have to allocate new pgdat.
> + *
> + * If an arch have generic style NODE_DATA(),
> + * node_data[nid] = kzalloc() works well . But it depends on each arch.
> + *
> + * In general, generic_alloc_nodedata() is used.
> + * generic...is a local function in mm/memory_hotplug.c
> + *
> + * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
> + *
> + */
> +extern struct pglist_data * arch_alloc_nodedata(int nid);
> +extern void arch_free_nodedata(pg_data_t *pgdat);
> +
> +#else /* !CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
> +#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
> +#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
> +
> +#ifdef CONFIG_NUMA
> +/*
> + * If ARCH_HAS_NODEDATA_EXTENSION=n, this func is used to allocate pgdat.
> + */
> +static inline struct pglist_data *generic_alloc_nodedata(int nid)
> +{
> +	return kzalloc(sizeof(struct pglist_data), GFP_ATOMIC);
> +}

>From an interface design point of view it's usually best to pass the
gfp_flags ito a function which performs memory allocation, rather than
assuming the worst-case like this.

If it's known that callers of generic_alloc_nodedata() can just never ever
be permitted to sleep then OK.  But GFP_KERNEL allocations are always
preferable.

> +/*
> + * This definition is just for error path in node hotadd.
> + * For node hotremove, we have to replace this.
> + */
> +static inline void generic_free_nodedata(struct pglist_data *pgdat)
> +{
> +	kfree(pgdat);
> +}
> +
> +#else /* !CONFIG_NUMA */
> +/* never called */
> +static inline struct pglist_data *generic_alloc_nodedata(int nid)
> +{
> +	BUG();
> +	return NULL;
> +}
> +static inline void generic_free_nodedata(struct pglist_data *pgdat)
> +{
> +}
> +#endif /* CONFIG_NUMA */
> +#endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
> +

Should the patch provide stubs for generic_alloc_nodedata() and
generic_alloc_nodedata() if !CONFIG_HAVE_ARCH_NODEDATA_EXTENSION?

(If all callers are also inside #ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
then the answer would be "no").

