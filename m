Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVIAHXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVIAHXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVIAHXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:23:50 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:48601 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964920AbVIAHXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:23:49 -0400
Date: Thu, 1 Sep 2005 09:24:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: [patch] drivers/ide/pci/alim15x3.c SMP fix
Message-ID: <20050901072430.GA6213@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


is this the right way to fix the UP assumption below?

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/drivers/ide/pci/alim15x3.c
===================================================================
--- linux.orig/drivers/ide/pci/alim15x3.c
+++ linux/drivers/ide/pci/alim15x3.c
@@ -323,7 +323,7 @@ static void ali15x3_tune_drive (ide_driv
 		if (r_clc >= 16)
 			r_clc = 0;
 	}
-	local_irq_save(flags);
+	spin_lock_irqsave(&ide_lock, flags);
 	
 	/* 
 	 * PIO mode => ATA FIFO on, ATAPI FIFO off
@@ -345,7 +345,7 @@ static void ali15x3_tune_drive (ide_driv
 	
 	pci_write_config_byte(dev, port, s_clc);
 	pci_write_config_byte(dev, port+drive->select.b.unit+2, (a_clc << 4) | r_clc);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ide_lock, flags);
 
 	/*
 	 * setup   active  rec
@@ -601,7 +601,7 @@ static unsigned int __devinit init_chips
 	}
 #endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS) */
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&ide_lock, flags);
 
 	if (m5229_revision < 0xC2) {
 		/*
@@ -614,7 +614,7 @@ static unsigned int __devinit init_chips
 		 * clear bit 7
 		 */
 		pci_write_config_byte(dev, 0x4b, tmpbyte & 0x7F);
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&ide_lock, flags);
 		return 0;
 	}
 
@@ -639,7 +639,7 @@ static unsigned int __devinit init_chips
 	 * 0:0.0 so if we didn't find one we know what is cooking.
 	 */
 	if (north && north->vendor != PCI_VENDOR_ID_AL) {
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&ide_lock, flags);
 	        return 0;
 	}
 
@@ -662,7 +662,7 @@ static unsigned int __devinit init_chips
 			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
 		}
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ide_lock, flags);
 	return 0;
 }
 
@@ -686,7 +686,7 @@ static unsigned int __devinit ata66_ali1
 	unsigned long flags;
 	u8 tmpbyte;
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&ide_lock, flags);
 
 	if (m5229_revision >= 0xC2) {
 		/*
@@ -736,7 +736,7 @@ static unsigned int __devinit ata66_ali1
 
 	pci_write_config_byte(dev, 0x53, tmpbyte);
 
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ide_lock, flags);
 
 	return(ata66);
 }
