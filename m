Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262695AbTCJCxc>; Sun, 9 Mar 2003 21:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262698AbTCJCxc>; Sun, 9 Mar 2003 21:53:32 -0500
Received: from holomorphy.com ([66.224.33.161]:40627 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262695AbTCJCxb>;
	Sun, 9 Mar 2003 21:53:31 -0500
Date: Sun, 9 Mar 2003 19:00:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFT] port of Lockmeter on i386 2.5.64 Patch
Message-ID: <20030310030059.GJ465@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <149620000.1047264510@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149620000.1047264510@w-hlinder>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 06:48:30PM -0800, Hanna Linder wrote:
> +/*
> + * Currently, the mips64 and sparc64 kernels talk to a 32-bit lockstat, so we
> + * need to force compatibility in the inter-communication data structure.
> + */
> +
> +#if defined(CONFIG_MIPS32_COMPAT)
> +#define TIME_T		uint32_t
> +#elif defined(CONFIG_SPARC32_COMPAT)
> +#define TIME_T		uint64_t
> +#else
> +#define TIME_T		time_t
> +#endif

Hmm, is there a way to inherit this from arch code?


On Sun, Mar 09, 2003 at 06:48:30PM -0800, Hanna Linder wrote:
> +#if defined(__KERNEL__) || (!defined(CONFIG_MIPS32_COMPAT) && !defined(CONFIG_SPARC32_COMPAT)) || (_MIPS_SZLONG==32)
> +#define POINTER		void *
> +#else
> +#define	POINTER		int64_t
> +#endif

What on earth? Shouldn't this be done some other way?

I really think 32-bit compatibility should be mostly ignored; userspace
should just be rearranged to understand it's looking at a 64-bit kernel
even when running in a 32-bit userspace.


On Sun, Mar 09, 2003 at 06:48:30PM -0800, Hanna Linder wrote:
> +#ifdef USER_MODE_TESTING
> +	rwlock_t    entry_lock;           /* lock for this read lock entry... */
> +	                                  /* avoid having more than one rdr at*/
> +	                                  /* needed for user space testing... */
> +	                                  /* not needed for kernel 'cause it  */
> +					  /* is non-preemptive. ............. */
> +#endif

Hmm, USER_MODE_TESTING can probably just go.


On Sun, Mar 09, 2003 at 06:48:30PM -0800, Hanna Linder wrote:
>  #define spin_unlock_irqrestore(lock, flags) \
>  do { \
> -	_raw_spin_unlock(lock); \
> +	spin_unlock(lock); \
>  	local_irq_restore(flags); \
>  	preempt_enable(); \
>  } while (0)

Erm, is this safe? there's a reason _raw_spin_unlock() is used here, for
the CONFIG_PREEMPT stuff basically. It'd look less disturbing if the old
names and semantics were preserved.


On Sun, Mar 09, 2003 at 06:48:30PM -0800, Hanna Linder wrote:
> +#ifdef DEBUG_LOCKMETER
> +		printk("put_lockmeter_info(cpu=%d): LSTAT_ON\n",THIS_CPU_NUMBER);
> +#endif

DEBUG_LOCKMETER should probably go away for merging.

All in all I'm glad to have this back. It'd be a valuable addition to
CONFIG_PROFILING once things are lined up with Linux conventions.
Despite a little bit of crustiness inherited from before ppl were used
to Linux conventions it's still pretty smooth.


-- wli
