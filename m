Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWGIXMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWGIXMV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 19:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWGIXMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 19:12:21 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:273 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932520AbWGIXMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 19:12:20 -0400
Date: Mon, 10 Jul 2006 01:12:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: Miles Lane <miles.lane@gmail.com>,
       "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de,
       linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
Message-ID: <20060709231218.GU13938@stusta.de>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF9E7@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECF9E7@hdsmsx411.amr.corp.intel.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 07:03:23PM -0400, Brown, Len wrote:
> 
> >It would be a solution to let HOTPLUG_PCI_ACPI depend on
> >(ACPI_DOCK || ACPI_DOCK=n), or the #if in 
> >include/acpi/acpi_drivers.h could be changed to
> >#if defined(CONFIG_ACPI_DOCK) || 
> >(defined(CONFIG_ACPI_DOCK_MODULE) && defined(MODULE))
> 
> CONFIG_HOTPLUG_PCI_ACPI requires CONFIG_ACPI_DOCK.
> There are 9 combinations.
> 
> DOCK	HPA
> n	n	ok
> n	y	illegal
> n	m	illegal
> y	n	ok
> y	y	ok
> y	m	ok
> m	n	ok
> m	y	illegal (subject of this thread)
> m	m	ok
> 
> The patch below handles all these cases:
> 
> DOCK	HPA
> n	n	builds
> n	y	-> y,y
> n	m	-> m,m
> y	n	builds
> y	y	builds
> y	m	builds
> m	n	builds
> m	y	-> m,y
> m	m	builds
> 
> okay?

This patch looks wrong since it allows the illegal configuration
ACPI_IBM_DOCK=y, HOTPLUG_PCI_ACPI=y/m, ACPI_DOCK=y/m.

If you select something, you have to ensure the dependencies of what you 
are select'ing are fulfilled.

config HOTPLUG_PCI_ACPI
	tristate "ACPI PCI Hotplug driver"
	depends on ACPI && HOTPLUG_PCI
	depends on !ACPI_IBM_DOCK
	select ACPI_DOCK
	help
	  ...

> -Len
> 
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 222a1cc..e7c955b 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -78,6 +78,7 @@ config HOTPLUG_PCI_IBM
>  config HOTPLUG_PCI_ACPI
>  	tristate "ACPI PCI Hotplug driver"
>  	depends on ACPI && HOTPLUG_PCI
> +	select ACPI_DOCK
>  	help
>  	  Say Y here if you have a system that supports PCI Hotplug
> using
>  	  ACPI.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

