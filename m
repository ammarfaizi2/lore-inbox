Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUGXR5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUGXR5P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 13:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUGXR5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 13:57:15 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:43982 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261711AbUGXR45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 13:56:57 -0400
Message-ID: <4102A2E6.60206@comcast.net>
Date: Sat, 24 Jul 2004 13:56:54 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
CC: Martin Schlemmer <azarah@nosferatu.za.org>, Jens Axboe <axboe@suse.de>
Subject: Re: audio cd writing causes massive swap and crash
References: <40F9854D.2000408@comcast.net> <20040718071830.GA29753@suse.de>	 <40FBBAAE.5060405@comcast.net> <40FC2E60.2030101@comcast.net>	 <40FF4563.5070407@comcast.net>  <20040722125450.GC3987@suse.de> <1090529059.10205.34.camel@nosferatu.lan> <41004E05.8020804@comcast.net>
In-Reply-To: <41004E05.8020804@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed something interesting when mounting dvd+R's with my plextor.  

normal mount of cd-r
cdrom: hdc: mrw address space DMA selected

mount of dvd+R with -o rw
udf: registering filesystem
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
cdrom: failed setting lba address space
UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'CDROM', timestamp 
2004/07/17 18:41 (1f10)


I dont have packet writing enabled because i haven't configured it yet, 
but it's interesting that lba isn't functioning on this drive. 
There is a flash upgrade available for it but not apparently for linux, 
just windows.  It only seemed to be for reading dual layer recordable 
disks though.  It's a PX-712A.   Perhaps the problem with writing audio 
disks come from some code in the driver that converts lba to mrw?  It's 
frustrating to be able to pin down the problem this close but be unable 
to solve it.









Ed Sweetman wrote:

> Martin Schlemmer wrote:
>
>> On Thu, 2004-07-22 at 14:54, Jens Axboe wrote:
>>  
>>
>>> On Thu, Jul 22 2004, Ed Sweetman wrote:
>>>   
>>>
>>>> I've had other people test writing.  It appears that scsi-emu is 
>>>> not effected by this memory leak when writing audio cds.  So it 
>>>> would appear that ide-cd along with any of the dependent ide source 
>>>> files is the culprit. But I cannot find anywhere in ide-cd that is 
>>>> apparent to being a mem leak.  There are various conditions in 
>>>> ide_do_drive_cmd that state that the cdrom driver has to be very 
>>>> careful about handling but without intimate knowledge of the 
>>>> driver, I can't be sure that it's sufficiently handling those 
>>>> situations. 
>>>> Surprisingly, it's very hard to find anyone who's used the native 
>>>> atapi mode to write an audio cd in 2.6.  Which is partly why this 
>>>> problem hasn't generated more mail traffic here I would guess.     
>>>
>>> That's not true, lots of people use it. But, oddly, the leak isn't
>>> reproducable on any machine I've tested.
>>>   
>>
>>
>> I seem to remember he noted a patch about dma during audio writing,
>> and his 'testing' if it might be the cause was to just disable dma
>> on the drive ...
>>  
>>
>
>
> The patch is now part of vanilla 2.6.   It was an audio dma api that 
> was a workaround for the broken dma api that only allows ide commands 
> 512bytes long.  Schilling mentioned something about this in an earlier 
> lkml posting around january. 
> I've asked some other people in an irc channel to test out the 
> problem.  Basically You need to be using the native atapi method for 
> recording audio.   Also, it appears that the mem leak is just what 
> happens to some people, other people like some of those who tested in 
> the irc channel experienced random program sigsevs and no mem leak at 
> all.  It would appear from this that what may be happening is the 
> cdrom ide module is mangling a pointer and either can't free it due to 
> it possibly randomly pointing to null or cause crashes due to it 
> randomly pointing to other anonymous/shared memory regions as kfree is 
> called. That's obviously just a guess.  But some sort of memory 
> mangling is apparently happening.  This is not just happening on my 
> computer.
>
> My drive is using udma33 and not mdma so maybe that makes the problem 
> occur more quickly.    I disabled dma to test it writing the old way 
> but it appears to be occuring in ide-cd or somewhere between cdrom.o 
> and the block device layer.  ide-scsi people dont have the problem at 
> all apparently.
>

