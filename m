Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282080AbRLDBpy>; Mon, 3 Dec 2001 20:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279261AbRLDAN0>; Mon, 3 Dec 2001 19:13:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6665 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282986AbRLCJVI>; Mon, 3 Dec 2001 04:21:08 -0500
Message-ID: <3C0B43DC.7A8F582A@zip.com.au>
Date: Mon, 03 Dec 2001 01:20:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: j-nomura@ce.jp.nec.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processor initialization check)
In-Reply-To: <20011203144615C.nomura@hpc.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

j-nomura@ce.jp.nec.com wrote:
> 
> Hello,
> 
> I experienced system hang on my SMP machine and it turned out to be due to
> console write before mmu initialization completes.
> 
> To be more specific, even if secondary processors are not in status enough
> to do actual console I/O (e.g. mmu is not initialized), call_console_drivers()
> tries to do it.
> This leads to unpredictable result. For me, for example, it cause machine
> check abort and hang up system.
> 
> Attached is a patch for it.
> 
> --- kernel/printk.c     2001/11/27 04:41:49     1.1.1.8
> +++ kernel/printk.c     2001/12/03 05:25:26
> @@ -491,20 +491,22 @@
>   */
>  void release_console_sem(void)
>  {
>         unsigned long flags;
>         unsigned long _con_start, _log_end;
>         unsigned long must_wake_klogd = 0;
> 
>         for ( ; ; ) {
>                 spin_lock_irqsave(&logbuf_lock, flags);
>                 must_wake_klogd |= log_start - log_end;
> +               if (!(cpu_online_map & 1UL << smp_processor_id()))
> +                       break;
>                 if (con_start == log_end)
>                         break;                  /* Nothing to print */
>                 _con_start = con_start;
>                 _log_end = log_end;
>                 con_start = log_end;            /* Flush */
>                 spin_unlock_irqrestore(&logbuf_lock, flags);
>                 call_console_drivers(_con_start, _log_end);
>         }
>         console_may_schedule = 0;
>         up(&console_sem);
> 

Seems that there is some sort of ordering problem here - someone
is calling printk before the MMU is initialised, but after some
console drivers have been installed.

I suspect the real fix is elsewhere, but I'm not sure where.

Probably a clearer place to put this test would be within
printk itself, immediately before the down_trylock.  Does that
work?

-
