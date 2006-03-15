Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752015AbWCOJG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbWCOJG4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 04:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCOJG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 04:06:56 -0500
Received: from [213.91.10.50] ([213.91.10.50]:29427 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1752015AbWCOJGz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 04:06:55 -0500
Date: Wed, 15 Mar 2006 10:01:47 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: Re: sis96x compiled in by error: delay of one minute at boot
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <zJe6kSDV.1142413307.3312800.khali@localhost>
In-Reply-To: <20060315034625.GA21733@jupiter.solarsys.private>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       "Etienne Lorrain" <etienne_lorrain@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Wed, 15 Mar 2006 10:01:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,

On 2006-03-15, Mark M. Hoffman wrote:
> Lots of drivers printk messages when they load - IMO it's useful info.
> E.g. how else could Etienne discover that he accidentally built a kernel
> with dozens of i2c bus drivers (and probably all of the hwmon drivers)
> built-in by accident?

The size of the kernel would be a good hint to start with, the boot time
would complement that, and a quick look at .config is the definitive
answer. What the i2c-sis96x driver message did here is cause Etienne to
accuse this driver for the boot delay he was observing, while other
drivers are in fact responsible for it, so it did not help at all.

If all drivers were actually printking messages when they load,
monolithic kernels would be a mess (not that I much understand the point
of such monolithic kernels, but...) You wouldn't be able to tell from
the boot log which drivers are actually used by the system, and which
aren't.

> Wow, that's a huge delay.  One alternative would be for i2c slaves to
> behave more like USB and do the probing asynchronous to driver load;
> i.e. 'modprobe w83627hf' returns before the chip is actually recognized
> and attached.

You mean that the i2c subsystem would finally be rewritten from scratch
to comply with the driver model? I'm waiting for your patches :)

> OTOH, that brings up all the related problems.  E.g., you could no longer
> expect this simple fragment of a RC script to work...
>
>	modprobe i2c-sis96x
>	modprobe asb100
>	sensors -s

I guess we would have to use hotplug instead then.

> Short of fixing all that... one has to accept that (1) i2c bus probing
> is slow, and (2) some i2c busses themselves are not reliably
> detectable...

Things can be improved still. The busses which cannot be reliably
detected could test themselves, and discard themselves if they find they
don't work. This is much the spirit of the bit_test parameter of the
i2c-algo-bit module; it could be made the default. i2c-algo-pca could be
added a similar option.

Also, the i2c subsystem is currently relying on general probing for
almost everything. Whenever you load an i2c chip driver, it'll probe
all the i2c busses for supported chips. We tried to limit the probing
area by introducing the concept of "classes", and we now only probe
the busses which share a class with the i2c chip driver. Not all drivers
have been modified to take benefit of that class check though, and the
i2c core doesn't enforce it at the moment; it is all based on drivers
cooperation. So there is room for improvement here.

Last, sometimes you know exactly where the chip is, yet the i2c core
doesn't offer a way to skip the probing step and attach the driver
directly to the device. I'm working on a way to do that, and hope to
have something ready to show soon. This should speed up the driver load
quite a bit.

Thanks,
--
Jean Delvare
