Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbUKLD1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUKLD1g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 22:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUKLD1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 22:27:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:15501 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262433AbUKLD12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 22:27:28 -0500
Date: Thu, 11 Nov 2004 19:27:27 -0800
From: Chris Wright <chrisw@osdl.org>
To: Florian Heinz <heinz@cronon-ag.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a.out issue
Message-ID: <20041111192727.R14339@build.pdx.osdl.net>
References: <20041111220906.GA1670@dereference.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041111220906.GA1670@dereference.de>; from heinz@cronon-ag.de on Thu, Nov 11, 2004 at 11:09:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Heinz (heinz@cronon-ag.de) wrote:
> seems like find_vma_prepare does not what insert_vm_struct expects when
> the whole addresspace is occupied.

The setup_arg_pages() is inserting an overlapping region.  If nothing
else, this will fix that problem.   Perhaps there's a better solution.

thanks,
-chris

===== fs/exec.c 1.143 vs edited =====
--- 1.143/fs/exec.c	2004-10-28 00:40:03 -07:00
+++ edited/fs/exec.c	2004-11-11 19:24:54 -08:00
@@ -413,6 +413,7 @@
 
 	down_write(&mm->mmap_sem);
 	{
+		struct vm_area_struct *vma;
 		mpnt->vm_mm = mm;
 #ifdef CONFIG_STACK_GROWSUP
 		mpnt->vm_start = stack_base;
@@ -433,6 +434,12 @@
 			mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_flags |= mm->def_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
+		vma = find_vma(mm, mpnt->vm_start);
+		if (vma) {
+			up_write(&mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return -ENOMEM;
+		}
 		insert_vm_struct(mm, mpnt);
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	}
