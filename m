Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSKACD0>; Thu, 31 Oct 2002 21:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSKACDZ>; Thu, 31 Oct 2002 21:03:25 -0500
Received: from ns1.triode.net.au ([202.147.124.1]:60045 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP
	id <S265552AbSKACDH>; Thu, 31 Oct 2002 21:03:07 -0500
Message-ID: <3DC1E1E3.4060008@torque.net>
Date: Fri, 01 Nov 2002 13:07:31 +1100
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Lane <miles.lane@attbi.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Re: ieee1394/sbp2.c doesn't compile in 2.5.45
References: <3DC1D271.5070602@attbi.com>
Content-Type: multipart/mixed;
 boundary="------------060900030708010206040806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060900030708010206040806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Miles Lane wrote:
> 
> Douglas wrote:
> 
>> Adrian,
>> Could you try this patch that I sent to the scsi
>> list against 2.5.44-bk3.
> 
> 
> Yes, this patch fixed the 2.5.45 compile for me.
> 
>     Miles
> 
>> --- linux/drivers/ieee1394/sbp2.h    2002-10-26 03:11:32.000000000 +1000
>> +++ linux/drivers/ieee1394/sbp2.h2544bk3fix    2002-10-31 
>> 11:27:25.000000000 +1100
>> @@ -552,7 +552,8 @@
>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,28)
>>  static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]);
>>  #else
>> -static int sbp2scsi_biosparam (Scsi_Disk *disk, struct block_device 
>> *dev, int geom[]);
>> +static int sbp2scsi_biosparam (struct scsi_device *sdev, +            
>> struct block_device *dev, sector_t capacy, int geom[]);
>>  #endif
>>  static int sbp2scsi_abort (Scsi_Cmnd *SCpnt);  static int 
>> sbp2scsi_reset (Scsi_Cmnd *SCpnt); --- 
>> linux/drivers/ieee1394/sbp2.c    2002-10-31 09:22:50.000000000 +1100
>> +++ linux/drivers/ieee1394/sbp2.c2544bk3fix    2002-10-31 
>> 11:30:20.000000000 +1100
>> @@ -3137,14 +3137,14 @@
>>  /*
>>   * Called by scsi stack to get bios parameters (used by fdisk, and at 
>> boot).
>>   */
>> -#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,44)
>> +#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,43)
>>  static int sbp2scsi_biosparam (struct scsi_device *sdev,
>> -        struct block_device *dev, sector_t capacy, int geom[]) 
>> +        struct block_device *dev, sector_t capacity, int geom[])  {
>>  #else
>>  static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int 
>> geom[])  {
>> -    sector_t capacy = disk->capacity;
>> +    sector_t capacity = disk->capacity;
>>  #endif
>>      int heads, sectors, cylinders;

Attached is a slightly cleaner version of the this patch.
My 1394 disk enclosure hasn't caught up with me yet.
Can someone confirm whether 1394 sbp2 devices work with
2.5.45

Doug Gilbert




--------------060900030708010206040806
Content-Type: text/plain;
 name="sbp2_2545.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sbp2_2545.diff"

--- linux/drivers/ieee1394/sbp2.h	2002-10-26 03:11:32.000000000 +1000
+++ linux/drivers/ieee1394/sbp2.h2545fix	2002-10-31 11:27:25.000000000 +1100
@@ -552,7 +552,8 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,28)
 static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]);
 #else
-static int sbp2scsi_biosparam (Scsi_Disk *disk, struct block_device *dev, int geom[]);
+static int sbp2scsi_biosparam (struct scsi_device *sdev, 
+			struct block_device *dev, sector_t capacy, int geom[]);
 #endif
 static int sbp2scsi_abort (Scsi_Cmnd *SCpnt); 
 static int sbp2scsi_reset (Scsi_Cmnd *SCpnt); 
--- linux/drivers/ieee1394/sbp2.c	2002-11-01 09:20:53.000000000 +1100
+++ linux/drivers/ieee1394/sbp2.c2545fix	2002-11-01 09:53:40.000000000 +1100
@@ -3139,12 +3139,12 @@
  */
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,44)
 static int sbp2scsi_biosparam (struct scsi_device *sdev,
-		struct block_device *dev, sector_t capacy, int geom[]) 
+		struct block_device *dev, sector_t capacity, int geom[]) 
 {
 #else
 static int sbp2scsi_biosparam (Scsi_Disk *disk, kdev_t dev, int geom[]) 
 {
-	sector_t capacy = disk->capacity;
+	sector_t capacity = disk->capacity;
 #endif
 	int heads, sectors, cylinders;
 

--------------060900030708010206040806--

