Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUBIWHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUBIWHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:07:45 -0500
Received: from ida.rowland.org ([192.131.102.52]:6660 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265201AbUBIWHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:07:43 -0500
Date: Mon, 9 Feb 2004 17:07:42 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Johannes Erdfelt <johannes@erdfelt.com>, <eric.piel@tremplin-utc.net>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Slight optimisation of the uhci-hcd init code
In-Reply-To: <1076335524.402793a4d04e9@mailetu.utc.fr>
Message-ID: <Pine.LNX.4.44L0.0402091657520.871-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for fowarding this, Johannes.

On Mon, 9 Feb 2004 eric.piel@tremplin-utc.net wrote:

> Hello,
> 
> While trying to understand why starting usb on my laptop made the bus master
> activity full I came accross a strange code in uhci-hcd: a seven level nested
> "if". The same thing can be achieved with a simgle ffz(). The attached patch
> should give to the code a bit better looking, on my x86 it even saves 96 bytes,
> cool ;-) 
> 
> hoping you like it,
> Eric Piel

It's a nice idea.  I was planning to alter the logic behind that nested
"if" anyway, and I'll keep your recommendation in mind when I do it.

> PS: still, I'm not sure it's normal to see ffffffff as "bus master activity" in
> /proc/acpi/processor/CPU0/power as soon as uhci-hcd is loaded. In particular, it
> prevents the processor to go to C3 state. Could you give me your pint of view?

I'm not sure exactly what the ffffffff value means -- maximum utilization?

Anyway, a UHCI host controller is a bus master and it can generate a lot
of activity depending on what USB devices are plugged in.  If no USB
devices are plugged, the controller will be suspended after 1 second.  
Of course then it shouldn't be accessing the PCI bus at all.

There is one exception to this.  Some manufacturers try to disable unused
USB ports on their motherboards by tying the overcurrent input permanently
high.  (This seems to be particularly common among laptops.)  With some
Intel controllers this strategy generates "device-connected" interrupts,
so the driver doesn't try to suspend the controller.  There's a patch to
fix this behavior currently being tested.

Alan Stern

