Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTA2Vpl>; Wed, 29 Jan 2003 16:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTA2Vpk>; Wed, 29 Jan 2003 16:45:40 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:46011 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S265126AbTA2Vpi>; Wed, 29 Jan 2003 16:45:38 -0500
Date: Wed, 29 Jan 2003 16:54:56 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Stanley Wang <stanley.wang@linux.co.intel.com>
cc: Rusty Lynch <rusty@linux.co.intel.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [Pcihpd-discuss] Questions about CPCI Hot Swap driver.
In-Reply-To: <1043743493.10695.14.camel@vmhack>
Message-ID: <Pine.LNX.4.44.0301291321270.17194-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jan 2003, Rusty Lynch wrote:

> On Wed, 2003-01-29 at 00:06, Stanley Wang wrote:
> > Hi, Scott
> > I have some questions about your CPCI Hot Swap driver.
> > Would you mind helping me to clarify them ?
> > 1. Why need we clear the EXT bit in the HS_CSR in "disable_slot()"?
> > I think the EXT bit has not been set at this point.
> 
> Wouldn't the EXT bit be set if the operator flips the ejector, and is
> waiting for the system to respond?

Yes, that's the case.

> > 2. I wonder why we could not receive the #ENUM interrupt when we unpluged
> > the board after disabling the corresponding slot("echo 0 > power")? It 
> > seems that the cpci_led_on has some mysterious side effect, but I could 
> > not find any hints in the spec.
> > Could you help me?

With most hardware and the current driver, you will still receive an ENUM#
signal if you flip a card's toggle open after echoing 0 into its power 
file.  Since the write to the slot's power file triggers unconfiguration 
of the driver for the attached device and removal of the kernel's PCI 
representation, pulling the card out then triggers the improper removal 
detection logic.  I should probably only honor the write of 0 to the 
power file for devices that are in extracting state via a toggle flip, 
I'll experiment a bit to see if that model works.

However, if the peripheral card in question is a ZT5541, all bets are off,
since in my experiments here it seems to completely shut down when its
hotswap LED is toggled.  I'm pretty sure this makes it non-compliant with
PICMG 2.1, but have not decided yet if disabling the attention file is 
worthwhile.  We could probably live without the attention file to toggle
the LED, and theoretically disable_slot should not need to call cpci_led_on
since clearing EXT is supposed to turn on the LED, but I've not seen 
enough peripheral hardware yet to have a feel for how safe it would be to
rely on things working correctly on all boards.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com



