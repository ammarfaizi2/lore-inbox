Return-Path: <linux-kernel-owner+w=401wt.eu-S1750939AbXACA1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbXACA1u (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXACA1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:27:50 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60785 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750939AbXACA1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:27:49 -0500
Date: Wed, 3 Jan 2007 00:36:35 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
Message-ID: <20070103003635.626cdfb3@localhost.localdomain>
In-Reply-To: <459AEE36.7080500@pobox.com>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	<459973F6.2090201@pobox.com>
	<20070102115834.1e7644b2@localhost.localdomain>
	<459AC808.1030807@pobox.com>
	<20070102212701.4b4535cf@localhost.localdomain>
	<459ACE9C.7020107@pobox.com>
	<20070102224559.2089d28d@localhost.localdomain>
	<459AE459.8030107@pobox.com>
	<20070102232706.49340349@localhost.localdomain>
	<459AEE36.7080500@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	1) Programmatically reserve /all/ resources associated with
> 	   our PCI device
> 	2) Manually reserve resources associated with our PCI device,
> 	   but are not listed in struct pci_dev.

Which it doesn't actually do. You reserve 0x1F0-0x1F7 but forget the
other register. BTW on unload you forget to release 0x1F0-7 too. I've not
fixed that as its not a regression just a bug. It's just another symptom
of a pile of code trying to do things the wrong way, in the wrong place.

> But then 2.6.21 goes back to:
> 
> 	1) Programmatically reserve /all/ resources associated with
> 	   our PCI device
> 	2) Manually reserve resources associated with our PCI device,
> 	   but are not listed in struct pci_dev.

Nope. You are either very confused about how PCI bus resources work or
you are trying to implement the future code in a very very peculiar way 8)

Remember with the resource tree now correct all the resources for an IDE
controller *are* in the pci_dev struct properly - the special cases are
all gone in libata and in drivers/ide.

Once combined mode is fixed not to abuse resources (and it originally
did it that way for a good reason I grant and am not criticising that) the
entire management for legacy mode, mixed mode and native mode resources
for an ATA device (including 0x170, 0x3F6 and other wacky magic) becomes

	if (pci_request_regions(pdev, "libata")) ...

You'll note:
- No special cases for differing modes
- No libata knowledge of PCI legacy mapping rules and addresses
- The death of the magic ATA_PRIMARY/SECONDARY constants and their magic
numbers
- Support for platforms that map legacy space differently
- Trivial cleanup from failure unlike the current code

all in one line. This will also fix all the existing bugs where unloading
a libata driver fails to free resources as pci_release_regions() will also
now do the correct thing.

*That* is one key reason why getting the PCI resource map right is so
important. We turn fifty lines of bug ridden hard to debug code into one
line of code that actually does more than the original, and gets it
right. For free we get the leaked resources after rmmod fixed, we get the
mixed mode resources fixed, we get all this stuff for free. We get to
shoot a chunk of code in drivers/ide if we want as well.

If we want to keep a combined mode in 2.6.21 with drivers/ide (which
seems dumb as libata has progressed far beyond the need for it) then the
-mm tree has a pci_request_regions_mask() function which we can push
to .21 development and we end up with five lines not three for these
cases.

Make sense ?

Alan
