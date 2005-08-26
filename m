Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVHZBur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVHZBur (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVHZBur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:50:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965045AbVHZBuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:50:46 -0400
Date: Thu, 25 Aug 2005 21:50:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Ray Fucillo <fucillo@intersystems.com>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Douglas Shakshober <dshaks@redhat.com>
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <430E6FD4.9060102@yahoo.com.au>
Message-ID: <Pine.LNX.4.63.0508252147040.9987@cuia.boston.redhat.com>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Nick Piggin wrote:

> > Skipping MAP_SHARED in fork() sounds like a good idea to me...
> 
> Indeed. Linus, can you remember why we haven't done this before?

Where "this" looks something like the patch below, shamelessly
merging Nick's and Andy's patches and adding the initialization
of retval.

I suspect this may be a measurable win on database servers with
a web frontend, where the connections to the database server are
set up basically for each individual query, and don't stick around
for a long time.

No, I haven't actually tested this patch - but feel free to go
wild while I sign off for the night.

Signed-off-by: Rik van Riel <riel@redhat.com>

--- linux-2.6.12/kernel/fork.c.mapshared	2005-08-25 18:40:44.000000000 -0400
+++ linux-2.6.12/kernel/fork.c	2005-08-25 18:47:16.000000000 -0400
@@ -184,7 +184,7 @@
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	struct rb_node **rb_link, *rb_parent;
-	int retval;
+	int retval = 0;
 	unsigned long charge;
 	struct mempolicy *pol;
 
@@ -265,7 +265,10 @@
 		rb_parent = &tmp->vm_rb;
 
 		mm->map_count++;
-		retval = copy_page_range(mm, current->mm, tmp);
+		/* Skip pte copying if page faults can take care of things. */
+		if (!file || !(tmp->vm_flags & VM_SHARED) ||
+						is_vm_hugetlb_page(vma))
+			retval = copy_page_range(mm, current->mm, tmp);
 		spin_unlock(&mm->page_table_lock);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
