Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVCAS7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVCAS7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 13:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVCAS7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 13:59:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:13809 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261556AbVCAS7m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 13:59:42 -0500
Date: Tue, 1 Mar 2005 12:59:39 -0600
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050301185939.GC1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <m1hdjvi8r3.fsf@muc.de> <Pine.LNX.4.58.0503011001320.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503011001320.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 10:08:48AM -0800, Linus Torvalds was heard to remark:
> 
> On Tue, 1 Mar 2005, Andi Kleen wrote:
> > 
> > But what would the default handling be? It would be nice if there
> > was a simple way for a driver to say "just shut me down on an error"
> > without adding iochk_* to each function. Ideally this would be just
> > a standard callback that knows how to clean up the driver.
> 
> There can't be any.
> 
> The thing is, IO errors just will be very architecture-dependent. Some 

:) 
FWIW, I've got a working prototype that is ppc64-architecture specific
and I've been yelled at for not proposing an architecture-generic API
and so my current goal is to hash out enough commonality with Seto to 
come up with a generic API that's acceptable for the mainline kernel.

(FYI, the 'prototype' currently ships with Novell/SUSE SLES9, but 
I haven't been sucessful in getting the patches in upstream.)

> might have exceptions happening, without the exception handler really 
> having much of an idea of who caused it, unless that driver had prepared 
> it some way, and gotten the proper locks.

Most hotplug-capable drivers are "most of the way there", since they
can deal with the sudden loss of i/o to the pci card, and know how
to clean themselves up.

> A non-converted driver just doesn't _do_ any of that. It doesn't guarantee 
> that it's the only one accessing that bus, since it doesn't do the 
> "iocheck_clear()/iocheck_read()" things that imply all the locking etc.

Yes; for example, the pci error might affect multiple device drivers.
The proposal is that there should be a "master cleanup thread" to
deal with this (see my other email).

> Shutting down the hardware by default might be a horribly bad thing to do

The current ppc64 prototype code does a pci-hotplug-remove/hotplug-add
if we've detected a pci error, and the affected device driver doesn't 
know what to do.  This works for ethernet cards, but can't work for
anything with a file system on it (because a pci-hotplug-remove 
on a scsi card trickles up to the block device, which trickles up to
the file system, which can't be unmounted post-facto.) 

> In fact, I'd argue that even a driver that _uses_ the interface should not
> necessarily shut itself down on error. Obviously, it should always log the
> error, but outside of that it might be good if the operator can decide and
> set a flag whether it should try to re-try (which may not always be
> possible, of course), shut down, or just continue.

On ppc64, "just continue" is not an option; the pci slot is "isolated"
all i/o is blocked, including dma. 

The current prototype code tells the device driver that the pci slot is
hung, then it resets the slot, then it tells the device driver that the
pci slot is good-to-go again.  

My goal is to negotiate a standard set of interfaces in struct pci_driver 
to do the above. (see other email).

--linas

