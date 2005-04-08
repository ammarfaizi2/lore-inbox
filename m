Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVDHLNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVDHLNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 07:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVDHLNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 07:13:48 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:47836 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262706AbVDHLNa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 07:13:30 -0400
Date: Fri, 8 Apr 2005 13:08:46 +0200 (CEST)
To: ladis@linux-mips.org
Subject: Re: [PATCH] ds1337 4/4
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <FxPJVIPZ.1112958526.4787880.khali@localhost>
In-Reply-To: <20050407231904.GE27226@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "James Chapman" <jchapman@katalix.com>, "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav,

> Add support for DS1339. The only difference against DS1337 is Trickle
> Charge register at address 10h, which is used to enable battery or gold
> cap charging. Please note that value may vary for different batteries,
> so it should be made module parameter. 0xaa is sane default and also
> matches my board ;-)

"Sane default" is a non-sense here. A sane default is that loading a
real-time clock driver should not affect the battery at all IMHO.

Can you tell us more on that battery thing? I admit I don't exatcly get
what it is. Which type of battery are we talking about? Are there
similar drivers in the kernel tree already?

Sounds weird to me that loading a driver would enable charging of a
battery, and removing it wouldn't disable it. And since the driver
might not be removed, it would possibly make more sense to have an entry
in /sys to enable and disable this thing.

Also, arbitrarily picking one of the 6 possible charging modes just
because it matches your board is a bad idea. It looks like a value which
should be set on a per-board basis, rather than picked randomly by the
user, so as to avoid accidental hardware breakage.

> +static int ds1339_charge = 0xaa;

I see little reason why this would be a global variable rather than a
define (let alone the fact that this shouldn't be hardcoded at all
IMHO, as I just explained).

> +/*
> + * DS1339 has Trickle Charge register at address 10h. During a multibyte
> + * access, when the address pointer reaches the end of the register space,
> + * it wraps around to location 00h.
> + * We read 17 bytes from device and compare first and last one. If they
> + * are same it is most likely DS1337 chip.
> + */
> +static int ds1337_is_ds1339(struct i2c_client *client)
> +{
> +	char buf[17], addr = 0;
> +	struct i2c_msg msg[2];
> +	int result;
> +
> +	msg[0].addr = client->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = 1;
> +	msg[0].buf = &addr;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = sizeof(buf);
> +	msg[1].buf = buf;
> +
> +	result = i2c_transfer(client->adapter, msg, 2);
> +	if (result < 0) {
> +		dev_err(&client->dev, "error reading data! %d\n", result);
> +		return 0;
> +	} else
> +		return (buf[0] == buf[16]) ? 0 : 1;
> +}

This will fail eventually. The first register is the seconds count, which
by definition is changing. I2C is slow, by the time you wrap over the
register range, the value could have changed. The datasheet explicitely
says that the register cache will refresh on address wrapping.

Also, 0x00 is a possible value for both the seconds count and the battery
register, so you could miss a DS1339 at times.

One possible check to start with would be on the value of the additional
register itself. It has only 7 possible values. But of course it would
be better if we could default to a DS1337 and find a way to identify the
DS1339, rather than the (unsafe) other way around. I also don't know
what a DS1337 will answer for this missing register. Maybe James can
help?

One possibility would be to start reading at 0x0E instead of 0x00,
because register 0x00 is the control register and is the only one which
will not change in our back as far as I can see. Oh, and the additional
battery register too. But this still doesn't sound like a bulletproof
method to me (we depend on the seconds and possibly minutes count
again). So it would be better to additionally perform the same tests
that were done on the non-wrapped registers for the regular DS1337
detection, but on the wrapped area.

The problem here is that all this will significantly increase the
detection delay.

Yet another method would be to write a non-significant value to the
battery register, such as 0x80. If we can read it back then it has to be
a DS1339. But what effect will it have on the DS1337? I'd hope none,
but this better be verified. And in general I don't much like using
register writes in detection methods.

Could you please provide the output of i2cdump in b and c modes for your
DS1339 chip? This might help finding an detection method. A similar dump
for the DS1337 would help too.

> -	const char *name = "";
> +	const char *name;
(...)
> +	default:
> +		name = "";
> +	}

This is noise.

Thanks,
--
Jean Delvare
