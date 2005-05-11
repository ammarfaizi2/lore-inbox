Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVEKOnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVEKOnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVEKOnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:43:10 -0400
Received: from general.keba.co.at ([193.154.24.243]:21149 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261172AbVEKOlW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:41:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Real-Time Preemption: BUG initializing kgdb
Date: Wed, 11 May 2005 16:41:16 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F36732320E@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Real-Time Preemption: BUG initializing kgdb
Thread-Index: AcVVq1d3cESUrNB1QpiLRwJo+wPQhwAgvseA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Bill Huey \(hui\)" <bhuey@lnxw.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "Lee Revell" <rlrevell@joe-job.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, May 10, 2005 at 02:34:54PM +0200, kus Kusche Klaus wrote:
> > I tried to merge the kgdb and the rt patches (not too 
> difficult, only
> > three rejects, and they all look trivial). The resulting kernel
> > compiles, boots, and works fine.
> ...
> > Any hints or suggestions?
> 
> Revert all spinlock_t types that kgdb uses to raw_spinlock_t 
> to get the
> actual spinlock code. A compile trick matches up the right functions
> with the struct definition so that changes to the kernel code 
> is minimized.
> The spinlock_t defintion in the RT patch is #defined to be a 
> blocking lock
> which is not what kgdb wants in order to be happy.
> 
> Also, make the interrupt handler setup uses SA_NODELAY or 
> something like
> that from my memory. The rest is relatively trivial.
> 
> Thanks for making the attempt. Somebody needed to do this a long time
> ago. :)
> 
> bill

Your hints helped a lot, thanks.

I changed three spinlocks (ts_spin, uart_interrupt_lock, one_at_atime)
and modified the kgdb serial interrupt handler to register with
SA_NODELAY (no need to change more locks, as I'm on a non-SMP target).

These changes resulted in a kernel which compiles and works fine, they
cured the BUG I reported yesterday, and they made kgdb "basically work":
I can connect over serial line or over ethernet, I can get "where"s and
variables etc., I can "cont", ...

However, there are still some issues:

* When debugging over ethernet, the kernel produces the following
messages in an infinite loop at full speed as long as it is halted by
gdb:

May 11 16:13:02 OF455 kern.warn kernel: ksoftirqd/0/2: BUG in
netpoll_poll at net/core/netpoll.c:157
May 11 16:13:02 OF455 kern.warn kernel:  [<c0102f29>]
dump_stack+0x17/0x19 (12)
May 11 16:13:02 OF455 kern.warn kernel:  [<c0224ac8>]
netpoll_poll+0xd0/0xed (36)
May 11 16:13:02 OF455 kern.warn kernel:  [<c01da116>]
eth_getDebugChar+0x16/0x41 (8)
May 11 16:13:02 OF455 kern.warn kernel:  [<c010c87e>]
getDebugChar+0x18/0x1a (8)
May 11 16:13:02 OF455 kern.warn kernel:  [<c010cba2>]
putpacket+0x184/0x198 (80)
May 11 16:13:02 OF455 kern.warn kernel:  [<c010e06b>]
kgdb_handle_exception+0xbfa/0xd0c (184)
May 11 16:13:02 OF455 kern.warn kernel:  [<c01034a5>] do_int3+0x2c/0x9b
(64)
May 11 16:13:02 OF455 kern.warn kernel:  [<c0102ca6>] int3+0x1e/0x2c
(60)
May 11 16:13:02 OF455 kern.warn kernel:  [<c021c900>]
net_rx_action+0x14e/0x188 (28)
May 11 16:13:02 OF455 kern.warn kernel:  [<c0118806>]
___do_softirq+0x42/0xc8 (44)
May 11 16:13:02 OF455 kern.warn kernel:  [<c011890e>]
_do_softirq+0x19/0x1c (8)
May 11 16:13:02 OF455 kern.warn kernel:  [<c0118c1e>]
ksoftirqd+0x8c/0xd9 (28)
May 11 16:13:02 OF455 kern.warn kernel:  [<c012614e>] kthread+0x7b/0xab
(32)
May 11 16:13:02 OF455 kern.warn kernel:  [<c0100c21>]
kernel_thread_helper+0x5/0xb (1055072276)

(this is a WARN_ON_RT(irqs_disabled()) in netpoll.c)

As soon as I "cont", the messages stop, and the kernel works fine. As
soon as I hit a breakpoint, these messages start again.

* When debugging over the ethernet, sooner or later all non-gdb traffic
fails: Although remote kgdb still works fine, the host and the target
can't even ping each other. The target even sends arp requests for the
host (which are answered, but it doesn't help).

This is a problem for me, because usually the targets neither have
keyboards nor screens, ssh is the only way in.

* Alt-SysRq-g is silently ignored when typed on the target's keyboard.
However, "echo g > /proc/sysrq-trigger" works fine.

Many thanks in advance for any help!

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
