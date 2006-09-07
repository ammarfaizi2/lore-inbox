Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWIGNKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWIGNKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWIGNKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:10:52 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:16658 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751787AbWIGNKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:10:51 -0400
Date: Thu, 7 Sep 2006 14:10:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060907131034.GC29532@flint.arm.linux.org.uk>
Mail-Followup-To: Tejun Heo <htejun@gmail.com>,
	Matthew Wilcox <matthew@wil.cx>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45001665.9050509@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 02:53:57PM +0200, Tejun Heo wrote:
> Matthew Wilcox wrote:
> >On Thu, Sep 07, 2006 at 02:33:25PM +0200, Arjan van de Ven wrote:
> >>>So I think we should redo the PCI subsystem to set cacheline size during
> >>>the buswalk rather than waiting for drivers to ask for it to be set.
> >>... while allowing for quirks for devices that go puke when this
> >>register gets written ;)
> >>
> >>(afaik there are a few)
> >
> >So you want:
> >
> >	unsigned int no_cls:1;	/* Device pukes on write to Cacheline Size */
> >
> >in struct pci_dev?
> 
> The spec says that devices can put additional restriction on supported 
> cacheline size (IIRC, the example was something like power of two >= or 
> <= certain size) and should ignore (treat as zero) if unsupported value 
> is written.  So, there might be need for more low level driver 
> involvement which knows device restrictions, but I don't know whether 
> such devices exist.

The problem is that both ends of the bus need to know the cache line
size for some of these commands to work correctly.

Consider, as in Matthew's case, a read command which wraps at the cache
line boundary.  Unless both the master and slave are programmed with the
same cache line size, it's entirely possible for the wrong memory
locations to be read.

Eg, the device might expect 0x118, 0x11c, 0x100, 0x104, but it actually
gets 0x118, 0x11c, 0x120, 0x124 because the target got programmed with
64 while the master was set to 32.

This is, of course, supposing that the memory read command is used in
the cache line wrap mode.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
