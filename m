Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131421AbQLFUg0>; Wed, 6 Dec 2000 15:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbQLFUgI>; Wed, 6 Dec 2000 15:36:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2315 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130786AbQLFUf4>; Wed, 6 Dec 2000 15:35:56 -0500
Date: Wed, 6 Dec 2000 12:05:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re:  The horrible hack from hell called A20
In-Reply-To: <3A2E2C95.10603@megapathdsl.net>
Message-ID: <Pine.LNX.4.10.10012061150460.1917-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Miles Lane wrote:
> 
> If I insert both my 3c575 and Belkin BusPort Mobile USB host-controller 
> and then enable both of them, "modprobe usb-ohci" hangs.  If I then
> attempt "modprobe -r 3c59x", that process hangs, too.  lsmod shows:
> 
> 	usb-ohci     15072   1  (initializing)
> 	3c59x            0   0  (deleted)
> 	usbcore      50384   1  (autoclean) [usb-ohci]

The only thing in common between the two will be the fact that they do
share the same irq, and I'm not at all sure that those two drivers are
always happy about irq sharing.

Your dmesg output looks sane and happy, though. Both the USB and the 3c59x
driver find their hardware, and claim to have successfully initialized
them. The USB driver even finds the stuff on the USB bus (microsoft
intellimouse), so it obviously works to a large degree. Similarly, the
ethernet driver happily finds everything etc.

In fact, everything looks so happy that I bet that the reason the module
is stuck initializing is some setup problem, possibly because kusbd ends
up waiting on /sbin/hotplug or similar. It does not look like the drivers
themselves would have trouble, it looks much more like a modprobe-related
issue (maybe deadlocking on some semaphore or other lock).

I'd suggest two things:

 - try not using modules. Does it "just work" for you then? (Both the OHCI
   and the 3c59x driver should happily work with hotplug compiled right
   into the kernel).

 - try "strace"ing the whole modprobe thing, to see where it hangs, in
   order to figure out what it is waiting for. I wonder if it's the
   keventd changes.

Basically, I think this is a completely different problem, and not really
driver-related any more.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
