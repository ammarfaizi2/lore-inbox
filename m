Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVGPCTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVGPCTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 22:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVGPCTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 22:19:04 -0400
Received: from fmr23.intel.com ([143.183.121.15]:12955 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262040AbVGPCS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 22:18:59 -0400
Date: Fri, 15 Jul 2005 19:17:44 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Justin M. Forbes" <jmforbes@linuxtx.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [11/11] x86_64: TASK_SIZE fixes for compatibility mode processes
Message-ID: <20050715191744.B18854@unix-os.sc.intel.com>
References: <20050713184130.GA9330@kroah.com> <20050713184426.GM9330@kroah.com> <20050713184946.GY23737@wotan.suse.de> <20050714094516.A1847@unix-os.sc.intel.com> <20050715155333.GA387@linuxtx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050715155333.GA387@linuxtx.org>; from jmforbes@linuxtx.org on Fri, Jul 15, 2005 at 10:53:33AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 10:53:33AM -0500, Justin M. Forbes wrote:
> That said, I will be testing this patch a bit further

Thanks. Let me know if you see any issues.

> myself, and because it does address a real memory leak issue, we should
> consider it or another fix for stable 2.6.12.4.

Appended patch will just fix the memory leak issue. Atleast, we should
apply this.

thanks,
suresh
--

malicious 32bit app can have an elf section at 0xffffe000.  During
exec of this app, we will have a memory leak as insert_vm_struct() is
not checking for return value in syscall32_setup_pages() and thus not
freeing the vma allocated for the vsyscall page.

Check the return value and free the vma incase of failure.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>


--- linux-2.6.12.2/arch/x86_64/ia32/syscall32.c.orig	2005-06-29 16:00:53.000000000 -0700
+++ linux-2.6.12.2/arch/x86_64/ia32/syscall32.c	2005-07-15 18:09:06.684409144 -0700
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

