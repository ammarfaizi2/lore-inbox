Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbRGFI0Z>; Fri, 6 Jul 2001 04:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266293AbRGFI0G>; Fri, 6 Jul 2001 04:26:06 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36541 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266292AbRGFIZ6>;
	Fri, 6 Jul 2001 04:25:58 -0400
Message-ID: <3B45760D.6F99149C@mandrakesoft.com>
Date: Fri, 06 Jul 2001 04:25:49 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Cc: Ville Nummela <ville.nummela@mail.necsom.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: tasklets in 2.4.6
In-Reply-To: <7an16iy2wa.fsf@necsom.com> <3B4563D5.89A1ACA3@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> The only thing that appears fishy is that if the tasklet constantly
> reschedules itself, it will never leave the loop AFAICS.  This affects
> tasklet_hi_action as well as tasklet_action.

As I hacked around to fix this, I noticed Andrea's ksoftirq patch
already fixed this.  So, I decided to look over his patch instead.


Quoted from 00_ksoftirqd-7:
> +#ifdef CONFIG_SMP
> +       movl processor(%ebx),%eax
> +       shll $CONFIG_X86_L1_CACHE_SHIFT,%eax
> +       testl $0, SYMBOL_NAME(irq_stat)(,%eax)  # softirq_pending
> +#else
> +       testl $0, SYMBOL_NAME(irq_stat)         # softirq_pending
> +#endif
> +       jne   handle_softirq

Did you get this from Alpha? :)  This is very similar to a
micro-optimization I put in for UP machines on Alpha.

Useful yes, but unrelated to ksoftirqd issue.

> +handle_softirq_back:
>         cmpl $0,need_resched(%ebx)
>         jne reschedule
> +reschedule_back:
>         cmpl $0,sigpending(%ebx)
>         jne signal_return
>  restore_all:
> @@ -256,9 +266,14 @@
>         jmp restore_all
> 
>         ALIGN
> +handle_softirq:
> +       call SYMBOL_NAME(do_softirq)
> +       jmp handle_softirq_back
> +
> +       ALIGN
>  reschedule:
>         call SYMBOL_NAME(schedule)    # test
> -       jmp ret_from_sys_call
> +       jmp reschedule_back

I'm too slack to look at the code flow and see what is going on here, so
"no comment" :)

> diff -urN 2.4.6pre5/include/asm-alpha/softirq.h softirq/include/asm-alpha/softirq.h
> --- 2.4.6pre5/include/asm-alpha/softirq.h       Thu Jun 21 08:03:51 2001
> +++ softirq/include/asm-alpha/softirq.h Thu Jun 21 15:58:06 2001
> @@ -8,21 +8,28 @@
>  extern inline void cpu_bh_disable(int cpu)
>  {
>         local_bh_count(cpu)++;
> -       mb();
> +       barrier();
>  }
> 
> -extern inline void cpu_bh_enable(int cpu)
> +extern inline void __cpu_bh_enable(int cpu)
>  {
> -       mb();
> +       barrier();
>         local_bh_count(cpu)--;
>  }

I do not say this is wrong... but why reinvent the wheel?  Is it
possible to use atomic_t for local

> 
> -#define local_bh_enable()      cpu_bh_enable(smp_processor_id())
> -#define __local_bh_enable      local_bh_enable
> +#define __local_bh_enable()    __cpu_bh_enable(smp_processor_id())
>  #define local_bh_disable()     cpu_bh_disable(smp_processor_id())
> 
> -#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
> +#define local_bh_enable()                                      \
> +do {                                                           \
> +       int cpu;                                                \
> +                                                               \
> +       barrier();                                              \
> +       cpu = smp_processor_id();                               \
> +       if (!--local_bh_count(cpu) && softirq_pending(cpu))     \
> +               do_softirq();                                   \
> +} while (0)

makes sense

> diff -urN 2.4.6pre5/include/asm-i386/softirq.h softirq/include/asm-i386/softirq.h
> --- 2.4.6pre5/include/asm-i386/softirq.h        Thu Jun 21 08:03:52 2001
> +++ softirq/include/asm-i386/softirq.h  Thu Jun 21 15:58:06 2001
> @@ -28,6 +26,7 @@
>  do {                                                                   \
>         unsigned int *ptr = &local_bh_count(smp_processor_id());        \
>                                                                         \
> +       barrier();                                                      \
>         if (!--*ptr)                                                    \
>                 __asm__ __volatile__ (                                  \
>                         "cmpl $0, -8(%0);"                              \

If you don't mind, why is barrier() needed here?  The __volatile__
doesn't take care of that?

I am not yet completely familiar with the conditions under which
barrier() is needed.


> diff -urN 2.4.6pre5/include/linux/interrupt.h softirq/include/linux/interrupt.h
> --- 2.4.6pre5/include/linux/interrupt.h Thu Jun 21 08:03:56 2001
> +++ softirq/include/linux/interrupt.h   Thu Jun 21 15:58:06 2001
> @@ -74,6 +74,22 @@
>  asmlinkage void do_softirq(void);
>  extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
> 
> +static inline void __cpu_raise_softirq(int cpu, int nr)
> +{
> +       softirq_pending(cpu) |= (1<<nr);
> +}
> +
> +
> +/* I do not want to use atomic variables now, so that cli/sti */
> +static inline void raise_softirq(int nr)
> +{
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       __cpu_raise_softirq(smp_processor_id(), nr);
> +       local_irq_restore(flags);
> +}
> +
>  extern void softirq_init(void);
> 
> 
> @@ -129,7 +145,7 @@
>  extern struct tasklet_head tasklet_hi_vec[NR_CPUS];
> 
>  #define tasklet_trylock(t) (!test_and_set_bit(TASKLET_STATE_RUN, &(t)->state))
> -#define tasklet_unlock(t) clear_bit(TASKLET_STATE_RUN, &(t)->state)
> +#define tasklet_unlock(t) do { smp_mb__before_clear_bit(); clear_bit(TASKLET_STATE_RUN, &(t)->state); } while(0)
>  #define tasklet_unlock_wait(t) while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
> 
>  extern void tasklet_schedule(struct tasklet_struct *t);
> diff -urN 2.4.6pre5/include/linux/irq_cpustat.h softirq/include/linux/irq_cpustat.h
> diff -urN 2.4.6pre5/kernel/softirq.c softirq/kernel/softirq.c
> --- 2.4.6pre5/kernel/softirq.c  Thu Jun 21 08:03:57 2001
> +++ softirq/kernel/softirq.c    Thu Jun 21 15:58:06 2001
> @@ -51,17 +51,20 @@
>  {
>         int cpu = smp_processor_id();
>         __u32 pending;
> +       long flags;
> +       __u32 mask;
> 
>         if (in_interrupt())
>                 return;
> 
> -       local_irq_disable();
> +       local_irq_save(flags);
> 
>         pending = softirq_pending(cpu);
> 
>         if (pending) {
>                 struct softirq_action *h;
> 
> +               mask = ~pending;
>                 local_bh_disable();
>  restart:
>                 /* Reset the pending bitmask before enabling irqs */
> @@ -81,12 +84,26 @@
>                 local_irq_disable();
> 
>                 pending = softirq_pending(cpu);
> -               if (pending)
> +               if (pending & mask) {
> +                       mask &= ~pending;
>                         goto restart;
> +               }

Cool, I was wondering why the old code did not do pending&mask...

> @@ -112,8 +129,7 @@
>          * If nobody is running it then add it to this CPU's
>          * tasklet queue.
>          */
> -       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state) &&
> -                                               tasklet_trylock(t)) {
> +       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>                 t->next = tasklet_vec[cpu].list;
>                 tasklet_vec[cpu].list = t;
>                 __cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
> @@ -130,8 +146,7 @@
>         cpu = smp_processor_id();
>         local_irq_save(flags);
> 
> -       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state) &&
> -                                               tasklet_trylock(t)) {
> +       if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>                 t->next = tasklet_hi_vec[cpu].list;
>                 tasklet_hi_vec[cpu].list = t;
>                 __cpu_raise_softirq(cpu, HI_SOFTIRQ);

Why does tasklet_trylock go away?

It seems like this removes the supported capability for a tasklet to
reschedule itself, which would occur when test_and_set_bit succeeds but
tasklet_trylock fails, in the code above.

> @@ -148,37 +163,29 @@
>         local_irq_disable();
>         list = tasklet_vec[cpu].list;
>         tasklet_vec[cpu].list = NULL;
> +       local_irq_enable();
> 
>         while (list) {
>                 struct tasklet_struct *t = list;
> 
>                 list = list->next;
> 
> -               /*
> -                * A tasklet is only added to the queue while it's
> -                * locked, so no other CPU can have this tasklet
> -                * pending:
> -                */
>                 if (!tasklet_trylock(t))
>                         BUG();
> -repeat:
> -               if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
> -                       BUG();
>                 if (!atomic_read(&t->count)) {
> -                       local_irq_enable();
> +                       clear_bit(TASKLET_STATE_SCHED, &t->state);
>                         t->func(t->data);
> -                       local_irq_disable();
> -                       /*
> -                        * One more run if the tasklet got reactivated:
> -                        */
> -                       if (test_bit(TASKLET_STATE_SCHED, &t->state))
> -                               goto repeat;
> +                       tasklet_unlock(t);
> +                       continue;

Here is the key problem area, the reason for this entire patch.

Andrea your fix appears -almost- correct, but it missed a key point: 
re-running the tasklet in tasklet_action is i/dcache friendly.

I suggest preserving the original intent of the code (as I interpret
from the comment), by re-running the tasklet function -once-, if it
rescheduled itself.

Comments?

>                 }
>                 tasklet_unlock(t);
> -               if (test_bit(TASKLET_STATE_SCHED, &t->state))
> -                       tasklet_schedule(t);
> +
> +               local_irq_disable();
> +               t->next = tasklet_vec[cpu].list;
> +               tasklet_vec[cpu].list = t;
> +               __cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
> +               local_irq_enable();

please create __tasklet_schedule and __tasklet_hi_schedule instead of
duplicating code here, between local_irq_disable and local_irq_enable.

>         }
> -       local_irq_enable();
>  }
> 
> 
> @@ -193,6 +200,7 @@
>         local_irq_disable();
>         list = tasklet_hi_vec[cpu].list;
>         tasklet_hi_vec[cpu].list = NULL;
> +       local_irq_enable();
> 
>         while (list) {
>                 struct tasklet_struct *t = list;
> @@ -201,21 +209,20 @@
> 
>                 if (!tasklet_trylock(t))
>                         BUG();
> -repeat:
> -               if (!test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
> -                       BUG();
>                 if (!atomic_read(&t->count)) {
> -                       local_irq_enable();
> +                       clear_bit(TASKLET_STATE_SCHED, &t->state);
>                         t->func(t->data);
> -                       local_irq_disable();
> -                       if (test_bit(TASKLET_STATE_SCHED, &t->state))
> -                               goto repeat;
> +                       tasklet_unlock(t);
> +                       continue;
>                 }
>                 tasklet_unlock(t);
> -               if (test_bit(TASKLET_STATE_SCHED, &t->state))
> -                       tasklet_hi_schedule(t);
> +
> +               local_irq_disable();
> +               t->next = tasklet_hi_vec[cpu].list;
> +               tasklet_hi_vec[cpu].list = t;
> +               __cpu_raise_softirq(cpu, HI_SOFTIRQ);
> +               local_irq_enable();

this should be __tasklet_hi_schedule call, not inlined duplicate code


> +static int ksoftirqd(void * __bind_cpu)
> +{
> +       int bind_cpu = *(int *) __bind_cpu;
> +       int cpu = cpu_logical_map(bind_cpu);
> +
> +       daemonize();
> +       current->nice = 19;
> +       sigfillset(&current->blocked);
> +
> +       /* Migrate to the right CPU */
> +       current->cpus_allowed = 1UL << cpu;
> +       while (smp_processor_id() != cpu)
> +               schedule();
> +
> +       sprintf(current->comm, "ksoftirqd_CPU%d", bind_cpu);
> +
> +       __set_current_state(TASK_INTERRUPTIBLE);
> +       mb();
> +
> +       ksoftirqd_task(cpu) = current;
> +
> +       for (;;) {
> +               if (!softirq_pending(cpu))
> +                       schedule();
> +
> +               __set_current_state(TASK_RUNNING);
> +
> +               while (softirq_pending(cpu)) {
> +                       do_softirq();
> +                       if (current->need_resched)
> +                               schedule();
> +               }
> +
> +               __set_current_state(TASK_INTERRUPTIBLE);
> +       }
> +}

should there perhaps be a
	current->policy |= SCHED_YIELD
in here, or does setting current->nice make that unnecessary?

So basically Andrea's ksoftirq patch indeed appears to fix the infinite
loop, but IMHO it needs a tiny bit of work...

	Jeff



-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
