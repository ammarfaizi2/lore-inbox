Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRHPBA0>; Wed, 15 Aug 2001 21:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268599AbRHPBAQ>; Wed, 15 Aug 2001 21:00:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38896 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S268598AbRHPBAH> convert rfc822-to-8bit; Wed, 15 Aug 2001 21:00:07 -0400
Message-ID: <3B7B1B07.A9FB293B@mvista.com>
Date: Wed, 15 Aug 2001 17:59:51 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bruce Janson <bruce@cs.usyd.edu.au>, linux-kernel@vger.kernel.org
Subject: How should nano_sleep be fixed (was: ptrace(), fork(), sleep(), exit(), 
 SIGCHLD)
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org> <20010814092849.E13892@pc8.lineo.fr> <20010814201825Z270798-760+1687@vger.kernel.org> <3B7A9953.744977A5@mvista.com> <3B7AB93D.F8B5B455@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that nano_sleep needs to continue sleeping if it wakes up
on a signal which is not delivered to the task.  This happens when
"strace" or "ptrace" cause otherwise blocked signals to be delivered. 
Do_signal() returns 0 if it does not deliver a signal, a 1 if it does so
I propose the following changes to nano_sleep:

asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec
*rmtp)
{
	struct timespec t;
	unsigned long expire;
+	struct pt_regs * regs = (struct pt_regs *) &rqtp;

	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
		return -EFAULT;

	if (t.tv_nsec >= 1000000000L || t.tv_nsec < 0 || t.tv_sec < 0)
		return -EINVAL;


	if (t.tv_sec == 0 && t.tv_nsec <= 2000000L &&
	    current->policy != SCHED_OTHER)
	{
		/*
		 * Short delay requests up to 2 ms will be handled with
		 * high precision by a busy wait for all real-time processes.
		 *
		 * Its important on SMP not to do this holding locks.
		 */
		udelay((t.tv_nsec + 999) / 1000);
		return 0;
	}

	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);

-	current->state = TASK_INTERRUPTIBLE;
-	expire = schedule_timeout(expire);
+	regs->eax = -EINTR;
+	do {
+               current->state = TASK_INTERRUPTIBLE;
+       } while((expire = schedule_timeout(expire)) &&
!do_signal(regs,NULL));

	if (expire) {
		if (rmtp) {
			jiffies_to_timespec(expire, &t);
			if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
				return -EFAULT;
		}
		return -EINTR;
	}
	return 0;
}

BUT, it turns out that do_signal() is in the "arch" code, and further
that different arch's have different calling sequences (and, of course,
pt_regs is different also).  This is the ONLY place in the kernel where
platform independent code needs to call do_signal() :(  There does not
seem to be a clean answer for this issue.  I suppose we could put
something like this in timer.c:

#ifndef _do_signal
#define _do_signal(a,b) 1
#endif

and then leave it to the platform code to define a uniform
_do_signal(a,b) interface.  This way each platform will work as it does
now and better once they define the macro.  If this is the path to take,
what should the parameters "a" & "b" be?  We need to cover all platforms
needs.

Another way to solve this issue is to move nano_sleep into the "arch"
signal.c file, but then each would have to change and things would be
broken (i.e. nano_sleep would not work) until the platform made the
move.  I suppose the current nano_sleep could stay in the kernel and
each platform could implement one in their area with a different name. 
When all were done, the current code could be deleted.

How should this be approached?

George


george anzinger wrote:
> 
> george anzinger wrote:
> >
> > Bruce Janson wrote:
> > >
> > > In article <20010814092849.E13892@pc8.lineo.fr>,
> > > christophe =?iso-8859-1?Q?barb=E9?=  <christophe.barbe@lineo.fr> wrote:
> > > ..
> > > >Le lun, 13 aoû 2001 10:29:32, Bruce Janson a écrit :
> > > ..
> > > >>     The following program behaves incorrectly when traced:
> > > ..
> > > >Have you receive off-line answers?
> > > ..
> > >
> > > No, though I did receive an offline reply from someone who appeared
> > > to have misunderstood the post.  In case it wasn't clear, the problem
> > > is that the above program behaves differently when traced to how it
> > > behaves when not traced.  (I do realise that in general, under newer
> > > Unices, when not ignored, a SIGCHLD signal may accompany the death of
> > > a child.)
> > >
> > > >I guess that it's certainly more a strace issue and that it's perhaps
> > > ..
> > >
> > > It's not clear to me whether it is a kernel, glibc or strace bug, but
> > > it does appear to be a bug.
> >
> > I don't have the code for usleep() handy and the man page is not much
> > help, but here goes:
> >
> > I think strace is using ptrace() which causes signals to be redirected
> > to wake up the parent (strace in this case).  In particular, blocked
> > signals are no longer blocked.  What this means is that a.) SIG CHILD is
> > posted, b.) the signal, not being blocked, the child is wakened, c.)
> > ptrace returns to the parent, d) the parent does what ever and tells the
> > kernel (ptrace) to continue the child with the original mask, e.) the
> > signal code returns 0 with out delivering the signal to the child.
> > Looks good, right?  Wrong!  The wake up at (b) pulls the child out of
> > the timer queue so when signal returns, the sleep (I assume nano sleep
> > is actually used here) call returns with the remaining sleep time as a
> > value.
> >
> > This is an issue for debugging also (same ptrace...).  The fix is to fix
> > nano_sleep to match the standard which says it should only return on a
> > signal if the signal is delivered to the program (i.e. not on internal
> > "do nothing" signals).  Signal in the kernel returns 1 if it calls the
> > task and 0 otherwise, thus nano sleep might be changed as follows:
> >
> >         expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
> >
> >         current->state = TASK_INTERRUPTIBLE;
> > -       expire = schedule_timeout(expire);
> > +       while (expire = schedule_timeout(expire) && !signal());
> Still not quite right.  regs needs to be dummied up (see sys_sigpause)
> and then:
> +       while (expire = schedule_timeout(expire) && !do_signal(regs,
> NULL));
> >
> >         if (expire) {
> >                 if (rmtp) {
> >                         jiffies_to_timespec(expire, &t);
> >                         if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
> >                                 return -EFAULT;
> >                 }
> >                 return -EINTR;
> >         }
> >         return 0;
> >
> > This code is in ../kernel/timer.c
> >
> > Note that this assumes that nano_sleep() underlies usleep().  If
> > setitimer (via sleep() or otherwise) is used, the problem and fix is in
> > the library.  In that case, the code needs to notice that it was
> > awakened but the alarm handler was not called.  Still, with out the full
> > spec on usleep() it is not clear what it should do.
> >
> > In any case, this is a bug in nano_sleep(), where the spec is clear on
> > this point.
> >
> > George
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
