Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266500AbUFQNXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266500AbUFQNXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUFQNVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:21:36 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:7555 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266494AbUFQNUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:20:14 -0400
Date: Thu, 17 Jun 2004 22:21:27 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 2/4]Diskdump Update
In-reply-to: <20040617124957.GA31392@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <CCC4546DFE9D94indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040617124957.GA31392@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 13:49:57 +0100, Christoph Hellwig wrote:

>my old comments for this are still valid, please add the actual dumping
>methods directly to scsi_host_template instead of a pointer to another
>method vector, 

I have already done in the latest patch.

diff -Nur linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.c linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linux-2.6.6.org/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-04 21:22:20.000000000 +0900
+++ linux-2.6.6/drivers/scsi/aic7xxx/aic7xxx_osm.c	2004-06-16 19:34:16.000000000 +0900
@@ -774,6 +774,10 @@
 static int	   ahc_linux_bus_reset(Scsi_Cmnd *);
 static int	   ahc_linux_dev_reset(Scsi_Cmnd *);
 static int	   ahc_linux_abort(Scsi_Cmnd *);
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+static int	   ahc_linux_sanity_check(struct scsi_device *);
+static void	   ahc_linux_poll(struct scsi_device *);
+#endif
 
 /*
  * Calculate a safe value for AHC_NSEG (as expressed through ahc_linux_nseg).
@@ -1313,6 +1317,10 @@
 	.slave_alloc		= ahc_linux_slave_alloc,
 	.slave_configure	= ahc_linux_slave_configure,
 	.slave_destroy		= ahc_linux_slave_destroy,
+#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
+	.dump_sanity_check	= ahc_linux_sanity_check,
+	.dump_poll		= ahc_linux_poll,
+#endif
 };
 
 /**************************** Tasklet Handler *********************************/



>please make it not a module of it's own but part of the
>scsi code, 

Do you mean scsi_dump module should be merged with sd_mod.o or scsi_mod.o?

>please don't use "scsi.h" in new code, 

Oh, I missed it. Thanks.


>and the find gendisk
>by dev_t code in sd.c is still no good.

In the latest source, sd_find_scsi_device, which I added, does not use
dev_t. Here is the latest version.

struct scsi_device *sd_find_scsi_device(struct block_device *bdev)
{
	struct gendisk *disk = bdev->bd_disk;

	/* Check whether dev is scsi or not */
	if (!disk || (disk->fops != &sd_fops))
		return NULL;

	if(disk->private_data)
		return scsi_disk(disk)->device;
	else
		return NULL;
}

I'll try sysfs attribute instead of this.

>On Thu, 27 May 2004 14:48:40 +0100, Christoph Hellwig wrote:
>>Not the kind of interface we want exported.  IMHO you shouldn't find
>>device by dev_t but add a dumpdevice sysfs attribute to the scsi_device
>>where you can echo 1 to to make it a possible dump device.


Best Regards,
Takao Indoh
