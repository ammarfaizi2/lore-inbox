Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbUKAQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUKAQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273529AbUKAPt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:49:26 -0500
Received: from mail3.utc.com ([192.249.46.192]:13229 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S271716AbUKAPaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 10:30:08 -0500
Message-ID: <41865662.3080902@cybsft.com>
Date: Mon, 01 Nov 2004 09:29:38 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Schmidt <mista.tapas@gmx.net>
CC: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
References: <1099171567.1424.9.camel@krustophenia.net>	<20041030233849.498fbb0f@mango.fruits.de>	<20041031120721.GA19450@elte.hu>	<20041031124828.GA22008@elte.hu>	<1099227269.1459.45.camel@krustophenia.net>	<20041031131318.GA23437@elte.hu>	<20041031134016.GA24645@elte.hu>	<20041031162059.1a3dd9eb@mango.fruits.de>	<20041031165913.2d0ad21e@mango.fruits.de>	<20041031200621.212ee044@mango.fruits.de>	<20041101134235.GA18009@elte.hu> <20041101150356.4324c4c9@mango.fruits.de>
In-Reply-To: <20041101150356.4324c4c9@mango.fruits.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt wrote:
> On Mon, 1 Nov 2004 14:42:35 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>* Florian Schmidt <mista.tapas@gmx.net> wrote:
>>
>>
>>>new max. jitter: 4.3% (41 usec)
>>>new max. jitter: 4.9% (47 usec)
>>
>>a couple of conceptual questions: why does rtc_wakeup poll() on
>>/dev/rtc? Shouldnt a read() be enough?
> 
> 
> well, it works like this:
> 
> 
> while(!stopit) {
> 	// returns when data is ready
> 	poll(on /dev/rtc);
> 
> 	// when ready generate the timestamp
> 	cycles = get_cycles();
> 
> 	// now read the data	
> 	read(on /dev/rtc);			
> 
> 	// and now stuff the data (including timestamp) into the ringbuffer
> 
> 	// rinse and repeat
> }
> 
> i get the timestamp before reading because i figured i want to take the
> timestamp as close as possible to data being available. The read() and
> passing the data to the other thread done after the timestamp generation (in
> that ca. 1 - 0.1 ms (1024 - 8192 hz) time window which we have until the
> next irq occurs)
> 
> 
>>i'm seeing some weird traces, which show rtc_wakeup doing this cycle:
>>
>>	[~900 usecs pass]
>>
>>	hardirq 8 comes in, wakes IRQ 8 thread
>>	IRQ 8 thread wakes up rtc_wakeup
>>
>>	rtc_wakeup fast-thread returns from sys_read()
>>	rtc_wakeup fast-thread enters sys_poll() and returns immediately
>>	rtc_wakeup fast-thread enters sys_read() and blocks
> 
> 
> weird. why could poll return immeaditly? Only when data should be available
> right? Ahh, maybe there's less data available than which is needed by
> read(). I suppose i need to check if enough data is available. If not,
> repoll(), then generate the timestamp. Then read(). I had the impression
> that this small amount of data which rtc delivers (4 bytes i think) would
> not be split into smaller parts.
> 
> It never occured to me that poll() could return with incomplete rtc data
> available..
> 
> As i don't know of any way of finding out how much data is available i
> suppose we can just make the poll() a read(). I suppose overhead is
> neglectable right?
> 
Someone please correct me if I'm wrong, but is there any MORE overhead 
associated with a blocking read than with a poll or select? Won't the 
process just go to sleep until there is data available?

> 
>>	rtc_wakeup slow-thread runs and does the calculations.
>>
>>	[repeat]
>>
>>this i think shows that the logic is wrong somewhere and that read()
>>will achieve the blocking. This also means that the sys_read()-return +
>>sys_poll() overhead is added to the 'IRQ wakeup' overhead!
>>
>>removing the poll() lines doesnt seem to impact the quality of the data,
>>but i still see roughly 50 usecs added to the 'real' latency that i see
>>in traces.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

