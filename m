Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132734AbRBEQXy>; Mon, 5 Feb 2001 11:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRBEQXn>; Mon, 5 Feb 2001 11:23:43 -0500
Received: from mail15.jump.net ([206.196.91.15]:46276 "EHLO mail15.jump.net")
	by vger.kernel.org with ESMTP id <S132734AbRBEQXX>;
	Mon, 5 Feb 2001 11:23:23 -0500
Message-ID: <3A7ED389.585A9AC5@sgi.com>
Date: Mon, 05 Feb 2001 10:23:37 -0600
From: Eric Sandeen <sandeen@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-XFS i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Rothwell <rothwell@holly-springs.nc.us>
CC: linux-kernel@vger.kernel.org, Brad Hards <bhards@bigpond.net.au>
Subject: Re: "kaweth" usb ethernet driver in 2.4?
In-Reply-To: <200102040727.f147RAQ14787@513.holly-springs.nc.us> <3A7D919F.F2213EA2@sgi.com> <002301c08f19$c9020100$8501a8c0@gromit>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so the problem with the current driver is that it will attempt to
load the firmware even if firmware is already loaded.  This will hang
the device.

The trick is to look at the device release number
(dev->descriptor.bcdDevice) - if no firmware is present, it returns
0x0002, if firmware is present, it returns 0x0202.

The second trick is to explicitly call usb_get_device_descriptor()
before checking this, as it seems to be cached otherwise.  Brad and I
had a simultaneous revelation on this one.  :)

Adding this test before the (firmware download, fix download, firmware
trigger) sequence makes things work much more reliably, although it
still fails occasionally if the device is plugged in after the driver is
loaded - fails on usb_get_device_descriptor() for some reason... perhaps
a short delay before re-reading the desriptor might help?  (just
guessing here...)

Patches sent to Brad & Michael.

-Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
