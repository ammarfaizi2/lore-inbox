Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbWBAHpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWBAHpn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030562AbWBAHpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:45:43 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:9308 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030561AbWBAHpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:45:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=G0cti156tcL+UZiD7vYVu5yleqefzXfymVmbuHnr6q/Pim+jwbu9xa7yEZKv84aOHQKzBRlPMy+aLJUOO2rdkjrtTpio6Qr2zWvZ0HmYrU7cQhBmjjYyC8h8KrkjlvluUJCiDB9exj2U1G+1mLT9Gq55gDM3GiREg6nBUtflTIk=
Message-ID: <43E0671F.1010302@gmail.com>
Date: Wed, 01 Feb 2006 16:45:35 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: psusi@cfl.rr.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <20060129112613.GA29356@merlin.emma.line.org> <Pine.LNX.4.61.0601292139080.2596@yvahk01.tjqt.qr> <43DD2A8A.nailGVQ115GOP@burner> <787b0d920601291328k52191977h37 <43DE495A.nail2BR211K0O@burner> <43DE75F5.40900@cfl.rr.com> <43DF403F.nail2RF310RP6@burner>
In-Reply-To: <43DF403F.nail2RF310RP6@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Phillip Susi <psusi@cfl.rr.com> wrote:
> 
> 
>>Joerg Schilling wrote:
>>
>>>I am sorry to see your recent dicussion style.
>>>
>>>I was asking a question and I did get a completely useless answer as
>>>any person who has some basic know how Linux SCSI would know that
>>>doing a stat("/dev/sg*", ...) will not return anything useful.
>>>  
>>
>>It certainly does return something useful, just not what you are looking 
>>for.  It does not return information that allows you to cleanly build 
>>your bus:device:lun view of the world, but it does return sufficient 
>>information to enumerate and communicate with all devices in the 
>>system.  Is that not sufficient to be able to implement cdrecord?  If it 
>>is, then the real issue here is that you want Linux to conform to the 
>>bus:device:lun world view, which it seems many people do not wish to do. 
> 
> It does not allow libscg to find all devices.
> 
>>Maybe it would be more constructive if you were to make a good argument 
>>for why the bus:device:lun view is better than /dev/*, but right now it 
>>seems to me that they are just two different ways of doing the same 
>>thing, and you prefer one way while the rest of the Linux developers 
>>prefer the other. 
> 
> It would help if someone would give arguments why Linux does treat all 
> SCSI devices equal, except for ATAPI transport based ones.
> 

Mostly historic, I guess.  When IDE drivers first got implemented, ATAPI 
wasn't really considered thoroughly and later when generic SCSI command 
support became necessary it was added by bridging ATAPI devices over to 
SCSI using ide-scsi.  People didn't like ide-scsi very much for good 
reasons - special boot parameter, confusing, needed full SCSI stack 
etc...  So, the hd SG_IO came.

And, yes, hd SG_IO has certain drawbacks as you pointed out.  No generic 
command to tape device (as no generic IDE device exists), not an 
integral part of SCSI subsystem and might even contain some new bugs as 
it's different new (well, was) code base.  Yet, people in general seem 
to find the change more beneficial and I personally like the change too.

ide-scsi is obsolete now.  Going back to it just won't happen and as I 
just said, yeah, some good stuff was lost in the process but others are 
gained, so please accept it - there is no central repository of SCSI 
command aware devices on Linux, at least at the moment.  It might happen 
in time but *currently* there is none.  I also think it would be better 
to have one but, hey, that's how the current state is and it will take 
quite some amount of work and time to implement that correctly.

So, let's meet somewhere inbetween.  Reserving a SCSI bus number for 
ATAPI devices and generating ID/LUN for SG_IO devices isn't very 
difficult and probably a good thing to have.  So, unfortunately, we 
won't have pretty /dev/sg* for all SCSI-aware devices, but you only have 
to scan limited number of devices - /dev/sg* and /dev/hd*.

How does that sound?

-- 
tejun
