Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291863AbSCDGfS>; Mon, 4 Mar 2002 01:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291878AbSCDGfJ>; Mon, 4 Mar 2002 01:35:09 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:5819 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S291863AbSCDGex>; Mon, 4 Mar 2002 01:34:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kittur Sameer <kssameer@attbi.com>
Reply-To: kssameer@attbi.com
To: sridharv@ufl.edu, linux-kernel@vger.kernel.org
Subject: Re: interrupt - spin lock question
Date: Sun, 3 Mar 2002 22:32:37 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <1015219129.3c8303b9e87a7@webmail.health.ufl.edu>
In-Reply-To: <1015219129.3c8303b9e87a7@webmail.health.ufl.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020304063447.THGI2951.rwcrmhc53.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 March 2002 09:18 pm, sridharv@ufl.edu wrote:
> I have a question related to spin locking on UP systems.Before that I would
> like to point out my understanding of the background stuff
> 1. spinlocks shud be used in intr handlers

It should be used in the interrupt handler, if you need to prevent any  race 
conditions with other interrupt/non-interrupt  context code that may be 
executing on some other CPU on an SMP system. Thus spinlocks need to be held 
for as short a duration as possible. You would need to use the 
spin_lock_irqsave/spin_unlock_irqrestore variant pair to prevent your 
interrupt handler from running on the same processor while holding the lock. 
This may be  needed if the interrupt handler may try to acquire the same lock 
thus causing a deadlock.

> 2. interrupts can preempt kernel code
> 3. spinlocks are turned to empty when kernel is compiled without SMP
> support.
>
> If a particular driver is running( not the intr handler part) and at this
> time an interrupt occurs. The handler has to be invoked now. Won't the
> preemption cause race conditions/inconsistencies? Is any other mechanism
> used? Pl correct me if I have not understood any part of this correctly

On a UP kernel the spin_lock_irqsave/spin_unlock_irqrestore pair expand to 
save_flags(flag); cli()/restore_flags(flag).

The masking of interrupts on the processor between spin_lock_irqsave and 
spin_unlock_irqrestore  pair prevent the user context code from being 
preempted by the interrupt handler.


Sameer.
