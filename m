Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVHDWOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVHDWOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVHDWOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:14:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3834 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262775AbVHDWMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:12:49 -0400
Message-ID: <42F29266.1090104@mvista.com>
Date: Thu, 04 Aug 2005 15:10:46 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Roland McGrath <roland@redhat.com>, kraxel@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve()
 any more
References: <42F28707.7060806@mvista.com>	<20050804213416.1EA56180980@magilla.sf.frob.com> <20050804150251.5f4acb0a.akpm@osdl.org>
In-Reply-To: <20050804150251.5f4acb0a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Roland McGrath <roland@redhat.com> wrote:
> 
>>That's wrong.  It has to be done only by the last thread in the group to go.
>>Just revert Ingo's change.
>>
Hm... I was looking at 2.6.10 to figure it out.  This looks more correct.

> 
> 
> OK..
> 
> --- 25/kernel/exit.c~revert-timer-exit-cleanup	Thu Aug  4 15:00:55 2005
> +++ 25-akpm/kernel/exit.c	Thu Aug  4 15:01:06 2005
> @@ -829,8 +829,10 @@ fastcall NORET_TYPE void do_exit(long co
>  	acct_update_integrals(tsk);
>  	update_mem_hiwater(tsk);
>  	group_dead = atomic_dec_and_test(&tsk->signal->live);
> -	if (group_dead)
> +	if (group_dead) {
> + 		del_timer_sync(&tsk->signal->real_timer);
>  		acct_process(code);
> +	}
>  	exit_mm(tsk);
>  
>  	exit_sem(tsk);
> diff -puN kernel/posix-timers.c~revert-timer-exit-cleanup kernel/posix-timers.c
> --- 25/kernel/posix-timers.c~revert-timer-exit-cleanup	Thu Aug  4 15:00:55 2005
> +++ 25-akpm/kernel/posix-timers.c	Thu Aug  4 15:01:06 2005
> @@ -1166,7 +1166,6 @@ void exit_itimers(struct signal_struct *
>  		tmr = list_entry(sig->posix_timers.next, struct k_itimer, list);
>  		itimer_delete(tmr);
>  	}
> -	del_timer_sync(&sig->real_timer);
>  }
>  
>  /*
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
