Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWHEU3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWHEU3c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 16:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWHEU3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 16:29:31 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:48532 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751486AbWHEU3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 16:29:31 -0400
From: David Brownell <david-b@pacbell.net>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: RTC: add RTC class interface to m41t00 driver
Date: Sat, 5 Aug 2006 12:13:49 -0700
User-Agent: KMail/1.7.1
Cc: ab@mycable.de, mgreer@mvista.com, a.zummo@towertech.it,
       linux-kernel@vger.kernel.org
References: <200608041933.39930.david-b@pacbell.net> <20060806.012924.96685417.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060806.012924.96685417.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608051213.50308.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 August 2006 9:29 am, Atsushi Nemoto wrote:
> On Fri, 4 Aug 2006 19:33:39 -0700, David Brownell <david-b@pacbell.net> wrote:
> > Actually, it'd be worth trying drivers/rtc/rtc-ds1307.c ... the M41T00 is
> > one of a family of mostly-compatible RTC chips, and the ds1307 driver
> > should be pretty much the least-common-denominator there.  They all use
> > the same I2C address, and the same register layout for the calendar/time
> > function.
> > ...
> 
> Thanks for your suggestion.  I have looked rtc-ds1307 too before I
> tried to modify m41t00 driver.

I couldn't tell that from any email I've seen, but it's good to know.


> 1. The driver contains ds_1340 (or st m41t00) definition, but it seems
>    no way to select the ds_type.

Which is harmless, since the driver has no code that really needs to care.
As I said, it's a least-common-denominator driver ... used in my case
with a SOC that integrates a highly functional (primary) RTC, because
only the external RTC provides its own battery-backed power domain.


This is a limitation of the I2C stack ... one that I observe is being
worked around by m41t00.c platform_device tricks.  A side effect of those
tricks is to prevent hooking up more than one of this type I2C chip
to a system ... not pretty (especially given that it's not documented),
but often OK.


> 2. As m41t00_chip_info_tbl[] in m41t00 driver shows, M41T81 and M41T85
>    have different register layout.

Right, suggesting the m41t00.c driver is more misnamed than rtc-ds1307.c
because it doesn't even insist on software-compatible chips!  And I'll
note that its Kconfig doesn't mention that support either ...

It would have made more sense to me to have the M41T81 and M41T85 be
in a different driver, because of the incompatible register layout.
That's the more traditional approach.


> 3. It lacks some features (ST bit, HT bit, SQW freq.) in m41t00
>    driver, though I personally does not need these features.

Right:  "least-common-denominator".  Most of those chips can do square
wave output (SQW), which should arguably be exposed as a <linux/clk.h>
signal like other such signals.

Plus, handling square wave output would in general need board-specific
configuration (also not directly supported by I2C), since the SQW pin
often doubles as an alarm interrupt output ... I'd rather have an alarm!
The ds1337 has two alarm pins, ds1339 muxes two alarms to one pin.

The ds1307 chip has NVRAM too, also not exposed ... even though that's
the natural place to store manufacturing info like ethernet ids.

And there are many other chip differences that software might care about.

 
> I choose changing m41t00 driver by (1) and (2).
> 
> If we really need a super generic driver, I suppose adding ds13xx
> support to new m41txx driver is less hard.  I think having separate
> drivers are good enough for now.

My approach was to go for "least common denominator", not "super generic".
Also, I avoided trying to work around I2C stack issues like the omission
of per-board tables/customization.  When I2C eventually has a nice clean
solution for those issues, I expect that will mean adopting the better
solution involves fewer changes.

But I was mostly pointing out that if the goal was to support the m41t00
RTC (the normal reading of $SUBJECT), that work has been done for some
time and has already been pushed upstream.

- Dave

