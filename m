Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUHPR3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUHPR3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267823AbUHPR3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:29:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57792 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267815AbUHPR27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:28:59 -0400
Date: Mon, 16 Aug 2004 10:28:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
 pte locks?
In-Reply-To: <1092609485.9538.27.camel@gaston>
Message-ID: <Pine.LNX.4.58.0408161025420.9812@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com>
 <1092609485.9538.27.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Benjamin Herrenschmidt wrote:

> On Sun, 2004-08-15 at 23:50, Christoph Lameter wrote:
> > Well this is more an idea than a real patch yet. The page_table_lock
> > becomes a bottleneck if more than 4 CPUs are rapidly allocating and using
> > memory. "pft" is a program that measures the performance of page faults on
> > SMP system. It allocates memory simultaneously in multiple threads thereby
> > causing lots of page faults for anonymous pages.
>
> Just a note: on ppc64, we already have a PTE lock bit, we use it to
> guard against concurrent hash table insertion, it could be extended
> to the whole page fault path provided we can guarantee we will never
> fault in the hash table on that PTE while it is held. This shouldn't
> be a problem as long as only user pages are locked that way (which
> should be the case with do_page_fault) provided update_mmu_cache()
> is updated to not take this lock, but assume it already held.

Is this the _PAGE_BUSY bit? The pte update routines on PPC64 seem to spin
on that bit when it is set waiting for the hash value update to complete.
Looks very specific to the PPC64 architecture.
