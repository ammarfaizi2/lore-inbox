Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSJXRhX>; Thu, 24 Oct 2002 13:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSJXRhW>; Thu, 24 Oct 2002 13:37:22 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:19477 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265567AbSJXRhU>;
	Thu, 24 Oct 2002 13:37:20 -0400
Message-ID: <3DB83156.5000402@mvista.com>
Date: Thu, 24 Oct 2002 12:43:50 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
References: <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>On Thu, Oct 24, 2002 at 10:36:22AM -0500, Corey Minyard wrote:
>
>  
>
>>Is there any way to detect if the nmi watchdog actually caused the 
>>timeout?  I don't understand the hardware well enough to do it without 
>>    
>>
>
>You can check if the counter used overflowed :
>
>#define CTR_OVERFLOWED(n) (!((n) & (1U<<31)))
>#define CTRL_READ(l,h,msrs,c) do {rdmsr(MSR_P6_PERFCTR0, (l), (h));} while (0)
>
>                CTR_READ(low, high, msrs, i);
>                if (CTR_OVERFLOWED(low)) {
>			... found
>
>like oprofile does.
>
Ok, thanks, I'll add that to the nmi_watchdog code.

>
>I've accidentally deleted your patch, but weren't you unconditionally
>returning "break out of loop" from the watchdog ? I'm not very clear on
>the difference between NOTIFY_DONE and NOTIFY_OK anyway...
>
The comments on these are:
#define NOTIFY_DONE        0x0000        /* Don't care */
#define NOTIFY_OK        0x0001        /* Suits me */
#define NOTIFY_STOP_MASK    0x8000        /* Don't call further */

I'mt taking these to mean that NOTIFY_DONE means you didn't handle it, 
NOTIFY_OK means you did handle it, and you "or" on NOTIFY_STOP_MASK if 
you want it to stop.  I'm thinking that stopping is probably a bad idea, 
if the NMI is really edge triggered.

>
>  
>
>>Plus, can't you get more than one cause of an NMI?  Shouldn't you check 
>>them all?
>>    
>>
>
>Shouldn't the NMI stay asserted ? At least with perfctr, two counters
>causes two interrupts (actually there's a bug in mainline oprofile on
>that that I'll fix when Linus is back)
>
There's a comment in do_nmi() that says that the NMI is edge triggered. 
 If it is, then you have to call everything.  I'd really like a manual 
on how the timer chip works, I'll see if I can hunt one down.

-Corey

