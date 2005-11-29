Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVK2Flx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVK2Flx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 00:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVK2Flx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 00:41:53 -0500
Received: from ozlabs.org ([203.10.76.45]:15275 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750811AbVK2Flw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 00:41:52 -0500
Date: Tue, 29 Nov 2005 16:41:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: Fix crash when ptrace poking hugepage areas
Message-ID: <20051129054136.GA16852@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	wli@holomorphy.com, linux-kernel@vger.kernel.org
References: <20051129050628.GB12498@localhost.localdomain> <20051128211807.66817481.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128211807.66817481.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 09:18:07PM -0800, Andrew Morton wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
> >
> > Bill, does this look like the correct fix for the problem to you?  If
> > so, please apply Andrew.
> > 
> > set_page_dirty() will not cope with being handed a page * which is
> > part of a compound page, but not the master page in that compound
> > page.  This case can occur via access_process_vm() if you attempt to
> > write to another process's hugepage memory area using ptrace()
> > (causing an oops or hang).
> > 
> > This patch fixes the bug by first resolving the page * to the compound
> > page's master page.
> 
> We already have to handle this situation for direct-io read()s into
> hugepages.  bio_set_pages_dirty() does
> 
> 		if (page && !PageCompound(page))
> 			set_page_dirty_lock(page);
> 
> It's such a rare case that it's probably best to continue to do this in the
> caller rather than in the callee.  That's access_process_vm().

Good call, revised patch below.

> Unless there's a reason why we actually want the compound page to be marked
> dirty?  If there is, then direct-io has a problem.  

I don't think so.  Since hugepages are never disk-backed, I think the
PageDirty flag is more or less irrelevant.

Fix crash when ptrace poking hugepage areas

set_page_dirty() will not cope with being handed a page * which is
part of a compound page, but not the master page in that compound
page.  This case can occur via access_process_vm() if you attemp to
write to another process's hugepage memory area using ptrace()
(causing an oops or hang).

This patch fixes the bug by only calling set_page_dirty() from
access_process_vm() if the page is not a compound page.  We already
use a similar fix in bio_set_pages_dirty() for the case of direct io
to hugepages.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/kernel/ptrace.c
===================================================================
--- working-2.6.orig/kernel/ptrace.c	2005-11-29 16:37:15.000000000 +1100
+++ working-2.6/kernel/ptrace.c	2005-11-29 16:37:32.000000000 +1100
@@ -241,7 +241,8 @@ int access_process_vm(struct task_struct
 		if (write) {
 			copy_to_user_page(vma, page, addr,
 					  maddr + offset, buf, bytes);
-			set_page_dirty_lock(page);
+			if (!PageCompound(page))
+				set_page_dirty_lock(page);
 		} else {
 			copy_from_user_page(vma, page, addr,
 					    buf, maddr + offset, bytes);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
