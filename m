Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268432AbRHRV6H>; Sat, 18 Aug 2001 17:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbRHRV55>; Sat, 18 Aug 2001 17:57:57 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:14596 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S268432AbRHRV5x>;
	Sat, 18 Aug 2001 17:57:53 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108182157.f7ILvt832092@oboe.it.uc3m.es>
Subject: Re: scheduling with io_lock held in 2.4.6
In-Reply-To: <3B7EC41C.9811D384@zip.com.au> from "Andrew Morton" at "Aug 18,
 2001 12:38:04 pm"
To: "Andrew Morton" <akpm@zip.com.au>
Date: Sat, 18 Aug 2001 23:57:55 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Andrew Morton wrote:"
> "Peter T. Breuer" wrote:
> > 
> > "Andrew Morton wrote:"
> > > "Peter T. Breuer" wrote:
> > > >   Aug 17 01:41:01 xilofon kernel: Scheduling with io lock held in process 1141
> > 
> > > Replace the printk with a BUG(), feed the result into ksymooops.
> > > Or use show_trace(0).

> Suggest you add the BUG() when it occurs, feed it into ksymoops
> and post it.  All will be revealed.

Whilst I've viewed dozens of the oopses, the call trace hasn't
enlightened me (there's usually an interrupt in it, which throws me),
and adding the oops seemed to destabilize the kernel. Does "atomic_set"
really work? It seems to be just an indirected write. I am suspicious
that the atomic writes I tried to do for the data aren't atomic. The
expansion of atomic_set(&io_request_lock_pid, current_pid()) is:

 ((( &io_request_lock_pid )->counter) = (  current_pid() )) ;

which doesn't look guarded by anything to me. Is the thory that this
expands to a single machine code instruction, and memory writes are
atomic anyway?

I'll produce some oops for you tomorrow. But they don't go to log, as
the io spinlock is held. There are no oops in any of the logs in this debian
2.2 machine, although syslog is supposed to be directing kern mesages
to kern.log (and bootup messages indeed do go there).

It's hard for me to experiment as the machine won't reboot remotely
(smp, apm, yadda, yadda).

I'll see ... btw, the problem seemed to track further to
blkdev_release_request. Aha aha aha aha aha ... the comment at the
top of that function says that not only must the io_request_lock be
held but irqs must be disabled. Do they mean locally or globally? I'm
holding them off locally (via spin_lock_irqsave).

Peter
