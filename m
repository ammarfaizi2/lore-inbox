Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314801AbSDVVmB>; Mon, 22 Apr 2002 17:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314819AbSDVVmB>; Mon, 22 Apr 2002 17:42:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:19185 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314801AbSDVVkU>;
	Mon, 22 Apr 2002 17:40:20 -0400
Message-ID: <3CC48321.5855B08A@mvista.com>
Date: Mon, 22 Apr 2002 14:39:45 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: in_interrupt race
In-Reply-To: <15553.17071.88897.914713@argo.ozlabs.ibm.com> <1019502174.939.50.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Sat, 2002-04-20 at 06:27, Paul Mackerras wrote:
> 
> > Thus if we have CONFIG_SMP and CONFIG_PREEMPT, there is a small but
> > non-zero probability that in_interrupt() will give the wrong answer if
> > it is called with preemption enabled.  If the process gets scheduled
> > from cpu A to cpu B between calling smp_processor_id() and evaluating
> > local_irq_count(cpu) or local_bh_count(), and cpu A then happens to be
> > in interrupt context at the point where the process resumes on cpu B,
> > then in_interrupt() will incorrectly return 1.
> 
> Looks like you are probably right ...
> 
> > One idea I had is to use a couple of bits in
> > current_thread_info()->flags to indicate whether local_irq_count and
> > local_bh_count are non-zero for the current cpu.  These bits could be
> > tested safely without having to disable preemption.

Preemption lock is implied by either of these being != 0, so this seems
consistant, but why not the whole counter?
> 
> For now we can just do this,
> 
> --- linux-2.5.8/include/asm-i386/hardirq.h      Sun Apr 14 15:18:55 2002
> +++ linux/include/asm-i386/hardirq.h    Mon Apr 22 14:56:29 2002
> @@ -21,8 +21,10 @@
>   * Are we in an interrupt context? Either doing bottom half
>   * or hardware interrupt processing?
>   */
> -#define in_interrupt() ({ int __cpu = smp_processor_id(); \
> -       (local_irq_count(__cpu) + local_bh_count(__cpu) != 0); })
> +#define in_interrupt() ({ int __cpu; preempt_disable(); \
> +       __cpu = smp_processor_id(); \
> +       (local_irq_count(__cpu) + local_bh_count(__cpu) != 0); \
> +       preempt_enable(); })
> 
>  #define in_irq() (local_irq_count(smp_processor_id()) != 0)
> 
> 
> Or perhaps leave the code as-is but make the rule preemption needs to be
> disabled before calling (either implicitly or explicitly).  I.e., via a
> call to preempt_disable or because interrupts are disabled, a lock is
> held, etc ...

Right, getting a consistant flag is not much use if it isn't used within
the same context.
> 
> > In fact almost all uses of local_irq_count() and local_bh_count() are
> > for the current cpu; the exceptions are the irqs_running() function
> > and some debug printks.  Maybe the irq and bh counters themselves
> > could be put into the thread_info struct, if irqs_running could be
> > implemented another way.
> 
> One thing Linus, DaveM, and I discussed a while back was actually
> getting rid of the irq and bh counts completely and folding them into
> preempt_count.  I am interested in this...

Yes.

> 
>         Robert Love
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
