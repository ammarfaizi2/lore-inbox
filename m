Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293607AbSCEEie>; Mon, 4 Mar 2002 23:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293605AbSCEEiY>; Mon, 4 Mar 2002 23:38:24 -0500
Received: from [202.135.142.196] ([202.135.142.196]:52228 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293604AbSCEEiH>; Mon, 4 Mar 2002 23:38:07 -0500
Date: Tue, 5 Mar 2002 15:41:23 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-Id: <20020305154123.078f0865.rusty@rustcorp.com.au>
In-Reply-To: <20020304115143.B1116@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au>
	<20020225100025.A1163@elinux01.watson.ibm.com>
	<20020227112417.3a302d31.rusty@rustcorp.com.au>
	<20020302095031.A1381@elinux01.watson.ibm.com>
	<20020304003040.21ac02b7.rusty@rustcorp.com.au>
	<20020304115143.B1116@elinux01.watson.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002 11:51:43 -0500
Hubertus Franke <frankeh@watson.ibm.com> wrote:
> > This is a definite advantage: my old fd-based code never looked at the
> > userspace counter: it had a kernel sempahore to sleep on for each
> > userspace lock. OTOH, this involves kernel allocation, with the complexity
> > that brings.
> > 
> 
> ???, kernel allocation is only required in under contention. If you take a look 
> at how I used the atomic word for semaphores and for rwlock_t, its different. 
> If you recheck in the kernel you need to know how this is used.
> In my approach I simply allocated two queues on demand.

Yes, but no allocation is even better than on-demand allocation, if you can
get away with it.

> I am OK with only supplying semaphores and rwlocks, if there is a general consent
> about it. Nevertheless, I think the multiqueue approach is somewhat more elegant
> and expandable.

Well, it's pretty easy to allow other values than -1/1 later as required.
I don't think the switch() overhead will be measurable for the first dozen
lock types 8).

> > > (h) how do you deal with signals ? E.g. SIGIO or something like it.
> > 
> > They're interruptible, so you'll get -ERESTARTSYS.  Should be fine.
> >  
> 
> That's what I did too, but some folks pointed out they might want to 
> interrupt a waking task, so that it can get back into user space and
> fail with EAGAIN or so and do not automatically restart the syscall.

Sorry, my bad.  I use -EINTR, so they don't get restarted, for exactly that
reason (eg. implementing timeouts on mutexes).

Cheers!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
