Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbULML3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbULML3Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbULML3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:29:24 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:38063 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262228AbULML3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:29:17 -0500
Date: Mon, 13 Dec 2004 12:28:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213112853.GS16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041212234331.GO16322@dualathlon.random> <cone.1102897095.171542.10669.502@pc.kolivas.org> <20041213002751.GP16322@dualathlon.random> <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412121817130.16940@montezuma.fsmlabs.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 06:50:30PM -0700, Zwane Mwaikambo wrote:
> Well most x86(64) these days have local APICs and that provides a 
> relatively inexpensive one shot timer mode.

I doubt a one shot is appropriate. The irq latency is variable and we
won't be able to atomically read tsc and rearm the one-shot timer. The
intemediate error will propagate over time.

You were the one making the case of the NMI, the NMI will screw
completely any attempt of rearming the TSC accurately (though I don't
mind too much, like for the sti; hlt, since NMI is pratically impossible
to trigger in production, if a NMI is fired we've more troubles than the
1/HZ latency on a pending wakeup or on the system time taking the
tangent ;)

Note that what we would have to implement to use a one-shot timer for
timekeeping, it's very similar to the algorithm we already have if the
timer irq get lost because we lost one tick.

My USB modem generates a flood of irq latency >1msec (I tried to track
it down where it comes from but I failed, it seems not a cli but just
the usb_uhci interrup taking 3msec to execute, and the timer irq failing
to execute nested, perhaps I could fix it by forcing irq priorities by
hand), so the tick-loss-adjustment always trigger on my firewall, and it
costantly goes in the future of a minute per hour or so. I had to hack
the code myself to reduce a bit the tsc value and now it's almost in
time, randomly deviating in future and past (note the deviation with the
mainline code is too huge that ntpd has no way to fix it, and it's like
having ntp turned off). It's too bad I couldn't yet find any bug in the
tick-loss adjustment algorithm yet.

In the current tick-loss adjustment case it's the
delay_at_last_interrupt and rdtscl that can't be atomic and that will
force an error on us. In the one shot case it's the read of the tsc and
the rearming that cannot be atomic and it will force an error on the
system time.

Now perhaps the error is small enough with a fast programming chip like
the apic, but the awful results I've got out of the lost-tick adjustment
scares me a bit to depend on a variable error to make the system time
accurate.

Even with the PIT, HZ=100/1000 are two numbers were we can get decent
accuracy, there are probably other frequencies where the accuracy is
less.

(btw, my firewall systemtime will get fixed too by dyanmic-hz HZ=100,
it's pure waste to keep my firewall at HZ=1000 even if I didn't have
constant irq-latency of 3/4msec [measured with rdtsc], though I didn't
mention this yet because dynamic-hz in my firewall case would be a pure
band-aid, even fixing the tick-lost adjustment would be a band-aid, the
only thing to fix is the usb irq that runs for 3/4msec without returning).
