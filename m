Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWATQFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWATQFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWATQFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:05:54 -0500
Received: from mx.pathscale.com ([64.160.42.68]:41856 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750808AbWATQFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:05:54 -0500
Subject: Re: [PATCH 1/6] 2.6.16-rc1 perfmon2 patch for review
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601201520.k0KFKCdY023112@frankl.hpl.hp.com>
References: <200601201520.k0KFKCdY023112@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 08:05:48 -0800
Message-Id: <1137773148.28944.29.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 07:20 -0800, Stephane Eranian wrote:

> + * Fast, simple, yet decent quality random number generator based on
> + * a paper by David G. Carta ("Two Fast Implementations of the
> + * `Minimal Standard' Random Number Generator," Communications of the
> + * ACM, January, 1990).

What on earth do you need a random number generator for?

> + * XXX: Hack until we figure out which header file to use.
> + *      Could use linux/random.h but then we would need
> + *      asm-XX/random.h which does not exists yet
> + */
> +#ifdef __ia64__
> +#define __HAVE_ARCH_CARTA_RANDOM32
> +#endif

Please use the same mechanism as I did last week for __iowrite_copy32,
instead of this ifdeffery.  If you search the archives, you'll find it.

> +/*
> + * Request structure used to define a context
> + */
> +typedef struct {
> +	pfm_uuid_t	ctx_smpl_buf_id;   /* which buffer format to use */
> +	u32		ctx_flags;	   /* noblock/block */

Please define a pfm_flags_t or similar type, and mark it __bitwise for
sparse.

> +	int		ctx_fd;		   /* ret arg: fd for context */

Why not an s32?

> +	u32 reg_flags;	   	/* input: flags, return: reg error */

This overloading is a bit gross, if I understand it correctly.  You're
passing in a bitmask and getting back an integer, is that right?  Or is
it a different kind of bitmask in either direction?

> +/*
> + * argument structure for pfm_write_pmds() and pfm_read_pmds()
> + */
> +typedef struct {
> +	u16 reg_num;	   	/* which register */
> +	u16 reg_set;	   	/* event set for this register */
> +	u32 reg_flags;	   	/* input: flags, return: reg error */
> +	u64 reg_value;	   	/* initial pmc/pmd value */
> +	u64 reg_long_reset;	/* value to reload after notification */
> +	u64 reg_short_reset;   	/* reset after counter overflow */
> +	u64 reg_last_reset_val;	/* return: PMD last reset value */
> +	u64 reg_ovfl_switch_cnt;/* #overflows before switch */
> +	unsigned long reg_reset_pmds[PFM_PMD_BV]; /* reset on overflow */
> +	unsigned long reg_smpl_pmds[PFM_PMD_BV];  /* record in sample */
> +	u64 reg_smpl_eventid;  	/* opaque event identifier */
> +	u64 reg_random_mask; 	/* bitmask used to limit random value */
> +	u32 reg_random_seed;   	/* seed for randomization */
> +	u32 reg_reserved2[7];	/* for future use */
> +} pfarg_pmd_t;

If this header file is shared with userspace (it looks like it is) and
these are syscall arguments, these should all be double-underscored
fixed-size types, as should all other types and structs that may be used
by userspace.  Using unsigned long, in particular, makes extra work for
multiarch machines that will have to repack those structs.


> + * default value for the user and group security parameters in
> + * /proc/sys/kernel/perfmon
> + */
> +#define PFM_GROUP_PERM_ANY	-1	/* any user/group */

/proc????

> +extern int  pfm_get_args(void __user *arg, size_t sz, void **kargs);

Please don't declare functions as extern.  It's redundant, and the head
penguins don't like the style.

Also, some comment in the header that makes it obvious where's the
boundary between functions that are purely internal to perfmon,
functions that can be used by other kernel subsystems (if any), and
syscalls would be useful.

> +/* use for IA-64 only */
> +#ifdef __ia64__
> +#define pfm_release_dbregs(_t) 		do { } while (0)
> +#define pfm_use_dbregs(_t)     		(0)
> +#endif

Please move this to asm-ia64/perfmon.h, then.

> +/*
> + * This header is at the beginning of the sampling buffer returned to the user.

How big are these sampling buffers, and would they be a better match for
relayfs?

	<b

