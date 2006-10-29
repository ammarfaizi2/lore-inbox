Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbWJ2Njl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWJ2Njl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 08:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWJ2Njl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 08:39:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:17267 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965223AbWJ2Njj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 08:39:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fcCP18c/t1BcJ0+2T0Di+9T/oCONAQfFgLCNY/ZDTN43FgFJtSzb7fzDFOShFAG7zMpT5/0fT/I+JFrYu3ijdFcxrUHGX0hpbVN1LPMj6WZiloillJtDkbzCvWEya5Rs5ka7H9t1BW8J6KputKk42HHWuXKtP6bry2BkeibvlpM=
Date: Sun, 29 Oct 2006 22:40:03 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: [PATCH -mm] acpi: use list.h API for sub_driver list
Message-ID: <20061029134003.GC10295@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <20061028185313.GK9973@localhost> <20061028190254.GA7070@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028190254.GA7070@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 08:02:54PM +0100, Christoph Hellwig wrote:
> Any chance to just switch the driver to use the list.h APIs instead
> of opencoding lists?

Subject: [PATCH -mm] acpi: use list.h API for sub_driver list

Use the list.h APIs instead of opencoding lists.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Index: work-fault-inject/drivers/acpi/pci_root.c
===================================================================
--- work-fault-inject.orig/drivers/acpi/pci_root.c
+++ work-fault-inject/drivers/acpi/pci_root.c
@@ -65,17 +65,14 @@ struct acpi_pci_root {
 
 static LIST_HEAD(acpi_pci_roots);
 
-static struct acpi_pci_driver *sub_driver;
+static LIST_HEAD(sub_driver);
 
 int acpi_pci_register_driver(struct acpi_pci_driver *driver)
 {
 	int n = 0;
 	struct list_head *entry;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr)
-		pptr = &(*pptr)->next;
-	*pptr = driver;
+	list_add_tail(&driver->list, &sub_driver);
 
 	if (!driver->add)
 		return 0;
@@ -96,14 +93,7 @@ void acpi_pci_unregister_driver(struct a
 {
 	struct list_head *entry;
 
-	struct acpi_pci_driver **pptr = &sub_driver;
-	while (*pptr) {
-		if (*pptr == driver)
-			break;
-		pptr = &(*pptr)->next;
-	}
-	BUG_ON(!*pptr);
-	*pptr = (*pptr)->next;
+	list_del(&driver->list);
 
 	if (!driver->remove)
 		return;
Index: work-fault-inject/include/linux/acpi.h
===================================================================
--- work-fault-inject.orig/include/linux/acpi.h
+++ work-fault-inject/include/linux/acpi.h
@@ -480,7 +480,7 @@ void acpi_penalize_isa_irq(int irq, int 
 void acpi_pci_irq_disable (struct pci_dev *dev);
 
 struct acpi_pci_driver {
-	struct acpi_pci_driver *next;
+	struct list_head list;
 	int (*add)(acpi_handle handle);
 	void (*remove)(acpi_handle handle);
 };
