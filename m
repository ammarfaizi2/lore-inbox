Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbWI3X6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWI3X6g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 19:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWI3X6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 19:58:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:16616 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751739AbWI3X6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 19:58:34 -0400
Message-ID: <451F049A.1010404@garzik.org>
Date: Sat, 30 Sep 2006 19:58:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>, Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Wilcox <matthew@wil.cx>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug>
In-Reply-To: <20060930140946.GA1195@slug>
Content-Type: multipart/mixed;
 boundary="------------020906010503040500020808"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020906010503040500020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Frederik Deweerdt wrote:
> On Sat, Sep 30, 2006 at 12:43:24AM +0100, Alan Cox wrote:
>> Ar Gwe, 2006-09-29 am 23:50 +0000, ysgrifennodd Frederik Deweerdt:
>>> Does this patch makes sense in that case? If yes, I'll put up a patch
>>> for the remaining cases in the drivers/scsi/aic7xxx/ directory.
>>> Also, aic7xxx's coding style would put parenthesis around the returned
>>> value, should I follow it?
>> Yes - but perhaps with a warning message so users know why ?
>>
>> As to coding style - kernel style is unbracketed so I wouldnt worry
>> about either.
>>
> Thanks for the advices. 
> 
> The following patch checks whenever the irq is valid before issuing a
> request_irq() for AIC7XXX and AIC79XX. An error message is displayed to
> let the user know what went wrong.
> 
> Regards,
> Frederik
> 
> Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

Actually, rather than adding this check to every driver, I would rather 
do something like the attached patch:  create a pci_request_irq(), and 
pass a struct pci_device to it.  Then the driver author doesn't have to 
worry about such details.

	Jeff



--------------020906010503040500020808
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a544997..9743471 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -809,6 +809,40 @@ err_out:
 	return -EBUSY;
 }
 
+#ifndef ARCH_VALIDATE_PCI_IRQ
+int pci_valid_irq(struct pci_dev *pdev)
+{
+	if (pdev->irq == 0)
+		return -EINVAL;
+	
+	return 0;
+}
+EXPORT_SYMBOL(pci_valid_irq);
+#endif /* ARCH_VALIDATE_PCI_IRQ */
+
+int pci_request_irq(struct pci_dev *pdev,
+		    irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		    unsigned long flags, const char *name, void *userdata)
+{
+	int rc;
+
+	rc = pci_valid_irq(pdev);
+	if (rc) {
+		dev_printk(KERN_ERR, &pdev->dev, "invalid irq\n");
+		return rc;
+	}
+
+	return request_irq(pdev->irq, handler, flags | IRQF_SHARED,
+			   name, userdata);
+}
+EXPORT_SYMBOL(pci_request_irq);
+
+void pci_release_irq(struct pci_dev *pdev, void *userdata)
+{
+	free_irq(pdev->irq, userdata);
+}
+EXPORT_SYMBOL(pci_release_irq);
+
 /**
  * pci_set_master - enables bus-mastering for device dev
  * @dev: the PCI device to enable
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5c3a417..5e254fc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -52,6 +52,7 @@ #include <linux/list.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
@@ -537,6 +538,12 @@ void pci_release_regions(struct pci_dev 
 int __must_check pci_request_region(struct pci_dev *, int, const char *);
 void pci_release_region(struct pci_dev *, int);
 
+int __must_check pci_valid_irq(struct pci_dev *pdev);
+int __must_check pci_request_irq(struct pci_dev *pdev,
+		    irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		    unsigned long flags, const char *name, void *userdata);
+void pci_release_irq(struct pci_dev *pdev, void *userdata);
+
 /* drivers/pci/bus.c */
 int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			struct resource *res, resource_size_t size,

--------------020906010503040500020808--
