Return-Path: <linux-kernel-owner+w=401wt.eu-S932428AbXASAgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbXASAgZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbXASAgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:36:25 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:48542 "EHLO
	pd5mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbXASAgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:36:24 -0500
Date: Thu, 18 Jan 2007 18:35:08 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: How to flush the disk write cache from userspace
In-reply-to: <fa.lqQRZqIqMX2chyIAM888fc1jCuY@ifi.uio.no>
To: Ricardo Correia <rcorreia@wizy.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>
Message-id: <45B0123C.3080506@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.y+HJNAxqDqX5AHUxcmThAo20Ivo@ifi.uio.no>
 <fa.xbdrjhFpvWMJeTroG2DpPE4wd+M@ifi.uio.no>
 <fa.lqQRZqIqMX2chyIAM888fc1jCuY@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Correia wrote:
> On Tuesday 16 January 2007 00:38, you wrote:
>> As always with these things, the devil is in the details. It requires
>> the device to support a ->prepare_flush() queue hook, and not all
>> devices do that. It will work for IDE/SATA/SCSI, though. In some devices
>> you don't want/need to do a real disk flush, it depends on the write
>> cache settings, battery backing, etc.
> 
> Is there any chance that someone could implement this (I don't have the 
> skills, unfortunately)? Maybe add a new ioctl() to block devices, so that it 
> doesn't break any existing code?

I think we really should have support for doing cache flushes 
automatically on fsync, etc. User space code should not have to worry 
about this problem, it's pretty silly that for example MySQL has to 
advise people to use hdparm -W 0 to disable the write cache on their IDE 
drives in order to get proper data integrity guarantees - and disabling 
the cache on IDE without command queueing really slaughters the 
performance, unnecessarily in this case.

There may be some cases where the controller provides a battery-backed 
cache and thus we don't want to actually force the controller to flush 
everything out to the drive on fsync, so we may need to be able to 
disable this, but these controllers may ignore flushes anyway. I know 
IBM ServeRAID appears to fail requests for write cache info and so the 
kernel assumes drive cache: write through and doesn't do any flushes.

> 
> I believe it's a very useful (and relatively simple) feature that increases 
> data integrity and reliability for applications that need this functionality.
> 
> I think it must be considered that most people have disk write caches enabled 
> and are using IDE, SATA or SCSI disks.
> 
> I also think there's no point in disabling disks' write caches, since it slows 
> writes and decreases disks' lifetime, and because there's a better solution.

Yes, ideally doing all writes to the drive with write cache enabled and 
then flushing them out afterwards would be much more efficient (at least 
  when no command queueing is involved) since the drive can choose what 
order to complete the writes in.

> 
> Personally, I'm not really interested in specific filesystem behaviour, since 
> my application uses block devices directly (it's a filesystem itself). 
> Although I think all filesystems should guarantee data integrity in the face 
> of fsync() or metadata modifications, even if it costs a little performance.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

