Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbTDNR0s (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTDNR0s (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:26:48 -0400
Received: from AMarseille-201-1-4-175.abo.wanadoo.fr ([217.128.74.175]:18727
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263576AbTDNR0r (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:26:47 -0400
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Patrick Mochel <mochel@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A260@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A260@orsmsx401.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050342025.6537.79.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Apr 2003 19:40:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 19:09, Grover, Andrew wrote:

> Topic drift...
> 
> After asking around internally, it sounds like we should not be doing a
> video re-POST on wakeup. Windows only used to in order to workaround
> buggy video drivers, according to what I've heard.
> 
> Ben obviously PPC is ahead of the pack on this stuff (congrats) but I
> did just want to put forward the idea that when we're all done with this
> stuff on all archs, we will hopefully not be regularly re-POSTing the
> video bios.

But how ? let's make clear what we call POST first ...

If the card is powered off, it must be POSTed to be brought back to
life. Either we do it by running the BIOS code (probably what you are
talking about and should be deprecated), or the driver "knows" how to
restore the chip from power off. I don't know if APM/ACPI provides
other ways, I suspect the APM BIOS will re-POST the card by itself
or else, things wouldn't work today. I don't know about ACPI.

What I mean here is that none of our drivers know how to bring 
back a chip as complicated as a radeon or a nvidia up from power off,
this requires intimate knowledge of the chip internals, the way it's
wired on a given board, etc...

On pmacs, the ROM does nothing for us. On wakeup from sleep, I basically
get control from the CPU right after the ROM figured out we are waking
up, that is a few instructions after the CPU itself is brought back from
power off, thus all HW is either just powered on by the PM microcontroller,
or in the state I left it when going to sleep.

So on machines where the PM microcontroller shuts off the PCI/AGP slots,
I must be able to fully restore PCI devices like video chips from their
power-on state, which I don't know how to do unless I'm the chip/board
manufacturer for a lot of "complicated" chips, like video ones...

The ability to re-run the BIOS (or open firmware) under some kind of
emulation or vm86 is a way to "work around" this problem.

The issue is that the driver must be told what is/canbe done so it
knows in what state it will get the chip back, and if it can resume
it at all or should reject sleep.

Ben.

