Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWEASee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWEASee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWEASee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:34:34 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19077 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751081AbWEASed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:34:33 -0400
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: 2.6.17-rc2-mm1
Date: Mon, 1 May 2006 20:34:26 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <4450F5AD.9030200@google.com> <20060428012022.7b73c77b.akpm@osdl.org> <44561A1E.7000103@google.com>
In-Reply-To: <44561A1E.7000103@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605012034.26763.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 May 2006 16:24, Martin J. Bligh wrote:

> double fault: 0000 [1] SMP
> last sysfs file: /devices/pci0000:00/0000:00:06.0/resource
> CPU 0
> Modules linked in:
> Pid: 20519, comm: mtest01 Not tainted 2.6.17-rc3-mm1-autokern1 #1
> RIP: 0010:[<ffffffff8047c8b8>] <ffffffff8047c8b8>{__sched_text_start+1856}
> RSP: 0000:0000000000000000  EFLAGS: 00010082
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff805d9438
> RDX: ffff8100db12c0d0 RSI: ffffffff805d9438 RDI: ffff8100db12c0d0
> RBP: ffffffff805d9438 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8100e39bd440 R14: ffff810008003620 R15: 000002b02751726c
> FS:  0000000000000000(0000) GS:ffffffff805fa000(0063) knlGS:00000000f7dd0460
> CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> CR2: fffffffffffffff8 CR3: 00000000da399000 CR4: 00000000000006e0
> Process mtest01 (pid: 20519, threadinfo ffff8100b1bb4000, task 
> ffff8100db12c0d0)
> Stack: ffffffff80579e20 ffff8100db12c0d0 0000000000000001 ffffffff80579f58
>         0000000000000000 ffffffff80579e78 ffffffff8020b0b2 ffffffff80579f58
>         0000000000000000 ffffffff80485520
> Call Trace: <#DF> <ffffffff8020b0b2>{show_registers+140}
>         <ffffffff8020b357>{__die+159} <ffffffff8020b3cc>{die+50}
>         <ffffffff8020bba6>{do_double_fault+115} 
> <ffffffff8020aa91>{double_fault+125}
>         <ffffffff8047c8b8>{__sched_text_start+1856} <EOE>

That's really strange - i wonder why the backtracer can't find the original
stack. Should probably add some printk diagnosis here.

Can you send the output with this patch?

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -238,6 +238,7 @@ void show_trace(unsigned long *stack)
 			HANDLE_STACK (stack < estack_end);
 			i += printk(" <EOE>");
 			stack = (unsigned long *) estack_end[-2];
+			printk("new stack %lx (%lx %lx %lx %lx %lx)\n", stack, estack_end[0], estack_end[-1], estack_end[-2], estack_end[-3], estack_end[-4]);
 			continue;
 		}
 		if (irqstack_end) {
