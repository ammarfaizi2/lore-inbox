Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbULNSl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbULNSl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbULNSl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:41:59 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:63695 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261603AbULNSlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:41:37 -0500
Date: Tue, 14 Dec 2004 19:38:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-os@analogic.com
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       kernel@kolivas.org, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041214183824.GN16322@dualathlon.random>
References: <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <20041213111741.GR16322@dualathlon.random> <20041213032521.702efe2f.akpm@osdl.org> <29495f1d041213195451677dab@mail.gmail.com> <Pine.LNX.4.61.0412140914360.13406@chaos.analogic.com> <29495f1d041214085457b8c725@mail.gmail.com> <20041214171503.GG16322@dualathlon.random> <Pine.LNX.4.61.0412141304070.15800@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412141304070.15800@chaos.analogic.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 01:22:03PM -0500, linux-os wrote:
> Yield used to not show a spin in `top`.  Also, contrary to
> "popular" opinion, not all events are accompanied by interrupts.

Yes, ppa zip drive has the same issue.

yield shows a spin in top if it's the only running task. Otherwise it
will wait other task to run first. The behaviour has changed a bit
between 2.4 and 2.6, and we changed the corner cases. But the semantics
of yield are still the same.

> If they where, I'd gladly use one of the sleep_on* functions.

Minor detail: sleep_on is obsolete and should be deleted since it
requires the big kernel lock or the global cli to be safe. But I got the
point ;)

> For instance, I need to erase NVRAM (Flash). Then I need to
> program each byte. Waiting for the completion events requires
> polling the hardware. Proper software will give up the CPU
> while waiting and only sample the event, not continually spin.

This is a case where you know when you can expect the hardware to be
done (just like it was the case for the ppa zip). While dealing with
long hardware delays schedule_timeout makes plenty of sense. It would be
pointless to yield and spin, if you know nothing good can happen in the
next millisecond.

> The timeout of (0) was really to make the code more obvious, the
> facts being that we really need to get the CPU back as soon as
> there are no higher-priority tasks computable. If yield() would

With schedule_timeout(1) you're probably going to become interactive,
and you'll be scheduled before other tasks. That's good. I mean the
scheduler sorts things out automatically.

> work like schedule(0), of course I'd use it. The major problem
> with yield() probably has to do with accounting. The machine
> "feels" as though the CPU is properly available when you need
> it, however it appears to be spinning, using 100% system time.
> This makes customers nervous.

It's as well a waste of energy power to spin when you can
schedule_timeout(1).

So you're optimal at using schedule_timeout(1) in this case while
waiting hardware to complete as far as I can tell.
