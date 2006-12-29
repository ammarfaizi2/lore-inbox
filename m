Return-Path: <linux-kernel-owner+w=401wt.eu-S1030179AbWL2Vxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWL2Vxa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030180AbWL2Vxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:53:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:48613 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030179AbWL2Vx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:53:29 -0500
Subject: Re: 2.6.20-rc2: kernel BUG at include/asm/dma-mapping.h:110!
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: linux1394-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <je7iwa1l8a.fsf@sykes.suse.de>
References: <je7iwa1l8a.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sat, 30 Dec 2006 08:52:51 +1100
Message-Id: <1167429171.23340.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Bisecting has identified this commit:
> 
> commit 9b7d9c096dd4e4baacc21b2588662bbb56f36c4e
> Author: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Date:   Wed Nov 22 21:44:34 2006 +0100
> 
>     ieee1394: sbp2: convert from PCI DMA to generic DMA
>     
>     API conversion without change in functionality
>     
>     Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> 
> 
> I'm only seeing this on ppc64, ppc32 seems to be working fine.

The patch looks totally bogus to me. It's passing a random struct device
from the hbsp host data structure to the dma_map_* routines. which they
can't do anything about.

The dma_map_* routines only know about some bus types. That's always
been the case (that's why you also can't pass a usb device's struct
device to them for example). Mostly, PCI, possibly others depending on
the platform.

So if you are to pass a struct device pointer to dma_map_*, use the one
inside the pci_dev of the host. Or have the host driver provide you with
the struct device pointer (which is the one from the pci_dev * for PCI
implementations, and others give you what they are on, assuming the
platform can do dma-* on that device).

Ben.


