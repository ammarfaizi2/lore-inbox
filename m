Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264096AbRGRXDo>; Wed, 18 Jul 2001 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRGRXDe>; Wed, 18 Jul 2001 19:03:34 -0400
Received: from [209.213.80.2] ([209.213.80.2]:51650 "EHLO
	joat.prv.ri.meganet.net") by vger.kernel.org with ESMTP
	id <S264096AbRGRXDP>; Wed, 18 Jul 2001 19:03:15 -0400
Message-ID: <3B5615E8.B838D6BD@ueidaq.com>
Date: Wed, 18 Jul 2001 19:04:08 -0400
From: Alex Ivchenko <aivchenko@ueidaq.com>
Organization: UEI, Inc.
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: PROBLEM SOLVED: 2.4.x SPINLOCKS behave differently then 2.2.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> Richard B. Johnson <root@chaos.analogic.com> wrote:
> >    ticks = 1 * HZ;        /* For 1 second */
> >    while((ticks = interruptible_sleep_on_timeout(&wqhead, ticks)) > 0)
> >                  ;
> Don't do this.
>
> Imagine what happens if a signal comes in and wakes you up? The signal
> will continue to be pending, which will make your "sleep loop" be a busy
> loop as you can never go to sleep interruptibly with a pending signal.

Well, the problem was quite different compare to what I thought.

Our hardware requires that once you start talking to firmware you cannot let
anybody to interrupt you.
Thus, I lazily put in all "magic" handlers (read, write, ioctl):

my_ioctl() {
... do entry stuff
_fw_spinlock // = spin_lock_irqsave(...);

.. do my stuff (nobody could interrupt me)

_fw_spinunlock // = spin_lock_irqrestore(...);
}

Everything worked fine under 2.2.x (I knew that this was a shortcut!!!)
In 2.4.x I could not call wake_up_interruptible() while in spinlock 
(and it's clearly understandable).

Now it seems that I have to grab and release spinlock each time I talk to the board,
exactly as I did in NT:
     KeAcquireSpinLock(&Adapter->DeviceLock, &oldIrql);
     if (KeSynchronizeExecution(Adapter->InterruptObject, PdAdapterEnableInterrupt, &Context));
     KeReleaseSpinLock(&Adapter->DeviceLock, oldIrql);

What d'u think?

-- 
Regards,
Alex

--
Alex Ivchenko, Ph.D.
United Electronic Industries, Inc.
"The High-Performance Alternative (tm)"
--
10 Dexter Avenue
Watertown, Massachusetts 02472
Tel: (617) 924-1155 x 222 Fax: (617) 924-1441
http://www.ueidaq.com
