Return-Path: <linux-kernel-owner+w=401wt.eu-S965178AbWLUKHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWLUKHv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 05:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422933AbWLUKHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 05:07:51 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:59957 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965178AbWLUKHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 05:07:50 -0500
Date: Thu, 21 Dec 2006 11:05:51 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Sorin Manolache" <sorinm@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: newbie questions about while (1) in kernel mode and spinlocks
Message-ID: <20061221110551.104ca3e1@localhost>
In-Reply-To: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
References: <20170a030612210141y6578602eo525e6df5f324747d@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2006 10:41:44 +0100
"Sorin Manolache" <sorinm@gmail.com> wrote:

> The Linux Device Drivers book says that a spin_lock should not be
> shared between a process and an interrupt handler. The explanation is
> that the process may hold the lock, an interrupt occurs, the interrupt
> handler spins on the lock held by the process and the system freezes.
> Why should it freeze? Isn't it possible for the interrupt handler to
> re-enable interrupts as its first thing, then to spin at the lock, the
> timer interrupt to preempt the interrupt handler and to relinquish
> control to the process which in turn will finish its critical section
> and release the lock, making way for the interrupt handler to
> continue.

Iterrupt handlers are executend in the process context (on top of the
process that they interrupted).

So, if you have a proccess A that does:

	Usual Kernel Code		Interrupt Handler

	...
	spin_lock(my_lock);
	...
		-------interrupt----->	...
					spin_lock(my_lock); // deadlock!
					...
		<------ back --------- 
	----
	spin_unlock(my_lock);


See?

If the interrupt comes in when process A is running and holding the
lock PREEMPTION can't do anything.

-- 
	Paolo Ornati
	Linux 2.6.20-rc1-g99f5e971 on x86_64
