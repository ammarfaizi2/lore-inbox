Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWHEU3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWHEU3d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWHEU3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 16:29:32 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:51092 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751487AbWHEU3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 16:29:32 -0400
From: David Brownell <david-b@pacbell.net>
To: Alexander Bigga <ab@mycable.de>
Subject: Re: RTC: add RTC class interface to m41t00 driver
Date: Sat, 5 Aug 2006 13:23:16 -0700
User-Agent: KMail/1.7.1
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, mgreer@mvista.com,
       a.zummo@towertech.it, linux-kernel@vger.kernel.org
References: <200608041933.39930.david-b@pacbell.net> <20060806.012924.96685417.anemo@mba.ocn.ne.jp> <44D4D8B0.5010103@mycable.de>
In-Reply-To: <44D4D8B0.5010103@mycable.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608051323.16796.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 August 2006 10:43 am, Alexander Bigga wrote:
> Hi Atsushi,
> Hi David,
> 
> I've seen very late that the rtc-ds1307.c driver supports the quite 
> simple m41t00 as well. As Mark's m41t00.c claimed to support even the 
> m41t81 and the m41st85, I startet at this point.

I touched on that in my reply to Atsushi ... basically, the approach
used in rtc-ds1307 is "least common denominator", and sticking to the
fully compatible register subset and generic I2C framework.

That helped avoid needing to work around the lack of driver model support
in the I2C stack, at the (minor to me!) price of not handling features
that would need platform_data hooks to support ... like <linux/clk.h>
support for SQW, and RTC alarm irqs.


> First, I sent my approach to Mark (m41t00.c), Alessandro (rtc-subsytem) 
> and Jean (i2c-subsystem) to discuss the strategy. And if I understood 
> them right, they found the idea good, to move the i2c/chips/m41t00.h to 
> an rtc/rtc-m41txx.c driver, as this should be the general place for such 
> rtc-drivers.

Agreed that RTC drivers should now use the (newish) RTC framework, and
these should move out of the "misc i2c chips" area.  Not all RTCs fit
in the drivers/rtc area though ... an RTC can be a secondary function
of a multipurpose chip.  (I suspect the Kconfig for their RTC interfaces
should probably live in drivers/rtc though...)


> As Atsushi has done almost the same work, I postet my version on friday 
> to pretend the next person to do this job and to start the discussion,

Discussion is now started.  :)


> how to get to a suitable version for all - including Mark with his 
> arch/ppc/platforms/katana.c boards.

I suspect not all that board support is upstream yet; I can't see
anything creating the m41t00 platform devices as required by the
current m41t00.c driver ... neither on katana, nor any other board.

So it looks to me like RTC class support is not the only issue!

Plus, Mr. Grep tells me there's a separate m41t81 driver in
mips/sibyte/swarm/rtc_m41t81.c ... 


> I confirm, that the rtc-ds1307.c driver works with m41t00.

Good to know that ... I tried to be careful, but I didn't have a
board with one of those to test with, just docs.  Thanks!  At
some point we may decide it's safe to remove i2c/chips/ds1337.c,
but I'd want similar confirmation for the ds1337 chip.


> Atsushi Nemoto wrote:
> > 2. As m41t00_chip_info_tbl[] in m41t00 driver shows, M41T81 and M41T85
> >    have different register layout.
> 
> The register layout seems to depend on the watchdog and alarm 
> functionality.
> The features differs from chip to chip, that's why I intodruced a 
> "features"-field in struct m41txx_chip_info.

I'm not sure that'd be sufficient; if you look at the various RTCs,
you'll notice that the control bits are in wildly different places.

You may end up doing more "switch (chip_type) {...}" than testing of
the feature bits, if you get beyond those three chips.


> > 3. It lacks some features (ST bit, HT bit, SQW freq.) in m41t00
> >    driver, though I personally does not need these features.
> >   
> 
> You need at least to clear the Stop Bit (ST) and the Halt Update Bit 
> (HT) unless your m41t8x will always report the time of the last power 
> fail and not the current time.

Yes, but the m41t8x chips aren't register-compatible with those other
RTCs, so I would not expect them to work the same.  :)


> For me there is still the open question, if the workqueue-part and the 
> exported symbols (m41t00_get_rtc_time, ) should stay or not. I don't 
> need it and Atsushi seems to share my opinion. But...?

None of the other RTC drivers export private APIs or require a workqueue,
so you won't need them on an m41t8x driver either.

I noticed that the katana board uses a different scheme for the "initialize
the system time/date" problem addressed by CONFIG_RTC_HCTOSYS, and that seems
to be the reason for the m41t00.c driver to export an API.  (Much the same way
that the PC-style "cmos clock" exports an API used early in x86 booting, which
likewise bypasses the RTC framework ...)

I suspect there are arch-specific issues to work through there, both for
initializing the clock at boot and for re-initializing it after resume.
(CONFIG_RTC_HCTOSYS doesn't currently address the latter...)

- Dave

