Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVCLASu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVCLASu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVCLARG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 19:17:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:19172 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261387AbVCLAOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 19:14:24 -0500
Subject: Re: AGP bogosities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Paul Mackerras <paulus@samba.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       werner@sgi.com, Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1110583375.4822.88.camel@eeyore>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <200503102002.47645.jbarnes@engr.sgi.com>
	 <1110515459.32556.346.camel@gaston>
	 <200503110839.15995.jbarnes@engr.sgi.com> <1110563965.4822.22.camel@eeyore>
	 <16946.7941.404582.764637@cargo.ozlabs.ibm.com>
	 <1110583375.4822.88.camel@eeyore>
Content-Type: text/plain
Date: Sat, 12 Mar 2005 11:12:38 +1100
Message-Id: <1110586359.5810.139.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I still don't quite understand this.  If the host bridge is not a
> PCI device, what PCI device contains the AGP capability that controls
> the host bridge?  I assume you're saying that you are required to
> have TWO PCI devices that have the AGP capability, one for the AGP
> device and one for the bridge.
> 
> HP boxes certainly don't have that (zx6000 sample below).  I guess
> it wouldn't be the first time we deviated from a spec ;-)

We are basically hitting a "hole" in the PCI spec itself :) It doesn't
really defines how a host bridge can expose itself as a device. That
means that in most cases, the host bridge either isn't visible at all,
or is as a random device at the first level (which makes it a sibling of
other devices, quite broken ....). Also, there is no standard "devfn"
for it, so it can be anywhere and there is no "simple" way of knowing
which devie is actually the host in a generic way. Most of the time,
looking for a devie with the class "host bridge" will work, but it's not
guaranteed. Some hosts also expose the AGP stuff differently.

In some cases, like Apple U3 HT host, it also has a set of registers
that mimmic a PCI config space, but aren't implemented in the PCI config
space proper, and thus, unless you add special case to your pci_ops, you
won't see it on the bus. (Apple's AGP host appears as a device on it's
own bus though).

So while AGP requires a set of PCI config space registers with the AGP
capabilities for the host, it's very possible that you have those in a
space that don't appear on the PCI (just as MMIO registers on your
bridge somewhere), or whatever other fancy setup. In fact, that part of
the spec hits the above hole, so I wouldn't be surprised if vendors
decided to ignore it and do fancy things.

Ben.

