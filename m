Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262495AbTCRTtr>; Tue, 18 Mar 2003 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262515AbTCRTtr>; Tue, 18 Mar 2003 14:49:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25222 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262495AbTCRTtp>; Tue, 18 Mar 2003 14:49:45 -0500
Date: Tue, 18 Mar 2003 15:03:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Steve Lee <steve@tuxsoft.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Linux-2.4.20 modem control
In-Reply-To: <001a01c2ed85$66ac5b00$0201a8c0@pluto>
Message-ID: <Pine.LNX.4.53.0303181437560.27964@chaos>
References: <001a01c2ed85$66ac5b00$0201a8c0@pluto>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, Steve Lee wrote:

> Please excuse my lack of understanding.  My dial-in box (using mgetty)
> is running on a dual Athlon 1900 MP system.  Previous system was a dual
> P3 450.  I've called into the Athlon system multiple times a day for
> almost a year now, the previous system, for several years.  What issue
> should I be seeing?  At times, I send some files home and when I get
> home I'll have to manually reset the modem (reset button), however,
> mgetty resets and is ready to answer again.  I have mgetty configured to
> skip the first call, then answer with the modem if another call happens
> within 45 seconds.
>
> Steve

My modem is initialized upon boot using a program that writes
the correct initialization strings to it so it will answer on
the first ring as long as DTR is high. This is never changed
nor touched until the next boot. FYI the correct settings are
not set into the modem's NVRAM (using AT&W) because the NVRAM
will wear out and not retain any settings. I ran BBS systems
since CP/M days so I know how to set up a modem. The terminal
driver is set at a high-speed with hardware flow-control. The
speed is never changed either.

A terminal driver `agetty` is set up in /etc/inittab to handle
logins. The speed is set to the same high-speed as in above. The
getty is set to leave the driver speed alone (no auto-baud). You
can use mgetty agetty, etc. They all work the same. You just don't
use mingetty because it doesn't "do" modems.

I dial up from home (or duplicate it from my office so I can
see and measure what happends). The modem answers and synchronizes.
Once the getty's open() succeeds, it writes the contents of
/etc/issue out the modem and presents me with a login prompt.

I log-in. Fine. Wonderful. Great. It works! NOT! Now log out.
Do you have the "NO CARRIER" message from your modem? No. You
get the damn login prompt again because the terminal didn't
hang up. So, you type "+++", get your "Ok", and enter ATH. You
forced a hang-up. The modem, 66 miles away in your office, will
never answer again. It is now permanently off-line because
your getty is waiting for an open() which will never happen
because DTR went low on the forced disconnect and only something
that opens O_NONBLOCK will ever open the terminal to raise the
DTR so it will answer calls again.

You can configure your modem to ignore DTR. If you do, you will
invite every kid in the neighborhood to become root because you
can (read will) end up with a live shell connected to the modem.

It is necessary that, upon the final close, a terminal defined
to be a modem (not CLOCAL, with HUPCL enabled), lower DTR for
at least a few hundred milliseconds. It must then raise DTR
before the final close() returns to the caller. That way, when
the next instance of a getty gets control from init, its DTR
is enabled, waiting for another call. All these getties sleep
(block) in open().

The temporary work-around is to modify a getty so it opens
the modem non-blocking, hangs up (lowers DTR), then raises
DTR, then closes(). After that, it can sleep in a blocking-
open for the next caller.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

