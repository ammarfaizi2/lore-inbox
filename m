Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVGRFxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVGRFxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 01:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVGRFxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 01:53:51 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:43457 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261283AbVGRFxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 01:53:50 -0400
Date: Mon, 18 Jul 2005 07:53:49 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Peter Osterlund <petero2@telia.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>,
       "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" 
	<k.s.matheussen@notam02.no>,
       Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       christoph@lameter.org
Subject: Re: High irq load (Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt)
Message-ID: <20050718055349.GA30667@MAIL.13thfloor.at>
Mail-Followup-To: Peter Osterlund <petero2@telia.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Lee Revell <rlrevell@joe-job.com>,
	"Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" <k.s.matheussen@notam02.no>,
	Chris Friesen <cfriesen@nortel.com>,
	Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
	akpm@osdl.org, cw@f00f.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	christoph@lameter.org
References: <42D2D912.3090505@nortel.com> <1121128260.2632.12.camel@mindpipe> <165840000.1121141256@[10.10.2.4]> <1121141602.2632.31.camel@mindpipe> <188690000.1121142633@[10.10.2.4]> <1121201925.10580.24.camel@mindpipe> <278570000.1121206956@flay> <Pine.LNX.4.61.0507131237130.14635@yvahk01.tjqt.qr> <Pine.LNX.4.58.0507131128100.17536@g5.osdl.org> <m3zmsppirb.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3zmsppirb.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 04:25:12PM +0200, Peter Osterlund wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Wed, 13 Jul 2005, Jan Engelhardt wrote:
> > > 
> > > No, some kernel code causes a triple-fault-and-reboot when the HZ is >=
> > > 10KHz. Maybe the highest possible value is 8192 Hz, not sure.
> > 
> > Can you post the triple-fault message? It really shouldn't triple-fault, 
> > although it _will_ obviously spend all time just doing timer interrupts, 
> > so it shouldn't get much (if any) real work done either.
> ...
> > There should be no conceptual "highest possible HZ", although there are 
> > certainly obvious practical limits to it (both on the timer hw itself, and 
> > just the fact that at some point we'll spend all time on the timer 
> > interrupt and won't get anything done..)
> 
> HZ=10000 appears to work fine here after some hacks to avoid
> over/underflows in integer arithmetics. gkrellm reports about 3-4% CPU
> usage when the system is idle, on a 3.07 GHz P4.

yep, we've gone up to 20kHz actually, but this
requires some changes to long lasting network
timeouts :)

nevertheless 20Hz-20kHz works fine on 'most'
archs ...

best,
Herbert

> ---
> 
>  Makefile                                    |    2 +-
>  arch/i386/kernel/cpu/proc.c                 |    6 ++++++
>  fs/nfsd/nfssvc.c                            |    2 +-
>  include/linux/jiffies.h                     |    6 ++++++
>  include/linux/nfsd/stats.h                  |    4 ++++
>  include/linux/timex.h                       |    2 +-
>  include/net/tcp.h                           |   12 +++++++++---
>  init/calibrate.c                            |   21 +++++++++++++++++++++
>  kernel/Kconfig.hz                           |    6 ++++++
>  kernel/timer.c                              |    4 ++--
>  net/ipv4/netfilter/ip_conntrack_proto_tcp.c |    2 +-
>  11 files changed, 58 insertions(+), 9 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 6
>  SUBLEVEL = 13
> -EXTRAVERSION =-rc3
> +EXTRAVERSION =-rc3-test
>  NAME=Woozy Numbat
>  
>  # *DOCUMENTATION*
> diff --git a/arch/i386/kernel/cpu/proc.c b/arch/i386/kernel/cpu/proc.c
> --- a/arch/i386/kernel/cpu/proc.c
> +++ b/arch/i386/kernel/cpu/proc.c
> @@ -128,9 +128,15 @@ static int show_cpuinfo(struct seq_file 
>  		     x86_cap_flags[i] != NULL )
>  			seq_printf(m, " %s", x86_cap_flags[i]);
>  
> +#if HZ <= 5000
>  	seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
>  		     c->loops_per_jiffy/(500000/HZ),
>  		     (c->loops_per_jiffy/(5000/HZ)) % 100);
> +#else
> +	seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
> +		     c->loops_per_jiffy/(500000/HZ),
> +		     (c->loops_per_jiffy*(HZ/5000)) % 100);
> +#endif
>  
>  	return 0;
>  }
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -160,7 +160,7 @@ update_thread_usage(int busy_threads)
>  	decile = busy_threads*10/nfsdstats.th_cnt;
>  	if (decile>0 && decile <= 10) {
>  		diff = nfsd_last_call - prev_call;
> -		if ( (nfsdstats.th_usage[decile-1] += diff) >= NFSD_USAGE_WRAP)
> +		if ( (nfsdstats.th_usage[decile-1] += diff) >= NFSD_USAGE_WRAP) 
>  			nfsdstats.th_usage[decile-1] -= NFSD_USAGE_WRAP;
>  		if (decile == 10)
>  			nfsdstats.th_fullcnt++;
> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -38,6 +38,12 @@
>  # define SHIFT_HZ	9
>  #elif HZ >= 768 && HZ < 1536
>  # define SHIFT_HZ	10
> +#elif HZ >= 1536 && HZ < 3072
> +# define SHIFT_HZ	11
> +#elif HZ >= 3072 && HZ < 6144
> +# define SHIFT_HZ	12
> +#elif HZ >= 6144 && HZ < 12288
> +# define SHIFT_HZ	13
>  #else
>  # error You lose.
>  #endif
> diff --git a/include/linux/nfsd/stats.h b/include/linux/nfsd/stats.h
> --- a/include/linux/nfsd/stats.h
> +++ b/include/linux/nfsd/stats.h
> @@ -30,7 +30,11 @@ struct nfsd_stats {
>  };
>  
>  /* thread usage wraps very million seconds (approx one fortnight) */
> +#if HZ < 2048
>  #define	NFSD_USAGE_WRAP	(HZ*1000000)
> +#else
> +#define	NFSD_USAGE_WRAP	(2048*1000000)
> +#endif
>  
>  #ifdef __KERNEL__
>  
> diff --git a/include/linux/timex.h b/include/linux/timex.h
> --- a/include/linux/timex.h
> +++ b/include/linux/timex.h
> @@ -90,7 +90,7 @@
>   *
>   * FINENSEC is 1 ns in SHIFT_UPDATE units of the time_phase variable.
>   */
> -#define SHIFT_SCALE 22		/* phase scale (shift) */
> +#define SHIFT_SCALE 25		/* phase scale (shift) */
>  #define SHIFT_UPDATE (SHIFT_KG + MAXTC) /* time offset scale (shift) */
>  #define SHIFT_USEC 16		/* frequency offset scale (shift) */
>  #define FINENSEC (1L << (SHIFT_SCALE - 10)) /* ~1 ns in phase units */
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -486,8 +486,8 @@ static __inline__ int tcp_sk_listen_hash
>     so that we select tick to get range about 4 seconds.
>   */
>  
> -#if HZ <= 16 || HZ > 4096
> -# error Unsupported: HZ <= 16 or HZ > 4096
> +#if HZ <= 16
> +# error Unsupported: HZ <= 16
>  #elif HZ <= 32
>  # define TCP_TW_RECYCLE_TICK (5+2-TCP_TW_RECYCLE_SLOTS_LOG)
>  #elif HZ <= 64
> @@ -502,8 +502,14 @@ static __inline__ int tcp_sk_listen_hash
>  # define TCP_TW_RECYCLE_TICK (10+2-TCP_TW_RECYCLE_SLOTS_LOG)
>  #elif HZ <= 2048
>  # define TCP_TW_RECYCLE_TICK (11+2-TCP_TW_RECYCLE_SLOTS_LOG)
> -#else
> +#elif HZ <= 4096
>  # define TCP_TW_RECYCLE_TICK (12+2-TCP_TW_RECYCLE_SLOTS_LOG)
> +#elif HZ <= 8192
> +# define TCP_TW_RECYCLE_TICK (13+2-TCP_TW_RECYCLE_SLOTS_LOG)
> +#elif HZ <= 16384
> +# define TCP_TW_RECYCLE_TICK (14+2-TCP_TW_RECYCLE_SLOTS_LOG)
> +#else
> +# error Unsupported: HZ > 16384
>  #endif
>  /*
>   *	TCP option
> diff --git a/init/calibrate.c b/init/calibrate.c
> --- a/init/calibrate.c
> +++ b/init/calibrate.c
> @@ -119,16 +119,30 @@ void __devinit calibrate_delay(void)
>  
>  	if (preset_lpj) {
>  		loops_per_jiffy = preset_lpj;
> +#if HZ <= 5000
>  		printk("Calibrating delay loop (skipped)... "
>  			"%lu.%02lu BogoMIPS preset\n",
>  			loops_per_jiffy/(500000/HZ),
>  			(loops_per_jiffy/(5000/HZ)) % 100);
> +#else
> +		printk("Calibrating delay loop (skipped)... "
> +			"%lu.%02lu BogoMIPS preset\n",
> +			loops_per_jiffy/(500000/HZ),
> +			(loops_per_jiffy*(HZ/5000)) % 100);
> +#endif
>  	} else if ((loops_per_jiffy = calibrate_delay_direct()) != 0) {
>  		printk("Calibrating delay using timer specific routine.. ");
> +#if HZ <= 5000
>  		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
>  			loops_per_jiffy/(500000/HZ),
>  			(loops_per_jiffy/(5000/HZ)) % 100,
>  			loops_per_jiffy);
> +#else
> +		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
> +			loops_per_jiffy/(500000/HZ),
> +			(loops_per_jiffy*(HZ/5000)) % 100,
> +			loops_per_jiffy);
> +#endif
>  	} else {
>  		loops_per_jiffy = (1<<12);
>  
> @@ -164,10 +178,17 @@ void __devinit calibrate_delay(void)
>  		}
>  
>  		/* Round the value and print it */
> +#if HZ <= 5000
>  		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
>  			loops_per_jiffy/(500000/HZ),
>  			(loops_per_jiffy/(5000/HZ)) % 100,
>  			loops_per_jiffy);
> +#else
> +		printk("%lu.%02lu BogoMIPS (lpj=%lu)\n",
> +			loops_per_jiffy/(500000/HZ),
> +			(loops_per_jiffy*(HZ/5000)) % 100,
> +			loops_per_jiffy);
> +#endif
>  	}
>  
>  }
> diff --git a/kernel/Kconfig.hz b/kernel/Kconfig.hz
> --- a/kernel/Kconfig.hz
> +++ b/kernel/Kconfig.hz
> @@ -36,6 +36,11 @@ choice
>  	 1000 HZ is the preferred choice for desktop systems and other
>  	 systems requiring fast interactive responses to events.
>  
> +	config HZ_10000
> +		bool "10000 HZ"
> +	help
> +	 10000 HZ is for testing only.
> +
>  endchoice
>  
>  config HZ
> @@ -43,4 +48,5 @@ config HZ
>  	default 100 if HZ_100
>  	default 250 if HZ_250
>  	default 1000 if HZ_1000
> +	default 10000 if HZ_10000
>  
> diff --git a/kernel/timer.c b/kernel/timer.c
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -710,7 +710,7 @@ static void second_overflow(void)
>  	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
>  	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
>  	time_offset += ltemp;
> -	time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
> +	time_adj = -ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE); 
>      } else {
>  	ltemp = time_offset;
>  	if (!(time_status & STA_FLL))
> @@ -718,7 +718,7 @@ static void second_overflow(void)
>  	if (ltemp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
>  	    ltemp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
>  	time_offset -= ltemp;
> -	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
> +	time_adj = ltemp << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE); 
>      }
>  
>      /*
> diff --git a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
> --- a/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
> +++ b/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
> @@ -87,7 +87,7 @@ static const char *tcp_conntrack_names[]
>  
>  unsigned long ip_ct_tcp_timeout_syn_sent =      2 MINS;
>  unsigned long ip_ct_tcp_timeout_syn_recv =     60 SECS;
> -unsigned long ip_ct_tcp_timeout_established =   5 DAYS;
> +unsigned long ip_ct_tcp_timeout_established =   2 DAYS;
>  unsigned long ip_ct_tcp_timeout_fin_wait =      2 MINS;
>  unsigned long ip_ct_tcp_timeout_close_wait =   60 SECS;
>  unsigned long ip_ct_tcp_timeout_last_ack =     30 SECS;
> 
> -- 
> Peter Osterlund - petero2@telia.com
> http://web.telia.com/~u89404340
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
