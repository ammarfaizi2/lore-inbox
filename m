Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWILGV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWILGV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 02:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWILGV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 02:21:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32738 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751320AbWILGV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 02:21:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Brandon Philips <brandon@ifup.org>, linux-kernel@vger.kernel.org,
       Brice Goglin <brice@myri.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Robert Love <rml@novell.com>
Subject: Re: 2.6.18-rc6-mm1 2.6.18-rc5-mm1 Kernel Panic on X60s
References: <20060908174437.GA5926@plankton.ifup.org>
	<20060908121319.11a5dbb0.akpm@osdl.org>
	<20060908194300.GA5901@plankton.ifup.org>
	<20060908125053.c31b76e9.akpm@osdl.org>
	<20060911021400.GA6163@plankton.ifup.org>
	<20060911095106.2a7d6d95.akpm@osdl.org>
Date: Tue, 12 Sep 2006 00:20:34 -0600
In-Reply-To: <20060911095106.2a7d6d95.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 11 Sep 2006 09:51:06 -0700")
Message-ID: <m1lkop7gi5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> OK, thanks.
>
> I don't think this necessarily tells us where the bug lies.  It could be
> some pre-existing thing in MSI, or it could be added by Bryce's changes. 
> Or by Eric's.  Or, of course, by
> genirq-convert-the-i386-architecture-to-irq-chips.patch.
>
> There doesn't seem to be a lot of movement on this and we want to get the
> x86 genirq conversion into 2.6.19.  Could be that we end up having to merge
> known-buggy stuff into mainline and crash enough computers to irritate
> someone into fixing it.  Rather sad.


Ok.  Looking at it I almost certain the problem is that
we lost the hunk of code removed in: 266f0566761cf88906d634727b3d9fc2556f5cbd
i386: Fix stack switching in do_IRQ

-       if (!irq_desc[irq].handle_irq) {
-               __do_IRQ(irq, regs);
-               goto out_exit;
-       }

The msi code does not yet set desc->handle_irq.  So when we attempt
to call it we get a NULL pointer dereference.

Except for adding that hunk back in and breaking 4K stacks I don't
have an immediate fix.

I do have a pending cleanup that should result in us setting handle_irq
in all cases.  I will see if I can advance that shortly.

Eric
