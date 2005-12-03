Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVLCB3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVLCB3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbVLCB3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:29:15 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:36525 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751105AbVLCB3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:29:14 -0500
Message-ID: <4390F614.7060202@student.ltu.se>
Date: Sat, 03 Dec 2005 02:34:12 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: [PATCH] pci: Schedule removal of pci_module_init (was Re: [PATCH
 2.6.15-rc3(-mm1) 3/3] pci.h:)
References: <20051201130338.28376.65935.sendpatchset@thinktank.campus.ltu.se>	<20051201130438.28376.78967.sendpatchset@thinktank.campus.ltu.se> <20051201152210.517b936d.akpm@osdl.org>
In-Reply-To: <20051201152210.517b936d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>  
>
>> +#if 0
>>  /*
>>   * pci_module_init is obsolete, this stays here till we fix up all usages of it
>>   * in the tree.
>>   */
>>  #define pci_module_init	pci_register_driver
>> +#endif
>>    
>>
>
>This one's a bit optimistic.  We need to wait until Linus's patch is fully
>converted, than wait a bit.
>
>You might investigate turning this into an inline function, then mark it
>__deprecated and generate a Documentation/feature-removal-schedule.txt
>record for it.
>-
>
From: Richard Knutsson <ricknu-0@student.ltu.se>

Scheduled the removal of pci_module_init and __deprecated the function, 
as suggested by Andrew.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---

diff -Narup a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt	2005-11-29 11:08:41.000000000 +0100
+++ b/Documentation/feature-removal-schedule.txt	2005-12-03 01:21:46.000000000 +0100
@@ -159,3 +159,10 @@ Why:	The 8250 serial driver now has the 
 	brother on Alchemy SOCs.  The loss of features is not considered an
 	issue.
 Who:	Ralf Baechle <ralf@linux-mips.org>
+
+---------------------------
+
+What:	pci_module_init(driver)
+When:	April 2006
+Why:	Is replaced by pci_register_driver(pci_driver).
+Who:	Richard Knutsson <ricknu-0@student.ltu.se>
diff -Narup a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-11-29 11:09:05.000000000 +0100
+++ b/include/linux/pci.h	2005-12-03 01:40:40.000000000 +0100
@@ -277,12 +277,6 @@ struct pci_driver {
 	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
-/*
- * pci_module_init is obsolete, this stays here till we fix up all usages of it
- * in the tree.
- */
-#define pci_module_init	pci_register_driver
-
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -434,6 +428,10 @@ void pci_enable_bridges(struct pci_bus *
 
 /* Proper probing supporting hot-pluggable devices */
 int __pci_register_driver(struct pci_driver *, struct module *);
+static inline int __deprecated pci_module_init(struct pci_driver *driver)
+{
+	return __pci_register_driver(driver, THIS_MODULE);
+}
 static inline int pci_register_driver(struct pci_driver *driver)
 {
 	return __pci_register_driver(driver, THIS_MODULE);
@@ -553,6 +551,7 @@ static inline void pci_disable_device(st
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int __pci_register_driver(struct pci_driver *drv, struct module *owner) { return 0;}
+static inline int __deprecated pci_module_init(struct pci_driver *driver) { return 0; }
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }


