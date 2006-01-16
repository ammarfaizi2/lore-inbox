Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWAPRw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWAPRw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWAPRw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:52:56 -0500
Received: from ebb.errno.com ([69.12.149.25]:26116 "EHLO ebb.errno.com")
	by vger.kernel.org with ESMTP id S1750770AbWAPRwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:52:55 -0500
Message-ID: <43CBDDC7.9060504@errno.com>
Date: Mon, 16 Jan 2006 09:54:15 -0800
From: Sam Leffler <sam@errno.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051227)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuffed Crust <pizza@shaftnet.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Johannes Berg <johannes@sipsolutions.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org> <43CAA853.8020409@errno.com> <20060116172817.GB8596@shaftnet.org>
In-Reply-To: <20060116172817.GB8596@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuffed Crust wrote:
> On Sun, Jan 15, 2006 at 11:53:55AM -0800, Sam Leffler wrote:
> 
>>The above is a great synopsis but there is more.  For example to support 
>>roaming (and sometimes for ap operation) you want to do background 
>>scanning; this ties in to power save mode if operating as a station. 
> 
> 
> Opportunistic roaming is one of those things that has many knobs to 
> twiddle, and depends a lot on the needs of the users. 
> 
> But we're not actually in powersave mode -- the 802.11 stack can spit
> out the NULL frames to tell the AP to buffer traffic for us. This is 
> trivial to do.

The way you implement bg scanning is to notify the ap you are going into 
power save mode before you leave the channel (in sta mode).  Hence bg 
scanning and power save operation interact.

> 
> Scans should be specified as "non-distruptive" so the hardware driver
> has to twiddle whatever bits are necessary to return the hardware to the
> same state that it was in before the scan kicked in.  Beyond that, the
> scanning smarts are all in the 802.11 stack.  The driver should be as
> dumb as possible.  :)

See above.  Doing bg scanning well is a balancing act and restoring 
hardware state is the least of your worries (hopefully); e.g. what's the 
right thing to do when you get a frame to transmit while off-channel 
scanning, how often should you return to the bss channel?

> 
> Background scanning, yes -- but there are all sorts of different
> thresholds and types of 'scanning' to be done, depending on how
> disruptive you are willing to be, and how capable the hardware is.  Most
> thin MACs don't filter out foreign BSSIDs on the same channel when
> you're joined, which makes some things a lot easier.

Er, you need to listen to at least beacons from other ap's if you're in 
11g so you can detect overlapping bss and enable protection.  There are 
other ways to handle this but that's one.

> 
> 
>>Further you want to order your channel list to hit the most likely 
>>channels first in case you are scanning for a specific ap--e.g. so you 
>>can stop the foreground scan and start to associate.  
> 
> 
> With my scenarios, the driver performs the sweep in the order it was 
> given -- if the hardware supports it, naturally.

Channel ordering is useful no matter who specifies it.  If you offload 
the ordering to the upper layers then they need to be aware of the 
regdomain constraints.  Probably not a big deal but then you need to 
synchronize info between layers or export it.  And there's other 
regdomain-related info that may want to be considered such as max 
txpower.  I'm just saying if you want to do a good job there's lots of 
work here.

> 
> 
>>In terms of beacon miss processing some parts have a hardware beacon
>>miss interrupt based on missed consecutive beacons but others require
>>you to detect beacon miss in software.  Other times you need s/w bmiss
>>detection because you're doing something like build a repeater when
>>the station virtual device can't depend on the hardware to deliver a
>>bmiss interrupt.
> 
> 
> Of course.  The stack is going to need a set of timers regardless of the 
> hardware's capabilities, but having (sane) hardware beacon miss 
> detection capabilities makes it a bit more robust.
>  
> 
>>Scanning (and roaming) is really a big can 'o worms.
> 
> 
> Oh, I know.  I've burned out many brain cells trying to build 
> supportable solutions for our customers.   

I don't recall seeing well-developed scanning code in either of the 
proposed stacks.

	Sam

