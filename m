Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWDNBbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWDNBbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDNBbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:31:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:65169 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932476AbWDNBbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:31:35 -0400
Date: Thu, 13 Apr 2006 18:31:05 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Swapless V2: Add migration swap entries
In-Reply-To: <20060413180159.0c01beb7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604131827210.16220@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235416.15398.49978.sendpatchset@schroedinger.engr.sgi.com>
 <20060413171331.1752e21f.akpm@osdl.org> <Pine.LNX.4.64.0604131728150.15802@schroedinger.engr.sgi.com>
 <20060413174232.57d02343.akpm@osdl.org> <Pine.LNX.4.64.0604131743180.15965@schroedinger.engr.sgi.com>
 <20060413180159.0c01beb7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006, Andrew Morton wrote:

> So we falsely return VM_FAULT_MINOR and let userspace retake the pagefault,
> thus implementing a form of polling, yes?  If so, there is no "something
> else" which this process can do.

Right.

> Pages are locked during migration.  The faulting process will sleep in
> lock_page() until migration is complete.  Except we've gone and diddled
> with the swap pte so do_swap_page() can no longer locate the page which
> needs to be locked.

Oh. The page is enconded in the migration pte.
 
> Doing a busy-wait seems a bit lame.  Perhaps it would be better to go to
> sleep on some global queue, poke that queue each time a page migration
> completes?

If we rely on the migrating thread to hold the page count while the 
page is locked then we could do what the patch below does. But then we 
may race with the freeing of the old page after migration is finished.

If we would add the 
increment of the page count back then we are on the safe side but have 
the problem that we may increment the page count before the migrating
thread gets to the final check. Then the migration check would fail
and we would retry.


Index: linux-2.6.17-rc1-mm2/mm/memory.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/memory.c	2006-04-13 17:32:36.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/memory.c	2006-04-13 18:26:49.000000000 -0700
@@ -1881,11 +1881,11 @@ static int do_swap_page(struct mm_struct
 	entry = pte_to_swp_entry(orig_pte);
 
 	if (is_migration_entry(entry)) {
-		/*
-		 * We cannot access the page because of ongoing page
-		 * migration. See if we can do something else.
-		 */
-		yield();
+		page = migration_entry_to_page(entry);
+		lock_page(page);
+		entry = pte_to_swp_entry(*page_table);
+		BUG_ON(is_migration_entry(entry));
+		unlock_page(page);
 		goto out;
 	}
 
