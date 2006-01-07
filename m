Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWAGH4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWAGH4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 02:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWAGH4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 02:56:25 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:28061 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1030345AbWAGH4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 02:56:24 -0500
Date: Sat, 7 Jan 2006 02:58:51 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys	interface
Message-ID: <20060107075851.GD3184@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
	Andrew Morton <akpm@osdl.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net> <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org> <20060107000826.GC20399@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060107000826.GC20399@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 01:08:26AM +0100, Pavel Machek wrote:
> On Pá 06-01-06 10:42:24, Alan Stern wrote:
> > On Thu, 5 Jan 2006, Patrick Mochel wrote:
> > It's a very bad idea to make bus drivers export and manage the syfs power 
> > interface.  It means that lots of code gets repeated and different buses 
> > do things differently.
> > 
> > Already we have PCI exporting "pm_possible_states" and "pm_state" while 
> > PCMCIA exports "suspend".  How many other different schemes are going to 
> > crop up?  How much bus-specific information will have to be built into a 
> > user utility?
> > 
> > If possible states are represented as arrays of pointers to strings, then 
> > the PM core can easily supply the sysfs interface.  If Patrick's patch 
> > were re-written so that the sysfs interface were moved into the PM core, 
> > leaving only the PCI-specific portions in the PCI drivers, I would be much 
> > happier.  This would also mean that Dominik's patch could be replaced by 
> > something a good deal smaller.
> > 
> > And it wouldn't hurt to add some mechanism for indicating which of the 
> > possible states is the generic "suspend" state (usually D3 for PCI 
> > devices, but not necessarily).
> 
> I think we should start with string-based interface, with just two
> states ("on" and "off"). That is easily extensible into future, and
> suits current PCMCIA nicely. It also allows us to experiment with PCI
> power management... I can cook up a patch, but it will be simple
> reintroduction of .../power file under different name.

The driver core can provide some infustructure, but let's leave the states
up to the drivers.  Afterall, some drivers might only be interested in "on"
during runtime.  Also, drivers might support some sort of partial-off
but not "off".

And no, this does not allow us to experiment with PCI power management.
The runtime PM in drivers and some aspects of the PCI PM code (e.g. PME events
and saving/restoring device context) are terminally broken.  We really need a
good foundation for each bus PM spec.  There's a lot more to it than
just setting some bit in the PCI config space.

Also there's nothing "runtime" about the PCMCIA PM API.  It's much more
like calling ->remove() as it disabled the device all together.  I'm more
interested in saving power without crippling functionality.

Thanks,
Adam

