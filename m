Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWJ3OnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWJ3OnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWJ3OnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:43:03 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:2709 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964899AbWJ3OnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:43:00 -0500
Date: Mon, 30 Oct 2006 07:42:59 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Adam J. Richter" <adam@yggdrasil.com>,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pavel@ucw.cz, shemminger@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061030144259.GD10235@parisc-linux.org>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com> <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org> <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 09:23:10AM -0500, Kyle Moffett wrote:
> recursive make invocations and nested directories).  Likewise in the  
> context of recursively nested busses and devices; multiple PCI  
> domains, USB, Firewire, etc.

I don't think you know what a PCI domain is ...

> Well, perhaps it does.  If I have (hypothetically) a 64-way system  
> with several PCI domains, I should be able to not only start scanning  
> each PCI domain individually,  but once each domain has been scanned  
> it should be able to launch multiple probing threads, one for each  
> device on the PCI bus.  That is, assuming that I have properly set up  
> my udev to statically name devices.

There's still one spinlock that protects *all* accesses to PCI config
space.  Maybe we should make it one per PCI root bridge or something,
but even that wouldn't help some architectures.

> I admit the complexity is a bit high, but since the maximum nesting  
> is bounded by the complexity of the hardware and the number of  
> busses, and the maximum memory-allocation is strictly limited in the  
> single-threaded case this could allow 64-way systems to probe all  
> their hardware an order of magnitude faster than today without  
> noticeably impacting an embedded system even in the absolute worst case.

To be honest, I think just scaling PARALLEL to NR_CPUS*4 or something
would be a reasonable way to go.

If people actually want to get serious about this, I know the PPC folks
have some openfirmware call that tells them about power domains and how
many scsi discs they can spin up at one time (for example).  Maybe
that's not necessary; if we can figure out what the system's max power
draw is and how close we are to it, we can decide whether to spawn
another thread or not.

It's quite complicated.  You can spin up a disc over *here*, but not
over *there* ... this really is a gigantic can of worms being opened.
