Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbTFRArd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbTFRArd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:47:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64764 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265032AbTFRArc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:47:32 -0400
Message-ID: <3EEFB9C5.4050300@mvista.com>
Date: Tue, 17 Jun 2003 18:00:53 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Riley Williams <Riley@Williams.Name>, davidm@hpl.hp.com,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <20030617232113.J32632@flint.arm.linux.org.uk>
In-Reply-To: <20030617232113.J32632@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Jun 17, 2003 at 11:11:46PM +0100, Riley Williams wrote:
> 
>>On most architectures, the said timer runs at 1,193,181.818181818 Hz.
> 
> 
> Wow.  That's more accurate than a highly expensive Caesium standard.
> And there's one inside most architectures?  Wow, we're got a great
> deal there, haven't we? 8)
> 
> 
>> > Please do not add CLOCK_TICK_RATE to the ia64 timex.h header file.
>>
>>It needs to be declared there. The only question is regarding the
>>value it is defined to, and it would have to be somebody with better
>>knowledge of the ia64 than me who decides that. All I can do is to
>>post a reasonable default until such decision is made.
> 
> 
> If this is the case, we have a dilema on ARM.  CLOCK_TICK_RATE has
> been, and currently remains (at Georges distaste) a variable on
> some platforms.  I shudder to think what this is doing to some of
> the maths in Georges new time keeping and timer code.
> 
So just what is it used for?  On the x86, the math on it is used 
mostly (aside from LATCH) to figure out the actual value of 1/HZ. 
This is then used to compute a more correct TICK_NSEC which is added 
to xtime each tick.  This usage of CLOCK_TICK_RATE just "beats it up" 
to see how close the hardware can get to the requested rate of 1/HZ. 
Since this code is in time.h and timex.h, it is shared with all the archs.

I submit that if it is not used to actually compute a LATCH value for 
the 1/HZ tick, it should just be some rather large value that more or 
less represents the granularity of the hardwares ability to generate 
1/HZ ticks.  Once it gets above about 100MHZ, I think it actually 
drops out of the calculations.  The last thing we want to do at this 
point is make it a variable.  (Nor do you want to put a -E in your cc 
command and take a look at what is produced for the conversion constants.)

If it is not possible to make it a constant, I think we need to 
revisit the timer conversion code as we would not only have a LOT of 
code bloat, but it would add far too much time to the conversions.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

