Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWJLT5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWJLT5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWJLT5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:57:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750724AbWJLT5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:57:19 -0400
Date: Thu, 12 Oct 2006 12:57:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank Sorenson <frank@tuxrocks.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in 2.6.19-rc1
Message-Id: <20061012125714.a44c3a1d.akpm@osdl.org>
In-Reply-To: <452E93D7.6020004@tuxrocks.com>
References: <452D43B6.8020406@tuxrocks.com>
	<20061012000643.f875c96e.akpm@osdl.org>
	<452E93D7.6020004@tuxrocks.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 14:13:27 -0500
Frank Sorenson <frank@tuxrocks.com> wrote:

> Andrew Morton wrote:
> > On Wed, 11 Oct 2006 14:19:18 -0500
> > Frank Sorenson <frank@tuxrocks.com> wrote:
> > 
> >> I'm getting kernel panics within a few minutes of boot with 2.6.19-rc1 
> >> (latest git) on x86_64.  Other than "make oldconfig", it's an identical 
> >> configuration to a working kernel on 2.6.18.
> >>
> >> The panic scrolls off the screen, but I copied down what was on the screen:
> > 
> > Can you get netconsole going?  Documentation/networking/netconsole.txt.
> > It's pretty simple.
> 
> Three netconsole dumps attached.  I hope they provide more information. 
>   Let me know if there's anything more I can provide.
> 

hmm.


> [   20.889846] warning: process `date' used the removed sysctl system call
> [  143.574063] do_IRQ: 0.65 No irq handler for vector

This might be the cause.  Please try the appended fix.

> [  160.311799] NMI Watchdog detected LOCKUP on CPU 1
> [  160.312107] CPU 1 
> [  160.312250] Modules linked in: sunrpc asus_acpi lp parport_pc parport nvram uhci_hcd joydev i2c_i801 ohci1394 ieee1394 ehci_hcd i2c_core
> [  160.313252] Pid: 0, comm: swapper Not tainted 2.6.19-rc1-fs2 #4
> [  160.313635] RIP: 0010:[<ffffffff81183dbc>]  [<ffffffff81183dbc>] acpi_processor_idle+0x259/0x48d
> [  160.314224] RSP: 0018:ffff810037e1be78  EFLAGS: 00000097
> [  160.314566] RAX: 00000000009bd686 RBX: 0000000000000001 RCX: 0000000000001008
> [  160.315026] RDX: 0000000000001016 RSI: 0000000000000013 RDI: 0000000000000000
> [  160.315485] RBP: ffff810037e1bec8 R08: ffff81007db44900 R09: 000000007db44960
> [  160.315945] R10: 00007fff89ad2cd0 R11: 0000000000000246 R12: ffff81007db44960
> [  160.316403] R13: 00000000009bd686 R14: ffff81007db44800 R15: 0000000000000008
> [  160.316864] FS:  0000000000000000(0000) GS:ffff81007debecc0(0000) knlGS:0000000000000000
> [  160.317383] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> [  160.317755] CR2: 00002b6954757000 CR3: 0000000067fb5000 CR4: 00000000000006e0
> [  160.318214] Process swapper (pid: 0, threadinfo ffff810037e1a000, task ffff810037e02100)
> [  160.318733] Stack:  0000000000000000 0000000000000001 ffff810037e1beb8 ffffffff8131d205
> [  160.319324]  00000000810088ad ffffffff81183b63 0000000000000001 0000000000000100
> [  160.319859]  ffffffff8148e300 0000000000000008 ffff810037e1bee8 ffffffff81008caa
> [  160.320379] Call Trace:
> [  160.320559]  [<ffffffff8131d205>] atomic_notifier_call_chain+0x3e/0x60
> [  160.320984]  [<ffffffff81183b63>] acpi_processor_idle+0x0/0x48d
> [  160.321367]  [<ffffffff81008caa>] cpu_idle+0x8f/0xc6
> [  160.321693]  [<ffffffff81018274>] start_secondary+0x44a/0x45a

That's a strange way for it to have manifested.


commit 994bd4f9f5a065ead4a92435fdd928ac7fd33809
tree 11e5b123bd5c5319a65ad4732ad3965b815dedbb
parent c25d5180441e344a3368d100c57f0a481c6944f7
author Eric W. Biederman <ebiederm@xmission.com> 1160628286 -0600
committer Linus Torvalds <torvalds@g5.osdl.org> 1160663850 -0700

[PATCH] x86_64 irq: Properly update vector_irq

This patch fixes my one line thinko where I was clearing
the vector_irq entries on the wrong cpus.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

 arch/x86_64/kernel/io_apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index c3cdcab..44b55f8 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -660,7 +660,7 @@ next:
 		}
 		if (old_vector >= 0) {
 			int old_cpu;
-			for_each_cpu_mask(old_cpu, domain)
+			for_each_cpu_mask(old_cpu, irq_domain[irq])
 				per_cpu(vector_irq, old_cpu)[old_vector] = -1;
 		}
 		for_each_cpu_mask(new_cpu, domain)

