Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVHPMx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVHPMx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVHPMx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:53:59 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:21127 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S965201AbVHPMx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:53:58 -0400
Message-ID: <4301E1AE.6010501@gmail.com>
Date: Tue, 16 Aug 2005 14:53:02 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.13-rc6] MODULE_DEVICE_TABLE for cpqfcTS driver
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508091806.45341@bilbo.math.uni-mannheim.de> <200508161111.08070@bilbo.math.uni-mannheim.de> <200508161111.35431@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508161111.35431@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer napsal(a):

>Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>
>--- a/drivers/scsi/cpqfcTSinit.c	2005-08-14 14:20:40.000000000 +0200
>+++ b/drivers/scsi/cpqfcTSinit.c	2005-08-14 14:25:33.000000000 +0200
>@@ -264,18 +264,14 @@ static void launch_FCworker_thread(struc
>  * Agilent XL2 
>  * HP Tachyon
>  */
>-#define HBA_TYPES 3
>-
>-#ifndef PCI_DEVICE_ID_COMPAQ_
>-#define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
>-#endif
>-
>-static struct SupportedPCIcards cpqfc_boards[] __initdata = {
>-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TACHYON},
>-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHLITE},
>-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHYON},
>+static struct pci_device_id cpqfc_boards[] __initdata = {
>+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TACHYON, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>+	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHLITE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>+	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHYON, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>+	{0, }
> };
>  
>
Wouldn't be better to use PCI_DEVICE macro for better readability?

> 
>+MODULE_DEVICE_TABLE(pci, cpqfc_boards);
> 
> int cpqfcTS_detect(Scsi_Host_Template *ScsiHostTemplate)
> {
>@@ -294,14 +290,9 @@ int cpqfcTS_detect(Scsi_Host_Template *S
>   ScsiHostTemplate->proc_name = "cpqfcTS";
> #endif
> 
>-  for( i=0; i < HBA_TYPES; i++)
>-  {
>-    // look for all HBAs of each type
>-
>-    while((PciDev = pci_find_device(cpqfc_boards[i].vendor_id,
>-				    cpqfc_boards[i].device_id, PciDev)))
>-    {
>-
>+  for(i = 0; cpqfc_boards[i]; i++) {
>+    while((PciDev = pci_get_device(cpqfc_boards[i].vendor,
>+				    cpqfc_boards[i].device, PciDev))) {
>       if (pci_enable_device(PciDev)) {
> 	printk(KERN_ERR
> 		"cpqfc: can't enable PCI device at %s\n", pci_name(PciDev));
>  
>
You maybe forgot to add pci_dev_put in error cases. You can inspire 
yourself here:
http://www.fi.muni.cz/~xslaby/lnx/pci_find/drivers:scsi:cpqfcTSinit.c.txt
(it wasn't accepted yet).

BTW. Greg KH wants me to cc him, if some of these changes are being done.

regards,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

