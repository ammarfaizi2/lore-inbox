Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbWFAKxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWFAKxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 06:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWFAKxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 06:53:06 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45546 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965022AbWFAKxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 06:53:05 -0400
Date: Thu, 1 Jun 2006 12:53:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060601105300.GA2985@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601103315.GA1865@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
> > >A .config would be useful too.
> > 
> > Now up at 
> > http://www.reub.net/files/kernel/configs/2.6.17-rc5-mm2-x86_64.confg
> 
> hm, i cannot reproduce the stack backtrace secondary crash with your 
> config. Weird.

ah, managed to reproduce it!

Jan, the dwarf2 unwinder apparently fails if we call a NULL function. 
The patch below will provoke it artificially on any box (as long as you 
have an IDE system). I've attached the incorrect backtrace attempt 
below, and the expected backtrace further below.

the relevant config options are:

CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y
CONFIG_STACK_UNWIND=y

	Ingo

Index: linux/drivers/ide/ide-io.c
===================================================================
--- linux.orig/drivers/ide/ide-io.c
+++ linux/drivers/ide/ide-io.c
@@ -1546,6 +1546,10 @@ irqreturn_t ide_intr (int irq, void *dev
 	ide_handler_t *handler;
 	ide_startstop_t startstop;
 
+	handler = NULL;
+	drive = NULL;
+	handler(drive);
+
 	spin_lock_irqsave(&ide_lock, flags);
 	hwif = hwgroup->hwif;
 
---{ BAD dump }---->

Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
 [<0000000000000000>]
PGD 0 
Oops: 0010 [1] SMP 
last sysfs file: 
CPU 1 
Modules linked in:
Pid: 1, comm: idle Not tainted 2.6.17-rc5-mm2-lockdep #15
RIP: 0010:[<0000000000000000>]  [<0000000000000000>]
RSP: 0000:ffff81003ff9fcf0  EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000206 RCX: ffff81003fd20000
RDX: ffffffff809021e0 RSI: ffff81003fd02b30 RDI: 0000000000000000
RBP: ffff81003ff9fd28 R08: 0000000000000001 R09: ffff81003fd20ad8
R10: 0000000000000000 R11: 0000000000000001 R12: 00000000fffffff4
R13: ffff81003fd02b30 R14: 000000000000000e R15: 000000000000000e
FS:  0000000000000000(0000) GS:ffff81003ffea400(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process idle (pid: 1, threadinfo ffff81003ff9e000, task ffff81003ff9ce20)
Stack:  ffffffff8020debd ffff81003ff9fd38 0000000000000206 00000000fffffff4
 ffff81003fd02b30 0000000000000001 000000000000000e ffff81003ff9fd78
 ffffffff802b4361 ffffffff80927120
Call Trace:


Code:  Bad RIP value.
RIP  [<0000000000000000>]
 RSP <ffff81003ff9fcf0>
CR2: 0000000000000000
 <0>Kernel panic - not syncing: Attempted to kill init!

Call Trace:
 [<ffffffff8026ff17>] show_trace+0xa7/0x220
 [<ffffffff802702ad>] dump_stack+0x15/0x17
 [<ffffffff8028be3f>] panic+0x9e/0x21f
 [<ffffffff802166a7>] do_exit+0xa5/0x95e
 [<ffffffff8020b0b0>] do_page_fault+0x8b0/0x9df
 [<ffffffff802662a5>] error_exit+0x0/0x8e
 
---{ expected dump }---->

Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
 [<ffffffff8020deb7>] ide_intr+0x17/0x208
PGD 0 
Oops: 0002 [1] SMP 
last sysfs file: 
CPU 1 
Modules linked in:
Pid: 1, comm: idle Not tainted 2.6.17-rc5-mm2-lockdep #14
RIP: 0010:[<ffffffff8020deb7>]  [<ffffffff8020deb7>] ide_intr+0x17/0x208
RSP: 0000:ffff81003ff9fcf8  EFLAGS: 00010092
RAX: 0000000000088212 RBX: 0000000000000206 RCX: ffff81003fd20000
RDX: ffffffff809021e0 RSI: ffff81003fd02b30 RDI: 000000000000000e
RBP: ffff81003ff9fd28 R08: 0000000000000001 R09: ffff81003fd20ad8
R10: 0000000000000000 R11: 0000000000000001 R12: 00000000fffffff4
R13: ffff81003fd02b30 R14: 000000000000000e R15: 000000000000000e
FS:  0000000000000000(0000) GS:ffff81003ffea400(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000000201000 CR4: 00000000000006e0
Process idle (pid: 1, threadinfo ffff81003ff9e000, task ffff81003ff9ce20)
Stack:  ffff81003ff9fd38 0000000000000206 00000000fffffff4 ffff81003fd02b30
 0000000000000001 000000000000000e ffff81003ff9fd78 ffffffff802b4371
 ffffffff80927120 ffffffff8020dea0
Call Trace:
 [<ffffffff802b4371>] request_irq+0xe1/0x141
 [<ffffffff80414ee4>] init_irq+0x2a4/0x572
 [<ffffffff80415333>] hwif_init+0x163/0x396
 [<ffffffff804156d5>] probe_hwif_init_with_fixup+0x25/0x83
 [<ffffffff80417853>] ide_setup_pci_device+0x54/0x96
 [<ffffffff8040baea>] amd74xx_probe+0x6a/0x71
 [<ffffffff8097ea7f>] ide_scan_pcidev+0x3f/0x6b
 [<ffffffff8097ead5>] ide_scan_pcibus+0x2a/0xdb
 [<ffffffff8097ea20>] ide_init+0x58/0x78
 [<ffffffff8026ee84>] init+0x164/0x2e3
 [<ffffffff8026647a>] child_rip+0x8/0x12


