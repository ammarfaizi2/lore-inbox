Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbTAFP1w>; Mon, 6 Jan 2003 10:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTAFP1w>; Mon, 6 Jan 2003 10:27:52 -0500
Received: from [195.208.223.236] ([195.208.223.236]:20864 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266989AbTAFP1t>; Mon, 6 Jan 2003 10:27:49 -0500
Date: Mon, 6 Jan 2003 18:33:28 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       grundler@cup.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030106183328.B677@localhost.park.msu.ru>
References: <20030105153735.A8532@jurassic.park.msu.ru> <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 05, 2003 at 08:14:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 08:14:53PM -0800, Linus Torvalds wrote:
> Can you do the same with a multi-pass thing? 
> 
> I really think the single-pass approach is broken, because it means that
> we _cannot_ have a fixup for device that runs _before_ the fixup for the 
> bridge that bridges to the device.
> 
> As such, the "PCI_FIXUP_EARLY" is not _nearly_ early enough, since it's
> way too late for the actual problem that started this whole thread (ie in
> order to turn off a bridge, we have to make sure that everything behind
> the bridge is turned off _first_).

I totally agree, 2-phase approach is a right way to go. However, I've been
confused by that "feature freeze" thing. ;-)
This patch has zero impact on existing code - I thought it's a "feature"
(and I still believe it's ok for 2.4).
OTOH, I've actually tried to implement 2-phase probing _inside_ the
pci_do_scan_bus, and that was ugly as hell.
I believe the phase #2 must be a separate top-level function -
something like pci_probe_resources (better naming?), but this
assumes some changes to PCI code for every architecture and hotplug
drivers.
 
> In other words, we really should be able to do all the bus number setup
> _first_. That isn't dependent ont eh BAR's or anything else. The actual 
> _sizing_ of the bus is clearly somethign we cannot do early, but we can 
> (and should) enumerate the devices first in phase #1.
> 
> Alternatively, we could even have a very limited phase #1 that only 
> enumerates _reachable_ devices (ie it doesn't even try to create bus 
> numbers, it only enumerates devices and buses that have already been set 
> up by the firmware, and ignores bridges that aren't set up yet). A pure 
> discovery phase, without any configuration at all.

I like the former. Even if we have to reassign the bus numbers,
we won't affect anything but forwarding the PCI configuration
cycles.

For now I'd start with following:
phase #1. pci_do_scan_bus() - build the bus/device tree, read in
          dev/vendor IDs, header type and class code; call
	  "PCI_FIXUP_EARLY" fixups.
phase #2. pci_probe_resources(bus) - walk the bus tree again,
	  probe the BARs, maybe call pci_read_bridge_bases for
	  bridges; fill in the rest of PCI header; call "PCI_FIXUP_HEADER"
	  fixups.
(Also there are phases #3 and #4 - assign resources and assign unassigned
resources, but it's another story)

Then, for example on alpha, we'll have

	/* Scan all of the recorded PCI controllers.  */
	for (next_busno = 0, hose = hose_head; hose; hose = hose->next) {
		hose->first_busno = next_busno;
		hose->last_busno = 0xff;
		bus = pci_scan_bus(next_busno, alpha_mv.pci_ops, hose);
		hose->bus = bus;
		next_busno = hose->last_busno = bus->subordinate;
+		pci_probe_resources(bus);
		next_busno += 1;
	}

Hmm, this looks good - now we can do early bus-specific fixups
without introducing "pcibios_init_bus" thing (suggested by Grant and
myself quite a while ago).

I'll try to code up all of this and do some basic testing on alpha
and i386 in next few days.

Comments?

Ivan.
