Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVAZKAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVAZKAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 05:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVAZKAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 05:00:44 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:21961 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262411AbVAZKAY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 05:00:24 -0500
Date: Wed, 26 Jan 2005 10:55:27 +0100 (CET)
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <ROmq5T3x.1106733327.5706070.khali@localhost>
In-Reply-To: <20050126013556.247b74bc@zanzibar.2ka.mipt.ru>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Greg KH" <greg@kroah.com>, "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Evgeniy,

> > So I suspect that this update at least was never reviewed by anyone (on
> > the sensors list at least).
>
> I have one rule - if noone answers that it means noone objects,
> or it is not interesting for anyone, and thus noone objects.

Broken rule IMHO. This might be fine for your own projects, but doesn't
work at all for the kernel. Silence might not mean that everyone agrees.
Rather, it could mean that either people are just not interested at all,
or they are too busy to review a whole new subsystem (or more) at the
moment. Believe me, kernel folks are very, very busy.

> I have pc8736x logical devices in my TODO list, but they are currently
> preempted by acrypto, but I definitely will get it very soon.

I don't think you get me. Your personal priorities are unimportant when
you are asking for code review and merge into the main kernel tree. What
matters is that parts are presented correctly and added in small chunks
and in the right order, so as to minimize the time it takes to Greg and
others to understand, review and accept it.

One year ago I learnt this the hard way myself. I realize how deep my
misunderstanding of the situation was back then, and now praise Greg for
the good lesson - however tough it was for me at that time - each time I
now send a kernel patch the right way and get it accepted.

So, make yourself a favor and comply with what the kernel folks expect
from you. They won't change for you.

> > If you can provide a patch which adds your superio core driver and one
> > which modifies the pc87360 driver to take make use of it, and only that,
> > this would certainly be easier for everyone (and especially me) to
> > review your superio code. Once this is in, incremental patches for the
> > additional features should be easier for you to generate and for the
> > rest of us to review.
>
> pc87360.c can not be used with superio as is, it requires big rewrite,
> since you implemented it as part of i2c core,
> that is why I created parts that was not touched by your driver.

Again, you clearly don't get it. The pc87360 driver does *not* require a
big rewrite. Without even looking at your superio code again, I can tell
that it is necessarily broken if every driver which accesses the superio
address space at the moment needs a big rewrite.

The pc87360 driver only really uses the superio for hardware
identification and then to get a couple configuration values (such as
subdevice I/O addresses) at startup, and then leaves it alone forever.
If we has a dedicated superio driver, it would need to provide an
interface to read, and eventually write, these values, as a replacement
for the savage direct accesses we do for now. Period. Anything else
might be nice or useful for other logical devices (such as GPIOs) but is
not strictly necessary at first.

I do not deny that these Super-I/O integrated sensors are not using the
SMBus and as such do not truly belong to the i2c subsystem. It just
happens that, for now and for historical reasons, the i2c subsystem is
also where all hardware monitoring drivers are. That might (hopefully)
change in the future, but this is a completely different problem. One
thing at a time please.

> Your driver is part of i2c core, it just not supposed to be used
> in superio, although many hardware routings could be used.

Again, some drivers in the i2c subsystem use ISA accesses; others need to
poke a couple PCI configuration registers. We did not move these drivers
to the ISA (is there even one?) or PCI subsystems. Before anything else,
these drivers are hardware monitoring drivers, and such drivers belong -
for now - to the i2c subsystem, until we can separate the i2c subsystem
from the hardware monitoring function more clearly.

So, the pc87360, it87, smsc47m1 and w83627hf drivers are not going to
move to the "superio subsystem", nor are they going to be rewritten
for it. Superio chips are only a new way to access the subdevices. What
we need for them is an extension of the request_region/release_region
mechanism, because superios introduce a two-level addressing scheme. And
this is about it.

Thanks,
--
Jean Delvare
