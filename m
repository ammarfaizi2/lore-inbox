Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVD1Gke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVD1Gke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 02:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVD1Gke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 02:40:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:34529 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261540AbVD1Gk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 02:40:26 -0400
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <20050427223702.21051afc.davem@davemloft.net>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
	 <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org>
	 <20050427223702.21051afc.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 16:39:13 +1000
Message-Id: <1114670353.7182.246.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 22:37 -0700, David S. Miller wrote:
> On Wed, 27 Apr 2005 23:33:11 -0600

> The 'offset' argument is defined to be page aligned
> when passed to mmap().

mmap API in general is defined to only ever deal with page aligned
parameters & return values no ?

> > If it's a token, the arch specific mmap() will know how to deal with it.
> > parisc does that with IO Port space(s) in the kernel.
> 
> Yes, if the token goes in as the offset parameter to mmap() then
> whatever ->mmap() code we write can call arch specific code to
> transform it as necessary.

Except from that page alignment thing ... which is the root of the
problem.

> It's been around for ages, and it used in the X server on PPC
> and Sparc.  It mostly allows handling of multi-domain stuff.
> Unfortunately, the $DOMAIN:xxx directory naming change we made
> in 2.6.x for /proc/pci stuff broke the X server at least on
> sparc64 :-/

In fact, I'm fairly sure X still uses /dev/mem on ppc :( Oh well...

> I hate to say this, but the largest consumer of this stuff is the
> X server, so we really need to force ourselves to work in parallel
> on clean X server support.

Cleaning X.org is my goal, this is why I'm trying to clean the kernel
side first :) I'm also working separately on the problem of VGA access
arbitration (We'll probably do a joint session with the desktop summit
an the kernel summit about those issue).

> Whether that's via some libpci.a
> abstraction or whatever, I personally don't care, but without the
> X support in some form all of this is API masterbation :-)

It is :) Userland driver stuff is a consumer too though.

> > If it's prefetchable, won't the reads/writes automatically be combined?
> > Since I equate "prefetchable" == "cacheable", I'd think anything
> > is fair game.
> 
> On many platforms some kind of "side effect" bit in the PTE
> determine if store buffer compression can happen in the processor.
> We'd want to not set such a bit for things like frame-buffers and
> the like.

Yes, and I think that pretty much match with PCI devices exposing a
"prefetchable" BAR, don't you agree ?

Ben.


