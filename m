Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVHCGxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVHCGxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVHCGxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:53:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47579 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262121AbVHCGwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:52:43 -0400
Date: Tue, 2 Aug 2005 23:52:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org,
       "alan@lxorguk.ukuu.org.uk Siddha, Suresh B" 
	<suresh.b.siddha@intel.com>,
       Andi Kleen <ak@suse.de>
Subject: [04/13] x86_64 memleak from malicious 32bit elf program
Message-ID: <20050803065220.GS7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

malicious 32bit app can have an elf section at 0xffffe000.  During
exec of this app, we will have a memory leak as insert_vm_struct() is
not checking for return value in syscall32_setup_pages() and thus not
freeing the vma allocated for the vsyscall page.

Check the return value and free the vma incase of failure.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/x86_64/ia32/syscall32.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.12.3.orig/arch/x86_64/ia32/syscall32.c	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/arch/x86_64/ia32/syscall32.c	2005-07-28 11:17:11.000000000 -0700
@@ -57,6 +57,7 @@
 	int npages = (VSYSCALL32_END - VSYSCALL32_BASE) >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
+	int ret;
 
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!vma)
@@ -78,7 +79,11 @@
 	vma->vm_mm = mm;
 
 	down_write(&mm->mmap_sem);
-	insert_vm_struct(mm, vma);
+	if ((ret = insert_vm_struct(mm, vma))) {
+		up_write(&mm->mmap_sem);
+		kmem_cache_free(vm_area_cachep, vma);
+		return ret;
+	}
 	mm->total_vm += npages;
 	up_write(&mm->mmap_sem);
 	return 0;
