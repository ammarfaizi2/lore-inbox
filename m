Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271336AbRHOSDP>; Wed, 15 Aug 2001 14:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271337AbRHOSCy>; Wed, 15 Aug 2001 14:02:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62205 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S271336AbRHOSCs> convert rfc822-to-8bit; Wed, 15 Aug 2001 14:02:48 -0400
Message-ID: <3B7AB93D.F8B5B455@mvista.com>
Date: Wed, 15 Aug 2001 11:02:37 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bruce Janson <bruce@cs.usyd.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: ptrace(), fork(), sleep(), exit(), SIGCHLD
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org> <20010814092849.E13892@pc8.lineo.fr> <20010814201825Z270798-760+1687@vger.kernel.org> <3B7A9953.744977A5@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Bruce Janson wrote:
> >
> > In article <20010814092849.E13892@pc8.lineo.fr>,
> > christophe =?iso-8859-1?Q?barb=E9?=  <christophe.barbe@lineo.fr> wrote:
> > ..
> > >Le lun, 13 aoû 2001 10:29:32, Bruce Janson a écrit :
> > ..
> > >>     The following program behaves incorrectly when traced:
> > ..
> > >Have you receive off-line answers?
> > ..
> >
> > No, though I did receive an offline reply from someone who appeared
> > to have misunderstood the post.  In case it wasn't clear, the problem
> > is that the above program behaves differently when traced to how it
> > behaves when not traced.  (I do realise that in general, under newer
> > Unices, when not ignored, a SIGCHLD signal may accompany the death of
> > a child.)
> >
> > >I guess that it's certainly more a strace issue and that it's perhaps
> > ..
> >
> > It's not clear to me whether it is a kernel, glibc or strace bug, but
> > it does appear to be a bug.
> 
> I don't have the code for usleep() handy and the man page is not much
> help, but here goes:
> 
> I think strace is using ptrace() which causes signals to be redirected
> to wake up the parent (strace in this case).  In particular, blocked
> signals are no longer blocked.  What this means is that a.) SIG CHILD is
> posted, b.) the signal, not being blocked, the child is wakened, c.)
> ptrace returns to the parent, d) the parent does what ever and tells the
> kernel (ptrace) to continue the child with the original mask, e.) the
> signal code returns 0 with out delivering the signal to the child.
> Looks good, right?  Wrong!  The wake up at (b) pulls the child out of
> the timer queue so when signal returns, the sleep (I assume nano sleep
> is actually used here) call returns with the remaining sleep time as a
> value.
> 
> This is an issue for debugging also (same ptrace...).  The fix is to fix
> nano_sleep to match the standard which says it should only return on a
> signal if the signal is delivered to the program (i.e. not on internal
> "do nothing" signals).  Signal in the kernel returns 1 if it calls the
> task and 0 otherwise, thus nano sleep might be changed as follows:
> 
>         expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
> 
>         current->state = TASK_INTERRUPTIBLE;
> -       expire = schedule_timeout(expire);
> +       while (expire = schedule_timeout(expire) && !signal());
Still not quite right.  regs needs to be dummied up (see sys_sigpause)
and then:
+       while (expire = schedule_timeout(expire) && !do_signal(regs,
NULL));
> 
>         if (expire) {
>                 if (rmtp) {
>                         jiffies_to_timespec(expire, &t);
>                         if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
>                                 return -EFAULT;
>                 }
>                 return -EINTR;
>         }
>         return 0;
> 
> This code is in ../kernel/timer.c
> 
> Note that this assumes that nano_sleep() underlies usleep().  If
> setitimer (via sleep() or otherwise) is used, the problem and fix is in
> the library.  In that case, the code needs to notice that it was
> awakened but the alarm handler was not called.  Still, with out the full
> spec on usleep() it is not clear what it should do.
> 
> In any case, this is a bug in nano_sleep(), where the spec is clear on
> this point.
> 
> George
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
