Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVB1PMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVB1PMq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 10:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVB1PMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 10:12:46 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:64418 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261633AbVB1PMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 10:12:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=YvjcrQ+578UNVdvi9M0iAhMQf5O0J00JXpHnAaxZYYfooEov4/nuP/RZ0WwQHCYzH4PI3yk/+SVvgyilZujrgdcyAhj1OB9ZSsS4Dv8Ixw09WNbUnfHblCweRISoKdoLhrAgzcYz3BG8LcGMCSdGaSf3i5Xo6OijdpQuEKWHhaw=
Message-ID: <422334CB.4010408@gmail.com>
Date: Tue, 01 Mar 2005 00:12:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch ide-dev 7/9] convert disk flush functions to use REQ_DRIVE_TASKFILE
References: <Pine.GSO.4.58.0502241545041.13534@mion.elka.pw.edu.pl> <20050227045125.GA25723@htj.dyndns.org> <200502271739.16076.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200502271739.16076.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 27 February 2005 05:51, Tejun Heo wrote:
> 
>> Hello, Bartlomiej,
>>
>>On Thu, Feb 24, 2005 at 03:45:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
>>
>>>Original patch from Tejun Heo <htejun@gmail.com>,
>>>ported over recent IDE changes by me.
>>>
>>>* teach ide_tf_get_address() about CHS
>>
>> IMHO, as patch #4 moves LBA/CHS selection into taskfile, I think
>>using taskfile->device to determine whether LBA or CHS is used instead
>>of drive->select makes more sense.
>>
>>
>>>* use ide_tf_get_address() and remove ide_get_error_location()
>>
>> IIRC, error responses for WIN_FLUSH_CACHE is in CHS if the LBA bit in
>>the device register is zero; likewise, in LBA if the LBA bit is one.
>>I don't know if drives can change the LBA bit when posting error
>>result.  The original code reads back the device register on error to
>>determine whether to interpret the error response in CHS or LBA.
>>(ATA/ATAPI-6 isn't clear on this issue.  Is ATA/ATAPI-7 updated?)
> 
> 
> The thing is that LBA bit is marked as "na" for FLUSH CACHE
> in all ATA/ATAPI drafts that I've seen.
> 

  Yeah, and nothing is mentioned about the LBA bit in the normal output 
description even though the lcyl, hcyl.. registers are described to be 
in either form of CHS or LBA.  Strange...

> 
>> This change combined with patch #2/#5 can make error address
>>calculation wrong on LBA28 drives.  I think setting the LBA bit in the
>>device register according to the drive's addressing mode in
>>ide_task_init_flush() and use taskfile->device in ide_tf_get_address()
>>should fix the problem.
> 
> 
> I will change the code to set LBA bit, it shouldn't hurt. :-)

  IMHO, there can be cases where just setting the LBA bit isn't enough. 
  Theoretically, drives can report CHS and clear the LBA bit in the 
device register even when the LBA bit was set when the command was 
issued.  Maybe the intention of the original code was to handle 
something like this?

-- 
tejun

