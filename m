Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVACSVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVACSVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVACSTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:19:15 -0500
Received: from alog0301.analogic.com ([208.224.222.77]:13440 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261760AbVACSOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:14:22 -0500
Date: Mon, 3 Jan 2005 13:11:32 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: "Jeff V. Merkey" <jmerkey@drdos.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
In-Reply-To: <41D98197.3050404@drdos.com>
Message-ID: <Pine.LNX.4.61.0501031248200.13136@chaos.analogic.com>
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com>
 <Pine.LNX.4.61.0412161703290.30336@yvahk01.tjqt.qr>
 <1103212832.21920.7.camel@localhost.localdomain> <20041218001254.GA8886@pclin040.win.tue.nl>
 <cq06vq$1t2$1@terminus.zytor.com> <20041218121507.GB8886@pclin040.win.tue.nl>
 <41C4BE18.5060404@zytor.com> <41D97D4C.9020403@drdos.com> <41D98197.3050404@drdos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Jeff V. Merkey wrote:

> Jeff V. Merkey wrote:
>
>> H. Peter Anvin wrote:
>> 
>>> Andries Brouwer wrote:
>>> 
>>>> 
>>>> Concerning one, it is a somewhat complicated format that takes over
>>>> your disk, rather inconvenient. It seems to me that one needs a good
>>>> reason (like a BIOS that understands the format and is able to boot
>>>> from it) to choose it.
>>>> 
>>> 
>>> Not really; it's actually a very simple table.
>>> 
>> 
>> It would be nice to know when this is going to make it in for my Linux 
>> projects.
>> I am running a 3Ware 9500 series with 3.1 TB disks.  I am able to use all 
>> the
>> storage at present with dsfs.  dsfs can support volumes up to 281 TB at 
>> present
>> but linux readir() can get into some problems when directories get really 
>> large.
>> 
>> I am not seeing problems with files that are 1.5 TB in size.  Have not 
>> tried to
>> create a 3TB file yet, but in theory, the VFS looks to support it.  I am 
>> getting around the
>> partition problem by basically ignoring the table extents (fdisk is broken 
>> with these large
>> partitions and wraps back to 700GB) if I have only created a single 
>> partition, I just query
>> the drive geometry and take the remaining space on the device and I ignore 
>> the partition
>> table.  It works fine.  If I detect more than one of my partitions I revert 
>> back to the actual
>> partition dimensions.
>> For Jens edification, I am using the BIO subsystem with this and I am 
>> seeing no problems
>> reading and writing these huge drives, so I think Linux 2.6.9 and 2.6.10 
>> will support this
>> well, and appears to.  I will be testing a combined striped array at around 
>> 20TB with multiple
>> controllers and FC/AL and will update if any problems are encountered.
>> Other than the partition problem, the base kernel seems to support these 
>> huge sizes with
>> 64 bit LBA addressing very well.
>> 
>> Jeff
>> 
>
> One other item I noticed is that the compiler for X86 has some problems doing 
> math for a 64 bit target
> variable, so when you are using Large LBA and doing something like:
>
> sector_t lba = part.start_lba + (block * (block_size /  sector_size));


I think the writer forgot about promotion rules so it's not
a compiler problem.

>
> you need to cast the variables if they are defined as 32 bit numbers because 
> the compiler is too stupid
> to realize you are adding the cumlative result into a 64-bit value, and it 
> will wrap the offset as a 32 bit number.
>

If block_size = uint32_t, and sector_size = uint32_t, then
block_size / sector_size is uint32_t, nothing more. Now, we have
a uint32_t * another uint32_t which is uint32_t with a possible
wrap, still correct. Then we have uint32_t + uint32_t which will
be promoted to sector_t (uint64_t).

If you need to promote variables ahead of the final assignment, the
writer needs to do this, not the compiler.


> i.e. 
> sector_t lba = part.start_lba + (sector_t)((sector_t)block * 
> ((sector_t)block_size /  (sector_t)sector_size));
>
> This works but if you leave off the type casting on any of the variables the 
> number reverts to a 32 bit value
> and wraps when you are calculating a 64 bit lba address. 
> Jeff
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
