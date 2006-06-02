Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWFBTz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWFBTz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWFBTz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:55:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59088 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751450AbWFBTz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:55:26 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 21:53:39 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 06/18] ieee1394/ohci1394: CycleTooLong
 interrupt management
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>,
       Jean-Baptiste Mur <jeanbaptiste@maunakeatech.com>
In-Reply-To: <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
Message-ID: <tkrat.f35772c971022262@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.885) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the ohci1394.c file to enable and manage the "cycle too 
long" interrupt. 
If this interrupt occurs, the "LinkControl.CycleMaster" bit of the host 
controller is reseted. This implies, that the host controller does not send 
"cycle start" packet anymore freezing then the isochronous communication. 
The management of the interrupt added by the patch is that when the interrupt 
occurs, the OHCI irq handler prints a kernel log warning and then sets the 
"LinkControl.CycleMaster" bit again resuming the isochronous communication.

Signed-off-by: Jean-Baptiste Mur <jeanbaptiste@maunakeatech.com>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/ohci1394.c	2006-06-01 20:55:39.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/ohci1394.c	2006-06-01 20:55:41.000000000 +0200
@@ -580,6 +580,7 @@ static void ohci_initialize(struct ti_oh
 		  OHCI1394_isochRx |
 		  OHCI1394_isochTx |
 		  OHCI1394_postedWriteErr |
+		  OHCI1394_cycleTooLong |
 		  OHCI1394_cycleInconsistent);
 
 	/* Enable link */
@@ -2386,6 +2387,15 @@ static irqreturn_t ohci_irq_handler(int 
 		PRINT(KERN_ERR, "physical posted write error");
 		/* no recovery strategy yet, had to involve protocol drivers */
 	}
+	if (event & OHCI1394_cycleTooLong) {
+		if(printk_ratelimit())
+			PRINT(KERN_WARNING, "isochronous cycle too long");
+		else
+			DBGMSG("OHCI1394_cycleTooLong");
+		reg_write(ohci, OHCI1394_LinkControlSet,
+			  OHCI1394_LinkControl_CycleMaster);
+		event &= ~OHCI1394_cycleTooLong;
+	}
 	if (event & OHCI1394_cycleInconsistent) {
 		/* We subscribe to the cycleInconsistent event only to
 		 * clear the corresponding event bit... otherwise,


