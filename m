Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030668AbWJJXDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030668AbWJJXDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030683AbWJJXDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:03:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:51840 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030668AbWJJXDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:03:46 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="144385617:sNHT25502687"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>
Cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Hugepage regression
Date: Tue, 10 Oct 2006 16:03:44 -0700
Message-ID: <000201c6ecc0$565cdc00$cb34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcbsqCF6J8YHsfnuT8+ngpMcmOsbQAAFsDww
In-Reply-To: <Pine.LNX.4.64.0610102045190.24759@blonde.wat.veritas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote on Tuesday, October 10, 2006 1:10 PM
> > can we reverse that order (call unmap_region
> > and then nulls out vma->vmfile and fput)?
> 
> I'm pretty sure we cannot: the ordering is quite intentional, that if
> a driver ->mmap failed, then it'd be wrong to call down to driver in
> the unmap_region (if a driver is nicely behaved, that unmap_region
> shouldn't be unnecessary; but some do rely on us clearing ptes there).


Even not something like the following?  I believe you that nullifying
vma->vm_file can not be done after unmap_region(), I just want to make
sure we are talking the same thing. It looks OK to me to defer the fput
in the do_mmap_pgoff clean up path.


--- ./mm/mmap.c.orig	2006-10-10 15:58:17.000000000 -0700
+++ ./mm/mmap.c	2006-10-10 15:59:02.000000000 -0700
@@ -1159,11 +1159,12 @@ out:	
 unmap_and_free_vma:
 	if (correct_wcount)
 		atomic_inc(&inode->i_writecount);
-	vma->vm_file = NULL;
-	fput(file);
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+
+	vma->vm_file = NULL;
+	fput(file);
 	charged = 0;
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
