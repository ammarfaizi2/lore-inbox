Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWCPO5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWCPO5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 09:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWCPO5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 09:57:04 -0500
Received: from silver.veritas.com ([143.127.12.111]:41859 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751142AbWCPO5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 09:57:03 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,197,1139212800"; 
   d="scan'208"; a="35974194:sNHT25532564"
Date: Thu, 16 Mar 2006 14:57:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Roland Dreier <rdreier@cisco.com>, bos@pathscale.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <20060315221716.19a92762.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0603161435170.21570@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
 <ada4q27fban.fsf@cisco.com> <1141948516.10693.55.camel@serpentine.pathscale.com>
 <ada1wxbdv7a.fsf@cisco.com> <1141949262.10693.69.camel@serpentine.pathscale.com>
 <20060309163740.0b589ea4.akpm@osdl.org> <1142470579.6994.78.camel@localhost.localdomain>
 <ada3bhjuph2.fsf@cisco.com> <1142475069.6994.114.camel@localhost.localdomain>
 <adaslpjt8rg.fsf@cisco.com> <1142477579.6994.124.camel@localhost.localdomain>
 <20060315192813.71a5d31a.akpm@osdl.org> <1142485103.25297.13.camel@camp4.serpentine.com>
 <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
 <20060315221716.19a92762.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Mar 2006 14:56:58.0987 (UTC) FILETIME=[E01873B0:01C64909]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006, Andrew Morton wrote:
> Roland Dreier <rdreier@cisco.com> wrote:
> 
> > Or maybe it's just simpler to use vm_insert_page() in the .mmap method
> > and not try to be fancy with .nopage?
> 
> One would need to work out what to do with these pages when they're shared,
> after a fork - a ->nopage() handler would still be needed there, assuming
> the VMA is marked VM_DONTCOPY.  Because we don't copy all the pte's on a
> VM_DONTCOPY vma at fork()-time.  (I think we _could_, but we don't)

Misapprehension of VM_DONTCOPY addressed in another reply.

> vm_insert_page() mucks around with rmap-named functions which don't
> actually do rmap and sports apparently-incorrect comments wrt
> PageReserved().  I don't know how well-cared-for it is...

It does seem to have four users intree now, so I hope it works.

It was a byproduct of when Linus thought he could get away with
limiting remap_pfn_range, in ways that later proved unsustainable.
It's a bit surplus to requirements now, but does have those users.

I'm not keen on it, because I think most drivers actually
want something slightly different (a remap_vmalloc_pages or a
remap_highorder_page).  But that will emerge later on, in that
fabled time when I go remove the SetPageReserveds from drivers.

Yes, there are some out-of-date comments thereabouts: I did correct
them once, but in one of those patches that Linus rejected.

insert_page does a page_add_file_rmap to bump the mapcount, yes;
but whether we ever "reverse map" from page to pte depends on other
things (page->mapping and prio_tree) certainly not set here, and
probably not (indeed, hopefully not!) done by any vm_insert_page
caller.  That criticism applies to all the page_add_rmaps and
page_remove_rmaps: we carried over the name from pte_chain days,
but the only thing that gets added or removed there now is "1".

Hugh
