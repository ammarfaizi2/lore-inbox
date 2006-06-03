Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWFCJ3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFCJ3l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 05:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWFCJ3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 05:29:40 -0400
Received: from mail1.kontent.de ([81.88.34.36]:30344 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750794AbWFCJ3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 05:29:40 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
Date: Sat, 3 Jun 2006 11:29:54 +0200
User-Agent: KMail/1.8
Cc: David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <447EB0DC.4040203@cogweb.net> <20060530200134.GB4074@ucw.cz>
In-Reply-To: <20060530200134.GB4074@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031129.54580.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Mai 2006 22:01 schrieb Pavel Machek:
> Hi!
> 
> > Starting with 2.6.16, some USB devices fail unnecessarily on unpowered
> > hubs. Alan Stern explains,
> > 
> > "The idea is that the kernel now keeps track of USB power budgets.  When a 
> > bus-powered device requires more current than its upstream hub is capable 
> > of providing, the kernel will not configure it.
> > 
> > Computers' USB ports are capable of providing a full 500 mA, so devices
> > plugged directly into the computer will work okay.  However unpowered hubs
> > can provide only 100 mA to each port.  Some devices require (or claim they
> > require) more current than that.  As a result, they don't get configured
> > when plugged into an unpowered hub."
> 
> Actually I have exactly opposite problem: my computer (spitz) can't
> supply full 500mA on its root hub, and linux tries to power up
> 'hungry' devices, anyway, leading to very weird behaviour.


You could lower the obvious values in this code from drivers/usb/core/hub.c

	if (hdev == hdev->bus->root_hub) {
		if (hdev->bus_mA == 0 || hdev->bus_mA >= 500)
			hub->mA_per_port = 500;
		else {
			hub->mA_per_port = hdev->bus_mA;
			hub->limited_power = 1;
		}

If that does the job we need to somehow inherit the power supply maximum from
PCI when we allocate the root hub's device structure.

	Regards
		Oliver
