Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUJKDmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUJKDmx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 23:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUJKDmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 23:42:52 -0400
Received: from ozlabs.org ([203.10.76.45]:64949 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268665AbUJKDmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 23:42:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16746.299.189583.506818@cargo.ozlabs.ibm.com>
Date: Mon, 11 Oct 2004 13:42:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
In-Reply-To: <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
References: <1097455528.25489.9.camel@gaston>
	<Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> On Mon, 11 Oct 2004, Benjamin Herrenschmidt wrote:
> >
> > Any reason why this totally broken code was ever merged upstream ?
> 
> Because it fixes a lot of drivers.
> 
> > Please, revert that to something sane before 2.6.9...
> 
> Nope. There's just too much confusion abou what the state thing means. 
> See the TG3 driver, for one, all the USB drivers for another.

The USB drivers aren't a good example, they are currently quite broken
as far as suspend/resume is concerned.  They used to work just fine
but got broken some time in the last few months.

The problem I have at the moment is that PCI drivers get asked to go
to D3 for both suspend-to-ram and suspend-to-disk.  In particular the
radeonfb driver wants to do different things in these two cases.

Really, what is bogus is pci-driver.c thinking it can tell what state
to ask the PCI device driver to put the device into from the system
power state, without using any platform information.  For suspend to
ram, we may need to put devices into D2, D3hot or D3cold, depending on
the motherboard design.  For suspend to disk, we don't really want to
change the device's power state at all, but just quiesce the device
and save its state.

In the radeonfb case, it needs to put the device into either D3hot or
D3cold (depending on the motherboard design) for suspend to ram.  For
suspend to disk it doesn't want to do much of anything (otherwise we
lose the console at that point).

> The long-term solution is to make this thing be not a number at all, but a 
> restricted type (ie a "struct" with one member, or similar) to make sure 
> you _cannot_ mis-use it. As it is, most PCI drivers do seem to expect a 
> PCI suspend state. 

Maybe the real problem is that we are trying to use the device suspend
functions for suspend-to-disk, when we don't really want to change the
device's power state at all.

Paul.
