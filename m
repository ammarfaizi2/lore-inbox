Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbVBAQuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbVBAQuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVBAQuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:50:14 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:57295 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262065AbVBAQuC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:50:02 -0500
Date: Tue, 1 Feb 2005 17:42:31 +0100 (CET)
To: adobriyan@mail.ru
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <dfju0pfr.1107276150.9406540.khali@localhost>
In-Reply-To: <200502011857.24786.adobriyan@mail.ru>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Aurelien Jarno" <aurelien@aurel32.net>, "Greg KH" <greg@kroah.com>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey,

> lm90 (all sensors chips have approximately the same speed, right?) spec
> says:

Absolutely not, it depends on the raw speed (internal clock) and the
number of channels. But in fact it doesn't matter, see below.

> "It takes the LM90 31.25 ms to measure the temperature of the remote diode
> and internal diode".

This is completely unrelated to the time it takes to read the registers.
The temperature (or other) measurements are done in the backgroud,
continuously, by the hardware monitoring chips.

> Google says: "The buses [I2C, SMBus] operate at the same
> speed, up to 100kHz, but the I2C bus has both 400kHz and 2MHz versions."

And this is what matters, because this tells you how much time it takes
to read one register. Multiply by the number of registers you need to
read (from 4 to 50, depends on the chip) and you have an approximative
total of time required by the update function, when the jiffies test
succeeds.

In other words, what matters in terms of speed is the SMBus the chip is
connected to, not the speed of the chip itself. Typical speed for
motherboard SMBus is 16kHz.

Let's look at how things work. These hardware monitoring chip drivers
export files to sysfs, which map more or less directly to the registers.
When one reads the sysfs file, the driver will attempt to read all
registers, cache all values and return the requested one. If an update
occured recently (typically less than 2 seconds ago) then the cached
value is directly returned instead. The reason why this is implemented
that way is that most chips stop monitoring when they receive read
requests. If we allowed registers to be read individually and without
caching the results, chips could possibly be kept busy forever, which
would be dangerous. We also want to avoid SMBus saturation.

Typically, people will read all sysfs files in a row (by running
"sensors" or any other hardware monitoring tool). This means that, for
a given read series:
1* The first sysfs file read will most probably trigger an update.
2* All the other sysfs file reads will hit the cache.

> What I'm trying to say that you shouldn't care about s/cmp; jcc/call/ if
> the actual measurement is infinite from CPU's POV.

That's absolutely right, optimizing the case in which the update *will*
occur (case 1* above) is worthless because it only occurs once in a
series, and is inherently slow. However, we still want to make the cache
hits (case 2* above) as fast as possible (IMHO at least) because it can
happen several dozen times in a series.

Your proposal actually slows down 1* (additional function call) but not
2*, so I'm fine with that. However, it also implies a mandatory update
at init time, which may take several seconds with no benefit, and I am
*not* fine with that.

> Well, yes, I agree that initialization will become slower. But how long is
> register read (from first outb command to the moment when CPU sees it)?
> I'm trying to build time hierarchy of things we're discussing in my head.

It's not outb/inb but (in the most common case)
i2c_smbus_read_byte_data. It *is* damn slow in comparison with any other
command, I/O or not. This is why I don't want to add any at init time
for no reason.

Thanks,
--
Jean Delvare
