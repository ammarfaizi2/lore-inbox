Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267429AbUIFEHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267429AbUIFEHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 00:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUIFEHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 00:07:24 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:51973 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267429AbUIFEHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 00:07:22 -0400
Message-ID: <9e473391040905210762427f42@mail.gmail.com>
Date: Mon, 6 Sep 2004 00:07:21 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: perex@suse.cz
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rddunlap@osdl.org>
In-Reply-To: <20040905190937.36e72b49.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040905184852.GA25431@linux.ensimag.fr>
	 <9e47339104090514244873fd05@mail.gmail.com>
	 <1094417386.1911.0.camel@localhost.localdomain>
	 <20040905190937.36e72b49.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 05 Sep 2004 21:49:50 +0100 Alan Cox wrote:
> | On Sul, 2004-09-05 at 22:24, Jon Smirl wrote:
> | > I'd don't know enough about the LPC bridge chip to know what the
> | > correct answer is for this. Right now I tend to think that the PCI
> | > driver should own the bridge chip. If not the PCI driver then there
> | > should be an explicit bridge driver. I don' think it is correct that a
> | > joystick driver is attaching to a bridge chip given the simple fact
> |
> | Nobody else currently needs to attach to it so why make life needlessly
> | complicated.

I just spent a while looking at the code. The joystick driver doesn't
need to exist. Instead the snd_intel8x0_probe() routine could have a
loop that does pci_get_subsys() over the ID's in
snd_intel8x0_joystick_ids[]. When it finds one, use the config space
to enable the joystick/midiports. You can locate the ports since
pci_get_subsys() returns the pci_dev* for the bridge device.  Save the
pci_dev* and set the ports back in snd_intel8x0_remove(). Don't forget
to pci_put() the bridge device.

This isn't a device driver for the bridge, we just want to locate it
and flip some bits. Later on if a driver for the bridge get written it
should support an API for setting these bits and the search loop can
be removed.

All of these devices are listed as Intel LPC bridges:
2410, 2420, 2440, 244c, 2450, 2480, 2484, 24c0, 24cc, 24d0, 24dc,
25a1, 2640, 2641, 2642
I have a 24D0 which isn't in the driver list, this is probably why
MIDI doesn't work on my system.

-- 
Jon Smirl
jonsmirl@gmail.com
