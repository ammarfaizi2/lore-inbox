Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbULCHBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbULCHBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 02:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbULCHBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 02:01:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:8664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261589AbULCHBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 02:01:36 -0500
Date: Thu, 2 Dec 2004 23:01:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: piotr@larroy.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][BUG] Badness in smp_call_function at
 arch/i386/kernel/smp.c:552
Message-Id: <20041202230106.14bb42f5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412022152480.21568@montezuma.fsmlabs.com>
References: <20041202210340.GA19140@larroy.com>
	<Pine.LNX.4.61.0412022152480.21568@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@holomorphy.com> wrote:
>
>  __handle_sysrq was modified to do a spin_lock_irqsave so we were 
>  entering smp_send_stop with interrupts. So enable interrupts in 
>  machine_shutdown().
> 
>  Signed-off-by: Zwane Mwaikambo <zwane@holomorphy.com>
> 
>  Index: linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c
>  ===================================================================
>  RCS file: /home/cvsroot/linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c,v
>  retrieving revision 1.1.1.1
>  diff -u -p -B -r1.1.1.1 reboot.c
>  --- linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c	30 Nov 2004 18:52:19 -0000	1.1.1.1
>  +++ linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c	3 Dec 2004 04:28:28 -0000
>  @@ -274,6 +274,8 @@ void machine_shutdown(void)
>   #ifdef CONFIG_SMP
>   	int reboot_cpu_id;
>   
>  +	local_irq_enable();

Well, sort-of.

If __handle_sysrq was really a normal IRQ handler then the correct thing to
do here is to replace spin_lock_irqsave() with spin_lock().  But
__handle_sysrq() can also be called via /proc/sysrq-trigger and via the
handlers of multiple interrupt sources.  So we're stuck with using
spin_lock_irqsave().

However enabling interrupts as you've done menas that theoretically we
could deadlock on sysrq_key_table_lock if another sysrq happens at the
wrong time.

Which deadlock opportunity would you prefer? ;)
