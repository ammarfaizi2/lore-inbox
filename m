Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272460AbRH3VDZ>; Thu, 30 Aug 2001 17:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272461AbRH3VDQ>; Thu, 30 Aug 2001 17:03:16 -0400
Received: from [194.213.32.137] ([194.213.32.137]:28164 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S272460AbRH3VDE>;
	Thu, 30 Aug 2001 17:03:04 -0400
Date: Sun, 26 Aug 2001 16:37:32 +0000
From: Pavel Machek <pavel@suse.cz>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Justin A <justin@bouncybouncy.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATH] Trigger OOM handler through sysrq
Message-ID: <20010826163731.A47@toy.ucw.cz>
In-Reply-To: <20010816233613.B23620@bouncybouncy.net> <Pine.LNX.4.30.0108171757250.2660-100000@fs131-224.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0108171757250.2660-100000@fs131-224.f-secure.com>; from szaka@f-secure.com on Fri, Aug 17, 2001 at 06:51:40PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The below patch allows you to trigger the OOM handler rather then the
> > generic SAK.
> 
> Hmm, does your patch work? You can't call oom_kill() from a non-task
> context because it uses schedule(). I had a similar patch for
> experiments long ago but can't find it. Anyway I think this solution
> fixes the symptom, not the root of the problem, especially SysRq
> is disabled in many places because of security reasons ....
> 
> .... but it's true it can be lifesaver in cases ;) The patch below works
> for me. For people who are interested, see
> /usr/src/linux/Documentation/sysrq.txt how to enable 'Magic SysRq keys'
> and after you can use ALT-SysRQ-f whenever you want to free some
> memory killing a process chosen by the kernel.

This is usefull and can be lifesaver. Can you push it to linus?

> 
> diff -ur linux.orig/drivers/char/sysrq.c linux/drivers/char/sysrq.c
> --- linux.orig/drivers/char/sysrq.c	Fri Aug 17 00:58:32 2001
> +++ linux/drivers/char/sysrq.c	Fri Aug 17 22:09:31 2001
> @@ -28,6 +28,7 @@
> 
>  extern void reset_vc(unsigned int);
>  extern struct list_head super_blocks;
> +extern int sysrq_oom;
> 
>  /* Whether we react on sysrq keys or just ignore them */
>  int sysrq_enabled = 1;
> @@ -137,6 +138,11 @@
>  		send_sig_all(SIGKILL, 1);
>  		orig_log_level = 8;
>  		break;
> +	case 'f':					    /* F -- call out of memory killer */
> +		printk("Trying to free some memory killing a \"bad\" process\n");
> +	 	sysrq_oom = 1;
> +		wakeup_kswapd();
> +		break;
>  	default:					    /* Unknown: help */
>  		if (kbd)
>  			printk("unRaw ");
> @@ -147,7 +153,7 @@
>  		printk("Boot ");
>  		if (sysrq_power_off)
>  			printk("Off ");
> -		printk("Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL\n");
> +		printk("Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL Freemem\n");
>  		/* Don't use 'A' as it's handled specially on the Sparc */
>  	}
> 
> diff -ur linux.orig/mm/vmscan.c linux/mm/vmscan.c
> --- linux.orig/mm/vmscan.c	Fri Aug 17 03:01:33 2001
> +++ linux/mm/vmscan.c	Fri Aug 17 22:03:51 2001
> @@ -24,6 +24,8 @@
> 
>  #include <asm/pgalloc.h>
> 
> +int sysrq_oom = 0;
> +
>  /*
>   * The "priority" of VM scanning is how much of the queues we
>   * will scan in one go. A value of 6 for DEF_PRIORITY implies
> @@ -925,6 +927,12 @@
> 
>  			/* Recalculate VM statistics. */
>  			recalculate_vm_stats();
> +		}
> +
> +		if (sysrq_oom) {
> +			sysrq_oom = 0;
> +			oom_kill();
> +			continue;
>  		}
> 
>  		if (!do_try_to_free_pages(GFP_KSWAPD, 1)) {
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

