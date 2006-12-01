Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936548AbWLAUaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936548AbWLAUaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936549AbWLAUaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:30:08 -0500
Received: from iabervon.org ([66.92.72.58]:33544 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S936548AbWLAUaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:30:07 -0500
Date: Fri, 1 Dec 2006 15:30:06 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] Disable INTx when enabling MSI in forcedeth
In-Reply-To: <20061201015000.GX1397@sequoia.sous-sol.org>
Message-ID: <Pine.LNX.4.64.0612011507130.20138@iabervon.org>
References: <Pine.LNX.4.64.0611301533010.20138@iabervon.org>
 <20061201003057.GV1397@sequoia.sous-sol.org> <Pine.LNX.4.64.0611301928420.20138@iabervon.org>
 <20061201011010.GW1397@sequoia.sous-sol.org> <Pine.LNX.4.64.0611302020150.20138@iabervon.org>
 <20061201015000.GX1397@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 27fc7625159acb1fd77d4a36a326be521ee79b19 Mon Sep 17 00:00:00 2001
From: Daniel Barkalow <barkalow@gaussian.borglab.com>
Date: Fri, 1 Dec 2006 14:56:58 -0500
Subject: [PATCH] Disable INTx when enabling MSI in forcedeth

At least some nforce cards continue to send legacy interrupts when MSI
is enabled, and these interrupts are treated as unhandled by the
kernel. This patch disables legacy interrupts explicitly when enabling
MSI mode.

The correct fix is to change the MSI infrastructure to disable legacy
interrupts when enabling MSI, but this is potentially risky if the
device isn't PCI-2.3 or is quirky, so the correct fix is going into
mainline, while patches like this one go into -stable.

Legend has it that it is most correct to disable legacy interrupts
before enabling MSI, but the mainline patch does it in the other
order, and this patch is "obviously" the same as mainline.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

Is there anyone else who should review this early? It should probably 
still wait on the patch from http://lkml.org/lkml/2006/11/21/332 actually 
getting into the mainline, and I don't know the status on that.

 drivers/net/forcedeth.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index c5ed635..72325fa 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -2815,11 +2815,13 @@ static int nv_request_irq(struct net_dev
 	}
 	if (ret != 0 && np->msi_flags & NV_MSI_CAPABLE) {
 		if ((ret = pci_enable_msi(np->pci_dev)) == 0) {
+			pci_intx(np->pci_dev, 0);
 			np->msi_flags |= NV_MSI_ENABLED;
 			if ((!intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq, IRQF_SHARED, dev->name, dev) != 0) ||
 			    (intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq_test, IRQF_SHARED, dev->name, dev) != 0)) {
 				printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
 				pci_disable_msi(np->pci_dev);
+				pci_intx(np->pci_dev, 1);
 				np->msi_flags &= ~NV_MSI_ENABLED;
 				goto out_err;
 			}
@@ -2862,6 +2864,7 @@ static void nv_free_irq(struct net_devic
 		free_irq(np->pci_dev->irq, dev);
 		if (np->msi_flags & NV_MSI_ENABLED) {
 			pci_disable_msi(np->pci_dev);
+			pci_intx(np->pci_dev, 1);
 			np->msi_flags &= ~NV_MSI_ENABLED;
 		}
 	}
-- 
1.4.2.4

