Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTBXHmB>; Mon, 24 Feb 2003 02:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbTBXHmB>; Mon, 24 Feb 2003 02:42:01 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:13071 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S264886AbTBXHmA>;
	Mon, 24 Feb 2003 02:42:00 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A343@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Christoph Hellwig '" <hch@infradead.org>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (16/21) SCSI
Date: Mon, 24 Feb 2003 16:52:10 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Christoph Hellwig
To: Osamu Tomita
Cc: Linux Kernel Mailing List; Alan Cox; Christoph Hellwig
Sent: 2003/02/23 19:52
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (16/21) SCSI

>> +int pc98_bios_param(struct block_device *bdev, int *ip)
>> +{
>> +  /* Note: This function is called from fs/partitions/nec98.c too. */
>> +  /* So we creat 'sdp' from 'bdev' here. */
>> +  struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
> 
> this is still not good - you shouldn't expose struct scsi_disk outside
> sd.c.  Please change the pc98_bios_param() prototype to that of the
> bios_param entry point (direct passing of capacity).
This is solved by using ioctl_by_bdev() in your suggestion. Thanks.

> Can you explain what this first_real_host() stuff is for - we need some
> way to handle this better.
PC98 BIOS create geometry table on boottime orderd by SCSI ID.
We read that to get geometry. If ide-scsi exist we mis-read table.

.
.
(Snipped, but I'll fix them. Thanks.)
.
.


>> +	BIOS_PARAM_OVERRIDE(sdp, bdev, sdkp->capacity, diskinfo);
>> +
> 
> the way this is done is ugly.  I'm still not sure how this is done
> best.  When do you need the pc98 geometry exactly?  i.e. can it happen
> with one of the existing linux scsi drivers?
We need BIOS geometry exactly to create a partion on linux (by fdisk or
GNU/parted). BIOS uses C/H/S access on boottime according to partition
table. If BIOS geometry is not exact, fail to boot from the partition.
I recived the report about this problem from people using advansys driver
without PC98 patch.

>> +#if defined(CONFIG_SCSI_PC980155) ||
defined(CONFIG_SCSI_PC980155_MODULE)
>> +#include "pc980155regs.h"
>> +#else /* !CONFIG_SCSI_PC980155 */
>>  
>>  static inline uchar read_wd33c93(const wd33c93_regs regs, uchar
reg_num)
>>  {
>> @@ -203,6 +206,7 @@
>>     *regs.SCMD = cmd;
>>     mb();
>>  }
>> +#endif /* CONFIG_SCSI_PC980155 */
> 
> The wd33c93 changes are ugly as hell, but that's not your fault.  I'll
> try to rework it to abstract out the different implementations better.
> Could you perform some testing for me if I send you updated versions?
Yes, of course.

Thanks,
Osamu Tomita
