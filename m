Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293727AbSCFRZc>; Wed, 6 Mar 2002 12:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293723AbSCFRZO>; Wed, 6 Mar 2002 12:25:14 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25840 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S293721AbSCFRZG>;
	Wed, 6 Mar 2002 12:25:06 -0500
Message-ID: <3C8650A3.F71D9FD0@mvista.com>
Date: Wed, 06 Mar 2002 09:23:47 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: frankeh@watson.ibm.com
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: Futexes III : performance numbers
In-Reply-To: <E16iQrS-0005vY-00@wagner.rustcorp.com.au> <20020306142738.104A83FE06@smtp.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke wrote:
> 
> On Tuesday 05 March 2002 09:08 pm, Rusty Russell wrote:
> > In message <20020305212210.B10A33FF04@smtp.linux.ibm.com> you write:
> > > On Tuesday 05 March 2002 02:01 am, Rusty Russell wrote:
> > > > 1) FUTEX_UP and FUTEX_DOWN defines. (Robert Love)
> > > > 2) Fix for the "decrement wraparound" problem (Paul Mackerras)
> > > > 3) x86 fixes: tested on dual x86 box.
> > > >
> > > > Example userspace lib attached,
> > > > Rusty.
> > >
> > > I did a quick hack to enable ulockflex to run on the latest interface
> > > that Rusty posted.
> >
> > Cool... is this 8-way or some such "serious" SMP?  How about the
> > below microoptimization (untested, but you get the idea).
> >
> > > Now 3 processes
> > >  3  1  5  4 k      0   0   0   99.98   0.00   0.00 0.033284   242040
> > >  3  1  5  4 m     0   0   0    0.29   0.00   0.00 0.018406  1979992
> > >  3  1  5  4 f      0   0   0   99.71   0.00   0.00 0.028083   306140
> > >  3  1  5  4 c      0   0   0    7.79   0.00   4.00 0.437084   774175
> > >
> > > Interesting... the strict FIFO ordering of my fast semaphores limits
> > > performance as seen by 99.71% contention, so we always ditch
> > > into the kernel. Convoy Avoidance locks 2.5 times better.
> >
> > Hmmm... actually I'm limited FIFO, in that I queue on the tail and do
> > wake one.  Of course, someone can come in userspace and grab the lock
> > while the guy in the kernel is waking up, and this is clearly
> > happening here.
> >
> > This can be fixed, I think, by saying to the one we wake up "you have
> > the lock" and never actually changing the value to 1.  This might cost
> > us very little: I'll send another patch this afternoon.
> >
> 
> Well, yes it can be fixed as I did in my package, but it comes at a
> substantial cost as seen above. The question is whether to simply
> ignore strict FIFO requirements ?
> Doing the FIFO leads to the convoy problem, namely your lock arrival
> becomes the scheduling queue.
> As seen above from the nonexisting contention,  mootexes completely
> exhaust their scheduling quantum before allowing anybocy else to grap
> the lock. This is desired behavior particular for high traffic, low lockhold
> time locks, but not for others.
> 
> In this case you simply hand over the lock and won't allow anybody
> in user space to grap it during the time window one is woken up in
> the kernel.
> Also, from my own experience doing a spinning lock that way
> 
> Another issue, is a few more operations, what would be nice is to be
> able to wake up all waiting processes and have them recontent?

Unless you are ready to go to priority queues (IMHO the preferred
approach) this is the only way to avoid priority inversion, especially
in a real time environment.

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
