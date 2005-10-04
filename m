Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVJDUyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVJDUyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 16:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVJDUyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 16:54:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25052 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964971AbVJDUyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 16:54:16 -0400
Date: Tue, 4 Oct 2005 22:53:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051004205334.GC18481@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz> <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510041711.13408.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > should be moved to snapshot.c as well, because they are in fact
> > > symmetrical to what's there (they perform the reverse of creating
> > > the snapshot and use analogous data structures).  IMO the code
> > > change required would not be so drammatic and all of the functions
> > > that _operate_ on the snapshot would be in the same file.
> > 
> > No. read_suspend_image/read_pagedir/data_read is image reading.
> 
> Yes, they are, but they use the same data structures and even call the same
> functions that are used in snapshot.c (eg. alloc_pagedir).

Yes, alloc_pagedir is shared, but that is pretty much it. Difference
between "this provides snapshot" and "this does disk reading/writing"
is still usefull.

> > That does not belong to snaphost. The rest is notthat clear, but I have it
> > working in userspace.
> 
> Of course it is doable in the userland, but this does not mean it should be
> done in the userland.  Personally I don't think so (please see
> below).

Even if you don't agree with putting it to userland (and that's
neccessary -- if we want some features from suspend2), split still
makes sense.

> > Image creation is still done in kernel space, but I think that kernel
> > <-> user interface is going to be cleaner that way, and I do not think
> > pushing it to user is so huge win.
> > 
> > Yes, names are not ideal, but that will be followup patch.
> 
> Having considered it for a while I think it's too early for the splitting,
> because:
> 1) we have bug fixes pending (viz. the x86-64 resume problem),

It is in arch-dependend code, only. It does not even conflict with split.

> 2) we can simplify swsusp quite a bit thanks to the rework-memory-freeing
> patch (eg. we can get rid of eat_page(), free_eaten_memory() and
> some complicated error paths in the resume code), which I'd prefer to do
> before the code is split,

Well, same cleanup can be done after the split, just as easily.

> 3) some cleanups are due before the splitting (eg. function names, the removal
> of prepare_suspend_image() etc.),

Split does not prevent you from doing the cleanups.

> 4) we could make swsusp consist of two functionally independent parts (ie. such
> that they use different data structures etc.) while it is in the single file
> and _then_ split.

The order of cleanups does not matter.

> IMHO there could be the snapshot-handling part and the storage-handling
> part interfacing via some functions (called by the snapshot-handling part)
> like:

No. It needs to be controlled by storage-handling parts, so that
snapshot-handling parts become nice library.

> 1) prepare_to_save(n, m) - initializing the data structures of the storage-handling
> part and the storage itself,
> 2) save_page(*addr, nr) - with addr being the addres of the page to save and nr
> the number of the page, where:
> - nr = 0 for the first pagedir page,
> - nr = (n - 1) for the last pagedir page,
> - nr = n for the first image page (ie. the page pointed to by the first pagedir
> entry)
> - nr = (n + m - 1) for the last image page (ie. the page pointed to by the
> last pagedir entry)
> 3) finish_saving() - removing the storage-handling part data structures,
> 4) prepare_to_load(*n, *m),
> 5) load_page(*addr, nr) - now addr being the address where to store the page,
> 6) finish_loading()

That is ugly. snapshot needs to be called from storage handling parts,
and then interface can become much simpler:

struct pbe *sys_snapshot();

snapshots a system, then you can save it in any way you want. And

void sys_restore(struct pbe *);

. Simple, eh?

> Then the storage-handling part would only have to save/load individual pages
> and associate the page numbers given by the snapshot-handling part
> with swap offsets or equivalent storage addresses.  In that case the
> storage-handling could be moved (at leas partially) to the userland
> _without_ reimplementing the swsusp's data structures in there.

You can't easily do calls from kernel to userland. 

> Also, we could use more memory-efficient representation of the PBE, as the
> only component of it that we really _need_ to save is the .orig_address field.
> Namely, the snapshot-handling part could use PBEs consisting of .address,
> .orig_address and .next internally, passing only the .orig_address fields
> to the storage-handling part (the original order of them could be recreated
> based on nr in save_page() and load_page()).
> 
> Even if that sounds complicated, I think I can implement it in two weeks,
> so please give me a chance.

Lets do it different way. Give me two weeks to do my cleanups. The
initial code move is big, but things get pretty easy from then on. I
break nothing, your cleanups will still be possible. Preview of some
cleanups follows...

Cleanup comments, remove unneccessary includes.

---
commit 1d0ecfa8c8bf0176533abcd2b3a6fe5d6555a182
tree f5491a678e89b8992904d325bb1972d0f8b539fa
parent 0eb03cc17fa5bed7659835f30e5dac6e7c8f614b
author <pavel@amd.(none)> Mon, 03 Oct 2005 14:24:24 +0200
committer <pavel@amd.(none)> Mon, 03 Oct 2005 14:24:24 +0200

 kernel/power/snapshot.c |   25 ++-----------------------
 kernel/power/swsusp.c   |    9 +--------
 2 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1,8 +1,7 @@
 /*
- * linux/kernel/power/swsusp.c
+ * linux/kernel/power/snapshot.c
  *
- * This file is to realize architecture-independent
- * machine suspend feature using pretty near only high-level routines
+ * This file provide system snapshot/restore functionality.
  *
  * Copyright (C) 1998-2005 Pavel Machek <pavel@suse.cz>
  *
@@ -15,30 +14,16 @@
 #include <linux/mm.h>
 #include <linux/suspend.h>
 #include <linux/smp_lock.h>
-#include <linux/file.h>
-#include <linux/utsname.h>
-#include <linux/version.h>
 #include <linux/delay.h>
-#include <linux/reboot.h>
 #include <linux/bitops.h>
-#include <linux/vt_kern.h>
-#include <linux/kbd_kern.h>
-#include <linux/keyboard.h>
 #include <linux/spinlock.h>
-#include <linux/genhd.h>
 #include <linux/kernel.h>
-#include <linux/major.h>
-#include <linux/swap.h>
 #include <linux/pm.h>
 #include <linux/device.h>
-#include <linux/buffer_head.h>
-#include <linux/swapops.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/console.h>
 #include <linux/highmem.h>
-#include <linux/bio.h>
-#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -46,15 +31,9 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 
-#include <linux/random.h>
-#include <linux/crypto.h>
-#include <asm/scatterlist.h>
-
 #include "power.h"
 
 
-
-
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -1,8 +1,7 @@
 /*
  * linux/kernel/power/swsusp.c
  *
- * This file is to realize architecture-independent
- * machine suspend feature using pretty near only high-level routines
+ * This file provides code to write suspend image to swap and read it back.
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
  * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@suse.cz>
@@ -47,11 +46,7 @@
 #include <linux/utsname.h>
 #include <linux/version.h>
 #include <linux/delay.h>
-#include <linux/reboot.h>
 #include <linux/bitops.h>
-#include <linux/vt_kern.h>
-#include <linux/kbd_kern.h>
-#include <linux/keyboard.h>
 #include <linux/spinlock.h>
 #include <linux/genhd.h>
 #include <linux/kernel.h>
@@ -63,10 +58,8 @@
 #include <linux/swapops.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
-#include <linux/console.h>
 #include <linux/highmem.h>
 #include <linux/bio.h>
-#include <linux/mount.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>



!-------------------------------------------------------------flip-


Coding style cleanups.

---
commit 4bf05b99d3c082bd0a1b5106f0b26daf25a0ead6
tree 314cf06719e7fb4eb03e153dbe2d785de250665e
parent 1d0ecfa8c8bf0176533abcd2b3a6fe5d6555a182
author <pavel@amd.(none)> Mon, 03 Oct 2005 14:34:57 +0200
committer <pavel@amd.(none)> Mon, 03 Oct 2005 14:34:57 +0200

 kernel/power/snapshot.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -144,10 +144,10 @@ static int pfn_is_nosave(unsigned long p
  *	isn't part of a free chunk of pages.
  */
 
-static int saveable(struct zone * zone, unsigned long * zone_pfn)
+static int saveable(struct zone *zone, unsigned long *zone_pfn)
 {
 	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
-	struct page * page;
+	struct page *page;
 
 	if (!pfn_valid(pfn))
 		return 0;
@@ -196,11 +196,11 @@ static void copy_data_pages(void)
 		/* This is necessary for swsusp_free() */
 		for_each_pb_page (p, pagedir_nosave)
 			SetPageNosaveFree(virt_to_page(p));
-		for_each_pbe(p, pagedir_nosave)
+		for_each_pbe (p, pagedir_nosave)
 			SetPageNosaveFree(virt_to_page(p->address));
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
-				struct page * page;
+				struct page *page;
 				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
 				BUG_ON(!pbe);
 				pbe->orig_address = (unsigned long)page_address(page);
@@ -294,7 +294,7 @@ static void *alloc_image_page(void)
  *	On each page we set up a list of struct_pbe elements.
  */
 
-struct pbe * alloc_pagedir(unsigned nr_pages)
+struct pbe *alloc_pagedir(unsigned nr_pages)
 {
 	unsigned num;
 	struct pbe *pblist, *pbe;
@@ -303,7 +303,7 @@ struct pbe * alloc_pagedir(unsigned nr_p
 		return NULL;
 
 	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
-	pblist = (struct pbe *)alloc_image_page();
+	pblist = alloc_image_page();
 	/* FIXME: rewrite this ugly loop */
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
@@ -359,7 +359,7 @@ static int enough_free_mem(void)
 
 static int swsusp_alloc(void)
 {
-	struct pbe * p;
+	struct pbe *p;
 
 	pagedir_nosave = NULL;
 



!-------------------------------------------------------------flip-


One more unneccessary cast killed.

---
commit 8e13f07afcbc380088716ae8b2592d25602cd825
tree e2935bf896b939beb5c336cc79414a5a70793318
parent 4bf05b99d3c082bd0a1b5106f0b26daf25a0ead6
author <pavel@amd.(none)> Mon, 03 Oct 2005 14:36:03 +0200
committer <pavel@amd.(none)> Mon, 03 Oct 2005 14:36:03 +0200

 kernel/power/snapshot.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -308,7 +308,7 @@ struct pbe *alloc_pagedir(unsigned nr_pa
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
 		pbe += PB_PAGE_SKIP;
-		pbe->next = (struct pbe *)alloc_image_page();
+		pbe->next = alloc_image_page();
 	}
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);



!-------------------------------------------------------------flip-


Reduce number of ifdefs somehow.

---
commit 84fc971b826d58ee677b119cf3b6d40bc7617728
tree cc22c57a14c587f4ef4f0046f5f5a46524247da9
parent 8e13f07afcbc380088716ae8b2592d25602cd825
author <pavel@amd.(none)> Mon, 03 Oct 2005 14:54:40 +0200
committer <pavel@amd.(none)> Mon, 03 Oct 2005 14:54:40 +0200

 kernel/power/snapshot.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -33,7 +33,6 @@
 
 #include "power.h"
 
-
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
@@ -88,12 +87,10 @@ static int save_highmem_zone(struct zone
 	}
 	return 0;
 }
-#endif /* CONFIG_HIGHMEM */
 
 
 static int save_highmem(void)
 {
-#ifdef CONFIG_HIGHMEM
 	struct zone *zone;
 	int res = 0;
 
@@ -104,13 +101,11 @@ static int save_highmem(void)
 		if (res)
 			return res;
 	}
-#endif
 	return 0;
 }
 
 int restore_highmem(void)
 {
-#ifdef CONFIG_HIGHMEM
 	printk("swsusp: Restoring Highmem\n");
 	while (highmem_copy) {
 		struct highmem_page *save = highmem_copy;
@@ -123,9 +118,12 @@ int restore_highmem(void)
 		free_page((long) save->data);
 		kfree(save);
 	}
-#endif
 	return 0;
 }
+#else
+static int save_highmem(void) { return 0; }
+int restore_highmem(void) { return 0; }
+#endif /* CONFIG_HIGHMEM */
 
 
 static int pfn_is_nosave(unsigned long pfn)



!-------------------------------------------------------------flip-


Reduce use of global variables.

---
commit 7797678810ae12ac92dfecf231ea0f1e27485dfd
tree b4a5834b90c3c9667dfa2d5eb19478d6a6a16405
parent 84fc971b826d58ee677b119cf3b6d40bc7617728
author <pavel@amd.(none)> Mon, 03 Oct 2005 14:59:10 +0200
committer <pavel@amd.(none)> Mon, 03 Oct 2005 14:59:10 +0200

 kernel/power/snapshot.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -88,7 +88,6 @@ static int save_highmem_zone(struct zone
 	return 0;
 }
 
-
 static int save_highmem(void)
 {
 	struct zone *zone;
@@ -164,37 +163,36 @@ static int saveable(struct zone *zone, u
 	return 1;
 }
 
-static void count_data_pages(void)
+static int count_data_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-
-	nr_copy_pages = 0;
+	int pages = 0;
 
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			nr_copy_pages += saveable(zone, &zone_pfn);
+			pages += saveable(zone, &zone_pfn);
 	}
+	return pages;
 }
 
-static void copy_data_pages(void)
+static void copy_data_pages(struct pbe *pgdir)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
-	struct pbe *pbe = pagedir_nosave, *p;
+	struct pbe *pbe = pgdir, *p;
 
-	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
 		mark_free_pages(zone);
 		/* This is necessary for swsusp_free() */
-		for_each_pb_page (p, pagedir_nosave)
+		for_each_pb_page (p, pgdir)
 			SetPageNosaveFree(virt_to_page(p));
-		for_each_pbe (p, pagedir_nosave)
+		for_each_pbe (p, pgdir)
 			SetPageNosaveFree(virt_to_page(p->address));
 		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 			if (saveable(zone, &zone_pfn)) {
@@ -396,7 +394,7 @@ static int suspend_prepare_image(void)
 	}
 
 	drain_local_pages();
-	count_data_pages();
+	nr_copy_pages = count_data_pages();
 	printk("swsusp: Need to copy %u pages\n", nr_copy_pages);
 
 	pr_debug("swsusp: pages needed: %u + %u + %u, free: %u\n",
@@ -422,7 +420,8 @@ static int suspend_prepare_image(void)
 	 * Kill them.
 	 */
 	drain_local_pages();
-	copy_data_pages();
+	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
+	copy_data_pages(pagedir_nosave);
 
 	/*
 	 * End of critical section. From now on, we can write to memory,



!-------------------------------------------------------------flip-


More globals removal.

---
commit e1754380014e7306a20eefbc924b9621280d73f5
tree d7f499d6a3911d784706f0c9488b7cbb3bc67f8d
parent 7797678810ae12ac92dfecf231ea0f1e27485dfd
author <pavel@amd.(none)> Mon, 03 Oct 2005 23:48:57 +0200
committer <pavel@amd.(none)> Mon, 03 Oct 2005 23:48:57 +0200

 kernel/power/snapshot.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -353,24 +353,21 @@ static int enough_free_mem(void)
 }
 
 
-static int swsusp_alloc(void)
+static struct pbe *swsusp_alloc(int pages)
 {
-	struct pbe *p;
+	struct pbe *p, *pgdir;
 
-	pagedir_nosave = NULL;
-
-	if (MAX_PBES < nr_copy_pages / PBES_PER_PAGE +
-	    !!(nr_copy_pages % PBES_PER_PAGE))
+	if (MAX_PBES < pages / PBES_PER_PAGE +
+	    !!(pages % PBES_PER_PAGE))
 		return -ENOSPC;
 
-	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
+	if (!(pgdir = alloc_pagedir(pages))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
 		return -ENOMEM;
 	}
-	create_pbe_list(pagedir_save, nr_copy_pages);
-	pagedir_nosave = pagedir_save;
+	create_pbe_list(pgdir, pages);
 
-	for_each_pbe (p, pagedir_save) {
+	for_each_pbe (p, pgdir) {
 		p->address = (unsigned long)alloc_image_page();
 		if (!p->address) {
 			printk(KERN_ERR "suspend: Allocating image pages failed.\n");
@@ -379,7 +376,7 @@ static int swsusp_alloc(void)
 		}
 	}
 
-	return 0;
+	return pgdir;
 }
 
 static int suspend_prepare_image(void)
@@ -412,9 +409,9 @@ static int suspend_prepare_image(void)
 		return -ENOSPC;
 	}
 
-	error = swsusp_alloc();
-	if (error)
-		return error;
+	pagedir_save = pagedir_nosave = swsusp_alloc(nr_copy_pages);
+	if (!pagedir_save)
+		return -ENOSPC;
 
 	/* During allocating of suspend pagedir, new cold pages may appear.
 	 * Kill them.

-- 
if you have sharp zaurus hardware you don't need... you know my address
