Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281068AbRKDSFu>; Sun, 4 Nov 2001 13:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKDSFk>; Sun, 4 Nov 2001 13:05:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:21494 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S281056AbRKDSFY>; Sun, 4 Nov 2001 13:05:24 -0500
Message-ID: <3BE57139.4971ED0F@mvista.com>
Date: Sun, 04 Nov 2001 08:47:53 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sivakumar.kuppusamy@wipro.com
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Locks in kernel
In-Reply-To: <001701c1638e$9bd332e0$5f08720a@wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sivakumar Kuppusamy wrote:
> 
> Hi All,
> I am having doubts in locking mechanism in Linux 2.2 kernel code.
> 
> We have done modifications in the Linux kernel code to support our
> application which runs at the user space. The modification done in
> the Linux kernel is to maintain a table of data(like a routing table),
> which will be updated by the applicaition with appropriate data. This
> data will be used by the kernel for other processing.
> 
> We are using "up" & "down" functions for locking global data in the kernel.
> Our code in kernel will get called when a IP packet is received. During
> that time we are trying to lock that global data and retrieve some
> info from that. Is this a correct way to do. We are also locking
> the global data when it gets updated from the application. Since
> ip_rcv() gets called from bottom_half(), can we do any locking
> stuff there? We faced kernel panicking when the application locked
> the global data and got scheduled to continue later(with lock held).
> That time ip_rcv() got called and we are trying to acquire the lock
> which is held by the scheduled process. This made the kernel panic.
> 
> How should we approach this problem? Shouldn't we use any locking in
> the code which is called by the bottom_half()?
> 
As I am sure you are beginning to suspect, you need to NOT hold locks in
tasks that can sleep which are also accessed from an interrupt context
(bottom_half).  Among the locks that allow (or even force) sleeping are
the "up" "down" locks.  These must NOT be used from the interrupt
context.  Locks that can be used from the interrupt context are the
spinlocks.  Of these you would need to use the "irq" versions.  In this
group you will also find the read/ write locks which allow several
readers at a time, while writers are given exclusive access.

If you must allow sleeping locks, you will have to promote the interrupt
code to a kernel task which can sleep.  This is done using wait queues. 
There are various versions of these, but they all end up having the
"consumer" sleep until the "producer" calls "wake_up".  Again, there are
various wrappers that can be used here.  The key is that the interrupt
context calls the "wake_up" side and the kernel task calls the sleep
side.

Then you will most likely need to use one of the spinlock_irq locks to
synchronize the interrupt context with the kernel task, but remember,
the kernel task must NOT sleep while holding a spinlock.

This is an overview.  You can find much more detail in the
kernel-hacking-HOWTO
http://www.linuxgrill.com/anonymous/fire/netfilter/kernel-hacking-HOWTO-5.html
or try Google.

George
