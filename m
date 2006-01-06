Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWAFPm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWAFPm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWAFPmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:42:25 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44421 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751158AbWAFPmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:42:25 -0500
Date: Fri, 6 Jan 2006 10:42:24 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Patrick Mochel <mochel@digitalimplant.org>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
Message-ID: <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Patrick Mochel wrote:

> On Fri, 6 Jan 2006, Pavel Machek wrote:
> 
> > On 05-01-06 16:04:07, Patrick Mochel wrote:
> 
> > > A better point, and one that would actually be useful, would be to remove
> > > the file altogether. Let Dominik export a power file, with complete
> > > control over the values, for each pcmcia device. Then you never have to
> > > worry about breaking PCMCIA again.
> >
> > Fine with me.
> 
> ACK, you beat me to it.
> 
> And, appended is a patch to export PM controls for PCI devices. The file
> "pm_possible_states" exports the states a device supports, and "pm_state"
> exports the current state (and provides the interface for entering a
> state).
> 
> Eventually, some drivers will want to fix up those values so that it can
> mask of states that it doesn't support, as well as offer possible device-
> specific states.
> 
> What's interesting is that with this patch, I can see that two more
> devices on my system support D1 and D2 -- the cardbus controllers, which
> are actually bridges whose PM capabilities aren't exported via lspci.

This trend is extremely alarming!!

It's a very bad idea to make bus drivers export and manage the syfs power 
interface.  It means that lots of code gets repeated and different buses 
do things differently.

Already we have PCI exporting "pm_possible_states" and "pm_state" while 
PCMCIA exports "suspend".  How many other different schemes are going to 
crop up?  How much bus-specific information will have to be built into a 
user utility?

If possible states are represented as arrays of pointers to strings, then 
the PM core can easily supply the sysfs interface.  If Patrick's patch 
were re-written so that the sysfs interface were moved into the PM core, 
leaving only the PCI-specific portions in the PCI drivers, I would be much 
happier.  This would also mean that Dominik's patch could be replaced by 
something a good deal smaller.

And it wouldn't hurt to add some mechanism for indicating which of the 
possible states is the generic "suspend" state (usually D3 for PCI 
devices, but not necessarily).

Alan Stern


