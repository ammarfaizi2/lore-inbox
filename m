Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSBSWGs>; Tue, 19 Feb 2002 17:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290614AbSBSWGh>; Tue, 19 Feb 2002 17:06:37 -0500
Received: from 217-126-141-228.uc.nombres.ttd.es ([217.126.141.228]:44303 "HELO
	smtp.cespedes.org") by vger.kernel.org with SMTP id <S290593AbSBSWGX>;
	Tue, 19 Feb 2002 17:06:23 -0500
Date: Tue, 19 Feb 2002 23:05:23 +0100
From: Juan Cespedes <cespedes@debian.org>
To: linux-kernel@vger.kernel.org
Subject: The ptrace() bug...
Message-ID: <20020219220523.GA10202@gizmo.thehackers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.2.0 (at least) to 2.4.14-pre7 contain this line in
mm/memory.c:copy_page_range:

    unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;

Version 2.4.14-pre8 and later changed this line with:

    unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE;

This line decides if copy-on-write should be active in a vm_area just
after a fork. The latter is more correct IMHO, with one exception:
it breaks ptraced programs, because programs been ptraced can see their
pages modified without having the VM_WRITE flag, and this causes that
both the parent and the child may see their pages changed (copy-on-write
doesn't work).

Reverting that one-line patch solves many problems for me and I think
there are no other side-effects...

Could it be included in 2.4?

Thanks,

<====================================================================>
--- old/linux-2.4.17/mm/memory.c	Fri Dec 21 18:42:05 2001
+++ linux-2.4.17/mm/memory.c	Sun Feb 17 20:38:20 2002
@@ -177,7 +177,7 @@
         pgd_t * src_pgd, * dst_pgd;
         unsigned long address = vma->vm_start;
         unsigned long end = vma->vm_end;
-        unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE;
+        unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
         src_pgd = pgd_offset(src, address)-1;
         dst_pgd = pgd_offset(dst, address)-1;
<====================================================================>

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Juan Cespedes     /       \       /       \    cespedes@TheHackers.org
.+'         `+...+'         `+...+'         `+...+'         `+...+'
