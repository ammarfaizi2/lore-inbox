Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbSJ2N7f>; Tue, 29 Oct 2002 08:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSJ2N7e>; Tue, 29 Oct 2002 08:59:34 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:37320 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261834AbSJ2N7d>; Tue, 29 Oct 2002 08:59:33 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Race in net/socket.c?
Date: Tue, 29 Oct 2002 15:05:38 +0100
User-Agent: KMail/1.4.7
References: <200210291437.16928.baldrick@wanadoo.fr> <200210291350.g9TDoYp01534@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200210291350.g9TDoYp01534@Port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210291505.38963.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 19:42, Denis Vlasenko wrote:
> On 29 October 2002 11:37, Duncan Sands wrote:
> > I am trying to understand the locking in net/socket.c.
> > Suppose the system is uniprocessor (no preemption).
> > Then the various locking routines do nothing:
> >
> > #define net_family_write_lock() do { } while(0)
> > #define net_family_write_unlock() do { } while(0)
> > #define net_family_read_lock() do { } while(0)
> > #define net_family_read_unlock() do { } while(0)
> >
> > Look in sock_create:
> >
> >         net_family_read_lock();
> > 	...
> >         if ((i = net_families[family]->create(sock, protocol)) < 0)
> > <= may sleep ...
> >         net_family_read_unlock();
> >
> > The call to create(...) may sleep.  Suppose during this sleep a task
> > is run that calls sock_unregister:
>
> You may not sleep under spinlock, only under semaphore.
> AFAIK rwlock is a spinlock.

It is not a real rwlock.  It acts like a rwlock but allows you to sleep
while reading (not while writing).

> If create() can sleep, that's a bug to fix.

The special locking takes care of that on SMP systems.  The problem
is on UP where there is no locking at all!

> > int sock_unregister(int family)
> > {
> >         if (family < 0 || family >= NPROTO)
> >                 return -1;
> >
> >         net_family_write_lock();
> >         net_families[family]=NULL;
> >         net_family_write_unlock();
> >         return 0;
> > }
> >
> > Since net_family_write_lock() is a noop, this succeeds, and returns.
>
> On (SMP kernel)+(UP box) CPU can enter sock_unregister
> and it will spin forever on write_lock(). So you'll get a hang
> instead of a race.

Again - it is not a real rwlock, it is a strange home grown creature...

> In a semaphore case, 2nd task would reschedule instead of spinning
> and evetually you will unlock in 1st task.

In fact the odd locking is trying to be a rw_semaphore: a semaphore
with any number of readers, but at most one writer, and no writers
while there are readers.  I am a bit surprised that such a semaphore
does not exist in the kernel...

> > Happy is my task!  It has returned from sock_unregister, so can now,
> > for example, free memory used for implementing that protocol.  But
> > the original create(...) call is in the middle of using that
> > protocol.  Unhappy am I!  I am dead!
> >
> > What have I missed?
>
> Nothing. But I am not an expert ;)

Neither am I!

Thanks, Duncan.

PS: I am CCing lkml.
