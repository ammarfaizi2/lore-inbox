Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUIKTK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUIKTK3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 15:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbUIKTK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 15:10:29 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:45145 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S268289AbUIKTK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 15:10:26 -0400
Message-ID: <41434DA0.3050408@travellingkiwi.com>
Date: Sat, 11 Sep 2004 20:10:24 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>	 <9e47339104091010221f03ec06@mail.gmail.com>	 <1094835846.17932.11.camel@localhost.localdomain>	 <9e47339104091011402e8341d0@mail.gmail.com>	 <Pine.LNX.4.58.0409102254250.13921@skynet>	 <1094853588.18235.12.camel@localhost.localdomain>	 <Pine.LNX.4.58.0409110137590.26651@skynet>	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>	 <Pine.LNX.4.58.0409110600120.26651@skynet>	 <1094913222.21157.61.camel@localhost.localdomain>	 <9e47339104091109463694ffd3@mail.gmail.com> <1094919681.21157.119.camel@localhost.localdomain>
In-Reply-To: <1094919681.21157.119.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Sad, 2004-09-11 at 17:46, Jon Smirl wrote:
>  
>
>>User 1's game queues up 20ms of 3D drawing commands.
>>Process swap to user 2.  ->quiesce() is going to take 20ms. 
>>User 2's timeslice expires and we go back to user 1.
>>User 1 queues up another 20ms.
>>
>>User 2's editor is never going to function.
>>    
>>
>
>If you implement it wrongly sure. If you implemented it right then
>this occurs.
>
>User 1 queues 20 ms of 3D commands
>User 1 is pre-empted
>User 2 wants the 2D engine
>User 2 beings wait for 2D
>User 2 sleeps
>User 1 wakes
>User 1 beings wait for 3D but discovers a claim is in progress
>User 1 sleeps
>User 2 wakes, runs commands
>
>If you have DRI loaded then as you rightly say the obvious desired
>outcome is that the fb engine either turns acceleration off or switches
>to using the DRI layer. 
>
>But this is a pretty obscure case, and one we can't even begin to
>support yet anyway.
>
>  
>

What about if you want to use fb when in text mode (Because you get 
200x75 on a 1600x1200 screen) AND run DRI because the rest of the time 
you want to run fast 3D. Plus you want to be able to CTRL-ALT-F1/F2/F7 
back & forth between X & fb... (i.e. how I currently use it but with 
unaccelerated x.org radeon drivers, becaus ethe 3D ones WON'T play nicely).

Currently this fails to work... Presumably because the fb & DRI code 
(fglrx here BTW) don't talk to each other & so the display gets garbled 
if you're lucky... Lockup if you're not.

Although I didn't like (Understand?) Jon's suggestion at first, I have 
to admit, that his scheme would let this work... because the low level 
driver would know what mode was in place, and you'd call the low-level 
driver to change between 3D & fb mode... 

Although Linus' suggestion works for memory allocation... I don't 
believe it addresses two competing drivers wanting to play with the same 
screen... Even when it's serialised like that. And unfortunately 
although Alan's probably works for DRI & fb on separate heads, how does 
it guarantee that the chipset is all setup the same way for each process 
on different heads... (When they have to share some of the hardware). Or 
is that necessary?

