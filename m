Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbUKJW7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbUKJW7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 17:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbUKJW7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 17:59:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:6533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262058AbUKJW66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 17:58:58 -0500
Date: Wed, 10 Nov 2004 15:03:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@holomorphy.com>,
       Andi Kleen <ak@muc.de>
Subject: Re: 2.6.10-rc1-mm4
Message-Id: <20041110150307.3a06cc1d.akpm@osdl.org>
In-Reply-To: <200411102333.03412.thomas.schlichter@web.de>
References: <200411102333.03412.thomas.schlichter@web.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <thomas.schlichter@web.de> wrote:
>
> Today I tested the linux-2.6.10-rc1-mm4 kernel and it works fine with the 
> attached config. But if I enable HIGHPTE, that kernel hits following BUG 
> (written down by hand) and panics when the INIT process is started:
> 
> kernel BUG at arch/i386/mm/highmem.c:63!
> EIP is at kunmap_atomic+0x27/0x70
> Call Trace
>   show_stack+0xa6/0xb0
>   show_register+0x14d/0x1c0
>   die+0x158/0x2e0
>   do_invalid_op+0xef/0x100
>   error_code+0x2b/0x30
>   copy_pte_range+0x122/0x490

This might help:




We're modifying src_pte and dst_pte in the for-loop, and then unmapping the
modified pointers.  If one of them walked off the end of the page then blam.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/memory.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -puN mm/memory.c~4level-highpte-fix mm/memory.c
--- 25/mm/memory.c~4level-highpte-fix	Wed Nov 10 14:58:55 2004
+++ 25-akpm/mm/memory.c	Wed Nov 10 15:00:58 2004
@@ -332,7 +332,8 @@ static int copy_pte_range(struct mm_stru
 				struct vm_area_struct *vma,
 			   	unsigned long addr, unsigned long end)
 {
-	pte_t * src_pte, * dst_pte;
+	pte_t *src_pte, *dst_pte;
+	pte_t *s, *d;
 	unsigned long vm_flags = vma->vm_flags;
 
 	dst_pte = pte_alloc_map(dst_mm, dst_pmd, addr);
@@ -341,12 +342,12 @@ static int copy_pte_range(struct mm_stru
 
 	spin_lock(&src_mm->page_table_lock);
 	src_pte = pte_offset_map_nested(src_pmd, addr);
-	for (;
-	     addr < end;
-	     addr += PAGE_SIZE, src_pte++, dst_pte++) {
-		if (pte_none(*src_pte))
+	d = dst_pte;
+	s = src_pte;
+	for ( ; addr < end; addr += PAGE_SIZE, s++, d++) {
+		if (pte_none(*s))
 			continue;
-		copy_one_pte(dst_mm, src_mm, dst_pte, src_pte, vm_flags, addr);
+		copy_one_pte(dst_mm, src_mm, d, s, vm_flags, addr);
 	}
 	pte_unmap_nested(src_pte);
 	pte_unmap(dst_pte);
_

