Return-Path: <linux-kernel-owner+w=401wt.eu-S965030AbWLOBgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWLOBgo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWLOBgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:36:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46249 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965000AbWLOBgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:36:38 -0500
Message-Id: <20061215013858.907556000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:34:00 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Barkalow <barkalow@iabervon.org>,
       gregkh@suse.de, jeff@garzik.org
Subject: [patch 23/24] forcedeth: Disable INTx when enabling MSI in forcedeth
Content-Disposition: inline; filename=forcedeth-disable-intx-when-enabling-msi-in-forcedeth.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Daniel Barkalow <barkalow@iabervon.org>

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
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

The general patch got into mainline last night, and this patch is clearly 
the same as that one, limited to the case of forcedeth (the pci_intx() 
calls are lifted from {enable,disable}_msi_mode to all of the indirect 
callers in forcedeth).

 drivers/net/forcedeth.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.18.5.orig/drivers/net/forcedeth.c
+++ linux-2.6.18.5/drivers/net/forcedeth.c
@@ -2692,11 +2692,13 @@ static int nv_request_irq(struct net_dev
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
@@ -2739,6 +2741,7 @@ static void nv_free_irq(struct net_devic
 		free_irq(np->pci_dev->irq, dev);
 		if (np->msi_flags & NV_MSI_ENABLED) {
 			pci_disable_msi(np->pci_dev);
+			pci_intx(np->pci_dev, 1);
 			np->msi_flags &= ~NV_MSI_ENABLED;
 		}
 	}

--
