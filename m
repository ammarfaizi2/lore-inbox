Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTE3QpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTE3QpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:45:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39049 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263818AbTE3QpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:45:11 -0400
Date: Thu, 29 May 2003 19:38:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: phillips@arcor.de, akpm@digeo.com, hch@infradead.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
Message-ID: <20030530023826.GA1350@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20030529151424.GA1397@us.ibm.com> <Pine.LNX.4.44.0305291723310.1800-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305291723310.1800-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 05:33:04PM +0100, Hugh Dickins wrote:
> On Thu, 29 May 2003, Paul E. McKenney wrote:
> > On Fri, May 23, 2003 at 11:42:02AM -0700, Paul E. McKenney wrote:
> > > 
> > > Exactly -- allows a ->nopage() to drop some lock to avoid races
> > > between pagefault and either vmtruncate() or invalidate_mmap_range().
> > > This race (from the cross-host mmap viewpoint) is described in:
> > > 
> > >     http://marc.theaimsgroup.com/?l=linux-kernel&m=105286345316249&w=2
> > 
> > Rediffed for 2.5.70-mm1.
> 
> Me?  I much preferred your original, much sparer, nopagedone patch
> (labelled "uglyh as hell" by hch).  I dislike passing lots of args
> down a level so they can be passed up again to the library function.
> 
> In particular, I feel queasy (fear loss of control) about passing a
> pmd_t* down to a filesystem, which I'd prefer to have no access to
> such.  But I may be in a minority, and the decision won't be mine.

Fine by me either way.  ;-)  Here is the rediffed nopagedone patch
for 2.5.70-mm1.

						Thanx, Paul


diff -urN -X dontdiff linux-2.5.70-mm1/include/linux/mm.h linux-2.5.70-mm1.nopagedone/include/linux/mm.h
--- linux-2.5.70-mm1/include/linux/mm.h	2003-05-28 20:16:04.000000000 -0700
+++ linux-2.5.70-mm1.nopagedone/include/linux/mm.h	2003-05-29 19:34:55.000000000 -0700
@@ -143,6 +143,7 @@
 	void (*open)(struct vm_area_struct * area);
 	void (*close)(struct vm_area_struct * area);
 	struct page * (*nopage)(struct vm_area_struct * area, unsigned long address, int unused);
+	void (*nopagedone)(struct vm_area_struct * area, unsigned long address, int status);
 	int (*populate)(struct vm_area_struct * area, unsigned long address, unsigned long len, pgprot_t prot, unsigned long pgoff, int nonblock);
 };
 
diff -urN -X dontdiff linux-2.5.70-mm1/mm/memory.c linux-2.5.70-mm1.nopagedone/mm/memory.c
--- linux-2.5.70-mm1/mm/memory.c	2003-05-28 20:16:04.000000000 -0700
+++ linux-2.5.70-mm1.nopagedone/mm/memory.c	2003-05-29 19:34:55.000000000 -0700
@@ -1468,6 +1468,9 @@
 	ret = VM_FAULT_OOM;
 out:
 	pte_chain_free(pte_chain);
+	if (vma->vm_ops && vma->vm_ops->nopagedone) {
+		vma->vm_ops->nopagedone(vma, address & PAGE_MASK, ret);
+	}
 	return ret;
 }
 
