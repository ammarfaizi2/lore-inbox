Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVBEWow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVBEWow (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 17:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbVBEWow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 17:44:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:1664 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262573AbVBEWon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 17:44:43 -0500
Subject: Re: [ACPI] Re: Legacy IO spaces (was Re: [RFC] Reliable video
	POSTing on resume)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
In-Reply-To: <9e47339105020416486cf19738@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de>
	 <200502041010.13220.jbarnes@engr.sgi.com>
	 <9e4733910502041459500ae8d3@mail.gmail.com>
	 <200502041534.03004.jbarnes@engr.sgi.com>
	 <9e47339105020416486cf19738@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 09:42:32 +1100
Message-Id: <1107643352.30270.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If they all point to the same space, I can't tell whether I have three
> legacy spaces or one. I need to know how many legacy spaces there are
> in order to know how many VGA cards can simultaneously be enabled.

You don't need to care about this, at least in userland. All you need
is proper primitives for locking/unlocking access to a given device.
Wether you have another one to arbitrate with on the same PCI bus or not
is almost irrelevant. That is, it is the job of the kernel driver that
ultimately will do this arbitration (we really need that), and we can
prefectly well survive a long time with a very simple implementation
taht always disable all other VGA devies in the system, not caring about
"simultaneous" access. That implementation can be then improved on
later.

My point is what we really need to define is the in-kernel and userland
API to do this basic VGA access arbitration in the first place. I though
you did something like that a while ago Jon, didn't you ?

I think it could be as simple as an additional sysfs entry
"legacy_enabled" added to all "VGA" devices in the system at the PCI
layer level. Toggling it triggers the "untoggling" of all others,
including VGA forwarding on bridges, and enables the path to that
device. For in-kernel users, a pci_* API would work.

The problem I see though is that it should all be synchronous &
spinlocked since the vgacon could want to grab at interrupt time (unless
it's locked by userland, in which case, vgacon should cache & trigger an
update later).

Ben.


