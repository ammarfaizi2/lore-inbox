Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVACR0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVACR0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVACRZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:25:46 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:9437 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261517AbVACRXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:23:53 -0500
Message-ID: <41D98197.3050404@drdos.com>
Date: Mon, 03 Jan 2005 10:32:07 -0700
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
References: <20041216145229.29167.qmail@web26502.mail.ukl.yahoo.com> <Pine.LNX.4.61.0412161703290.30336@yvahk01.tjqt.qr> <1103212832.21920.7.camel@localhost.localdomain> <20041218001254.GA8886@pclin040.win.tue.nl> <cq06vq$1t2$1@terminus.zytor.com> <20041218121507.GB8886@pclin040.win.tue.nl> <41C4BE18.5060404@zytor.com> <41D97D4C.9020403@drdos.com>
In-Reply-To: <41D97D4C.9020403@drdos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

> H. Peter Anvin wrote:
>
>> Andries Brouwer wrote:
>>
>>>
>>> Concerning one, it is a somewhat complicated format that takes over
>>> your disk, rather inconvenient. It seems to me that one needs a good
>>> reason (like a BIOS that understands the format and is able to boot
>>> from it) to choose it.
>>>
>>
>> Not really; it's actually a very simple table.
>>
>
> It would be nice to know when this is going to make it in for my Linux 
> projects.
> I am running a 3Ware 9500 series with 3.1 TB disks.  I am able to use 
> all the
> storage at present with dsfs.  dsfs can support volumes up to 281 TB 
> at present
> but linux readir() can get into some problems when directories get 
> really large.
>
> I am not seeing problems with files that are 1.5 TB in size.  Have not 
> tried to
> create a 3TB file yet, but in theory, the VFS looks to support it.  I 
> am getting around the
> partition problem by basically ignoring the table extents (fdisk is 
> broken with these large
> partitions and wraps back to 700GB) if I have only created a single 
> partition, I just query
> the drive geometry and take the remaining space on the device and I 
> ignore the partition
> table.  It works fine.  If I detect more than one of my partitions I 
> revert back to the actual
> partition dimensions.
> For Jens edification, I am using the BIO subsystem with this and I am 
> seeing no problems
> reading and writing these huge drives, so I think Linux 2.6.9 and 
> 2.6.10 will support this
> well, and appears to.  I will be testing a combined striped array at 
> around 20TB with multiple
> controllers and FC/AL and will update if any problems are encountered.
> Other than the partition problem, the base kernel seems to support 
> these huge sizes with
> 64 bit LBA addressing very well.
>
> Jeff
>

One other item I noticed is that the compiler for X86 has some problems 
doing math for a 64 bit target
variable, so when you are using Large LBA and doing something like:

sector_t lba = part.start_lba + (block * (block_size /  sector_size));

you need to cast the variables if they are defined as 32 bit numbers 
because the compiler is too stupid
to realize you are adding the cumlative result into a 64-bit value, and 
it will wrap the offset as a 32 bit number.

i.e. 

sector_t lba = part.start_lba + (sector_t)((sector_t)block * 
((sector_t)block_size /  (sector_t)sector_size));

This works but if you leave off the type casting on any of the variables 
the number reverts to a 32 bit value
and wraps when you are calculating a 64 bit lba address. 

Jeff



