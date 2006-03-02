Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWCBPvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWCBPvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWCBPvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:51:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25100 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751565AbWCBPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:51:11 -0500
Date: Thu, 2 Mar 2006 15:50:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060302155056.GB28895@flint.arm.linux.org.uk>
Mail-Followup-To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <44070B62.3070608@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44070B62.3070608@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 12:12:34AM +0900, Kenji Kaneshige wrote:
> Hi Andrew, Greg,
> 
> Here is an updated set of patches for PCI legacy I/O port free
> driver. It incorporates all of the feedbacks. I rebased it against the
> latest -mm kernel (2.6.16-rc5-mm1).
> 
> Could you consider applying this to -mm tree?

I've been wondering whether this "no_ioport" flag is the correct approach,
or whether it's adding to complexity when it isn't really required.

In the non-Intel world, the kernel itself sets up the PCI bus mappings,
and any IO bars which it can't satisfy might also need to be gracefully
handled.  Currently, we just go 'printk("whoops, didn't allocate
resource")' and leave the BAR containing whatever random junk it
contained before, along with the resource containing whatever random
junk pci_bus_alloc_resource() decided to leave in it.

In such cases, I would suggest that the method of signalling that IO
should not be used is to have the IO resource structures cleared out -
if the IO resources aren't valid, they should not contain something
which could be interpreted as valid.

Maybe something like this should be done for the "legacy IO port" case
as well?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
