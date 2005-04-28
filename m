Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVD1FtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVD1FtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVD1FsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:48:24 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:9681
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262127AbVD1FqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:46:14 -0400
Date: Wed, 27 Apr 2005 22:37:02 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: benh@kernel.crashing.org, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, bjorn.helgaas@hp.com, davem@redhat.com
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
Message-Id: <20050427223702.21051afc.davem@davemloft.net>
In-Reply-To: <20050428053311.GH21784@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston>
	<20050426163042.GE2612@colo.lackof.org>
	<1114555655.7183.81.camel@gaston>
	<1114643616.7183.183.camel@gaston>
	<20050428053311.GH21784@colo.lackof.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005 23:33:11 -0600
Grant Grundler <grundler@parisc-linux.org> wrote:

> I would expect the mmap() return value to point at the base of
> whatever thing it is that I handed it. And everything is relative
> to that within the range that I ask be mmap'd.

The 'offset' argument is defined to be page aligned
when passed to mmap().

> If it's a token, the arch specific mmap() will know how to deal with it.
> parisc does that with IO Port space(s) in the kernel.

Yes, if the token goes in as the offset parameter to mmap() then
whatever ->mmap() code we write can call arch specific code to
transform it as necessary.

> This is similar to davem's reminder about 32-bit user space on 64-bit
> platform. I expect some form of token will need to be used if user
> space can't be taught/forced to use 64-bit values coming from
> either /sys or /proc. It's probably best to leave /proc untouched
> and only mangle /sys so it always prints 64-bit values.

Let's make sys use 64-bit, yes.

> I didn't know anything about pci_mmap_page_range().
> parisc and alpha don't implement it. And both translate the IO View
> (BAR values) to CPU view (resource) for MMIO space.

It's been around for ages, and it used in the X server on PPC
and Sparc.  It mostly allows handling of multi-domain stuff.
Unfortunately, the $DOMAIN:xxx directory naming change we made
in 2.6.x for /proc/pci stuff broke the X server at least on
sparc64 :-/

> sys-fs support also uses it:
> 
> grundler <533>fgrep HAVE_PCI_MMAP drivers/pci/*
> drivers/pci/pci-sysfs.c:#ifdef HAVE_PCI_MMAP
> drivers/pci/pci-sysfs.c:#else /* !HAVE_PCI_MMAP */
> drivers/pci/pci-sysfs.c:#endif /* HAVE_PCI_MMAP */
> 
> Documentation/filesystems/sysfs-pci.txt at least mentions which
> parameters can be passed to mmap and what the arch must provide.

I hate to say this, but the largest consumer of this stuff is the
X server, so we really need to force ourselves to work in parallel
on clean X server support.  Whether that's via some libpci.a
abstraction or whatever, I personally don't care, but without the
X support in some form all of this is API masterbation :-)

> If it's prefetchable, won't the reads/writes automatically be combined?
> Since I equate "prefetchable" == "cacheable", I'd think anything
> is fair game.

On many platforms some kind of "side effect" bit in the PTE
determine if store buffer compression can happen in the processor.
We'd want to not set such a bit for things like frame-buffers and
the like.

