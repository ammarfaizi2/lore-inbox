Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967053AbWKVDn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967053AbWKVDn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 22:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967055AbWKVDn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 22:43:57 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50153 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S967053AbWKVDn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 22:43:57 -0500
Message-ID: <4563C775.8020004@garzik.org>
Date: Tue, 21 Nov 2006 22:43:49 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Barkalow <barkalow@iabervon.org>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, Roland Dreier <rdreier@cisco.com>,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [PATCH] Disable INTx when enabling MSI in forcedeth
References: <Pine.LNX.4.64.0611212118540.20138@iabervon.org> <Pine.LNX.4.64.0611211839540.3338@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611211839540.3338@woody.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090504000307070304090506"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090504000307070304090506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Tue, 21 Nov 2006, Daniel Barkalow wrote:
>> My nVidia ethernet card doesn't disable its own INTx when MSI is
>> enabled. This causes a steady stream of spurious interrupts that
>> eventually kills my SATA IRQ if MSI is used with forcedeth, which is
>> true by default. Simply disabling the INTx interrupt takes care of it.
>>
>> This is against -stable, and would be suitable once someone who knows the 
>> code verifies that it's correct.
> 
> I _really_ think that we should do this in pci_msi_enable().
> 
> Screw cards that are not PCI-2.3 compliant - just make the rule be that if 
> you use MSI, you _have_ to allow us to set the disable-INTx bit. It's then 
> up to the drivers to decide if they can use MSI or not.
> 
> (Even a number of cards that are not PCI-2.3 may simply not _implement_ 
> the disable-INTx bit, and in that case, they can use MSI if they disable 
> INTx automatically - the ).
> 
> Comments?

I agree.  And it's just a simple matter of remove the PCI-Express 
brackets AFAICS, like in the attached patch (untested).

	Jeff




--------------090504000307070304090506
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9fc9a34..c2828a3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -255,10 +255,8 @@ static void enable_msi_mode(struct pci_d
 		pci_write_config_word(dev, msi_control_reg(pos), control);
 		dev->msix_enabled = 1;
 	}
-    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
-		/* PCI Express Endpoint device detected */
-		pci_intx(dev, 0);  /* disable intx */
-	}
+
+	pci_intx(dev, 0);  /* disable intx */
 }
 
 void disable_msi_mode(struct pci_dev *dev, int pos, int type)
@@ -276,10 +274,8 @@ void disable_msi_mode(struct pci_dev *de
 		pci_write_config_word(dev, msi_control_reg(pos), control);
 		dev->msix_enabled = 0;
 	}
-    	if (pci_find_capability(dev, PCI_CAP_ID_EXP)) {
-		/* PCI Express Endpoint device detected */
-		pci_intx(dev, 1);  /* enable intx */
-	}
+
+	pci_intx(dev, 1);  /* enable intx */
 }
 
 static int msi_lookup_irq(struct pci_dev *dev, int type)

--------------090504000307070304090506--
