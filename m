Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267828AbUG3UWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUG3UWU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267819AbUG3UWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:22:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:28089 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267828AbUG3UVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:21:51 -0400
Date: Fri, 30 Jul 2004 13:20:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive
 kernels
Message-Id: <20040730132016.5906caa7.akpm@osdl.org>
In-Reply-To: <1091218419.1968.46.camel@mulgrave>
References: <20040730190227.29913e23.ak@suse.de>
	<20040730130238.0f68f5e7.akpm@osdl.org>
	<1091218419.1968.46.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>
> On Fri, 2004-07-30 at 16:02, Andrew Morton wrote:
> > We're paying for past sins here.  I think it would be better to create a
> > new version of pci_alloc_consistent() which takes gfp_flags, then migrate
> > the drivers you care about to use it.  That way the benefit is available on
> > non-preempt kernels too.
> > 
> > The ultimate aim of course would be to deprecate then remove the old
> > function.
> 
> True, that's why it was added for dma_alloc_coherent().
> 
> Is there any need for a new wrapper?  Why not just use
> dma_alloc_coherent() from now on?
> 

Sounds sane.  But the default version in asm-generic/dma-mapping.h needs to
be fixed up:

static inline void *
dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
		   int flag)
{
	BUG_ON(dev->bus != &pci_bus_type);

	return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
}

If we stick with this model, we'll still need a new pci_alloc_consistent_gfp().
