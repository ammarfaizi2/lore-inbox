Return-Path: <linux-kernel-owner+w=401wt.eu-S1762560AbWLKG1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762560AbWLKG1i (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 01:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762573AbWLKG1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 01:27:38 -0500
Received: from dmgw.movial.fi ([62.236.91.5]:45428 "EHLO dmgw.movial.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762560AbWLKG1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 01:27:37 -0500
Message-ID: <42002.80.222.56.248.1165818454.squirrel@webmail.movial.fi>
In-Reply-To: <200612081859.42995.david-b@pacbell.net>
References: <200612081859.42995.david-b@pacbell.net>
Date: Mon, 11 Dec 2006 08:27:34 +0200 (EET)
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates:  more chips, alarm,
      12hr mode, etc
From: "Voipio Riku" <Riku.Voipio@movial.fi>
To: "David Brownell" <david-b@pacbell.net>
Cc: rtc-linux@googlegroups.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Riku Voipio" <riku.voipio@movial.fi>,
       "Alessandro Zummo" <alessandro.zummo@towertech.it>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Update the rtc-rs5c372 driver:
> I suspect the
> issue wasn't that "mode 1" didn't work on that board; the original
> code to fetch the trim was broken.  If "mode 1" really won't work,
> that's almost certainly a bug in that board's I2C driver.

It was not related to trim fetching. Yes, it very likely that the boards
i2c controller (i2c-iop3xx) is has a bug, but I'm not competent enough to
find out what it is actually sending out to the wire.

With your patch, the rtc acts like the chip would completely ignore the
"address" transfer, and starts reading from the last (default) register
anyway. Thus all the regs look shifted by one in the driver. With current
git driver results look like:

# cat /proc/driver/rtc ; sleep 1 ; echo one sec gone; cat /proc/driver/rtc
rtc_time        : 06:16:55
rtc_date        : 2006-12-11
24hr            : yes
32.768 KHz
trim    : 1
one sec gone
rtc_time        : 06:16:56
rtc_date        : 2006-12-11
24hr            : yes
32.768 KHz
trim    : 1

And same after your patch:

rtc_time        : 16:23:28
rtc_date        : 2012-11-01
alrm_time       : **:01:00
alrm_date       : ****-**-**
alrm_wakeup     : no
alrm_pending    : no
24hr            : yes
crystal         : 32.768 KHz
trim            : 10
one sec gone
rtc_time        : 16:24:28
rtc_date        : 2012-11-01
alrm_time       : **:01:00
alrm_date       : ****-**-**
alrm_wakeup     : no
alrm_pending    : no
24hr            : yes
crystal         : 32.768 KHz
trim            : 10


> +	/* this implements the first (most portable) reading method
> +	 * specified in the datasheet.
>  	 */

Why is this method considered more portable? Howabout making the read
method a module parameter?


