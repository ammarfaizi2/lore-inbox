Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbULCHor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbULCHor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 02:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbULCHoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 02:44:46 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:8849 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262080AbULCHno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 02:43:44 -0500
Date: Fri, 3 Dec 2004 00:43:07 -0700 (MST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
cc: piotr@larroy.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][BUG] Badness in smp_call_function at arch/i386/kernel/smp.c:552
In-Reply-To: <20041202233611.256fcf3f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412030040071.21568@montezuma.fsmlabs.com>
References: <20041202210340.GA19140@larroy.com>
 <Pine.LNX.4.61.0412022152480.21568@montezuma.fsmlabs.com>
 <20041202230106.14bb42f5.akpm@osdl.org> <Pine.LNX.4.61.0412030005070.21568@montezuma.fsmlabs.com>
 <20041202233611.256fcf3f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004, Andrew Morton wrote:

> >  > However enabling interrupts as you've done menas that theoretically we
> >  > could deadlock on sysrq_key_table_lock if another sysrq happens at the
> >  > wrong time.
> >  > 
> >  > Which deadlock opportunity would you prefer? ;)
> > 
> >  Agreed, there is actually a higher chance of the smp_call_function 
> >  deadlock occuring since the __handle_sysrq one relies on another sysrq 
> >  event occuring via a different IRQ line interrupt handler, so 
> >  we would have to do sysrq via serial and then sysrq via keyboard to cause 
> >  the deadlock. Perhaps just make it a spin_trylock?
> 
> Well yeah, but it's so much fuss for such a silly problem.
> 
> How about a local_irq_enable() in sysrq_handle_reboot()?

That should be fine too, i prefer it to local_irq_enable in 
machine_shutdown() too.

Signed-off-by: Zwane Mwaikambo <zwane@holomorphy.com>

===== drivers/char/sysrq.c 1.32 vs edited =====
--- 1.32/drivers/char/sysrq.c	2004-11-07 19:13:54 -07:00
+++ edited/drivers/char/sysrq.c	2004-12-03 00:42:29 -07:00
@@ -98,6 +98,7 @@ static struct sysrq_key_op sysrq_unraw_o
 static void sysrq_handle_reboot(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty) 
 {
+	local_irq_enable();
 	machine_restart(NULL);
 }
 
