Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVF0HZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVF0HZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVF0HZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:25:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261869AbVF0HZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:25:09 -0400
Date: Mon, 27 Jun 2005 00:24:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-mm2
Message-Id: <20050627002429.40231fdf.akpm@osdl.org>
In-Reply-To: <42BFA05B.1090208@reub.net>
References: <fa.h6rvsi4.j68fhk@ifi.uio.no>
	<42BFA05B.1090208@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> ...
> 
> Some bad stuff seems to be happening here (this is new to -mm2; -mm1 did not 
> have this problem).
> 
> It's 100% reproduceable, although seems to happen at slightly different places 
> in the bootup, especially at the end.  Did I miss a patch for this?
> 

Why do you keep breaking my kernel?

> ...
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>   [<c0103ad0>] dump_stack+0x17/0x19
>   [<c01cab4b>] spin_bug+0x5b/0x67
>   [<c01cac9c>] _raw_spin_lock+0x78/0x7a
>   [<c0314ad9>] _spin_lock+0x8/0xa
>   [<c0313370>] schedule+0x6c0/0xd68
>   [<c0100d31>] cpu_idle+0x64/0x66
>   [<c01002c5>] rest_init+0x25/0x27
>   [<c03fe8af>] start_kernel+0x154/0x167
>   [<c010020f>] 0xc010020f
> Kernel panic - not syncing: bad locking

That's odd - we lost a printk there:

	printk("BUG: spinlock %s on CPU#%d, %s/%d, %p\n", msg,
		smp_processor_id(), current->comm, current->pid, lock);

which is a shame, because it would have told us stuff.  Do you have any
traces which do have that message?

Anyway, scary trace.  It look like some spinlock is thought to be in the
wrong state in schedule().  Send the .config, please.
