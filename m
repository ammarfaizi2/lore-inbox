Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTIDNBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264977AbTIDNBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:01:48 -0400
Received: from ozlabs.org ([203.10.76.45]:59539 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264989AbTIDM7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:59:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.14133.352143.660688@nanango.paulus.ozlabs.org>
Date: Thu, 4 Sep 2003 22:59:33 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904104801.A7387@flint.arm.linux.org.uk>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<20030904104801.A7387@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> Using the high flag bits probably isn't a good idea for two reasons:
> 
> 1. We already use bit 31 to indicate the busy status:
> 
>    #define IORESOURCE_BUSY         0x80000000      /* Driver has marked this resource busy */
> 
>    However, it looks like bits 27 to 17 are currently unused.

Using some flag bits would work but it seems like a bit of a kludge.
Maybe the struct resource needs to have a pointer to the struct device
which owns it?  Or maybe just a `sysdata' field?

> 2. The resource tree won't know about the upper bits or whatever sitting
>    in flags, and as such identical addresses on two different buses will
>    clash.
> 
> Resource start,end needs to be some unique quantity no matter which (PCI)
> bus you are on.

They are non-overlapping for PCI buses in the same domain.  Perhaps
the sensible thing is to have a separate resource tree for each PCI
domain (actually two trees, for I/O and memory space), and have them
contain bus addresses rather than physical addresses.  I don't know if
the generic iomem_resource and ioport_resource are still useful if we
do that.

Paul.
