Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbTDNSZY (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTDNSZL (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:25:11 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:4081 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263626AbTDNSY3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 14:24:29 -0400
Date: Mon, 14 Apr 2003 20:47:15 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       nicoya@apia.dhs.org
Subject: Re: cow-ahead N pages for fault clustering
Message-ID: <20030414184715.GI14552@wind.cocodriloo.com>
References: <10760000.1050332136@[10.10.2.4]> <20030414152947.GB14552@wind.cocodriloo.com> <12790000.1050334744@[10.10.2.4]> <20030414155748.GD14552@wind.cocodriloo.com> <14860000.1050337484@[10.10.2.4]> <20030414164321.GE14552@wind.cocodriloo.com> <15700000.1050338226@[10.10.2.4]> <20030414171419.GG14552@wind.cocodriloo.com> <16700000.1050340965@[10.10.2.4]> <20030414183251.GH14552@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20030414183251.GH14552@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 14, 2003 at 08:32:51PM +0200, Antonio Vargas wrote:
> On Mon, Apr 14, 2003 at 10:22:46AM -0700, Martin J. Bligh wrote:
> > >> Ah, you probably don't want to do that ... it's very expensive. Moreover,
> > >> if you exec 2ns later, all the effort will be wasted ... and it's very
> > >> hard to deterministically predict whether you'll exec or not (stupid
> > >> UNIX  semantics). Doing it lazily is probably best, and as to "nodes
> > >> would not  have to reference the memory from others" - you're still
> > >> doing that, you're just batching it on the front end.
> > > 
> > > True... What about a vma-level COW-ahead just like we have a file-level
> > > read-ahead, then? I mean batching the COW at unCOW-because-of-write time.
> > 
> > That'd be interesting ... and you can test that on a UP box, is not just
> > NUMA. Depends on the workload quite heavily, I suspect.
> >  
> > > btw, COW-ahead sound really silly :)
> > 
> > Yeah. So be sure to call it that if it works out ... we need more things
> > like that ;-) Moooooo.
> 
> What about the attached one? I'm compiling it right now to test in UML :)
> 
> [ snip fake-NUMA-on-SMP discussion ]
> 

OK, too quick for me... this next one applies, compiles and boots on 2.5.66 + uml.
Now I wonder how can I test if this is useful... ideas?

Greets, Antonio.

--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cow-ahead.patch"

 mm/memory.c |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff -puN mm/memory.c~cow-ahead mm/memory.c
--- 25/mm/memory.c~cow-ahead	Mon Apr 14 20:08:44 2003
+++ 25-wind/mm/memory.c	Mon Apr 14 20:37:42 2003
@@ -1452,7 +1452,7 @@ static int do_file_page(struct mm_struct
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 	struct vm_area_struct * vma, unsigned long address,
-	int write_access, pte_t *pte, pmd_t *pmd)
+	int write_access, pte_t *pte, pmd_t *pmd, int *cowahead)
 {
 	pte_t entry;
 
@@ -1471,8 +1471,11 @@ static inline int handle_pte_fault(struc
 	}
 
 	if (write_access) {
-		if (!pte_write(entry))
+		if (!pte_write(entry)) {
+			if(!*cowahead)
+				*cowahead = 1;
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
+		}
 
 		entry = pte_mkdirty(entry);
 	}
@@ -1492,6 +1495,17 @@ int handle_mm_fault(struct mm_struct *mm
 	pgd_t *pgd;
 	pmd_t *pmd;
 
+	int cowahead, i;
+	int retval, x;
+
+	/*
+	 * Implement cow-ahead: copy-on-write several
+	 * pages when we fault one of them
+	 */
+
+	i = cowahead = 0;
+
+do_cowahead:
 	__set_current_state(TASK_RUNNING);
 	pgd = pgd_offset(mm, address);
 
@@ -1507,10 +1521,20 @@ int handle_mm_fault(struct mm_struct *mm
 	spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, address);
 
-	if (pmd) {
+	while (pmd) {
 		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
-			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+		if (!pte) break;
+
+		x = handle_pte_fault(mm, vma, address, write_access, pte, pmd, &cowahead);
+		if(!i) retval = x;
+
+		i++;
+		address += PAGE_SIZE;
+
+		if(!cowahead || i >= 0 || address >= vma->vm_end)
+			return retval;
+
+		goto do_cowahead;
 	}
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;

_

--O3RTKUHj+75w1tg5--
