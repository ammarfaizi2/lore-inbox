Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUCWCVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUCWCVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:21:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:41963 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261879AbUCWCV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:21:28 -0500
Subject: Issues with /proc/bus/pci
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080007613.22212.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 13:06:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David !

I'm working on some userland code shell that helps soft booting
video cards, and so for once had to use our nice /proc/bus/pci
API to mmap the IO and memory spaces.

Doing that, I figured out we have a problem. On PPC, we never
implemented properly the 'trick' allowing to map the host bridge
itself (I though it was there but actually I was wrong) so that
mean we can't mmap space outside of the area represented by the
card's BARs.

I could add the host bridge thing fairly easily, but I think it
is not very practical. Well, I probably have to add it anyway in
case any existing stuff uses that, but it's definitely not
practical when you have a bit of useralnd that knows the PCI ID
(domain/bus/devfn) of the card and wants to access the legacy IO
space of that bridge. The problem is finding which pci_dev is
the host bridge, if any since host bridges aren't required to
show up at all.

Right now, I have a nice piece of code that goes straight to the
correct entry. Having to "find" the host means iterating all
devices, asking their domain number, and find the one that is
both of class host bridge and on the same domain. That also mean
properly fixing up any host bridge that doesn't show itself up
as a class host bridge device (you know how things can be especially
in the embedded world) and leaves a potential problem with host
bridges that just don't show up on the bus (that's currently the
case with the HyperTransport host on the G5, though I could fix
that in the long term, I suspect it may happen again elsewhere
as they aren't required to show up as devices).

What do you think of dealing with that with a slight addition to
the current ioctl's, basically adding a pair equivalent to
PCIIOC_MMAP_IS_IO and PCIIOC_MMAP_IS_MEM that would be
PCIIOC_MMAP_IS_HOST_IO and PCIIOC_MMAP_IS_HOST_MEM ? That would
be, imho, the simplest solution, as far as userland is concerned,
though it requires updating the implementation of pci_mmap_page_range()
of all archs that implement it.

Another simpler solution would be to consider that mapping outside
of a device is only ever useful for legacy ISA IO space and simply
fix the archs to allow an IO mapping of the IO region below 0x400
using any device pci_dev (provided the region exist on a given host
of course), since the value passed by userland is an absolute BAR
address in bus space, that would work.

What do you think ?

Ben.


