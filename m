Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUKHFQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUKHFQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 00:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKHFQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 00:16:09 -0500
Received: from jpnmailout01.yamato.ibm.com ([203.141.80.81]:38313 "EHLO
	jpnmailout01.yamato.ibm.com") by vger.kernel.org with ESMTP
	id S261766AbUKHFPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 00:15:51 -0500
In-Reply-To: <1099887081.1750.249.camel@sli10-desk.sh.intel.com>
Subject: Re: [ACPI] [PATCH/RFC 4/4]An experimental implementation for IDE bus
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, Greg <greg@kroah.com>,
       Len Brown <len.brown@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
X-Mailer: Lotus Notes Release 6.0.2CF2 July 23, 2003
Message-ID: <OFD9746A61.227E41CC-ON49256F46.001B0F2E-49256F46.001CE593@jp.ibm.com>
From: Hiroshi 2 Itoh <HIROIT@jp.ibm.com>
Date: Mon, 8 Nov 2004 14:15:10 +0900
X-MIMETrack: Serialize by Router on D19ML115/19/M/IBM(Release 6.51HF338 | June 21, 2004) at
 2004/11/08 14:15:12
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi, Li-san

Thanks for your framework. It's one of patches what I really want.

My test machine has SATA controller and works with ata_piix driver with no
.suspend and .resume entry while ide.c has them.

The first thing I did is to create them and add some function calls to save
and restore the device specific PCI configuration space.
But then I had no idea how to execute ACPI's IDE specific method like _GTM,
_STM.

As I am not familiar with IDE driver too, I hope the module owner will
change ata_piix source to support .suspend, .resume, .platform_bind entries
soon.

Regards, Hiro.

acpi-devel-admin@lists.sourceforge.net wrote on 2004/11/08 13:11:47:
> Hi,
> A sample patch to bind IDE devices. I'm not familar with IDE driver, so
> the patch possibly is completely wrong, though it can show correct ACPI
> path in my laptop. This test case just shows the framework works, please
> don't apply it.
>
> Thanks,
> Shaohua
> ---
>
>  2.6-root/drivers/ide/ide.c |   43
> +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 43 insertions(+)
>
> diff -puN drivers/ide/ide.c~ide-bind-acpi drivers/ide/ide.c
> --- 2.6/drivers/ide/ide.c~ide-bind-acpi   2004-11-08 11:09:12.625009440
> +0800
> +++ 2.6-root/drivers/ide/ide.c   2004-11-08 11:10:04.477126720 +0800
> @@ -2412,10 +2412,53 @@ EXPORT_SYMBOL(ide_fops);
>
>  EXPORT_SYMBOL(ide_lock);
>
> +#ifdef CONFIG_ACPI
> +#include <linux/acpi.h>
> +int generic_ide_platform_bind(struct device *dev)
> +{
> +   acpi_handle parent_handle = NULL;
> +   acpi_integer address;
> +   int i;
> +
> +   /* Seems dev->parent->parent is the PCI IDE controller */
> +        if (dev->parent && dev->parent->parent)
> +                parent_handle = dev->parent->parent->handle;
> +
> +   if (!parent_handle) {
> +      printk("Can't find parent handle \n");
> +      return -1;
> +   }
> +   /* Please ref to ACPI spec for syntax of _ADR */
> +   sscanf(dev->bus_id, "%d", &i);
> +   address = i;
> +   dev->handle = acpi_get_child(parent_handle, address);
> +
> +#if 1
> +       {/* For debug */
> +               char            name[80] = {'?','\0'};
> +               struct acpi_buffer      buffer = {sizeof(name), name};
> +
> +               printk("IDE device %d:", i);
> +               if (dev->handle) {
> +                       acpi_get_name(dev->handle, ACPI_FULL_PATHNAME,
> &buffer);
> +                       printk("%s", name);
> +               }
> +               printk("\n");
> +       }
> +#endif
> +   return 0;
> +}
> +#else
> +int generic_ide_platform_bind(struct device *dev)
> +{
> +   return 0;
> +}
> +#endif
>  struct bus_type ide_bus_type = {
>     .name      = "ide",
>     .suspend   = generic_ide_suspend,
>     .resume      = generic_ide_resume,
> +   .platform_bind   = generic_ide_platform_bind,
>  };
>
>  /*
> _
>

