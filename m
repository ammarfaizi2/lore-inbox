Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbTGDW5C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 18:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbTGDW5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 18:57:02 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:30992 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S266209AbTGDW4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 18:56:15 -0400
To: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] [4/6] EISA support updates
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Sat, 05 Jul 2003 01:07:49 +0200
Message-ID: <wrpwuexubzu.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpk7axvqv1.fsf@hina.wild-wind.fr.eu.org> (Marc Zyngier's
 message of "Sat, 05 Jul 2003 01:01:22 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PA-RISC changes :

- Probe the right number of EISA slots on PA-RISC. No more, no less.

	M.

diff -ruN linux-latest/drivers/parisc/eisa.c linux-eisa/drivers/parisc/eisa.c
--- linux-latest/drivers/parisc/eisa.c	2003-07-04 09:38:48.000000000 +0200
+++ linux-eisa/drivers/parisc/eisa.c	2003-07-04 09:39:46.000000000 +0200
@@ -378,19 +378,21 @@
 		}
 	}
 	eisa_eeprom_init(eisa_dev.eeprom_addr);
-	eisa_enumerator(eisa_dev.eeprom_addr, &eisa_dev.hba.io_space, &eisa_dev.hba.lmmio_space);
+	result = eisa_enumerator(eisa_dev.eeprom_addr, &eisa_dev.hba.io_space, &eisa_dev.hba.lmmio_space);
 	init_eisa_pic();
 
-	/* FIXME : Get the number of slots from the enumerator, not a
-	 * hadcoded value. Also don't enumerate the bus twice. */
-	eisa_dev.root.dev = &dev->dev;
-	dev->dev.driver_data = &eisa_dev.root;
-	eisa_dev.root.bus_base_addr = 0;
-	eisa_dev.root.res = &eisa_dev.hba.io_space;
-	eisa_dev.root.slots = EISA_MAX_SLOTS;
-	if (eisa_root_register (&eisa_dev.root)) {
-		printk(KERN_ERR "EISA: Failed to register EISA root\n");
-		return -1;
+	if (result >= 0) {
+		/* FIXME : Don't enumerate the bus twice. */
+		eisa_dev.root.dev = &dev->dev;
+		dev->dev.driver_data = &eisa_dev.root;
+		eisa_dev.root.bus_base_addr = 0;
+		eisa_dev.root.res = &eisa_dev.hba.io_space;
+		eisa_dev.root.slots = result;
+		eisa_dev.root.dma_mask = 0xffffffff; /* wild guess */
+		if (eisa_root_register (&eisa_dev.root)) {
+			printk(KERN_ERR "EISA: Failed to register EISA root\n");
+			return -1;
+		}
 	}
 	
 	return 0;
diff -ruN linux-latest/drivers/parisc/eisa_enumerator.c linux-eisa/drivers/parisc/eisa_enumerator.c
--- linux-latest/drivers/parisc/eisa_enumerator.c	2003-07-04 09:39:09.000000000 +0200
+++ linux-eisa/drivers/parisc/eisa_enumerator.c	2003-07-04 09:40:06.000000000 +0200
@@ -438,6 +438,10 @@
 		id = le32_to_cpu(inl(SLOT2PORT(slot)+EPI));
 		
 		if (0xffffffff == id) {
+			/* Maybe we didn't expect a card to be here... */
+			if (es->eisa_slot_id == 0xffffffff)
+				return -1;
+			
 			/* this board is not here or it does not 
 			 * support readid 
 			 */
@@ -499,8 +503,7 @@
 			(&eeprom_buf[HPEE_SLOT_INFO(i)]);
 	        
 		if (-1==init_slot(i+1, es)) {
-			return -1;
-			
+			continue;
 		}
 		
 		if (es->config_data_offset < HPEE_MAX_LENGTH) {
@@ -513,6 +516,6 @@
 			return -1;
 		}
 	}
-	return 0;
+	return eh->num_slots;
 }
 

-- 
Places change, faces change. Life is so very strange.
