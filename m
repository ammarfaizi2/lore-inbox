Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbULNS0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbULNS0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbULNS0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:26:22 -0500
Received: from alog0355.analogic.com ([208.224.222.131]:17280 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261577AbULNS0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:26:07 -0500
Date: Tue, 14 Dec 2004 13:22:03 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       kernel@kolivas.org, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
In-Reply-To: <20041214171503.GG16322@dualathlon.random>
Message-ID: <Pine.LNX.4.61.0412141304070.15800@chaos.analogic.com>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz>
 <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
 <20041213030237.5b6f6178.akpm@osdl.org> <20041213111741.GR16322@dualathlon.random>
 <20041213032521.702efe2f.akpm@osdl.org> <29495f1d041213195451677dab@mail.gmail.com>
 <Pine.LNX.4.61.0412140914360.13406@chaos.analogic.com>
 <29495f1d041214085457b8c725@mail.gmail.com> <20041214171503.GG16322@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Andrea Arcangeli wrote:

> On Tue, Dec 14, 2004 at 08:54:29AM -0800, Nish Aravamudan wrote:
>> Hmm, schedule_timeout(0) working that way is interesting. There is
>> also the option to use schedule_timeout(MAX_SCHEDULE_TIMEOUT) which
>> should sleep indefinitely (depending of course on the conditions of
>> the state). Oh but I think I understand what you're saying... the
>> driver needs to sleep indefinitely in total (potentially), but needs
>> to be able to return quite often (like yield() used to) so they could
>> check a condition...
>>
>> Thanks for the input!
>
> what do you mean like yield() used to? yield() is still there in latest
> 2.6, just call yield() and you'll get the same effect of sched_yield in
> userspace. yields in the kernel are a bad thing though (they usually
> mean code is not well written, code should be event driven not polled
> driven).
>

Yield used to not show a spin in `top`.  Also, contrary to
"popular" opinion, not all events are accompanied by interrupts.
If they where, I'd gladly use one of the sleep_on* functions.

For instance, I need to erase NVRAM (Flash). Then I need to
program each byte. Waiting for the completion events requires
polling the hardware. Proper software will give up the CPU
while waiting and only sample the event, not continually spin.

You can get away with software murder if you only need to program
something that saves some state between shutdowns. However, if
you have a writable flash file-system you need to do it right.

> Note that __set_current_state(..); schedule_timeout(0) is not like
> yield. yield will return immediatly if it's the only task running. A
> yielding loop will consume all available cpu, while the
> schedule_timeout(0) will wait less than 1/HZ sec. But really

The timeout of (0) was really to make the code more obvious, the
facts being that we really need to get the CPU back as soon as
there are no higher-priority tasks computable. If yield() would
work like schedule(0), of course I'd use it. The major problem
with yield() probably has to do with accounting. The machine
"feels" as though the CPU is properly available when you need
it, however it appears to be spinning, using 100% system time.
This makes customers nervous.

> schedule_timeout(0) makes little sense, either use schedule_timeout(1)
> and explicitly wait 1msec, or use yield. schedule_timeout(0) just
> happens to work because the timer code has to approximate for excess and
> it will wait for the next timer irq for timeouts <= 0 and it will wait
> for two ticks for timeouts == 1 etc...
>
> I guess we could change schedule_timeout() to WARN_ON if 0 is being
> passed to it.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
