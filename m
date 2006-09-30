Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWI3Itb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWI3Itb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWI3Itb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:49:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751171AbWI3Ita (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:49:30 -0400
Date: Sat, 30 Sep 2006 01:49:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 22/23] dynticks: increase SLAB timeouts
Message-Id: <20060930014904.76ed3f9b.akpm@osdl.org>
In-Reply-To: <20060929234441.323486000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234441.323486000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:42 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> decrease the rate of SLAB timers going off. Reduces the amount
> of timers going off in an idle system.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> --
>  mm/slab.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.18-mm2/mm/slab.c
> ===================================================================
> --- linux-2.6.18-mm2.orig/mm/slab.c	2006-09-30 01:41:09.000000000 +0200
> +++ linux-2.6.18-mm2/mm/slab.c	2006-09-30 01:41:20.000000000 +0200
> @@ -457,8 +457,13 @@ struct kmem_cache {
>   * OTOH the cpuarrays can contain lots of objects,
>   * which could lock up otherwise freeable slabs.
>   */
> -#define REAPTIMEOUT_CPUC	(2*HZ)
> -#define REAPTIMEOUT_LIST3	(4*HZ)
> +#ifdef CONFIG_NO_HZ
> +# define REAPTIMEOUT_CPUC	(4*HZ)
> +# define REAPTIMEOUT_LIST3	(8*HZ)
> +#else
> +# define REAPTIMEOUT_CPUC	(2*HZ)
> +# define REAPTIMEOUT_LIST3	(4*HZ)
> +#endif
>  
>  #if STATS
>  #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
> 

err, no.

a) We shouldn't go and assume that "No Hz" implies "I want the CPU to
   remain idle for long periods".

   It's a good assumption, but that is an *application* of NO_HZ and the
   above should be a separate configuration option.  Or, better, runtime
   configurable.

b) This reap timeout is there for a reason.  We shouldn't just go and
   modify memory management behaviour because someone selected NO_HZ.

   Again, a runtime tunable is preferable.

Then again, two seconds is quite a long time, surely?  And increasing it to
just four seconds hardly seems worth the effort.


Still, the code you're patching is pretty lame anyway.  It shouldn't be
using time.  Time is meaningless in the mm context.  I'm not sure what it
_should_ be using though.  Perhaps every-Nth-kmem_cache_alloc or something.

It's trying to measure "is this memory I'm holding likely to be in the
CPU's cache any more".  So perhaps time is a close-enough basis.
