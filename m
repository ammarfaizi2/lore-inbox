Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVBQSKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVBQSKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVBQSKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:10:51 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:25823 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262277AbVBQSKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:10:19 -0500
From: David Brownell <david-b@pacbell.net>
To: "Frank Buss" <fb@frank-buss.de>
Subject: Re: SL811 problem on mach-pxa
Date: Thu, 17 Feb 2005 10:09:55 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050217035136.462465B80B@frankbuss.de>
In-Reply-To: <20050217035136.462465B80B@frankbuss.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502171009.55375.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2005 7:51 pm, Frank Buss wrote:
> 
> http://www.frank-buss.de/tmp/sl811-hcd.c-patch.txt

Some of that looks reasonable, not all.  In particular, don't
change the convention on resources (memory to i/o), or expect
that the two regions involve more than one byte each ... the
hardware only has two single-byte registers!

I'll look at the ep->hep stuff ... I could believe rc1 got a
bug added there.  The urb->hcpriv bit looks wrong though.
It may take a little time for me to check it out though. 


> There is still an important error: When a device is plugged, then opened and
> then unplugged while open, it looks like the process freezes, which opened
> the device (I've tried "cat /dev/input/mice" and I can't break it after
> unplugged). After plugging the device again, it is not recognized any more.
> When the device is not open or after closing the device, unlugging and
> plugging again is no problem.

That seems pretty odd; I certainly tested that (on 2.6.almost-10)
as part of the initial development, and nothing in that area should
have changed either in the sl811 driver or usbcore.  I suspect the
issue is one of the other changes you made.


> -// #define	QUIRK2
> -#define	QUIRK3
> +/* with other QUIRK combinations it crashes */
> +#define	QUIRK2
> +//#define	QUIRK3

Also very odd.  It was tested with _both_ workarounds for IRQ issues;
and nobody else has reported any need for #2 any more (now that the
IRQs are acked selectively, unlike the predecessors to this driver).

If there's a crash there, don't paper it over like this.


> @@ -1580,6 +1591,14 @@
>  	if (sl811->board && sl811->board->power)
>  		hub_set_power_budget(udev, sl811->board->power * 2);
>  
> +	// enable power and interupts	
> +	port_power(sl811, 1);
> +
> +	/* reset USB (without this the devices were not detected at boot,
> only after plugging) */
> +	sl811_write(sl811, SL11H_CTLREG1, 0x08);
> +	mdelay(20);
> +	sl811_write(sl811, SL11H_CTLREG1, 0);
> +
>  	return 0;
>  }
>  

Hmm, what platform were you using?  I've had reports that one of the
KARO boards has that issue.  That looks like the sort of thing that
should be done in the reset() routine rather than start(); and it should
certainly use a symbolic constant not 0x08.

- Dave

