Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbRCWKdA>; Fri, 23 Mar 2001 05:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130493AbRCWKcl>; Fri, 23 Mar 2001 05:32:41 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:18596 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130470AbRCWKca>; Fri, 23 Mar 2001 05:32:30 -0500
Date: Fri, 23 Mar 2001 02:31:49 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Patch(?): linux-2.4.3-pre6/mm/vmalloc.c could return with init_mm.page_table_lock held
Message-ID: <20010323023149.A250@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	[Sorry for posting three messages to linux-kernel about this.
Each time I was pretty sure I was done for the night.  Anyhow, I
hope this proposed patch makes up for it.]

	In linux-2.4.3-pre6, a call to vmalloc can result in a call to
pte_alloc without the appropriate page_table_lock being held.  Here is
the call graph, from my post of about half an hour ago:

        vmalloc
        __vmalloc
        vmalloc_area_pages
        alloc_area_pmd
        pte_alloc ...which assumes (here incorrectly) that
                mm->page_table_lock is held, and sometimes releases
                and reacquires mm->page_table_lock.

	Not only does pte_alloc expect mm->page_table_lock 
to be held when it is called, but it also sometimes releases and
reacquires it.  vmalloc did not release this lock either, of course.
So, the next attempt to acquire the same mm->page_table_lock spin lock
hangs.

	The symptom that I had noticed was the agpgart.o module hanging
at module initialization, but it is a much more general problem, and
could explain all sorts of hangs in 2.4.3-pre6.

	Anyhow, with this patch, agpgart.o loads just fine and the
kernel seems to have suffered no negative side effects.  I am
not confident in exactly where I chose to put the spin_lock and
spin_unlock calls, so I would recommend a careful examination of
this patch before integrating.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmalloc.patch"

--- linux-2.4.3-pre6/mm/vmalloc.c	Fri Mar 23 02:16:41 2001
+++ linux/mm/vmalloc.c	Fri Mar 23 02:09:58 2001
@@ -136,39 +136,41 @@
 
 inline int vmalloc_area_pages (unsigned long address, unsigned long size,
                                int gfp_mask, pgprot_t prot)
 {
 	pgd_t * dir;
 	unsigned long end = address + size;
 	int ret;
 
 	dir = pgd_offset_k(address);
 	flush_cache_all();
+	spin_lock(&init_mm.page_table_lock);
 	lock_kernel();
 	do {
 		pmd_t *pmd;
 		
 		pmd = pmd_alloc(&init_mm, dir, address);
 		ret = -ENOMEM;
 		if (!pmd)
 			break;
 
 		ret = -ENOMEM;
 		if (alloc_area_pmd(pmd, address, end - address, gfp_mask, prot))
 			break;
 
 		address = (address + PGDIR_SIZE) & PGDIR_MASK;
 		dir++;
 
 		ret = 0;
 	} while (address && (address < end));
 	unlock_kernel();
+	spin_unlock(&init_mm.page_table_lock);
 	flush_tlb_all();
 	return ret;
 }
 
 struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
 {
 	unsigned long addr;
 	struct vm_struct **p, *tmp, *area;
 
 	area = (struct vm_struct *) kmalloc(sizeof(*area), GFP_KERNEL);

--jI8keyz6grp/JLjh--
