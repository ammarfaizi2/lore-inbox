Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVFJX2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVFJX2C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 19:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVFJX2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 19:28:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:39101 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261448AbVFJX0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 19:26:03 -0400
Subject: Re: [PATCH 00/10] IOCHK interface for I/O error handling/detecting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <42A96C25.9050903@jp.fujitsu.com>
References: <42A8386F.2060100@jp.fujitsu.com>
	 <20050609173433.GE24611@parcelfarce.linux.theplanet.co.uk>
	 <42A96C25.9050903@jp.fujitsu.com>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 09:25:09 +1000
Message-Id: <1118445909.5986.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I think this is the wrong way to go about it.  For PCI Express, we
> > have a defined cross-architecture standard which tells us exactly how
> > all future PCIe devices will behave in the face of errors.  For PCI and
> > PCI-X, we have a lot of legacy systems, each of which implements error
> > checking and recovery in a somewhat eclectic way.

We already defined something for recovery that everybody seem to be fine
with and that isn't tied around PCIe specifics. I do not think PCIe is
the ultimate panacea that will replace everything.
 
> > So, IMO, any implementation of PCI error recovery should start by
> > implementing the PCI Express AER mechanisms and then each architecture can
> > look at extending that scheme to fit their own legacy hardware systems.

No, I strongly disagree.

> > That way we have a clean implementation for the future rather than being
> > tied to any one manufacturer or architecture's quirks.
>>
> > Also, we can evaluate it based on looking at what the standard says,
> > rather than all trying to wrap our brains around the idiosyncracies of
> > a given platform ;-)

> All right, please take it a example of approach from legacy-side.
> 
> Already there are good working group, includes Linas, BenH, and Long.
> They are also implementing some PCI error recovery codes (currently
> setting home to ppc64), and I know their wonderful works are more PCI
> Express friendly than my mysterious ia64 works :-)
>
> However, I also know that it doesn't mean my works were useless.
> Since there is a notable difference between their asynchronous error
> recovery and my synchronous error detecting, both could live in
> coexistence with each other.
> 
> How cooperate with is interesting coming agenda, I think.

Well, our recovery mecanism is intended to be an addition to the
synchronous error detection. If you read carefully my document for
example, I specify places where driver should still do synchronous
detection, especially in some of the recovery phases themselves.

We have agreed a long time ago that a good mecanism for synchronous
detection is to sandwitch IOs that way. The actual implementation may
use AER, pSeries EEH mecanisms, PCI/PCI-X status errors bits (that need
per-segment locks though) etc... depending on the architecture.

Since the actual error information can be very varied, the error
"cookie" was suggested as an opaque way to carry that information and
keep track of other platform specific things. We can then add specific
accessors to extract useful infos (or dump as ASCII for some logging
facility) the details of the error cookie.

Ben.
 

