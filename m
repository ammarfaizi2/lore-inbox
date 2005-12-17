Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVLQNPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVLQNPA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 08:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVLQNO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 08:14:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34714 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932575AbVLQNO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 08:14:59 -0500
Date: Sat, 17 Dec 2005 13:14:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
Message-ID: <20051217131456.GA13043@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com> <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + * $Id: ipath_common.h 4491 2005-12-15 22:20:31Z rjwalsh $

please remove RCSIDs everywhere.

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

Please push this out.  It's fine if they reuse kernel-code in userspace
this way, but please move the compat wrappers to a separate file that's
not in the kernel tree.  

> +typedef uint8_t ipath_type;

totally meaningless typedef

> +#ifndef _BITS_PER_BYTE
> +#define _BITS_PER_BYTE 8
> +#endif

WTF?

> +
> +static __inline__ void ipath_shortcopy(void *dest, void *src, uint32_t cnt)
> +    __attribute__ ((always_inline));



> +/*
> + * this is used for very short copies, usually 1 - 8 bytes,
> + * *NEVER* to the PIO buffers!!!!!!!  use ipath_dwordcpy for longer
> + * copies, or any copy to the PIO buffers.  Works for 32 and 64 bit
> + * gcc and pathcc
> + */
> +static __inline__ void ipath_shortcopy(void *dest, void *src, uint32_t cnt)

in kernel land we __inline__ includes always_inline.  Also no need for
a separate prototype for a just following inline function.

> +{
> +	void *ssv, *dsv;
> +	uint32_t csv;
> +	__asm__ __volatile__("cld\n\trep\n\tmovsb":"=&c"(csv), "=&D"(dsv),
> +			     "=&S"(ssv)
> +			     :"0"(cnt), "1"(dest), "2"(src)
> +			     :"memory");
> +}

No way we're gonna put assembler code into such a driver.

> +struct ipath_int_vec {
> +	int long long addr;
> +	uint32_t info;
> +};


please always used fixes-size types for user communication.  also please
avoid ioctls like the rest of the IB codebase.

> +/* Similarly, this is the kernel version going back to the user.  It's slightly
> + * different, in that we want to tell if the driver was built as part of a
> + * PathScale release, or from the driver from the OpenIB, kernel.org, or a
> + * standard distribution, for support reasons.  The high bit is 0 for
> + * non-PathScale, and 1 for PathScale-built/supplied.  That bit is defined
> + * in Makefiles, rather than this file.
> + *
> + * It's returned by the driver to the user code during initialization
> + * in the spi_sw_version field of ipath_base_info, so the user code can
> + * in turn check for compatibility with the kernel.
> +*/
> +#define IPATH_KERN_SWVERSION ((IPATH_KERN_TYPE<<31) | IPATH_USER_SWVERSION)

NACK, there's no way we're gonna put in a way to identify an "official"
version.  The official version is the last one in mainline always.

> +#ifndef PCI_VENDOR_ID_PATHSCALE	/* not in pci.ids yet */
> +#define PCI_VENDOR_ID_PATHSCALE 0x1fc1
> +#define PCI_DEVICE_ID_PATHSCALE_INFINIPATH1 0xa
> +#define PCI_DEVICE_ID_PATHSCALE_INFINIPATH2 0xd
> +#endif

so move it there?

> +typedef struct _ipath_portdata {

please avoid typedefs for struct types.

> +/*
> + * these should be somewhat dynamic someday, although they are fixed
> + * for all users of the device on any given load.
> + *
> + * NOTE: There is a VM bug in the 2.4 Kernels similar to the one Dave
> + * fixed in the 2.6 Kernel.  When using large or discontinuous memory,
> + * we get random kernel oops.  So, in 2.4, we are just going to stick
> + * with 4k chunks instead of 64k chunks.
> + */

No one cares about 2.4 kernels here.

> + * these function similarly to the mlock/munlock system calls.
> + * ipath_mlock() is used to pin an address range (if not already pinned),
> + * and optionally return the list of physical addresses
> + * ipath_munlock() does the obvious, and ipath_mlock() cleans up all 
> + * private memory, used at driver unload.
> + * ipath_mlock_nocopy() is similar to mlock, but only one page, and marks
> + * the vm so the page isn't taken away on a fork.
> + */
> +int ipath_mlock(unsigned long, size_t, struct page **);
> +int ipath_mlock_nocopy(unsigned long, struct page **);

this kind of thing definitly doesn't belong into an LLDD.  or maybe
it's just stale prototypes?

> +#ifdef IPATH_COSIM
> +extern __u32 sim_readl(const volatile void __iomem * addr);
> +extern __u64 sim_readq(const volatile void __iomem * addr);
> +extern void sim_writel(__u32 val, volatile void __iomem * addr);
> +extern void sim_writeq(__u64 val, volatile void __iomem * addr);
> +#define ipath_readl(addr) sim_readl(addr)
> +#define ipath_readq(addr) sim_readq(addr)
> +#define ipath_writel(val, addr) sim_writel(val, addr)
> +#define ipath_writeq(val, addr) sim_writeq(val, addr)
> +#else
> +#define ipath_readl(addr) readl(addr)
> +#define ipath_readq(addr) readq(addr)
> +#define ipath_writel(val, addr) writel(val, addr)
> +#define ipath_writeq(val, addr) writeq(val, addr)
> +#endif

Please use the proper functions directly.  Your simulator can override
them if nessecary.

> +static __inline__ uint32_t ipath_kget_kreg32(const ipath_type stype,
> +					     ipath_kreg regno)
> +{
> +	volatile uint32_t *kreg32;
> +
> +	if (!devdata[stype].ipath_kregbase)
> +		return ~0;
> +
> +	kreg32 = (volatile uint32_t *)&devdata[stype].ipath_kregbase[regno];

volatile use is probably always wrong. but this whole functions looks like
a very odd wrapper anyway?

