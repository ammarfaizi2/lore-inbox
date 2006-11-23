Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932929AbWKWC0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbWKWC0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 21:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932932AbWKWC0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 21:26:24 -0500
Received: from smtp.osdl.org ([65.172.181.25]:15778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932929AbWKWC0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 21:26:24 -0500
Date: Wed, 22 Nov 2006 18:26:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Conke Hu" <conke.hu@amd.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
Message-Id: <20061122182610.4d9f3d98.akpm@osdl.org>
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
>  	{ PCI_VDEVICE(ATI, 0x4381), board_ahci }, /* ATI SB600 raid */

I doubt if it's appropriate to do all this via ifdefs.  Users don't compile
their kernels - others compile them for the users.  We need the one kernel
binary to support both modes.   Possible?
