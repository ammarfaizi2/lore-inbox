Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbULNQRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbULNQRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbULNQRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:17:20 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:47034 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261546AbULNQP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:15:27 -0500
Message-ID: <41BF119A.4070002@keyaccess.nl>
Date: Tue, 14 Dec 2004 17:15:22 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.10-rc2+] ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED
 SOON!
References: <41B36021.5050600@keyaccess.nl> <58cb370e04121313473057143b@mail.gmail.com>
In-Reply-To: <58cb370e04121313473057143b@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------090505080608010502060200"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090505080608010502060200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bartlomiej Zolnierkiewicz wrote:

>>I do need a way to force an 80c cable on this AMD756 (ATA66 max) board,
>>since the BIOS doesn't seem to be setting the cable bits correctly.
> 
> 
> Ugh, I checked AMD datasheets and AMD756 doesn't support host
> side cable detection.  Well, we can try doing disk side only for it.
> [ ATi and ITE (in -ac kernels) drivers are also doing this. ]
> 
> --- amd74xx.c.orig	2004-11-02 14:17:14.000000000 +0100
> +++ amd74xx.c	2004-12-13 22:41:50.406229168 +0100
> @@ -344,10 +344,8 @@
>  			break;
>  
>  		case AMD_UDMA_66:
> -			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
> -			for (i = 24; i >= 0; i -= 8)
> -				if ((u >> i) & 4)
> -					amd_80w |= (1 << (1 - (i >> 4)));
> +			/* no host side cable detection */
> +			amd_80w = 0x03;
>  			break;
>  	}
> 

Well, yes, works for me I guess. Was playing around to see if I could 
find something a bit more subtle but it seems nothing's available. My 
BIOS does show hdc (a DVD-ROM by the way) to be udma4 in its summary 
screen but it does not enable udma for it. I saw AMD_DRIVE_TIMINGS is 
not used for udma (and programmed by my BIOS to the highest PIO mode the 
device offers for all devices present) so also of no use...

Attached patch combines this and deleting a "use ide0=ata66" advice from 
the driver.

One slight cosmetic problem, with amd_80w set unconditionally the 
/proc/ide/amd74xx file's "cable type" line will now always show "80w" 
and seems likely to confuse people that have 40w cables installed. I 
believe the proc file may be on its way out anyway? If not, one option 
could be to print "n/a" for amd_config->flags & AMD_UDMA == AMD_UDMA_66 
(<= ?).

Rene.

--------------090505080608010502060200
Content-Type: text/x-patch;
 name="linux-2.6.10-rc3_ata66.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.10-rc3_ata66.diff"

--- linux-2.6.10-rc3/drivers/ide/pci/amd74xx.c.orig	2004-12-14 11:33:21.000000000 +0100
+++ linux-2.6.10-rc3/drivers/ide/pci/amd74xx.c	2004-12-14 16:31:22.000000000 +0100
@@ -344,10 +344,8 @@
 			break;
 
 		case AMD_UDMA_66:
-			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
-			for (i = 24; i >= 0; i -= 8)
-				if ((u >> i) & 4)
-					amd_80w |= (1 << (1 - (i >> 4)));
+			/* no host side cable detection */
+			amd_80w = 0x03;
 			break;
 	}
 
@@ -383,8 +381,6 @@
 	if (amd_clock < 20000 || amd_clock > 50000) {
 		printk(KERN_WARNING "%s: User given PCI clock speed impossible (%d), using 33 MHz instead.\n",
 			amd_chipset->name, amd_clock);
-		printk(KERN_WARNING "%s: Use ide0=ata66 if you want to assume 80-wire cable\n",
-			amd_chipset->name);
 		amd_clock = 33333;
 	}
 

--------------090505080608010502060200--
