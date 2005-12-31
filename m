Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVLaGqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVLaGqS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 01:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLaGqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 01:46:18 -0500
Received: from hera.kernel.org ([140.211.167.34]:31933 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751271AbVLaGqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 01:46:17 -0500
Date: Sat, 31 Dec 2005 04:46:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC] Event counters [1/3]: Basic counter functionality
Message-ID: <20051231064615.GB11069@dmt.cnet>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, Dec 20, 2005 at 03:57:33PM -0800, Christoph Lameter wrote:
> Light weight counter functions
> 
> The remaining counters in page_state after the zoned VM counter patch has been
> applied are all just for show in /proc/vmstat. They have no essential function
> for the VM and therefore we can make these counters lightweight by ignoring
> races and also allow an off switch for embedded systems that allows a building
> of a linux kernels without these counters.
> 
> The implementation of these counters is through inline code that typically
> results in a simple increment of a global memory locations.
> 
> Also
> - Rename page_state to event_state
> - Make event state an array indexed by the event item.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.15-rc5-mm3/init/Kconfig
> ===================================================================
> --- linux-2.6.15-rc5-mm3.orig/init/Kconfig	2005-12-16 11:44:09.000000000 -0800
> +++ linux-2.6.15-rc5-mm3/init/Kconfig	2005-12-20 14:15:23.000000000 -0800
> @@ -411,6 +411,15 @@ config SLAB
>  	  SLOB is more space efficient but does not scale well and is
>  	  more susceptible to fragmentation.
>  
> +config EVENT_COUNTERS

Please rename to VM_EVENT_COUNTERS or a better name.

> +	default y
> +	bool "Enable event counters for /proc/vmstat" if EMBEDDED
> +	help
> +	  Event counters are only needed to display statistics. They
> +	  have no function for the kernel itself. This option allows
> +	  the disabling of the event counters. /proc/vmstat will only
> +	  contain essential counters.
> +
>  config SERIAL_PCI
>  	depends PCI && SERIAL_8250
>  	default y
> Index: linux-2.6.15-rc5-mm3/include/linux/page-flags.h
> ===================================================================
> --- linux-2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2005-12-20 13:15:45.000000000 -0800
> +++ linux-2.6.15-rc5-mm3/include/linux/page-flags.h	2005-12-20 14:55:00.000000000 -0800
> @@ -77,120 +77,70 @@
>  #define PG_nosave_free		18	/* Free, should not be written */
>  #define PG_uncached		19	/* Page has been mapped as uncached */
>  
> +#ifdef CONFIG_EVENT_COUNTERS
>  /*
> - * Global page accounting.  One instance per CPU.  Only unsigned longs are
> - * allowed.
> + * Light weight per cpu counter implementation.
>   *
> - * - Fields can be modified with xxx_page_state and xxx_page_state_zone at
> - * any time safely (which protects the instance from modification by
> - * interrupt.
> - * - The __xxx_page_state variants can be used safely when interrupts are
> - * disabled.
> - * - The __xxx_page_state variants can be used if the field is only
> - * modified from process context, or only modified from interrupt context.
> - * In this case, the field should be commented here.
> + * Note that these can race. We do not bother to enable preemption
> + * or care about interrupt races. All we care about is to have some
> + * approximate count of events.

What about this addition to the documentation above, to make it a little more 
verbose:

	The possible race scenario is restricted to kernel preemption,
	and could happen as follows:

	thread A				thread B
a)	movl    xyz(%ebp), %eax			movl    xyz(%ebp), %eax
b)	incl    %eax				incl    %eax
c)	movl    %eax, xyz(%ebp)			movl    %eax, xyz(%ebp)

Thread A can be preempted in b), and thread B succesfully increments the
counter, writing it back to memory. Now thread A resumes execution, with
its stale copy of the counter, and overwrites the current counter.

Resulting in increments lost.

However that should be relatively rare condition.

> + *
> + * Counters should only be incremented and no critical kernel component
> + * should rely on the counter values.
> + *
> + * Counters are handled completely inline. On many platforms the code
> + * generated will simply be the increment of a global address.
>   */
> -struct page_state {
> -	/*
> -	 * The below are zeroed by get_page_state().  Use get_full_page_state()
> -	 * to add up all these.
> -	 */
> -	unsigned long pgpgin;		/* Disk reads */
> -	unsigned long pgpgout;		/* Disk writes */
> -	unsigned long pswpin;		/* swap reads */
> -	unsigned long pswpout;		/* swap writes */
> -
> -	unsigned long pgalloc_high;	/* page allocations */
> -	unsigned long pgalloc_normal;
> -	unsigned long pgalloc_dma32;
> -	unsigned long pgalloc_dma;
> -
> -	unsigned long pgfree;		/* page freeings */
> -	unsigned long pgactivate;	/* pages moved inactive->active */
> -	unsigned long pgdeactivate;	/* pages moved active->inactive */
> -
> -	unsigned long pgfault;		/* faults (major+minor) */
> -	unsigned long pgmajfault;	/* faults (major only) */
> -
> -	unsigned long pgrefill_high;	/* inspected in refill_inactive_zone */
> -	unsigned long pgrefill_normal;
> -	unsigned long pgrefill_dma32;
> -	unsigned long pgrefill_dma;
> -
> -	unsigned long pgsteal_high;	/* total highmem pages reclaimed */
> -	unsigned long pgsteal_normal;
> -	unsigned long pgsteal_dma32;
> -	unsigned long pgsteal_dma;
> -
> -	unsigned long pgscan_kswapd_high;/* total highmem pages scanned */
> -	unsigned long pgscan_kswapd_normal;
> -	unsigned long pgscan_kswapd_dma32;
> -	unsigned long pgscan_kswapd_dma;
> -
> -	unsigned long pgscan_direct_high;/* total highmem pages scanned */
> -	unsigned long pgscan_direct_normal;
> -	unsigned long pgscan_direct_dma32;
> -	unsigned long pgscan_direct_dma;
> -
> -	unsigned long pginodesteal;	/* pages reclaimed via inode freeing */
> -	unsigned long slabs_scanned;	/* slab objects scanned */
> -	unsigned long kswapd_steal;	/* pages reclaimed by kswapd */
> -	unsigned long kswapd_inodesteal;/* reclaimed via kswapd inode freeing */
> -	unsigned long pageoutrun;	/* kswapd's calls to page reclaim */
> -	unsigned long allocstall;	/* direct reclaim calls */
> +#define FOR_ALL_ZONES(x) x##_DMA, x##_DMA32, x##_NORMAL, x##_HIGH
>  
> -	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
> +enum event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> +		FOR_ALL_ZONES(PGALLOC),
> +		PGFREE, PGACTIVATE, PGDEACTIVATE,
> +		PGFAULT, PGMAJFAULT,
> + 		FOR_ALL_ZONES(PGREFILL),
> + 		FOR_ALL_ZONES(PGSTEAL),
> +		FOR_ALL_ZONES(PGSCAN_KSWAPD),
> +		FOR_ALL_ZONES(PGSCAN_DIRECT),
> +		PGINODESTEAL, SLABS_SCANNED, KSWAPD_STEAL, KSWAPD_INODESTEAL,
> +		PAGEOUTRUN, ALLOCSTALL, PGROTATED,
> +		NR_EVENT_ITEMS
>  };
>  
> -extern void get_full_page_state(struct page_state *ret);
> -extern unsigned long read_page_state_offset(unsigned long offset);
> -extern void mod_page_state_offset(unsigned long offset, unsigned long delta);
> -extern void __mod_page_state_offset(unsigned long offset, unsigned long delta);
> -
> -#define read_page_state(member) \
> -	read_page_state_offset(offsetof(struct page_state, member))
> -
> -#define mod_page_state(member, delta)	\
> -	mod_page_state_offset(offsetof(struct page_state, member), (delta))
> -
> -#define __mod_page_state(member, delta)	\
> -	__mod_page_state_offset(offsetof(struct page_state, member), (delta))
> -
> -#define inc_page_state(member)		mod_page_state(member, 1UL)
> -#define dec_page_state(member)		mod_page_state(member, 0UL - 1)
> -#define add_page_state(member,delta)	mod_page_state(member, (delta))
> -#define sub_page_state(member,delta)	mod_page_state(member, 0UL - (delta))
> -
> -#define __inc_page_state(member)	__mod_page_state(member, 1UL)
> -#define __dec_page_state(member)	__mod_page_state(member, 0UL - 1)
> -#define __add_page_state(member,delta)	__mod_page_state(member, (delta))
> -#define __sub_page_state(member,delta)	__mod_page_state(member, 0UL - (delta))
> -
> -#define page_state(member) (*__page_state(offsetof(struct page_state, member)))
> -
> -#define state_zone_offset(zone, member)					\
> -({									\
> -	unsigned offset;						\
> -	if (is_highmem(zone))						\
> -		offset = offsetof(struct page_state, member##_high);	\
> -	else if (is_normal(zone))					\
> -		offset = offsetof(struct page_state, member##_normal);	\
> -	else if (is_dma32(zone))					\
> -		offset = offsetof(struct page_state, member##_dma32);	\
> -	else								\
> -		offset = offsetof(struct page_state, member##_dma);	\
> -	offset;								\
> -})
> -
> -#define __mod_page_state_zone(zone, member, delta)			\
> - do {									\
> -	__mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
> - } while (0)
> -
> -#define mod_page_state_zone(zone, member, delta)			\
> - do {									\
> -	mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
> - } while (0)
> +struct event_state {
> +	unsigned long event[NR_EVENT_ITEMS];
> +};
> +
> +DECLARE_PER_CPU(struct event_state, event_states);

Might be interesting to mark this structure as __cacheline_aligned_in_smp to
avoid unrelated data sitting in the same line?

