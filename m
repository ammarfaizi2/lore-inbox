Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbQLNKQL>; Thu, 14 Dec 2000 05:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131749AbQLNKQB>; Thu, 14 Dec 2000 05:16:01 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:63731 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S131227AbQLNKPv>;
	Thu, 14 Dec 2000 05:15:51 -0500
Message-ID: <3A3896B0.9567E7DA@non.agilent.com>
Date: Thu, 14 Dec 2000 09:45:20 +0000
From: Guy Bolton King <Guy_Bolton_King@non.agilent.com>
Organization: Agilent Technologies
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: ak@muc.de
Subject: Re:[PATCH] Fix poll bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I believe I've found an inconsistency between the behaviour of poll(2)
and select(2); select() is restartable in the face of signals
(sys_select() returns ERESTARTNOHAND if a signal is pending), whilst
poll() is not (sys_poll() returns EINTR).  On Feb 13 2000, Andi Kleen
posted a patch for 2.2.14--2.2.15 that fixes this (reproduced below;
the explanation is somewhat confusing and doesn't match my problem,
but the patch does The Right Thing), but it hasn't gone into any of
the subsequent 2.2 series.

Is this deliberate?  And if so, why (because it's just bitten me quite
badly)?  If not, I assume this has been fixed for 2.4?  I note that
this problem (i.e. restartable system calls) has cropped up a few
times on the list, always with poll(2), usually in combination with
job control or gdb, so it _does_ appear to be confusing users and
breaking code (or at least breaking code that expects BSD signal
behaviour as the default, which I believe is also the POSIX
way---please correct me if I'm wrong about this last one).

Guy.

> Hi Alan, 
> 
> 
> I just found a poll() bug. poll currently returns -EINTR when 
> a signal occurs, which causes the system call to be restarted. Unfortunately 
> the timeout is not decreased, so when you have a periodic SA_RESTART timer 
> with just the right period and no other event occurs poll hangs forever. 
> 
> 
> select does it correctly, it always returns EINTR and is never restarted. 
> 
> 
> I found it because syslogd's 30s "mark" timer can trigger it in the 
> dns resolver when syslogd does forwarding. 
> 
> 
> This patch fixes the problem. I also fixed an outdated comment. 
> 
> 
> Please add for 2.2.15. Thanks. 
> 
> 
> -Andi 
> 
> 
> --- linux/fs/select.c-o Thu Aug 26 02:29:49 1999 
> +++ linux/fs/select.c Sun Feb 13 12:52:00 2000 
> @@ -230,12 +230,8 @@ 
>  } 
>   
>  /* 
> - * We can actually return ERESTARTSYS instead of EINTR, but I'd 
> - * like to be certain this leads to no problems. So I return 
> - * EINTR just for safety. 
> - * 
> - * Update: ERESTARTSYS breaks at least the xview clock binary, so 
> - * I'm trying ERESTARTNOHAND which restart only when you want to. 
> + * On interrupts return ERESTARTNOHAND, because automatic restart 
> + * is not handled properly (the timeout is not decreased). 
>   */ 
>  #define MAX_SELECT_SECONDS \ 
>          ((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1) 
> @@ -434,7 +430,7 @@ 
>   
>          err = fdcount; 
>          if (!fdcount && signal_pending(current)) 
> - err = -EINTR; 
> + err = -ERESTARTNOHAND; 
>   
>  out_fds: 
>          kfree(fds); 
> 
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
