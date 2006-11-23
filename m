Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932832AbWKWCcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbWKWCcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 21:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbWKWCcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 21:32:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:24995 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932832AbWKWCcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 21:32:04 -0500
Date: Wed, 22 Nov 2006 18:31:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Conke Hu" <conke.hu@amd.com>
Cc: <linux-kernel@vger.kernel.org>, Anatoli Antonovitch <antonovi@ati.com>,
       Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
Message-Id: <20061122183122.1a137815.akpm@osdl.org>
In-Reply-To: <FFECF24D2A7F6D418B9511AF6F3586020108CD36@shacnexch2.atitech.com>
References: <FFECF24D2A7F6D418B9511AF6F3586020108CD36@shacnexch2.atitech.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 06:23:50 +0800
"Conke Hu" <conke.hu@amd.com> wrote:

> ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID. Legacy/Native IDE mode is designed for compatibility with some old OS without AHCI driver but looses SATAII/AHCI features such as NCQ. This patch provides users with two options when the SB600 SATA is set as IDE mode by BIOS:
> 1. Setting the controller back to AHCI mode and using ahci as its driver.
> 2. Using the controller as a normal IDE.
> What's more, without this patch, ahci driver always tries to claim all 4 modes of SB600 SATA, but fails in legacy IDE mode.
> 
> Signed-off-by: conke.hu@amd.com
> -------
> diff -Nur linux-2.6.19-rc6-git4.orig/drivers/ata/ahci.c linux-2.6.19-rc6-git4/drivers/ata/ahci.c
> --- linux-2.6.19-rc6-git4.orig/drivers/ata/ahci.c	2006-11-23 13:36:52.000000000 +0800
> +++ linux-2.6.19-rc6-git4/drivers/ata/ahci.c	2006-11-23 13:50:13.000000000 +0800
> @@ -323,7 +323,14 @@
>  	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci }, /* JMicron JMB366 */
>  
>  	/* ATI */
> +#ifdef CONFIG_SB600_AHCI_IDE
>  	{ PCI_VDEVICE(ATI, 0x4380), board_ahci }, /* ATI SB600 non-raid */
> +#else
> +	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_RAID<<8, 0xffff00, 
> +	  board_ahci },
> +	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, 0x010600, 0xffff00, 
> +	  board_ahci },
> +#endif

And your patch conflicts in mysterious ways with the below.

I've been sitting on this patch for three months.  I don't know why.


From: "Anatoli Antonovitch" <antonovi@ati.com>

Automatically match the proper driver for different SATA/IDE modes of SB600
SATA controller: ahci for SATA/Native IDE/RAID modes and ATIIXP_IDE for legacy
mode.

Signed-off-by: Anatoli Antonovitch <antonovi@ati.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/ahci.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/ata/ahci.c~ahci-ati-sb600-sata-support-for-various-modes drivers/ata/ahci.c
--- a/drivers/ata/ahci.c~ahci-ati-sb600-sata-support-for-various-modes
+++ a/drivers/ata/ahci.c
@@ -323,7 +323,12 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci }, /* JMicron JMB366 */
 
 	/* ATI */
-	{ PCI_VDEVICE(ATI, 0x4380), board_ahci }, /* ATI SB600 non-raid */
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
+	  PCI_ANY_ID, 0x010600, 0xffff00, board_ahci }, /* ATI SB600 AHCI */
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
+	  PCI_ANY_ID, 0x010400, 0xffff00, board_ahci }, /* ATI SB600 raid */
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
+	  PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8f, 0xffff05, board_ahci }, /* ATI SB600 native IDE */
 	{ PCI_VDEVICE(ATI, 0x4381), board_ahci }, /* ATI SB600 raid */
 
 	/* VIA */
_

