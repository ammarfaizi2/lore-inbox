Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270129AbUJTK0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270129AbUJTK0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270201AbUJSXBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:01:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:62089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270078AbUJSWqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:21 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257372797@kroah.com>
Date: Tue, 19 Oct 2004 15:42:17 -0700
Message-Id: <1098225737586@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.44, 2004/10/06 13:05:44-07:00, greg@kroah.com

[PATCH] PCI: change cyrix.c driver to use pci_dev_present

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/cpu/cyrix.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)


diff -Nru a/arch/i386/kernel/cpu/cyrix.c b/arch/i386/kernel/cpu/cyrix.c
--- a/arch/i386/kernel/cpu/cyrix.c	2004-10-19 15:23:42 -07:00
+++ b/arch/i386/kernel/cpu/cyrix.c	2004-10-19 15:23:42 -07:00
@@ -187,12 +187,19 @@
 }
 
 
+#ifdef CONFIG_PCI
+static struct pci_device_id cyrix_55x0[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520) },
+	{ },
+};
+#endif
+
 static void __init init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
 	const char *p = NULL;
-	struct pci_dev *dev;
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -275,16 +282,8 @@
 		/*
 		 *  The 5510/5520 companion chips have a funky PIT.
 		 */  
-		dev = pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510, NULL);
-		if (dev) {
-			pci_dev_put(dev);
-			pit_latch_buggy = 1;
-		}
-		dev =  pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
-		if (dev) {
-			pci_dev_put(dev);
+		if (pci_dev_present(cyrix_55x0))
 			pit_latch_buggy = 1;
-		}
 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {

