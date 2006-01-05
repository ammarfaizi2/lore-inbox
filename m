Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWAEAYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWAEAYu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWAEAYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:24:49 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:57739 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750834AbWAEAYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:24:49 -0500
Subject: Re: [PATCH 1/1] usb/input: Add missing keys to hid-debug.h
From: Marcel Holtmann <marcel@holtmann.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20060103195344.GC6443@corona.home.nbox.cz>
References: <20060102233730.GA29826@hansmi.ch>
	 <200601030142.32623.dtor_core@ameritech.net>
	 <20060103195344.GC6443@corona.home.nbox.cz>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 01:24:34 +0100
Message-Id: <1136420674.6652.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

> We should split HID in two parts - transport and decoding. This would
> help in many places:
> 
> 	Bluetooth would be happy, because it uses the same HID protocol
> 	on top of a different transport layer (completely non-USB).
> 
> 	Wacom and many other blacklisted devices would be happy, because
> 	they could use the USB HID transport - no blacklist would be
> 	needed.
> 
> 	Would allow for /dev/usb/rawhid0 style devices, which would give
> 	access to raw HID reports without any parsing done.
> 
> 	Would allow userspace drivers for broken UPS devices (like APC)
> 	without the need for special handling of their bugs in the kernel.
> 
> It seems to me it could be almost its own layer, like serio or gameport.
> Windows has an API like that.
> 
> I don't have the time to do the split myself, but it shouldn't be too
> hard.

I actually started this work when I presented the Bluetooth HID at the
Linux-Kongress 2004. However getting this fully done is not as easy as
it sounds. There are still parts inside the HID driver that I still have
no clue why they exists and what they actually do. A good revision
history inside the SCM seems really important for this driver.

The biggest problem that I see is that we can't break the current USB
HID driver, because this will render a lot of desktop system totally
useless and one 2.6 release is not enough to sort the problems out. Even
breaking the -mm kernel doesn't sound very helpful.

My idea actually was to create a HID subsystem under drivers/hid/ which
will be a fully copy of the current usbhid.ko driver, but without any
USB related code. This means that hiddev needs its own major number.
After that I am happy to offer the Bluetooth subsystem as testing base
for the new HID subsystem. The number of devices are still limited, but
it should be enough to sort out the basic problems.

The rawhidX devices should not be USB specific, because we might even
need them with Bluetooth as transport. There exists a Wacom tablet that
might make use of it.

I also need raw access to the reports (sending and receiving) for some
special features. The LCD displays of some Logitech keyboards are using
two report IDs for this job. It would be great to handle them via a
special rawhidX (with a ID filter) or via an extra driver while the
basic input processing is still done by the HID driver.

Regards

Marcel


