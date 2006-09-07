Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWIGMIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWIGMIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 08:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWIGMIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 08:08:09 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:50705 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751494AbWIGMIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 08:08:05 -0400
Date: Thu, 7 Sep 2006 13:07:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060907120756.GA29532@flint.arm.linux.org.uk>
Mail-Followup-To: Tejun Heo <htejun@gmail.com>,
	Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz,
	Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45000076.4070005@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 01:20:22PM +0200, Tejun Heo wrote:
> Matthew Wilcox wrote:
> >Just call pci_set_mwi(), that'll make sure the cache line size is set
> >correctly.
> 
> Sounds simple enough.  Just two small worries though.
> 
> * It has an apparent side effect of setting PCI_COMMAND_INVALIDATE, 
> which should be okay in sil3124's case.
> 
> * The controller might have some restrictions on configurable cache line 
> size.  This is the same for MWI, so I guess this problem is just imaginary.
> 
> For the time being, I'll go with pci_set_mwi() but IMHO it would be 
> better to have a pci helper for this purpose - 
> pci_config_cacheline_size() or something.

I've often wondered why we don't set the cache line size when we set the
bus master bit - ISTR when I read the PCI spec (2.1 or 2.2) it implied
that this should be set for bus master operations.

I've certainly seen PCI devices which can bus master and do have the
cache line size register but have the invalidate bit set forced to zero
in the command register.

Makes sense when you consider there are cache line considerations for
"memory read multiple" and "memory read line" bus commands in addition
to the "memory write and invalidate" bus command.

(Consider - if you use memory read line and haven't programmed the
cache line size, how does the master know how long a cache line is and
hence knows when to use this command?)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
