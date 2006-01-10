Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWAJIlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWAJIlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 03:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWAJIlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 03:41:17 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:51134 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932098AbWAJIlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 03:41:16 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.15 EHCI hang on boot
Date: Tue, 10 Jan 2006 00:27:48 -0800
User-Agent: KMail/1.7.1
Cc: Marc Haber <mh+linux-kernel@zugschlus.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <20060104161844.GA28839@torres.l21.ma.zugschlus.de> <20060104220403.GC12778@kroah.com>
In-Reply-To: <20060104220403.GC12778@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601100027.48372.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 2:04 pm, Greg KH wrote:

> > I suspect an incompatibility with the i865 chipset. Is there anything
> > I can do to help debugging?
> 
> I don't know, David, any ideas?

Such things are more often BIOS than chipset, so check for updates there.
Plus, you commented that the issue only shows up with your newest board,
and most folk don't have such hang-on-boot issues.

There were updates in 2.6.15 to how all the PCI based usb host controller
drivers handle their reset/init logic ... basically "handoff" from BIOS to
the OS kernel (Linux) is always done "early" now.  Previously it wasn't
always done until late (too late for the input subsystem, given usb keyboards
and mice that the BIOS uses to emulate ps/2 ones), and wasn't done very
consistently.  (The "early handoff" code didn't act identically to the
code inside the HCDs that did the bios handoff "later".)

If there's no BIOS update, one experiment would be to #ifdef out the call
to bios_handoff() in drivers/usb/host/ehci-pci.c ... the version of that
code in the .../usb/hosts/pci-quirks.c file _should_ eventually suffice,
though I think there are still differences between that version and the
one (in ehci-pci.c) that's better tested.

- Dave
