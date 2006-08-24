Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965338AbWHXB6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965338AbWHXB6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 21:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965337AbWHXB6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 21:58:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965338AbWHXB6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 21:58:03 -0400
Date: Wed, 23 Aug 2006 18:48:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 12/18] 2.6.17.9 perfmon2 patch for review: common core
 functions
Message-Id: <20060823184818.627a861b.akpm@osdl.org>
In-Reply-To: <200608230806.k7N863tf000480@frankl.hpl.hp.com>
References: <200608230806.k7N863tf000480@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 01:06:03 -0700
Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:

> This patch the core of perfmon2.
> 
> The core consists of:
> 	- back-end to most system calls
> 	- notification message queue management
> 	- sampling buffer allocation
> 	- support functions for sampling
> 	- context allocation and destruction
> 	- user level notification
> 	- perfmon2 initialization
> 	- permission checking
> 

Remind us again why this doesn't use relay files?

> --- linux-2.6.17.9.base/include/linux/perfmon.h	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17.9/include/linux/perfmon.h	2006-08-21 03:37:46.000000000 -0700
> @@ -0,0 +1,749 @@
> +/*
> + * Copyright (c) 2001-2006 Hewlett-Packard Development Company, L.P.
> + * Contributed by Stephane Eranian <eranian@hpl.hp.com>
> + */

I'm a bit surprised to not see explicit licensing info within the perfmon
files.

> +/*
> + * custom sampling buffer identifier type
> + */
> +typedef __u8 pfm_uuid_t[16];

What does this do, and why is a UUID used?

> +typedef __u32 __bitwise pfm_flags_t;

grumble.

> +/*
> + * Request structure used to define a context
> + */
> +struct pfarg_ctx {
> +	pfm_uuid_t	ctx_smpl_buf_id;   /* which buffer format to use */
> +	pfm_flags_t	ctx_flags;	   /* noblock/block/syswide */
> +	__s32		ctx_fd;		   /* ret arg: fd for context */
> +	__u64		ctx_smpl_buf_size; /* ret arg: actual buffer size */
> +	__u64		ctx_reserved3[12]; /* for future use */
> +};

It helps if the comments explicitly identify those structures which are
shared with userspace.

I suspect this structure _is_ shared with userspace, and I wonder about the
alignment of those u64's.  It looks to be OK, as long as pfm_flags_t
remains 32-bit.

Given this, and the fact that the type of pfm_flags_t is cast in stone (if
it is indeed exported to userspace), there really is little point in using
a typedef - we won't be changing it.  Sometimes there's a clarity case to
be made for a typedef, but usually not.


> +/*
> + * context flags (ctx_flags)
> + *
> + */
> +#define PFM_FL_NOTIFY_BLOCK    	 0x01	/* block task on user notifications */
> +#define PFM_FL_SYSTEM_WIDE	 0x02	/* create a system wide context */
> +#define PFM_FL_OVFL_NO_MSG	 0x80   /* no overflow msgs */
> +#define PFM_FL_MAP_SETS		 0x10	/* event sets are remapped */
> +
> +
> +/*
> + * argument structure for pfm_write_pmcs()
> + */
> +struct pfarg_pmc {
> +	__u16 reg_num;		/* which register */
> +	__u16 reg_set;		/* event set for this register */
> +	pfm_flags_t reg_flags;	/* input: flags, return: reg error */
> +	__u64 reg_value;	/* pmc value */
> +	__u64 reg_reserved2[4];	/* for future use */
> +};
>
> +/*
> + * argument structure for pfm_write_pmds() and pfm_read_pmds()
> + */
> +struct pfarg_pmd {
> +	__u16 reg_num;	   	/* which register */
> +	__u16 reg_set;	   	/* event set for this register */
> +	pfm_flags_t reg_flags; 	/* input: flags, return: reg error */
> +	__u64 reg_value;	/* initial pmc/pmd value */
> +	__u64 reg_long_reset;	/* value to reload after notification */
> +	__u64 reg_short_reset;  /* reset after counter overflow */
> +	__u64 reg_last_reset_val;	/* return: PMD last reset value */
> +	__u64 reg_ovfl_switch_cnt;	/* #overflows before switch */
> +	__u64 reg_reset_pmds[PFM_PMD_BV]; /* reset on overflow */
> +	__u64 reg_smpl_pmds[PFM_PMD_BV];  /* record in sample */
> +	__u64 reg_smpl_eventid; /* opaque event identifier */
> +	__u64 reg_random_mask; 	/* bitmask used to limit random value */
> +	__u32 reg_random_seed;  /* seed for randomization */
> +	__u32 reg_reserved2[7];	/* for future use */
> +};

OK, these both seem to be cunningly designed to avoid alignment problems
and compiler changes.

Perhaps declaring all these `packed' might provide additional safety there;
not sure.

The "reserved for future use" field is pretty useless unless there is also
version information somewhere.  Is there?

Are the reserved-for-future-use fields guaranteed to be zero when the
kernel priovides them?  (They should be).

Does the kernel check that the reserved-for-future-use fields are all-zero
when userspace provides them?  (Perhaps it should?)

> +/*
> + * optional argument to pfm_start(), pass NULL if no arg needed
> + */
> +struct pfarg_start {
> +	__u16 start_set;	/* event set to start with */
> +	__u16 start_reserved1;	/* for future use */
> +	__u32 start_reserved2;	/* for future use */
> +	__u64 reserved3[3];	/* for future use */
> +};
> +
> +/*
> + * argument to pfm_load_context()
> + */
> +struct pfarg_load {
> +	__u32	load_pid;	   /* thread to attach to */
> +	__u16	load_set;	   /* set to load first */
> +	__u16	load_reserved1;	   /* for future use */
> +	__u64	load_reserved2[3]; /* for future use */
> +};
> +
> +/*
> + * argument to pfm_create_evtsets()/pfm_delete_evtsets()
> + *
> + * max timeout: 1h11mn33s (2<<32 usecs)
> + */
> +struct pfarg_setdesc {
> +	__u16	set_id;		  /* which set */
> +	__u16	set_id_next;	  /* next set to go to */
> +	pfm_flags_t set_flags; 	  /* input: flags, return: err flag  */
> +	__u32	set_timeout;	  /* req/eff switch timeout in usecs */
> +	__u32	set_reserved1;	  /* for future use */
> +	__u64	set_mmap_offset;  /* ret arg: cookie for mmap offset */
> +	__u64	reserved[5];	  /* for future use */
> +};

Why microseconds?  64-bit nanoseconds would be more typical, and perhaps
more useful.  (Except people have gone and shipped it now, so it gets
messy, yes?)

> +/*
> + * argument to pfm_getinfo_evtsets()
> + */
> +struct pfarg_setinfo {
> +	__u16	set_id;             /* which set */
> +	__u16	set_id_next;        /* out: next set to go to */
> +	pfm_flags_t set_flags;	    /* out:flags or error */
> +	__u64 	set_ovfl_pmds[PFM_PMD_BV]; /* out: last ovfl PMDs */
> +	__u64	set_runs;            /* out: #times the set was active */
> +	__u32	set_timeout;         /* out: effective switch timeout in usecs */
> +	__u32	set_reserved1;       /* for future use */
> +	__u64	set_act_duration;    /* out: time set active (cycles) */
> +	__u64	set_mmap_offset;     /* cookie to for mmap offset */
> +	__u64	set_avail_pmcs[PFM_PMC_BV];/* unavailable PMCs */
> +	__u64	set_avail_pmds[PFM_PMD_BV];/* unavailable PMDs */
> +	__u64	reserved[4];         /* for future use */
> +};
> +
> +/*
> + * default value for the user and group security parameters in
> + * /proc/sys/kernel/perfmon/sys_group
> + * /proc/sys/kernel/perfmon/task_group
> + */
> +#define PFM_GROUP_PERM_ANY	-1	/* any user/group */
> +
> +/*
> + * remapped set view
> + *
> + * IMPORTANT: cannot be bigger than PAGE_SIZE
> + */
> +struct pfm_set_view {
> +	__u32      set_status;             /* set status: active/inact */
> +	__u32      set_reserved1;          /* for future use */
> +	__u64      set_runs;               /* number of activations */
> +	__u64      set_pmds[PFM_MAX_PMDS]; /* 64-bit value of PMDS */
> +	volatile unsigned long	set_seq;   /* sequence number of updates */
> +};

What's that volatile doing in there?

> +/*
> + * pfm_set_view status flags
> + */
> +#define PFM_SETVFL_ACTIVE	0x1 /* set is active */
> +
> +struct pfm_ovfl_msg {
> +	__u32 		msg_type;	/* generic message header */
> +	__u32		msg_ovfl_pid;	/* process id */
> +	__u64		msg_ovfl_pmds[PFM_HW_PMD_BV];/* overflowed PMDs */
> +	__u16 		msg_active_set;	/* active set at overflow */
> +	__u16 		msg_ovfl_cpu;	/* cpu of PMU interrupt */
> +	__u32		msg_ovfl_tid;	/* kernel thread id */
> +	__u64		msg_ovfl_ip;    /* IP on PMU intr */
> +};
> +
> +#define PFM_MSG_OVFL	1	/* an overflow happened */
> +#define PFM_MSG_END	2	/* task to which context was attached ended */
> +
> +union pfm_msg {
> +	__u32	type;
> +	struct pfm_ovfl_msg	pfm_ovfl_msg;
> +};
> +
> +/*
> + * perfmon version number
> + */
> +#define PFM_VERSION_MAJ		 2U
> +#define PFM_VERSION_MIN		 2U
> +#define PFM_VERSION		 (((PFM_VERSION_MAJ&0xffff)<<16)|\
> +				  (PFM_VERSION_MIN & 0xffff))
> +#define PFM_VERSION_MAJOR(x)	 (((x)>>16) & 0xffff)
> +#define PFM_VERSION_MINOR(x)	 ((x) & 0xffff)

There's a version.

> +#define pfm_ctx_arch(c)	((struct pfm_arch_context *)((c)+1))

ick, so we can do pfm_ctx_arch(42) and there will be no compiler warnings.

Suggest that this be converted to an inline function.

> +
> +static inline void pfm_inc_activation(void)
> +{
> +	__get_cpu_var(pmu_activation_number)++;
> +}
> +
> +static inline void pfm_set_activation(struct pfm_context *ctx)
> +{
> +	ctx->last_act = __get_cpu_var(pmu_activation_number);
> +}
> +
> +static inline void pfm_set_last_cpu(struct pfm_context *ctx, int cpu)
> +{
> +	ctx->last_cpu = cpu;
> +}
> +
> +static inline void pfm_modview_begin(struct pfm_event_set *set)
> +{
> +	set->view->set_seq++;
> +}
> +
> +static inline void pfm_modview_end(struct pfm_event_set *set)
> +{
> +	set->view->set_seq++;
> +}
> +
> +static inline void pfm_retflag_set(u32 flags, u32 val)
> +{
> +	flags &= ~PFM_REG_RETFL_MASK;
> +	flags |= (val);
> +}

All the above need caller-provided locking.  It would be nice to add a
comment describing what it is.

> +int  __pfm_write_pmcs(struct pfm_context *, struct pfarg_pmc *, int);
> +int  __pfm_write_pmds(struct pfm_context *, struct pfarg_pmd *, int, int);
> +int  __pfm_read_pmds(struct pfm_context *, struct pfarg_pmd *, int);

Prototypes are more useful if the programmer fills in the (well-chosen)
argument identifiers.

> +u64 carta_random32 (u64);

This declaration shouldn't be in this header, should it?

> +static inline void pfm_put_ctx(struct pfm_context *ctx)
> +{
> +	fput(ctx->filp);
> +}

This wrapper makes conversion to fput_light() a bit more complex.

> +#define PFM_ONE_64		((u64)1)

heh, OK, C sucks

> +#define PFM_BPL		64
> +#define PFM_LBPL	6	/* log2(BPL) */

#define PFM_BPL (1 << PFM_LBPL)

> +
> +/*
> + * those operations are not provided by linux/bitmap.h.

Please, add them there then.

> + * We do not need atomicity nor volatile accesses here.
> + * All bitmaps are 64-bit wide.
> + */
> +static inline void pfm_bv_set(u64 *bv, unsigned int rnum)
> +{
> +	bv[rnum>>PFM_LBPL] |= PFM_ONE_64 << (rnum&(PFM_BPL-1));
> +}
> +
> +static inline int pfm_bv_isset(u64 *bv, unsigned int rnum)
> +{
> +	return bv[rnum>>PFM_LBPL] & (PFM_ONE_64 <<(rnum&(PFM_BPL-1))) ? 1 : 0;
> +}
> +
> +static inline void pfm_bv_clear(u64 *bv, unsigned int rnum)
> +{
> +	bv[rnum>>PFM_LBPL] &= ~(PFM_ONE_64 << (rnum&(PFM_BPL-1)));
> +}
> +
> +/*
> + * read a single PMD register. PMD register mapping is provided by PMU
> + * description module. Some PMD registers are require a special read
> + * handler (e.g., virtual PMD mapping to a SW resource).
> + */
> +static inline u64 pfm_read_pmd(struct pfm_context *ctx, unsigned int cnum)
> +{
> +	if (unlikely(pfm_pmu_conf->pmd_desc[cnum].type & PFM_REG_V))
> +		return pfm_pmu_conf->pmd_sread(ctx, cnum);
> +
> +	return pfm_arch_read_pmd(ctx, cnum);
> +}
> +
> +static inline void pfm_write_pmd(struct pfm_context *ctx, unsigned int cnum, u64 value)
> +{
> +	/*
> +	 * PMD writes are ignored for read-only registers
> +	 */
> +	if (pfm_pmu_conf->pmd_desc[cnum].type & PFM_REG_RO)
> +		return;
> +
> +	if (pfm_pmu_conf->pmd_desc[cnum].type & PFM_REG_V) {
> +		pfm_pmu_conf->pmd_swrite(ctx, cnum, value);
> +		return;
> +	}
> +	pfm_arch_write_pmd(ctx, cnum, value);
> +}
> +
> +#define ulp(_x) ((unsigned long *)_x)

OK this is related to bitmap API shortcomings.  Let's try to get those
shortcomings fixed and then make all this go away.

> +
> +static union pfm_msg *pfm_get_new_msg(struct pfm_context *ctx)
> +{
> +	int idx, next;
> +
> +	next = (ctx->msgq_tail+1) % PFM_MAX_MSGS;
> +
> +	PFM_DBG("head=%d tail=%d", ctx->msgq_head, ctx->msgq_tail);
> +
> +	if (next == ctx->msgq_head)
> +		return NULL;
> +
> +	idx = ctx->msgq_tail;
> +	ctx->msgq_tail = next;
> +
> +	PFM_DBG("head=%d tail=%d msg=%d",
> +		ctx->msgq_head,
> +		ctx->msgq_tail, idx);
> +
> +	return ctx->msgq+idx;
> +}

This is the inferior way of doing a ringbuffer.

It's better to let `head' and `tail' wrap all the way through 0xffffffff and
to only mask them off when actually using them as offsets.  That way,

	(head - tail == 0):		empty
	(head - tail == PFM_MAX_MSGS):	full
	(head - tail):			number-of-items

which is nicer.  It requires that PFM_MAX_MSGS be a power of two, which is
reasonable.

> +
> +/*
> + * only called in for the current task
> + */
> +static int pfm_setup_smpl_fmt(struct pfm_smpl_fmt *fmt, void *fmt_arg,
> +				struct pfm_context *ctx, u32 ctx_flags,
> +				int mode, struct file *filp)
> +{
> +	size_t size = 0;
> +	int ret = 0;
> +
> +	/*
> +	 * validate parameters
> +	 */
> +	if (fmt->fmt_validate) {
> +		ret = (*fmt->fmt_validate)(ctx_flags, pfm_pmu_conf->num_pmds,
> +					   fmt_arg);
> +		PFM_DBG("validate(0x%x,%p)=%d", ctx_flags, fmt_arg, ret);
> +		if (ret)
> +			goto error;
> +	}
> +
> +	/*
> +	 * check if buffer format wants to use perfmon
> +	 * buffer allocation/mapping service
> +	 */
> +	size = 0;

We already did that.

> +	if (fmt->fmt_getsize) {
> +		ret = (*fmt->fmt_getsize)(ctx_flags, fmt_arg, &size);
> +		if (ret) {
> +			PFM_DBG("cannot get size ret=%d", ret);
> +			goto error;
> +		}
> +	}
> +
> +	if (size) {
> +#ifdef CONFIG_IA64_PERFMON_COMPAT
> +		if (mode == PFM_COMPAT)
> +			ret = pfm_smpl_buffer_alloc_old(ctx, size, filp);
> +		else
> +#endif
> +		{
> +			ret = pfm_smpl_buffer_alloc(ctx, size);
> +		}

Would be better to create more per-arch helpers and get the IA64 stuff out
of perfmon/perfmon.c.

> +		if (ret)
> +			goto error;
> +
> +	}
> +
> +	if (fmt->fmt_init) {
> +		ret = (*fmt->fmt_init)(ctx, ctx->smpl_addr, ctx_flags,
> +				       pfm_pmu_conf->num_pmds,
> +				       fmt_arg);
> +		if (ret)
> +			goto error_buffer;
> +	}
> +	return 0;
> +
> +error_buffer:
> +	if (!ctx->flags.kapi)
> +		pfm_release_buf_space(ctx->smpl_size);
> +	/*
> +	 * we do not call fmt_exit, if init has failed
> +	 */
> +	vfree(ctx->smpl_addr);
> +error:
> +	return ret;
> +}
> +
>
> ...
>
> +struct pfm_context *pfm_context_alloc(void)
> +{
> +	struct pfm_context *ctx;
> +
> +	/*
> +	 * allocate context structure
> +	 * the architecture specific portion is allocated
> +	 * right after the struct pfm_context struct. It is
> +	 * accessible at ctx_arch = (ctx+1)
> +	 */
> +	ctx = kmem_cache_alloc(pfm_ctx_cachep, SLAB_ATOMIC);
> +	if (ctx) {
> +		memset(ctx, 0, sizeof(*ctx)+PFM_ARCH_CTX_SIZE);
> +		PFM_DBG("alloc ctx @%p", ctx);
> +	}
> +	return ctx;
> +}

Can we avoid the unreliable SLAB_ATOMIC here?

> +/*
> + * in new mode, we only allocate the kernel buffer, an explicit mmap()
> + * is needed to remap the buffer at the user level
> + */
> +int pfm_smpl_buffer_alloc(struct pfm_context *ctx, size_t rsize)
> +{
> +	void *addr;
> +	size_t size;
> +	int ret;
> +
> +	/*
> +	 * the fixed header + requested size and align to page boundary
> +	 */
> +	size = PAGE_ALIGN(rsize);
> +
> +	PFM_DBG("sampling buffer rsize=%zu size=%zu", rsize, size);
> +
> +	if (!ctx->flags.kapi) {
> +		ret = pfm_reserve_buf_space(size);
> +		if (ret) return ret;

newline, please.

> +	}
> +
> +	addr = vmalloc(size);
> +	if (addr == NULL) {
> +		PFM_DBG("cannot allocate sampling buffer");
> +		goto unres;
> +	}
> +
> +	memset(addr, 0, size);
> +
> +	ctx->smpl_addr = addr;
> +	ctx->smpl_size = size;
> +
> +	PFM_DBG("kernel smpl buffer @%p", addr);
> +
> +	return 0;
> +unres:
> +	if (!ctx->flags.kapi)
> +		pfm_release_buf_space(size);
> +	return -ENOMEM;
> +}
> +
> +static inline u64 pfm_new_pmd_value (struct pfm_pmd *reg, int reset_mode)
> +{
> +	u64 val, mask;
> +	u64 new_seed, old_seed;
> +
> +	val = reset_mode == PFM_PMD_RESET_LONG ? reg->long_reset : reg->short_reset;
> +	old_seed = reg->seed;
> +	mask = reg->mask;
> +
> +	if (reg->flags & PFM_REGFL_RANDOM) {
> +		new_seed = carta_random32(old_seed);
> +
> +		/* counter values are negative numbers! */
> +		val -= (old_seed & mask);
> +		if ((mask >> 32) != 0)
> +			/* construct a full 64-bit random value: */
> +			new_seed |= (u64)carta_random32((u32)(old_seed >> 32)) << 32;

carta_random32 already returns u64.   I think neither cast is needed here.

> +		reg->seed = new_seed;
> +	}
> +	reg->lval = val;
> +	return val;
> +}
>
> ...
>
> +void pfm_reset_pmds(struct pfm_context *ctx, struct pfm_event_set *set,
> +		    int reset_mode)
> +{
> +	u64 ovfl_mask, hw_val;
> +	u64 *cnt_mask, *reset_pmds;
> +	u64 val;
> +	unsigned int i, max_pmd, not_masked;
> +
> +	reset_pmds = set->reset_pmds;
> +	max_pmd	= pfm_pmu_conf->max_pmd;
> +
> +	ovfl_mask = pfm_pmu_conf->ovfl_mask;
> +	cnt_mask = pfm_pmu_conf->cnt_pmds;
> +	not_masked = ctx->state != PFM_CTX_MASKED;
> +
> +	PFM_DBG_ovfl("%s r_pmds=0x%llx not_masked=%d",
> +		     reset_mode == PFM_PMD_RESET_LONG ? "long" : "short",
> +		     (unsigned long long)reset_pmds[0],
> +		     not_masked);
> +
> +	pfm_modview_begin(set);
> +
> +	for (i = 0; i < max_pmd; i++) {
> +
> +		if (pfm_bv_isset(reset_pmds, i)) {
> +

Unneeded newline here (lots of places)

> +			val = pfm_new_pmd_value(set->pmds + i,
> +						reset_mode);

			val = pfm_new_pmd_value(set->pmds + i, reset_mode);


> +			set->view->set_pmds[i]= val;
> +
> +			if (not_masked) {
> +				if (pfm_bv_isset(cnt_mask, i)) {
> +					hw_val = val & ovfl_mask;
> +				} else {
> +					hw_val = val;
> +				}

Unneeded braces.

> +				pfm_write_pmd(ctx, i, hw_val);
> +			}
> +			PFM_DBG_ovfl("pmd%u set=%u sval=0x%llx",
> +				     i,
> +				     set->id,
> +				     (unsigned long long)val);
> +		}
> +	}
> +
> +	pfm_modview_end(set);
> +
> +	/*
> +	 * done with reset
> +	 */
> +	bitmap_zero(ulp(reset_pmds), max_pmd);

Let's fix the bitmap code.

> +	/*
> +	 * make changes visible
> +	 */
> +	if (not_masked)
> +		pfm_arch_serialize();
> +}
> +
>
> ...
>
> +/*
> + * called from pfm_handle_work() and __pfm_restart()
> + * for system-wide and per-thread context.
> + */
> +static void pfm_resume_after_ovfl(struct pfm_context *ctx)
> +{
> +	struct pfm_smpl_fmt *fmt;
> +	u32 rst_ctrl;
> +	struct pfm_event_set *set;
> +	u64 *reset_pmds;
> +	void *hdr;
> +	int state, ret;
> +
> +	hdr = ctx->smpl_addr;
> +	fmt = ctx->smpl_fmt;
> +	state = ctx->state;
> +	set = ctx->active_set;
> +	ret = 0;
> +
> +	if (hdr) {
> +		rst_ctrl = 0;
> +		prefetch(hdr);
> +		if (fmt->fmt_restart)
> +			ret = (*fmt->fmt_restart)(state == PFM_CTX_LOADED,
> +					  	  &rst_ctrl, hdr);
> +	} else {
> +		rst_ctrl= PFM_OVFL_CTRL_RESET;
> +	}
> +	reset_pmds = set->reset_pmds;
> +
> +	PFM_DBG("restart=%d set=%u r_pmds=0x%llx switch=%d ctx_state=%d",
> +		ret,
> +		set->id,
> +		(unsigned long long)reset_pmds[0],
> +		!(set->priv_flags & PFM_SETFL_PRIV_SWITCH),
> +		state);
> +
> +	if (!ret) {
> +		/*
> +		 * switch set if needed
> +		 */
> +		if (set->priv_flags & PFM_SETFL_PRIV_SWITCH) {
> +			set->priv_flags &= ~PFM_SETFL_PRIV_SWITCH;
> +			pfm_switch_sets(ctx, NULL, PFM_PMD_RESET_LONG, 0);
> +			set = ctx->active_set;

I assume there's some locking in place for all of this.  If so, it's useful
to mention that in the function's introductory comment block - it's rather
important.

Or stick an assert_spin_locked() in there, which is rather stronger...

> +		} else if (rst_ctrl & PFM_OVFL_CTRL_RESET) {
> +			if (!bitmap_empty(ulp(set->reset_pmds), pfm_pmu_conf->max_pmd))
> +				pfm_reset_pmds(ctx, set, PFM_PMD_RESET_LONG);
> +		}
> +
> +		if (!(rst_ctrl & PFM_OVFL_CTRL_MASK)) {
> +			pfm_unmask_monitoring(ctx);
> +		} else {
> +			PFM_DBG("stopping monitoring?");
> +		}

braces...

> +		ctx->state = PFM_CTX_LOADED;
> +	}
> +	ctx->flags.can_restart = 0;
> +}
> +
>
> ...
>
> +/*
> + * pfm_handle_work() can be called with interrupts enabled
> + * (TIF_NEED_RESCHED) or disabled. The down_interruptible
> + * call may sleep, therefore we must re-enable interrupts
> + * to avoid deadlocks. It is safe to do so because this function
> + * is called ONLY when returning to user level (PUStk=1), in which case
> + * there is no risk of kernel stack overflow due to deep
> + * interrupt nesting.
> + *
> + * input:
> + *	- current task pointer
> + */

What's PUStk?

> +void __pfm_handle_work(struct task_struct *task)
> +{
> +	struct pfm_context *ctx;
> +	unsigned long flags, dummy_flags;
> +	unsigned int reason;
> +	int ret;
> +
> +	ctx = task->pfm_context;
> +	if (ctx == NULL) {
> +		PFM_ERR("handle_work [%d] has no ctx", task->pid);
> +		return;
> +	}
> +
> +	BUG_ON(ctx->flags.system);
> +
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	clear_thread_flag(TIF_NOTIFY_RESUME);
> +
> +	/*
> +	 * extract reason for being here and clear
> +	 */
> +	reason = ctx->flags.trap_reason;
> +
> +	if (reason == PFM_TRAP_REASON_NONE)
> +		goto nothing_to_do;
> +
> +	ctx->flags.trap_reason = PFM_TRAP_REASON_NONE;
> +
> +	PFM_DBG("reason=%d state=%d", reason, ctx->state);
> +
> +	/*
> +	 * must be done before we check for simple-reset mode
> +	 */
> +	if (ctx->state == PFM_CTX_ZOMBIE)
> +		goto do_zombie;
> +
> +	if (reason == PFM_TRAP_REASON_RESET)
> +		goto skip_blocking;
> +
> +	/*
> +	 * restore interrupt mask to what it was on entry.
> +	 * Could be enabled/diasbled.
> +	 */
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	/*
> +	 * force interrupt enable because of down_interruptible()
> +	 */
> +	local_irq_enable();
> +
> +	PFM_DBG("before block sleeping");
> +
> +	/*
> +	 * may go through without blocking on SMP systems
> +	 * if restart has been received already by the time we call down()
> +	 */
> +	ret = wait_for_completion_interruptible(&ctx->restart_complete);
> +
> +	PFM_DBG("after block sleeping ret=%d", ret);
> +
> +	/*
> +	 * lock context and mask interrupts again
> +	 * We save flags into a dummy because we may have
> +	 * altered interrupts mask compared to entry in this
> +	 * function.
> +	 */
> +	spin_lock_irqsave(&ctx->lock, dummy_flags);
> +
> +	if (ctx->state == PFM_CTX_ZOMBIE)
> +		goto do_zombie;
> +
> +	/*
> +	 * in case of interruption of down() we don't restart anything
> +	 */
> +	if (ret < 0)
> +		goto nothing_to_do;
> +
> +skip_blocking:
> +	pfm_resume_after_ovfl(ctx);
> +
> +nothing_to_do:
> +
> +	/*
> +	 * restore flags as they were upon entry
> +	 */
> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +	return;
> +
> +do_zombie:
> +	PFM_DBG("context is zombie, bailing out");
> +
> +	__pfm_unload_context(ctx, 0);
> +
> +	/*
> +	 * enable interrupt for vfree()
> +	 */
> +	local_irq_enable();
> +
> +	/*
> +	 * actual context free
> +	 */
> +	pfm_context_free(ctx);
> +
> +	/*
> +	 * restore interrupts as they were upon entry
> +	 */
> +	local_irq_restore(flags);
> +}

Yeah, the local_irq handling here is unpleasing.

> +/*
> + * called only from exit_thread(): task == current
> + * we come here only if current has a context
> + * attached (loaded or masked or zombie)
> + */
> +void __pfm_exit_thread(struct task_struct *task)
> +{
> +	struct pfm_context *ctx;
> +	unsigned long flags;
> +	int free_ok = 0;
> +
> +	ctx  = task->pfm_context;
> +
> +	BUG_ON(ctx->flags.system);
> +
> +	spin_lock_irqsave(&ctx->lock, flags);
> +
> +	PFM_DBG("state=%d", ctx->state);
> +
> +	/*
> +	 * __pfm_unload_context() cannot fail
> +	 * in the context states we are interested in
> +	 */
> +	switch(ctx->state) {
              ^ space, please.

> +		case PFM_CTX_LOADED:
> +		case PFM_CTX_MASKED:
> +			__pfm_unload_context(ctx, 0);
> +			pfm_end_notify_user(ctx);
> +			break;
> +		case PFM_CTX_ZOMBIE:
> +			__pfm_unload_context(ctx, 0);
> +			free_ok = 1;
> +			break;
> +		default:
> +			BUG_ON(ctx->state != PFM_CTX_LOADED);
> +			break;
> +	}

We normally indent switch statement bodies one tabstop less than this.

> +	spin_unlock_irqrestore(&ctx->lock, flags);
> +
> +	/*
> +	 * All memory free operations (especially for vmalloc'ed memory)
> +	 * MUST be done with interrupts ENABLED.
> +	 */
> +	if (free_ok)
> +		pfm_context_free(ctx);
> +}
> +
> +/*
> + * this function is called from pfm_init()
> + * pfm_pmu_conf is NULL at this point
> + */
> +void __cpuinit pfm_init_percpu (void *dummy)
                                 ^ no space ;)

> +{
> +	pfm_arch_init_percpu();
> +}
> +
> +/*
> + * global initialization routine, executed only once
> + */
> +int __init pfm_init(void)
> +{
> +	int ret;
> +
> +	PFM_LOG("version %u.%u", PFM_VERSION_MAJ, PFM_VERSION_MIN);
> +
> +	pfm_ctx_cachep = kmem_cache_create("pfm_context",
> +				   sizeof(struct pfm_context)+PFM_ARCH_CTX_SIZE,
> +				   SLAB_HWCACHE_ALIGN, 0, NULL, NULL);
> +	if (pfm_ctx_cachep == NULL) {
> +		PFM_ERR("cannot initialize context slab");
> +		goto error_disable;
> +	}
> +	ret = pfm_sets_init();
> +	if (ret)
> +		goto error_disable;
> +
> +
> +	if (pfm_sysfs_init())
> +		goto error_disable;
> +
> +	/*
> +	 * one time, global initialization
> +	 */
> +	if (pfm_arch_initialize())
> +		goto error_disable;
> +
> +	init_pfm_fs();
> +
> +	/*
> +	 * per cpu initialization (interrupts must be enabled)
> +	 */
> +	on_each_cpu(pfm_init_percpu, NULL, 1, 1);
> +
> +	return 0;
> +error_disable:
> +	return -1;
> +}

Three of these error paths will leak *pfm_ctx_cachep.  The kernel will
panic next time the module is loaded (if this is a loadable module..)

> +/*
> + * must use subsys_initcall() to ensure that the perfmon2 core
> + * is initialized before any PMU description module when they are
> + * compiled in.
> + */
> +subsys_initcall(pfm_init);
> +
> +int __pfm_start(struct pfm_context *ctx, struct pfarg_start *start)
> +{
> +	struct task_struct *task, *owner_task;
> +	struct pfm_event_set *new_set, *old_set;
> +	u64 now_itc;
> +	int is_self, flags;
> +
> +	task = ctx->task;
> +
> +	/*
> +	 * context must be loaded.
> +	 * we do not support starting while in MASKED state
> +	 * (mostly because of set switching issues)
> +	 */
> +	if (ctx->state != PFM_CTX_LOADED)
> +		return -EINVAL;
> +
> +	old_set = new_set = ctx->active_set;
> +
> +	/*
> +	 * always the case for system-wide
> +	 */
> +	if (task == NULL)
> +		task = current;
> +
> +	is_self = task == current;
> +
> +	/*
> +	 * argument is provided?
> +	 */
> +	if (start) {
> +		/*
> +		 * find the set to load first
> +		 */
> +		new_set = pfm_find_set(ctx, start->start_set, 0);
> +		if (new_set == NULL) {
> +			PFM_DBG("event set%u does not exist",
> +				start->start_set);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	PFM_DBG("cur_set=%u req_set=%u",
> +		old_set->id,
> +		new_set->id);
> +
> +	/*
> +	 * if we need to change the active set we need
> +	 * to check if we can access the PMU
> +	 */
> +	if (new_set != old_set) {
> +		owner_task = __get_cpu_var(pmu_owner);

>From this I'll assume that either a) this function is always called under
some locking (but which?) or b) it hasn't been tested with
CONFIG_DEBUG_PREEMPT.

> +		/*
> +		 * system-wide: must run on the right CPU
> +		 * per-thread : must be the owner of the PMU context
> +		 *
> +		 * pfm_switch_sets() returns with monitoring stopped
> +		 */
> +		if (is_self) {
> +			pfm_switch_sets(ctx, new_set, PFM_PMD_RESET_LONG, 1);
> +		} else {
> +			/*
> +			 * In a UP kernel, the PMU may contain the state
> +			 * of the task we want to operate on, yet the task
> +			 * may be switched out (lazy save). We need to save
> +			 * current state (old_set), switch active_set and
> +			 * mark it for reload.
> +			 */
> +			if (owner_task == task) {
> +				pfm_modview_begin(old_set);
> +				pfm_save_pmds(ctx, old_set);
> +				pfm_modview_end(old_set);
> +			}
> +			ctx->active_set = new_set;
> +			new_set->view->set_status |= PFM_SETVFL_ACTIVE;
> +			new_set->priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
> +		}
> +	}
> +	/*
> +	 * mark as started, must be done before calling
> +	 * pfm_arch_start()
> +	 */
> +	ctx->flags.started = 1;
> +
> +	/*
> +	 * at this point, monitoring is:
> +	 * 	- stopped if we switched set (self-monitoring)
> +	 * 	- stopped if never started
> +	 * 	- started if calling pfm_start() in sequence
> +	 */
> +	now_itc = pfm_arch_get_itc();
> +	flags = new_set->flags;
> +
> +	if (is_self) {
> +		unsigned long info;
> +		if (flags & PFM_SETFL_TIME_SWITCH)
> +			info = PFM_CPUINFO_TIME_SWITCH;
> +		else
> +			info = 0;
> +
> +		__get_cpu_var(pfm_syst_info) = info;
> +	}
> +	/*
> +	 * in system-wide, the new_set may EXCL_IDLE, in which
> +	 * case pfm_start() must actually stop monitoring
> +	 */
> +	if (current->pid == 0 && (flags & PFM_SETFL_EXCL_IDLE))
> +		pfm_arch_stop(task, ctx, new_set);
> +	else
> +		pfm_arch_start(task, ctx, new_set);
> +
> +	/*
> +	 * we restart total duration even if context was
> +	 * already started. In that case, counts are simply
> +	 * reset.
> +	 *
> +	 * For system-wide, we start counting even when we exclude
> +	 * idle and pfm_start() called by idle.
> +	 *
> +	 * For per-thread, if not self-monitoring, the statement
> +	 * below will have no effect because thread is stopped.
> +	 * The field is reset of ctxsw in.
> +	 *
> +	 * if monitoring is masked (MASKED), this statement
> +	 * will be overriden in pfm_unmask_monitoring()
> +	 */
> +	ctx->duration_start = now_itc;
> +	new_set->duration_start = now_itc;
> +
> +	return 0;
> +}
>
> ...
>
> +/*
> + * XXX: interrupts are masked yet monitoring may be active. Hence they
> + * might be a counter overflow during the call. It will be kept pending
> + * and we might return inconsistent unless we check the state of the counter
> + * and compensate for the overflow. Note that we will not loose a sample
> + * when sampling, however, there may be an issue with simple counting and
> + * virtualization.
> + */

What issue?

> +int __pfm_read_pmds(struct pfm_context *ctx, struct pfarg_pmd *req, int count)
> +{
> +
>
> ...
>
> +int __pfm_write_pmds(struct pfm_context *ctx, struct pfarg_pmd *req, int count,
> +		     int compat)
> +{
>
> ...
>
> +				bitmap_or(ulp(set->used_pmds),
> +					  ulp(set->used_pmds),
> +					  ulp(reset_pmds), max_pmd);

argh.

> +/*
> + * should not call when task == current
> + */
> +static int pfm_bad_permissions(struct task_struct *task)
> +{
> +	/* inspired by ptrace_attach() */
> +	PFM_DBG("cur: euid=%d uid=%d gid=%d task: euid=%d "
> +		"suid=%d uid=%d egid=%d cap:%d sgid=%d",
> +		current->euid,
> +		current->uid,
> +		current->gid,
> +		task->euid,
> +		task->suid,
> +		task->uid,
> +		task->egid,
> +		task->sgid, capable(CAP_SYS_PTRACE));
> +
> +	return ((current->uid != task->euid)
> +	    || (current->uid != task->suid)
> +	    || (current->uid != task->uid)
> +	    || (current->gid != task->egid)
> +	    || (current->gid != task->sgid)
> +	    || (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE);
> +}

A comment which describes the design decisions behind this permission check
would be a pretty important improvement.

I wonder if selinux wants to get this deep into things.

> +
> +/*
> + * cannot attach if :
> + * 	- kernel task
> + * 	- task not owned by caller
> + * 	- task incompatible with context mode
> + */

there's a comment.

What does "incompatible with context mode" mean?

> +static int pfm_task_incompatible(struct pfm_context *ctx,
> +				 struct task_struct *task)
> +{
> +	/*
> +	 * no kernel task or task not owned by caller
> +	 */
> +	if (!task->mm) {
> +		PFM_DBG("cannot attach to kernel thread [%d]", task->pid);
> +		return -EPERM;
> +	}
> +
> +	if (pfm_bad_permissions(task)) {
> +		PFM_DBG("no permission to attach to [%d]", task->pid);
> +		return -EPERM;
> +	}
> +
> +	/*
> +	 * cannot block in self-monitoring mode
> +	 */
> +	if (ctx->flags.block && task == current) {
> +		PFM_DBG("cannot load a in blocking mode on self for [%d]",

tpyo.

> +			task->pid);
> +		return -EINVAL;
> +	}
> +
> +	if (task->state == EXIT_ZOMBIE || task->state == EXIT_DEAD) {

That isn't right.  These things are recorded in task_struct.exit_state, not in
task_struct.state.

> +		PFM_DBG("cannot attach to zombie/dead task [%d]", task->pid);
> +		return -EBUSY;
> +	}
> +
> +	/*
> +	 * always ok for self
> +	 */
> +	if (task == current)
> +		return 0;
> +
> +	if ((task->state != TASK_STOPPED) && (task->state != TASK_TRACED)) {
> +		PFM_DBG("cannot attach to non-stopped task [%d] state=%ld",
> +			task->pid, task->state);
> +		return -EBUSY;
> +	}
> +	PFM_DBG("before wait_inactive() task [%d] state=%ld",
> +		task->pid, task->state);
> +	/*
> +	 * make sure the task is off any CPU
> +	 */
> +	wait_task_inactive(task);

There it is again.  This is a busywait.

> +	PFM_DBG("after wait_inactive() task [%d] state=%ld",
> +		task->pid, task->state);
> +	/* more to come... */
> +
> +	return 0;
> +}
> +static int pfm_get_task(struct pfm_context *ctx, pid_t pid,
> +			struct task_struct **task)
> +{
> +	struct task_struct *p = current;
> +	int ret;
> +
> +	/* XXX: need to add more checks here */
> +	if (pid < 2)
> +		return -EPERM;

;)

What are we actually trying to do here?

> +	if (pid != current->pid) {
> +
> +		read_lock(&tasklist_lock);
> +
> +		p = find_task_by_pid(pid);
> +
> +		/* make sure task cannot go away while we operate on it */
> +		if (p)
> +			get_task_struct(p);
> +
> +		read_unlock(&tasklist_lock);
> +
> +		if (p == NULL)
> +			return -ESRCH;
> +	}
> +
> +	ret = pfm_task_incompatible(ctx, p);
> +	if (!ret) {
> +		*task = p;
> +	} else if (p != current) {
> +		put_task_struct(p);
> +	}

braces.

> +	return ret;
> +}
> +
> +static int pfm_check_task_exist(struct pfm_context *ctx)
> +{
> +	struct task_struct *g, *t;
> +	int ret = -ESRCH;
> +
> +	read_lock(&tasklist_lock);
> +
> +	do_each_thread (g, t) {
                      ^ space

> +		if (t->pfm_context == ctx) {
> +			ret = 0;
> +			break;
> +		}
> +	} while_each_thread (g, t);

again

> +	read_unlock(&tasklist_lock);
> +
> +	PFM_DBG("ret=%d ctx=%p", ret, ctx);
> +
> +	return ret;
> +}

These functions are expensive.  Hopefully not called much?

> +
> +static int pfm_load_context_thread(struct pfm_context *ctx, pid_t pid,
> +				   struct pfm_event_set *set)
> +{
> +	struct task_struct *task = NULL;
> +	struct pfm_context *old;
> +	u32 set_flags;
> +	unsigned long info;
> +	int ret, state;
> +
> +	state = ctx->state;
> +	set_flags = set->flags;
> +
> +	PFM_DBG("load_pid [%d] set=%u runs=%llu set_flags=0x%x",
> +		pid,
> +		set->id,
> +		(unsigned long long)set->view->set_runs,
> +		set_flags);
> +
> +	if (ctx->flags.block && pid == current->pid) {
> +		PFM_DBG("cannot use blocking mode in while self-monitoring");
> +		return -EINVAL;
> +	}
> +
> +	ret = pfm_get_task(ctx, pid, &task);
> +	if (ret) {
> +		PFM_DBG("load_pid [%d] get_task=%d", pid, ret);
> +		return ret;
> +	}
> +
> +	ret = pfm_arch_load_context(ctx, task);
> +	if (ret) {
> +		put_task_struct(task);

Further down, we only do put_task_struct() if task!=current.

> +		return ret;
> +	}
> +
> +	/*
> +	 * now reserve the session
> +	 */
> +	ret = pfm_reserve_session(ctx, -1);
> +	if (ret)
> +		goto error;
> +
> +	/*
> +	 * task is necessarily stopped at this point.
> +	 *
> +	 * If the previous context was zombie, then it got removed in
> +	 * pfm_ctxswout_thread(). Therefore we should not see it here.
> +	 * If we see a context, then this is an active context
> +	 *
> +	 */
> +	PFM_DBG("before cmpxchg() old_ctx=%p new_ctx=%p",
> +		task->pfm_context, ctx);
> +
> +	ret = -EEXIST;
> +
> +	old = cmpxchg(&task->pfm_context, NULL, ctx);
> +	if (old != NULL) {
> +		PFM_DBG("load_pid [%d] has already a context "
> +			"old=%p new=%p cur=%p",
> +			pid,
> +			old,
> +			ctx,
> +			task->pfm_context);
> +		goto error_unres;
> +	}
> +
> +	/*
> +	 * link context to task
> +	 */
> +	ctx->task = task;
> +	set_tsk_thread_flag(task, TIF_PERFMON);
> +
> +	/*
> +	 * commit active set
> +	 */
> +	ctx->active_set = set;
> +
> +	pfm_modview_begin(set);
> +
> +	set->view->set_runs++;

Locking for this increment?

> +	set->view->set_status |= PFM_SETVFL_ACTIVE;

and for this?

> +	/*
> +	 * self-monitoring
> +	 */
> +	if (task == current) {
> +#ifndef CONFIG_SMP
> +		struct pfm_context *ctxp;
> +
> +		/*
> +		 * in UP per-thread, due to lazy save
> +		 * there could be a context from another
> +		 * task. We need to push it first before
> +		 * installing our new state
> +		 */
> +		ctxp = __get_cpu_var(pmu_ctx);

This code does smp_processor_id() a lot.  Hopefully it's all preempt-correct..

> +		if (ctxp) {
> +			struct pfm_event_set *setp;
> +			setp = ctxp->active_set;
> +			pfm_modview_begin(setp);
> +			pfm_save_pmds(ctxp, setp);
> +			setp->view->set_status &= ~PFM_SETVFL_ACTIVE;
> +			pfm_modview_end(setp);
> +			/*
> +			 * do not clear ownership because we rewrite
> +			 * right away
> +			 */
> +		}
> +#endif
> +		pfm_set_last_cpu(ctx, smp_processor_id());
> +		pfm_inc_activation();
> +		pfm_set_activation(ctx);
> +
> +		/*
> +		 * setting PFM_CPUINFO_TIME_SWITCH, triggers
> +		 * further checking if __pfm_handle_switch_timeout().
> +		 * switch timeout is effectively decremented only once
> +		 * monitoring has been activated via pfm_start() or
> +		 * any user level equivalent.
> +		 */
> +		if (set_flags & PFM_SETFL_TIME_SWITCH) {
> +			info = PFM_CPUINFO_TIME_SWITCH;
> +			__get_cpu_var(pfm_syst_info) = info;
> +		}
> +		/*
> +		 * load all PMD from set
> +		 * load all PMC from set
> +		 */
> +		pfm_arch_restore_pmds(ctx, set);
> +		pfm_arch_restore_pmcs(ctx, set);
> +
> +		/*
> +		 * set new ownership
> +		 */
> +		pfm_set_pmu_owner(task, ctx);
> +
> +		PFM_DBG("context loaded on PMU for [%d] TIF=%d", task->pid, test_tsk_thread_flag(task, TIF_PERFMON));
> +	} else {
> +
> +		/* force a full reload */
> +		ctx->last_act = PFM_INVALID_ACTIVATION;
> +		pfm_set_last_cpu(ctx, -1);
> +		set->priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
> +		PFM_DBG("context loaded next ctxswin for [%d]", task->pid);
> +	}
> +
> +	pfm_modview_end(set);
> +
> +	ret = 0;
> +
> +error_unres:
> +	if (ret)
> +		pfm_release_session(ctx, -1);
> +error:
> +	/*
> +	 * release task, there is now a link with the context
> +	 */
> +	if (task != current) {
> +		put_task_struct(task);
> +
> +		if (!ret) {
> +			ret = pfm_check_task_exist(ctx);
> +			if (ret) {
> +				ctx->state = PFM_CTX_UNLOADED;
> +				ctx->task = NULL;
> +			}
> +		}
> +	}
> +	return ret;
> +}
>
> ...
>
> +int __pfm_unload_context(struct pfm_context *ctx, int defer_release)

It's fairly unfruitful reviewing functions when you don't know what they
do.  Comments really help.


