Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132633AbRDKQ3U>; Wed, 11 Apr 2001 12:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132642AbRDKQ3L>; Wed, 11 Apr 2001 12:29:11 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:14134 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S132636AbRDKQ3A>; Wed, 11 Apr 2001 12:29:00 -0400
Message-ID: <3AD485E4.40BCBC0D@mvista.com>
Date: Wed, 11 Apr 2001 09:27:16 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: SodaPop <soda@xirr.com>, alexey@datafoundation.com,
        linux-kernel@vger.kernel.org
Subject: Re: [test-PATCH] Re: [QUESTION] 2.4.x nice level
In-Reply-To: <Pine.LNX.4.21.0104110726210.25737-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One rule of optimization is to move any code you can outside the loop. 
Why isn't the nice_to_ticks calculation done when nice is changed
instead of EVERY recalc.?  I guess another way to ask this is, who needs
to see the original nice?  Would it be worth another task_struct entry
to move this calculation out of the loop?

George

Rik van Riel wrote:
> 
> On Tue, 10 Apr 2001, Rik van Riel wrote:
> 
> > I'll try to come up with a recalculation change that will make
> > this thing behave better, while still retaining the short time
> > slices for multiple normal-priority tasks and the cache footprint
> > schedule() and friends currently have...
> 
> OK, here it is. It's nothing like montavista's singing-dancing
> scheduler patch that does all, just a really minimal change that
> should stretch the nice levels to yield the following CPU usage:
> 
> Nice    0    5   10   15   19
> %CPU  100   56   25    6    1
> 
> Note that the code doesn't change the actual scheduling code,
> just the recalculation. Care has also been taken to not increase
> the cache footprint of the scheduling and recalculation code.
> 
> I'd love to hear some test results from people who are interested
> in wider nice levels. How does this run on your system?  Can you
> trigger bad behaviour in any way?
> 
> regards,
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
>                 http://www.surriel.com/
> http://www.conectiva.com/       http://distro.conectiva.com.br/
> 
> --- linux-2.4.3-ac4/kernel/sched.c.orig Tue Apr 10 21:04:06 2001
> +++ linux-2.4.3-ac4/kernel/sched.c      Wed Apr 11 06:18:46 2001
> @@ -686,8 +686,26 @@
>                 struct task_struct *p;
>                 spin_unlock_irq(&runqueue_lock);
>                 read_lock(&tasklist_lock);
> -               for_each_task(p)
> +               for_each_task(p) {
> +                   if (p->nice <= 0) {
> +                       /* The normal case... */
>                         p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
> +                   } else {
> +                       /*
> +                        * Niced tasks get less CPU less often, leading to
> +                        * the following distribution of CPU time:
> +                        *
> +                        * Nice    0    5   10   15   19
> +                        * %CPU  100   56   25    6    1
> +                        */
> +                       short prio = 20 - p->nice;
> +                       p->nice_calc += prio;
> +                       if (p->nice_calc >= 20) {
> +                           p->nice_calc -= 20;
> +                           p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
> +                       }
> +                   }
> +               }
>                 read_unlock(&tasklist_lock);
>                 spin_lock_irq(&runqueue_lock);
>         }
> --- linux-2.4.3-ac4/include/linux/sched.h.orig  Tue Apr 10 21:04:13 2001
> +++ linux-2.4.3-ac4/include/linux/sched.h       Wed Apr 11 06:26:47 2001
> @@ -303,7 +303,8 @@
>   * the goodness() loop in schedule().
>   */
>         long counter;
> -       long nice;
> +       short nice_calc;
> +       short nice;
>         unsigned long policy;
>         struct mm_struct *mm;
>         int has_cpu, processor;
