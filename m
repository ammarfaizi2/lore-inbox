Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRHaQPk>; Fri, 31 Aug 2001 12:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265249AbRHaQPb>; Fri, 31 Aug 2001 12:15:31 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:3220 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S267621AbRHaQP0>; Fri, 31 Aug 2001 12:15:26 -0400
Importance: Normal
Subject: NFS deadlock explained (on S/390)
To: oliver@paukstadt.de, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFBDD4401D.2B4C053F-ONC1256AB9.00573A30@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Fri, 31 Aug 2001 18:14:38 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 31/08/2001 18:14:42
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've found the cause of the NFS deadlocks on the S/390 platform.  It's
a classical case of deadlocking on two spinlocks; one spinlock is the
xprt_sock_lock, and the other is a private spinlock used by the QDIO
driver to protect its data structures accessed from both its bottom half
and its interrupt handler.

Specifically, what happens is that the first CPU runs the QDIO bottom
half (from ksoftirqd, but this is probably not important).  That bottom
half grabs the QDIO private spinlock, and then executes a bunch of code
including a dev_kfree_skb_any().  As we are only in a softirq, not a
hard irq, dev_kfree_skb_any() call kfree_skb() directly, which happens
to invoke the udp_write_space() callback in xprt.c.  This routine then
spins trying to acquire the xprt_sock_lock.

On the other CPU, an normal sys_open system call on an NFS file is
processed; the call path goes through nfs_permission, rpc_execute,
and rpc_release_task to xprt_release.  That routine holds the
xprt_sock_lock; however it takes it only with a spin_lock_bh, so that
interrupts are not disabled.  While the lock is held, a QDIO interrupt
comes in; the QDIO interrupt handler spins trying to acquire the
QDIO private lock (to protect itself against parallel execution with
the QDIO bottom half).

Now, you can argue who's at fault ;-)  On the one hand, QDIO should
probably hold on to its spinlock only for shorter periods of time,
and especially not call kfree_skb while holding it.

On the other hand, the xprt_sock_lock handling really appears to invite
such deadlocks, as xprt.c grabs it both from within the udp_write_space
callback, which can be called at times surprising to a driver who just
wanted to free a piece of memory, and at the same allows itself to be
interrupted by random driver IRQs while holding the lock ...

Whether this same situation can explain the deadlocks seen on other
platforms depends on whether the drivers used there exhibit similar
locking behaviours as the QDIO driver, of course.

(We've fixed our problem by changing the QDIO driver not to call
kfree_skb while holding to any lock.)


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

