Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVBNWZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVBNWZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVBNWZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:25:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6110 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261356AbVBNWZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:25:38 -0500
Message-ID: <42112544.2030006@pobox.com>
Date: Mon, 14 Feb 2005 17:25:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: avoiding pci_disable_device()...
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com>	<4211013E.6@pobox.com> <52hdke29sh.fsf@topspin.com>	<20050214200043.GA15868@havoc.gtf.org> <52d5v224z3.fsf@topspin.com>
In-Reply-To: <52d5v224z3.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jeff> That's an MSI bug.
> 
>     Jeff> A current PCI driver -should- be using pci_request_regions().
> 
> Hmm... I'm not sure everyone would agree with that.  It does make
> sense that the MSI-X core wants to make sure that it owns the MSI-X
> table without having someone else stomp on it.

The idea is right but the implementation is definitely incorrect, for 
multiple reasons:

* Every PCI driver should call pci_request_regions(), because there 
should only be one pci_driver associated with that set of resources.

* Therefore, any _addition_ to the PCI API that prevents a driver from 
using pci_request_regions() causes multiple problems, by virtue of 
diverging from the other 98% of the kernel's PCI drivers, which use 
pci_request_regions().

IOW, MSI-X's implementation incorrectly constrains PCI driver authors.

* Programmer over-protection.  Who is attempting to stomp on MSI-X 
tables?  If a driver is reading an MSI-X bar and doing something without 
consulting the kernel MSI-X code, that's a bug and most likely a 
violation of the PCI spec.  Fix the driver.

In Linux we don't over-protect programmers with a zillion sanity checks 
for every internal API call; that leads to bloat, and papers over bugs 
that should be fixed.

	Jeff


