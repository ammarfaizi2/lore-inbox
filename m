Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTEMXbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTEMXbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:31:37 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:37588 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262166AbTEMXbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:31:34 -0400
Date: Tue, 13 May 2003 15:43:24 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mjbligh@us.ibm.com
Subject: Re: [RFC][PATCH] Interface to invalidate regions of mmaps
Message-ID: <20030513154324.F2929@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030513133636.C2929@us.ibm.com> <20030513152141.5ab69f07.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513152141.5ab69f07.akpm@digeo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 03:21:41PM -0700, Andrew Morton wrote:
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> >
> > This patch adds an API to allow networked and distributed filesystems
> > to invalidate portions of (or all of) a file.  This is needed to 
> > provide POSIX or near-POSIX semantics in such filesystems, as
> > discussed on LKML late last year:
> > 
> > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=103609089604576&w=2
> > 	http://marc.theaimsgroup.com/?l=linux-kernel&m=103167761917669&w=2
> > 
> > Thoughts?
> 
> What filesystems would be needing this, and when could we see live code
> which actually uses it?

Working on getting it out...  But I suspect that others need
this functionality as well, given the threads noted above.

> > +/*
> > + * Helper function for invalidate_mmap_range().
> > + * Both hba and hlen are page numbers in PAGE_SIZE units.
> > + */
> > +static void 
> > +invalidate_mmap_range_list(struct list_head *head,
> > +			   unsigned long const hba,
> > +			   unsigned long const hlen)
> 
> Be nice to consolidate this with vmtruncate_list, so that it gets
> exercised.

Good point from both you and wli -- here is the updated vmtruncate
patch (now depends on the invalidate_mmap_range patch).

						Thanx, Paul

diff -urN -X dontdiff linux-2.5.69.invalidate_mmap_range/mm/memory.c linux-2.5.69.vmtruncate/mm/memory.c
--- linux-2.5.69.invalidate_mmap_range/mm/memory.c	Tue May 13 14:56:41 2003
+++ linux-2.5.69.vmtruncate/mm/memory.c	Tue May 13 15:19:23 2003
@@ -1063,6 +1063,7 @@
 /*
  * Helper function for invalidate_mmap_range().
  * Both hba and hlen are page numbers in PAGE_SIZE units.
+ * An hlen of zero blows away the entire portion file after hba.
  */
 static void 
 invalidate_mmap_range_list(struct list_head *head,
@@ -1078,6 +1079,8 @@
 	unsigned long zea;
 
 	hea = hba + hlen - 1;	/* avoid overflow. */
+	if (hea < hba)
+		hea = ULONG_MAX;
 	list_for_each(curr, head) {
 		vp = list_entry(curr, struct vm_area_struct, shared);
 		vba = vp->vm_pgoff;
@@ -1128,37 +1131,6 @@
 	up(&mapping->i_shared_sem);
 }       
 
-static void vmtruncate_list(struct list_head *head, unsigned long pgoff)
-{
-	unsigned long start, end, len, diff;
-	struct vm_area_struct *vma;
-	struct list_head *curr;
-
-	list_for_each(curr, head) {
-		vma = list_entry(curr, struct vm_area_struct, shared);
-		start = vma->vm_start;
-		end = vma->vm_end;
-		len = end - start;
-
-		/* mapping wholly truncated? */
-		if (vma->vm_pgoff >= pgoff) {
-			zap_page_range(vma, start, len);
-			continue;
-		}
-
-		/* mapping wholly unaffected? */
-		len = len >> PAGE_SHIFT;
-		diff = pgoff - vma->vm_pgoff;
-		if (diff >= len)
-			continue;
-
-		/* Ok, partially affected.. */
-		start += diff << PAGE_SHIFT;
-		len = (len - diff) << PAGE_SHIFT;
-		zap_page_range(vma, start, len);
-	}
-}
-
 /*
  * Handle all mappings that got truncated by a "truncate()"
  * system call.
@@ -1176,17 +1148,12 @@
 	if (inode->i_size < offset)
 		goto do_expand;
 	inode->i_size = offset;
+	pgoff = (offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	down(&mapping->i_shared_sem);
-	if (list_empty(&mapping->i_mmap) && list_empty(&mapping->i_mmap_shared))
-		goto out_unlock;
-
-	pgoff = (offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (!list_empty(&mapping->i_mmap))
-		vmtruncate_list(&mapping->i_mmap, pgoff);
-	if (!list_empty(&mapping->i_mmap_shared))
-		vmtruncate_list(&mapping->i_mmap_shared, pgoff);
-
-out_unlock:
+	if (unlikely(!list_empty(&mapping->i_mmap)))
+		invalidate_mmap_range_list(&mapping->i_mmap, pgoff, 0);
+	if (unlikely(!list_empty(&mapping->i_mmap_shared)))
+		invalidate_mmap_range_list(&mapping->i_mmap_shared, pgoff, 0);
 	up(&mapping->i_shared_sem);
 	truncate_inode_pages(mapping, offset);
 	goto out_truncate;
