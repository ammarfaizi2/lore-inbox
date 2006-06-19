Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWFSVif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWFSVif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWFSVif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:38:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964851AbWFSVie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:38:34 -0400
Date: Mon, 19 Jun 2006 14:41:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: The i386 and x86_64 genirq patches are wrong!
Message-Id: <20060619144150.51fe627c.akpm@osdl.org>
In-Reply-To: <m1y7vzzlrk.fsf@ebiederm.dsl.xmission.com>
References: <m1r71t2ew8.fsf@ebiederm.dsl.xmission.com>
	<20060614070353.GA11896@elte.hu>
	<m1y7vzzlrk.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > here too it's hard for me to give an answer without seeing your specific 
> > changes (against whatever base is most convenient to you). MSI certainly 
> > works fine on current -mm. (at least on my box)
> 
> Ok.  Looking closer.  I have found a clear functional bug.
> 
> When CONFIG_PCI_MSI is not set.
>   move_irq expands to move_native_irq.
> 
>   ack_ioapic_vector
>     move_native_irq
>     ack_ioapic_irq
>       move_irq
>         move_native_irq
> 
>   ack_ioapic_quirk_vector
>     move_native_irq
>     ack_ioapic_quirk_irq
>       move_irq
>         move_native_irq
> 
> So we wind up calling move_native_irq twice when MSI is disabled where
> before your conversion we only ever called it once.  Luckily in
> the case where we have the double call vector_to_irq is a noop so
> we only migration the same irq twice.
> 

OK, but this doesn't seem to answer Ingo's request "could you please send
that fix to me, against whatever base you have it tested on, and i'll merge
it to genirq/irqchips [and fix up genirq if needed].  Please also include a
description of the problem.  How common is that edge retrigger problem, and
how come this has never been seen in the past years since we had
irqbalance?"

The genirq patches are stuck in limboland until issues like this are
resolved.  I'm not planning on sending them to Linus for 2.6.18 so there's
no huge rush on it, but it would be nice to get all these loose ends tied
off reasonably promptly, please.

