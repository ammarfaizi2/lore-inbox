Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283553AbRK3Htd>; Fri, 30 Nov 2001 02:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283550AbRK3HtP>; Fri, 30 Nov 2001 02:49:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:46072 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283548AbRK3HtG>; Fri, 30 Nov 2001 02:49:06 -0500
Message-ID: <3C0739DE.4E2EF490@mvista.com>
Date: Thu, 29 Nov 2001 23:48:46 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ryan Bradetich <rbradetich@uswest.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Possible bug with the keyboard_tasklet? or is it softirq tasklet 
 scheduling?
In-Reply-To: <1007100759.13785.8.camel@beavis>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Bradetich wrote:
> 
> Hello linux hackers,
> 
> I am a relatively new kernel hacker working on the parisc-linux port,
> and I think I found a BUG in the arch independant code involving the
> keyboard_tasklet.  The problem represented itself as a system hang
> when I enabled CONFIG_SMP on my C200+.  I am posting to this list, so
> hopefully someone can verify the problem and help devise a solution to
> fix the problem properly.
> 
> Problem Description:
> ------------------------------------------------------------------------
> I tracking the problem down to the following infinate loop in
> tasklet_action() from kernel/softirq.c.
> 
> while (list) {
>         struct tasklet_struct *t = list;
> 
>         list = list->next;
> 
>         if (tasklet_trylock(t)) {
>                 if (!atomic_read(&t->count)) {
>                         if (!test_and_clear_bit(TASKLET_STATE_SCHED,
> &t->state))
>                                 BUG();
>                         t->func(t->data);
>                         tasklet_unlock(t);
>                         continue;
>                 }
>                 tasklet_unlock(t);
>         }
> 
>         local_irq_disable();
>         t->next = tasklet_vec[cpu].list;
>         tasklet_vec[cpu].list = t;
>         __cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
>         local_irq_enable();
> }
> 
> I eventually figured out that the if(!atomic_read(&t->count)) was
> failing... and the task would be added back into the list via the
> following two lines of code:
> 
>         t->next = tasklet_vec[cpu].list;
>         tasklet_vec[cpu].list = t;
> 
> This loop would never end since the atomic_read(&t->count) was always
> non-zero, and the task was always being re-added to the list.
> 
> Debugging the loop further showed me the keyboard_tasklet was
> the culprit task causing the infinate loop.  I eventually figured out
> that the keyboard_tasklet->count was being initialized to 1 by the
> following macro from include/linux/interrupt.h:
> 
>         #define DECLARE_TASKLET_DISABLED(name, func, data) \
>         struct tasklet_struct name = { NULL, 0, ATOMIC_INIT(1), func,
> data }
> 
> I also figurd out that the keyboard_tasklet was being scheduled via the
> schedule_tasklet() before the enable_tasklet() was called it.  (The
> enable_tasklet() provides a memory barrior, then calls atomic_dec()
> on the ->count of the tasklet, making it 0).
> 
> The following traces shows the paths to the first call of
> schedule_tasklet(), and the first call of enable_tasklet() for the
> keyboard_tasklet.
> 
> schedule_tasklet(keyboard_tasklet)
> -------------------------
> 1. start_kernel()
> 2. console_init()
> 3. con_init()
> 4. vc_init()
> 5. reset_terminal()
> 6. set_leds()
> 7. schedule_tasklet()
> 
> enable_tasklet(keyboard_tasklet)
> --------------------------------
> 1. start_kernel()
> 2. rest_init()
> 3. init() via kernel_thread.
> 4. do_basic_setup()
> 5. do_init_calls()
> 6. chr_dev_init()
> 7. tty_init()
> 8. kbd_init()
> 9. enable_tasklet()
> 
> Looking in the start_kernel(),  console_init() is the 9th function
> called, where as rest_init() is the last function called.
> 
> Questions about the code:
> ------------------------------------------------------------------------
> 1. Why is the console code scheduling the keyboard_tasklet?  This
> doesn't make much sense to me.
> 
> 2. Is the member variable count in the tasklet_struct
> (include/linux/interrupt.h) only used for flagging the enabled/disabled
> state of the tasklet?  If so, is it possible to rename the member
> variable to something more intuative like disabled?
> 
> 3. What is the best way to fix this problem, assuming I actually did
> find a bug (I know this fixes the problem I was seeing on my C200+).
> 
> Currently I have the following patch in my local tree for this problem:
> 
> --- drivers/char/console.c      2001/11/09 23:35:36     1.15
> +++ drivers/char/console.c      2001/11/30 04:44:38
> @@ -1420,7 +1420,10 @@ static void reset_terminal(int currcons,
>         kbd_table[currcons].slockstate = 0;
>         kbd_table[currcons].ledmode = LED_SHOW_FLAGS;
>         kbd_table[currcons].ledflagstate =
> kbd_table[currcons].default_ledflagstate;
> -       set_leds();
> +
> +        /* Only schedule the keyboard_tasklet if it is enabled. */
> +        if (!atomic_read(&keyboard_tasklet.count))
> +               set_leds();
> 
>         cursor_type = CUR_DEFAULT;
>         complement_mask = s_complement_mask;
> 
> Thanks for your time,
> 
> - Ryan
> parisc-linux newbie kernel hacker.
> 
I found this same problem in while trying to run down timer bh issues. 
With out looking at the keyboard driver (since this is IMHO a tasklet
issue), I recommend that we not set the "pending" bit
(__cpu_raise_softirq()) if the tasklet fails because of count !=0, and
then modify the enable macro to, if the count is now 0, do the
__cpu_raise_softirq().  This still leaves the issue of the
tasklet_trylock(t), which will fail in the same way, but there we are
contending with another cpu and the rules say it can only run on one cpu
at a time.

On the other hand, why is this bothering you?  You don't say what kernel
version you are on, but the later versions push this sort of thing off
to ksoftirqd (a kernel thread) which allows the system to boot (even if
the thread doesn't exist yet, and it doesn't at this point).

The tasklet info suggests that it is ok for a tasklet to reschedule
itself, however, in the current system, this means that it will run each
interrupt.  Surly a timer would be a better answer, except we don't have
sub jiffie timers... yet.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
