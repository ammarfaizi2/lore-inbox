Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <155972-17700>; Sun, 30 Aug 1998 14:52:30 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:2577 "HELO castle.nmd.msu.ru" ident: "TIMEDOUT") by vger.rutgers.edu with SMTP id <156669-15447>; Sun, 30 Aug 1998 12:24:06 -0400
Message-ID: <19980830151441.A2616@castle.nmd.msu.ru>
Date: Sun, 30 Aug 1998 15:14:41 +0400
From: Savochkin Andrey Vladimirovich <saw@msu.ru>
To: rdm@bamboo.verinet.com, linux-kernel@vger.rutgers.edu
Cc: "David S. Miller" <davem@dm.cobaltmicro.com>, sct@redhat.com, torvalds@transmeta.com, mingo@valerie.inf.elte.hu, number6@the-village.bc.nu, haible@ma2s2.mathematik.uni-karlsruhe.de
Subject: Re: Fuzzy hash stuff.. (was Re: 2.1.xxx makes Electric Fence 22x slower)
References: <199808202227.QAA32085@bamboo.verinet.com> <199808241008.LAA18963@dax.dcs.ed.ac.uk> <199808250833.BAA32289@dm.cobaltmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
X-Mailer: Mutt 0.93.2i
In-Reply-To: <199808250833.BAA32289@dm.cobaltmicro.com>; from "David S. Miller" on Tue, Aug 25, 1998 at 01:33:14AM
Sender: owner-linux-kernel@vger.rutgers.edu


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii

Hi,

I've managed a draft version of the fuzzy hash VMA lookup stuff to work.
Right now it works only on i386.

It would be nice to know the speed of ElectricFence programs
with the patch applied.

BTW, I've also reimplemented one slot cache to catch growing down
areas too. However the cache requires find_vma calls
to be atomic against each other. I suppose it's true for now, isn't it?

I also measured the one slot cache hit rate.
On my system it stays permanently about 1/3rd!

Best wishes
					Andrey V.
					Savochkin

On Tue, Aug 25, 1998 at 01:33:14AM -0700, David S. Miller wrote:
> 
> As promised here is my work in progress fuzzy hash VMA lookup stuff.
> 
> Actually, two months ago I sat down for an hour or so and tried to do
> all the 2.1.x changes necessary to do a complete job of it, alas not
> only did I get distracted before finishing, I also cannot find the
> half done patch I saved somewhere (hmph...).
> 
> Anyways, the following is enough to demonstrate how the layout would
> look and how each fundamental operation on the data structure needs to
> be implemented.  I suppose someone with Linux VM experience could
> implant the following ideas into their skull and have something at
> least half working in a day or two.
> 
> The fuzzy hashing scheme used here was first formulated by Thomas
> Schoebel, I fixed all the minor quirks and bugs in his initial
> formulation and together we converged on the algorithm as used here.
> To my knowledge it is the only hashing scheme which can handle range
> based lookups and multiple keys in this manner.  (As an interesting
> side note, this scheme could be very useful for other applications,
> for example a c++ exception handling implementation could make good
> use of it with careful crafting).
> 
> The reason I like this scheme so much compared to any other VMA lookup
> engine is that I _know_ that if the full work is implemented properly
> it will be as fast or cheaper _even_ in the common case than what we
> have now.  Sort of like scalability at no latency cost, the best
> kind.  (I know there is a slight space cost, and I'm not trying to
> ignore that issue, yet I believe this cost to be on the same scale as
> that incurred by the old AVL trees)

--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inc-vma.2n"

diff -ruN linux.bak/arch/i386/mm/init.c linux.inc-vma/arch/i386/mm/init.c
--- linux.bak/arch/i386/mm/init.c	Thu Aug  6 09:12:27 1998
+++ linux.inc-vma/arch/i386/mm/init.c	Sun Aug 30 13:56:21 1998
@@ -377,7 +377,8 @@
 	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
 	pg0[0] = pte_val(mk_pte(PAGE_OFFSET, PAGE_READONLY));
 	local_flush_tlb();
-	current->mm->mmap->vm_start += PAGE_SIZE;
+	/* Not a good code. Sometime it suddenly will stop working... */
+	current->mm->mmap_neighbours->vm_start += PAGE_SIZE;
 	__asm__ __volatile__(
 		"jmp 1f; 1:\n"
 		"movb %0,%1\n"
@@ -389,7 +390,7 @@
 		:"memory");
 	pg0[0] = old;
 	local_flush_tlb();
-	current->mm->mmap->vm_start -= PAGE_SIZE;
+	current->mm->mmap_neighbours->vm_start -= PAGE_SIZE;
 	if (boot_cpu_data.wp_works_ok < 0) {
 		boot_cpu_data.wp_works_ok = 0;
 		printk("No.\n");
diff -ruN linux.bak/fs/binfmt_aout.c linux.inc-vma/fs/binfmt_aout.c
--- linux.bak/fs/binfmt_aout.c	Thu Aug  6 09:36:34 1998
+++ linux.inc-vma/fs/binfmt_aout.c	Sun Aug 30 13:53:01 1998
@@ -362,7 +362,6 @@
 		(current->mm->start_brk = N_BSSADDR(ex));
 
 	current->mm->rss = 0;
-	current->mm->mmap = NULL;
 	compute_creds(bprm);
  	current->flags &= ~PF_FORKNOEXEC;
 #ifdef __sparc__
diff -ruN linux.bak/fs/binfmt_elf.c linux.inc-vma/fs/binfmt_elf.c
--- linux.bak/fs/binfmt_elf.c	Thu Aug  6 09:36:34 1998
+++ linux.inc-vma/fs/binfmt_elf.c	Sun Aug 30 13:53:01 1998
@@ -581,7 +581,6 @@
 	/* OK, This is the point of no return */
 	current->mm->end_data = 0;
 	current->mm->end_code = 0;
-	current->mm->mmap = NULL;
 	current->flags &= ~PF_FORKNOEXEC;
 	elf_entry = (unsigned long) elf_ex.e_entry;
 
@@ -1068,7 +1067,7 @@
 	/* Count what's needed to dump, up to the limit of coredump size */
 	segs = 0;
 	size = 0;
-	for(vma = current->mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for(vma = current->mm->mmap_neighbours; vma != NULL; vma = vma->vm_next) {
 		if (maydump(vma))
 		{
 			int sz = vma->vm_end-vma->vm_start;
@@ -1257,7 +1256,7 @@
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
 	/* Write program headers for segments dump */
-	for(vma = current->mm->mmap, i = 0;
+	for(vma = current->mm->mmap_neighbours, i = 0;
 		i < segs && vma != NULL; vma = vma->vm_next) {
 		struct elf_phdr phdr;
 		size_t sz;
@@ -1289,7 +1288,7 @@
 
 	DUMP_SEEK(dataoff);
 
-	for(i = 0, vma = current->mm->mmap;
+	for(i = 0, vma = current->mm->mmap_neighbours;
 	    i < segs && vma != NULL;
 	    vma = vma->vm_next) {
 		unsigned long addr = vma->vm_start;
diff -ruN linux.bak/fs/proc/array.c linux.inc-vma/fs/proc/array.c
--- linux.bak/fs/proc/array.c	Thu Aug  6 09:39:57 1998
+++ linux.inc-vma/fs/proc/array.c	Sun Aug 30 14:12:26 1998
@@ -702,11 +702,11 @@
 	struct mm_struct * mm = p->mm;
 
 	if (mm && mm != &init_mm) {
-		struct vm_area_struct * vma = mm->mmap;
+		struct vm_area_struct * vma;
 		unsigned long data = 0, stack = 0;
 		unsigned long exec = 0, lib = 0;
 
-		for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		for (vma = mm->mmap_neighbours; vma; vma = vma->vm_next) {
 			unsigned long len = (vma->vm_end - vma->vm_start) >> 10;
 			if (!vma->vm_file) {
 				data += len;
@@ -828,11 +828,7 @@
 	state = *get_task_state(tsk);
 	vsize = eip = esp = 0;
 	if (tsk->mm && tsk->mm != &init_mm) {
-		struct vm_area_struct *vma = tsk->mm->mmap;
-		while (vma) {
-			vsize += vma->vm_end - vma->vm_start;
-			vma = vma->vm_next;
-		}
+		vsize = tsk->mm->total_vm;
 		eip = KSTK_EIP(tsk);
 		esp = KSTK_ESP(tsk);
 	}
@@ -983,7 +979,7 @@
 	if (!tsk)
 		return 0;
 	if (tsk->mm && tsk->mm != &init_mm) {
-		struct vm_area_struct * vma = tsk->mm->mmap;
+		struct vm_area_struct * vma = tsk->mm->mmap_neighbours;
 
 		while (vma) {
 			pgd_t *pgd = pgd_offset(tsk->mm, vma->vm_start);
@@ -1079,7 +1075,7 @@
 	column = *ppos & (MAPS_LINE_LENGTH-1);
 
 	/* quickly go to line lineno */
-	for (map = p->mm->mmap, i = 0; map && (i < lineno); map = map->vm_next, i++)
+	for (map = p->mm->mmap_neighbours, i = 0; map && (i < lineno); map = map->vm_next, i++)
 		continue;
 
 	for ( ; map ; map = next ) {
diff -ruN linux.bak/fs/proc/link.c linux.inc-vma/fs/proc/link.c
--- linux.bak/fs/proc/link.c	Wed May 20 15:55:38 1998
+++ linux.inc-vma/fs/proc/link.c	Sun Aug 30 13:53:01 1998
@@ -99,7 +99,8 @@
 			struct vm_area_struct * vma;
 			if (!p->mm)
 				goto out_unlock;
-			vma = p->mm->mmap;
+			/* XXX: why the first vma is supposed to be the executable? */
+			vma = p->mm->mmap_neighbours;
 			while (vma) {
 				if ((vma->vm_flags & VM_EXECUTABLE) && 
 				    vma->vm_file) {
diff -ruN linux.bak/fs/proc/mem.c linux.inc-vma/fs/proc/mem.c
--- linux.bak/fs/proc/mem.c	Sun Apr 12 12:34:00 1998
+++ linux.inc-vma/fs/proc/mem.c	Sun Aug 30 13:53:01 1998
@@ -231,10 +231,10 @@
 	 moment because working out the vm_area_struct & nattach stuff isn't
 	 worth it. */
 
-	src_vma = tsk->mm->mmap;
 	stmp = vma->vm_offset;
+	src_vma = find_vma(current->mm, stmp);
 	while (stmp < vma->vm_offset + (vma->vm_end - vma->vm_start)) {
-		while (src_vma && stmp > src_vma->vm_end)
+		while (src_vma && stmp >= src_vma->vm_end)
 			src_vma = src_vma->vm_next;
 		if (!src_vma || (src_vma->vm_flags & VM_SHM))
 			return -EINVAL;
@@ -266,14 +266,14 @@
 		stmp += PAGE_SIZE;
 	}
 
-	src_vma = tsk->mm->mmap;
 	stmp    = vma->vm_offset;
 	dtmp    = vma->vm_start;
+	src_vma = find_vma(current->mm, stmp);
 
 	flush_cache_range(vma->vm_mm, vma->vm_start, vma->vm_end);
 	flush_cache_range(src_vma->vm_mm, src_vma->vm_start, src_vma->vm_end);
 	while (dtmp < vma->vm_end) {
-		while (src_vma && stmp > src_vma->vm_end)
+		while (src_vma && stmp >= src_vma->vm_end)
 			src_vma = src_vma->vm_next;
 
 		src_dir = pgd_offset(tsk->mm, stmp);
diff -ruN linux.bak/include/asm-i386/processor.h linux.inc-vma/include/asm-i386/processor.h
--- linux.bak/include/asm-i386/processor.h	Thu Aug  6 09:43:52 1998
+++ linux.inc-vma/include/asm-i386/processor.h	Sun Aug 30 13:53:01 1998
@@ -244,8 +244,15 @@
 	unsigned long v86flags, v86mask, v86mode, saved_esp0;
 };
 
-#define INIT_MMAP \
-{ &init_mm, 0, 0, PAGE_SHARED, VM_READ | VM_WRITE | VM_EXEC, NULL, &init_mm.mmap }
+#define INIT_MMAP	\
+{ 0, 0,			\
+  NULL, NULL,		\
+  0, VM_READ | VM_WRITE | VM_EXEC, \
+  &init_mm, NULL,	\
+  PAGE_SHARED, NULL,	\
+  &init_mm.mmap_hash[0], &init_mm.mmap_neighbours, \
+  NULL, NULL,		\
+  0}
 
 #define INIT_TSS  {						\
 	0,0, /* back_link, __blh */				\
diff -ruN linux.bak/include/linux/mm.h linux.inc-vma/include/linux/mm.h
--- linux.bak/include/linux/mm.h	Thu Aug  6 17:26:12 1998
+++ linux.inc-vma/include/linux/mm.h	Sun Aug 30 13:53:01 1998
@@ -32,24 +32,27 @@
  * library, the executable area etc).
  */
 struct vm_area_struct {
-	struct mm_struct * vm_mm;	/* VM area parameters */
-	unsigned long vm_start;
-	unsigned long vm_end;
-	pgprot_t vm_page_prot;
-	unsigned short vm_flags;
-	struct vm_area_struct *vm_next;
-	struct vm_area_struct **vm_pprev;
+/*0x00*/unsigned long			vm_start;
+/*0x08*/unsigned long			vm_end;
+/*0x10*/struct vm_area_struct		*vm_hash_next;
+/*0x18*/struct vm_area_struct		*vm_next;
+
+/*0x20*/unsigned long			vm_offset;
+/*0x28*/unsigned short			vm_flags;
+/*0x30*/struct mm_struct		*vm_mm;
+/*0x38*/struct vm_operations_struct	*vm_ops;
+
+/*0x40*/pgprot_t			vm_page_prot;
+/*0x48*/struct file			*vm_file;
+/*0x50*/struct vm_area_struct		**vm_hash_pprev;
+/*0x58*/struct vm_area_struct		**vm_pprev;
 
 	/* For areas with inode, the list inode->i_mmap, for shm areas,
 	 * the list of attaches, otherwise unused.
 	 */
-	struct vm_area_struct *vm_next_share;
-	struct vm_area_struct **vm_pprev_share;
-
-	struct vm_operations_struct * vm_ops;
-	unsigned long vm_offset;
-	struct file * vm_file;
-	unsigned long vm_pte;			/* shared mem */
+/*0x60*/struct vm_area_struct		*vm_next_share;
+/*0x68*/struct vm_area_struct		**vm_pprev_share;
+/*0x70*/unsigned long			vm_pte;		/* shared mem */
 };
 
 /*
@@ -351,20 +354,21 @@
 	return 0;
 }
 
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
-static inline struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr)
+extern struct vm_area_struct *__find_vma(struct mm_struct *mm,
+		unsigned long addr);
+
+/* Look up VMA with smallest vm_start and vm_end > addr, NULL if none */
+extern inline struct vm_area_struct *find_vma(struct mm_struct *mm,
+		unsigned long addr)
 {
 	struct vm_area_struct *vma = NULL;
-
-	if (mm) {
-		/* Check the cache first. */
+	if(mm) {
+		/* Check cache inline quickly. */
 		vma = mm->mmap_cache;
-		if(!vma || (vma->vm_end <= addr) || (vma->vm_start > addr)) {
-			vma = mm->mmap;
-			while(vma && vma->vm_end <= addr)
-				vma = vma->vm_next;
-			mm->mmap_cache = vma;
-		}
+		if(vma == NULL			||
+		   (vma->vm_end <= addr)	||
+		   (mm->mmap_cache_start > addr))
+			vma = __find_vma(mm, addr);
 	}
 	return vma;
 }
diff -ruN linux.bak/include/linux/sched.h linux.inc-vma/include/linux/sched.h
--- linux.bak/include/linux/sched.h	Sun Aug 16 09:58:09 1998
+++ linux.inc-vma/include/linux/sched.h	Sun Aug 30 13:53:01 1998
@@ -160,8 +160,14 @@
 /* Maximum number of active map areas.. This is a random (large) number */
 #define MAX_MAP_COUNT	(65536)
 
+#define MM_MMAP_HASHSZ	16
+
 struct mm_struct {
-	struct vm_area_struct *mmap, *mmap_cache;
+	struct vm_area_struct	*mmap_hash[MM_MMAP_HASHSZ];
+
+	struct vm_area_struct	*mmap_cache;
+	unsigned long		mmap_cache_start;
+	struct vm_area_struct	*mmap_neighbours;
 	pgd_t * pgd;
 	int count, map_count;
 	struct semaphore mmap_sem;
@@ -180,7 +186,10 @@
 };
 
 #define INIT_MM {					\
-		&init_mmap, NULL, swapper_pg_dir, 1, 1,	\
+		{ &init_mmap, NULL, },			\
+		&init_mmap, 0, &init_mmap,		\
+		swapper_pg_dir,				\
+		1, 1,					\
 		MUTEX,					\
 		0,					\
 		0, 0, 0, 0,				\
diff -ruN linux.bak/ipc/shm.c linux.inc-vma/ipc/shm.c
--- linux.bak/ipc/shm.c	Thu Aug  6 09:55:14 1998
+++ linux.inc-vma/ipc/shm.c	Sun Aug 30 13:53:01 1998
@@ -640,7 +640,7 @@
 
 	down(&current->mm->mmap_sem);
 	lock_kernel();
-	for (shmd = current->mm->mmap; shmd; shmd = shmdnext) {
+	for (shmd = current->mm->mmap_neighbours; shmd; shmd = shmdnext) {
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
 		    && shmd->vm_start - shmd->vm_offset == (ulong) shmaddr)
diff -ruN linux.bak/kernel/acct.c linux.inc-vma/kernel/acct.c
--- linux.bak/kernel/acct.c	Thu Aug  6 09:55:14 1998
+++ linux.inc-vma/kernel/acct.c	Sun Aug 30 13:53:01 1998
@@ -295,11 +295,7 @@
 
 	vsize = 0;
 	if (current->mm) {
-		struct vm_area_struct *vma = current->mm->mmap;
-		while (vma) {
-			vsize += vma->vm_end - vma->vm_start;
-			vma = vma->vm_next;
-		}
+		vsize = current->mm->total_vm << PAGE_SHIFT;
 	}
 	vsize = vsize / 1024;
 	ac.ac_mem = encode_comp_t(vsize);
diff -ruN linux.bak/kernel/fork.c linux.inc-vma/kernel/fork.c
--- linux.bak/kernel/fork.c	Sun Aug 16 09:58:09 1998
+++ linux.inc-vma/kernel/fork.c	Sun Aug 30 13:53:01 1998
@@ -236,14 +236,16 @@
 
 #endif
 
+extern void vma_insert_hash(struct mm_struct *mm, struct vm_area_struct *vma);
+
 static inline int dup_mmap(struct mm_struct * mm)
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
 
 	flush_cache_mm(current->mm);
-	pprev = &mm->mmap;
-	for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
+	pprev = &mm->mmap_neighbours;
+	for (mpnt = current->mm->mmap_neighbours; mpnt ; mpnt = mpnt->vm_next) {
 		struct file *file;
 
 		retval = -ENOMEM;
@@ -282,6 +284,7 @@
 			(*pprev)->vm_pprev = &tmp->vm_next;
 		*pprev = tmp;
 		tmp->vm_pprev = pprev;
+		vma_insert_hash(mm, tmp);
 
 		pprev = &tmp->vm_next;
 		if (retval)
@@ -316,7 +319,8 @@
 		 * Leave mm->pgd set to the parent's pgd
 		 * so that pgd_offset() is always valid.
 		 */
-		mm->mmap = mm->mmap_cache = NULL;
+		mm->mmap_neighbours = mm->mmap_cache = NULL;
+		memset(mm->mmap_hash, 0, sizeof(mm->mmap_hash));
 
 		/* It has not run yet, so cannot be present in anyone's
 		 * cache or tlb.
diff -ruN linux.bak/mm/mlock.c linux.inc-vma/mm/mlock.c
--- linux.bak/mm/mlock.c	Thu Aug  6 09:56:20 1998
+++ linux.inc-vma/mm/mlock.c	Sun Aug 30 13:53:01 1998
@@ -241,7 +241,7 @@
 	current->mm->def_flags = def_flags;
 
 	error = 0;
-	for (vma = current->mm->mmap; vma ; vma = vma->vm_next) {
+	for (vma = current->mm->mmap_neighbours; vma ; vma = vma->vm_next) {
 		unsigned int newflags;
 
 		newflags = vma->vm_flags | VM_LOCKED;
diff -ruN linux.bak/mm/mmap.c linux.inc-vma/mm/mmap.c
--- linux.bak/mm/mmap.c	Thu Aug  6 09:56:20 1998
+++ linux.inc-vma/mm/mmap.c	Sun Aug 30 13:53:01 1998
@@ -72,6 +72,149 @@
 	return free > pages;
 }
 
+#define vmahash(__addr_key)	(((__addr_key)>>13) & (MM_MMAP_HASHSZ - 1))
+
+#define __VMA_HASH_LOOKUP					\
+	do {	vma = mm->mmap_hash[hash];			\
+		if((vma != NULL) && (vma->vm_start < addr))	\
+			goto start_search;			\
+		hash = ((hash - 1) & (MM_MMAP_HASHSZ - 1));	\
+	} while(hash != starthash)
+
+#define __FIND_VMA_LOOP						\
+	/* Here is where things get interesting. */		\
+	do {							\
+		tmp = vma->vm_hash_next;			\
+		if (tmp != NULL && tmp->vm_start < addr) {	\
+			vma = tmp;				\
+			continue;				\
+		}						\
+		tmp = vma->vm_next;				\
+		if (tmp != NULL && tmp->vm_start < addr) {	\
+			vma = tmp;				\
+			continue;				\
+		}						\
+		if (vma->vm_end > addr)				\
+			break;					\
+		vma = vma->vm_next;				\
+		break;						\
+	} while (1)
+
+#define __FIND_VMA_PREV_LOOP					\
+	do {							\
+		tmp = vma->vm_hash_next;			\
+		if (tmp != NULL && tmp->vm_end <= addr) {	\
+			vma = tmp;				\
+			continue;				\
+		}						\
+		tmp = vma->vm_next;				\
+		if (tmp != NULL && tmp->vm_start < addr) {	\
+			prev = vma;				\
+			vma = tmp;				\
+			continue;				\
+		}						\
+		if (vma->vm_end > addr)				\
+			break;					\
+		prev = vma;					\
+		vma = vma->vm_next;				\
+		break;						\
+	} while (1)
+
+/* The main search engine is not expanded inline everywhere. */
+struct vm_area_struct *__find_vma(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma, *tmp;
+	unsigned int hash = vmahash(addr);
+	unsigned int starthash = hash;
+
+	__VMA_HASH_LOOKUP;
+	mm->mmap_cache_start = 0;
+	mm->mmap_cache = mm->mmap_neighbours;
+	return mm->mmap_neighbours;
+
+start_search:
+	__FIND_VMA_LOOP;
+	mm->mmap_cache_start = addr;
+	mm->mmap_cache = vma;
+	return vma;
+}
+
+static struct vm_area_struct *find_vma_prev(struct mm_struct *mm,
+		unsigned long addr, struct vm_area_struct **pprev)
+{
+	struct vm_area_struct *vma, *tmp, *prev;
+	unsigned int hash = vmahash(addr);
+	unsigned int starthash = hash;
+
+	__VMA_HASH_LOOKUP;
+	*pprev = NULL;
+	mm->mmap_cache_start = 0;
+	mm->mmap_cache = mm->mmap_neighbours;
+	return mm->mmap_neighbours;
+
+start_search:
+	__FIND_VMA_PREV_LOOP;
+	*pprev = prev;
+	mm->mmap_cache_start = prev->vm_end;
+	mm->mmap_cache = vma;
+	return vma;
+}
+
+static void vma_insert_neighbour(struct mm_struct *mm, struct vm_area_struct *ivm)
+{
+	struct vm_area_struct *vma, *tmp, *prev;
+	unsigned long addr = ivm->vm_start;
+	unsigned int hash = vmahash(addr);
+	unsigned int starthash = hash;
+
+	__VMA_HASH_LOOKUP;
+	ivm->vm_next = mm->mmap_neighbours;
+	ivm->vm_pprev = &mm->mmap_neighbours;
+	mm->mmap_neighbours = ivm;
+	mm->mmap_cache_start = 0;
+	mm->mmap_cache = ivm;
+	return;
+
+start_search:
+	__FIND_VMA_PREV_LOOP;
+	prev->vm_next = ivm;
+	ivm->vm_next = vma;
+	ivm->vm_pprev = &prev->vm_next;
+	if (vma != NULL)
+		vma->vm_pprev = &ivm->vm_next;
+	mm->mmap_cache_start = prev->vm_end;
+	mm->mmap_cache = ivm;
+}
+
+void vma_insert_hash(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	unsigned long start = vma->vm_start;
+	struct vm_area_struct **vpp = &mm->mmap_hash[vmahash(start)];
+
+	for( ; *vpp && (*vpp)->vm_start < start; vpp = &(*vpp)->vm_hash_next)
+		;
+	if((vma->vm_hash_next = *vpp) != NULL)
+		(*vpp)->vm_hash_pprev = &vma->vm_hash_next;
+	*vpp = vma;
+	vma->vm_hash_pprev = vpp;
+}
+
+static inline void vma_insert(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	vma_insert_neighbour(mm, vma);
+	vma_insert_hash(mm, vma);
+}
+
+static void vma_remove(struct vm_area_struct *vma)
+{
+	struct vm_area_struct *n_next = vma->vm_next;
+	struct vm_area_struct *h_next = vma->vm_hash_next;
+	if(n_next) n_next->vm_pprev = vma->vm_pprev;
+	if(h_next) h_next->vm_hash_pprev = vma->vm_hash_pprev;
+	*vma->vm_pprev = n_next;
+	*vma->vm_hash_pprev = h_next;
+}
+
 /* Remove one vm structure from the inode's i_mmap ring. */
 static inline void remove_shared_vm_struct(struct vm_area_struct *vma)
 {
@@ -453,9 +596,7 @@
 	 * on the list.  If nothing is put on, nothing is affected.
 	 */
 	mm = current->mm;
-	mpnt = mm->mmap;
-	while(mpnt && mpnt->vm_end <= addr)
-		mpnt = mpnt->vm_next;
+	mpnt = find_vma(mm, addr);
 	if (!mpnt)
 		return 0;
 
@@ -476,11 +617,7 @@
 	free = NULL;
 	for ( ; mpnt && mpnt->vm_start < addr+len; ) {
 		struct vm_area_struct *next = mpnt->vm_next;
-
-		if(mpnt->vm_next)
-			mpnt->vm_next->vm_pprev = mpnt->vm_pprev;
-		*mpnt->vm_pprev = mpnt->vm_next;
-
+		vma_remove(mpnt);
 		mpnt->vm_next = free;
 		free = mpnt;
 		mpnt = next;
@@ -546,8 +683,9 @@
 {
 	struct vm_area_struct * mpnt;
 
-	mpnt = mm->mmap;
-	mm->mmap = mm->mmap_cache = NULL;
+	mpnt = mm->mmap_neighbours;
+	mm->mmap_neighbours = mm->mmap_cache = NULL;
+	memset(mm->mmap_hash, 0, sizeof(mm->mmap_hash));
 	mm->rss = 0;
 	mm->total_vm = 0;
 	mm->locked_vm = 0;
@@ -582,21 +720,12 @@
  */
 void insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vmp)
 {
-	struct vm_area_struct **pprev = &mm->mmap;
 	struct file * file;
 
 	mm->map_count++;
 
-	/* Find where to link it in. */
-	while(*pprev && (*pprev)->vm_start <= vmp->vm_start)
-		pprev = &(*pprev)->vm_next;
-
-	/* Insert it. */
-	if((vmp->vm_next = *pprev) != NULL)
-		(*pprev)->vm_pprev = &vmp->vm_next;
-	*pprev = vmp;
-	vmp->vm_pprev = pprev;
+	vma_insert(mm, vmp);
 
 	file = vmp->vm_file;
 	if (file) {
 		struct inode * inode = file->f_dentry->d_inode;
@@ -623,12 +753,7 @@
 {
 	struct vm_area_struct *prev, *mpnt, *next;
 
-	prev = NULL;
-	mpnt = mm->mmap;
-	while(mpnt && mpnt->vm_end <= start_addr) {
-		prev = mpnt;
-		mpnt = mpnt->vm_next;
-	}
+	mpnt = find_vma_prev(mm, start_addr, &prev);
 	if (!mpnt)
 		return;
 
@@ -668,10 +793,7 @@
 		 * big segment can possibly merge with the next one.
 		 * The old unused mpnt is freed.
 		 */
-		if(mpnt->vm_next)
-			mpnt->vm_next->vm_pprev = mpnt->vm_pprev;
-		*mpnt->vm_pprev = mpnt->vm_next;
-
+		vma_remove(mpnt);
 		prev->vm_end = mpnt->vm_end;
 		if (mpnt->vm_ops && mpnt->vm_ops->close) {
 			mpnt->vm_offset += mpnt->vm_end - mpnt->vm_start;
diff -ruN linux.bak/mm/swapfile.c linux.inc-vma/mm/swapfile.c
--- linux.bak/mm/swapfile.c	Sun Aug 16 09:58:09 1998
+++ linux.inc-vma/mm/swapfile.c	Sun Aug 30 13:53:01 1998
@@ -280,7 +280,7 @@
 	 */
 	if (!mm || mm == &init_mm)
 		return;
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	for (vma = mm->mmap_neighbours; vma; vma = vma->vm_next) {
 		pgd_t * pgd = pgd_offset(mm, vma->vm_start);
 		unuse_vma(vma, pgd, entry, page);
 	}

--yrj/dFKFPuw6o+aM--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
