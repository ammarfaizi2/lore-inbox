Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSHBMOX>; Fri, 2 Aug 2002 08:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSHBMOW>; Fri, 2 Aug 2002 08:14:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62214 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311885AbSHBMNn>; Fri, 2 Aug 2002 08:13:43 -0400
Message-ID: <3D4A771A.9020308@evision.ag>
Date: Fri, 02 Aug 2002 14:12:10 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
References: <1028288066.1123.5.camel@laptop.americas.sgi.com>	<20020802114713.GD1055@suse.de>  <3D4A7178.7050307@evision.ag> <1028289940.1123.19.camel@laptop.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Stephen Lord napisa³:
> On Fri, 2002-08-02 at 06:48, Marcin Dalecki wrote:
> 
>>Uz.ytkownik Jens Axboe napisa?:
>>
>>>On Fri, Aug 02 2002, Stephen Lord wrote:
>>>
>>>
>>>>In 2.5.30 I started getting these warning messages out ide during
>>>>the mount of an XFS filesystem:
>>>>
>>>>ide-dma: received 1 phys segments, build 2
>>>>
>>>>Can anyone translate that into English please.
>>>
>>>
>>>Well I added that message when switching to the 2.5 style request
>>>mapping functions, and I think the message is perfectly clear :-). Never
>>>the less, it means that a segment that came into the ide layer with an
>>>advertised size of 1 segment was returned from blk_rq_map_sg() as having
>>>_two_. This can be a problem with dynamically allocated sg table (not
>>>that ide uses those, but still).
>>>
>>>It's a bug and usually a critical one when this happens. I'd be inclined
>>>to think that Adam's changes in this path are to blame for this error.
>>
>>Carefull carefull. it can be that the generic BIO code doesn't honour
>>the limits Adam was setting properly. And it can be of course
>>as well the XFS doesn't cooperate properly with those limits as well,
>>since ther kernel appears to be patched to support them.
>>
> 
> 
> Well, this is happening when reading the log up from disk during
> mount, we will be asking for somewhere around 32K of data at a
> time, but it might not be well aligned. I will instrument it and
> report back - will be a few hours, the box is at work and I just
> tripped it up in some other code, I cannot reset it from here.
> 
> 
>>It would be helpfull as well to know on which brand of host controller 
>>chip this was found. In esp. trm290 maybe?
> 
> 
> Since it is down I cannot give you the ide boot messages right now,
> but it is a Tyan Tiger BX motherboard using the built in IDE chipset,
> so pretty generic stuff.
OK. Could you then deliberately change the following in ide/main.c

+	/* Most controllers cannot do transfers across 64kB boundaries.
+	   trm290 can do transfers within a 4GB boundary, so it changes
+	   this mask accordingly. */
+	ch->seg_boundary_mask = 0xffff;
+
+	/* Some chipsets (cs5530, any others?) think a 64kB transfer
+	   is 0 byte transfer, so set the limit one sector smaller.
+	   In the future, we may default to 64kB transfers and let
+	   invidual chipsets with this problem change ch->max_segment_size. */
+	ch->max_segment_size = (1<<16) - 512;


I would in esp. like to see the result of setting  ch->max_segment_size 
= (1 << 15).



