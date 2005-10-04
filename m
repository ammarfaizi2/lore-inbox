Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVJDQkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVJDQkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVJDQkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:40:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35492 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964791AbVJDQkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:40:49 -0400
Date: Tue, 4 Oct 2005 17:40:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bogus kfree() in ibmtr
Message-ID: <20051004164044.GF7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	On several failure exits in ibmtr we end up doing kfree() on
dev->priv, with dev allocated by alloc_trdev() and ->priv never reassigned.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc3-git4-base/drivers/net/tokenring/ibmtr.c current/drivers/net/tokenring/ibmtr.c
--- RC14-rc3-git4-base/drivers/net/tokenring/ibmtr.c	2005-08-28 23:09:44.000000000 -0400
+++ current/drivers/net/tokenring/ibmtr.c	2005-10-03 18:15:27.000000000 -0400
@@ -531,7 +531,6 @@
 			if (!time_after(jiffies, timeout)) continue;
 			DPRINTK( "Hardware timeout during initialization.\n");
 			iounmap(t_mmio);
-			kfree(ti);
 			return -ENODEV;
 		}
 		ti->sram_phys =
@@ -645,7 +644,6 @@
 			DPRINTK("Unknown shared ram paging info %01X\n",
 							ti->shared_ram_paging);
 			iounmap(t_mmio); 
-			kfree(ti);
 			return -ENODEV;
 			break;
 		} /*end switch shared_ram_paging */
@@ -675,7 +673,6 @@
 			"driver limit (%05x), adapter not started.\n",
 			chk_base, ibmtr_mem_base + IBMTR_SHARED_RAM_SIZE);
 			iounmap(t_mmio);
-			kfree(ti);
 			return -ENODEV;
 		} else { /* seems cool, record what we have figured out */
 			ti->sram_base = new_base >> 12;
@@ -690,7 +687,6 @@
 		DPRINTK("Could not grab irq %d.  Halting Token Ring driver.\n",
 					irq);
 		iounmap(t_mmio);
-		kfree(ti);
 		return -ENODEV;
 	}
 	/*?? Now, allocate some of the PIO PORTs for this driver.. */
@@ -699,7 +695,6 @@
 		DPRINTK("Could not grab PIO range. Halting driver.\n");
 		free_irq(dev->irq, dev);
 		iounmap(t_mmio);
-		kfree(ti);
 		return -EBUSY;
 	}
 
