Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWHRFVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWHRFVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 01:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWHRFVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 01:21:48 -0400
Received: from mail.mailmij.org ([82.93.140.149]:29915 "EHLO mail.mailmij.org")
	by vger.kernel.org with ESMTP id S932250AbWHRFVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 01:21:48 -0400
Date: Fri, 18 Aug 2006 07:21:43 +0200
From: danny@mailmij.org
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net
Subject: [PATCH] fix for recently added firewire patch that breaks things on ppc
Message-ID: <20060818072143.A32418@luna.ellen.dexterslabs.com>
References: <20060805151050.B24484@luna.ellen.dexterslabs.com> <1155118273.4040.81.camel@localhost.localdomain> <20060809151226.A31391@luna.ellen.dexterslabs.com> <1155201211.17187.128.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1155201211.17187.128.camel@localhost.localdomain>; from benh@kernel.crashing.org on Thu, Aug 10, 2006 at 11:13:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Recently a patch was added for preliminary suspend/resume 
    handling on !PPC_PMAC. However, this broke both suspend and firewire
    on powerpc because it saves the pci state after the device has already
    been disabled.
 
    This moves the save state to before the pmac specific code.
    Please apply before 2.6.18.

    Signed-off-by: Danny Tholen <obiwan at mailmij.org>

--- linux-2.6.17.7/drivers/ieee1394/ohci1394.c~ 2006-08-09 09:00:32.556422070 -0400
+++ linux-2.6.17.7/drivers/ieee1394/ohci1394.c  2006-08-09 09:02:53.546090923 -0400
@@ -3548,6 +3548,8 @@
 
 static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
+	pci_save_state(pdev);
+
 #ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
 		struct device_node *of_node;
@@ -3559,8 +3561,6 @@
 	}
 #endif
 
-	pci_save_state(pdev);
-
 	return 0;
 } 
