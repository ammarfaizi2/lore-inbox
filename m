Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755604AbWKWEEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbWKWEEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 23:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbWKWEEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 23:04:37 -0500
Received: from mail-sin.bigfish.com ([207.46.51.74]:13654 "EHLO
	mail98-sin-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1755573AbWKWEEg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 23:04:36 -0500
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Add IDE mode support for SB600 SATA
Date: Thu, 23 Nov 2006 12:04:20 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F3586020108CE6F@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add IDE mode support for SB600 SATA
Thread-Index: AccOp6BajH/1qDm3QAeMtzkZOwLiUgACwGKw
From: "Conke Hu" <conke.hu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       "Anatoli Antonovitch" <anatoli.antonovitch@amd.com>,
       "Jeff Garzik" <jeff@garzik.org>, "Tejun Heo" <htejun@gmail.com>
X-OriginalArrivalTime: 23 Nov 2006 04:04:26.0801 (UTC) FILETIME=[77ABFA10:01C70EB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Thursday, November 23, 2006 10:31 AM
To: Conke Hu
Cc: linux-kernel@vger.kernel.org; Anatoli Antonovitch; Jeff Garzik; Tejun Heo
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA

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

Automatically match the proper driver for different SATA/IDE modes of SB600 SATA controller: ahci for SATA/Native IDE/RAID modes and ATIIXP_IDE for legacy mode.

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
+	  PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8f, 0xffff05, board_ahci }, 
+/* ATI SB600 native IDE */
 	{ PCI_VDEVICE(ATI, 0x4381), board_ahci }, /* ATI SB600 raid */
 
 	/* VIA */
_

Hi Andrew,
	Thank you! I will re-write the patch since you think it is not reasonable.
	There were 3 patches for sb600 sata controller, including the one you listed, but none is accepted, so I will re-create the patch until it is accepted.
	(btw, I am sorry for using MS Outlook to reply this maillist. It seems we use different mail format, and I will switch to another email client next time.)

best regards,
conke



