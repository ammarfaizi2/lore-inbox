Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268771AbUILS16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268771AbUILS16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268775AbUILS16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:27:58 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:26476 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S268771AbUILS1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:27:53 -0400
Message-ID: <414434A0.9000401@travellingkiwi.com>
Date: Sun, 12 Sep 2004 12:36:00 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>	 <9e47339104091010221f03ec06@mail.gmail.com>	 <1094835846.17932.11.camel@localhost.localdomain>	 <9e47339104091011402e8341d0@mail.gmail.com>	 <Pine.LNX.4.58.0409102254250.13921@skynet>	 <1094853588.18235.12.camel@localhost.localdomain>	 <Pine.LNX.4.58.0409110137590.26651@skynet>	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>	 <Pine.LNX.4.58.0409110600120.26651@skynet>	 <1094913222.21157.61.camel@localhost.localdomain>	 <9e47339104091109463694ffd3@mail.gmail.com>	 <1094919681.21157.119.camel@localhost.localdomain>	 <41434DA0.3050408@travellingkiwi.com> <1094944787.21702.3.camel@localhost.localdomain>
In-Reply-To: <1094944787.21702.3.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>What about if you want to use fb when in text mode (Because you get 
>>200x75 on a 1600x1200 screen) AND run DRI because the rest of the time 
>>you want to run fast 3D. Plus you want to be able to CTRL-ALT-F1/F2/F7 
>>back & forth between X & fb... (i.e. how I currently use it but with 
>>unaccelerated x.org radeon drivers, becaus ethe 3D ones WON'T play nicely).
>>    
>>
>
>Thats actually the easy case. We don't care if it takes another 30th of
>a second to flip console. The hard one Jon was trying to point out is
>a dual head card. Head 0 has someone running bzflag, head 1 has someone
>editing an open office document. You have one accelerator set for both
>heads. At that point you do care about the switch over, but the drivers
>can co-operate for it. So it would always work, but it would work better
>with friendly drivers when there is a need to do so.
>
>  
>

I see you point of view. And agree with the sentiment about another 
1/30th of a scond to switch modes... Heck, I'd put up with 500ms... 
(1000ms looks like too much of a lag & makes me impatient when I want to 
switch. Especially if there's no feedback).

But this relies on drivers co-operating with each other. Which is a real 
pain, and we'd still be stuck with finger pointing whenever two drivers 
didn't manage to co-operate successfully... And you'd need co-operation 
& understanding to solve the problem... If one of the sides is 
proprietary closed source drivers then the co-operation may not be there.

At the end of the day, if it works & works well, it doesn't appear to 
matter too much whether it's a single driver, or multiple drivers 
accessing the same hardware. I have no axe to grind either way, and hope 
I'm keeping an open mind.

But from a supportability point of view I think Jon's single driver 
wins. Even if it's a closed source driver, as long as the entry points & 
callbacks are documented well & can be tested, it's easier to find where 
the problem lies (i.e. inside or outside the one driver). Having 
competing ones may well prove to be near impossible to get to work 
together (Risking the wrath and going back to an example like the ide cd 
& disk one, it would be like having a proprietary driver talking to your 
SCSI DVD drive, manipulating the chipset on your SCSI card & another one 
doing the same thing for you HD... It just doesn't happen that way 
now... We have a SCSI card driver that looks after the card & separate 
drivers that use the low-level one to just push SCSI commands to each. - 
Bad analogy?

>>Currently this fails to work... Presumably because the fb & DRI code 
>>(fglrx here BTW) don't talk to each other & so the display gets garbled 
>>if you're lucky... Lockup if you're not.
>>    
>>
>
>fglrx stomps blindly on everything including your AGP. Not much we can
>do about it.
>
>  
>

Yeah. Would fglrx  be more stable if you used the external AGP rather 
than fglrx's built in AGP driver?


>>although Alan's probably works for DRI & fb on separate heads, how does 
>>it guarantee that the chipset is all setup the same way for each process 
>>on different heads... (When they have to share some of the hardware). Or 
>>is that necessary?
>>    
>>
>
>You assume someone else crapped on the hardware. That is how DRI works
>for example. You have multiple rendering clients each of which when it
>takes the lock finds out if it was the last user (thats one thing Linus
>sketch lacked but is easy to add).
>
>My code ends up looking like
>
>	lock
>	if(someone_else_used_it)
>		restore_my_state()
>	blah 
>	unlock
>
>  
>
Ah... Now I understand what you've been talking about as well... The 
only caveat is whether you can always restore your own state from the 
state the other person put it into. Do any cards exist where you could 
perhaps still lock the card up because you didn't know the current state 
of the card?

Would it be better to do the state_changed flag as a callback to each 
registered driver?
