Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUBYAnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbUBYAnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:43:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:53940 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262351AbUBYAm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:42:59 -0500
Subject: Re: IOMMUs was Re: Intel vs AMD x86-64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       richard.brunner@amd.com
In-Reply-To: <20040227022849.6d9f88ef.ak@suse.de>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com.suse.lists.linux.kernel>
	 <Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	 <20040223134853.5947a414.davem@redhat.com.suse.lists.linux.kernel>
	 <Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	 <p73r7wk607c.fsf_-_@verdi.suse.de>
	 <20040224101340.47341f28.davem@redhat.com>
	 <20040227022849.6d9f88ef.ak@suse.de>
Content-Type: text/plain
Message-Id: <1077669384.1128.38.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 11:36:25 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Arjan suggested it some time ago already. In fact I implemented it, it's in the current code.
> But it caused data corruption with a few devices, in particular 3ware, so I had 
> to disable it again. I didn't find a bug in the code. It worked fine with others. My theory 
> was that it triggered some hardware bug that was normally masked by the frequent flushes, but 
> I wasn't able to track it down without heavy equipment.

Interesting. I'm having a data corruption issue with the G5 iommu that
I can fix by always mapping everything. That is non-mapped virtual
IO pages are actually mapped to a dummy RAM page. It seems there is a
problem with the PCI<->HT bridge doing prefetches beyond iommu mapped
pages, thus triggering an iommu error, which in turns probably triggers
some other chipset bug ending up in data corruption. Having everything
mapped (allowing prefetch to complete even while prefetched data is
actually useless) fixes the problem and we don't see any corruption.

Of course, that means we can not longer use the mecanism we first
implemented where we would only flush the iommu TLB once after runnning
out of virtual pages to allocate. We have to flush on every insertion
and removal now :( On the other hand, we can probably do per-tag TLB
flushes instead of flushing the whole TLB once we properly figure out
how to access the tag registers on the chipset and their format (the
darwin source code seem to imply that is doable, but doesn't actually
use that, but in this regard, apple's implementation is impressively
sub-optimal).

Ben.


