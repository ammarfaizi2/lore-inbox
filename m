Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbUAXEYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 23:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266861AbUAXEYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 23:24:45 -0500
Received: from dp.samba.org ([66.70.73.150]:59338 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263002AbUAXEYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 23:24:42 -0500
Date: Sat, 24 Jan 2004 15:22:25 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Audit 2.6 set_pte users
Message-ID: <20040124042225.GO11236@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I went through all the users of set_pte to check if they flush the
current pte if it is present. Below is a summary of the audit,
everything looks good except for a failure case in
dup_mmap->copy_page_range.

The set_pte usage in copy_page_range is fine (no present ptes in the
childs address space yet) however ptep_set_wrprotect is also called to
write protect COW mappings in the parent. It turns out we can fail part
way through copy_page_range and end up not calling flush_tlb_mm. Sure
there will be no child process so the COW mappings arent needed, but
having the linux view and the hw view of the pte get out of sync is not
good.

Anton

--

dup_mmap has problem where we fail calling copy_page (which potentially
write protects pages in the parent) and do not call flush_tlb_mm.

===== kernel/fork.c 1.154 vs edited =====
--- 1.154/kernel/fork.c	Tue Jan 20 10:38:15 2004
+++ edited/kernel/fork.c	Sat Jan 24 14:17:00 2004
@@ -347,6 +347,7 @@
 fail_nomem:
 	retval = -ENOMEM;
 fail:
+	flush_tlb_mm(current->mm);
 	vm_unacct_memory(charge);
 	goto out;
 }

--

fs/exec.c:
put_dirty_page
	safe - no existing pte

mm/fremap.c:
install_page
	safe - calls ptep_clear_flush
install_file_pte
	safe - calls ptep_clear_flush

mm/highmem.c:
map_new_virtual
	safe - no existing pte

mm/memory.c:
copy_page_range
	safe - no existing pte
zeromap_pte_range
	safe - calls flush_tlb_range
remap_pte_range
	safe - calls flush_tlb_range
do_swap_page
	safe - no existing pte
do_anonymous_page
	safe - no existing pte
do_no_page
	safe - no existing pte

mm/mprotect.c
change_pte_range
	safe - calls flush_tlb_range

mm/mremap.c
copy_one-pte
	safe - calls ptep_clear_flush

mm/rmap.c
try_to_unmap_one
	safe - calls ptep_clear_flush

mm/swapfile.c:
unuse_pte
	safe - no existing pte

mm/vmalloc.c:
map_area_pte
	safe - no existing pte
