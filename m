Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbQKJRNB>; Fri, 10 Nov 2000 12:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQKJRMl>; Fri, 10 Nov 2000 12:12:41 -0500
Received: from mail-03-real.cdsnet.net ([63.163.68.110]:31505 "HELO
	mail-03-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S131378AbQKJRMg>; Fri, 10 Nov 2000 12:12:36 -0500
Message-ID: <3A0C2D4A.83C75D4B@mvista.com>
Date: Fri, 10 Nov 2000 09:15:54 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: John Kacur <jkacur@home.com>, linux-kernel@vger.kernel.org
Subject: Re: test11-pre2 compile error undefined reference to `bust_spinlocks' 
 WHAT?!
In-Reply-To: <23569.973832900@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The notion of releasing a spin lock by initializing it seems IMHO, on
the face of it, way off.  Firstly the protected area is no longer
protected which could lead to undefined errors/ crashes and secondly,
any future use of spinlocks to control preemption could have a lot of
trouble with this, principally because the locker is unknown.

In the case at hand, it would seem that an unlocked path to the console
is a more correct answer that gives the system a far better chance of
actually remaining viable.

George

Keith Owens wrote:
> 
> On Fri, 10 Nov 2000 00:32:49 -0500,
> John Kacur <jkacur@home.com> wrote:
> >When attempting to compile test11-pre2, I get the following compile
> >error.
> >
> >arch/i386/mm/mm.o: In function `do_page_fault':
> >arch/i386/mm/mm.o(.text+0x781): undefined reference to `bust_spinlocks'
> >make: *** [vmlinux] Error 1
> 
> Oops, wrong patch.
> 
> Index: 0-test11-pre2.1/arch/i386/kernel/traps.c
> --- 0-test11-pre2.1/arch/i386/kernel/traps.c Fri, 10 Nov 2000 13:10:37 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
> +++ 0-test11-pre2.1(w)/arch/i386/kernel/traps.c Fri, 10 Nov 2000 16:06:48 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
> @@ -382,6 +382,18 @@ static void unknown_nmi_error(unsigned c
>         printk("Do you have a strange power saving mode enabled?\n");
>  }
> 
> +extern spinlock_t console_lock, timerlist_lock;
> +/*
> + * Unlock any spinlocks which will prevent us from getting the
> + * message out (timerlist_lock is acquired through the
> + * console unblank code)
> + */
> +void bust_spinlocks(void)
> +{
> +       spin_lock_init(&console_lock);
> +       spin_lock_init(&timerlist_lock);
> +}
> +
>  #if CONFIG_X86_IO_APIC
> 
>  int nmi_watchdog = 1;
> @@ -394,19 +406,7 @@ static int __init setup_nmi_watchdog(cha
> 
>  __setup("nmi_watchdog=", setup_nmi_watchdog);
> 
> -extern spinlock_t console_lock, timerlist_lock;
>  static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
> -
> -/*
> - * Unlock any spinlocks which will prevent us from getting the
> - * message out (timerlist_lock is aquired through the
> - * console unblank code)
> - */
> -void bust_spinlocks(void)
> -{
> -       spin_lock_init(&console_lock);
> -       spin_lock_init(&timerlist_lock);
> -}
> 
>  inline void nmi_watchdog_tick(struct pt_regs * regs)
>  {
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
