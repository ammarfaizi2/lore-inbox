Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWAZAll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWAZAll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWAZAll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:41:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:6060 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751278AbWAZAlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:41:40 -0500
Date: Thu, 26 Jan 2006 01:42:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, lock validator] fix deadlock in drivers/pci/msi.c
Message-ID: <20060126004211.GA26443@elte.hu>
References: <20060126004005.GA25940@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126004005.GA25940@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[corrected patch below.]

the lock validator caught another one: drivers/pci/msi.c is accessing 
&irq_desc[i].lock with interrupts enabled (!).

  ============================
  [ BUG: illegal lock usage! ]
  ----------------------------
  illegal {used-in-hardirq} -> {enabled-hardirqs} usage.
  swapper/1 [HC0[0]:SC0[0]:HE1:SE1] takes {&irq_desc[i].lock [u:7]}, at:
   [<c043d757>] irq_handler_init+0x1e/0x53
  {used-in-hardirq} state was registered at:
   [<c014d092>] __do_IRQ+0x4a/0x100
  hardirqs last enabled at: [<c0d296fe>] _spin_unlock_irqrestore+0x1e/0x23
  softirqs last enabled at: [<c012cfac>] irq_exit+0x36/0x38
  
  other info that might help us debug this::
  locks held by swapper/1:
   #0:  {drivers/base/core.c:&dev->mutex} [<c053f8f0>] __driver_attach+0x23/0x69
   #1:  {drivers/base/core.c:&dev->mutex} [<c053f902>] __driver_attach+0x35/0x69
   [<c0103e86>] show_trace+0xd/0xf
   [<c0103e9d>] dump_stack+0x15/0x17
   [<c013e792>] print_usage_bug+0x176/0x181
   [<c013ee6f>] mark_lock+0x9b/0x22b
   [<c013f3e1>] debug_lock_chain+0x3e2/0xac4
   [<c013faf4>] debug_lock_chain_spin+0x31/0x48
   [<c0410976>] _raw_spin_lock+0x34/0x7f
   [<c0d295f5>] _spin_lock+0x8/0xa
   [<c043d757>] irq_handler_init+0x1e/0x53
   [<c043ea7c>] pci_enable_msi+0x21d/0x311
   [<c041de4f>] pcie_port_device_register+0x20c/0x35d
   [<c041dff7>] pcie_portdrv_probe+0x57/0x6a
   [<c041bc70>] pci_device_probe+0x39/0x59
   [<c053f870>] driver_probe_device+0x68/0xc5
   [<c053f914>] __driver_attach+0x47/0x69
   [<c053ed53>] bus_for_each_dev+0x36/0x5b
   [<c053f590>] driver_attach+0x14/0x17
   [<c053f214>] bus_add_driver+0x72/0x101
   [<c053fb24>] driver_register+0x71/0x76
   [<c041b8bc>] __pci_register_driver+0x71/0x8f
   [<c143248d>] pcie_portdrv_init+0x15/0x25
   [<c0100498>] init+0x1ae/0x302
   [<c0101005>] kernel_thread_helper+0x5/0xb

the fix is to disable interrupts properly.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 drivers/pci/msi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: linux/drivers/pci/msi.c
===================================================================
--- linux.orig/drivers/pci/msi.c
+++ linux/drivers/pci/msi.c
@@ -430,7 +430,9 @@ static void attach_msi_entry(struct msi_
 
 static void irq_handler_init(int cap_id, int pos, int mask)
 {
-	spin_lock(&irq_desc[pos].lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&irq_desc[pos].lock, flags);
 	if (cap_id == PCI_CAP_ID_MSIX)
 		irq_desc[pos].handler = &msix_irq_type;
 	else {
@@ -439,7 +441,7 @@ static void irq_handler_init(int cap_id,
 		else
 			irq_desc[pos].handler = &msi_irq_w_maskbit_type;
 	}
-	spin_unlock(&irq_desc[pos].lock);
+	spin_unlock_irqrestore(&irq_desc[pos].lock, flags);
 }
 
 static void enable_msi_mode(struct pci_dev *dev, int pos, int type)
