Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUEMPlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUEMPlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbUEMPlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:41:31 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:44977 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264261AbUEMPlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:41:03 -0400
Message-ID: <40A3962F.3020500@pacbell.net>
Date: Thu, 13 May 2004 08:37:19 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: PrakashKC@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2, usb ehci warnings/error?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There appear lines like
> 
> usb usb2: string descriptor 0 read error: -108
> 
> bug or feature? They weren't there with 2.6.6-mm1. I have no usb2.0 
> stuff to actually test. My usb1 stuff seems to work though.

Bug; minor, since the only real symptom seems to be messages like
that.  Ignore them for now, I'll make a patch soonish.

It's actually the OHCI driver managing your "usb2" bus,
this is nothing to do with EHCI:

> ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
> PCI: Setting latency timer of device 0000:00:02.1 to 64
> ohci_hcd 0000:00:02.1: irq 21, pci mem f88fe000
> ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected

What's happening?  One of the USB patches makes OHCI suspend
its root hub when it's idle (no devices attached), much like
the UHCI driver has done for some time.  Saves some power.

However, it wrongly marks the controller itself (vs just the
root hub part of it) as having suspended.  That's what causes
the "-108" (-ESHUTDOWN) fault reports, as if the controller were
suspended too.  When the controller is suspended, its registers
are inaccesible so requests to the root hub must fail.

- Dave

