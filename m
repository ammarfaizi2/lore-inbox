Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRJaWyA>; Wed, 31 Oct 2001 17:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275012AbRJaWxw>; Wed, 31 Oct 2001 17:53:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:38905 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S275126AbRJaWxo>; Wed, 31 Oct 2001 17:53:44 -0500
Message-ID: <3BE08108.91067996@mvista.com>
Date: Wed, 31 Oct 2001 14:54:00 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.30.0110311902410.29481-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to post this this AM, but it was a no show.  Here it is again:

First I want to thank Tim for pointing out (by usage) the do_div()
macro.  This has troubled me for some time.  Thanks Tim.

As to the method to use for 64-bit jiffies, the one Tim used was
discussed on the list a short time ago under the subject "How should we
do a 64-bit jiffies?" (thread started by me on 10/22/01).  The asm
overlay was discussed as well as other methods.  Linus proposed the
version that Tim used here and that I am using in the high-res-timers
patch. (See: http://sourceforge.net/projects/high-res-timers)  And, yes
it does make it a NO-NO to have a local variable (or a struct member)
named jiffies and I am sure that we will find other uses of such as
additional drivers and platforms are tried.
http://sourceforge.net/projects/high-res-timers
On the issue of locking, jiffies (in the current system) is updated
under the xtime_lock, so this is the lock one would use to read it if
you cared, however, as patched, almost NO ONE cares or needs to.  Just
using the low 32 bits and the existing compare macros will do just fine,
thank you.  For those that care, i.e. uptime, CLOCK_MONOTOINIC (and
other code in POSIX timers), either the xtime_lock (a read/write lock by
the way, not a spin lock) can be taken.

Here Tim is proposing a while loop which, IMHO, will fail in the SMP
case, but does handle the UP interrupt case quite nicely.

Tim Schmielau wrote:
> 
> On Wed, 31 Oct 2001, Richard B. Johnson wrote:
> 
> > On Wed, 31 Oct 2001, vda wrote:
> >
> > [SNIPPED...]
> >
> > > Hmm.... 64bit jiffies are attractive.
> > >
> > > I'd like to see less #defines in kernel
> > > Some parts of your patch fight with the fact that jiffies
> > > is converted to macro -> it is illegal now to have local vars
> > > called "jiffies". This is ugly. I know that there are tons of similarly
> > > (ab)used macros in the kernel now but let's stop adding more!
> > >
> > > This test prog shows how to make overlapping 32bit and 64bit vars.
> > > It works for me.
> > >
> 
> [asm snipped]
> 
> > >
> > > Is this better or not? If not, why?

The principle problem is platform dependence.

> > > --
> > > vda
> >
> > The problem is that a 64-bit jiffies on a 32-bit machine would
> > require a spin-lock every time the jiffies variable is changed!

Ah, but it is only changed in the timer interrupt which is already under
a write_irq lock.

> > This is because there are two (or more) memory accesses for
> > every 64 bit operation, plus two or more register accesses for
> > every 64 bit operation. If a context-switch or an interrupt
> > occurs between those operations, all bets are off about the
> > result.
> >
> > The appended small tar.gz file contains some 64-bit assembly
> > plus some 64-bit C, Look at the assembly and it will become
> > obvious to you that you don't want to use a 64-bit timer
> > on a 32 bit machine.
> >
> >
> > Cheers,
> > Dick Johnson
> >
> 
> The idea was that all drivers that use the 32 bit jiffies counter have to
> be aware of the wraparound anyways, and won't see a difference.
> The race only happens for 64 bit accesses to jiffies, but hey, without
> the patch these values come out wrong _every_ time, so I believed a
> tiny window for a single wrong display of uptime every 497.1 days to be
> acceptable.

For display, ok, but not for CLOCK_MONOTONIC and other POSIX timers
usage :)
> 
> If we want to make sure to eliminate this possibility as well, the kind of
> home-made synchronization may help that I came up with before considering
> the race acceptable. It also has the advantage of not touching the jiffies
> definition at all.

As pointed out above, this works for interrupts  on UP machines, but,
IMHO, will fail on SMP machines.

George

> 
> Tim
> 
> --- fs/proc/proc_misc.c.orig    Wed Oct 31 17:45:08 2001
> +++ fs/proc/proc_misc.c Wed Oct 31 18:49:19 2001
> @@ -39,6 +39,7 @@
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
> +#include <asm/div64.h>
> 
>  #define LOAD_INT(x) ((x) >> FSHIFT)
> @@ -103,15 +104,28 @@
>  static int uptime_read_proc(char *page, char **start, off_t off,
>                                  int count, int *eof, void *data)
>  {
> -       unsigned long uptime;
> +       u64 uptime;
> +       unsigned long jiffies_tmp, jiffies_high_tmp, remainder;
>         unsigned long idle;
>         int len;
> 
> -       uptime = jiffies;
> +       /* We need to make sure jiffies_high does not change while
> +        * reading jiffies and jiffies_high */
> +       do {
> +               jiffies_high_tmp = jiffies_high_shadow;
> +               barrier();
> +               jiffies_tmp = jiffies;
> +               barrier();
> +       } while (jiffies_high != jiffies_high_tmp);
> +
> +       uptime = jiffies_tmp + ((u64)jiffies_high_tmp << BITS_PER_LONG);
> +       remainder = (unsigned long) do_div(uptime, HZ);
> +
>         idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
> 
> -       /* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
> -          that would overflow about every five days at HZ == 100.
> +       /* The formula for the fraction part of the idle time really is
> +          ((t * 100) / HZ) % 100, but that would overflow about
> +           every five days at HZ == 100.
>            Therefore the identity a = (a / b) * b + a % b is used so that it is
>            calculated as (((t / HZ) * 100) + ((t % HZ) * 100) / HZ) % 100.
>            The part in front of the '+' always evaluates as 0 (mod 100). All divisions
> @@ -121,14 +135,14 @@
>          */
>  #if HZ!=100
>         len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> -               uptime / HZ,
> -               (((uptime % HZ) * 100) / HZ) % 100,
> +               (unsigned long) uptime,
> +               ((remainder * 100) / HZ) % 100,
>                 idle / HZ,
>                 (((idle % HZ) * 100) / HZ) % 100);
>  #else
>         len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> -               uptime / HZ,
> -               uptime % HZ,
> +               (unsigned long) uptime,
> +               remainder,
>                 idle / HZ,
>                 idle % HZ);
>  #endif
> --- kernel/timer.c.orig Wed Oct 31 17:24:36 2001
> +++ kernel/timer.c      Wed Oct 31 18:38:47 2001
> @@ -65,7 +65,9 @@
> 
>  extern int do_setitimer(int, struct itimerval *, struct itimerval *);
> 
> -unsigned long volatile jiffies;
> +#define INITIAL_JIFFIES 0xFFFFD000ul
> +unsigned long volatile jiffies = INITIAL_JIFFIES;
> +unsigned long volatile jiffies_high, jiffies_high_shadow;
> 
>  unsigned int * prof_buffer;
>  unsigned long prof_len;
> @@ -117,7 +119,7 @@
>                 INIT_LIST_HEAD(tv1.vec + i);
>  }
> 
> -static unsigned long timer_jiffies;
> +static unsigned long timer_jiffies = INITIAL_JIFFIES;
> 
>  static inline void internal_add_timer(struct timer_list *timer)
>  {
> @@ -638,7 +640,7 @@
>  }
> 
>  /* jiffies at the most recent update of wall time */
> -unsigned long wall_jiffies;
> +unsigned long wall_jiffies = INITIAL_JIFFIES;
> 
>  /*
>   * This spinlock protect us from races in SMP while playing with xtime. -arca
> @@ -673,7 +675,22 @@
> 
>  void do_timer(struct pt_regs *regs)
>  {
> -       (*(unsigned long *)&jiffies)++;
> +       /* we assume that two calls to do_timer can never overlap
> +        * since they are one jiffie apart in time */
> +       if (jiffies != 0xffffffffUL) {
> +               jiffies++;
> +       } else {
> +               /* We still need to care about the race with readers of
> +                * jiffies_high. Readers have to discard the values if
> +                * jiffies_high != jiffies_high_shadow when read with
> +                * proper barriers in between. */
> +               jiffies_high++;
> +               barrier();
> +               jiffies++;
> +               barrier();
> +               jiffies_high_shadow = jiffies_high;
> +               barrier();
> +       }
>  #ifndef CONFIG_SMP
>         /* SMP process accounting uses the local APIC timer */
> 
> --- kernel/info.c.orig  Wed Oct 31 17:58:25 2001
> +++ kernel/info.c       Wed Oct 31 18:48:52 2001
> @@ -12,15 +12,28 @@
>  #include <linux/smp_lock.h>
> 
>  #include <asm/uaccess.h>
> +#include <asm/div64.h>
> 
>  asmlinkage long sys_sysinfo(struct sysinfo *info)
>  {
>         struct sysinfo val;
> +       u64 uptime;
> +       unsigned long jiffies_tmp, jiffies_high_tmp;
> 
>         memset((char *)&val, 0, sizeof(struct sysinfo));
> 
>         cli();
> -       val.uptime = jiffies / HZ;
> +        /* We need to make sure jiffies_high does not change while
> +         * reading jiffies and jiffies_high */
> +        do {
> +                jiffies_high_tmp = jiffies_high_shadow;
> +                barrier();
> +                jiffies_tmp = jiffies;
> +                barrier();
> +        } while (jiffies_high != jiffies_high_tmp);
> +       uptime = jiffies_tmp + ((u64)jiffies_high_tmp << BITS_PER_LONG);
> +       do_div(uptime, HZ);
> +       val.uptime = uptime;
> 
>         val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
>         val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
