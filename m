Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbULWVLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbULWVLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbULWVLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:11:17 -0500
Received: from ozlabs.org ([203.10.76.45]:31721 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261289AbULWVLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:11:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16843.13418.630413.64809@cargo.ozlabs.ibm.com>
Date: Fri, 24 Dec 2004 08:11:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: unlisted-recipients:;;;akpm@osdl.org; (no To-header on input),
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)akpm@osdl.org
								     ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)akpm@osdl.org
								     ^-missing end of address
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
In-Reply-To: <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	<41C20E3E.3070209@yahoo.com.au>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:

> The most expensive operation in the page fault handler is (apart of SMP
> locking overhead) the zeroing of the page.

Re-reading this I see that you mean the zeroing of the page that is
mapped into the process address space, not the page table pages.  So
ignore my previous reply.

Do you have any statistics on how often a page fault needs to supply a
page of zeroes versus supplying a copy of an existing page, for real
applications?

In any case, unless you have magic page-zeroing hardware, I am still
inclined to think that zeroing the page at the time of the fault is
the most efficient, since that means the page will be hot in the cache
for the process to use.  If you zero it earlier using CPU stores, it
can only cause more overall memory traffic, as far as I can see.

I did some measurements once on my G5 powermac (running a ppc64 linux
kernel) of how long clear_page takes, and it only takes 96ns for a 4kB
page.  This is real-life elapsed time in the kernel, not just some
cache-hot benchmark measurement.  Thus I don't think your patch will
gain us anything on ppc64.

Paul.
