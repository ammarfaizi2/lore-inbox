Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUDFLwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbUDFLwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:52:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263771AbUDFLvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:51:46 -0400
Date: Tue, 6 Apr 2004 12:51:45 +0100
From: Matthew Wilcox <willy@debian.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux IA64 Mailing List <linux-ia64@vger.kernel.org>,
       Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Subject: Re: [RFC] readX_check() - Interface for PCI-X error recovery
Message-ID: <20040406115145.GA23258@parcelfarce.linux.theplanet.co.uk>
References: <0HVQ0051BXG19H@fjmail506.fjmail.jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0HVQ0051BXG19H@fjmail506.fjmail.jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 08:04:49PM +0900, Hidetoshi Seto wrote:
> - Resources newly required:
> 
>     on struct device:
> 	error flag
> 	list of recoverable physical address regions

Can't you just use the pci_dev->resource regions for this?

> 	pointer to host bridge of the device

Again, there's already ways of getting to this from the pci_dev.
Simply wander up through pdev->bus->self until you get to a self that
is NULL and you've found a root bus.  Alternatively, you might just look
at PCI_CONTROLLER() on ia64.

>     on per_cpu:
> 	list of currently checking devices
> 
> 
> - Interfaces newly required:
> 
>     clear_pcix_errors(dev)
> 	Clear the error flag of the dev, and start to check the device.
> 	This also clears the status register of its host bridge.

For consistency, how about naming these functions pci_clear_errors()
and pci_check_errors()?  PCI-Express has similar error-checking abilities
and I'd hate to see two extremely similar capabilities at war with each
other over unacceoptable names ;-)

>     readX_check(dev,vaddr)
> 	Read a register of the device mapped to vaddr, and check errors 
> 	if possible(This is depending on its architecture. In the case of 
> 	ia64, we can generate a MCA from an error by simple operation to 
> 	test the read data.)
> 	If any error happen on the recoverable region, set the error flag.

I really don't think we want another readX variant.  Do we then also
add readX_check_relaxed()?  Can't we just pretend the MCA is asynchronous
on ia64?  I'm sure we'd get better performance.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
