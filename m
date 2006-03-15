Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWCODqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWCODqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWCODqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:46:36 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:28351 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S964805AbWCODqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:46:35 -0500
Date: Tue, 14 Mar 2006 22:46:25 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: sis96x compiled in by error: delay of one minute at boot
Message-ID: <20060315034625.GA21733@jupiter.solarsys.private>
References: <20060313223824.79218.qmail@web26915.mail.ukl.yahoo.com> <9M1JwY7o.1142329434.1027530.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9M1JwY7o.1142329434.1027530.khali@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean, Etienne:

<snip>

> On 2006-03-13, Etienne Lorrain wrote:
> > Sorry, I was just assuming that while probing I2C hardware one per one,
> > if one line is diplayed for each driver I do not have - then the kernel
> > will at least display one line if it found something.

* Jean Delvare <khali@linux-fr.org> [2006-03-14 10:43:54 +0100]:
> This is the way it should work, but unfortunately our i2c bus drivers
> don't follow these rules. Almost all of them keep quiet when loaded
> (except for i2c-sis96x, as you found out by yourself) but they also keep
> quiet (unless debug is enabled) when a supported device is found, which
> is not so good.
> 
> Mark, can you provide a patch to your i2c-sis96x driver so that it'll
> keep quiet when no supported device is found?

Lots of drivers printk messages when they load - IMO it's useful info.
E.g. how else could Etienne discover that he accidentally built a kernel
with dozens of i2c bus drivers (and probably all of the hwmon drivers)
built-in by accident?

(But, I'll send the trivial patch to lm-sensors list if you still want it.)

<snip>

> > Removing the last PCA9564 gives me:
> > Mar 13 21:46:48 ubuntu kernel: [   47.699704] input: AT Translated Set 2
> > keyboard as /class/input/input1
> > Mar 13 21:46:48 ubuntu kernel: [   47.702667] input: PC Speaker
> > as /class/input/input2
> > Mar 13 21:46:48 ubuntu kernel: [   47.705445] i2c /dev entries driver
> > Mar 13 21:46:48 ubuntu kernel: [   47.708637] i2c-parport: using default
> > base 0x378
> > Mar 13 21:46:48 ubuntu kernel: [   70.366096] hdaps: supported laptop not
> > found!
> > Mar 13 21:46:48 ubuntu kernel: [   70.368750] hdaps: driver init failed
> > (ret=-6)!
> 
> You should also drop "Parallel port adapter (light)", it might cause
> the same kind of delays and probably explains (part of) the 23 second
> delay remaining.

<snip>

Wow, that's a huge delay.  One alternative would be for i2c slaves to behave
more like USB and do the probing asynchronous to driver load; i.e. 'modprobe
w83627hf' returns before the chip is actually recognized and attached.

OTOH, that brings up all the related problems.  E.g., you could no longer
expect this simple fragment of a RC script to work...

	modprobe i2c-sis96x
	modprobe asb100
	sensors -s

Short of fixing all that... one has to accept that (1) i2c bus probing is
slow, and (2) some i2c busses themselves are not reliably detectable...

...thus (3) it's a bad idea to build all of that into your monolithic kernel.

As Jean suggests, either use modules or build only the drivers for hardware
you actually have.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

