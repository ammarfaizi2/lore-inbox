Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbREMQWb>; Sun, 13 May 2001 12:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbREMQWV>; Sun, 13 May 2001 12:22:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20239 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261289AbREMQWK>;
	Sun, 13 May 2001 12:22:10 -0400
Date: Sun, 13 May 2001 13:21:46 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: Re: [PATCH] eliminate a truckload of context switches
In-Reply-To: <Pine.LNX.4.33.0105081355290.363-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0105131320380.5468-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, Mike Galbraith wrote:

> While running a ktrace enabled kernel (IKD), I noticed many useless
> context switches.  The problem is that we continually pester kswapd/
> kflushd at times when they can't do anything other than go back to
> sleep.  As you'll see below, we do this quite a bit under heavy load.

I agree, both with your analysis that the context switches
aren't needed and with the patch you sent to fix it.

Linus, if it isn't in the kernel yet, please put it in...

thanks,

Rik

> --- linux-2.4.4.ikd/mm/vmscan.c.org	Tue May  8 10:54:33 2001
> +++ linux-2.4.4.ikd/mm/vmscan.c	Tue May  8 11:16:17 2001
> @@ -964,7 +964,7 @@
> 
>  void wakeup_kswapd(void)
>  {
> -	if (current != kswapd_task)
> +	if (waitqueue_active(&kswapd_wait))
>  		wake_up_process(kswapd_task);
>  }
> 
> --- linux-2.4.4.ikd/fs/buffer.c.org	Tue May  8 10:55:33 2001
> +++ linux-2.4.4.ikd/fs/buffer.c	Tue May  8 11:15:22 2001
> @@ -2578,16 +2578,16 @@
>  	return flushed;
>  }
> 
> +DECLARE_WAIT_QUEUE_HEAD(kflushd_wait);
>  struct task_struct *bdflush_tsk = 0;
> 
>  void wakeup_bdflush(int block)
>  {
> -	if (current != bdflush_tsk) {
> +	if (waitqueue_active(&kflushd_wait))
>  		wake_up_process(bdflush_tsk);
> 
> -		if (block)
> -			flush_dirty_buffers(0);
> -	}
> +	if (block)
> +		flush_dirty_buffers(0);
>  }
> 
>  /*
> @@ -2711,14 +2711,10 @@
>  		 * skip the sleep and flush some more. Otherwise, we
>  		 * go to sleep waiting a wakeup.
>  		 */
> -		set_current_state(TASK_INTERRUPTIBLE);
>  		if (!flushed || balance_dirty_state(NODEV) < 0) {
>  			run_task_queue(&tq_disk);
> -			schedule();
> +			interruptible_sleep_on(&kflushd_wait);
>  		}
> -		/* Remember to mark us as running otherwise
> -		   the next schedule will block. */
> -		__set_current_state(TASK_RUNNING);
>  	}
>  }
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


