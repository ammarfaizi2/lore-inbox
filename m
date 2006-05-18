Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWERJwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWERJwr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWERJwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:52:47 -0400
Received: from tim.rpsys.net ([194.106.48.114]:28290 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750940AbWERJwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:52:46 -0400
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
From: Richard Purdie <rpurdie@rpsys.net>
To: Harald Welte <laforge@gnumonks.org>
Cc: openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org,
       "Michael 'Mickey' Lauer" <mickey@tm.informatik.uni-frankfurt.de>
In-Reply-To: <20060518070700.GT17897@sunbeam.de.gnumonks.org>
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org>
Content-Type: text/plain
Date: Thu, 18 May 2006 10:52:27 +0100
Message-Id: <1147945947.20943.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-05-18 at 09:07 +0200, Harald Welte wrote:
> 0) What kind of X/Y/Pressure values should I return?  Are they supposed
>    to be scaled to the X/Y resolution of the LCD?  As of now, I return
>    X_ABS, Y_ABS and PRESSURE values between 0 and 1000 (each).
> 
>    However, the coordinates are actually inverted, so '0,0' corresponds
>    to the lower right corner of the screen, whereas '1000,1000' is the
>    upper left corner.  Shall I invert them (i.e. return 1000-coord')?

Just send the raw data to userspace. Any translations needed can be
handled in userspace by the calibration program. You probably want to
have a look at tslib: http://cvs.arm.linux.org.uk/cgi/viewcvs.cgi/tslib/

The range of the values also doesn't really matter and scaling would
again get handled in userspace.

> 1) where does touchscreen calibration happen?  The EZX phones (like many
>    other devices, I believe) only contain resistive touchscreens that
>    appear pretty uncalibrated.   I'm sure the factory-set calibration
>    data must be stored somewhere in flash, but it's definitely handled
>    in the proprietary EZX userland, since their old kernel driver
>    doesn't have any calibration related bits.

Calibration happens in userspace and tslib stores the result
in /etc/pointercal. If you device has this data stored in hardware, you
could have a userspace app translate that data into such a file,
otherwise, you can run a calibration program such as ts_calibrate (from
tslib) or something like xtscal.

> 2) what about the 'button' event.  In addition to the pressure (which is
>    about 300 for regular stylus use, > 400 if you press hard and > 600 if
>    you use yourfinger), some existing TS drivers return a button press.
>    Is it up to me to decide after which pressure level to consider the
>    button to be pressed / released?

If the user is pressing the screen at all, its a button event and
release is when they stop touching the screen. I'd try not to make it
depend upon pressure but it will depend on the hardware to a degree.

Admittedly, tslib doesn't do much with pressure information at the
moment but tslib would the the correct place to handle pressure rather
than have every kernel touchscreen driver doing it.

For debugging, I'd highly recommend the test tools in tslib (ts_print,
ts_calibrate and ts_test). Use them in that order, checking for sane
output with ts_print first, get a working calibration second and finally
prove its working with ts_test. I found them to be very useful when
developing corgi_ts.

I'm told you're thinking about using OpenEmbedded and would highly
recommend it. It should easily be able to provide a known working
userspace with tslib and these tools in.

Regards,

Richard



