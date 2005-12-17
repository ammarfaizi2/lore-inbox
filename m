Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVLQMdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVLQMdV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 07:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVLQMdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 07:33:21 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:20340 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932571AbVLQMdV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 07:33:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hHO3Cua1J95CcleDDPkfVLz3BWuc6mV//LMuMXeAr/irdjOCVsCzU7HRMILWevY+gV6rBZQ0BH0V+/mO1I7c4vELbmz50mo0yuxNIYojIVUdhpQds2wf3u+cqK78sGhjwCQbxD4r5nFr9jYbvQM6NC1IMqSyFecNQtjpVp8EAgI=
Message-ID: <84144f020512170433h151a7667o42c382242f81347b@mail.gmail.com>
Date: Sat, 17 Dec 2005 14:33:16 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH 01/13] [RFC] ipath basic headers
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	 <200512161548.aLjaDpGm5aqk0k0p@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,

On 12/17/05, Roland Dreier <rolandd@cisco.com> wrote:
> +/*
> + * This file contains defines, structures, etc. that are used
> + * to communicate between kernel and user code.
> + */
> +
> +#ifdef __KERNEL__
> +#include <linux/ioctl.h>
> +#include <linux/uio.h>
> +#include <asm/atomic.h>
> +#else                          /* !__KERNEL__; user mode */
> +#include <sys/ioctl.h>
> +#include <sys/uio.h>
> +#include <sys/types.h>
> +#include <stdint.h>
> +
> +/* these aren't implemented for user mode, which is OK until we multi-thread */
> +typedef struct _atomic {
> +       uint32_t counter;
> +} atomic_t;                    /* no atomic_t type in user-land */
> +#define atomic_set(a,v) ((a)->counter = (v))
> +#define atomic_inc_return(a)  (++(a)->counter)
> +#define likely(x) (x)
> +#define unlikely(x) (x)
> +
> +#define yield() sched_yield()
> +
> +/*
> + * too horrible to try and use the kernel get_cycles() or equivalent,
> + * so define and inline it here
> + */
> +
> +#if !defined(rdtscll)
> +#if defined(__x86_64) || defined(__i386)
> +#define rdtscll(v) do {uint32_t a,d;asm volatile("rdtsc" : "=a" (a), "=d" (d)); \
> +         (v) = ((uint64_t)a) | (((uint64_t)d)<<32); \
> +} while(0)
> +#else
> +#error "No cycle counter routine implemented yet for this platform"
> +#endif
> +#endif                         /* !defined(rdtscll) */

Do we really need this ugly userspace emulation code in the kernel?

> +/*
> + * this is used for very short copies, usually 1 - 8 bytes,
> + * *NEVER* to the PIO buffers!!!!!!!  use ipath_dwordcpy for longer
> + * copies, or any copy to the PIO buffers.  Works for 32 and 64 bit
> + * gcc and pathcc
> + */
> +static __inline__ void ipath_shortcopy(void *dest, void *src, uint32_t cnt)
> +{
> +       void *ssv, *dsv;
> +       uint32_t csv;
> +       __asm__ __volatile__("cld\n\trep\n\tmovsb":"=&c"(csv), "=&D"(dsv),
> +                            "=&S"(ssv)
> +                            :"0"(cnt), "1"(dest), "2"(src)
> +                            :"memory");
> +}
> +
> +/*
> + * optimized word copy; good for rev C and later opterons.  Among the best for
> + * short copies, and does as well or slightly better than the optimizization
> + * guide copies 6 and 8 at 2KB.
> + */
> +void ipath_dwordcpy(uint32_t * dest, uint32_t * src, uint32_t ndwords);

What is this used for? Why can't yo use memcpy?

> +#define round_up(v,sz) (((v) + (sz)-1) & ~((sz)-1))

Please use ALIGN().

> +/* These are used in the driver, don't use them elsewhere */
> +#define _IPATH_SIMFUNC_IOCTL_LOW 1
> +#define _IPATH_SIMFUNC_IOCTL_HIGH 7
> +
> +/*
> + * These tell the driver which ioctl's belong to the diags interface.
> + * As above, don't use them elsewhere.
> + */
> +#define _IPATH_DIAG_IOCTL_LOW 100
> +#define _IPATH_DIAG_IOCTL_HIGH 109

[snip, snip]

You seem to be introducing loads of new ioctls. Any reason you can't
use sysfs and/or configfs?

> +/* macros for processing rcvhdrq entries */
> +#define ips_get_hdr_err_flags(StartOfBuffer) *(((uint32_t *)(StartOfBuffer))+1)
> +#define ips_get_index(StartOfBuffer) (((*((uint32_t *)(StartOfBuffer))) >> \
> +        INFINIPATH_RHF_EGRINDEX_SHIFT) & INFINIPATH_RHF_EGRINDEX_MASK)
> +#define ips_get_rcv_type(StartOfBuffer)  ((*(((uint32_t *)(StartOfBuffer))) >> \
> +        INFINIPATH_RHF_RCVTYPE_SHIFT) & INFINIPATH_RHF_RCVTYPE_MASK)
> +#define ips_get_length_in_bytes(StartOfBuffer) \
> +        (uint32_t)(((*(((uint32_t *)(StartOfBuffer))) >> \
> +        INFINIPATH_RHF_LENGTH_SHIFT) & INFINIPATH_RHF_LENGTH_MASK) << 2)
> +#define ips_get_first_protocol_header(StartOfBuffer) (void *) \
> +        ((uint32_t *)(StartOfBuffer) + 2)
> +#define ips_get_ips_header(StartOfBuffer) ((ips_message_header_typ *) \
> +        ((uint32_t *)(StartOfBuffer) + 2))
> +#define ips_get_ipath_ver(ipath_header) (((ipath_header) >> INFINIPATH_I_VERS_SHIFT) \
> +        & INFINIPATH_I_VERS_MASK)

Please use static inlines instead for readability.
