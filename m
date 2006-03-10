Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWCJIEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWCJIEv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWCJIEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:04:51 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:15337 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932376AbWCJIEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:04:49 -0500
Date: Fri, 10 Mar 2006 17:04:45 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH: 004/017](RFC) Memory hotplug for new nodes v.3. (generic alloc pgdat)
Cc: tony.luck@intel.com, ak@suse.de, jschopp@austin.ibm.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20060309040045.17dbf286.akpm@osdl.org>
References: <20060308212719.002A.Y-GOTO@jp.fujitsu.com> <20060309040045.17dbf286.akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060310161339.CA7B.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
> > +/*
> > + * For supporint node-hotadd, we have to allocate new pgdat.
> > + *
> > + * If an arch have generic style NODE_DATA(),
> > + * node_data[nid] = kzalloc() works well . But it depends on each arch.
> > + *
> > + * In general, generic_alloc_nodedata() is used.
> > + * generic...is a local function in mm/memory_hotplug.c
> > + *
> > + * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
> > + *
> > + */
> > +extern struct pglist_data * arch_alloc_nodedata(int nid);
> > +extern void arch_free_nodedata(pg_data_t *pgdat);
> > +
> > +#else /* !CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
> > +#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
> > +#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
> > +
> > +#ifdef CONFIG_NUMA
> > +/*
> > + * If ARCH_HAS_NODEDATA_EXTENSION=n, this func is used to allocate pgdat.
> > + */
> > +static inline struct pglist_data *generic_alloc_nodedata(int nid)
> > +{
> > +	return kzalloc(sizeof(struct pglist_data), GFP_ATOMIC);
> > +}
> 
> >From an interface design point of view it's usually best to pass the
> gfp_flags ito a function which performs memory allocation, rather than
> assuming the worst-case like this.
> 
> If it's known that callers of generic_alloc_nodedata() can just never ever
> be permitted to sleep then OK.  But GFP_KERNEL allocations are always
> preferable.

Ok. I'll change GFP_KERNEL for it.

> > +/*
> > + * This definition is just for error path in node hotadd.
> > + * For node hotremove, we have to replace this.
> > + */
> > +static inline void generic_free_nodedata(struct pglist_data *pgdat)
> > +{
> > +	kfree(pgdat);
> > +}
> > +
> > +#else /* !CONFIG_NUMA */
> > +/* never called */
> > +static inline struct pglist_data *generic_alloc_nodedata(int nid)
> > +{
> > +	BUG();
> > +	return NULL;
> > +}
> > +static inline void generic_free_nodedata(struct pglist_data *pgdat)
> > +{
> > +}
> > +#endif /* CONFIG_NUMA */
> > +#endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
> > +
> 
> Should the patch provide stubs for generic_alloc_nodedata() and
> generic_alloc_nodedata() if !CONFIG_HAVE_ARCH_NODEDATA_EXTENSION?
> 
> (If all callers are also inside #ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
> then the answer would be "no").

No. 
They are stubs for !CONFIG_HAVE_ARCH_NODEDATA_EXTENSION.
They are inside of !CONFIG case. Not for special archtectures.
I intend that if an architecture needs some kind of extension, 
it should define CONFIG_HAVE_ARCH..... and arch_alloc_nodedata(nid).

Did I make mistake comment for #ifdef?

Bye.

-- 
Yasunori Goto 


