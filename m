Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274892AbTGaXDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270576AbTGaXDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:03:04 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:32228 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S270278AbTGaXCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:02:12 -0400
Message-ID: <3F299FF0.9060407@wmich.edu>
Date: Thu, 31 Jul 2003 19:02:08 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Andrew Morton <akpm@osdl.org>, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271517.55549.phillips@arcor.de> <3F22FB33.5080703@wmich.edu> <200308011038.49528.phillips@arcor.de>
In-Reply-To: <200308011038.49528.phillips@arcor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What i consider decoding is everything from the file to the audio going 
to the audio device. This means moving the audio from your decoder into 
the buffer you use to play sound.  The process may be set as realtime, 
but whether or not it's able to accomplish that is up to the code 
itself, usually you have more audio experienced programmers working on 
the output library/device.  Just because the decoder may be able to get 
cpu and resources when it asks for it within a bounded range doesn't 
mean it's able to accomplish what it's supposed to within that range all 
the time.  Otherwise explain why substituting different decoders results 
in different performances regarding audio skipping, that includes 
different decoders for different codecs and even the same ones. The 
audio programs themselves are responsible for the poor performances they 
get with current kernels much more than the kernel is, that point was my 
original subject.

yea, it's just as distinct per cycle as outputting audio is, but the 
players are not at a realtime quality, which they should be before 
people start using them to grade the kernel's "realtimeness".

Daniel Phillips wrote:
> On Saturday 26 July 2003 17:05, Ed Sweetman wrote:
> 
>>My comment was towards the fact that although playing audio is a
>>realtime priority, decoding audio is not, and is not coded that way in
>>many programs, in fact, many programs will sleep() in order to decode
>>only when the output buffer is getting low.
> 
> 
> Decoding is realtime too, though the bounds are more relaxed than for the DMA 
> refill process.  In fact, it's the decoding task that causes skipping, 
> because the DMA refill normally runs in interrupt context (so should mixing 
> and equalizing, but that's another story) where essentially everything is 
> realtime, modulo handwaving.
> 
> To convince yourself of this, note that when DMA refill fails to meet its 
> deadline you will hear repeats, not skipping, because the DMA hardware on the 
> sound card has been set up to automatically restart the DMA each time the 
> buffer expires.  Try running the kernel under kgdb and breaking to the 
> monitor while sound is playing.
> 
> So you need to reevaluate your thinking re the realtime nature of audio 
> decoders.
> 
> To be sure, for perfect audio reproduction, any file IO involved has to be 
> realtime as well, as does the block layer.  We're not really in position to 
> take care of all that detail at this point, mainly because no Linux 
> filesystem has realtime IO support.  (I believe Irix XFS has realtime IO and 
> that part didn't get ported because of missing infrastructure in Linux.)  But 
> the block layer isn't really that far away from being able to make realtime 
> guarantees.  Mainly, that work translates into plugging in a different IO 
> scheduler.
> 
> Beyond that, there's priority inversion to worry about, which is a hard 
> problem from a theoretical point of view.  However, once we get to the point 
> where priority inversion is the worst thing about Linux audio, we will be 
> lightyears ahead of where we now stand.
> 
> 
>>Technically, you shouldn't be
>>able to get aplay to skip at all as long as no other processes are at an
>>equal or higher nice value.
> 
> 
> This got fuzzier with the interactivity hacks, which effectively allow the 
> nice values to vary within some informally defined range.
> 
> Regards,
> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


