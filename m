Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265070AbTIDPlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbTIDPlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:41:15 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:19646 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S265070AbTIDPlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:41:09 -0400
Date: Thu, 4 Sep 2003 08:50:04 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>,
       hch@lst.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904155004.GA31420@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk> <16215.1054.262782.866063@nanango.paulus.ozlabs.org> <20030904023624.592f1601.davem@redhat.com> <20030904104801.A7387@flint.arm.linux.org.uk> <16215.14133.352143.660688@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16215.14133.352143.660688@nanango.paulus.ozlabs.org>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 04 2003, at 22:59, Paul Mackerras was caught saying:
> Russell King writes:
> 
> > Using the high flag bits probably isn't a good idea for two reasons:
> > 
> > 1. We already use bit 31 to indicate the busy status:
> > 
> >    #define IORESOURCE_BUSY         0x80000000      /* Driver has marked this resource busy */
> > 
> >    However, it looks like bits 27 to 17 are currently unused.
> 
> Using some flag bits would work but it seems like a bit of a kludge.
> Maybe the struct resource needs to have a pointer to the struct device
> which owns it?  Or maybe just a `sysdata' field?
> 
> > 2. The resource tree won't know about the upper bits or whatever sitting
> >    in flags, and as such identical addresses on two different buses will
> >    clash.
> > 
> > Resource start,end needs to be some unique quantity no matter which (PCI)
> > bus you are on.
> 
> They are non-overlapping for PCI buses in the same domain.  Perhaps
> the sensible thing is to have a separate resource tree for each PCI
> domain (actually two trees, for I/O and memory space), and have them
> contain bus addresses rather than physical addresses.  I don't know if
> the generic iomem_resource and ioport_resource are still useful if we
> do that.

I think we need to a have a resource tree per _bus_, not just PCI.
I have systems which have overlapping devices in multiple PCI domains
and devices on the local memory bus that also overlap. Before someone
yells at me about ioremap() only being for PCI memory resources,
it's already used throughout the kernel for locally mapped devices.

Ideally, the resource "system" as it exists would be rewritten
with something that ties into the device tree a bit by having
each resource being owned by a device.  One then calls
ioremap_resource() which on platforms that need it can look
at the resource->dev ptr to determine how to map that resource.

~Deepak

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
