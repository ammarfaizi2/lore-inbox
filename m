Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTLMDPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 22:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTLMDPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 22:15:13 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:16324 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263102AbTLMDPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 22:15:09 -0500
Message-ID: <3FDA8435.3060205@colorfullife.com>
Date: Sat, 13 Dec 2003 04:15:01 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

 From Chapter 4.1:

> |spin_lock_irqsave()| (include/linux/spinlock.h) is a variant which 
> saves whether interrupts were on or off in a flags word, which is 
> passed to |spin_unlock_irqrestore()|. This means that the same code 
> can be used inside an hard irq handler (where interrupts are already 
> off) and in softirqs (where the irq disabling is required).

Interrupts are typically on within the hard irq handler.
spin_lock() is usually ok because an interrupt handler is never 
reentered. Thus if a lock is only accessed from a single irq handler, 
then spin_lock() is the faster approach. That's why many nic drivers use 
spin_lock instead of spin_lock_irqsave() in their irq handlers.
OTHO: if a driver lock is a global resource that is used from different 
irqs, then it must either use _irqsave(), or set SA_INTERRUPT.
Examples: rtc_lock relies on SA_INTERRUPT: it's touched from the rtc irq 
and the timer irq path, and both rtc and timer set SA_INTERRUPT.
I assume ide relies on _irqsave(), but the code is too difficult to follow.

Btw, perhaps you could add the 2nd synchronization approach for 
interrupts: if it's an extremely rare event, then no lock at all in the 
irq handler (no reentrancy guaranteed by the kernel), and 
spin_lock+disable_irq() in the softirq/tasklet. My network drivers use 
that to synchronize packet rx with close.

--
    Manfred

