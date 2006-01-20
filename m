Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWATTNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWATTNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWATTFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:28368 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751166AbWATTFA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:00 -0500
Cc: iod00d@hp.com
Subject: [PATCH] PCI: make it easier to see that set_msi_affinity() is used
In-Reply-To: <11377838789@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:38 -0800
Message-Id: <11377838782828@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: make it easier to see that set_msi_affinity() is used

I missed this usage in drivers/pci/msi.h:

#ifdef CONFIG_SMP
#define set_msi_irq_affinity    set_msi_affinity
#else
#define set_msi_irq_affinity    NULL
#endif

set_msi_affinity() is declared and exclusively used in msi.c.
Here's a better way so (hopefully) history doesn't repeat itself.

Signed-off-by: Grant Grundler <iod00d@hp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 705f309deedc7b2c5c00d89f78336f1e68fe504b
tree 77308ae642b7c796f28f65efd66b25aeb83659f5
parent fcac4238faf5cace3946d6c0102c176370483ed6
author Grant Grundler <iod00d@hp.com> Tue, 03 Jan 2006 18:51:46 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:34 -0800

 drivers/pci/msi.c |    8 +++++---
 drivers/pci/msi.h |    6 ------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 202b750..8977556 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -137,6 +137,8 @@ static void set_msi_affinity(unsigned in
 		break;
 	}
 }
+#else
+#define set_msi_affinity NULL
 #endif /* CONFIG_SMP */
 
 static void mask_MSI_irq(unsigned int vector)
@@ -214,7 +216,7 @@ static struct hw_interrupt_type msix_irq
 	.disable	= mask_MSI_irq,
 	.ack		= mask_MSI_irq,
 	.end		= end_msi_irq_w_maskbit,
-	.set_affinity	= set_msi_irq_affinity
+	.set_affinity	= set_msi_affinity
 };
 
 /*
@@ -230,7 +232,7 @@ static struct hw_interrupt_type msi_irq_
 	.disable	= mask_MSI_irq,
 	.ack		= mask_MSI_irq,
 	.end		= end_msi_irq_w_maskbit,
-	.set_affinity	= set_msi_irq_affinity
+	.set_affinity	= set_msi_affinity
 };
 
 /*
@@ -246,7 +248,7 @@ static struct hw_interrupt_type msi_irq_
 	.disable	= do_nothing,
 	.ack		= do_nothing,
 	.end		= end_msi_irq_wo_maskbit,
-	.set_affinity	= set_msi_irq_affinity
+	.set_affinity	= set_msi_affinity
 };
 
 static void msi_data_init(struct msg_data *msi_data,
diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 402136a..4ac52d4 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -22,12 +22,6 @@ extern int vector_irq[NR_VECTORS];
 extern void (*interrupt[NR_IRQS])(void);
 extern int pci_vector_resources(int last, int nr_released);
 
-#ifdef CONFIG_SMP
-#define set_msi_irq_affinity	set_msi_affinity
-#else
-#define set_msi_irq_affinity	NULL
-#endif
-
 /*
  * MSI-X Address Register
  */

