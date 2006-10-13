Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWJMRIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWJMRIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWJMRIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:08:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9619 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751392AbWJMRIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:08:47 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adam Belay <abelay@MIT.EDU>, Arjan van de Ven <arjan@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061013164933.GD11633@parisc-linux.org>
References: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
	 <1160753187.25218.52.camel@localhost.localdomain>
	 <1160753390.3000.494.camel@laptopd505.fenrus.org>
	 <1160755562.25218.60.camel@localhost.localdomain>
	 <1160757260.26091.115.camel@localhost.localdomain>
	 <1160759349.25218.62.camel@localhost.localdomain>
	 <20061013164933.GD11633@parisc-linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 18:34:27 +0100
Message-Id: <1160760867.25218.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 10:49 -0600, ysgrifennodd Matthew Wilcox:
> No it didn't.  It's undefined behaviour to perform *any* PCI config
> access to the device while it's doing a D-state transition.  It may have

I think you missed the earlier parts of the story - the kernel caches
the base config register state.

> happened to work with the chips you tried it with, but more likely you
> never hit that window because X simply didn't try to do that.

Which is why the kernel caches the register state. This all came up long
ago and the solution we currently have was the one chosen after
considerable debate and analysis about things like locking. We preserved
the historical reliable interface going back to the early Linux PCI
support and used by all the apps.


There are several problems with making it return an error

- What does user space do ?

	while(pci_...() == -EAGAIN) yield();

which is useful how - there is no select operation for waiting here, and
while it could be added it just gets uglier

- Who actually wants to get an error in that specific case ?

If you can find someone who desperately wants an error code then code in
O_DIRECT support to do it and preserve the existing sane API.

The job of the kernel is not to expose hardware directly, it is to
provide sane interfaces to it. We don't have separate interfaces to
conf1, conf2, pcibios etc for good reason. Exposing everyone to ugly
minor details of the PCI transition handling isn't progress.


Alan

