Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291890AbSBARxj>; Fri, 1 Feb 2002 12:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291887AbSBARx2>; Fri, 1 Feb 2002 12:53:28 -0500
Received: from logic.net ([64.81.146.141]:20356 "EHLO logic.net")
	by vger.kernel.org with ESMTP id <S291886AbSBARxN>;
	Fri, 1 Feb 2002 12:53:13 -0500
Subject: PCI Problems [was Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)]
From: "Edward S. Marshall" <esm@logic.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3C5984C9.20104@candelatech.com>
In-Reply-To: <Pine.LNX.4.44.0201311741430.5601-100000@flubber.jvb.tudelft.nl> 
	<3C5984C9.20104@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Feb 2002 11:52:06 -0600
Message-Id: <1012585929.1843.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-31 at 11:54, Ben Greear wrote:
> The only lockup problems I have run into are connecting some eepro nics to
> a 10bt hub, and using (cheap arsed, it appears) PCI riser cards.  I have
> heard of some SMP related issues, but nothing concrete, and I don't
> have any SMP systems personally.  You could try the e100, but I have
> no idea if it will be better or worse for your particular problem.

I was running into the same problems here; SMP system w/PCI riser card
(HP NetServer LPr), connected to a 10/100 switch. I'd get
"wait_for_command_timeout" errors all the time under moderate network
load. Switching to the e100 driver didn't help in the slightest.
Eventually, I'd experience a complete system lockup.

Replacing the card with a 3c59x-based card put the machine back in
service (I've completely written eepro100s off as a viable cards now),
although I still saw occasional PCI-related issues. Specifically:

Jan 23 10:11:37 x kernel: Uhhuh. NMI received. Dazed and confused, but
trying to continue
Jan 23 10:11:37 x kernel: eth0: Host error, FIFO diagnostic register
0000.
Jan 23 10:11:37 x kernel: eth0: PCI bus error, bus status 80000020
Jan 23 10:11:37 x kernel: You probably have a hardware problem with your
RAM chips
Jan 23 10:11:37 x kernel: eth0: Host error, FIFO diagnostic register
0000.
Jan 23 10:11:37 x kernel: eth0: PCI bus error, bus status 80000020

The last two messages will repeat indefinitely, usually with a hit to
the dist for each pair of log entries (resulting in a very distinctive
drive grinding). Memory problems don't seem to be the issue; with a
fairly extensive run of memtest86, everything came back clean.

Taking a few minutes to try and rectify the situation, I started
shutting down services and manually unloading modules to see what was
causing the problem. Unloading usbcore did the trick:

Jan 26 18:41:24 x kernel: eth0: Host error, FIFO diagnostic register
0000.
Jan 26 18:41:24 x kernel: eth0: PCI bus error, bus status 80000020
Jan 26 18:41:24 x kernel: eth0: Too much work in interrupt, status e003.
Jan 26 18:41:24 x kernel: usb.c: USB disconnect on device 1
Jan 26 18:41:24 x kernel: USB bus 1 deregistered

I've rebooted the machine since then, but have always unloaded usb-uhci
and usbcore after booting. The issue hasn't cropped up again, although
it happened every couple of days previously.

The kernel in question is Red Hat's kernel-smp-2.4.9-21 build.

-- 
Edward S. Marshall <esm@logic.net>                       
http://esm.logic.net/
-------------------------------------------------------------------------------
[                  Felix qui potuit rerum cognoscere causas.            
]

