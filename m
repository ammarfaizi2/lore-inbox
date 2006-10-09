Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWJILrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWJILrd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWJILrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:47:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:20366 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932581AbWJILrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:47:32 -0400
Date: Mon, 9 Oct 2006 12:47:31 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more ia64 irq handlers
Message-ID: <20061009114731.GN29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cast to (void *) in request_irq() argument is stupid and
only hides problems...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/sn/kernel/huberror.c          |    4 ++--
 arch/ia64/sn/pci/pcibr/pcibr_provider.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/sn/kernel/huberror.c b/arch/ia64/sn/kernel/huberror.c
index 96fb81e..abca6bd 100644
--- a/arch/ia64/sn/kernel/huberror.c
+++ b/arch/ia64/sn/kernel/huberror.c
@@ -22,7 +22,7 @@ #include <asm/sn/bte.h>
 void hubiio_crb_error_handler(struct hubdev_info *hubdev_info);
 extern void bte_crb_error_handler(cnodeid_t, int, int, ioerror_t *,
 				  int);
-static irqreturn_t hub_eint_handler(int irq, void *arg, struct pt_regs *ep)
+static irqreturn_t hub_eint_handler(int irq, void *arg)
 {
 	struct hubdev_info *hubdev_info;
 	struct ia64_sal_retval ret_stuff;
@@ -178,7 +178,7 @@ void hubiio_crb_error_handler(struct hub
  */
 void hub_error_init(struct hubdev_info *hubdev_info)
 {
-	if (request_irq(SGI_II_ERROR, (void *)hub_eint_handler, IRQF_SHARED,
+	if (request_irq(SGI_II_ERROR, hub_eint_handler, IRQF_SHARED,
 			"SN_hub_error", (void *)hubdev_info))
 		printk("hub_error_init: Failed to request_irq for 0x%p\n",
 		    hubdev_info);
diff --git a/arch/ia64/sn/pci/pcibr/pcibr_provider.c b/arch/ia64/sn/pci/pcibr/pcibr_provider.c
index 838c93c..27dd7df 100644
--- a/arch/ia64/sn/pci/pcibr/pcibr_provider.c
+++ b/arch/ia64/sn/pci/pcibr/pcibr_provider.c
@@ -95,7 +95,7 @@ u16 sn_ioboard_to_pci_bus(struct pci_bus
  * bridge sends an error interrupt.
  */
 static irqreturn_t
-pcibr_error_intr_handler(int irq, void *arg, struct pt_regs *regs)
+pcibr_error_intr_handler(int irq, void *arg)
 {
 	struct pcibus_info *soft = (struct pcibus_info *)arg;
 
@@ -138,7 +138,7 @@ pcibr_bus_fixup(struct pcibus_bussoft *p
 	/*
 	 * register the bridge's error interrupt handler
 	 */
-	if (request_irq(SGI_PCIASIC_ERROR, (void *)pcibr_error_intr_handler,
+	if (request_irq(SGI_PCIASIC_ERROR, pcibr_error_intr_handler,
 			IRQF_SHARED, "PCIBR error", (void *)(soft))) {
 		printk(KERN_WARNING
 		       "pcibr cannot allocate interrupt for error handler\n");
-- 
1.4.2.GIT

