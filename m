Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbULCE5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbULCE5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 23:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbULCE5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 23:57:35 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:13966 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261981AbULCE52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 23:57:28 -0500
Date: Thu, 2 Dec 2004 21:56:24 -0700 (MST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
To: Pedro Larroy <piotr@larroy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][BUG] Badness in smp_call_function at arch/i386/kernel/smp.c:552
In-Reply-To: <20041202210340.GA19140@larroy.com>
Message-ID: <Pine.LNX.4.61.0412022152480.21568@montezuma.fsmlabs.com>
References: <20041202210340.GA19140@larroy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004, Pedro Larroy wrote:

> This happens when triggering sysrq-B to reboot box:
> 
> SysRq : Emergency Sync
> Emergency Sync complete
> SysRq : Resetting
> Badness in smp_call_function at arch/i386/kernel/smp.c:552
>  [<c011192e>] smp_call_function+0xfe/0x110
>  [<c011ccf4>] call_console_drivers+0x74/0x100
>  [<c011d0cf>] release_console_sem+0x7f/0xc0
>  [<c011198b>] smp_send_stop+0x1b/0x30
>  [<c0111204>] machine_shutdown+0x34/0x60
>  [<c011ce97>] printk+0x17/0x20
>  [<c021a1fc>] __handle_sysrq+0x7c/0x110

ChangeSet 1.2026.75.111 2004/11/07 20:06:32 jbaron@redhat.com
  [PATCH] fix alt-sysrq deadlock

__handle_sysrq was modified to do a spin_lock_irqsave so we were 
entering smp_send_stop with interrupts. So enable interrupts in 
machine_shutdown().

Signed-off-by: Zwane Mwaikambo <zwane@holomorphy.com>

Index: linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 reboot.c
--- linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c	30 Nov 2004 18:52:19 -0000	1.1.1.1
+++ linux-2.6.10-rc2-mm4/arch/i386/kernel/reboot.c	3 Dec 2004 04:28:28 -0000
@@ -274,6 +274,8 @@ void machine_shutdown(void)
 #ifdef CONFIG_SMP
 	int reboot_cpu_id;
 
+	local_irq_enable();
+
 	/* The boot cpu is always logical cpu 0 */
 	reboot_cpu_id = 0;
 
