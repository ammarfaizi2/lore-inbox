Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUFXSy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUFXSy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbUFXSyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:54:23 -0400
Received: from colin2.muc.de ([193.149.48.15]:59918 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264791AbUFXSv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:51:57 -0400
Date: 24 Jun 2004 20:51:56 +0200
Date: Thu, 24 Jun 2004 20:51:56 +0200
From: Andi Kleen <ak@muc.de>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Andi Kleen <ak@muc.de>, discuss@x86-64.org, tiwai@suse.de,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624185156.GA19559@colin2.muc.de>
References: <20040623234644.GC38425@colin2.muc.de> <20040624154429.GC8014@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624154429.GC8014@hygelac>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 10:44:29AM -0500, Terence Ripperda wrote:
> On Wed, Jun 23, 2004 at 04:46:44PM -0700, ak@muc.de wrote:
> > pci_alloc_consistent is limited to 16MB, but so far nobody has really
> > complained about that. If that should be a real issue we can make
> > it allocate from the swiotlb pool, which is usually 64MB (and can
> > be made bigger at boot time) 
> 
> In all of the cases I've seen, it defaults to 4M. in swiotlb.c,
> io_tlb_nslabs defaults to 1024, * PAGE_SIZE == 4194304.

I checked this now. 

It's 

#define IO_TLB_SHIFT 11

static unsigned long io_tlb_nslabs = 1024;

and the allocation does

	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs * (1 << IO_TLB_SHIFT));

which contrary to its name does not allocate in pages (otherwise you would
get 8GB of memory on x86-64 and even more on IA64) 
That's definitely far too small. 

A better IO_TLB_SHIFT would be 16 or 17.

-Andi
