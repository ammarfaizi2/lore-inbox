Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWBPWjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWBPWjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWBPWjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:39:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750749AbWBPWjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:39:17 -0500
Date: Thu, 16 Feb 2006 17:39:16 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Fix IDE locking error.
Message-ID: <20060216223916.GA8463@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bit us a few kernels ago, and for some reason never made it's way
upstream.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144743
Kernel panic - not syncing: drivers/ide/pci/piix.c:231:
spin_lock(drivers/ide/ide.c:c03cef28) already locked by driver/ide/ide-iops.c/1153.

From: Alan Cox <alan@redhat.com>
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/drivers/ide/pci/piix.c~	2005-07-11 10:23:24.637181320 +0100
+++ linux-2.6.12/drivers/ide/pci/piix.c	2005-07-11 10:23:24.637181320 +0100
@@ -203,6 +203,8 @@
 	}
 }
 
+static spinlock_t tune_lock = SPIN_LOCK_UNLOCKED;
+
 /**
  *	piix_tune_drive		-	tune a drive attached to a PIIX
  *	@drive: drive to tune
@@ -229,7 +231,12 @@
 			    { 2, 3 }, };
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
-	spin_lock_irqsave(&ide_lock, flags);
+	
+	/* Master v slave is synchronized above us but the slave register is
+	   shared by the two hwifs so the corner case of two slave timeouts in
+	   parallel must be locked */
+	   
+	spin_lock_irqsave(&tune_lock, flags);
 	pci_read_config_word(dev, master_port, &master_data);
 	if (is_slave) {
 		master_data = master_data | 0x4000;
@@ -249,7 +256,7 @@
 	pci_write_config_word(dev, master_port, master_data);
 	if (is_slave)
 		pci_write_config_byte(dev, slave_port, slave_data);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock_irqrestore(&tune_lock, flags);
 }
 
 /**
