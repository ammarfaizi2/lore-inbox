Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVLEIYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVLEIYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 03:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVLEIYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 03:24:30 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:45257 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932308AbVLEIY3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 03:24:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G/13+x+Xft09Bs4B7zM8eEIX6D8L1YBkLe4zEREyA5Xh3ZZ9kYz0A7C07M4cWyPz3hYn0B6SzRFCK1KVHwRXyxOKk0LAx9nK1ObZKP2jLayfjq4L1LTlYvM/557xiLatc4QBBwMUAHwQVDCZltpzJFRK2hh5QUtcigLpE8OU+Nc=
Message-ID: <58cb370e0512050024s647fdc5eg8d0c2e60dd7867dd@mail.gmail.com>
Date: Mon, 5 Dec 2005 09:24:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: ide: MODALIAS support for autoloading of ide-cd, ide-disk, ...
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
In-Reply-To: <20051203172418.GA12297@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203172418.GA12297@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks fine but what about ide-scsi driver and ide_optical media?

Bartlomiej

On 12/3/05, Kay Sievers <kay.sievers@vrfy.org> wrote:
> This applies on top of the changes currently in the -mm tree, which
> rename ".hotplug" to ".uevent". I don't have any IDE hardware left
> around here, so I've tested it only with a PCMCIA CF adapter. :)
>
> Thanks,
> Kay
>
>
>
> From: Kay Sievers <kay.sievers@suse.de>
>
> IDE: MODALIAS support for autoloading of ide-cd, ide-disk, ...
>
> Add MODULE_ALIAS to IDE midlayer modules to autoload them depending
> on the probed media type.
>
>   $ modinfo ide-disk
>   filename:       /lib/modules/2.6.15-rc4-g1b0997f5/kernel/drivers/ide/ide-disk.ko
>   description:    ATA DISK Driver
>   alias:          ide:*m-disk*
>   license:        GPL
>   ...
>
>   $ modprobe -vn ide:m-disk
>   insmod /lib/modules/2.6.15-rc4-g1b0997f5/kernel/drivers/ide/ide-disk.ko
>
>   $ cat /sys/bus/ide/devices/0.0/modalias
>   ide:m-disk
>
> It also adds attributes to the IDE device:
>   $ tree /sys/bus/ide/devices/0.0/
>   /sys/bus/ide/devices/0.0/
>   |-- bus -> ../../../../../../../bus/ide
>   |-- drivename
>   |-- media
>   |-- modalias
>   |-- power
>   |   |-- state
>   |   `-- wakeup
>   `-- uevent
>
>   $ cat /sys/bus/ide/devices/0.0/{modalias,drivename,media}
>   ide:m-disk
>   hda
>   disk
>
> Signed-off-by: Kay Sievers <kay.sievers@suse.de>
> ---
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 9455e42..24e3e64 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -3516,6 +3516,7 @@ static int __init ide_cdrom_init(void)
>         return driver_register(&ide_cdrom_driver.gen_driver);
>  }
>
> +MODULE_ALIAS("ide:*m-cdrom*");
>  module_init(ide_cdrom_init);
>  module_exit(ide_cdrom_exit);
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> index f4e3d35..06fb261 100644
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -1271,6 +1271,7 @@ static int __init idedisk_init(void)
>         return driver_register(&idedisk_driver.gen_driver);
>  }
>
> +MODULE_ALIAS("ide:*m-disk*");
>  module_init(idedisk_init);
>  module_exit(idedisk_exit);
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> index 9e293c8..fba3fff 100644
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -2197,6 +2197,7 @@ static int __init idefloppy_init(void)
>         return driver_register(&idefloppy_driver.gen_driver);
>  }
>
> +MODULE_ALIAS("ide:*m-floppy*");
>  module_init(idefloppy_init);
>  module_exit(idefloppy_exit);
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 7d7944e..a621548 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -4947,6 +4947,7 @@ out:
>         return error;
>  }
>
> +MODULE_ALIAS("ide:*m-tape*");
>  module_init(idetape_init);
>  module_exit(idetape_exit);
>  MODULE_ALIAS_CHARDEV_MAJOR(IDETAPE_MAJOR);
> diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
> index 8af179b..96d39a1 100644
> --- a/drivers/ide/ide.c
> +++ b/drivers/ide/ide.c
> @@ -1904,9 +1904,73 @@ static int ide_bus_match(struct device *
>         return 1;
>  }
>
> +static char *media_string(ide_drive_t *drive)
> +{
> +       switch (drive->media) {
> +       case ide_disk:
> +               return "disk";
> +       case ide_cdrom:
> +               return "cdrom";
> +       case ide_tape:
> +               return "tape";
> +       case ide_floppy:
> +               return "floppy";
> +       default:
> +               return "UNKNOWN";
> +       }
> +}
> +
> +static ssize_t media_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       ide_drive_t *drive = dev->driver_data;
> +       return sprintf(buf, "%s\n", media_string(drive));
> +}
> +
> +static ssize_t drivename_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       ide_drive_t *drive = dev->driver_data;
> +       return sprintf(buf, "%s\n", drive->name);
> +}
> +
> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +       ide_drive_t *drive = dev->driver_data;
> +       return sprintf(buf, "ide:m-%s\n", media_string(drive));
> +}
> +
> +static struct device_attribute ide_dev_attrs[] = {
> +       __ATTR_RO(media),
> +       __ATTR_RO(drivename),
> +       __ATTR_RO(modalias),
> +       __ATTR_NULL
> +};
> +
> +static int ide_uevent(struct device *dev, char **envp, int num_envp,
> +                     char *buffer, int buffer_size)
> +{
> +       ide_drive_t *drive = dev->driver_data;
> +       int i = 0;
> +       int length = 0;
> +
> +       add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
> +                      "MEDIA=%s", media_string(drive));
> +
> +       add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
> +                      "DRIVENAME=%s", drive->name);
> +
> +       add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
> +                      "MODALIAS=ide:m-%s",
> +                      media_string(drive));
> +
> +       envp[i] = NULL;
> +       return 0;
> +}
> +
>  struct bus_type ide_bus_type = {
>         .name           = "ide",
>         .match          = ide_bus_match,
> +       .uevent         = ide_uevent,
> +       .dev_attrs      = ide_dev_attrs,
>         .suspend        = generic_ide_suspend,
>         .resume         = generic_ide_resume,
>  };
