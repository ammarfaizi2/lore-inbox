Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVKTHqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVKTHqS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVKTHqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:46:18 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:51652 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750834AbVKTHqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:46:18 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool 
In-reply-to: Your message of "Fri, 18 Nov 2005 11:32:57 -0800."
             <437E2C69.4000708@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Nov 2005 18:45:58 +1100
Message-ID: <5511.1132472758@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005 11:32:57 -0800, 
Matthew Dobson <colpatch@us.ibm.com> wrote:
>We have a clustering product that needs to be able to guarantee that the
>networking system won't stop functioning in the case of OOM/low memory
>condition.  The current mempool system is inadequate because to keep the
>whole networking stack functioning, we need more than 1 or 2 slab caches to
>be guaranteed.  We need to guarantee that any request made with a specific
>flag will succeed, assuming of course that you've made your "critical page
>pool" big enough.
>
>The following patch series implements such a critical page pool.  It
>creates 2 userspace triggers:
>
>/proc/sys/vm/critical_pages: write the number of pages you want to reserve
>for the critical pool into this file
>
>/proc/sys/vm/in_emergency: write a non-zero value to tell the kernel that
>the system is in an emergency state and authorize the kernel to dip into
>the critical pool to satisfy critical allocations.

FWIW, the Kernel Debugger (KDB) has similar problems where the system
is dying because of lack of memory but KDB must call some functions
that use kmalloc.  A related problem is that sometimes KDB is invoked
from a non maskable interrupt, so I could not even trust the state of
the spinlocks and the chains in the slab code.

I worked around the problem by adding a last ditch allocator.  Extract
from the kdb patch.

---

/* Last ditch allocator for debugging, so we can still debug even when the
 * GFP_ATOMIC pool has been exhausted.  The algorithms are tuned for space
 * usage, not for speed.  One smallish memory pool, the free chain is always in
 * ascending address order to allow coalescing, allocations are done in brute
 * force best fit.
 */

struct debug_alloc_header {
	u32 next;	/* offset of next header from start of pool */
	u32 size;
};
#define dah_align 8

static u64 debug_alloc_pool_aligned[64*1024/dah_align];	/* 64K pool */
static char *debug_alloc_pool = (char *)debug_alloc_pool_aligned;
static u32 dah_first;

/* Locking is awkward.  The debug code is called from all contexts, including
 * non maskable interrupts.  A normal spinlock is not safe in NMI context.  Try
 * to get the debug allocator lock, if it cannot be obtained after a second
 * then give up.  If the lock could not be previously obtained on this cpu then
 * only try once.
 */
static DEFINE_SPINLOCK(dap_lock);
static inline
int get_dap_lock(void)
{
	static int dap_locked = -1;
	int count;
	if (dap_locked == smp_processor_id())
		count = 1;
	else
		count = 1000;
	while (1) {
		if (spin_trylock(&dap_lock)) {
			dap_locked = -1;
			return 1;
		}
		if (!count--)
			break;
		udelay(1000);
	}
	dap_locked = smp_processor_id();
	return 0;
}

void *debug_kmalloc(size_t size, int flags)
{
	unsigned int rem, h_offset;
	struct debug_alloc_header *best, *bestprev, *prev, *h;
	void *p = NULL;
	if ((p = kmalloc(size, flags)))
		return p;
	if (!get_dap_lock())
		return NULL;
	h = (struct debug_alloc_header *)(debug_alloc_pool + dah_first);
	prev = best = bestprev = NULL;
	while (1) {
		if (h->size >= size && (!best || h->size < best->size)) {
			best = h;
			bestprev = prev;
		}
		if (!h->next)
			break;
		prev = h;
		h = (struct debug_alloc_header *)(debug_alloc_pool + h->next);
	}
	if (!best)
		goto out;
	rem = (best->size - size) & -dah_align;
	/* The pool must always contain at least one header */
	if (best->next == 0 && bestprev == NULL && rem < sizeof(*h))
		goto out;
	if (rem >= sizeof(*h)) {
		best->size = (size + dah_align - 1) & -dah_align;
		h_offset = (char *)best - debug_alloc_pool + sizeof(*best) + best->size;
		h = (struct debug_alloc_header *)(debug_alloc_pool + h_offset);
		h->size = rem - sizeof(*h);
		h->next = best->next;
	} else
		h_offset = best->next;
	if (bestprev)
		bestprev->next = h_offset;
	else
		dah_first = h_offset;
	p = best+1;
out:
	spin_unlock(&dap_lock);
	return p;
}

void debug_kfree(const void *p)
{
	struct debug_alloc_header *h;
	unsigned int h_offset;
	if (!p)
		return;
	if ((char *)p < debug_alloc_pool ||
	    (char *)p >= debug_alloc_pool + sizeof(debug_alloc_pool_aligned)) {
		kfree(p);
		return;
	}
	if (!get_dap_lock())
		return;		/* memory leak, cannot be helped */
	h = (struct debug_alloc_header *)p - 1;
	h_offset = (char *)h - debug_alloc_pool;
	if (h_offset < dah_first) {
		h->next = dah_first;
		dah_first = h_offset;
	} else {
		struct debug_alloc_header *prev;
		prev = (struct debug_alloc_header *)(debug_alloc_pool + dah_first);
		while (1) {
			if (!prev->next || prev->next > h_offset)
				break;
			prev = (struct debug_alloc_header *)(debug_alloc_pool + prev->next);
		}
		if (sizeof(*prev) + prev->size == h_offset) {
			prev->size += sizeof(*h) + h->size;
			h = prev;
			h_offset = (char *)h - debug_alloc_pool;
		} else {
			h->next = prev->next;
			prev->next = h_offset;
		}
	}
	if (h_offset + sizeof(*h) + h->size == h->next) {
		struct debug_alloc_header *next;
		next = (struct debug_alloc_header *)(debug_alloc_pool + h->next);
		h->size += sizeof(*next) + next->size;
		h->next = next->next;
	}
	spin_unlock(&dap_lock);
}

void kdb_initsupport()
{
	struct debug_alloc_header *h;
	h = (struct debug_alloc_header *)debug_alloc_pool;
	h->next = 0;
	h->size = sizeof(debug_alloc_pool_aligned) - sizeof(*h);
	dah_first = 0;
}

