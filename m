Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVLQUkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVLQUkJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVLQUjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:39:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44001 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964951AbVLQUi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:38:56 -0500
Date: Sat, 17 Dec 2005 12:38:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
Message-Id: <20051217123827.32f119da.akpm@osdl.org>
In-Reply-To: <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	<200512161548.aLjaDpGm5aqk0k0p@cisco.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> ...
>
> +#ifdef __KERNEL__
> +#include <linux/ioctl.h>
> +#include <linux/uio.h>
> +#include <asm/atomic.h>
> +#else				/* !__KERNEL__; user mode */
> +#include <sys/ioctl.h>
> +#include <sys/uio.h>
> +#include <sys/types.h>
> +#include <stdint.h>
> +
> +/* these aren't implemented for user mode, which is OK until we multi-thread */
> +typedef struct _atomic {
> +	uint32_t counter;
> +} atomic_t;			/* no atomic_t type in user-land */
> +#define atomic_set(a,v) ((a)->counter = (v))
> +#define atomic_inc_return(a)  (++(a)->counter)
> +#define likely(x) (x)
> +#define unlikely(x) (x)
> +
> +#define yield() sched_yield()

Some might get upset about what I assume is userspace test harness code or
what _is_ this doing?) in a driver.  But if the maintainers find it useful
we can live with it,

> +#ifndef _BITS_PER_BYTE
> +#define _BITS_PER_BYTE 8
> +#endif

I'd be inclined to stick BITS_PER_BYTE into include/linux/types.h.

> +static __inline__ void ipath_shortcopy(void *dest, void *src, uint32_t cnt)
> +    __attribute__ ((always_inline));

s/__inline__/inline/ throughout.

> +#define round_up(v,sz) (((v) + (sz)-1) & ~((sz)-1))

We have ALIGN()

> +struct ipath_int_vec {
> +	int long long addr;

long long

> +	uint32_t info;
> +};
> +struct ipath_eeprom_req {
> +	long long addr;

Like this.

> +	uint16_t len;
> +	uint16_t offset;
> +};
> ...
> +#define IPATH_USERINIT      _IOW('s', 16, struct ipath_user_info)
> +/* init;  kernel/chip params to user */
> +#define IPATH_BASEINFO      _IOR('s', 17, struct ipath_base_info)
> +/* send a packet */
> +#define IPATH_SENDPKT       _IOW('s', 18, struct ipath_sendpkt)

uh-oh.  ioctls.  Do we have compat conversions for them all, if needed?

> +/*
> + * A segment is a linear region of low physical memory.
> + * XXX Maybe we should use phys addr here and kmap()/kunmap()
> + * Used by the verbs layer.
> + */
> +struct ipath_seg {
> +	void *vaddr;
> +	u64 length;
> +};

Suggest `long' for the length.  We don't need 64 bits on 32-bit machines.

> +struct ipath_mregion {
> +	u64 user_base;		/* User's address for this region */

void *.

> +	u64 iova;		/* IB start address of this region */

Maybe here too.

> +int ipath_mlock(unsigned long, size_t, struct page **);

Sometimes it does `int foo()' and sometimes `extern int foo()'.  I tend to
think the `extern' is a waste of space.

> +#define ipath_func_krecord(a)
> +#define ipath_func_urecord(a, b)
> +#define ipath_func_mrecord(a, b)
> +#define ipath_func_rkrecord(a)
> +#define ipath_func_rurecord(a, b)
> +#define ipath_func_rmrecord(a, b)
> +#define ipath_func_rsrecord(a)
> +#define ipath_func_rcrecord(a)

What are all these doing?   Might need do{}while(0) for safety.

> +#ifdef IPATH_COSIM
> +extern __u32 sim_readl(const volatile void __iomem * addr);
> +extern __u64 sim_readq(const volatile void __iomem * addr);

The driver has a strange mixture of int32_t, s32 and __s32.  s32 is
preferred.

> + */
> +static __inline__ uint32_t ipath_kget_ureg32(const ipath_type stype,
> +					     ipath_ureg regno, int port)
> +{
> +	uint64_t *ubase;
> +
> +	ubase = (uint64_t *) (devdata[stype].ipath_uregbase
> +			      + (char *)devdata[stype].ipath_kregbase
> +			      + devdata[stype].ipath_palign * port);
> +	return ubase ? ipath_readl(ubase + regno) : 0;
> +}

Are all these u64's needed on 32-bit?

> +static __inline__ uint64_t ipath_kget_kreg64(const ipath_type stype,
> +					     ipath_kreg regno)
> +{
> +	if (!devdata[stype].ipath_kregbase)
> +		return ~0ULL;

We don't know that the architecture implements u64 as unsigned long long. 
Some use unsigned long.  Best way of implmenting the all-ones pattern is
just `-1'.



Gee.  Big driver.
