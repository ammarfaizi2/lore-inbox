Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVIYR5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVIYR5p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbVIYR5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 13:57:45 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:30224 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932253AbVIYR5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 13:57:44 -0400
Date: Sun, 25 Sep 2005 19:57:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Request only really used I/O ports in w83627hf driver
Message-Id: <20050925195735.1ef98b40.khali@linux-fr.org>
In-Reply-To: <431F4006.6060901@vc.cvut.cz>
References: <20050907181415.GA468@vana.vc.cvut.cz>
	<20050907210753.3dbad61b.khali@linux-fr.org>
	<431F4006.6060901@vc.cvut.cz>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

Sorry for the delay.

> No, it would perfectly work.  W83627HF (and all other hardware monitoring
> chips from Winbond) respond only to xxx5 and xxx6 address, not to the
> other addresses in the range xxx0-xxx7. So requesting full 8 byte range
> is not only unnecessary, but also incorrect.

Incorrect WRT to which specification or coding rules guide, please?

> For example I can place 4-byte printer port at 0xC00-0xC03, while sensors
> live at 0xC05-0xC06.  If I place sensors and serial port at same address,
> I get bytes (from C00-C07) "04 00 01 00 13 40 01 00".  When I move senors
> away, I get "04 00 01 00 13 06 00 00", so you can see that only address + 5
> and + 6 are affected.  And when I move serial port away, leaving sensors
> in place, I see "FF FF FF FF FF 40 01 FF" - again chip respons to +5 & +6
> addresses only, not to the full range.

I see a problem with your demonstration. Your 4-byte printer port was
seemingly affecting not only 0xC00-0xC03, but also 0xC04 and 0xC07. Had
you tried without sensors in the way, I bet we would have seen ports
0xC05 and 0xC06 change values as well. This means that your printer port
does answer to reads on I/O ports it has no use for. This is exactly
what I (erroneously) thought would happen with the W83627HF chip.

I'm no electronics expert (far from that actually) but isn't it a
problem, from an electronic point of view, to have two devices
competing for I/O ports? What if your printer port were "stronger" than
your W83627HF? My guess is that the latter wouldn't work anymore.

I just checked on an IT8705F Super-I/O with hardware monitoring. It has
an 8-byte I/O region with +5 and +6 only used, just like the W836x7HF
family. The device presence changes the I/O region from:
  ff ff ff ff ff ff ff ff
to:
  04 04 04 04 04 51 04 04
So, the IT8705F definitely answers on the full I/O range, even ports it
isn't supposed to care about, just like the printer port in your
example. Same is true of the IT8712F, BTW.

> And even if it would answer to the other addresses, you should not request
> them, as driver apparently does not need them, while some other driver might.

This is a non-issue until this hypothetical other driver exists.

> Take a look at i2c-amd756 driver for example.  It uses bytes 0xE0-0xEF
> from large 256 byte I/O window on amd7x6/amd8111 chips.  And it correctly
> requests only region 0xE0-0xEF, so other drivers can drive other parts
> of the chip.

In this case, the rest of the region has other uses, and other drivers
actually need it, so this is a different situation. As far as I can see,
no driver is going to need the leftover I/O ports from hardware
monitoring chips. If these ports are ever used at some point in time,
we can reasonably assume that the new feature needing them will belong
to the same hardware monitoring driver.

> I do not agree with your analysis here.  Chip just wants 8 byte aligned
> address, nowhere in the documentation is stated that full 8 bytes are
> used, actually doc is quite explicit that accesses are decoded only if
> low nibble is 5 or 6 (for example w83627hf/f/hg/g datasheet revision A1,
> page 28).

This is a valuable technical information, and it conforms to your
experimental results above. This seems to differ from the behavior of
the IT87xxF chips and your printer port.

> It is not buggy BIOS.  It is incorrect assumption of driver writter about
> hardware, and about request_region API.  If you want to put potential
> resources to the tree, you should not tag them BUSY, as they are not
> busy, they are free for use by the driver.

There are plenty of drivers out there which request more I/O ports than
they strictly need, just because the author knew that no other driver
would ever need these. Reasons to do this are multiple: sparse used I/O
ports (you're not going to call request_region 3 times if you need 3 I/O
ports spread over a large I/O region), plans to implement more features
in that driver in the future, anticipation of hardware evolution. You
really can't blame the driver writer.

> No.  Unfortunately BIOS knows how hardware works while w83627hf driver
> apparently does not, so I do not think manufacturers are going to break
> BIOS just to match Linux driver expectations.

Sure, BIOSes are never broken :)

My summarized impression is that what matters here is not the fact that
a given driver does or does not need a given I/O port, but the fact
that a given chip will or will not decode the I/O requests for all
ports within its base I/O range. I agree it does make sense, and should
be safe, not to request I/O ports that are not *decoded* by a chip.
OTOH, I would expect problems to arise if two devices have intersecting
base I/O ranges and at least one I/O port is decoded by both devices. I
would expect even more problems if one device does use that one I/O
port.

This leads me to the following conclusions:
1* Reserving only 0x295-0x296 for the W836x7HF family of chips should
be safe, if and only if all other drivers do reserve all I/O ports they
decode, as opposed to only I/O ports they have a use for.
2* Your printer port above should really reserve the 8 I/O ports it
decodes, rather than just the 4 it needs. Which driver is this?

The bottom line is that I am now inclined to accept your patch. I would
only ask you for one minor change: please drop the local "addr"
variable you have been introducing, you can do without it very easily
and it should make the code more readable.

I would also want you to check that all of the W83627HF, W83627THF,
W83697HF and W83637HF chips do not decode ports other than +5 and +6. I
hope and guess so, but if not we will need slightly more complex code.

Could you please additionally check whether this applies to the
W83627EHF/EHG chips as well? Maybe we need to modify the w83627ehf
driver in a similar way.

Thanks,
-- 
Jean Delvare
