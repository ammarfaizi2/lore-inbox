Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751780AbWCIJmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbWCIJmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWCIJmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:42:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22166 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751780AbWCIJmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:42:23 -0500
Date: Thu, 9 Mar 2006 01:40:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Max Asbock <masbock@us.ibm.com>,
       Vernon Mauery <vernux@us.ibm.com>
Subject: Re: Oops on ibmasm
Message-Id: <20060309014023.2caa42d2.akpm@osdl.org>
In-Reply-To: <20060308224145.47332.qmail@web52607.mail.yahoo.com>
References: <20060308224145.47332.qmail@web52607.mail.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au> wrote:
>
> When ibmasm kernel module is loaded on a slab debug
> enabled kernel, it oopses. Yes, it's fine when there's
> no slab debug.
>
> ...
> 
> md: ... autorun DONE.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 17 (level,
> low) -> IRQ 18
> command count: 1
> input: ibmasm RSA I remote mouse as
> /class/input/input2
> input: ibmasm RSA I remote keyboard as
> /class/input/input3
> ibmasm remote responding to events on RSA card 0
> command count: 2
> ibmasm_exec_command:130 at 1141819512.780778
> do_exec_command:107 at 1141819512.780787
> respond to interrupt at 1141819512.782055
> exec_next_command:150 at 1141819512.782094
> finished interrupt at   1141819512.782103
> command count: 1
> Unable to handle kernel paging request at virtual
> address 6b6b6b6b
>  printing eip:
> c0261af6
> *pde = 00000000
> Oops: 0002 [#1]
> SMP 
> Modules linked in: ibmasm dm_snapshot dm_zero
> dm_mirror dm_mod raid0 ext3 mbcache jbd ide_disk
> ide_core ips aic7xxx scsi_transport_spi sd_mod
> scsi_mod
> CPU:    1
> EIP:    0060:[<c0261af6>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.16-rc5 #4) 
> EIP is at _spin_unlock_irqrestore+0x2/0x7
> eax: 6b6b6b6b   ebx: 00000246   ecx: 00000001   edx:
> 00000246
> esi: 00000000   edi: f7c56bdb   ebp: f7cc2ad0   esp:
> f746cda8
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 429, threadinfo=f746c000
> task=f7f82570)
> Stack: <0>f88dee8c c339f0b0 00000000 c339f0b0 00000000
> c339f0e8 f7c14ee0 f88dd3aa 
>        00000001 f88e24ec f88e24c0 f7c14ee0 c01f4439
> c01b9410 f7c14f28 f7c14f28 
>        f88e24ec c01f4389 f7c14f28 c316092c f88e24ec
> c01f4491 00000000 c02af580 
> Call Trace:
>  [<f88dee8c>] ibmasm_send_driver_vpd+0xb7/0xc3
> [ibmasm]
>  [<f88dd3aa>] ibmasm_init_one+0x2a6/0x37c [ibmasm]
>  [<c01f4439>] __driver_attach+0x0/0x7f
>  [<c01b9410>] pci_device_probe+0x36/0x57
>  [<c01f4389>] driver_probe_device+0x42/0x8b
>  [<c01f4491>] __driver_attach+0x58/0x7f
>  [<c01f3ead>] bus_for_each_dev+0x37/0x59
>  [<c01f42f3>] driver_attach+0x11/0x13

I assume this'll fix it?

I suspect there's no point in the locking around that kobject_put() anyway.
Or if there is, it wasn't the right way to fix the race.

diff -puN drivers/misc/ibmasm/ibmasm.h~ibmasm-use-after-free-fix drivers/misc/ibmasm/ibmasm.h
--- devel/drivers/misc/ibmasm/ibmasm.h~ibmasm-use-after-free-fix	2006-03-09 01:35:05.000000000 -0800
+++ devel-akpm/drivers/misc/ibmasm/ibmasm.h	2006-03-09 01:35:16.000000000 -0800
@@ -100,11 +100,7 @@ struct command {
 
 static inline void command_put(struct command *cmd)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(cmd->lock, flags);
         kobject_put(&cmd->kobj);
-	spin_unlock_irqrestore(cmd->lock, flags);
 }
 
 static inline void command_get(struct command *cmd)
_


