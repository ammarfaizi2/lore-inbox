Return-Path: <linux-kernel-owner+w=401wt.eu-S937682AbWLKWXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937682AbWLKWXJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937680AbWLKWXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:23:09 -0500
Received: from dmgw.movial.fi ([62.236.91.5]:42867 "EHLO dmgw.movial.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937679AbWLKWXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:23:06 -0500
Message-ID: <42003.80.222.56.248.1165875783.squirrel@webmail.movial.fi>
In-Reply-To: <200612111155.09435.david-b@pacbell.net>
References: <200612081859.42995.david-b@pacbell.net>
    <42002.80.222.56.248.1165818454.squirrel@webmail.movial.fi>
    <200612111155.09435.david-b@pacbell.net>
Date: Tue, 12 Dec 2006 00:23:03 +0200 (EET)
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates:  more chips, alarm,
      12hr mode, etc
From: "Voipio Riku" <Riku.Voipio@movial.fi>
To: "David Brownell" <david-b@pacbell.net>
Cc: rtc-linux@googlegroups.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Alessandro Zummo" <alessandro.zummo@towertech.it>,
       dan.j.williams@intel.com, dan.j.williams@gmail.com, i2c@lm-sensors.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sunday 10 December 2006 10:27 pm, Voipio Riku wrote:
>> > Update the rtc-rs5c372 driver:
>> > I suspect the
>> > issue wasn't that "mode 1" didn't work on that board; the original
>> > code to fetch the trim was broken.  If "mode 1" really won't work,
>> > that's almost certainly a bug in that board's I2C driver.

>> It was not related to trim fetching. Yes, it very likely that the boards
>> i2c controller (i2c-iop3xx) is has a bug, but I'm not competent enough
>> to
>> find out what it is actually sending out to the wire.

> I'd expect that would be the controller _driver_ ... although it would
> not surprise me to know there were also (unfixed) silicon bugs to cope
> with, like version-specific differences.  One hopes errata are published
> for the chip you're using, and that they don't lie.

from what I saw, the driver simply passes messages over to the i2c
controller. It even specifically mentiones that it supports repeated start
conditions, as needed for read method #1. Comparing to 80219 manual[1], I
did not spot anything obviously wrong.

> Have you asked around for anyone who may have insights about i2c-iop3xx
> driver bugs?  Maybe the driver maintainers, or arm-linux folk, or on
> the i2c list.

I was told to contact Dan Williams, I didn't get any response.

>> With your patch, the rtc acts like the chip would completely ignore the
>> "address" transfer, and starts reading from the last (default) register
>> anyway. Thus all the regs look shifted by one in the driver.

> That's quite strange.  The docs on the RTC are quite clear about what's
> supposed to happen with what I2C messages.  And I'd expect them to be
> right ... especially since they behaved for me, and the original author
> of that code!  That makes me suspect that your particular I2C controller
> driver must not be issuing the protocol requests it should be, at least
> on your hardware and revision.

Well at least I'm happy that there is now someone more experienced working
on this driver. When I tried to get it working I could not find anyone
with another board to verify if the original and/or my patch works for
them..

>> > +	/* this implements the first (most portable) reading method
>> > +	 * specified in the datasheet.
>> >  	 */

>> Why is this method considered more portable? Howabout making the read
>> method a module parameter?

> Of the three methods, #2 depends on messages that not all I2C masters
> are necessarily going to be able to issue, and #3 assumes that there's
> no other I2C master accessing that chip.

Agreed, I wouldn't consider method #2 either.

> Plus, if I understand things correctly, using mode #3 would break when
> writing

I should not. Writing isn't related to reading methods according the
datasheet[2]. It provides one addressing method for writing, and writing
works fine our Thecus/Allnet hardware.

[1] http://www.intel.com/design/iio/manuals/274017.htm
[2] http://www.ricoh.com/LSI/product_rtc/2wire/5c372/5c372a-e.pdf
