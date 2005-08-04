Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVHDVkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVHDVkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVHDVid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:38:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262719AbVHDVf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:35:56 -0400
Date: Thu, 4 Aug 2005 14:37:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: kraxel@suse.de, roland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve()
 any more
Message-Id: <20050804143728.182086ba.akpm@osdl.org>
In-Reply-To: <42F28707.7060806@mvista.com>
References: <20050804164532.GB31853@bytesex>
	<42F28707.7060806@mvista.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> Source: MontaVista Software, Inc. George Anzinger <george@mvista.com>
> Type: Defect Fix 
> Description:
> 
>  	The changes to itimer of late (after 2.6.11) cause itimers not
>  	to survive the exec* calls.  Standard says they should.  
> 
> Signed-off-by: George Anzinger<george@mvista.com>
> 
>  exit.c         |    1 +
>  posix-timers.c |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> 
> Index: linux-2.6.13-rc/kernel/exit.c
> ===================================================================
> --- linux-2.6.13-rc.orig/kernel/exit.c
> +++ linux-2.6.13-rc/kernel/exit.c
> @@ -794,6 +794,7 @@ fastcall NORET_TYPE void do_exit(long co
>  	}
>  
>  	tsk->flags |= PF_EXITING;
> +	del_timer_sync(&tsk->signal->real_timer);
>  
>  	/*
>  	 * Make sure we don't try to process any timer firings
> Index: linux-2.6.13-rc/kernel/posix-timers.c
> ===================================================================
> --- linux-2.6.13-rc.orig/kernel/posix-timers.c
> +++ linux-2.6.13-rc/kernel/posix-timers.c
> @@ -1183,10 +1183,10 @@ void exit_itimers(struct signal_struct *
>  	struct k_itimer *tmr;
>  
>  	while (!list_empty(&sig->posix_timers)) {
> -		tmr = list_entry(sig->posix_timers.next, struct k_itimer, list);
> +		tmr = list_entry(sig->posix_timers.next,
> +				 struct k_itimer, list);
>  		itimer_delete(tmr);
>  	}
> -	del_timer_sync(&sig->real_timer);
>  }

Yup, that's the one, thanks George.

Obvious though it is, I'll hold off on forwarding this Linuswards until
Gerd has had a chance to test it.  Or did you run Gerd's test app?

