Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270097AbTHBS7W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270203AbTHBS7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:59:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:18846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270097AbTHBS7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:59:21 -0400
Date: Sat, 2 Aug 2003 12:00:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
Message-Id: <20030802120023.7390f68f.akpm@osdl.org>
In-Reply-To: <20030802143222.GG22824@waste.org>
References: <20030802042445.GD22824@waste.org>
	<20030802040015.0fcafda2.akpm@osdl.org>
	<20030802143222.GG22824@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> > Are you really sure that all the decisions about where to use spin_lock()
>  > vs spin_lock_irq() vs spin_lock_irqsave() are correct?  They are
>  > non-obvious.
> 
>  Aside from the put_user stuff below, yes.

Well I see in Linus's current tree:

	ndev->regen_timer.function = ipv6_regen_rndid;

And ipv6_regen_rndid() ends up calling get_random_bytes() which calls
extract_entropy() which now does a bare spin_lock().

So I think if the timer is run while some process-context code on the same
CPU is running get_random_bytes() we deadlock don't we?

Probably, we should make get_random_bytes() callable from any context.

