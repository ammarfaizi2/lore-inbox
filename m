Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWDNPm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDNPm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 11:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDNPm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 11:42:56 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:49326 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1750756AbWDNPmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 11:42:55 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] pcmcia/pcmcia_resource.c: fix crash when using Cardbus cards
Date: Fri, 14 Apr 2006 17:42:13 +0200
User-Agent: KMail/1.7.2
Cc: linux-pcmcia@lists.infradead.org,
       "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141742.13553.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 1377;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] pcmcia/pcmcia_resource.c: fix crash when using Cardbus cards

using the old ioctl interface together with cardbus card gives a NULL
pointer dereference since cardbus devices don't have a struct pcmcia_device.
also s->io[0].res can be NULL as well.

fix is to move the pcmcia code after the cardbus code and to check for a null
pointer.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index 45063b4..6572f07 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -209,7 +209,6 @@ int pccard_get_configuration_info(struct
 	if (!(s->state & SOCKET_PRESENT))
 		return CS_NO_CARD;
 
-	config->Function = p_dev->func;
 
 #ifdef CONFIG_CARDBUS
 	if (s->state & SOCKET_CARDBUS) {
@@ -223,14 +222,22 @@ #ifdef CONFIG_CARDBUS
 			config->AssignedIRQ = s->irq.AssignedIRQ;
 			if (config->AssignedIRQ)
 				config->Attributes |= CONF_ENABLE_IRQ;
-			config->BasePort1 = s->io[0].res->start;
-			config->NumPorts1 = s->io[0].res->end - config->BasePort1 + 1;
+			if (s->io[0].res) {
+				config->BasePort1 = s->io[0].res->start;
+				config->NumPorts1 = s->io[0].res->end - config->BasePort1 + 1;
+			}
 		}
 		return CS_SUCCESS;
 	}
 #endif
 
-	c = (p_dev) ? p_dev->function_config : NULL;
+	if (p_dev) {
+		c = p_dev->function_config;
+		config->Function = p_dev->func;
+	} else {
+		c = NULL;
+		config->Function = 0;
+	}
 
 	if ((c == NULL) || !(c->state & CONFIG_LOCKED)) {
 		config->Attributes = 0;
