Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVHDMMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVHDMMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVHDMMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:12:06 -0400
Received: from [202.125.86.130] ([202.125.86.130]:22146 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S262496AbVHDMJU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:09:20 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6 partition support driver methods 
Date: Thu, 4 Aug 2005 17:35:02 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <C349E772C72290419567CFD84C26E017042497@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6 partition support driver methods 
thread-index: AcWYXlUN8nD1H/+4SAu8iEGVxNNWAwAhhqVA
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <corbet@lwn.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear corbet,

Here is the over idea about the driver status.
My driver supports 4 SD cards at a time. 
The driver works well when there are partitions are disabled.
i.e. when alloc_disk(1); - i.e. no partitions

Right now, I am working on getting the driver up with partitions
supported.
After making changes in the gendisk initialization, I am able to mount
the device in the socket 0 but I am NOT able mount the devices in the
rest of the sockets when partitions are enabled?

Also, there is nothing specific that I am implementing for partition IO
request support on the devices.

However, 
I am in bit confusion whether the following gendisk will suffice the
requirement or NOT?

Will u please verify the gendisk code below?
Here is how I am initializing the gendisk in my driver.

----------------------gendisk impl ----------------------------

	gDisk->blkqueue = blk_init_queue(do_request, &gDisk->qlock);
	if(gDisk->blkqueue == NULL) {
		printk("FM ERROR | Queue Initialization failed!\n");
		return FAILURE;
	}
	
	/* set sector size */
	blk_queue_hardsect_size(gDisk->blkqueue, DEV_SECT_SIZE);

	/* add gendisk: partitioning support.... */
	gDisk->gd = alloc_disk(4); /* 3 -> 3 partitions */
	if(! gDisk->gd) {
		printk("FM ERROR | alloc_disk failed!\n");
		return FAILURE;
	}
	gDisk->gd->major = major_num;
	gDisk->gd->first_minor = (int_of(Dev->dName[2]) *
MAX_NUM_SOCKETS) +
(iSock * 4);
	gDisk->gd->fops = &bd_op;
	gDisk->gd->private_data = Dev;

	for(i=0;i<3;i++)
		devName[i] = Dev->dName[i];
	devName[i] = char_of(iSock);
	devName[i+1] = '\0';
	strcpy(gDisk->gd->disk_name, devName);
	PRINTK("Device Name under /dev/ = %s\n", devName);

	/* removable media */
	gDisk->gd->flags |= GENHD_FL_REMOVABLE;

	set_capacity(gDisk->gd,
	((dSize * 1024)/DEV_SECT_SIZE) *
(DEV_SECT_SIZE/KRNL_SECT_SIZE));

	gDisk->gd->queue = gDisk->blkqueue;

	add_disk(gDisk->gd);
----------------------gendisk impl ENDS ----------------------------

This gendisk is invoked at socket initialization.

For example, phy devices are 
/dev/tfa0 - 3:  socket 1
/dev/tfa4 - 7:  socket 2
/dev/tfa8 - 11: socket 3
/dev/tfa12 -15: socket 4

i.e, I have created the nodes like minors 0, 1, 2, 3 for socket0
	I have created the nodes like minors 12, 13, 14, 15 for socket3.

With these physical nodes, I through it should work.
When a card is inserted in the socket 0, I am able to mount.

BUT, when a card is inserted in the socket 3, I am NOT able to mount and
it says.
Mount: /dev/tfa12 is not a valid block device

Can you convey me where exactly I am missing or why is it failing?

Regards,
Mukund Jampala


>-----Original Message-----
>From: corbet@lwn.net [mailto:corbet@lwn.net]
>Sent: Thursday, August 04, 2005 12:35 AM
>To: Mukund JB.
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: 2.6 partition support driver methods
>
>> Do I need to handle any thing in the request function to handle
>> read/writes to the device partitions?
>
>It looks like you've done most of what you need; in 2.6, block drivers
>need not worry about the details of partitioning.
>
>Lots of details in the block drivers chapter of LDD3 if you need them:
>
>	http://lwn.net/Kernel/LDD3/
>
>jon
>
>Jonathan Corbet
>Executive editor, LWN.net
>corbet@lwn.net

