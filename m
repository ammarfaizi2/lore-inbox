Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbULNRPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbULNRPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbULNRPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:15:45 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:12769 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261561AbULNRPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:15:15 -0500
Date: Tue, 14 Dec 2004 18:15:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: linux-os@analogic.com, Andrew Morton <akpm@osdl.org>, kernel@kolivas.org,
       pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041214171503.GG16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <20041213111741.GR16322@dualathlon.random> <20041213032521.702efe2f.akpm@osdl.org> <29495f1d041213195451677dab@mail.gmail.com> <Pine.LNX.4.61.0412140914360.13406@chaos.analogic.com> <29495f1d041214085457b8c725@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d041214085457b8c725@mail.gmail.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 08:54:29AM -0800, Nish Aravamudan wrote:
> Hmm, schedule_timeout(0) working that way is interesting. There is
> also the option to use schedule_timeout(MAX_SCHEDULE_TIMEOUT) which
> should sleep indefinitely (depending of course on the conditions of
> the state). Oh but I think I understand what you're saying... the
> driver needs to sleep indefinitely in total (potentially), but needs
> to be able to return quite often (like yield() used to) so they could
> check a condition...
> 
> Thanks for the input!

what do you mean like yield() used to? yield() is still there in latest
2.6, just call yield() and you'll get the same effect of sched_yield in
userspace. yields in the kernel are a bad thing though (they usually
mean code is not well written, code should be event driven not polled
driven).

Note that __set_current_state(..); schedule_timeout(0) is not like
yield. yield will return immediatly if it's the only task running. A
yielding loop will consume all available cpu, while the
schedule_timeout(0) will wait less than 1/HZ sec. But really
schedule_timeout(0) makes little sense, either use schedule_timeout(1)
and explicitly wait 1msec, or use yield. schedule_timeout(0) just
happens to work because the timer code has to approximate for excess and
it will wait for the next timer irq for timeouts <= 0 and it will wait
for two ticks for timeouts == 1 etc...

I guess we could change schedule_timeout() to WARN_ON if 0 is being
passed to it.
