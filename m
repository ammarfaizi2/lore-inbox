Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSLMJqS>; Fri, 13 Dec 2002 04:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSLMJqS>; Fri, 13 Dec 2002 04:46:18 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:33736
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261799AbSLMJqP>; Fri, 13 Dec 2002 04:46:15 -0500
Subject: Re: 2.5.51 ide module problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Jeff Chua <jchua@fedex.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rusty@rustcorp.com.au
In-Reply-To: <20021212235934.A770@baldur.yggdrasil.com>
References: <200212110650.WAA13780@adam.yggdrasil.com>
	<Pine.LNX.4.50.0212111501310.30173-100000@boston.corp.fedex.com>
	<20021211004104.A362@baldur.yggdrasil.com>
	<Pine.LNX.4.50.0212111711180.4632-200000@boston.corp.fedex.com> 
	<20021212235934.A770@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Dec 2002 10:31:48 +0000
Message-Id: <1039775508.25121.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 07:59, Adam J. Richter wrote:

> --- linux-2.5.51/drivers/pci/pci.c	2002-12-09 18:45:52.000000000 -0800
> +++ linux/drivers/pci/pci.c	2002-12-09 19:03:18.000000000 -0800
> @@ -736,6 +736,7 @@
>  EXPORT_SYMBOL(isa_bridge);
>  #endif
>  
> +EXPORT_SYMBOL(pci_enable_device_bars);
>  EXPORT_SYMBOL(pci_enable_device);
>  EXPORT_SYMBOL(pci_disable_device);
>  EXPORT_SYMBOL(pci_max_busnr);

This one looks correct.

> diff -r -u linux-2.5.51/drivers/ide/Kconfig linux/drivers/ide/Kconfig
> --- linux-2.5.51/drivers/ide/Kconfig	2002-12-09 18:45:56.000000000 -0800
> +++ linux/drivers/ide/Kconfig	2002-11-27 18:23:46.000000000 -0800
> @@ -199,7 +199,7 @@
>  	depends on BLK_DEV_IDE
>  
>  config BLK_DEV_CMD640
> -	bool "CMD640 chipset bugfix/support"
> +	tristate "CMD640 chipset bugfix/support"

Please don't do this. You can't "load" the workaround meaningfully for
this device

>  config BLK_DEV_GENERIC
> -	bool "Generic PCI IDE Chipset Support"
> +	tristate "Generic PCI IDE Chipset Support"
>  	depends on PCI && BLK_DEV_IDEPCI

Probably ok. I need to review that.

> -obj-$(CONFIG_BLK_DEV_IDE)		+= ide-io.o ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o
> +obj-$(CONFIG_BLK_DEV_IDE)		+= ide-mod.o
> +ide-mod-objs				+= ide-io.o ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o

Looks ok

> diff -r -u linux-2.5.51/drivers/ide/pci/cmd640.c linux/drivers/ide/pci/cmd640.c
> --- linux-2.5.51/drivers/ide/pci/cmd640.c	2002-12-09 18:46:22.000000000 -0800
> +++ linux/drivers/ide/pci/cmd640.c	2002-11-27 18:24:00.000000000 -0800
> @@ -102,6 +102,7 @@

No (as per comment above)


> --- linux-2.5.51/drivers/ide/ide-probe.c	2002-12-09 18:46:10.000000000 -0800
> +++ linux/drivers/ide/ide-probe.c	2002-12-12 23:50:58.000000000 -0800
> @@ -831,7 +831,8 @@
>  	ide_toggle_bounce(drive, 1);
>  
>  #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
> -	HWIF(drive)->ide_dma_queued_on(drive);
> +	if (HWIF(drive)->ide_dma_queued_on)
> +		HWIF(drive)->ide_dma_queued_on(drive);

Looks right




At a first glance (and its only that), drop out the CMD640 changes and
the rest seems ok. Please check it on a few setups and also non modular
since you've changed the probe bits a little.

Alan

