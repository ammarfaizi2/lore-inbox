Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVAEBsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVAEBsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVAEBpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:45:07 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:39625 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262192AbVAEBju
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:39:50 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, dev-etrax@axis.com
Cc: starvik@axis.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105014007.22177.60026.41442@localhost.localdomain>
In-Reply-To: <20050105014001.22177.28259.66716@localhost.localdomain>
References: <20050105014001.22177.28259.66716@localhost.localdomain>
Subject: [PATCH 1/2] cris: remove cli()/sti() in arch/cris/arch-v10/drivers/gpio.c
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 19:39:47 -0600
Date: Tue, 4 Jan 2005 19:39:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/cris/arch-v10/drivers/gpio.c linux-2.6.10-mm1/arch/cris/arch-v10/drivers/gpio.c
--- linux-2.6.10-mm1-original/arch/cris/arch-v10/drivers/gpio.c	2004-12-24 16:33:48.000000000 -0500
+++ linux-2.6.10-mm1/arch/cris/arch-v10/drivers/gpio.c	2005-01-04 20:21:46.356413860 -0500
@@ -270,10 +270,10 @@
 		 */
 		tmp = ~data & priv->highalarm & 0xFF;
 		tmp = (tmp << R_IRQ_MASK1_SET__pa0__BITNR);
-		save_flags(flags); cli();
+		local_irq_save(flags);
 		gpio_pa_irq_enabled_mask |= tmp;
 		*R_IRQ_MASK1_SET = tmp;
-		restore_flags(flags);
+		local_irq_restore(flags);
 
 	} else if (priv->minor == GPIO_MINOR_B)
 		data = *R_PORT_PB_DATA;
@@ -372,7 +372,7 @@
 		data = *buf++;
 		if (priv->write_msb) {
 			for (i = 7; i >= 0;i--) {
-				local_irq_save(flags); local_irq_disable();
+				local_irq_save(flags);
 				*priv->port = *priv->shadow &= ~clk_mask;
 				if (data & 1<<i)
 					*priv->port = *priv->shadow |= data_mask;
@@ -384,7 +384,7 @@
 			}
 		} else {
 			for (i = 0; i <= 7;i++) {
-				local_irq_save(flags); local_irq_disable();
+				local_irq_save(flags);
 				*priv->port = *priv->shadow &= ~clk_mask;
 				if (data & 1<<i)
 					*priv->port = *priv->shadow |= data_mask;
@@ -491,14 +491,14 @@
 	 */
 	unsigned long flags;
 	if (USE_PORTS(priv)) {
-		local_irq_save(flags); local_irq_disable();
+		local_irq_save(flags);
 		*priv->dir = *priv->dir_shadow &= 
 		~((unsigned char)arg & priv->changeable_dir);
 		local_irq_restore(flags);
 		return ~(*priv->dir_shadow) & 0xFF; /* Only 8 bits */
 	} else if (priv->minor == GPIO_MINOR_G) {
 		/* We must fiddle with R_GEN_CONFIG to change dir */
-		save_flags(flags); cli();
+		local_irq_save(flags)
 		if (((arg & dir_g_in_bits) != arg) && 
 		    (arg & changeable_dir_g)) {
 			arg &= changeable_dir_g;
@@ -533,7 +533,7 @@
 			/* Must be a >120 ns delay before writing this again */
 				
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return dir_g_in_bits;
 	}
 	return 0;
@@ -543,14 +543,14 @@
 {
 	unsigned long flags;
 	if (USE_PORTS(priv)) {
-		local_irq_save(flags); local_irq_disable();
+		local_irq_save(flags);
 		*priv->dir = *priv->dir_shadow |= 
 		  ((unsigned char)arg & priv->changeable_dir);
 		local_irq_restore(flags);
 		return *priv->dir_shadow;
 	} else if (priv->minor == GPIO_MINOR_G) {
 		/* We must fiddle with R_GEN_CONFIG to change dir */			
-		save_flags(flags); cli();
+		local_irq_save(flags);
 		if (((arg & dir_g_out_bits) != arg) &&
 		    (arg & changeable_dir_g)) {
 			/* Set bits in genconfig to set to output */
@@ -583,7 +583,7 @@
 			*R_GEN_CONFIG = genconfig_shadow;
 			/* Must be a >120 ns delay before writing this again */
 		}
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return dir_g_out_bits & 0x7FFFFFFF;
 	}
 	return 0;
@@ -613,7 +613,7 @@
 		}
 		break;
 	case IO_SETBITS:
-		local_irq_save(flags); local_irq_disable();
+		local_irq_save(flags);
 		// set changeable bits with a 1 in arg
 		if (USE_PORTS(priv)) {
 			*priv->port = *priv->shadow |= 
@@ -624,7 +624,7 @@
 		local_irq_restore(flags);
 		break;
 	case IO_CLRBITS:
-		local_irq_save(flags); local_irq_disable();
+		local_irq_save(flags);
 		// clear changeable bits with a 1 in arg
 		if (USE_PORTS(priv)) {
 			*priv->port = *priv->shadow &= 
