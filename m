Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUIELD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUIELD6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUIELD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:03:57 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:41734 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266233AbUIELDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:03:38 -0400
Date: Sun, 5 Sep 2004 12:03:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Kegel <dank@kegel.com>, Roman Zippel <zippel@linux-m68k.org>,
       Matthias Urlichs <smurf@smurf.noris.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Getting kernel.org kernel to build for m68k?
Message-ID: <20040905120325.A29363@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dan Kegel <dank@kegel.com>, Roman Zippel <zippel@linux-m68k.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
References: <41355F88.2080801@kegel.com> <Pine.GSO.4.58.0409011029390.15681@waterleaf.sonytel.be> <Pine.LNX.4.58.0409051224020.30282@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409051224020.30282@anakin>; from geert@linux-m68k.org on Sun, Sep 05, 2004 at 12:41:08PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hence if no one objects, I'll submit the patch to Andrew and Linus.

the common code changes below are not okay.  Please fir m68k into one of
the schemes we have for thread_info/task_struct already.


> --- linux-2.6.8.1/include/linux/sched.h	2004-08-04 12:14:38.000000000 +0200
> +++ linux-m68k-2.6.8.1/include/linux/sched.h	2004-09-04 21:18:59.000000000 +0200
> @@ -977,6 +977,7 @@ static inline struct mm_struct * get_tas
>  	return mm;
>  }
> 
> +#ifndef __HAVE_THREAD_FUNCTIONS
> 
>  /* set thread flags in other task's structures
>   * - see asm/thread_info.h for TIF_xxxx flags available
> @@ -1006,6 +1007,8 @@ static inline int test_tsk_thread_flag(s
>  	return test_ti_thread_flag(tsk->thread_info,flag);
>  }
> 
> +#endif	/* __HAVE_THREAD_FUNCTIONS */
> +
>  static inline void set_tsk_need_resched(struct task_struct *tsk)
>  {
>  	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
> --- linux-2.6.8.1/include/linux/thread_info.h	2004-04-27 20:42:22.000000000 +0200
> +++ linux-m68k-2.6.8.1/include/linux/thread_info.h	2004-09-04 21:24:36.000000000 +0200
> @@ -21,6 +21,7 @@ extern long do_no_restart_syscall(struct
>  #include <asm/thread_info.h>
> 
>  #ifdef __KERNEL__
> +#ifndef __HAVE_THREAD_FUNCTIONS
> 
>  /*
>   * flag set/clear/test wrappers
> @@ -77,16 +78,11 @@ static inline int test_ti_thread_flag(st
>  	return test_bit(flag,&ti->flags);
>  }
> 
> -static inline void set_need_resched(void)
> -{
> -	set_thread_flag(TIF_NEED_RESCHED);
> -}
> +#endif	/* __HAVE_THREAD_FUNCTIONS */
> 
> -static inline void clear_need_resched(void)
> -{
> -	clear_thread_flag(TIF_NEED_RESCHED);
> -}
> +#define set_need_resched() set_thread_flag(TIF_NEED_RESCHED)
> +#define clear_need_resched(void) clear_thread_flag(TIF_NEED_RESCHED)
> 
> -#endif
> +#endif	/* __KERNEL__ */
> 
>  #endif /* _LINUX_THREAD_INFO_H */
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> [*] For reference:
> 
>     http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/POSTPONED/156-thread_info.diff
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---
