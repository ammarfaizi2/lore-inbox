Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWBWG1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWBWG1g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 01:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWBWG1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 01:27:36 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:61414
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1751476AbWBWG1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 01:27:35 -0500
Message-ID: <00dc01c63842$381f9a30$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <billion.wu@areca.com.tw>, <alan@lxorguk.ukuu.org.uk>, <akpm@osdl.org>,
       <arjan@infradead.org>, <oliver@neukum.org>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com> <20060220182045.GA1634@infradead.org> <001401c63779$12e49aa0$b100a8c0@erich2003> <20060222145733.GC16269@infradead.org>
Subject: Re: Areca RAID driver remaining items?
Date: Thu, 23 Feb 2006 14:27:26 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 23 Feb 2006 06:23:23.0500 (UTC) FILETIME=[A5F58AC0:01C63841]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christoph Hellwig,

I have figure out your comments about "remove internal queueing" and "remove 
odd ioctl".
But about "hardware datastructures", areca's firmware spec is need to get a 
trunk of contingous memory space under 4G.
In 64bit platform arcmsr need to make sure all ccbs have same of 
ccb_phyaddr_hi32 physical address.
If arcmsr use dma_pool_alloc do a separate dma mapping.
Is there any method to avoid ccbs pool cross 4G segment?

- msi should be a module options if at all, but defintitly not
   a config options

In some mainboard if I always enable msi function, it will cause system hang 
up.
If it is not a config option, do you have any idea to avoid this issue?

Best Regards
Erich Chen
----- Original Message ----- 
From: "Christoph Hellwig" <hch@infradead.org>
To: "erich" <erich@areca.com.tw>
Cc: <linux-scsi@vger.kernel.org>; <linux-kernel@vger.kernel.org>; 
<billion.wu@areca.com.tw>; <alan@lxorguk.ukuu.org.uk>; <akpm@osdl.org>; 
<arjan@infradead.org>; <oliver@neukum.org>
Sent: Wednesday, February 22, 2006 10:57 PM
Subject: Re: Areca RAID driver remaining items?


> On Wed, Feb 22, 2006 at 02:27:32PM +0800, erich wrote:
>> Hi Christoph Hellwig,
>>
>> Thanks for your comment with "arcmsr".
>> I will follow your comment to redo this driver.
>> But I am confuse with your mention about some items.
>> Hope you can tell me more detail and let me realy know your comment.
>>
>>  1- remove internal queueing:
>>
>>      Does the "internal queueing" is mention with arcmsr of ccb_free_list 
>> ?
>
> Currently the drivers queuecommand routine works the following:
>
> 1) perform some checks
> 2) try to post outstanding ccbs
> 3) grab new ccb from freelist and set it up
> 4) try to post new ccb, else enqueue it
>
> there is not poin in having such a pending queue in the driver because
> the midlayer does that work for you.  If ->queuecommand can't immediately
> post a ccb you should return
>
> SCSI_MLQUEUE_HOST_BUSY   if there is a resource shortage at the hba level
> SCSI_MLQUEUE_DEVICE_BUSY if there is a resource shortage at the device 
> level
>
> and the scsi midlayer will try to send the command again once a command
> has been completed on the hba/device.
>
>>  2- fix hardware datastructures:
>>
>>      Does the "fix hardware datastructures" is to fix struct ARCMSR_CDB?
>>      Is it illeagal in linux?
>
> struct CCB is a structure that is passed to the hardware but contains
> pointers which have different sized on different architectures.  This
> is generally very dangerous.  If this is just a cookie that the hardware
> doesn't interpret at all it needs more documentation.  Also the way
> you try to convert from bus to virtual addresses with pACB->vir2phy_offset
> can't work on many linux platforms because the virtual to bus address
> mapping isn't contingous.  you need a separate dma mapping for each ccb,
> a good way to archive that is the dma_pool_ * API.
>
>
>>  3- remove odd ioctls:
>>
>>      How about remove odd ioctl?
>
> generally we don't want to add new ioctls.  For scsi/raid drivers there's
> been an exception where we allow a pass-through to the firmware which
> the managment applications need.  the driver has various ioctls that
> don't seem to fall into that category. 

