Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbWJBQ20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWJBQ20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWJBQ2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:28:05 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:26059 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S965033AbWJBQ16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:27:58 -0400
Message-ID: <45213E53.6090507@candelatech.com>
Date: Mon, 02 Oct 2006 09:29:07 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com>	<m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com>	<m3hcyo2qvs.fsf@defiant.localdomain>	<45200BD7.6030509@candelatech.com> <m3zmcf8z8a.fsf@defiant.localdomain>
In-Reply-To: <m3zmcf8z8a.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Ben Greear <greearb@candelatech.com> writes:
>
>   
>> My assumption for bridging a bitstream is that timeslot sync is not
>> absolutely critical.  However, IF
>> you could be sure of time-slot sync, you'd  have a lot more power and
>> be able to do some extra ticks
>> in user-space I think...
>>     
>
> Not sure what do you want to do with that, but it may be critical for
> many things.
>
>   
>> The key for me is that if you ever miss a slot in bit-stream mode, you
>> can never make it up because
>> every bit is critical.
>>     
>
> I think you'd have to perform some recover procedure then, that's similar
> to DCE losing sync.
>   
The recovery is to simply drop a few time slices.  Whatever protocol is 
running over
the wire must be able to deal with it.
>>  This leads to having to drop arbitrary data to
>> keep from ever-increasing latency on your
>> bridge.
>>     
>
> If your clocks are synchronized (for example, if you get a "master"
> clock from your public phone exchange and you propagate it downstream,
> or your machine is the "master") then you never drop anything, the
> input and output rates are equal and in sync.
>   

If you are bridging in user-space (or kernel, for that matter), it is 
possible your writing process
will not be scheduled in time to fill up the tx buffer with real data.  
So, it would have to be
padded by the driver and/or NIC hardware.  With an adequately powered 
machine, this should
be a rare occurrence, however.

>>  With HDLC, you can skip the flags and make up time if you
>> ever miss a timeslot (assuming the
>> HDLC is not using the line at 100% capacity.)
>>     
>
> Sure. Even at 100% you can just drop a frame, HDLC applications must
> be prepared for it.
>   
Agreed.
>> I'd be happy with a software approach.  In fact, if I could get a
>> framed packet (ie, I know that
>> byte 0 is channel 1, byte 24 is channel 24, and byte 25 is channel 1
>> again...) then I could even
>> do the multiplexing in user space.
>>     
>
> Well, with software framing it would look a bit different - there
> is no such thing as "packet" as both TX and RX is continuous, not
> aligned to anything etc. You would have to detect channel boundaries,
> and bit-shift the data. Requires the sync serial controller (and FALC)
> in transparent mode (I would have to look at some docs). I think
> the kernel is a better place for things like that due to latency
> issues.
>   
I would definitely want the driver/hardware to deal with the byte/bit 
boundaries.  But,
the user-space read API could be similar to UDP (or HDLC if I understand 
it correctly),
but it would always return a multiple of the number of channels in bytes 
(0, 24, 48, ... for and entire T1).
>> For write, I'd also need to be able to guarantee that byte 0 goes to
>> channel 1, etc.  So, if the
>> driver bit-stuffed, then it would need to do an entire time-slice at once.
>>     
>
> BTW: An HDLC frame can use many slices. You can in fact have many
> HDLC frames (from different streams) multiplexed. You just need
> a multi-stream device or a multiplexer.
>   
Good.
>>>> *  Configure entire T1 as HDLC transport, bridge HDLC frames from one
>>>> T1 to the other.
>>>>         
>> Excellent.  I actually want to write the bridge logic myself in
>> user-space..I just need the driver
>> API and at least one driver that supports it and has support for
>> readily available T1/E1 hardware.
>>     
>
> If you want the userspace HDLC bridge... I'd use a pair of T1/E1 cards
> with generic HDLC support, for example, Cyclades PC300 (never used them
> and while I don't exactly like their driver, in case of problems I could
> add T1/E1 to my own driver which currently supports PC300 X.21 and
> V.24/V.35).
>
> Once T1/E1s are working and the required slots are selected:
> sethdlc hdlc0 hdlc (options)
> sethdlc hdlc1 hdlc (options)
> ifconfig hdlc0 up
> ifconfig hdlc1 up
> man PF_PACKET
>
> A single HDLC stream is a simple thing because it's exactly what
> the cards are designed for.
>   
Before I settle on hardware, I'd like to have some idea that the NIC can 
deal with raw
bit-streams.  It seems all of the NICs can handle HDLC, so that part 
should be pretty
easy.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com> 
Candela Technologies Inc  http://www.candelatech.com


