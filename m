Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUDBPK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264069AbUDBPK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:10:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43783 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261850AbUDBPKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:10:25 -0500
Date: Fri, 2 Apr 2004 16:10:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Zoltan.Menyhart@bull.net
cc: linux-kernel@vger.kernel.org
Subject: Re: To kunmap_atomic or not to kunmap_atomic ?
In-Reply-To: <406D7573.FF5F0B5F@nospam.org>
Message-ID: <Pine.LNX.4.44.0404021559480.6018-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2004, Zoltan Menyhart wrote:
> > 
> > Amusing misunderstanding.  Take a look at kmap_atomic_to_page
> > in arch/i386/mm/highmem.c: it doesn't _do_ a kmap_atomic, it
> > translates the virtual address already supplied by kmap_atomic
> > to the address of the struct page of the physical page backing
> > that virtual address.  So, in the case of try_to_unmap_one, it
> > operates on the virtual address supplied by rmap_ptep_map
> > (which does do a kmap_atomic), and at the end there's an
> > rmap_ptep_unmap (which does the rmap_ptep_unmap).
>...
> 
> I think we cannot guarantee that we will never ever need to
> unmap things. As it is required to use kmap - kunmap in pair,
> it is quite logic to use kmap_atomic* in pair with kunmap_atomic.

Agreed.

> I think it is a bad programming style to abuse the fact that
> some macros are no-ops for the most popular architectures.

Agreed.

> I think we should have some global counters in DEBUG mode which
> are incremented on each call to *map* and decremented on each
> *unpap* call, and we can detect, ooops, it leaks...

If you choose CONFIG_DEBUG_HIGHMEM, kmap_atomic does check that
kunmap_atomic was done last time, no need for additional counter.

Sorry, I've not made it clear.

kmap_atomic_to_page does not map anything, and doesn't need a
corresponding unmap operation.  It expects that you already did
a kmap_atomic (and that you will later do a kunmap_atomic), and
translates from the address returned by kmap_atomic to the address
of the relevant struct page.  You can certainly argue that it's
misleadingly named, but no better name springs to my mind.

Hugh

