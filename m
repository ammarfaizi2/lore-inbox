Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbULCHgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbULCHgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 02:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbULCHgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 02:36:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:25220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262073AbULCHgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 02:36:40 -0500
Date: Thu, 2 Dec 2004 23:36:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: piotr@larroy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][BUG] Badness in smp_call_function at
 arch/i386/kernel/smp.c:552
Message-Id: <20041202233611.256fcf3f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412030005070.21568@montezuma.fsmlabs.com>
References: <20041202210340.GA19140@larroy.com>
	<Pine.LNX.4.61.0412022152480.21568@montezuma.fsmlabs.com>
	<20041202230106.14bb42f5.akpm@osdl.org>
	<Pine.LNX.4.61.0412030005070.21568@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@holomorphy.com> wrote:
>
> > Well, sort-of.
>  > 
>  > If __handle_sysrq was really a normal IRQ handler then the correct thing to
>  > do here is to replace spin_lock_irqsave() with spin_lock().  But
>  > __handle_sysrq() can also be called via /proc/sysrq-trigger and via the
>  > handlers of multiple interrupt sources.  So we're stuck with using
>  > spin_lock_irqsave().
>  > 
>  > However enabling interrupts as you've done menas that theoretically we
>  > could deadlock on sysrq_key_table_lock if another sysrq happens at the
>  > wrong time.
>  > 
>  > Which deadlock opportunity would you prefer? ;)
> 
>  Agreed, there is actually a higher chance of the smp_call_function 
>  deadlock occuring since the __handle_sysrq one relies on another sysrq 
>  event occuring via a different IRQ line interrupt handler, so 
>  we would have to do sysrq via serial and then sysrq via keyboard to cause 
>  the deadlock. Perhaps just make it a spin_trylock?

Well yeah, but it's so much fuss for such a silly problem.

How about a local_irq_enable() in sysrq_handle_reboot()?
