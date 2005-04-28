Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVD1HAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVD1HAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVD1HAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:00:25 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:54180
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261780AbVD1HAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:00:11 -0400
Date: Wed, 27 Apr 2005 23:50:56 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com, bjorn.helgaas@hp.com,
       davem@redhat.com
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
Message-Id: <20050427235056.0bd09a94.davem@davemloft.net>
In-Reply-To: <1114670353.7182.246.camel@gaston>
References: <1114493609.7183.55.camel@gaston>
	<20050426163042.GE2612@colo.lackof.org>
	<1114555655.7183.81.camel@gaston>
	<1114643616.7183.183.camel@gaston>
	<20050428053311.GH21784@colo.lackof.org>
	<20050427223702.21051afc.davem@davemloft.net>
	<1114670353.7182.246.camel@gaston>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 16:39:13 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2005-04-27 at 22:37 -0700, David S. Miller wrote:
> > On Wed, 27 Apr 2005 23:33:11 -0600
> 
> > The 'offset' argument is defined to be page aligned
> > when passed to mmap().
> 
> mmap API in general is defined to only ever deal with page aligned
> parameters & return values no ?

Yes.

> Except from that page alignment thing ... which is the root of the
> problem.

You can hide all of those problems in libpci.a or whatever.
You page align the offset, but pass back to the user a pointer
with his sub-page offset applied to it.

The kernel wants pages, so just give it pages :-)

> > I hate to say this, but the largest consumer of this stuff is the
> > X server, so we really need to force ourselves to work in parallel
> > on clean X server support.
> 
> Cleaning X.org is my goal, this is why I'm trying to clean the kernel
> side first :) I'm also working separately on the problem of VGA access
> arbitration (We'll probably do a joint session with the desktop summit
> an the kernel summit about those issue).

Yeah, that one is all about enabling VGA forwarding in the bridges.

Taking out all of the resource garbage in the X server, and replacing
it with properly synchronized calls in the kernel for mapping ROMs
and changing the current VGA forwarding seems to be the way to go.

> > On many platforms some kind of "side effect" bit in the PTE
> > determine if store buffer compression can happen in the processor.
> > We'd want to not set such a bit for things like frame-buffers and
> > the like.
> 
> Yes, and I think that pretty much match with PCI devices exposing a
> "prefetchable" BAR, don't you agree ?

Some scsi controllers have prefetchable set in their normal
register BARs.  The sym53c8xx does if I remember correctly.

Anyways, what I'm trying to say is that blinding turning prefetchable
BAR into "don't set side effect bit in PTE" might not be so wise.

I really think it's a userlevel decision.  That's where all the ioctl()
garbage came from for the /proc/bus/pci mmap() stuff.  It was for chossing
IO vs MEM space, and also for setting these kinds of mapping attributes.
