Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVBBSy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVBBSy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVBBSy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:54:57 -0500
Received: from www2.muking.org ([216.231.42.228]:45883 "HELO www2.muking.org")
	by vger.kernel.org with SMTP id S262696AbVBBSs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:48:56 -0500
To: linux-kernel@vger.kernel.org
Subject: Real-Time Preemption and GFP_ATOMIC    
From: Kevin Hilman <kevin@hilman.org>
Organization: None to speak of.
Date: 02 Feb 2005 10:48:54 -0800
Message-ID: <83r7jyiyqx.fsf@www2.muking.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While testing an older driver on an -RT kernel (currently using
-V0.7.37-03), I noticed something strange.

The driver was triggering a "sleeping function called from invalid
context" BUG().  It was coming from a case where the driver was doing
a __get_free_page(GFP_ATOMIC) while interrupts were disabled (example
trace below).  I know this is probably real bug and it shouldn't be
allocating memory with interrupts disabled, but shouldn't this be
possible?  Isn't the role of GFP_ATOMIC to say that "this caller
cannot sleep". 

To produce the following trace, I wrote a simple moudle which just has
this as its init_module routine:

        local_irq_disable();
        p = __get_free_page(GFP_ATOMIC);
        local_irq_enable();
 
And here's the trace:

BUG: sleeping function called from invalid context insmod(2126) at kernel/rt.c:1448
in_atomic():0 [00000000], irqs_disabled():1
 [<c0102fa3>] dump_stack+0x23/0x30 (20)
 [<c01133c5>] __might_sleep+0xe5/0x100 (36)
 [<c012fbb8>] __spin_lock+0x38/0x60 (24)
 [<c012fc8d>] _spin_lock_irqsave+0x1d/0x30 (16)
 [<c0140e5c>] buffered_rmqueue+0x1c/0x190 (40)
 [<c01413ce>] __alloc_pages+0x34e/0x390 (76)
 [<c0141437>] __get_free_pages+0x27/0x50 (12)
 [<c883205a>] kmod_init+0x5a/0x74 [kmod] (24)
 [<c0138232>] sys_init_module+0x232/0x260 (28)
 [<c010299c>] syscall_call+0x7/0xb (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c0133e3d>] .... print_traces+0x1d/0x60
.....[<c0102fa3>] ..   ( <= dump_stack+0x23/0x30)




