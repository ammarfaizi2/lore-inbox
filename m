Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWHYEis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWHYEis (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 00:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWHYEis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 00:38:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161001AbWHYEir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 00:38:47 -0400
Date: Thu, 24 Aug 2006 21:38:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Edward Falk <efalk@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
Message-Id: <20060824213828.5504b4de.akpm@osdl.org>
In-Reply-To: <p7364gifx8o.fsf@verdi.suse.de>
References: <44ED157D.6050607@google.com>
	<p7364gifx8o.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Aug 2006 08:45:11 +0200
Andi Kleen <ak@suse.de> wrote:

> Edward Falk <efalk@google.com> writes:
> 
> > Add spin_lock_string_flags and _raw_spin_lock_flags() to
> > asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same
> > semantics on x86_64 as it does on i386 and does *not* have interrupts
> > disabled while it is waiting for the lock.
> 
> Did it fix anything for you?
> 

It's the rendezvous-via-IPI problem.  Suppose we want to capture all CPUs
in an IPI handler (TSC sync, for example).

- CPUa holds read_lock(&tasklist_lock)
- CPUb is spinning in write_lock_irq(&taslist_lock)
- CPUa enters its IPI handler and spins
- CPUb never takes the IPI and we're dead.

Re-enabling interrupts while we spin will prevent that.  But I suspect that
if we ever want to implement IPI rendezvous (and cannot use the
stop_machine_run() thing) then we might still have problems.  A valid
optimisation (which we use in some places) is:

	local_irq_save(flags);
	<stuff>
	write_lock(lock);


