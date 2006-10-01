Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWJASkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWJASkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWJASkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 14:40:20 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:20103 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932168AbWJASkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 14:40:18 -0400
Message-ID: <45200BD7.6030509@candelatech.com>
Date: Sun, 01 Oct 2006 11:41:27 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com>	<m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com> <m3hcyo2qvs.fsf@defiant.localdomain>
In-Reply-To: <m3hcyo2qvs.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Ben Greear <greearb@candelatech.com> writes:
>
>   
>> I think if I could support these scenarios below, I would have
>> everything I need:
>>
>> *  Configure T1 as unchannelized bitstream, bridge entire thing to
>> second T1.
>>     
>
> I think it should be easy with such card, though I think the drivers
> can't currently do that.
>   
At least some out-of-tree drivers seem to be able to do this.  For 
instance, these guys:
http://www.farsite.co.uk/

>> *  Configure channels 1-5 as a bitstream and bridge that to channels
>> 1-5
>> of a second T1.  (random proprietary bit-streaming protocol,
>>     
>
> I think the hardware would permit that. Probably needs additional
> driver support and I'm not sure about timeslot synchronization (for
> HDLC, sync doesn't matter).
>   
My assumption for bridging a bitstream is that timeslot sync is not 
absolutely critical.  However, IF
you could be sure of time-slot sync, you'd  have a lot more power and be 
able to do some extra ticks
in user-space I think...
>>                     would probably bridge HDLC just fine, but handling
>> HDLC as frames would be more efficient I think.)
>>     
>
> Not sure, maybe yes (less data to bridge due to bit stuffing, flags etc.),
> maybe not (variable length of HDLC frame).
>   
The key for me is that if you ever miss a slot in bit-stream mode, you 
can never make it up because
every bit is critical.  This leads to having to drop arbitrary data to 
keep from ever-increasing latency on your
bridge.  With HDLC, you can skip the flags and make up time if you ever 
miss a timeslot (assuming the
HDLC is not using the line at 100% capacity.)
>>    channels 6-10 configured as an HDLC interface, bridged as HDLC
>> frames to channels 6-10 of a second T1. (PPP & other protocols over
>> HDLC)
>>    channels 10-24 each configured as a separate bit-stream, bridged to
>> channels 10-24 on the second T1. (Voice)
>>     
>
> I think the above could be a problem - I think common T1/E1 cards
> can do only one stream at once.
>
> I wonder if it can be done in software - the hardware framer would
> have to pass all data transparently, and it would be demultiplexed,
> processed and then multiplexed by the driver. Quite complicated,
> but I think at 2 Mbps it wouldn't be a CPU performance problem.
>   
I'd be happy with a software approach.  In fact, if I could get a framed 
packet (ie, I know that
byte 0 is channel 1, byte 24 is channel 24, and byte 25 is channel 1 
again...) then I could even
do the multiplexing in user space.

For write, I'd also need to be able to guarantee that byte 0 goes to 
channel 1, etc.  So, if the
driver bit-stuffed, then it would need to do an entire time-slice at once.

>> *  Configure entire T1 as HDLC transport, bridge HDLC frames from one
>> T1 to the other.
>>     
>
> Easy even with existing drivers I think (no bridge support but it's
> trivial).
>   
Excellent.  I actually want to write the bridge logic myself in 
user-space..I just need the driver
API and at least one driver that supports it and has support for readily 
available T1/E1 hardware.
For future work, I'd be interested in the same sort of support for DS3/E3.

I'd be willing to fund development of these features if you or someone 
else is interested
(please contact me off list for details.)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


