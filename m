Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbUDAQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUDAQtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:49:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31002 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262829AbUDAQtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:49:16 -0500
Date: Thu, 1 Apr 2004 17:49:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Zoltan.Menyhart@bull.net
cc: linux-kernel@vger.kernel.org
Subject: Re: To kunmap_atomic or not to kunmap_atomic ?
In-Reply-To: <406C43A4.E29F92FB@nospam.org>
Message-ID: <Pine.LNX.4.44.0404011740190.30126-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004, Zoltan Menyhart wrote:
> I can see a couple of functions, like
> 
> static inline struct mm_struct * ptep_to_mm(pte_t * ptep)
> {
> 	struct page * page = kmap_atomic_to_page(ptep);
> 	return (struct mm_struct *) page->mapping;
> }
> 
> in "rmap.?" without invoking "kunmap_atomic()".
> Is it intentional?
> What if for an architecture "kunmap_atomic()" is not a no-op ?

Amusing misunderstanding.  Take a look at kmap_atomic_to_page
in arch/i386/mm/highmem.c: it doesn't _do_ a kmap_atomic, it
translates the virtual address already supplied by kmap_atomic
to the address of the struct page of the physical page backing
that virtual address.  So, in the case of try_to_unmap_one, it
operates on the virtual address supplied by rmap_ptep_map
(which does do a kmap_atomic), and at the end there's an
rmap_ptep_unmap (which does the rmap_ptep_unmap).

Hugh

