Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWHYO14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWHYO14 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHYO1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:27:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40336 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751102AbWHYO1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:27:54 -0400
Date: Fri, 25 Aug 2006 15:27:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060825142753.GK10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/char/random.c
> @@ -655,6 +655,7 @@ void add_interrupt_randomness(int irq)
>  	add_timer_randomness(irq_timer_state[irq], 0x100 + irq);
>  }
>  
> +#ifdef CONFIG_BLOCK
>  void add_disk_randomness(struct gendisk *disk)
>  {
>  	if (!disk || !disk->random)
> @@ -667,6 +668,7 @@ void add_disk_randomness(struct gendisk 
>  }
>  
>  EXPORT_SYMBOL(add_disk_randomness);
> +#endif
>  
>  #define EXTRACT_SIZE 10
>  
> @@ -918,6 +920,7 @@ void rand_initialize_irq(int irq)
>  	}
>  }
>  
> +#ifdef CONFIG_BLOCK
>  void rand_initialize_disk(struct gendisk *disk)
>  {
>  	struct timer_rand_state *state;
> @@ -932,6 +935,7 @@ void rand_initialize_disk(struct gendisk
>  		disk->random = state;
>  	}
>  }
> +#endif

Can you put this two into a single ifdef block?

> index fead87d..f945953 100644
> --- a/drivers/infiniband/ulp/iser/Kconfig
> +++ b/drivers/infiniband/ulp/iser/Kconfig
> @@ -1,6 +1,6 @@
>  config INFINIBAND_ISER
>  	tristate "ISCSI RDMA Protocol"
> -	depends on INFINIBAND && SCSI
> +	depends on INFINIBAND && BLOCK && SCSI

SCSI should (and does in your patch) depend on BLOCK, so you don't
need this additional dependency.

> -	depends on INFINIBAND && SCSI
> +	depends on INFINIBAND && BLOCK && SCSI

ditto.

>  config BLK_DEV_SD
>  	tristate "SCSI disk support"
> -	depends on SCSI
> +	depends on SCSI && BLOCK

ditto.

>  config BLK_DEV_SR
>  	tristate "SCSI CDROM support"
> -	depends on SCSI
> +	depends on SCSI && BLOCK

ditto.

>  config SCSI_SATA
>  	tristate "Serial ATA (SATA) support"
> -	depends on SCSI
> +	depends on SCSI && BLOCK

ditto.

>  config USB_STORAGE
>  	tristate "USB Mass Storage support"
> -	depends on USB
> +	depends on USB && BLOCK

ditto.

> index 3f00a9f..dc5e69b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -4,6 +4,8 @@ #
>  
>  menu "File systems"
>  
> +if BLOCK
> +
>  config EXT2_FS
>  	tristate "Second extended fs support"
>  	help
> @@ -383,8 +385,11 @@ config MINIX_FS
>  	  partition (the one containing the directory /) cannot be compiled as
>  	  a module.
>  
> +endif
> +
>  config ROMFS_FS
>  	tristate "ROM file system support"
> +	depends on BLOCK

care to group all block-based filesystem in a group so that a single
if BLOCK will do it?

> +ifeq ($(CONFIG_BLOCK),y)
> +obj-y +=	buffer.o bio.o block_dev.o direct-io.o mpage.o ioprio.o
> +else
> +obj-y +=	no-block.o
> +endif
>  
>  obj-$(CONFIG_INOTIFY)		+= inotify.o
>  obj-$(CONFIG_INOTIFY_USER)	+= inotify_user.o

> index 7b8a9b4..af160e9 100644
> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -645,6 +645,7 @@ out:
>  }
>  #endif
>  
> +#ifdef CONFIG_BLOCK
>  struct hd_geometry32 {
>  	unsigned char heads;
>  	unsigned char sectors;
> @@ -869,6 +870,7 @@ static int sg_grt_trans(unsigned int fd,
>  	}
>  	return err;
>  }
> +#endif /* CONFIG_BLOCK */

again, try to reorder things here to only require a single ifdef block
(or rather two, a second one for the array entries) if possible.

> --- /dev/null
> +++ b/fs/no-block.c
> @@ -0,0 +1,22 @@
> +/* no-block.c: implementation of routines required for non-BLOCK configuration
> + *
> + * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/fs.h>
> +
> +static int no_blkdev_open(struct inode * inode, struct file * filp)
> +{
> +	return -ENODEV;
> +}
> +
> +const struct file_operations def_blk_fops = {
> +	.open		= no_blkdev_open,
> +};

Can we put this into some other file under #ifndef CONFIG_BLOCK to
avoid the separate file and makefile ugliness?

> diff --git a/include/scsi/scsi_tcq.h b/include/scsi/scsi_tcq.h
> index e47e36a..bc34746 100644
> --- a/include/scsi/scsi_tcq.h
> +++ b/include/scsi/scsi_tcq.h
> @@ -5,7 +5,6 @@ #include <linux/blkdev.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_device.h>
>  
> -
>  #define MSG_SIMPLE_TAG	0x20
>  #define MSG_HEAD_TAG	0x21
>  #define MSG_ORDERED_TAG	0x22
> @@ -13,6 +12,7 @@ #define MSG_ORDERED_TAG	0x22
>  #define SCSI_NO_TAG	(-1)    /* identify no tag in use */
>  
>  
> +#ifdef CONFIG_BLOCK
>  
>  /**
>   * scsi_get_tag_type - get the type of tag the device supports
> @@ -131,4 +131,5 @@ static inline struct scsi_cmnd *scsi_fin
>  	return sdev->current_cmnd;
>  }
>  
> +#endif /* CONFIG_BLOCK */
>  #endif /* _SCSI_SCSI_TCQ_H */

No one should include this file unless block device support is enabled,
so I don't see the point for the ifdefs.  Ditto for many other header
files you touch that don't contain any stubs for generic code.


And btw, shouldn't the option be CONFIG_BLK_DEV instead of CONFIG_BLOCK
to fit the variour CONFIG_BLK_DEV_FOO options we have?
