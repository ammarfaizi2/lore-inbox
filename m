Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWGYUzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWGYUzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWGYUzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:55:17 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:63663 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751577AbWGYUzP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:55:15 -0400
From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To: jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [PATCH] Stop calling phy_stop_interrupts() twice
Date: Wed, 26 Jul 2006 00:53:53 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, afleming@freescale.com,
       vbordug@ru.mvista.com, yshpilevsky@ru.mvista.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200607260053.53390.sshtylyov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent phylib from freeing PHY IRQ twice on closing an eth device:
phy_disconnect() first calls phy_stop_interrupts(), then it calls 
phy_stop_machine() which in turn calls phy_stop_interrupts() making the 
kernel complain on each bootup...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Index: linux-2.6/drivers/net/phy/phy.c
===================================================================
--- linux-2.6.orig/drivers/net/phy/phy.c
+++ linux-2.6/drivers/net/phy/phy.c
@@ -419,9 +419,8 @@ void phy_start_machine(struct phy_device
 
 /* phy_stop_machine
  *
- * description: Stops the state machine timer, sets the state to
- *   UP (unless it wasn't up yet), and then frees the interrupt,
- *   if it is in use. This function must be called BEFORE
+ * description: Stops the state machine timer, sets the state to UP
+ *   (unless it wasn't up yet). This function must be called BEFORE
  *   phy_detach.
  */
 void phy_stop_machine(struct phy_device *phydev)
@@ -433,9 +432,6 @@ void phy_stop_machine(struct phy_device 
 		phydev->state = PHY_UP;
 	spin_unlock(&phydev->lock);
 
-	if (phydev->irq != PHY_POLL)
-		phy_stop_interrupts(phydev);
-
 	phydev->adjust_state = NULL;
 }
 

