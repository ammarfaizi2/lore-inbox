Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVATLOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVATLOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 06:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVATLOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 06:14:45 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:21999 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262117AbVATLOh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:14:37 -0500
Date: Thu, 20 Jan 2005 12:08:47 +0100 (CET)
To: nico@cam.org, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <CPrisGfK.1106219326.9605690.khali@localhost>
In-Reply-To: <Pine.LNX.4.61.0501191608010.5315@localhost.localdomain>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Jonas Munsin" <jmunsin@iki.fi>, "Simone Piunno" <pioppo@ferrara.linux.it>,
       "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nicolas,

> > I would also appreciate a dump of the chip (isadump 0x295 0x296 unless
> > it lives at some uncommon address) to confirm the guess.
>
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 10 80 00 37 ff 00 37 ff 07 13 5b 00 51 40 ff
> 10: fe fe ff 71 d7 fe 7f fe 00 00 ff ff ff ff ff ff

Interesting. Your chip does seem to be configured (i.e. pwm polarity is
high), so whatever your problem is, it is probably different from what
Simone experienced.

Your configuration is as follow:
* PWM outputs active high.
* PWM 2 and 3 in on/off mode, set to on.
* PWM 1 in "smart guardian" mode, set to automatic PWM depending on
temp3.

I would like to know how temperature channels are used by your
motherboard, and how fans are used as well. Which temperature and fan
channels correspond to your CPU? What other temperature sensors and fans
are present?

The values dumped here make me believe that the PWM outputs were
configured by the BIOS. Now maybe not the correct way, at least for you.

> I guess the BIOS setting will simply be overwritten so changing the BIOS
> should not affect subsequent use, no?

Changing the BIOS configuration affects the initial register
configuration, from which the it87 driver decides whether using PWM or
reconfiguring the chip (changing polarity) is safe or not. This is why
it might help. With the dump you provided, we now know that the (new)
it87 driver will accept PWM operations even when your BIOS was left in
"smart guardian" mode.

I would like you to give a try to a recent version of the it87 driver (as
found in 2.6.11-rc1-bk7 or 2.6.11-rc1-mm2). This will let us know which
revision of the IT8712F you have (in case it matters), and will also let
you experiment with manual PWM.

If manual PWM works, then the problem is in the way temperature interacts
with PWM in automatic mode.

If manual PWM works the wrong way around (like it did for Simone) then it
is a polarity issue (after all, maybe *you* need active low).

If manual PWM half works (fan speed changes but not as much as it should)
it might be a problem of picking the correct base frequency for PWM.

So please let us know how manual PWM behaves, and I'll tell you what I
think the problem is, and how I think it can be tinkered with (providing
it can).

In the meantime, you could contact Gigabyte and explain about the
problem. They better learn about the problem and fix their BIOS is
needed.

Thanks,
--
Jean Delvare
