Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313469AbSDLJGO>; Fri, 12 Apr 2002 05:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313470AbSDLJGO>; Fri, 12 Apr 2002 05:06:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:49426 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313469AbSDLJGN>; Fri, 12 Apr 2002 05:06:13 -0400
Message-ID: <3CB694FC.2060701@evision-ventures.com>
Date: Fri, 12 Apr 2002 10:04:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
In-Reply-To: <20020412001029.GA1172@ppc.vc.cvut.cz> <20020412102021.A18037@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Apr 12, 2002 at 02:10:29AM +0200, Petr Vandrovec wrote:

Cze¶æ koledzy :-).

>>  After looking through code up and down I found that first 
>>sector is written in 32bit mode, while others in 16bit mode, 
>>and VIA IDE interface does not cope with this correctly. Can 
>>anybody explain me, what's wrong with patch at the end of this 
>>message? As there is dozen of places where io_32bit is cleared, 
>>I believe that there must be some reason for doing that... And 
>>do not ask me why it worked in 2.4.x, as it cleared io_32bit
>>in task_out_intr too.
> 
> 
> It's a very unwise thing to disable 32-bit mode on VIA and AMD chipsets,
> AMD even has it in their errata (VIA has no documented errata, of
> course). Thanks for the good find. Martin, can we do anything about
> this?

Agreed. The 16 bit transfer support is one legacy leftover from the
XT PC days which are of no relevance to Linux at all.
The disabling of 32 bit transfers was most propably intendid
to work around the fact that the SUPPORT_VLB_SYNC code was not
giving the desired results. The bugs it's supposed to work
around are only present if there are 32 bit transfers. This obscure
workaround code can't be found in any other ATA driver out there
I was looking at. And finally Jens has observed that the code in question
doesn't get used in 2.4 at all.

I tend therefore to the following measures:

1. Check whatever taskfile_output_data would indeed transfer the proper
    amount of data if the below patch get's applied.

2. If yes - just kill the disabling alltogehter.

3. Make 32 bit PIO transfers the global default.

...

Now I have just looked at the places where taskfile_output_data
get's used. It's abvious that the code in question is a mistake
and the disabling of io_32bit should just be killed alltogether.

Good spotting Petr!!!!!!!!

>>diff -urN linux-2.5.8-pre3.dist/drivers/ide/ide-taskfile.c linux-2.5.8-pre3/drivers/ide/ide-taskfile.c
>>--- linux-2.5.8-pre3.dist/drivers/ide/ide-taskfile.c	Sun Apr  7 03:43:03 2002
>>+++ linux-2.5.8-pre3/drivers/ide/ide-taskfile.c	Fri Apr 12 01:50:04 2002
>>@@ -602,7 +602,7 @@
>> 		rq = HWGROUP(drive)->rq;
>> 		pBuf = ide_map_rq(rq, &flags);
>> 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
>>-		drive->io_32bit = 0;
>>+//		drive->io_32bit = 0;
>> 		taskfile_output_data(drive, pBuf, SECTOR_WORDS);
>> 		ide_unmap_rq(rq, pBuf, &flags);
>> 		drive->io_32bit = io_32bit;
> 
> 

