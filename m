Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161824AbWKVC2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161824AbWKVC2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161811AbWKVC2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:28:43 -0500
Received: from iabervon.org ([66.92.72.58]:59404 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1161825AbWKVC2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:28:42 -0500
Date: Tue, 21 Nov 2006 21:28:41 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: linux-kernel@vger.kernel.org
cc: Jeff Garzik <jeff@garzik.org>, David Miller <davem@davemloft.net>,
       Roland Dreier <rdreier@cisco.com>, Linus Torvalds <torvalds@osdl.org>,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: [PATCH] Disable INTx when enabling MSI in forcedeth
Message-ID: <Pine.LNX.4.64.0611212118540.20138@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My nVidia ethernet card doesn't disable its own INTx when MSI is
enabled. This causes a steady stream of spurious interrupts that
eventually kills my SATA IRQ if MSI is used with forcedeth, which is
true by default. Simply disabling the INTx interrupt takes care of it.

This is against -stable, and would be suitable once someone who knows the 
code verifies that it's correct.

Works for me, but I've obviously only tested the codepath where using
MSI succeeds.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

(cc:s to people who were talking about the existance of devices 
that misbehave like this)

The device in question is:
00:07.0 Bridge: nVidia Corporation MCP61 Ethernet (rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 8234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 209
        Region 0: Memory at dff7d000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at e480 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: 00000000fee00000  Data: 4032
        Capabilities: [6c] HyperTransport: MSI Mapping

 drivers/net/forcedeth.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
index 11b8f1b..97087d2 100644
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -2691,12 +2691,14 @@ static int nv_request_irq(struct net_dev
 		}
 	}
 	if (ret != 0 && np->msi_flags & NV_MSI_CAPABLE) {
+		pci_intx(np->pci_dev, 0);
 		if ((ret = pci_enable_msi(np->pci_dev)) == 0) {
 			np->msi_flags |= NV_MSI_ENABLED;
 			if ((!intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq, IRQF_SHARED, dev->name, dev) != 0) ||
 			    (intr_test && request_irq(np->pci_dev->irq, &nv_nic_irq_test, IRQF_SHARED, dev->name, dev) != 0)) {
 				printk(KERN_INFO "forcedeth: request_irq failed %d\n", ret);
 				pci_disable_msi(np->pci_dev);
+				pci_intx(np->pci_dev, 1);
 				np->msi_flags &= ~NV_MSI_ENABLED;
 				goto out_err;
 			}
@@ -2706,6 +2708,8 @@ static int nv_request_irq(struct net_dev
 			writel(0, base + NvRegMSIMap1);
 			/* enable msi vector 0 */
 			writel(NVREG_MSI_VECTOR_0_ENABLED, base + NvRegMSIIrqMask);
+		} else {
+			pci_intx(np->pci_dev, 1);
 		}
 	}
 	if (ret != 0) {
-- 
1.4.2.4

