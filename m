Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVCAWXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVCAWXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVCAWXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:23:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:51394 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262089AbVCAWWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:22:44 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
References: <422428EC.3090905@jp.fujitsu.com> <42249A44.4020507@pobox.com>
	 <Pine.LNX.4.58.0503010844470.25732@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 09:20:22 +1100
Message-Id: <1109715623.5679.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 08:49 -0800, Linus Torvalds wrote:
> 
> On Tue, 1 Mar 2005, Jeff Garzik wrote:
> > 
> > A new API handles none of this.
> 
> Ehh? 
> 
> The new API is what _allows_ a driver to care. It doesn't handle DMA, but
> I think that's because nobody knows how to handle it (ie it's probably
> hw-dependent and all existign implementations would thus be
> driver-specific anyway).

We do on pSeries. Additionally, another device on the same physical
segment can trigger an error and cause a slot isolation on us even when
we do no IOs, so we also need asynchronous notification.

> And in the sense of "any general new api handles none of it", your 
> argument doesn't make sense. The _old_ IO API's clearly don't handle it. 
> So if you seem to say that "A new API" can't handle it either, then that 
> translates to "no API can ever handle it". Fair enough, if you think it's 
> impossible, but clearly you can handle some things.
> 
> And yes, CLEARLY drivers will have to do all the heavy lifting. 

I think Seto has a good start tho. But it's not enough. See my other
mail to Jeff for my other thought on the issue, I'm still trying to get
some API I'm happy myself with however, since it's not a simple issue.

> I don't expect most drivers to care. In fact, I expect about five to ten
> drivers to be converted to really care, and then for some forseeable time
> you'll have to be very picky about your hardware if you care about PCI 
> parity errors etc. Most people don't, and most drivers won't be written in 
> environments where they can be reasonably tested.

On pSeries, we'll default, for drivers that don't care, to triggering a
PCI unplug, slot reset, PCI re-plug. This is perfect for ethernet
drivers for example. But it's a real pain for block devices since they
won't be able to recover (and we can't even force unmount the dangling
filesystem afaik).

For drivers like IPR SCSI, we want to expose a richer API so they can
make use of the features provided by the platform, like resetting the
slot.

But the above also need to be able to differenciate a driver that cares
from a driver that doesn't. I think an additional callback in pci_driver
for notifying of async events (error happened, slot has been reset, IOs
are re-enabled, whatever we define ...) is a good idea, since the
presence of a callback is a good enough indication to the core of wether
the driver has it's own recovery strategy or not.

> That's just a fact. Anybody who expects all drivers to suddenly start 
> doing IO checks is just living in a dream world.
> 
> 		Linus
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

