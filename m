Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUBDXdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUBDX36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:29:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:52100 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264930AbUBDX1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:27:43 -0500
Subject: Re: [PATCH] PCI / OF linkage in sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
References: <1075878713.992.3.camel@gaston>
	 <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
Content-Type: text/plain
Message-Id: <1075937213.8483.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 10:26:54 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-05 at 09:08, Linus Torvalds wrote:
> On Wed, 4 Feb 2004, Benjamin Herrenschmidt wrote:
> > 
> > This patch adds a "devspec" property to all PCI entries in sysfs
> > that provides the full "Open Firmware" path to each device on
> > PPC and PPC64 platforms that have Open Firmware support.
> 
> Wouldn't it make more sense to go the other way? Ie have the PCI devices 
> be pointed to from the OF paths?

Well... There are a few problems with that. First, what people/drivers
actually want is the PCI -> OF mapping, rarely the other way around.
So having an OF -> PCI linkage will mean users will have to walk the
whole tree each time to locate the device.

Then, adding properties to the OF tree is a bit nasty as we try to
keep it as "intact" as possible and the current /proc interface to
it is rather static, this is not on our plan to change that in the
2.6 timeframe... 

Finally, the "macio" and "of platform" type devices already have
that "devspec" entry, so it would be more consistent to do the
same for PCI.

> I'd prefer to avoid having OF-specific files in a PCI directory. That just 
> leads to inherently unportable user mode stuff. In contrast, having the OF 
> directory entry that points to the hardware (PCI) entry makes perfect 
> sense.

Well, I don't see a portability problem. Usermode stuff that need to
use & access the OF information are inherently unportable already,
wether it does the lookup via /sys/devices or via /proc/device-tree
(or whatever we call it if we ever move it out of /proc).

The 2 usage of that I see (maybe more with IBM diagnostic & VPD stuff)
right are:

 - setting up the bootloader (inherently non-portable, currently uses
a rather broken shell script that sometimes work by mere luck and wild
guesses)

 - Xserver/XFree. On most platform, the drivers in there (typically ATI
ones) will use tables in the x86 BIOS for things like PLL parameters,
on OF machines, though, those infos are available via properties in the
OF device-tree set by the f-code firmware of the cards. We need a way
to access these (along with some connector information). Currently, lots
of configs work only with UseFBDev because of that.


Ben.


