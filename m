Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSLRPq1>; Wed, 18 Dec 2002 10:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbSLRPq1>; Wed, 18 Dec 2002 10:46:27 -0500
Received: from users.ccur.com ([208.248.32.211]:14754 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S264836AbSLRPqV>;
	Wed, 18 Dec 2002 10:46:21 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200212181553.PAA04992@rudolph.ccur.com>
Subject: [PATCH] An O1, nonrecursive ID allocator for Posix timers
To: george@mvista.com
Date: Wed, 18 Dec 2002 10:53:28 -0500 (EST)
Cc: akpm@digeo.com, torvalds@transmeta.com, jim.houston@ccur.com,
       linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George, Andrew, Linus, Jim, Everyone,

This is a drop-in replacement for the ID allocator that Jim Houston
wrote to support posix timers.  The inspiration for this came from
Andrew Morton's desire for a recursion-free allocator; in addition I
have made it O(1) while preserving the no-upper-limits-except-memory
attribute of the original.

I (actually Jim) spot-tested this with Jim's posix timers patch as
the base.  It passed a run of George's timers test suite
(http://sourceforge.net/projects/high-res-timers) and the timer
portion of the posix test suite (http://posixtest.sourceforge.net/).

To play with, apply Jim's posix timer patch to 2.5.51 and then delete

    kernel/id2ptr.c
    include/linux/id2ptr.h

then apply this patch.

This procedure might also work against George's timers patch, as he is
using the same ID allocator as Jim.

Jim's timer patch may be found at:
    http://marc.theaimsgroup.com/?l=linux-kernel&m=104006731324824&q=raw

George's timer patch may be found at:
    http://sourceforge.net/projects/high-res-timers 

Joe Korty - Concurrent Computer Corporation




--- 2.5.51/kernel/id2ptr.c	1969-12-31 19:00:00.000000000 -0500
+++ 2.5.51-jh-jak/kernel/id2ptr.c	2002-12-18 09:46:57.000000000 -0500
@@ -0,0 +1,353 @@
+/*
+ * kernel/id2ptr.c
+ *
+ * 2002-12-16  written by Joe Korty joe.korty@ccur.com
+ *	Copywrite (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * An O(1) ID to pointer translation service.
+ *
+ * 17 bits from the ID data structure pointer are copied into the ID
+ * which, when that ID is passed back into the system, can be used to
+ * construct a pointer to a `block of IDs', within which the desired ID
+ * data structure can be found.  However, before that reconstructed pointer
+ * can be dereferenced, the above 17 bits must first index a bitmap to
+ * check if the pointer is valid.  The remaining ID bits hold the index
+ * of the desired ID data structure within the block and an arbitary
+ * value, used to keep IDs from being reused `too fast'.
+ *
+ * Design assumptions: A kmalloc that aligns a power-of-two request to
+ * the size and whose allocation address range spans at most 2^30 bytes.
+ *
+ * Design faults: 1) ID blocks are never kfree'ed once kmalloc'ed.  2)
+ * The bitmap may be prohibitively large on 64-bit architectures (to fix,
+ * vmalloc() might make a good kmalloc() substitute).  3) A bitmap is 4
+ * pages and ID blocks are 2 pages each, these sizes strain kmalloc.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/id2ptr.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+/*
+ * These are the master tuning knobs of the ID allocator:
+ *
+ *    KMALLOCSZ_INBITS	- address range of a kmalloc call, in #bits.
+ *    IDSZ_INBITS	- #bits in a posix timer ID.
+ *    BLKSZ_INBITS	- allocation size of a block of IDs, in #bits.
+ *
+ * These are some of the more important 'sub-tunables', derived from the above:
+ *
+ *    KEYSZ_INBITS	- #bits from a ID pointer copied into an ID.
+ *    CODESZ_INBITS	- #bits in an ID available to hold misc encoded data:
+ *			    i   - index of ID data struct in an ID block
+ *			    arb - a arbitrary `random value', used to keep IDs
+ *				  from being reused 'too fast'
+ *    MAX_IDS_PERBLK	- #IDs in an ID block.
+ *    MAX_ARBS		- upper limit on the above `arb' random value.
+ *
+ * Relationships:
+ *
+ *    KEYSZ_INBITS + CODESZ_INBITS  == IDSZ_INBITS
+ *	(an ID is made up of only two fields, KEY and CODE)
+ *
+ *    KEYSZ_INBITS + BLKSZ_INBITS == KMALLOCSZ_INBITS
+ *	(all bits the kmalloc range must be accounted for by the KEY and
+ *	BLK fields)
+ *
+ *    MAX_ARBS * MAX_PTIMERS_PERBLOCK <= CODESZ
+ *	(required for the CODE field to hold an encoding of the `ID data
+ *	structure index' and the `arbitary value').
+ */
+#define KMALLOCSZ_INBITS	(30)
+#define KMALLOCSZ		(1 << KMALLOCSZ_INBITS)
+#define KMALLOCSZ_MASK		(KMALLOCSZ - 1)
+
+#define IDSZ_INBITS		(32)
+#define BYTESZ_INBITS		(8)
+
+#define BLKSZ_INBITS		(13)
+#define BLKSZ			(1 << BLKSZ_INBITS)
+#define BLKSZ_MASK		(BLKSZ - 1)
+
+#define KEYSZ_INBITS		(KMALLOCSZ_INBITS - BLKSZ_INBITS)
+#define KEYSZ			(1 << KEYSZ_INBITS)
+#define KEYSZ_MASK		(KEYSZ - 1)
+
+#define CODESZ_INBITS		(IDSZ_INBITS - KEYSZ_INBITS)
+#define CODESZ			(1 << CODESZ_INBITS)
+#define CODESZ_MASK		(CODESZ - 1)
+
+#define BITMAPSZ		(KEYSZ / BYTESZ_INBITS)
+
+#define MAX_IDS_PERBLK		(BLKSZ / sizeof(struct iddata))
+#define MAX_ARBS		(CODESZ / MAX_IDS_PERBLK)
+
+/*
+ * An ID namespace control structure.
+ */
+struct idspace {
+	struct list_head head;
+	unsigned long *bitmap;
+	spinlock_t lock;
+	struct semaphore sleeplock;
+};
+
+/*
+ * An ID control structure.
+ */
+struct iddata {
+	struct list_head list;
+	unsigned id;
+	unsigned ctr;
+	void *data;
+};
+
+/**
+ * id_init - create & initialize an ID namespace
+ * @isp - pointer to an uninitialized/unused ID namespace structure
+ *
+ * Large things are left uninitialized until first use.
+ */
+static void id_init(struct idspace *isp)
+{
+	spin_lock_init(&isp->lock);
+	sema_init(&isp->sleeplock, 1);
+	INIT_LIST_HEAD(&isp->head);
+	isp->bitmap = NULL;
+}
+
+/**
+ * id_init_finish - finish initializing an ID namespace
+ * @isp - pointer to a partially initialized ID namespace structure
+ *
+ * Invoked at first use of the namespace.  May race with other (potential)
+ * first-users, first one there gets to initialize; the others NOP.
+ */
+static void id_init_finish(struct idspace *isp)
+{
+	void *bp;
+
+	bp = kmalloc(BITMAPSZ, GFP_KERNEL);
+	memset(bp, 0, BITMAPSZ);
+
+	spin_lock_irq(&isp->lock);
+	if(likely(!isp->bitmap)) {
+		isp->bitmap = bp;
+	} else {
+		kfree(bp);
+	}
+	spin_unlock_irq(&isp->lock);
+}
+
+/**
+ * id_mk - make an ID out of a ID structure address and an arbitrary value.
+ * @p: pointer to a ID data structure in that namespace
+ * @arb: an arbitrary value.
+ *
+ * Callers should make `arb % MAX_ARBS' different each time id_mk is called
+ * with the same `p'.
+ */
+static inline unsigned id_mk(struct iddata *p, unsigned arb)
+{
+	unsigned base, off, i, key, code, id;
+
+	base = (unsigned) ((unsigned long)p - PAGE_OFFSET);
+
+	key = base >> BLKSZ_INBITS;
+	off = base & BLKSZ_MASK;
+	i = off / sizeof(struct iddata);
+	arb %= MAX_ARBS;
+	if (unlikely((arb|key|i) == 0))
+		arb=1; /* do not allow an ID == 0 to be created */
+	code = (i * MAX_ARBS) + arb;
+	id = (key << CODESZ_INBITS) + code;
+
+	BUG_ON(key >= KEYSZ);
+	BUG_ON(off % sizeof(struct iddata));
+	BUG_ON(i >= MAX_IDS_PERBLK);
+	BUG_ON(code >= CODESZ);
+
+	return id;
+}
+
+/**
+ * id_alloc - allocate an iddata data structure and assign it an ID.
+ * @isp: pointer to the ID namespace that the allocation is to be made in.
+ */
+static struct iddata *id_alloc(struct idspace *isp)
+{
+	struct iddata *p;
+	unsigned i, base, key;
+
+	might_sleep();
+
+	if (unlikely(!isp->bitmap)) {
+		id_init_finish(isp);
+	}
+	spin_lock_irq(&isp->lock);
+	while (unlikely(list_empty(&isp->head))) {
+		spin_unlock_irq(&isp->lock);
+		down(&isp->sleeplock);
+		spin_lock_irq(&isp->lock);
+		if (likely(list_empty(&isp->head))) {
+			spin_unlock_irq(&isp->lock);
+			p = kmalloc(BLKSZ, GFP_KERNEL);
+			base = (unsigned) ((unsigned long)p - PAGE_OFFSET);
+
+			BUG_ON(base & ~KMALLOCSZ_MASK);
+			BUG_ON(base & BLKSZ_MASK);
+
+			spin_lock_irq(&isp->lock);
+			for (i = 0; i < MAX_IDS_PERBLK; i++) {
+				list_add_tail(&p[i].list, &isp->head);
+				p[i].id = 0;
+			}
+			key = base >> BLKSZ_INBITS;
+			__set_bit(key, isp->bitmap);
+		}
+		up(&isp->sleeplock);
+	}
+	p = list_entry(isp->head.next, struct iddata, list);
+	list_del(&p->list);
+	spin_unlock_irq(&isp->lock);
+
+	p->id = id_mk(p, p->ctr++);
+	return p;
+}
+
+/**
+ * id_lookup_l - given an ID, return its iddata structure address or NULL
+ * if the ID is not in use.
+ * @isp: pointer to the ID namespace owning the ID
+ * @id: the ID in question
+ *
+ * isp->lock must be held on entry, remains held on exit.
+ */
+static struct iddata *id_lookup_l(struct idspace *isp, unsigned id)
+{
+	struct iddata *p;
+	unsigned key, code, i, base;
+
+	key = id >> CODESZ_INBITS;
+	code = id & CODESZ_MASK;
+	i = code / MAX_ARBS;
+	base = (key << BLKSZ_INBITS) + (i * sizeof(struct iddata));
+	p = (struct iddata *) ((unsigned long)base + PAGE_OFFSET);
+
+	if (unlikely (!isp->bitmap))
+		p = NULL;
+	else if (unlikely(i >= MAX_IDS_PERBLK))
+		p = NULL;
+	else if (unlikely(!test_bit(key, isp->bitmap)))
+		p = NULL;
+	else if (unlikely(p->id != id))
+		p = NULL;
+	return p;
+}
+
+
+/*
+ * Compatibility (user) interface to the above.
+ */
+
+
+/***
+ * id2ptr_new - allocate a new ID and associate a data value with it.
+ * @idp: ID namespace pointer, caller-visible version.
+ * @data: data value to be attached to the ID.
+ */
+int id2ptr_new(struct id *idp, void *data)
+{
+	struct idspace *isp = (struct idspace *)idp->data;
+	struct iddata *p;
+	unsigned id;
+
+	p = id_alloc(isp);
+	if (unlikely(!p)) {
+		id = 0;
+	} else {
+		p->data = data;
+		id = p->id;
+	}
+	return (int)id;
+}
+
+/***
+ * id2ptr_lookup - given an ID namespace and an ID, return the data value
+ * associated with it, or 0 if ID is not in use.
+ * @idp: ID namespace pointer, caller-visible version.
+ * @id: ID to look up.
+ */
+void *id2ptr_lookup(struct id *idp, int id)
+{
+	struct idspace *isp = (struct idspace *)idp->data;
+	unsigned long flags;
+	struct iddata *p;
+	void *data;
+
+	if (unlikely(!isp->bitmap)) {
+		return NULL;
+	}
+	spin_lock_irqsave(&isp->lock, flags);
+
+	p = id_lookup_l(isp, (unsigned)id);
+	if (unlikely(p == NULL)) {
+		data = NULL;
+	} else {
+		data = p->data;
+	}
+	spin_unlock_irqrestore(&isp->lock, flags);
+	return data;
+}
+
+/*** 
+ * id2ptr_remove - free up an ID, return that ID if successful or 0 if not.
+ * @idp: ID namespace pointer, caller-visible version.
+ * @id: the ID to be freed.
+ */
+int id2ptr_remove(struct id *idp, int id)
+{
+	struct idspace *isp = (struct idspace *)idp->data;
+	unsigned long flags;
+	struct iddata *p;
+	int ecode = 0;
+
+	if (unlikely(!isp->bitmap))
+		return 0;
+
+	spin_lock_irqsave(&isp->lock, flags);
+	p = id_lookup_l(isp, (unsigned)id);
+	if (likely(p != NULL)) {
+		p->id = 0;
+		list_add_tail(&p->list, &isp->head);
+		ecode = id;
+	}
+	spin_unlock_irqrestore(&isp->lock, flags);
+	return ecode;
+}
+
+/***
+ * id2ptr_init - initialize/create an ID namespace.
+ * @idp: ID namespace pointer, caller-visible version.
+ * @min_wrap: not used, present only for compatibility.
+ *
+ * No locking done; assumes no caller will try to multiply initialize an
+ * ID namespace.
+ */
+
+void id2ptr_init(struct id *idp, int min_wrap) {
+
+	struct idspace *isp;
+
+	isp = kmalloc(sizeof(*isp), GFP_KERNEL);
+	id_init(isp);
+	idp->data = (void *)isp;
+}
--- 2.5.51/include/linux/id2ptr.h	1969-12-31 19:00:00.000000000 -0500
+++ 2.5.51-jh-jak/include/linux/id2ptr.h	2002-12-17 14:40:40.000000000 -0500
@@ -0,0 +1,28 @@
+#ifndef LINUX_ID2PTR_H
+#define LINUX_ID2PTR_H
+
+/*
+ * include/linux/id2ptr.h
+ *
+ * 2002-12-16  written by Joe Korty joe.korty@ccur.com
+ *	Copyright (C) 2002 by Concurrent Computer Corporation
+ *	Distributed under the GNU GPL license version 2.
+ *
+ * Caller interface to the O(1) ID to pointer translation service.
+ */
+
+/*
+ * ID namespace control structure.  From the caller's point of
+ * view, this will be an opaque data type.
+ */
+
+struct id {
+	void *data;
+};
+
+extern void *id2ptr_lookup(struct id *idp, int id);
+extern int id2ptr_new(struct id *idp, void *data);
+extern int id2ptr_remove(struct id *idp, int id);
+extern void id2ptr_init(struct id *idp, int min_wrap);
+
+#endif /* LINUX_ID2PTR_H */
