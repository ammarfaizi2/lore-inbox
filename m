Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQKMVgz>; Mon, 13 Nov 2000 16:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQKMVgp>; Mon, 13 Nov 2000 16:36:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55311 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129219AbQKMVga>;
	Mon, 13 Nov 2000 16:36:30 -0500
Date: Mon, 13 Nov 2000 12:18:33 -0800
From: David Hinds <dhinds@valinux.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: Re: PATCH: Pcmcia/Cardbus/xircom_tulip in 2.4.0-test10.
Message-ID: <20001113121833.A1725@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you try the test11-pre2 patch? It includes a bugfix to
> xircom_tulip from Andrea. 

Andrea's fix doesn't actually solve the problem; it merely changes the
set of working configurations to a set that includes Andrea's setup.
I don't know whether the size of the working set gets larger or
smaller.

There is something fundamentally broken/weird about how the receive
filter works on the Xircom cards.  It is at least deterministic, but
different network configurations behave very differently and I haven't
been able to figure out the logic.  One version of the driver will
work perfectly for everyone that uses DHCP... another version will
work fine for people who specify a static IP address... another
version will work for people who use Red Hat's network configuration
script but not the default PCMCIA script.  The best I've been able to
figure out, is that whether a call to set_rx_mode() will work or lock
up the card depends on the history of what has gone on before (whether
the card has had traffic through it), where the rx filter setup frame
goes in the transmit ring, the alignment of the frame, and how many
times set_rx_mode() has been called.  Certain combinations work, other
combinations don't.

The effect of "ifconfig eth0 -multicast" (which should be a no-op) is
that it calls set_rx_mode() with the same set of parameters it was
called with before.  Doing this one or more times may kick the card so
that it starts working.  The number of times is constant for a given
network configuration, and varies between 0 and 3.

I wasted a lot of time trying to figure out the rules for when
set_rx_mode() would work and eventually gave up; I'm waiting for
Xircom to give me an explanation.

-- Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
