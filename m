Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUBRRY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUBRRY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:24:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60105
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S267537AbUBRRYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:24:52 -0500
Date: Wed, 18 Feb 2004 18:24:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: module unload deadlock
Message-ID: <20040218172446.GD4478@dualathlon.random>
References: <20040217172646.GT4478@dualathlon.random> <20040218041527.052222C510@lists.samba.org> <20040218043555.GY8858@parcelfarce.linux.theplanet.co.uk> <20040218154040.GZ4478@dualathlon.random> <20040218164659.GA31035@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218164659.GA31035@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 04:46:59PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Feb 18, 2004 at 04:40:41PM +0100, Andrea Arcangeli wrote:
> > On Wed, Feb 18, 2004 at 04:35:55AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > It's clear this could be fixed by making sure parport won't call
> > request_module from cleanup_module, the primary reason I fixed it in the
> > module code is that I don't know if other drivers are doing this, do
> > you? What parport did was legitimate, and it was working fine in the
> > past, sure the parport code could be made slightly more complex and
> > aware about the fact it doesn't worth to try loading the lowlevel module
> > in cleanup_exit, but it wasn't obviously wrong, the cleanup/init module
> > are slow paths, it didn't matter if parport tried to load a lowlevel
> > module there.
> 
> Sigh...
> 
> No, it wasn't legitimate.  As the matter of fact, _nothing_ outside of
> parport/share.c has any business looking at the list of ports.  IOW,
> parport_enumerate() should be removed regardless of the request_module()
> crap.
> 
> In particular, parport_pc should keep track of the ports it had created
> instead of messing with parport_enumerate().

The one you propose (of parport_pc keeping track of the ports by itself)
is a different model, currently it's the highlevel that keeps track of
the ports and each lowlevel registers the lowlevel ports in the
highlevel list of ports. It doesn't mean the current model is wrong. You
may not like it and you may find it less efficient, or less clean, or
whatever, but the current model is definitely legitimate (the parport
code has the troubles you found in the sharing code locking, but this
registration model you're complaining about now is legitimate instead).

But let's ignore parport, the only question is if you know if other
modules are doing the same thing or not. Calling request_module from
cleanup_module was allowed with the 2.4 module API, now it deadlocks.
The only single reason I changed the module code is to avoid other
modules to deadlock in rmmod.
