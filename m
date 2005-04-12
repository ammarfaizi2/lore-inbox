Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVDLOpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVDLOpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVDLOoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:44:07 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:45721 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262252AbVDLOiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:38:17 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] genalloc for 2.6.12-rc-mm3
References: <16987.39669.285075.730484@jaguar.mkp.net>
	<20050412031502.3b5d39fc.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 12 Apr 2005 10:38:14 -0400
In-Reply-To: <20050412031502.3b5d39fc.akpm@osdl.org>
Message-ID: <yq0br8k12nd.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> jes@trained-monkey.org (Jes Sorensen) wrote:
Andrew> Suggest you put a !CONFIG_GENERIC_ALLOCATOR stub in genpool.h,
Andrew> remove these ifdefs.

Gone, used to be a time when I thought it was needed to have the init
function ... oh well.

>> +# Generic allocator support is selected if needed +# +config
>> GENERIC_ALLOCATOR + boolean

Andrew> This will be turned on by some later patch, yes?

The mspec patch enables it. I don't think this should be a make config
visible option, but rather be enabled by other drivers etc that needs
it.

Andrew> So will this code even be compiled in -mm?  I guess
Andrew> allyesconfig will enable it.

If you enable the mspec driver and compile for ia64 it will.

Andrew> Some API kerneldocs would be useful.

Documentation, you're asking a lot ;-) I'll look into adding something
in a seperate patch - that'll take a bit longer.

>> IA64_GRANULE_SHIFT.  + */ + if ((max_chunk_shift > (PAGE_SHIFT +

Andrew> Does this ia64ism restrict the usefulness of genalloc in any
Andrew> way, or is the comment stale?

Nope, it was just an arbitrary way to set a maximum upper limit for
the chunks. We can always crank it up if someone needs to be able to
allocate larger chunks (all it costs is a few extra entries in the
table).

Andrew> roundup_pow_of_two()?

Didn't know that one, fixed.

Andrew> dprintk?

Leftover code from the sym allocator, removed.

Andrew> mabe get_new_chunk() should return void*, avoid the casting?

I went back and reviewed this and it's sorta a win-one lose-one
situation. If I make it return void * there's other places where it'll
need to be cast the other way. I can change it but I don't think
there's a real win by doing so.

Andrew> You once sent me a rude email for putting a line >80 cols into
Andrew> acenic.c

Me? Never! ;-) Will fix. Ok, this dogfood of mine is quite tasty ....

>> + +EXPORT_SYMBOL(alloc_gen_pool); +EXPORT_SYMBOL(gen_pool_alloc);
>> +EXPORT_SYMBOL(gen_pool_free);

Andrew> Current style is usually to put the exports at the line after
Andrew> the function's closing brace.  I prefer that personally - it's
Andrew> easier to locate.

Hmmm I always thought was the other way. I kinda prefer it that way,
but I am not overly biased. Fixed.

How does this version look?

Cheers,
Jes

Generic allocator that can  be used by device driver to manage special
memory etc. in particular it's used to manage uncached memory on ia64
for the mspec driver. The allocator is based on the allocator from the
sym53c8xx_2 driver.

Signed-off-by: Jes Sorensen <jes@wildopensource.com>


diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/include/linux/genalloc.h linux-2.6.12-rc2-mm3/include/linux/genalloc.h
--- linux-2.6.12-rc2-mm3-vanilla/include/linux/genalloc.h	1969-12-31 16:00:00 -08:00
+++ linux-2.6.12-rc2-mm3/include/linux/genalloc.h	2005-04-12 06:15:45 -07:00
@@ -0,0 +1,40 @@
+/*
+ * Basic general purpose allocator for managing special purpose memory
+ * not managed by the regular kmalloc/kfree interface.
+ * Uses for this includes on-device special memory, uncached memory
+ * etc.
+ *
+ * This code is based on the buddy allocator found in the sym53c8xx_2
+ * driver, adapted for general purpose use.
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/spinlock.h>
+
+#define ALLOC_MIN_SHIFT		5 /* 32 bytes minimum */
+/*
+ *  Link between free memory chunks of a given size.
+ */
+struct gen_pool_link {
+	struct gen_pool_link *next;
+};
+
+/*
+ *  Memory pool descriptor.
+ */
+struct gen_pool {
+	spinlock_t lock;
+	unsigned long (*get_new_chunk)(struct gen_pool *);
+	struct gen_pool *next;
+	struct gen_pool_link *h;
+	unsigned long private;
+	int max_chunk_shift;
+};
+
+unsigned long gen_pool_alloc(struct gen_pool *poolp, int size);
+void gen_pool_free(struct gen_pool *mp, unsigned long ptr, int size);
+struct gen_pool *gen_pool_create(int nr_chunks, int max_chunk_shift,
+				 unsigned long (*fp)(struct gen_pool *),
+				 unsigned long data);
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/lib/Kconfig linux-2.6.12-rc2-mm3/lib/Kconfig
--- linux-2.6.12-rc2-mm3-vanilla/lib/Kconfig	2005-03-01 23:38:10 -08:00
+++ linux-2.6.12-rc2-mm3/lib/Kconfig	2005-04-12 02:14:06 -07:00
@@ -40,6 +40,12 @@
 	tristate
 
 #
+# Generic allocator support is selected if needed
+#
+config GENERIC_ALLOCATOR
+	boolean
+
+#
 # reed solomon support is select'ed if needed
 #
 config REED_SOLOMON
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/lib/Makefile linux-2.6.12-rc2-mm3/lib/Makefile
--- linux-2.6.12-rc2-mm3-vanilla/lib/Makefile	2005-04-12 02:09:05 -07:00
+++ linux-2.6.12-rc2-mm3/lib/Makefile	2005-04-12 02:14:41 -07:00
@@ -29,6 +29,7 @@
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
+obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.12-rc2-mm3-vanilla/lib/genalloc.c linux-2.6.12-rc2-mm3/lib/genalloc.c
--- linux-2.6.12-rc2-mm3-vanilla/lib/genalloc.c	1969-12-31 16:00:00 -08:00
+++ linux-2.6.12-rc2-mm3/lib/genalloc.c	2005-04-12 07:04:59 -07:00
@@ -0,0 +1,189 @@
+/*
+ * Basic general purpose allocator for managing special purpose memory
+ * not managed by the regular kmalloc/kfree interface.
+ * Uses for this includes on-device special memory, uncached memory
+ * etc.
+ *
+ * This code is based on the buddy allocator found in the sym53c8xx_2
+ * driver Copyright (C) 1999-2001  Gerard Roudier <groudier@free.fr>,
+ * and adapted for general purpose use.
+ *
+ * Copyright 2005 (C) Jes Sorensen <jes@trained-monkey.org>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/genalloc.h>
+
+#include <asm/page.h>
+#include <asm/pal.h>
+
+
+struct gen_pool *gen_pool_create(int nr_chunks, int max_chunk_shift,
+				 unsigned long (*fp)(struct gen_pool *),
+				 unsigned long data)
+{
+	struct gen_pool *poolp;
+	unsigned long tmp;
+	int i;
+
+	/*
+	 * This is really an arbitrary limit, +10 is enough for
+	 * IA64_GRANULE_SHIFT, aka 16MB. If anyone needs a large limit
+	 * this can be increased without problems.
+	 */
+	if ((max_chunk_shift > (PAGE_SHIFT + 10)) || 
+	    ((max_chunk_shift < ALLOC_MIN_SHIFT) && max_chunk_shift))
+		return NULL;
+
+	if (!max_chunk_shift)
+		max_chunk_shift = PAGE_SHIFT;
+
+	poolp = kmalloc(sizeof(struct gen_pool), GFP_KERNEL);
+	if (!poolp)
+		return NULL;
+	memset(poolp, 0, sizeof(struct gen_pool));
+	poolp->h = kmalloc(sizeof(struct gen_pool_link) *
+			   (max_chunk_shift - ALLOC_MIN_SHIFT + 1),
+			   GFP_KERNEL);
+	if (!poolp->h) {
+		printk(KERN_WARNING "gen_pool_alloc() failed to allocate\n");
+		kfree(poolp);
+		return NULL;
+	}
+	memset(poolp->h, 0, sizeof(struct gen_pool_link) *
+	       (max_chunk_shift - ALLOC_MIN_SHIFT + 1));
+
+	spin_lock_init(&poolp->lock);
+	poolp->get_new_chunk = fp;
+	poolp->max_chunk_shift = max_chunk_shift;
+	poolp->private = data;
+
+	for (i = 0; i < nr_chunks; i++) {
+		tmp = poolp->get_new_chunk(poolp);
+		printk(KERN_INFO "allocated %lx\n", tmp);
+		if (!tmp)
+			break;
+		gen_pool_free(poolp, tmp, (1 << poolp->max_chunk_shift));
+	}
+
+	return poolp;
+}
+EXPORT_SYMBOL(gen_pool_create);
+
+
+/*
+ *  Simple power of two buddy-like generic allocator.
+ *  Provides naturally aligned memory chunks.
+ */
+unsigned long gen_pool_alloc(struct gen_pool *poolp, int size)
+{
+	int j, i, s, max_chunk_size;
+	unsigned long a, flags;
+	struct gen_pool_link *h = poolp->h;
+
+	max_chunk_size = 1 << poolp->max_chunk_shift;
+
+	if (size > max_chunk_size)
+		return 0;
+
+	i = 0;
+	
+	size = max(size, 1 << ALLOC_MIN_SHIFT);
+	s = roundup_pow_of_two(size);
+
+	j = i;
+
+	spin_lock_irqsave(&poolp->lock, flags);
+	while (!h[j].next) {
+		if (s == max_chunk_size) {
+			struct gen_pool_link *ptr;
+			spin_unlock_irqrestore(&poolp->lock, flags);
+			ptr = (struct gen_pool_link *)poolp->get_new_chunk(poolp);
+			spin_lock_irqsave(&poolp->lock, flags);
+			h[j].next = ptr;
+			if (h[j].next)
+				h[j].next->next = NULL;
+			break;
+		}
+		j++;
+		s <<= 1;
+	}
+	a = (unsigned long) h[j].next;
+	if (a) {
+		h[j].next = h[j].next->next;
+		/*
+		 * This should be split into a seperate function doing
+		 * the chunk split in order to support custom
+		 * handling memory not physically accessible by host
+		 */
+		while (j > i) {
+			j -= 1;
+			s >>= 1;
+			h[j].next = (struct gen_pool_link *) (a + s);
+			h[j].next->next = NULL;
+		}
+	}
+	spin_unlock_irqrestore(&poolp->lock, flags);
+	return a;
+}
+EXPORT_SYMBOL(gen_pool_alloc);
+
+
+/*
+ *  Counter-part of the generic allocator.
+ */
+void gen_pool_free(struct gen_pool *poolp, unsigned long ptr, int size)
+{
+	struct gen_pool_link *q;
+	struct gen_pool_link *h = poolp->h;
+	unsigned long a, b, flags;
+	int i, s, max_chunk_size;
+
+	max_chunk_size = 1 << poolp->max_chunk_shift;
+
+	if (size > max_chunk_size)
+		return;
+
+	i = 0;
+
+	size = max(size, 1 << ALLOC_MIN_SHIFT);
+	s = roundup_pow_of_two(size);
+
+	a = ptr;
+
+	spin_lock_irqsave(&poolp->lock, flags);
+	while (1) {
+		if (s == max_chunk_size) {
+			((struct gen_pool_link *)a)->next = h[i].next;
+			h[i].next = (struct gen_pool_link *)a;
+			break;
+		}
+		b = a ^ s;
+		q = &h[i];
+
+		while (q->next && q->next != (struct gen_pool_link *)b)
+			q = q->next;
+
+		if (!q->next) {
+			((struct gen_pool_link *)a)->next = h[i].next;
+			h[i].next = (struct gen_pool_link *)a;
+			break;
+		}
+		q->next = q->next->next;
+		a = a & b;
+		s <<= 1;
+		i++;
+	}
+	spin_unlock_irqrestore(&poolp->lock, flags);
+}
+EXPORT_SYMBOL(gen_pool_free);
