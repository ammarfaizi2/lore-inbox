Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265775AbUGMUC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUGMUC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUGMUC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:02:56 -0400
Received: from fmr06.intel.com ([134.134.136.7]:46494 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265775AbUGMUCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:02:06 -0400
Date: Tue, 13 Jul 2004 15:02:43 -0700
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200407132202.i6DM2hRa007928@snoqualmie.dp.intel.com>
To: roland@topspin.com
Subject: Re:[PATCH]2.6.7 MSI-X Update
Cc: ak@muc.de, akpm@osdl.org, greg@kroah.com, jgazik@pobox.com,
       linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 25, 2004 6:39 PM, Roland Dreier wrote: 
>To summarize:
>  1) free_irq() should not have the function of disabling MSI, since
>     drivers probably don't want to disable MSI or free MSI-X vectors
>     just because they call free_irq()
Agree. Thanks for your inputs.

>  2) removing this overloaded function from free_irq() will also make
>     driver code clearer and easier to maintain.
I need this overloaded function to keep track of the state of each 
MSI/MSI-X vector. This allows me to generate a BUG_ON() if driver 
calls pci_disable_msi()/pci_disable_msix() without calling free_irq() 
for all MSI/MSI-X vector(s). 

I include the update to previous patch. Please let me know what you 
think.

Thanks,
Long
---------------------------------------------------------------------
diff -urN patch-2.6.7-msix-src1/Documentation/MSI-HOWTO.txt patch-2.6.7-msix-src2/Documentation/MSI-HOWTO.txt
--- patch-2.6.7-msix-src1/Documentation/MSI-HOWTO.txt	2004-06-25 16:10:58.000000000 -0400
+++ patch-2.6.7-msix-src2/Documentation/MSI-HOWTO.txt	2004-07-13 12:45:45.000000000 -0400
@@ -113,7 +113,7 @@
 messages regardless of a device function is capable of supporting
 more than one vector. To enable MSI on a device function's MSI
 capability structure requires a device driver to call the function 
-pci_enable_msi() explicitly.
+pci_enable_msi() explicitly. 
 
 5.2.1 API pci_enable_msi
 
@@ -132,11 +132,15 @@
 
 void pci_disable_msi(struct pci_dev *dev)
 
-This API is needed to encounter the case where a device driver is
-unloaded without doing request_irq on assigned MSI vector results
-a device being left in MSI mode and not be able to recover without
-rebooting. This API provides a device driver an ability to recover
-and resolves vector leakage.   
+This API should always be used to undo the effect of pci_enable_msi()
+when a device driver is unloading. This API restores dev->irq with
+the pre-assigned IOAPIC vector and switches a device's interrupt 
+mode to PCI pin-irq assertion/INTx emulation mode.    
+
+Note that a device driver should always call free_irq() on MSI vector
+it has done request_irq() on before calling this API. Failure to do  
+so results a BUG_ON() and a device will be left with MSI enabled and 
+leaks its vector. 
 
 5.2.3 MSI mode vs. legacy mode diagram
 
@@ -148,8 +152,7 @@
 	|	     | <===============	| 			 |
 	| MSI MODE   |	  	     	| PIN-IRQ ASSERTION MODE |
 	| 	     | ===============>	|			 |
- 	 ------------	free_irq/      	 ------------------------
-			pci_disable_msi
+ 	 ------------	pci_disable_msi  ------------------------
 
 
 Figure 1.0 MSI Mode vs. Legacy Mode
@@ -161,17 +164,24 @@
 stored in dev->irq will be saved by the PCI subsystem and a new 
 assigned MSI vector will replace dev->irq. 
 
-To return back to its default mode, a device driver must call 
-free_irq() using the allocated MSI vector. The PCI subsystem restores a
-device's dev->irq with a pre-assigned IOAPIC vector and marks released
-MSI vector as unused. Once being marked as unused, there is no 
-guarantee that the PCI subsystem will reserve this MSI vector for a
-device. Depending on the availability of current PCI vector resources
-and the number of MSI/MSI-X requests from other drivers, this MSI
-may be re-assigned. For the case where the PCI subsystem re-assigned 
-this MSI vector another driver, a request to switching back to MSI
-mode may result in being assigned a different MSI vector or a failure
-if no more vectors are available.  
+To return back to its default mode, a device driver should always call
+pci_disable_msi() to undo the effect of pci_enable_msi(). Note that a
+device driver should always call free_irq() on MSI vector it has done
+request_irq() on before calling pci_disable_msi(). Failure to do so 
+results a BUG_ON() and a device will be left with MSI enabled and 
+leaks its vector. Otherwise, the PCI subsystem restores a device's
+dev->irq with a pre-assigned IOAPIC vector and marks released
+MSI vector as unused. 
+
+Once being marked as unused, there is no guarantee that the PCI 
+subsystem will reserve this MSI vector for a device. Depending on 
+the availability of current PCI vector resources and the number of 
+MSI/MSI-X requests from other drivers, this MSI may be re-assigned. 
+
+For the case where the PCI subsystem re-assigned this MSI vector 
+another driver, a request to switching back to MSI mode may result 
+in being assigned a different MSI vector or a failure if no more 
+vectors are available.  
 
 5.3 Configuring for MSI-X support
 
@@ -328,15 +338,11 @@
 
 void pci_disable_msix(struct pci_dev *dev)
 
-This API is needed to encounter the case where a device driver is
-unloaded without doing request_irq on all ssigned MSI-X vector 
-results a device being left in MSI-x mode and not be able to recover
-without rebooting. For example, a device driver does pci_enable_msix
-and is allocated 2 vectors, then correctly does request_irq/free_irq
-on one vector but does not touch the second vector. When a device
-driver is unloaded, it will be left in MSI-X mode. This API provides
-a device driver an ability to recover without rebooting and resolves
-vector leakage.   
+This API should always be used to undo the effect of pci_enable_msix()
+when a device driver is unloading. Note that a device driver should 
+always call free_irq() on all MSI-X vectors it has done request_irq() 
+on before calling this API. Failure to do so results a BUG_ON() and 
+a device will be left with MSI-X enabled and leaks its vectors. 
 
 5.3.6 MSI-X mode vs. legacy mode diagram
 
@@ -348,8 +354,7 @@
 	|	     | <===============	    | 			     |
 	| MSI-X MODE |	  	     	    | PIN-IRQ ASSERTION MODE |
 	| 	     | ===============>	    |			     |
- 	 ------------	(n)free_irq/   	     ------------------------
-			pci_disable_msix
+ 	 ------------	pci_disable_msix     ------------------------
 
 Figure 2.0 MSI-X Mode vs. Legacy Mode
 
@@ -358,30 +363,29 @@
 device's interrupt mode to MSI-X mode. A pre-assigned IOAPIC vector
 stored in dev->irq will be saved by the PCI subsystem; however, 
 unlike MSI mode, the PCI subsystem will not replace dev->irq with 
-assigned MSI-x vector because the PCI subsystem already writes the 1:1 
+assigned MSI-X vector because the PCI subsystem already writes the 1:1 
 vector-to-entry mapping into the field vector of each element 
 specified in second argument.
 
-To return back to its default mode, a device driver requires to call 
-free_irq() on all allocated MSI vectors associated with doing 
-request_irq. Unlike MSI mode, the PCI subsystem switches a device 
-function back to its default legacy mode if and only if its device 
-driver successfully releases all allocated MSI-X vectors correctly
-associated with request_irq/free_irq.
-
-Note that if a device still operates in MSI-X mode, its device 
-driver can use request_irq/free_irq to any vectors in subset n. When
-the PCI subsystem detects all MSI-X vectors being released by a device
-driver, it will switches a function's interrupt mode from MSI-X mode
-to legacy mode and mark all allocated MSI-X vectors as unused. Once 
-being marked as unused, there is no guarantee that the PCI subsystem 
-will reserve these MSI-X vectors for a device. Depending on the 
-availability of current PCI vector resources and the number of 
+To return back to its default mode, a device driver should always call
+pci_disable_msix() to undo the effect of pci_enable_msix(). Note that 
+a device driver should always call free_irq() on all MSI-X vectors it 
+has done request_irq() on before calling pci_disable_msix(). Failure 
+to do so results a BUG_ON() and a device will be left with MSI-X 
+enabled and leaks its vectors. Otherwise, the PCI subsystem switches a
+device function's interrupt mode from MSI-X mode to legacy mode and 
+marks all allocated MSI-X vectors as unused. 
+
+Once being marked as unused, there is no guarantee that the PCI 
+subsystem will reserve these MSI-X vectors for a device. Depending on 
+the availability of current PCI vector resources and the number of 
 MSI/MSI-X requests from other drivers, these MSI-X vectors may be 
-re-assigned. For the case where the PCI subsystem re-assigned 
-these MSI-X vectors to other driver, a request to switching back to 
-MSI-X mode may result being assigned with another set of MSI-X vectors
-or a failure.  
+re-assigned. 
+
+For the case where the PCI subsystem re-assigned these MSI-X vectors
+to other driver, a request to switching back to MSI-X mode may result
+being assigned with another set of MSI-X vectors or a failure if no 
+more vectors are available.  
 
 5.4 Handling function implementng both MSI and MSI-X capabilities
 
diff -urN patch-2.6.7-msix-src1/drivers/pci/msi.c patch-2.6.7-msix-src2/drivers/pci/msi.c
--- patch-2.6.7-msix-src1/drivers/pci/msi.c	2004-06-25 14:43:10.000000000 -0400
+++ patch-2.6.7-msix-src2/drivers/pci/msi.c	2004-07-13 09:30:44.000000000 -0400
@@ -779,10 +779,8 @@
 		dev->irq);
 		BUG_ON(entry->msi_attrib.state > 0);
 	} else {
-		if (vector_irq[dev->irq] != 0) {
-			vector_irq[dev->irq] = 0; /* free it */
-			nr_released_vectors++;
-		}
+		vector_irq[dev->irq] = 0; /* free it */
+		nr_released_vectors++;
 		default_vector = entry->msi_attrib.default_vector;
 		spin_unlock_irqrestore(&msi_lock, flags);
 		/* Restore dev->irq to its default pin-assertion vector */
@@ -794,58 +792,14 @@
 
 static void release_msi(unsigned int vector)
 {
-	int type, default_vector;
 	struct msi_desc *entry;
-	struct pci_dev *dev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&msi_lock, flags);
 	entry = msi_desc[vector];
-	if (!entry || !entry->dev) {
-		spin_unlock_irqrestore(&msi_lock, flags);
-		return;
-	}
-	dev = entry->dev;
-	type = entry->msi_attrib.type;
-	entry->msi_attrib.state = 0;		/* Mark it not active */
-	default_vector = entry->msi_attrib.default_vector;
+	if (entry && entry->dev) 
+		entry->msi_attrib.state = 0;	/* Mark it not active */
 	spin_unlock_irqrestore(&msi_lock, flags);
-	switch (type) {
-	case PCI_CAP_ID_MSI:
-		spin_lock_irqsave(&msi_lock, flags);
-		vector_irq[vector] = 0;		/* Mark it free */
-		nr_released_vectors++;
-		spin_unlock_irqrestore(&msi_lock, flags);
-		break;
-	case PCI_CAP_ID_MSIX:
-		spin_lock_irqsave(&msi_lock, flags);
-		while (vector != entry->link.tail) {
-			entry = msi_desc[entry->link.tail];
-			if (!entry->msi_attrib.state)
-				continue;
-			spin_unlock_irqrestore(&msi_lock, flags);
-			/* 
-			 * Device still operates in MSI-X mode. Do not
-			 * switch interrupt mode
-			 */
-			return;
-		}
-		entry = msi_desc[vector];
-		vector_irq[vector] = 0; 		  /* Mark it free */
-		nr_released_vectors++;
-		while (vector != entry->link.tail) {
-			vector_irq[entry->link.tail] = 0; /* Mark it free */
-			nr_released_vectors++;
-			entry = msi_desc[entry->link.tail];
-		} 
-		spin_unlock_irqrestore(&msi_lock, flags);
-		break;
-	default:
-		return;
-	}
-	/* Restore dev->irq to its default pin-assertion vector */
-	dev->irq = default_vector;
-	disable_msi_mode(dev, pci_find_capability(dev, type), type);
 }
 
 static int msi_free_vector(struct pci_dev* dev, int vector, int reassign)
@@ -1074,6 +1028,7 @@
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
 	if (!(control & PCI_MSIX_FLAGS_ENABLE)) 
 		return;
+	
 	temp = dev->irq;
 	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSIX)) {
 		int state, vector, head, tail = 0, warning = 0;
@@ -1086,10 +1041,8 @@
 			if (state) 
 				warning = 1;
 			else {
-				if (vector_irq[vector] != 0) {
-					vector_irq[vector] = 0; /* free it */
-					nr_released_vectors++;
-				}
+				vector_irq[vector] = 0; /* free it */
+				nr_released_vectors++;
 			}
 			tail = msi_desc[vector]->link.tail;
 			vector = tail;
