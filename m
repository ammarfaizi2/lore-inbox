Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265758AbUE1CMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265758AbUE1CMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 22:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbUE1CMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 22:12:50 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:34955 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265758AbUE1CMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 22:12:43 -0400
Date: Fri, 28 May 2004 11:13:56 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [2/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040527134840.GA15356@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <26C444596DF2D3indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040527134840.GA15356@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for many comments.
I am updating files now...

Best Regards,
Takao Indoh


>On Thu, May 27, 2004 at 09:37:30PM +0900, Takao Indoh wrote:
>>  obj-$(CONFIG_BLK_DEV_SR)	+= sr_mod.o
>>  obj-$(CONFIG_CHR_DEV_SG)	+= sg.o
>>  
>> +obj-$(CONFIG_SCSI_DUMP)         += scsi_dump.o
>
>please use tabs instead of space here.
>
>> @@ -691,6 +691,10 @@
>>  {
>>  	unsigned long flags;
>>  
>> +#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
>> +	if (crashdump_mode())
>> +		return;
>> +#endif
>
>Please make sure crashdump_mode() is always defined so you don't need the
>ifdef mess.
>
>> +#include <linux/config.h>
>
>not needed.
>
>> +#include "scsi.h"
>
>please don't use this in new code, use the include/scsi/*.h includes
>instead.
>
>> +#include "scsi_priv.h"
>
>this is a private header for scsi_mod.ko as the name might suggest ;)
>But given the rather strange exports I'd suggest to always build
>scsi_dump.c into scsi_mod.ko anyway.
>
>> +#include "hosts.h"
>
>Please use <scsi/scsi_host.h>
>
>> +#include "scsi_dump.h"
>> +#include <scsi/scsi_ioctl.h>
>> +
>> +#include <linux/genhd.h>
>> +#include <linux/utsname.h>
>> +#include <linux/crc32.h>
>> +#include <linux/diskdump.h>
>> +#include <linux/diskdumplib.h>
>> +#include <linux/delay.h>
>
>please rework the include order, <linux/*.h> first, then <asm/*.h>,
>then <scsi/*.h>, then private headers.
>
>> +#define DEBUG 0
>> +#if DEBUG
>> +# define Dbg(x, ...) printk(KERN_INFO "scsi_dump:" x "\n", ## __VA_ARGS__)
>> +#else
>> +# define Dbg(x...)
>> +#endif
>> +
>> +#define Err(x, ...)	printk(KERN_ERR "scsi_dump: " x "\n", ## __VA_ARGS__);
>> +#define Warn(x, ...)	printk(KERN_WARNING "scsi_dump: " x "\n", ## 
>> __VA_ARGS__)
>> +#define Info(x, ...)	printk(x "\n", ## __VA_ARGS__)
>
>please use the pr_* macros from kernel.h
>
>
>> +static int quiesce_ok = 0;
>
>on need to initialize to 0
>
>> +static Scsi_Cmnd scsi_dump_cmnd;
>> +static struct request scsi_dump_req;
>> +static uint32_t module_crc;
>> +
>> +static void rw_intr(Scsi_Cmnd * scmd)
>
>Please never use the Scsi_Foo types but the struct scsi_foo versions
>(goes hand in hand with using <scsi/*.h>
>
>> +static void init_scsi_command(Scsi_Device *sdev, Scsi_Cmnd *scmd, void *
>> buf, int len, unsigned char direction, int set_lun)
>
>plese make sure lines aren't longer than 80 characters.
>
>> +	if (!spin_is_locked(host->host_lock)) {
>> +		sanity = 0;
>> +	} else {
>> +		Warn("host_lock is held: host %d channel %d id %d lun %d",
>> +				host->host_no, sdev->channel, sdev->id, sdev->
lun);
>> +		if (host->host_lock == &host->default_lock)
>> +			sanity = 1;
>> +		else
>> +			return -EIO;
>> +	}
>
>This look bogus to me.  Why handle the case of the default and per-driver
>lock differently?
>
>> +static int scsi_dump_add_device(struct disk_dump_device *dump_device)
>> +{
>> +	Scsi_Device *sdev;
>> +
>> +	sdev = dump_device->device;
>> +	if (!sdev->host->hostt->dump_ops)
>> +		return -ENOTSUPP;
>> +
>> +	scsi_device_get(sdev);  /* retval ignored ? */
>
>Please fix this ;-)
>
>> diff -Nur linux-2.6.6.org/drivers/scsi/scsi_dump.h linux-2.6.6/drivers/
>> scsi/scsi_dump.h
>> --- linux-2.6.6.org/drivers/scsi/scsi_dump.h	1970-01-01 09:00:00.
>> 000000000 +0900
>> +++ linux-2.6.6/drivers/scsi/scsi_dump.h	2004-05-27 09:31:07.000000000 +

>> 0900
>> @@ -0,0 +1,38 @@
>> +#ifndef _SCSI_DUMP_H
>> +#define _SCSI_DUMP_H
>
>This file should go into include/scsi/.
>
>> +struct scsi_dump_ops {
>> +	int (*sanity_check)(Scsi_Device *);
>> +	int (*quiesce)(Scsi_Device *);
>> +	int (*shutdown)(Scsi_Device *);
>> +	void (*poll)(Scsi_Device *);
>> +};
>
>But I'm not sure we need it at all.  These should just go into the
>scsi_host_template, imho.
>
>>  static void scsi_eh_done(struct scsi_cmnd *scmd)
>>  {
>> +#if defined(CONFIG_SCSI_DUMP) || defined(CONFIG_SCSI_DUMP_MODULE)
>> +	if (crashdump_mode())
>> +		return;
>> +#endif
>
>Same comments as above, please avoid ifdefs.
>
>> +#include "scsi_priv.h"
>>  
>>  
>>  /*
>> @@ -107,3 +108,5 @@
>>   */
>>  EXPORT_SYMBOL(scsi_add_timer);
>>  EXPORT_SYMBOL(scsi_delete_timer);
>> +
>> +EXPORT_SYMBOL(scsi_decide_disposition);
>
>prototype in scsi_priv.h == not exported
>
>> --- linux-2.6.6.org/drivers/scsi/sd.c	2004-05-20 08:58:48.000000000 +
0900
>> +++ linux-2.6.6/drivers/scsi/sd.c	2004-05-27 09:24:46.000000000 +0900
>> @@ -192,6 +192,21 @@
>>  	up(&sd_ref_sem);
>>  }
>>  
>> +#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
>> +Scsi_Device *sd_find_scsi_device(dev_t dev)
>> +{
>> +	struct gendisk *disk;
>> +	int part;
>> +	disk = get_gendisk(dev, &part);
>> +	if(disk && disk->private_data)
>> +		return scsi_disk(disk)->device;
>> +	else
>> +		return NULL;
>> +}
>> +
>> +EXPORT_SYMBOL(sd_find_scsi_device);
>> +#endif
>
>Not the kind of interface we want exported.  IMHO you shouldn't find
>device by dev_t but add a dumpdevice sysfs attribute to the scsi_device
>where you can echo 1 to to make it a possible dump device.
