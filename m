Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267902AbUHESpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267902AbUHESpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUHESoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:44:08 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:29056 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S267903AbUHESnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:43:02 -0400
Message-ID: <41128070.5050109@tmr.com>
Date: Thu, 05 Aug 2004 14:46:08 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Jens Axboe <axboe@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
References: <1091490870.1649.23.camel@localhost.localdomain><1091490870.1649.23.camel@localhost.localdomain> <20040803055337.GA23504@suse.de>
In-Reply-To: <20040803055337.GA23504@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Aug 03 2004, Alan Cox wrote:
> 
>>On Sad, 2004-07-31 at 21:00, Jens Axboe wrote:
>>
>>>If you want it to work that way, you have the have a pass-through filter
>>>in the kernel knowing what commands are out there (including vendor
>>>specific ones). That's just too ugly and not really doable or
>>>maintainable, sorry.
>>
>>I disagree providing you turn it the other way around. The majority of
>>scsi commands have to be protected because you can destroy the drive
>>with some of them or bypass the I/O layers. (Eg using SG_IO to do writes
>>to raw disk to bypass auditing layers)
>>
>>So you need CAP_SYS_RAWIO for most commands. You can easily build a list
>>of sane commands for a given media type that are harmless and it fits
>>the kernel role of a gatekeeper to do that.
> 
> 
> So that's where we vehemently disagree - it fits the kernel role, if you
> allow it to control policy all of a sudden. And it's not easy, unless
> you do it per specific device (not just type, make and model).
> 
> 
>>Providing the 'allowed' function is driver level and we also honour
>>read/write properly for that case (so it doesnt bypass block I/O
>>restrictions and fail the least suprise test) then it seems quite
>>doable.
>>
>>For such I/O you'd then do
>>
>>	if(capable(CAP_SYS_RAWIO) || driver->allowed(driver, blah, cmdblock))
>>
>>If the allowed function filters positively "unknown is not allowed" and
>>the default allowed function is simply "no" it works.
> 
> 
> Until there's a new valid command for some device, in which case you
> have to update your kernel?

As opposed to now when a new command comes along and the driver doesn't 
generate it until you update your kernel? Reading a CD doesn't take 
exotic commands, and given the choice of having users able to send 
arbitrary commands to the device and not access it at all, I would say 
"not at all" would be good.
> 
> 
>>We'd end up with a list of allowed commands for all sorts of operations
>>that don't threaten the machine while blocking vendor specific wonders
>>and also cases where users can do stuff like firmware erase.

There was a note on another list titled "Why did this work?" (from 
memory) where someone accidentally run a firmware update as a normal 
user and it worked. While this was a benign event, it points out that 
there is a hole here far beyond my earlier worry that someone would 
update a CD-RW.
> 
> 
> Sorry, I think this model is totally bogus and I'd absolutely refuse to
> merge any such beast into the block layer sg code.
> 
So what is your solution? Or do you believe that allowing users to have 
unmonitored access to devices is acceptable?

Is this problem only in ide-cd, or does it affect other devices like 
ZIP, USB, etc, which do or may look like SCSI?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
