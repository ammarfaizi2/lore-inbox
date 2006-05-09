Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWEIRVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWEIRVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 13:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWEIRVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 13:21:16 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:40350 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750770AbWEIRVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 13:21:15 -0400
Subject: Re: Add SYSTEM_BOOTING_KMALLOC_AVAIL system_state
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060508224952.0b43d0fd.akpm@osdl.org>
References: <20060509053512.GA20073@monkey.ibm.com>
	 <20060508224952.0b43d0fd.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 09 May 2006 10:20:04 -0700
Message-Id: <1147195205.23893.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 22:49 -0700, Andrew Morton wrote:
> Mike Kravetz <kravetz@us.ibm.com> wrote:
> >
> > There are a few places that check the system_state variable to
> >  determine if they should use the bootmem or kmalloc allocator.
> >  However, this is not accurate as system_state transitions from
> >  SYSTEM_BOOTING to SYSTEM_RUNNING well after the bootmem allocator
> >  is no longer usable.  Introduce the SYSTEM_BOOTING_KMALLOC_AVAIL
> >  state which indicates the kmalloc allocator is available for use.
> 
> Let's not do this - system_state is getting out of control.
> 
> How about some private boolean in slab.c, and some special allocation
> function like
> 
> void __init *alloc_memory_early(size_t size, gfp_t gfp_flags)
> {
> 	if (slab_is_available)
> 		return kmalloc(size, gfp_flags);
> 	return alloc_bootmem(size);
> }	

One issue with that approach is that you can't use it for larger
allocations (which we have a lot of at boot-time).  Would it be OK to
fall back to the raw page allocator for things where kmalloc() fails?
Oh, and do we want to make it explicitly NUMA aware?

-- Dave

