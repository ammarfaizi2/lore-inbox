Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTAFFOy>; Mon, 6 Jan 2003 00:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbTAFFOy>; Mon, 6 Jan 2003 00:14:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25383 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266473AbTAFFOx>; Mon, 6 Jan 2003 00:14:53 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, <davidm@hpl.hp.com>,
       <grundler@cup.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Jan 2003 22:22:14 -0700
In-Reply-To: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com>
Message-ID: <m1n0mej1ix.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sun, 5 Jan 2003, Ivan Kokshaysky wrote:
> >
> > Hopefully this patch should solve most problems with probing the BARs.
> > The changes are quite minimal as everything still is done in one pass.
> 
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
> 
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
> 
> Hmm?

I have done something similar to this in LinuxBIOS, perhaps a
description of that will spark ideas.  

In the enumeration phase I look at the vendor+device id and then hdr
type to assign methods.  The methods I have are:
scan_bus,
read_bases,
write_bases.

Then for all children of a bus that have a scan_bus function I
recurse.  This fits in very naturally with devices not necessarily
being pci devices.

When it comes time to assign pci resources I call the read_bases
method to get the size and possibly fixed location of the resource.  I
play with my data structures to get a non conflicting set of resources
and then I call write_bases on each device to write the resource
assignments to the actual device.

The setup works well enough that I don't have to differentiation later
in the code between pci busses and normal pci devices.

I have not had to push beyond the standard pci devices yet, but I
don't think I have missed anything that would cause me problems.

Linus is this the kind of thing you are thinking of?

Eric
