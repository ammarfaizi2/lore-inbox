Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293589AbSCFO2K>; Wed, 6 Mar 2002 09:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293595AbSCFO2B>; Wed, 6 Mar 2002 09:28:01 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:26041 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293589AbSCFO1x>;
	Wed, 6 Mar 2002 09:27:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Futexes III : performance numbers
Date: Wed, 6 Mar 2002 09:28:42 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <E16iQrS-0005vY-00@wagner.rustcorp.com.au>
In-Reply-To: <E16iQrS-0005vY-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020306142738.104A83FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 March 2002 09:08 pm, Rusty Russell wrote:
> In message <20020305212210.B10A33FF04@smtp.linux.ibm.com> you write:
> > On Tuesday 05 March 2002 02:01 am, Rusty Russell wrote:
> > > 1) FUTEX_UP and FUTEX_DOWN defines. (Robert Love)
> > > 2) Fix for the "decrement wraparound" problem (Paul Mackerras)
> > > 3) x86 fixes: tested on dual x86 box.
> > >
> > > Example userspace lib attached,
> > > Rusty.
> >
> > I did a quick hack to enable ulockflex to run on the latest interface
> > that Rusty posted.
>
> Cool... is this 8-way or some such "serious" SMP?  How about the
> below microoptimization (untested, but you get the idea).
>
> > Now 3 processes
> >  3  1  5  4 k      0   0   0   99.98   0.00   0.00 0.033284   242040
> >  3  1  5  4 m     0   0   0    0.29   0.00   0.00 0.018406  1979992
> >  3  1  5  4 f      0   0   0   99.71   0.00   0.00 0.028083   306140
> >  3  1  5  4 c      0   0   0    7.79   0.00   4.00 0.437084   774175
> >
> > Interesting... the strict FIFO ordering of my fast semaphores limits
> > performance as seen by 99.71% contention, so we always ditch
> > into the kernel. Convoy Avoidance locks 2.5 times better.
>
> Hmmm... actually I'm limited FIFO, in that I queue on the tail and do
> wake one.  Of course, someone can come in userspace and grab the lock
> while the guy in the kernel is waking up, and this is clearly
> happening here.
>
> This can be fixed, I think, by saying to the one we wake up "you have
> the lock" and never actually changing the value to 1.  This might cost
> us very little: I'll send another patch this afternoon.
>

Well, yes it can be fixed as I did in my package, but it comes at a 
substantial cost as seen above. The question is whether to simply 
ignore strict FIFO requirements ?
Doing the FIFO leads to the convoy problem, namely your lock arrival
becomes the scheduling queue.
As seen above from the nonexisting contention,  mootexes completely
exhaust their scheduling quantum before allowing anybocy else to grap
the lock. This is desired behavior particular for high traffic, low lockhold
time locks, but not for others.

In this case you simply hand over the lock and won't allow anybody
in user space to grap it during the time window one is woken up in 
the kernel.
Also, from my own experience doing a spinning lock that way

Another issue, is a few more operations, what would be nice is to be
able to wake up all waiting processes and have them recontent?

> Cheers!
> Rusty.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
