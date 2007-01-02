Return-Path: <linux-kernel-owner+w=401wt.eu-S1752609AbXABXn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbXABXn4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXABXn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:43:56 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47791 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbXABXnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:43:55 -0500
Message-ID: <459AEE36.7080500@pobox.com>
Date: Tue, 02 Jan 2007 18:43:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>	<459973F6.2090201@pobox.com>	<20070102115834.1e7644b2@localhost.localdomain>	<459AC808.1030807@pobox.com>	<20070102212701.4b4535cf@localhost.localdomain>	<459ACE9C.7020107@pobox.com>	<20070102224559.2089d28d@localhost.localdomain>	<459AE459.8030107@pobox.com> <20070102232706.49340349@localhost.localdomain>
In-Reply-To: <20070102232706.49340349@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> 2.6.0 - 2.6.19:  libata guarantees that all PCI BARs are reserved to the 
>> libata driver.
> 
> Please read the code Jeff. The old IDE quirk code in the PCI layer blanked
> BAR 0 to BAR 3 of a compatibility mode controller

(a) I'm well of aware of this, and (b) that changes nothing.

I said "PCI BARs" for a reason.  libata was written according to the 
following model:

	1) Programmatically reserve /all/ resources associated with
	   our PCI device
	2) Manually reserve resources associated with our PCI device,
	   but are not listed in struct pci_dev.

You have changed this to:

	1) Manually reserve /some/ resources associated with PCI device
	2) Manually reserve resources associated with our PCI device,
	   but are not listed in struct pci_dev.

But then 2.6.21 goes back to:

	1) Programmatically reserve /all/ resources associated with
	   our PCI device
	2) Manually reserve resources associated with our PCI device,
	   but are not listed in struct pci_dev.

Maybe I can say it more clearly by telling you how to fix the regression 
you have introduced:  Loop through all BAR resources in struct pci_dev, 
and reserve them if they are not already reserved by libata earlier in 
the code.  There.  Regression fixed.

(but then we rewrite this code again in 2.6.21)


> You then request_region 0x1f0 and 0x170 (BAR 0 and BAR 2) directly. You
> never request the legacy BAR 1 and BAR 3 because they were erased by the
> PCI quirk code and thus never claim the other port. Thats been a bug since
> day one but it never seemed worth fixing in the short term.

Yes -- that's a bug, one that existed prior to the "it doesn't boot" 
combined mode regression everybody complained about.  I'm talking about 
a new regression just introduced via 
dc3c3377f03634d351fafdfe35b237b283586c04, not a old bug that existed 
prior to the regression introduced in 
368c73d4f689dae0807d0a2aa74c61fd2b9b075f.

	Jeff


