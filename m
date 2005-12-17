Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVLQWjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVLQWjZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 17:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVLQWjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 17:39:25 -0500
Received: from lame.durables.org ([64.81.244.120]:6835 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S964986AbVLQWjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 17:39:24 -0500
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
From: Robert Walsh <rjwalsh@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20051217123827.32f119da.akpm@osdl.org>
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	 <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	 <20051217123827.32f119da.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 14:39:18 -0800
Message-Id: <1134859158.20575.82.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#define yield() sched_yield()
> 
> Some might get upset about what I assume is userspace test harness code or
> what _is_ this doing?) in a driver.  But if the maintainers find it useful
> we can live with it,

That is cosimulator code.  It's easy enough to remove.  I'll look into
it.

> > +#ifndef _BITS_PER_BYTE
> > +#define _BITS_PER_BYTE 8
> > +#endif
> 
> I'd be inclined to stick BITS_PER_BYTE into include/linux/types.h.

Really?  I was just going to suggest removing it, but if sticking it in
types.h works for you, then fine.

> > +static __inline__ void ipath_shortcopy(void *dest, void *src, uint32_t cnt)
> > +    __attribute__ ((always_inline));
> 
> s/__inline__/inline/ throughout.

OK.

> > +#define round_up(v,sz) (((v) + (sz)-1) & ~((sz)-1))
> 
> We have ALIGN()

Yup.

> > +struct ipath_int_vec {
> > +	int long long addr;
> 
> long long

OK.

> > +#define IPATH_USERINIT      _IOW('s', 16, struct ipath_user_info)
> > +/* init;  kernel/chip params to user */
> > +#define IPATH_BASEINFO      _IOR('s', 17, struct ipath_base_info)
> > +/* send a packet */
> > +#define IPATH_SENDPKT       _IOW('s', 18, struct ipath_sendpkt)
> 
> uh-oh.  ioctls.  Do we have compat conversions for them all, if needed?

For those that are needed, I believe we covered them all.  Some have
suggested removing ioctls.  I'm willing to look into alternatives, but
if you think they're OK, I'd rather leave them.

> > +/*
> > + * A segment is a linear region of low physical memory.
> > + * XXX Maybe we should use phys addr here and kmap()/kunmap()
> > + * Used by the verbs layer.
> > + */
> > +struct ipath_seg {
> > +	void *vaddr;
> > +	u64 length;
> > +};
> 
> Suggest `long' for the length.  We don't need 64 bits on 32-bit machines.

OK.

> > +struct ipath_mregion {
> > +	u64 user_base;		/* User's address for this region */
> 
> void *.
> 
> > +	u64 iova;		/* IB start address of this region */
> 
> Maybe here too.

OK.

> > +int ipath_mlock(unsigned long, size_t, struct page **);
> 
> Sometimes it does `int foo()' and sometimes `extern int foo()'.  I tend to
> think the `extern' is a waste of space.

Yup.

> > +#define ipath_func_krecord(a)
> > +#define ipath_func_urecord(a, b)
> > +#define ipath_func_mrecord(a, b)
> > +#define ipath_func_rkrecord(a)
> > +#define ipath_func_rurecord(a, b)
> > +#define ipath_func_rmrecord(a, b)
> > +#define ipath_func_rsrecord(a)
> > +#define ipath_func_rcrecord(a)
> 
> What are all these doing?   Might need do{}while(0) for safety.

I'll look at cleaning them out.  Probably left-overs from some earlier
experiment.

> > +#ifdef IPATH_COSIM
> > +extern __u32 sim_readl(const volatile void __iomem * addr);
> > +extern __u64 sim_readq(const volatile void __iomem * addr);
> 
> The driver has a strange mixture of int32_t, s32 and __s32.  s32 is
> preferred.

Yea - I'll clean that up.

> > + */
> > +static __inline__ uint32_t ipath_kget_ureg32(const ipath_type stype,
> > +					     ipath_ureg regno, int port)
> > +{
> > +	uint64_t *ubase;
> > +
> > +	ubase = (uint64_t *) (devdata[stype].ipath_uregbase
> > +			      + (char *)devdata[stype].ipath_kregbase
> > +			      + devdata[stype].ipath_palign * port);
> > +	return ubase ? ipath_readl(ubase + regno) : 0;
> > +}
> 
> Are all these u64's needed on 32-bit?

Don't know - I'll ask around.  We don't support the hardware in 32-bit
anyway, so...

> > +static __inline__ uint64_t ipath_kget_kreg64(const ipath_type stype,
> > +					     ipath_kreg regno)
> > +{
> > +	if (!devdata[stype].ipath_kregbase)
> > +		return ~0ULL;
> 
> We don't know that the architecture implements u64 as unsigned long long. 
> Some use unsigned long.  Best way of implmenting the all-ones pattern is
> just `-1'.

OK.

> Gee.  Big driver.

Tell me about it :-)  Basically, we're doing infiniband in software: no
offload.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


