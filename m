Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSJMOJd>; Sun, 13 Oct 2002 10:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSJMOJd>; Sun, 13 Oct 2002 10:09:33 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:12296 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261525AbSJMOJb>; Sun, 13 Oct 2002 10:09:31 -0400
Date: Sun, 13 Oct 2002 15:15:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.41: Core infrastructure 1/3
Message-ID: <20021013151520.A17134@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>
References: <3DA5188A.D5436324@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA5188A.D5436324@opersys.com>; from karim@opersys.com on Thu, Oct 10, 2002 at 02:04:58AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 02:04:58AM -0400, Karim Yaghmour wrote:
> 1) We needed to define TRUE and FALSE for the tracer. A grep for
> #define TRUE/FALSE in include/linux shows a few repeats. Shouldn't
> these be globally defined somewhere?

No.  No core code uses it, and that's for a reason.  I suggest
you simply use 1/0 instead.

> 2) The tracer uses rvmalloc/rvfree. If I remember correctly there was
> a suggestion at some point to define these globally for easier use.
> A rapid grep in drivers/ shows that quite a few drivers had copies
> of these functions in their source (especially drivers/ieee1394,
> drivers/media/video, drivers/usb/media/).

Tons of duplication.  IIRC there was a political reason not to have
common versions, but IMO the duplication is far to big nowdays to
not have a generic library version.

> +/* Structure packing within the trace */
> +#if LTT_UNPACKED_STRUCTS

who defines this?

> +/* The functions to the tracer management code */
> +int trace_set_config
> + (int,		/* Use depth to fetch eip */
> +  int,		/* Use bounds to fetch eip */
> +  int,		/* Detph to fetch eip */
> +  void *,	/* Lower bound eip address */
> +  void *);	/* Upper bound eip address */

Linux style for this would be:

extern int trace_set_config(int, int, int, void *, void *);

But, yes, that looses some info.  When doing multi-line
prototypes please at least use tabs and add the actual
parameter names (like e.g. XFS does):

extern int trace_set_config(
	int		do_depth,	/* Use depth to fetch eip */
	int		do_bounds,	/* Use bounds to fetch eip */
	int		depth,		/* Detph to fetch eip */
	void		*lower,		/* Lower bound eip address */
	void		*upper);	/* Upper bound eip address */

> +/* Generic function */
> +static inline void TRACE_EVENT(u8 event_id, void* data)
> +{
> +	trace_event(event_id, data);
> +}

Umm, why don't you just use trace_even in the actual code?

> +/* Traced events */
> +#define TRACE_EV_START           0	/* This is to mark the trace's start */
> +#define TRACE_EV_SYSCALL_ENTRY   1	/* Entry in a given system call */
> +#define TRACE_EV_SYSCALL_EXIT    2	/* Exit from a given system call */
> +#define TRACE_EV_TRAP_ENTRY      3	/* Entry in a trap */
> +#define TRACE_EV_TRAP_EXIT       4	/* Exit from a trap */
> +#define TRACE_EV_IRQ_ENTRY       5	/* Entry in an irq */
> +#define TRACE_EV_IRQ_EXIT        6	/* Exit from an irq */
> +#define TRACE_EV_SCHEDCHANGE     7	/* Scheduling change */
> +#define TRACE_EV_KERNEL_TIMER    8	/* The kernel timer routine has been called */
> +#define TRACE_EV_SOFT_IRQ        9	/* Hit key part of soft-irq management */
> +#define TRACE_EV_PROCESS        10	/* Hit key part of process management */
> +#define TRACE_EV_FILE_SYSTEM    11	/* Hit key part of file system */
> +#define TRACE_EV_TIMER          12	/* Hit key part of timer management */
> +#define TRACE_EV_MEMORY         13	/* Hit key part of memory management */
> +#define TRACE_EV_SOCKET         14	/* Hit key part of socket communication */
> +#define TRACE_EV_IPC            15	/* Hit key part of System V IPC */
> +#define TRACE_EV_NETWORK        16	/* Hit key part of network communication */
> +
> +#define TRACE_EV_BUFFER_START   17	/* Mark the begining of a trace buffer */
> +#define TRACE_EV_BUFFER_END     18	/* Mark the ending of a trace buffer */
> +#define TRACE_EV_NEW_EVENT      19	/* New event type */
> +#define TRACE_EV_CUSTOM         20	/* Custom event */
> +
> +#define TRACE_EV_CHANGE_MASK    21	/* Change in event mask */
> +
> +#define TRACE_EV_HEARTBEAT      22	/* Heartbeat event */

What about an enum?

> +#ifdef CONFIG_X86_TSC
> +#include <asm/msr.h>
> +#endif
> +
> +/**
> + *	calc_time_delta: - Utility function for time delta calculation.
> + *	@now: current time
> + *	@start: start time
> + *
> + *	Returns the time delta produced by subtracting start time from now.
> + */
> +static inline trace_time_delta calc_time_delta(struct timeval *now, 
> +					       struct timeval *start)
> +{
> +	return (now->tv_sec - start->tv_sec) * 1000000
> +		+ (now->tv_usec - start->tv_usec);
> +}
> +
> +/**
> + *	recalc_time_delta: - Utility function for time delta recalculation.
> + *	@now: current time
> + *	@new_delta: the new time delta calculated
> + *	@cpu: the associated CPU id
> + *
> + *	Sets the value pointed to by new_delta to the time difference between
> + *	the buffer start time and now, if TSC timestamping is being used. 
> + */
> +static inline void recalc_time_delta(struct timeval *now, 
> +				     trace_time_delta *new_delta,
> +				     u8 cpu)
> +{
> +	if(using_tsc == FALSE)
> +		*new_delta = calc_time_delta(now, &buffer_start_time(cpu));
> +}
> +
> +/**
> + *	get_time_delta: - Utility function for getting time delta.
> + *	@now: pointer to a timeval struct that may be given current time
> + *	@cpu: the associated CPU id
> + *
> + *	Returns either the TSC if TSCs are being used, or the time and the
> + *	time difference between the current time and the buffer start time 
> + *	if TSCs are not being used.  The time is returned so that callers
> + *	can use the do_gettimeofday() result if they need to.
> + */
> +static inline trace_time_delta get_time_delta(struct timeval *now, u8 cpu)
> +{
> +	trace_time_delta time_delta;
> +
> +#if defined (__i386__) || defined (__x86_64__)
> +	if((using_tsc == TRUE) && cpu_has_tsc)
> +		rdtscl(time_delta);
> +	else {
> +		do_gettimeofday(now);
> +		time_delta = calc_time_delta(now, &buffer_start_time(cpu));
> +	}
> +#else	
> +	do_gettimeofday(now);
> +	time_delta = calc_time_delta(now, &buffer_start_time(cpu));
> +#endif
> +
> +	return time_delta;
> +}

Instead of adding per-arch stuff here I'd suggest using asm/trace.h
with an asm-generic/trace.h for the default version.

