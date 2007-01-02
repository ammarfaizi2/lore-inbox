Return-Path: <linux-kernel-owner+w=401wt.eu-S1754959AbXABWFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbXABWFJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbXABWFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:05:08 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47511
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964970AbXABWFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:05:06 -0500
Date: Tue, 02 Jan 2007 14:05:04 -0800 (PST)
Message-Id: <20070102.140504.71092282.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       dmk@flex.com, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org>
References: <24a109a8fa0f45011daf3e2b55172392@kernel.crashing.org>
	<1167768735.6165.68.camel@localhost.localdomain>
	<bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 2 Jan 2007 22:28:21 +0100

> >> Not single thread -- but a "global OF lock" yes.  Not that
> >> it matters too much, (almost) all property accesses are init
> >> time anyway (which is effectively single threaded).
> >
> > Not that true anymore. A lot of driver probe is being threaded 
> > nowadays,
> > either bcs of the new multithread probing bits, or because they get
> > loaded by userland from some initramfs etc..
> 
> The kernel doesn't care if one CPU is in OF land while the others
> are doing other stuff -- well you have to make sure the OF won't
> try to use a hardware device at the same time as the kernel, true.

True, but at the very least you have to prevent multiple cpus
from enterring OFW.  In fact this is very important.

OFW is not multi-threaded therefore you can't let multiple CPUs call
into OFW at one time.  You must use some kind of locking mechanism,
and that locking mechanism is not simple because it has to not just
stop the other cpus, it has to be able to stop the other cpus yet
still allow them to receive SMP cross-calls from the firmware if the
OFW call is 'stop' or similar.

> I'm a bit concerned about the 100kB or so of data duplication
> (on a *quite big* device tree), and the extra code you need
> (all changes have to be done to both tree copies).  Maybe
> I shouldn't be worried; still, it's obviously not a great
> idea to *require* any arch to get and keep a full copy of
> the tree -- it's wasteful and unnecessary.

The largest amount of memory I've ever seen consumed on sparc64
was 76K and this is 1) 64-bit and 2) an ENORMOUS machine with
lots of cpus and devices.  And I know because sparc64 prints
a kernel message at boot which states how much memory was
consumed by the in-kernel device tree copy.

That ENORMOUS machine also had a lot of ram.

76K, that's just over 8 FREAKIN PAGES.  It's nothing!

I think all this worry is overblown, terribly so in fact.

Please let's get over this memory consumption non-issue and move
on to more productive talk.
