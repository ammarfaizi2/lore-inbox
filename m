Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSKVTZo>; Fri, 22 Nov 2002 14:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265228AbSKVTZo>; Fri, 22 Nov 2002 14:25:44 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:6153 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265222AbSKVTZn>; Fri, 22 Nov 2002 14:25:43 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1998@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: linux-kernel@vger.kernel.org, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: Manish Lachwani <manish@Zambeel.com>
Subject: Early determinition of bad sectors and correcting them ...
Date: Fri, 22 Nov 2002 11:32:41 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had thought abt this earlier and tried to implemented it.

Everytime there is an ECC error (0x40), there is a pending set of sectors
that the drive needs to remap. The drive can map the sectors as part of its
house keeping function or the drive can remap it when an explicit write is
made to that sector. Once an ECC error occurs, the remapping process is
manual or we have to wait till an write operation takes place to that
sector. 

If a READ gives an ECC error, the amount of time it takes to read is usually
higher as compared to READ operations accross sectors that are good. Even
for a sector or a region of sectors that are degrading over time, the READ
time is a good indication that the sector is deteriorating. A write to that
sector will fix the problem.

Based on the above, I modified the ide driver to implement this simple
change. I created a sysctl entry called ide_disk_delay_threshold which is
initially set to 250 ms. In ide-dma.c, I measure the amount of time it takes
to complete a READ request:

	drive->service_time = jiffies - drive->service_start;
	if (rq->cmd == READ && (ide_disk_delay_threshold > 0) &&
            ( (drive->service_time*10) > ide_disk_delay_threshold) ) {
        printk("%s: re-write, ", drive->name);
        printk("READ took %d ms \n", drive->service_time*10);
        /*
         * Set the command to write
         */
        rq->cmd = WRITE;
        return ide_stopped;
       }

I have tested the above and I have found that everytime I get accross an ECC
error (0x40), the driver immediately writes to that location remapping that
sector. This way, I get away with the bad sectors. The threshold 250 ms can
be changed depending on the application or requirement. But, it seems to be
a good indicator for early prediction of bad sectors ...

Thanks
-Manish

