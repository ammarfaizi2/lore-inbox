Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbULWVdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbULWVdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbULWVd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:33:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:15061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261307AbULWVdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:33:21 -0500
Date: Thu, 23 Dec 2004 13:37:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: clameter@sgi.com, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
Message-Id: <20041223133745.1d95bb08.akpm@osdl.org>
In-Reply-To: <16843.13418.630413.64809@cargo.ozlabs.ibm.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	<41C20E3E.3070209@yahoo.com.au>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
	<16843.13418.630413.64809@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Christoph Lameter writes:
> 
> > The most expensive operation in the page fault handler is (apart of SMP
> > locking overhead) the zeroing of the page.
> 
> Re-reading this I see that you mean the zeroing of the page that is
> mapped into the process address space, not the page table pages.  So
> ignore my previous reply.
> 
> Do you have any statistics on how often a page fault needs to supply a
> page of zeroes versus supplying a copy of an existing page, for real
> applications?

When the workload is a gcc run, the pagefault handler dominates the system
time.  That's the page zeroing.

> In any case, unless you have magic page-zeroing hardware, I am still
> inclined to think that zeroing the page at the time of the fault is
> the most efficient, since that means the page will be hot in the cache
> for the process to use.  If you zero it earlier using CPU stores, it
> can only cause more overall memory traffic, as far as I can see.

x86's movnta instructions provide a way of initialising memory without
trashing the caches and it has pretty good bandwidth, I believe.  We should
wire that up to these patches and see if it speeds things up.

> I did some measurements once on my G5 powermac (running a ppc64 linux
> kernel) of how long clear_page takes, and it only takes 96ns for a 4kB
> page.

40GB/s.  Is that straight into L1 or does the measurement include writeback?

