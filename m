Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWILOnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWILOnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWILOnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 10:43:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23196 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965151AbWILOnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 10:43:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Brandon Philips <brandon@ifup.org>,
       linux-kernel@vger.kernel.org, Brice Goglin <brice@myri.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Robert Love <rml@novell.com>
Subject: Re: [patch] genirq/MSI: restore __do_IRQ() compat logic temporarily
References: <20060908174437.GA5926@plankton.ifup.org>
	<20060908121319.11a5dbb0.akpm@osdl.org>
	<20060908194300.GA5901@plankton.ifup.org>
	<20060908125053.c31b76e9.akpm@osdl.org>
	<20060911021400.GA6163@plankton.ifup.org>
	<20060911095106.2a7d6d95.akpm@osdl.org>
	<m1lkop7gi5.fsf@ebiederm.dsl.xmission.com>
	<20060912075047.GA10641@elte.hu>
Date: Tue, 12 Sep 2006 08:37:42 -0600
In-Reply-To: <20060912075047.GA10641@elte.hu> (Ingo Molnar's message of "Tue,
	12 Sep 2006 09:50:47 +0200")
Message-ID: <m14pvd6thl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> Ok.  Looking at it I almost certain the problem is that
>> we lost the hunk of code removed in: 266f0566761cf88906d634727b3d9fc2556f5cbd
>> i386: Fix stack switching in do_IRQ
>> 
>> -       if (!irq_desc[irq].handle_irq) {
>> -               __do_IRQ(irq, regs);
>> -               goto out_exit;
>> -       }
>> 
>> The msi code does not yet set desc->handle_irq.  So when we attempt to 
>> call it we get a NULL pointer dereference.
>
> indeed ... We thought the MSI cleanup went all the way with the irqchips 
> conversion, that's we suggested to Andrew to drop this chunk in -mm too.

Sorry.  At the time I was trying for a minimal fix to much more
fundamental brain damage.

>> Except for adding that hunk back in and breaking 4K stacks I don't 
>> have an immediate fix.
>
> i've attached a bandaid patch for -mm below. Brandon, does this solve 
> the crash you are seeing?
>
>> I do have a pending cleanup that should result in us setting 
>> handle_irq in all cases.  I will see if I can advance that shortly.
>
> yeah, that's the right solution.

The core problem at the moment is that the generic code in msi.c
still knows about apics.  So struct irq_chip needs to be pushed
to the individual architectures.  At which point it becomes easy to
ensure we have a proper handle_irq value as we aren't trying to be
impossibly generic.

Eric
