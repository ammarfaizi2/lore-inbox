Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWGKFVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWGKFVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 01:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWGKFVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 01:21:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:15032 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965170AbWGKFVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 01:21:03 -0400
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m14pxolryw.fsf@ebiederm.dsl.xmission.com>
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	 <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	 <1152571162.1576.122.camel@localhost.localdomain>
	 <m14pxolryw.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 15:20:05 +1000
Message-Id: <1152595205.6346.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I didn't really expect you to have an immediate use, but the
> confirmation is nice.  The interesting part is how I have factored out
> the arch specific details. I believe this is close to the direction
> you envisioned for msi.  If you could look at the basic structure
> and confirm that the structure looks properly arch neutral that
> would be appreciated.  As time permits I want to make the msi code
> look more the this hypertransport irq code.

Ok, I'll try to have a second look in the plane :) (I'm flying off
tomorrow). If you are interested in the new IRQ infrastructure I did for
powerpc, it's now upstream (read comments in arch/powerpc/kernel/irq.c).
My idea for MSIs etc... is that I've completley disconnected linux
interrupt numbers and HW vector numbers for a given controller. Thus I
can allocate linux virtual irq numbers (including linear ranges of them
if we ever want to handle multiple MSIs (not MSI-X) etc.. However, it's
up to a given irq controller to handle it's own allocation of vectors
for those MSIs. Some controllers may have a fixed set of vectors
reserved for MSIs, or in some cases, like pSeries LPAR, the firmware
controls everything and just hands me a bunch of vectors for devices,
etc... 

That also mean that the allocation of vectors for a given controller
that can do MSI will be handled completely locally to the driver of that
controller. For example, on the Quad G5, I will have the MPIC driver
locally have a bitmap of what irq sources are used by LSIs and HT
interrupts coming from IO-APICs (pretty much the same as LSIs as far as
the driver is concerned) and will implement a local allocator to handle
the allocation of the remaining sources by MSI capable devices.

One problem I have at this point is with multiple MSIs. Our current
interface, pci_enable_msi(), is pretty much documented as only ever
enabling one MSI and I don't quite understand why we did that in the
first place. It seems ok to me to define that it can enable 2^N MSIs as
requested by the device with consecutive numbers starting at pdev->irq.
Now if we don't want to change that, I would propose that we define a
new interface, pci_enable_msi_multi(pdev, order, array) to which we can
pass a requested count (order) which has to be <= to the device number
of requested MSIs (so the driver can ask for less if it knows it doesn't
need as much as the device asks for) and the actual interrupts infos are
returned via an array identical to the one used for MSI-X. That way,
even if hardware MSI vectors still have to be naturally aligned on the
number requested and consecutive, the returned linux IRQ numbers don't
have to. In addition, by holding the list of IRQs in the same data
structure as MSI-X, this simplifies drivers who want to implement both
modes.

I don't have time to work much on the MSI aspect of things before OLS
though and I'll be away after that until end of august with only
intermittent internet access, so we'll talk about it again either at OLS
itself if we find some time, or when I'm back.

Cheers,
Ben.


