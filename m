Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVEONis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVEONis (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 09:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVEONis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 09:38:48 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:9137 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261624AbVEONiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 09:38:25 -0400
Date: Sun, 15 May 2005 15:38:22 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: andrea@cpushare.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Dave Jones <davej@redhat.com>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <20050514154538.GB6695@g5.random>
Message-ID: <Pine.LNX.4.58.0505151533180.8633@artax.karlin.mff.cuni.cz>
References: <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
 <20050513215905.GY5914@waste.org> <1116024419.20646.41.camel@localhost.localdomain>
 <1116025212.6380.50.camel@mindpipe> <20050513232708.GC13846@redhat.com>
 <1116027488.6380.55.camel@mindpipe> <1116084186.20545.47.camel@localhost.localdomain>
 <20050514154538.GB6695@g5.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 May 2005 andrea@cpushare.com wrote:

> On Sat, May 14, 2005 at 04:23:10PM +0100, Alan Cox wrote:
> > You cannot use rdtsc for anything but rough instruction timing. The
> > timers for different processors run at different speeds on some SMP
> > systems, the timer rates vary as processors change clock rate nowdays.
> > Rdtsc may also jump dramatically on a suspend/resume.
>
> x86-64 uses it for vgettimeofday very safely (i386 could do too but it
> doesn't).
>
> Anyway I believe at least for seccomp it's worth to turn off the tsc,
> not just for HT but for the L2 cache too. So it's up to you, either you
> turn it off completely (which isn't very nice IMHO) or I recommend to
> apply this below patch. This has been tested successfully on x86-64
> against current cogito repository (i686 compiles so I didn't bother
> testing ;). People selling the cpu through cpushare may appreciate this
> bit for a peace of mind. There's no way to get any timing info anymore
> with this applied (gettimeofday is forbidden of course).

Another possibility to get timing is from direct-io --- i.e. initiate
direct io read, wait until one cache line contains new data and you can be
sure that the next will contain new data in certain time. IDE controller
bus master operation acts here as a timer.

Mikulas

> The seccomp
> environment is completely deterministic so it can't be allowed to get
> timing info, it has to be deterministic so in the future I can enable a
> computing mode that does a parallel computing for each task with server
> side transparent checkpointing and verification that the output is the
> same from all the 2/3 seller computers for each task, without the buyer
> even noticing (for now the verification is left to the buyer client
> side and there's no checkpointing, since that would require more kernel
> changes to track the dirty bits but it'll be easy to extend once the
> basic mode is finished).
>
> Thanks.
>
> Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>
>
> Index: arch/i386/kernel/process.c
> ===================================================================
> --- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/i386/kernel/process.c  (mode:100644)
> +++ uncommitted/arch/i386/kernel/process.c  (mode:100644)
> @@ -561,6 +561,25 @@
>  }
>
>  /*
> + * This function selects if the context switch from prev to next
> + * has to tweak the TSC disable bit in the cr4.
> + */
> +static void disable_tsc(struct thread_info *prev,
> +			struct thread_info *next)
> +{
> +	if (unlikely(has_secure_computing(prev) ||
> +		     has_secure_computing(next))) {
> +		/* slow path here */
> +		if (has_secure_computing(prev) &&
> +		    !has_secure_computing(next)) {
> +			clear_in_cr4(X86_CR4_TSD);
> +		} else if (!has_secure_computing(prev) &&
> +			   has_secure_computing(next))
> +			set_in_cr4(X86_CR4_TSD);
> +	}
> +}
> +
> +/*
>   *	switch_to(x,yn) should switch tasks from x to y.
>   *
>   * We fsave/fwait so that an exception goes off at the right time
> @@ -639,6 +658,8 @@
>  	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
>  		handle_io_bitmap(next, tss);
>
> +	disable_tsc(prev_p->thread_info, next_p->thread_info);
> +
>  	return prev_p;
>  }
>
> Index: arch/x86_64/kernel/process.c
> ===================================================================
> --- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/arch/x86_64/kernel/process.c  (mode:100644)
> +++ uncommitted/arch/x86_64/kernel/process.c  (mode:100644)
> @@ -439,6 +439,25 @@
>  }
>
>  /*
> + * This function selects if the context switch from prev to next
> + * has to tweak the TSC disable bit in the cr4.
> + */
> +static void disable_tsc(struct thread_info *prev,
> +			struct thread_info *next)
> +{
> +	if (unlikely(has_secure_computing(prev) ||
> +		     has_secure_computing(next))) {
> +		/* slow path here */
> +		if (has_secure_computing(prev) &&
> +		    !has_secure_computing(next)) {
> +			clear_in_cr4(X86_CR4_TSD);
> +		} else if (!has_secure_computing(prev) &&
> +			   has_secure_computing(next))
> +			set_in_cr4(X86_CR4_TSD);
> +	}
> +}
> +
> +/*
>   * This special macro can be used to load a debugging register
>   */
>  #define loaddebug(thread,r) set_debug(thread->debugreg ## r, r)
> @@ -556,6 +575,8 @@
>  		}
>  	}
>
> +	disable_tsc(prev_p->thread_info, next_p->thread_info);
> +
>  	return prev_p;
>  }
>
> Index: include/linux/seccomp.h
> ===================================================================
> --- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/linux/seccomp.h  (mode:100644)
> +++ uncommitted/include/linux/seccomp.h  (mode:100644)
> @@ -19,6 +19,11 @@
>  		__secure_computing(this_syscall);
>  }
>
> +static inline int has_secure_computing(struct thread_info *ti)
> +{
> +	return unlikely(test_ti_thread_flag(ti, TIF_SECCOMP));
> +}
> +
>  #else /* CONFIG_SECCOMP */
>
>  #if (__GNUC__ > 2)
> @@ -28,6 +33,7 @@
>  #endif
>
>  #define secure_computing(x) do { } while (0)
> +#define has_secure_computing(x) 0
>
>  #endif /* CONFIG_SECCOMP */
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
