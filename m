Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268848AbRHRWN3>; Sat, 18 Aug 2001 18:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRHRWNL>; Sat, 18 Aug 2001 18:13:11 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:43025 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268848AbRHRWMx>; Sat, 18 Aug 2001 18:12:53 -0400
Message-ID: <3B7EE86F.49906C18@zip.com.au>
Date: Sat, 18 Aug 2001 15:13:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ptb@it.uc3m.es
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: scheduling with io_lock held in 2.4.6
In-Reply-To: <3B7EC41C.9811D384@zip.com.au> from "Andrew Morton" at "Aug 18,
	 2001 12:38:04 pm" <200108182157.f7ILvt832092@oboe.it.uc3m.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" wrote:
> 
> "A month of sundays ago Andrew Morton wrote:"
> > "Peter T. Breuer" wrote:
> > >
> > > "Andrew Morton wrote:"
> > > > "Peter T. Breuer" wrote:
> > > > >   Aug 17 01:41:01 xilofon kernel: Scheduling with io lock held in process 1141
> > >
> > > > Replace the printk with a BUG(), feed the result into ksymooops.
> > > > Or use show_trace(0).
> 
> > Suggest you add the BUG() when it occurs, feed it into ksymoops
> > and post it.  All will be revealed.
> 
> Whilst I've viewed dozens of the oopses, the call trace hasn't
> enlightened me (there's usually an interrupt in it, which throws me),

Yes, there are often interrupt entrails on the stack.  If you can,
generate that trace and send it....

> and adding the oops seemed to destabilize the kernel. Does "atomic_set"
> really work? It seems to be just an indirected write. I am suspicious
> that the atomic writes I tried to do for the data aren't atomic. The
> expansion of atomic_set(&io_request_lock_pid, current_pid()) is:
> 
>  ((( &io_request_lock_pid )->counter) = (  current_pid() )) ;

That's OK - this is the x86 version of atomic_set and yes, we
assume that the compiler will generate a single write for the
store.  All the x86 MP cache coherency stuff takes care of
the atomicity wrt other CPUs.
 
> ...
> I'll see ... btw, the problem seemed to track further to
> blkdev_release_request. Aha aha aha aha aha ... the comment at the
> top of that function says that not only must the io_request_lock be
> held but irqs must be disabled. Do they mean locally or globally? I'm
> holding them off locally (via spin_lock_irqsave).

Locally.  You need to take spin_lock_irqsave(&io_request_lock)
before calling that function.  It doesn't call anything which
sleeps, either.

It may simplify your oops tracing to remove all the `inline'
qualifiers in ll_rw_blk.c, BTW.  They tend to obscure things.
They should in fact be taken out permanently - someone went
absolutely insane there.

-
