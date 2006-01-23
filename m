Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWAWOZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWAWOZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 09:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWAWOZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 09:25:47 -0500
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:12983 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751444AbWAWOZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 09:25:46 -0500
Date: Mon, 23 Jan 2006 06:23:16 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] 2.6.16-rc1 perfmon2 patch for review
Message-ID: <20060123142316.GC5317@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200601201520.k0KFKCdY023112@frankl.hpl.hp.com> <1137773148.28944.29.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137773148.28944.29.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan,

On Fri, Jan 20, 2006 at 08:05:48AM -0800, Bryan O'Sullivan wrote:
> On Fri, 2006-01-20 at 07:20 -0800, Stephane Eranian wrote:
> 
> > + * Fast, simple, yet decent quality random number generator based on
> > + * a paper by David G. Carta ("Two Fast Implementations of the
> > + * `Minimal Standard' Random Number Generator," Communications of the
> > + * ACM, January, 1990).
> 
> What on earth do you need a random number generator for?
> 
Good question!

Perfmon2 has support for kernel-level sampling buffer. You can
setup sampling with a kernel buffer. At the end of a sampling
period, a sample a added to the buffer. When  the buffer becomes
full, the user tool is notified. Most likely it will copy the data
out of the buffer or do some processing, then it invokes
the pfm_restart() system call to "reset" the buffer and resume
monitoring. As you'd expect, the user tool is not involved 
between samples. The next sampling period is selected by the 
kernel. It can either be a fixed period determined when the counter
was program or be randomized. Randomization is VERY important to
avoid biased samples with certain measurements. In particular,
when sampling of events that do occur very frequently. We need
a simple/cheap randomizer to move the sampling period a bit.
The Carta algorithm is very simple and provides good enough
randomization. Furthermore it is totally determined by its sedd
value so it is easy to reproduce the same pseudo-number series
if necessary.

> > + * XXX: Hack until we figure out which header file to use.
> > + *      Could use linux/random.h but then we would need
> > + *      asm-XX/random.h which does not exists yet
> > + */
> > +#ifdef __ia64__
> > +#define __HAVE_ARCH_CARTA_RANDOM32
> > +#endif
> 
> Please use the same mechanism as I did last week for __iowrite_copy32,
> instead of this ifdeffery.  If you search the archives, you'll find it.
> 

I did some search and could not find the message thread you are referring
to. Could you provide some URL?

> 
> > +	int		ctx_fd;		   /* ret arg: fd for context */
> 
> Why not an s32?

This is a file descriptor. I think most user programs think of a file
descriptor as int. Looking at the kernel code for sys_read(),it looks
like this field should instead be the using u32 date type.

> 
> > +	u32 reg_flags;	   	/* input: flags, return: reg error */
> 
> This overloading is a bit gross, if I understand it correctly.  You're
> passing in a bitmask and getting back an integer, is that right?  Or is
> it a different kind of bitmask in either direction?

You are passing a bitmask of flags. You are getting back the same
bitmask of flags + a bitmask of error in the upper bits. The idea
is that given that you are passing a vectors of structs, any one
element in the vector can cause a failure. You get the syscall
error code, but you'd like to figure out quickly which element
caused trouble. For that you simply need to scan the upper bits
of the reg_flags field.

> 
> > +/*
> > + * argument structure for pfm_write_pmds() and pfm_read_pmds()
> > + */
> > +typedef struct {
> > +	u16 reg_num;	   	/* which register */
> > +	u16 reg_set;	   	/* event set for this register */
> > +	u32 reg_flags;	   	/* input: flags, return: reg error */
> > +	u64 reg_value;	   	/* initial pmc/pmd value */
> > +	u64 reg_long_reset;	/* value to reload after notification */
> > +	u64 reg_short_reset;   	/* reset after counter overflow */
> > +	u64 reg_last_reset_val;	/* return: PMD last reset value */
> > +	u64 reg_ovfl_switch_cnt;/* #overflows before switch */
> > +	unsigned long reg_reset_pmds[PFM_PMD_BV]; /* reset on overflow */
> > +	unsigned long reg_smpl_pmds[PFM_PMD_BV];  /* record in sample */
> > +	u64 reg_smpl_eventid;  	/* opaque event identifier */
> > +	u64 reg_random_mask; 	/* bitmask used to limit random value */
> > +	u32 reg_random_seed;   	/* seed for randomization */
> > +	u32 reg_reserved2[7];	/* for future use */
> > +} pfarg_pmd_t;
> 
> If this header file is shared with userspace (it looks like it is) and
> these are syscall arguments, these should all be double-underscored
> fixed-size types, as should all other types and structs that may be used
> by userspace.  Using unsigned long, in particular, makes extra work for
> multiarch machines that will have to repack those structs.
> 

The data structure is indeed shared with user space. I do not reuse
the same perfmon.h for user applications. Instead, I have a "user"
perfmon.h (that would eventually migrate to libc). It defines the field
using the uint32_t, uint64_t notation instead.

We had a long discussion with David Gibson about the bitmask reg_*pmds[]
in the context of ABI issues on platforms running a 64-bit OS but with
both a 32-bit and 64-bit  ABIs. The number of bits in the bitmask is fixed.
When using unsigned long the number of elements in the reg_*_pmds[] array
differ between 32-bit and 64-bit but it does work. I am fine with hardcoding
those fields as u64, if people think this is more appropriate or/and more
efficient with 32-bit ABIs/architectures.

> 
> > + * default value for the user and group security parameters in
> > + * /proc/sys/kernel/perfmon
> > + */
> > +#define PFM_GROUP_PERM_ANY	-1	/* any user/group */
> 
> /proc????
> 

I must admit I don't quite follow the arguments about/sys vs. /proc if
that is what you are asking for. I'd like to understand better why 
put entries in one vs. the other.

> 
> Please don't declare functions as extern.  It's redundant, and the head
> penguins don't like the style.
> 

> Also, some comment in the header that makes it obvious where's the
> boundary between functions that are purely internal to perfmon,
> functions that can be used by other kernel subsystems (if any), and
> syscalls would be useful.
> 

Will do that.

> > +/* use for IA-64 only */
> > +#ifdef __ia64__
> > +#define pfm_release_dbregs(_t) 		do { } while (0)
> > +#define pfm_use_dbregs(_t)     		(0)
> > +#endif
> 
> Please move this to asm-ia64/perfmon.h, then.
> 

Well the issue is that this part is used whenever CONFIG_PERFMON is not
selected. perfmon.h includes <asm/perfmon.h> but only when CONFIG_PERFMON
is selected. I would have to move asm/perfmon.h at the top of perfmon.h
but it depends on some definitions in perfmon.h.


> > +/*
> > + * This header is at the beginning of the sampling buffer returned to the user.
> 
> How big are these sampling buffers, and would they be a better match for
> relayfs?

Good question again.

David Gibson suggested this a while back, same thing with Andrew Morton. The
issue is that relayfs is designed to provide per-CPU buffers. Perfmon2 sampling
buffers are used in system-wide mode where we do monitor on a per-CPU basis. So
there relayfs could work. But perfmon2 also provides kernel level sampling buffer
for per-thread sampling. There the buffer is attached to the thread not the processor
it is running on. That's where this becomes very complicated with relayfs.

Thanks for your feedback.

-- 
-Stephane
