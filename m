Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263225AbVGaNrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbVGaNrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbVGaNrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:47:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25037 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263225AbVGaNq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:46:29 -0400
Date: Sun, 31 Jul 2005 15:46:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk
Subject: [patch] fix ucb1x00 support on collie
Message-ID: <20050731134617.GA25906@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Collie is slightly strange; it does not seem to have proper ucb1x00
ID. With this patch, basic ucb support seems to work and I can get
interrupts from battery.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 7247714847e6e3eebcdd71c58a4f730e12f0e56b
tree 555a0b987efd7b625097032bf894620574472f2c
parent 5a5269552a832668451518423ab7c1ece8d814e8
author <pavel@amd.(none)> Sun, 31 Jul 2005 15:45:30 +0200
committer <pavel@amd.(none)> Sun, 31 Jul 2005 15:45:30 +0200

 drivers/misc/mcp-sa1100.c   |   13 +++++++++++--
 drivers/misc/ucb1x00-core.c |   15 ++++++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mcp-sa1100.c b/drivers/misc/mcp-sa1100.c
--- a/drivers/misc/mcp-sa1100.c
+++ b/drivers/misc/mcp-sa1100.c
@@ -149,7 +149,7 @@ static int mcp_sa1100_probe(struct devic
 	    !machine_is_graphicsmaster() && !machine_is_lart()           &&
 	    !machine_is_omnimeter()      && !machine_is_pfs168()         &&
 	    !machine_is_shannon()        && !machine_is_simpad()         &&
-	    !machine_is_yopy())
+	    !machine_is_yopy()		 && !machine_is_collie())
 		return -ENODEV;
 
 	if (!request_mem_region(0x80060000, 0x60, "sa11x0-mcp"))
@@ -170,6 +170,12 @@ static int mcp_sa1100_probe(struct devic
 		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
 	}
 
+	if (machine_is_collie()) {
+		GAFR &= ~(GPIO_GPIO(16));
+		GPDR |= GPIO_GPIO(16);
+		GPSR |= GPIO_GPIO(16);
+	}
+
 	/*
 	 * Setup the PPC unit correctly.
 	 */
@@ -181,7 +187,10 @@ static int mcp_sa1100_probe(struct devic
 
 	Ser4MCSR = -1;
 	Ser4MCCR1 = 0;
-	Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;
+	if (machine_is_collie()) 
+		Ser4MCCR0 = MCCR0_ADM | MCCR0_ExtClk;
+	else
+		Ser4MCCR0 = 0x00007f7f | MCCR0_ADM;
 
 	/*
 	 * Calculate the read/write timeout (us) from the bit clock
diff --git a/drivers/misc/ucb1x00-core.c b/drivers/misc/ucb1x00-core.c
--- a/drivers/misc/ucb1x00-core.c
+++ b/drivers/misc/ucb1x00-core.c
@@ -28,6 +28,7 @@
 #include <asm/dma.h>
 #include <asm/hardware.h>
 #include <asm/irq.h>
+#include <asm/mach-types.h>
 
 #include <asm/arch/ucb1x00.h>
 
@@ -461,15 +462,19 @@ static int ucb1x00_probe(struct mcp *mcp
 {
 	struct ucb1x00 *ucb;
 	struct ucb1x00_driver *drv;
-	unsigned int id;
+	unsigned int id = UCB_ID_1200;
 	int ret = -ENODEV;
 
 	mcp_enable(mcp);
-	id = mcp_reg_read(mcp, UCB_ID);
 
-	if (id != UCB_ID_1200 && id != UCB_ID_1300) {
-		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
-		goto err_disable;
+	if (!machine_is_collie()) {
+		id = mcp_reg_read(mcp, UCB_ID);
+
+		/* Ouch? Collie produces basically random numbers. */
+		if (id != UCB_ID_1200 && id != UCB_ID_1300) {
+			printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
+			goto err_disable;
+		}
 	}
 
 	ucb = kmalloc(sizeof(struct ucb1x00), GFP_KERNEL);

-- 
if you have sharp zaurus hardware you don't need... you know my address
