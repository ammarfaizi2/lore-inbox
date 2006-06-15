Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030487AbWFOOr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030487AbWFOOr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWFOOr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:47:57 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:3761 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030487AbWFOOr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:47:56 -0400
Message-ID: <44917313.9040800@ext.bull.net>
Date: Thu, 15 Jun 2006 16:47:47 +0200
From: Frederic TEMPORELLI <frederic.temporelli@ext.bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: IO blocks are limited to 512KBytes (blk_queue_max_sectors)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/06/2006 16:51:40,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/06/2006 16:51:41,
	Serialize complete at 15/06/2006 16:51:41
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


Using 2.6.16.20 with lpfc and scsi_debug, I wasn't able to get blocks larger 
than 512KBytes.
(should be the same with 2.6.17-rc6)

My test:
writting 10000 blocks, block size is 1MByte (=> 10 GBytes):

[root@iotiger2 ~]# cat /proc/diskstats | grep sdk
8 160 sdk 3 3 768 28 0 0 0 0 0 28 28
[root@iotiger2 ~]# dd if=/dev/zero of=/dev/sdk bs=1M count=10000
10000+0 records in
10000+0 records out
[root@iotiger2 ~]# cat /proc/diskstats | grep sdk
8 160 sdk 3 3 768 28 20007 139993 20480000 11271532 0 77680 11271556

=> there have been ~20000 ops (which means that block size is 512KBytes)

The 512KBytes size is also reported on the storage array side when using lpfc 
driver with a NEC 2400 system.


Then, I try to change BLK_DEF_MAX_SECTORS in include/linux/blkdev.h.

=> Using a value of 4096, IO blocks where 2MBytes large.


Now, locking at the block layer implementations, seems that there may be 
something wrong with blk_queue_max_sectors.
I know that max_sectors is set to 0xFFFF in the lpfc driver, and I was expecting 
to get the block layer queue max_sectors sized according to the low level driver 
max_sector.
but we have the following affectations:

q->max_hw_sectors = max_sectors
q->max_sectors = BLK_DEF_MAX_SECTORS

why q->max_sectors isn't set to max_sectors too ?
I've did a try with q->max_sectors=max_sectors and I was able to use 8MBytes 
blocks (measured from diskstat and from the NEC storage system too)

So, what is the nice way to change the block layer for getting large IO blocks 
(> 1024 sectors) ?


Best regards


-- 
Frederic TEMPORELLI
