Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUDAUqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbUDAUqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:46:52 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:63500 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263154AbUDAUqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:46:48 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Nikita V. Youshchenko" <yoush@cs.msu.su>, linux-kernel@vger.kernel.org
Subject: Re: Strange 'zombie' problem both in 2.4 and 2.6
Date: Thu, 1 Apr 2004 23:46:39 +0300
User-Agent: KMail/1.5.4
Cc: ghost@cs.msu.su, bahmurov@cs.msu.su
References: <200404011442.18078@zigzag.lvk.cs.msu.su> <200404011909.20671.vda@port.imtp.ilyichevsk.odessa.ua> <200404020025.25122@sercond.localdomain>
In-Reply-To: <200404020025.25122@sercond.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404012346.39237.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 23:25, Nikita V. Youshchenko wrote:
> > > As far as I understand, in case of threads SIGRT_1 is used instead of
> > > SIGCHLD.
> > > So I tried to send SIGRT_1 to the parent manually. And zombies
> > > disappeared! However, new zombies appear soon. They may still be
> > > removed by manual SIGRT_1, but it is not a solution for a kernel bug
> > >
> > > :).
> >
> > Maybe. Maybe not. I am no expert, I'd try to learn out how SIGRT_1
> > is generated in normal case (I suppose kernel does not distinguish
> > between threads and processes, maybe it's done by threading libs?)
>
> I've looked at the kernel source.
> This is what I found.

Good! :)

> - looks like do_notify_parent() from kernel/signal.c is called to notify
> parent about child termination.
>
> - do_notify_parent() calls __group_send_sig_info() to send the signal, and
> does not check the return code. However, __group_send_sig_info() may fail.
>
> - __group_send_sig_info() calls send_signal()
>
> - send_signal() contains the following code:
>
> 	struct sigqueue * q = NULL;
> ...
> 	if (atomic_read(&nr_queued_signals) < max_queued_signals)
> 		q = kmem_cache_alloc(sigqueue_cachep, GFP_ATOMIC);
> 	if (q) {
> ...
> 	} else {
> 		if (sig >= SIGRTMIN && info && (unsigned long)info != 1
> 		   && info->si_code != SI_USER)
> 			return -EAGAIN;
> ...
>
> SIGRT_1 = 33, 33 is greater than SIGRTMIN, info is definitely not 0 or 1,
> and info->si_code is definitly not SI_USER on the path related to parent
> process notification.
>
> nr_queued_signals and sigqueue_cachep seem to be local for kernel/signal.c
> file, and code is organized such that nr_queued_signals shows exactly how
> many elements are allocated in sigqueue_cachep.
> max_queued_signals equals to 1024, so it is not allowed to allocate more
> than 1024 elements from sigqueue_cachep.
>
> sigqueue_cachep is initialized in signals_init():
> 	sigqueue_cachep =
> 		kmem_cache_create("sigqueue",
> 				  sizeof(struct sigqueue),
> 				  __alignof__(struct sigqueue),
> 				  0, NULL, NULL);
>
> So I looked into /proc/slabinfo on the server running "zombie-loving"
> kernel, and found the following line:
> nikita@zigzag:/proc> grep sigqueue slabinfo
> sigqueue 1024   1107  144  27  1 : tunables  120  60  8 : slabdata 41 41  0
>
> As far as I understand, the first number in this output is the number of
> elements allocated from "sigqueue" cache. That is, all 1024 elements are
> allocated!
>
> So looks like 'atomic_read(&nr_queued_signals) < max_queued_signals' is
> false, so 'q' is not allocated, and send_signal() returns -EAGAIN while
> trying to send SIGRT_1 to the parent process. This error code is passed
> from __group_send_sig_info() to do_notify_parent(), and just ignored
> there.

Hmmm what it can do there? Maybe only printk(). The question is why
sigqueue gets so big and does not shrink.

> So signal is not delivered, and dying process is left in zombie
> state.
>
> So "something" that happens in the kernel that makes it "zombie-lover" is
> sigqueue overflow.

You found an explanation why there are zombies. Now, why it starts to happen?
Why does it persists? There must be some code which shrinks sigqueue.
It does not seem to work right.
--
vda

