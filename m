Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUAPQNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUAPQMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:12:45 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:53491 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265352AbUAPQMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:12:41 -0500
Message-ID: <40080D6B.5090801@wmich.edu>
Date: Fri, 16 Jan 2004 11:12:27 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Jonathan Kamens <jik@kamens.brookline.ma.us>, linux-kernel@vger.kernel.org
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us> <16389.63781.783923.930112@jik.kamens.brookline.ma.us> <16391.24288.194579.471295@jik.kamens.brookline.ma.us> <200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk> <16392.734.505550.6731@jik.kamens.brookline.ma.us> <200401161546.i0GFkkpa002053@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200401161546.i0GFkkpa002053@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Quote from Jonathan Kamens <jik@kamens.brookline.ma.us>:
> 
>>John Bradford writes:
>> > Quote from Jonathan Kamens <jik@kamens.brookline.ma.us>:
>> > > ... hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
>> > > ... hde: drive_cmd: error=0x04 { DriveStatusError }
>> > 
>> > The drive doesn't seem to understand the command it was sent.
>>
>>I'm not sure what this means, but assuming that it's going to happen
>>again at some point,
> 
> 
> Maybe not - the most common cause I've seen for that message in the logs is trying to access S.M.A.R.T. information when S.M.A.R.T. is disabled.
> 
> I.E. the error should be reproducable with:
> 
> # smartctl -d /dev/hda
> # smartctl -a /dev/hda
> 
> Are you sure you weren't trying to get S.M.A.R.T. info from the drive at the time the error was logged?
> 
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }


Some drives i guess report the exact error like mine here.  These occur 
when i'm transferring from my tulip based nic to my hdd at 8Mbytes a 
second (avg). The fs is ext3.  When i'm transferring about 1.5GB files 
over the drive seems to freak out.  Timing sources (tsc) can also lose 
so many ticks that the other time source has to be used.

What i dont understand is why the ata drivers dont handle crc errors 
correctly. Instead of resetting the ide bus and turning dma off why dont 
they start throttling down the dma modes one by one,  When the rate of 
crc errors reaches a certain reasonable number, drop an udma level. If 
that crc error rate is reached again, drop a level.  You keep doing that 
until you hit pio mode.  Usually the problem is solved by simply using a 
lower dma mode.  That way my system doesn't have to reach loads of 20 
and io suck all my cpu while i'm trying to re-enable dma so i can 
actually figure out what's going on. CRC errors are caused by timing 
problems as well as physical problems around the cabling in the 
computer.  Normal hdd to hdd transfers (which avg about 30MByte/sec) do 
not cause these errors for me.


