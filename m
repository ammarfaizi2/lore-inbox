Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbUKXOGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbUKXOGf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUKXOGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:06:18 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:45463 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262705AbUKXNbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:31:48 -0500
Subject: Suspend 2 merge: 41/51: Ranges (extents).
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101299472.5805.362.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:01:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the heart of our metadata storage.

The comments at the top of range.c say it all. Ranges are used to store
the which pages are in which pageset. The swapwriter uses them to store
which swap addresses are allocated and what block numbers on the swap
devices those addresses map to (we can't swapon at resume time to find
out).

diff -ruN 831-range-old/kernel/power/range.c 831-range-new/kernel/power/range.c
--- 831-range-old/kernel/power/range.c	1970-01-01 10:00:00.000000000 +1000
+++ 831-range-new/kernel/power/range.c	2004-11-04 16:27:41.000000000 +1100
@@ -0,0 +1,784 @@
+/* Suspend2 routines for manipulating ranges.
+ *
+ * (C) 2003-2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * Distributed under GPLv2.
+ * 
+ * These encapsulate the manipulation of ranges. I learnt after writing this
+ * code that ranges are more commonly called extents. They work like this:
+ *
+ * A lot of the data that suspend saves involves continguous ranges of memory
+ * or storage. Let's say that we're storing data on disk in blocks 1-32768 and
+ * 49152-49848 of a swap partition. Rather than recording 1, 2, 3... in arrays
+ * pointing to the locations, we simply use:
+ *
+ * struct range {
+ * 	unsigned long min;
+ * 	unsigned long max;
+ * 	struct range * next;
+ * }
+ *
+ * We can then store 1-32768 and 49152-49848 in 2 struct ranges, using 24 bytes
+ * instead of something like 133,860. This is of course inefficient where a range
+ * covers only one or two values, but the benefits gained by the much larger
+ * ranges more than outweight these instances.
+ *
+ * Whole pages are allocated to store ranges, with unused structs being chained
+ * together and linked into an unused_ranges list:
+ *
+ * struct range * unused_ranges; (just below).
+ *
+ * We can fit 341 ranges in a 4096 byte page (rangepage), with 4 bytes left over.
+ * These four bytes, referred to as the RangePageLink, are used to link the pages
+ * together. The RangePageLink is a pointer to the next page, or'd with the index
+ * number of the page.
+ *
+ * RangePages are stored in the header of the suspend image. For portability
+ * between suspend time and resume time, we 'relativise' the contents of each page
+ * before writing them to disk. That is, each .next and each RangePageLink is
+ * changed to point not to an absolute location, but to the relative location in
+ * the list of pages. This makes all the information valid and usable (after it
+ * has been absolutised again, of course) regardless of where it is reloaded to
+ * at resume time.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/suspend.h>
+#include <linux/mm.h>
+
+#include "pageflags.h"
+#include "suspend.h"
+
+struct range * unused_ranges = NULL;
+int nr_unused_ranges = 0;
+int max_ranges_used = 0;
+int num_range_pages = 0;
+static unsigned long ranges_allocated = 0;
+struct range * first_range_page = NULL, * last_range_page = NULL;
+
+/* Add_range_pages
+ *
+ * Allocates and initialises new pages for storing ranges.
+ * Returns 1 on failure to get a page.
+ * Otherwise adds the new pages to the unused_ranges pool and returns 0.
+ * During resuming, it ensures the page added doesn't collide with memory that
+ * will be overwritten when copying the original kernel back.
+ */
+
+static int add_range_pages(int number_requested)
+{
+	int i, j;
+	struct range * ranges;
+	void **eaten_memory = NULL, **this;
+
+	for (j = 0; j < number_requested; j++) {
+		if (test_suspend_state(SUSPEND_NOW_RESUMING)) {
+			struct page * pageaddr;
+			/* Make sure page doesn't collide when we're resuming */
+			while ((this = (void **) get_zeroed_page(GFP_ATOMIC))) {
+				pageaddr = virt_to_page(this);
+				if (!PageInUse(pageaddr))
+					break;
+				*this = eaten_memory;
+				eaten_memory = this;
+			}
+			// Free unwanted memory
+			while(eaten_memory) {
+				this = eaten_memory;
+				eaten_memory = *eaten_memory;
+				free_page((unsigned long) this);
+			}
+		} else
+			this = (void *) get_grabbed_pages(0);
+
+		if (!this)
+			return 1;
+
+		num_range_pages++;
+		if (!first_range_page)
+			first_range_page = (struct range *) this;
+		if (last_range_page)
+			*RANGEPAGELINK(last_range_page) |= (unsigned long) this;
+		*RANGEPAGELINK(this) = num_range_pages;
+		last_range_page = (struct range *) this;
+		ranges = (struct range *) this;
+		for (i = 0; i < RANGES_PER_PAGE; i++)
+			(ranges+i)->next = (ranges+i+1);
+		(ranges + i - 1)->next = unused_ranges;
+		unused_ranges = ranges;
+		nr_unused_ranges += i;
+	}
+	return 0;
+}
+
+
+/* 
+ * Free ranges.
+ *
+ * Frees pages allocated by add_range_pages()
+ *
+ * Checks that all ranges allocated have been freed and emits a warning if this
+ * is not true.
+ */
+
+int free_ranges(void)
+{
+	int i;
+	struct range * this_range_page = first_range_page, 
+		* next_range_page = NULL;
+
+	if (ranges_allocated)
+		printk(" *** Warning: %ld ranges still allocated when "
+				"free_ranges() called.\n", ranges_allocated);
+
+	for (i = 0; i < num_range_pages; i++) {
+		next_range_page = (struct range *) 
+			(((unsigned long)
+			  (*RANGEPAGELINK(this_range_page))) & PAGE_MASK);
+		free_pages((unsigned long) this_range_page, 0);
+		this_range_page = next_range_page;
+	}
+
+	nr_unused_ranges = num_range_pages = ranges_allocated = 0;
+	unused_ranges = last_range_page = first_range_page = NULL;
+
+	return 0;
+}
+
+/* get_range
+ *
+ * Returns a free range, having removed it from the unused list and having
+ * incremented the usage count. May imply allocating a new page and may
+ * therefore fail, returning NULL instead.
+ * 
+ * No locking. This is because we are only called from suspend, which is single
+ * threaded.
+ */
+
+static struct range * get_range(void)
+{
+	struct range * result;
+	
+	if ((!unused_ranges) && (add_range_pages(1)))
+		return NULL;
+
+	result = unused_ranges;
+	unused_ranges = unused_ranges->next;
+	nr_unused_ranges--;
+	ranges_allocated++;
+	if (ranges_allocated > max_ranges_used)
+		max_ranges_used++;
+	result->minimum = result->maximum = 0;
+	result->next = NULL;
+	return result;
+}
+
+/*
+ * put_range.
+ *
+ * Returns a range to the pool of unused pages and decrements the usage count.
+ *
+ * Assumes unlinking is done by the caller.
+ */
+void put_range(struct range * range)
+{
+	if (!range) {
+		printk("Error! put_range called with NULL range.\n");
+		return;
+	}
+	range->minimum = range->maximum = 0;
+	range->next = unused_ranges;
+	unused_ranges = range;
+	ranges_allocated--;
+	nr_unused_ranges++;
+}
+
+/*
+ * put_range_chain.
+ *
+ * Returns a whole chain of ranges to the unused pool.
+ */
+void put_range_chain(struct rangechain * chain)
+{
+	int count = 0;
+	struct range * this;
+
+	if (chain->first) {
+		this = chain->first;
+		while (this) {
+			this->minimum = this->maximum = 0;
+			this=this->next;
+		}
+		chain->last->next = unused_ranges;
+		unused_ranges = chain->first;
+		count = chain->allocs - chain->frees;
+		ranges_allocated -= count;
+		nr_unused_ranges += count;
+
+		chain->first = NULL;
+		chain->last = NULL;
+		chain->size = 0;
+		chain->allocs = 0;
+		chain->frees = 0;
+		chain->timesusedoptimisation = 0;
+		chain->lastaccessed = NULL; /* Invalidate optimisation info */
+		chain->prevtolastaccessed = NULL;
+		chain->prevtoprev = NULL;
+	}
+}
+
+/* print_chain.
+ *
+ * Displays the contents of a chain.
+ *
+ * printmethod:
+ * 0: integer
+ * 1: hex
+ * 2: page number
+ */
+void print_chain(int debuglevel, struct rangechain * chain, int printmethod)
+{
+	struct range * this = chain->first;
+	int count = 0, size = 0;
+	
+	if ((console_loglevel < debuglevel) || (!this) ||
+			(!TEST_DEBUG_STATE(SUSPEND_RANGES)))
+		return;
+
+	if (!chain->name)
+		suspend_message(SUSPEND_RANGES, debuglevel, 1, "Chain %p\n", chain);
+	else
+		suspend_message(SUSPEND_RANGES, debuglevel, 1, "%s\n", chain->name);
+	
+	while (this) {
+		/*
+		 * 'This' is printed separately so it is displayed if an oops
+		 * results.
+		 */
+		switch (printmethod) {
+			case 0:
+				suspend_message(SUSPEND_RANGES, debuglevel, 1, "(%p) ",
+					this);
+				suspend_message(SUSPEND_RANGES, debuglevel, 1, "%lx-%lx; ",
+					this->minimum, this->maximum);
+				break;
+			case 1:
+				suspend_message(SUSPEND_RANGES, debuglevel, 1, "(%p)",
+					this);
+				suspend_message(SUSPEND_RANGES, debuglevel, 1, "%lu-%lu; ",
+					this->minimum, this->maximum);
+				break;
+			case 2:
+				suspend_message(SUSPEND_RANGES, debuglevel, 1, "(%p)",
+					this);
+				suspend_message(SUSPEND_RANGES, debuglevel, 1, "%p-%p; ",
+					page_address(mem_map+this->minimum),
+					page_address(mem_map+this->maximum) +
+						PAGE_SIZE - 1);
+				break;
+		}
+		size+= this->maximum - this->minimum + 1;
+		this = this->next;
+		count++;
+		if (!(count%4))
+			suspend_message(SUSPEND_RANGES, debuglevel, 1, "\n");
+	}
+	
+	if ((count%4))
+		suspend_message(SUSPEND_RANGES, debuglevel, 1, "\n");
+
+	suspend_message(SUSPEND_RANGES, debuglevel, 1,"%d entries/%ld allocated. "
+			"Allocated %d and freed %d. Size %d.",
+			count, 
+			ranges_allocated,
+			chain->allocs,
+			chain->frees,
+			size);
+	if (count != (chain->allocs - chain->frees)) {
+		chain->debug = 1;
+		check_shift_keys(1, "Discrepancy in chain.");
+	}
+	suspend_message(SUSPEND_RANGES, debuglevel, 1, "\n");
+}
+
+/*
+ * add_to_range_chain.
+ *
+ * Takes a value to be stored and a pointer to a chain and adds the value to 
+ * the range chain, merging with an existing range or  adding a new entry as
+ * necessary. Ranges  are stored in increasing order.
+ *
+ * Values should be consecutive, and so may need to be transformed first. (eg
+ * for pages, would want to call with page-mem_map).
+ *
+ * Important optimisation:
+ * We store in the chain info the location of the last range accessed or added
+ * (and its previous). If the next value is outside this range by one, we start
+ * from the previous entry instead of the start of the chain. In cases of heavy
+ * fragmentation, this saves a lot of time searching.
+ * 
+ * Returns:
+ * 0 if successful
+ * 1 if the value is already included.
+ * 2 if unable to allocate memory.
+ * 3 if fall out bottom (shouldn't happen).
+ */
+
+int add_to_range_chain(struct rangechain * chain, unsigned long value)
+{
+	struct range * this, * prev = NULL, * prevtoprev = NULL;
+	int usedoptimisation = 0;
+	
+	if (!chain->first) {	/* Empty */
+		chain->last = chain->first = get_range();
+		if (!chain->first) {
+			printk("Error unable to allocate the first range for "
+					"the chain.\n");
+			return 2;
+		}
+		chain->allocs++;
+		chain->first->maximum = value;
+		chain->first->minimum = value;
+		chain->size++;
+		return 0;
+	}
+	
+	this = chain->first;
+
+	if (chain->lastaccessed && chain->prevtolastaccessed &&
+		       chain->prevtoprev) {
+		if ((value + 1) == chain->lastaccessed->minimum) {
+			prev = chain->prevtoprev;
+			this = chain->prevtolastaccessed;
+			usedoptimisation = 1;
+		} else if (((value - 1) == chain->lastaccessed->maximum)) {
+			prev = chain->prevtolastaccessed;
+			this = chain->lastaccessed;
+			usedoptimisation = 1;
+		}
+	}
+
+	while (this) {
+		/* Need new entry prior to this? */
+		if ((value + 1) < this->minimum) {
+			struct range * new = get_range();
+			if (!new)
+				return 2;
+			chain->allocs++;
+			new->minimum = value;
+			new->maximum = value;
+			new->next = this;
+			/* Prior to start of chain? */
+			if (!prev)
+				chain->first = new;
+			else
+				prev->next = new;
+			if (!usedoptimisation) {
+				chain->prevtoprev = prevtoprev;
+				chain->prevtolastaccessed = prev;
+				chain->lastaccessed = new;
+			}
+			chain->size++;
+			return 0;
+		}
+
+		if ((this->minimum <= value) && (this->maximum >= value)) {
+			if (chain->name)
+				printk("%s:", chain->name);
+			else
+				printk("%p:", chain);
+				printk("Trying to add a value (%ld/0x%lx) already "
+				"included in chain.\n",
+				value, value);
+			print_chain(SUSPEND_ERROR, chain, 0);
+			check_shift_keys(1, NULL);
+			return 1;
+		}
+		if ((value + 1) == this->minimum) {
+			this->minimum = value;
+			if (!usedoptimisation) {
+				chain->prevtoprev = prevtoprev;
+				chain->prevtolastaccessed = prev;
+				chain->lastaccessed = this;
+			}
+			chain->size++;
+			return 0;
+		}
+		if ((value - 1) == this->maximum) {
+			if ((this->next) && 
+					(this->next->minimum == value + 1)) {
+				struct range * oldnext = this->next;
+				this->maximum = this->next->maximum;
+				this->next = this->next->next;
+				if ((chain->last) == oldnext)
+					chain->last = this;
+				put_range(oldnext);
+				/* Invalidate optimisation info */
+				chain->lastaccessed = NULL;	
+				chain->frees++;
+				if (!usedoptimisation) {
+					chain->prevtoprev = prevtoprev;
+					chain->prevtolastaccessed = prev;
+					chain->lastaccessed = this;
+				}
+				chain->size++;
+				return 0;
+			} 
+			this->maximum = value;
+			if (!usedoptimisation) {
+				chain->prevtoprev = prevtoprev;
+				chain->prevtolastaccessed = prev;
+				chain->lastaccessed = this;
+			}
+			chain->size++;
+			return 0;
+		}
+		if (!this->next) {
+			struct range * new = get_range();
+			if (!new) {
+				printk("Error unable to append a new range to "
+						"the chain.\n");
+				return 2;
+			}
+			chain->allocs++;
+			new->minimum = value;
+			new->maximum = value;
+			new->next = NULL;
+			this->next = new;
+			chain->last = new;
+			if (!usedoptimisation) {
+				chain->prevtoprev = prev;
+				chain->prevtolastaccessed = this;
+				chain->lastaccessed = new;
+			}
+			chain->size++;
+			return 0;
+		}
+		prevtoprev = prev;
+		prev = this;
+		this = this->next;
+	}
+	printk("\nFell out the bottom of add_to_range_chain. This shouldn't "
+			"happen!\n");
+	SET_RESULT_STATE(SUSPEND_ABORTED);
+	return 3;
+}
+
+/* append_range
+ * Used where we know a range is to be added to the end of the list
+ * and does not need merging with the current last range.
+ * (count_data_pages only at the moment)
+ */
+
+int append_range_to_range_chain(struct rangechain * chain, 
+		unsigned long minimum, unsigned long maximum)
+{
+	struct range * newrange = NULL;
+
+	newrange = get_range();
+	if (!newrange) {
+		printk("Error unable to append a new range to the chain.\n");
+		return 2;
+	}
+
+	chain->allocs++;
+	chain->size+= (maximum - minimum + 1);
+	newrange->minimum = minimum;
+	newrange->maximum = maximum;
+	newrange->next = NULL;
+
+	if (chain->last) {
+		chain->last->next = newrange;
+		chain->last = newrange;
+	} else 
+		chain->last = chain->first = newrange;
+
+	/* No need to reset optimisation info since added to end */
+	return 0;
+}
+
+int append_to_range_chain(int chain, unsigned long min, unsigned long max)
+{
+	int result = 0;
+
+	switch (chain) {
+		case 0:
+			return 0;
+		case 1:
+			result = append_range_to_range_chain(
+					&pagedir1.origranges, min, max);
+			break;
+		case 2:
+			result = append_range_to_range_chain(
+					&pagedir2.origranges, min, max);
+			if (!result)
+				result = append_range_to_range_chain(
+					&pagedir1.destranges, min, max);
+	}
+	return result;
+}
+
+/* -------------- Routines for relativising and absoluting ranges -------------
+ *
+ * Prepare rangesets for save by translating addresses to relative indices.
+ */
+void relativise_ranges(void)
+{
+	struct range * this_range_page = first_range_page;
+	int i;
+	
+	while (this_range_page) {
+		struct range * this_range = this_range_page;
+		for (i = 0; i < RANGES_PER_PAGE; i++) {
+			if (this_range->next) {
+				struct range * orig = this_range->next;
+				this_range->next =
+					RANGE_RELATIVE(this_range->next);
+				suspend_message(SUSPEND_RANGES, SUSPEND_VERBOSE, 1,
+					"Relativised range %d on this page is %p. Absolutised range is %p.\n",
+					i, this_range->next, orig);
+			}
+			this_range++;
+		}
+		this_range_page = (struct range *)
+			((*RANGEPAGELINK(this_range_page)) & PAGE_MASK);
+	}
+}
+
+/* Convert ->next pointers for ranges back to absolute values.
+ * The issue is finding out what page the absolute value is now at.
+ * If we use an array of values, we gain speed, but then we need to
+ * be able to allocate contiguous pages. Fortunately, this is done
+ * prior to loading pagesets, so we can just allocate the pages
+ * needed, set up our array and use it and then discard the data
+ * before we exit.
+ */
+
+void absolutise_ranges()
+{
+	struct range * this_range_page = first_range_page;
+	int i;
+	
+	while (this_range_page) {
+		struct range * this_range = this_range_page;
+		for (i = 0; i < RANGES_PER_PAGE; i++) {
+			if (this_range->next) {
+				struct range * orig = this_range->next;
+				this_range->next = 
+					RANGE_ABSOLUTE(this_range->next);
+				suspend_message(SUSPEND_RANGES, SUSPEND_VERBOSE, 1,
+					"Relativised range %d on this page is %p. Absolutised range is %p.\n",
+					i, orig, this_range->next);
+			}
+			this_range++;
+		}
+		this_range_page = (struct range *)
+			((*RANGEPAGELINK(this_range_page)) & PAGE_MASK);
+	}
+}
+
+void absolutise_chain(struct rangechain * chain)
+{
+	if (chain->first)
+		chain->first = RANGE_ABSOLUTE(chain->first);
+	if (chain->last)
+		chain->last = RANGE_ABSOLUTE(chain->last);
+	if (chain->lastaccessed)
+		chain->lastaccessed = RANGE_ABSOLUTE(chain->lastaccessed);
+	if (chain->prevtolastaccessed)
+		chain->prevtolastaccessed =
+			RANGE_ABSOLUTE(chain->prevtolastaccessed);
+	if (chain->prevtoprev)
+		chain->prevtoprev =
+			RANGE_ABSOLUTE(chain->prevtoprev);
+}
+
+void relativise_chain(struct rangechain * chain)
+{
+	if (chain->first)
+		chain->first = RANGE_RELATIVE(chain->first);
+	if (chain->last)
+		chain->last = RANGE_RELATIVE(chain->last);
+	if (chain->lastaccessed)
+		chain->lastaccessed = RANGE_RELATIVE(chain->lastaccessed);
+	if (chain->prevtolastaccessed)
+		chain->prevtolastaccessed =
+			RANGE_RELATIVE(chain->prevtolastaccessed);
+	if (chain->prevtoprev)
+		chain->prevtoprev = RANGE_RELATIVE(chain->prevtoprev);
+}
+
+/*
+ * Each page in the rangepages lists starts with a pointer to the next page
+ * containing the list. This lets us only use order zero allocations.
+ */
+#define POINTERS_PER_PAGE ((PAGE_SIZE / sizeof(void *)) - 1)
+static unsigned long * range_pagelist = NULL;
+
+unsigned long * get_rangepages_list_entry(int index)
+{
+	int pagenum, offset, i;
+	unsigned long * current_list_page = range_pagelist;
+
+	BUG_ON(index > num_range_pages);
+
+	pagenum = index / POINTERS_PER_PAGE;
+	offset = index - (pagenum * POINTERS_PER_PAGE);
+
+	for (i = 0; i < pagenum; i++)
+		current_list_page = *((unsigned long **) current_list_page);
+
+	return (unsigned long *) current_list_page[offset];
+}
+
+int get_rangepages_list(void)
+{
+	struct range * this_range_page = first_range_page;
+	int i, j, pages_needed, num_in_this_page;
+	unsigned long * current_list_page = range_pagelist;
+	unsigned long * prev_list_page = NULL;
+
+	pages_needed =
+		((num_range_pages + POINTERS_PER_PAGE - 1) / POINTERS_PER_PAGE);
+	
+	for (i = 0; i < pages_needed; i++) {
+		int page_start = i * POINTERS_PER_PAGE;
+		
+		if (!current_list_page) {
+			current_list_page =
+				(unsigned long *) get_grabbed_pages(0);
+			if (!current_list_page)
+				current_list_page = (unsigned long *) get_zeroed_page(GFP_ATOMIC);
+			if (!current_list_page) {
+				abort_suspend("Unable to allocate memory for a range pages list.");
+				printk("Number of range pages is %d.\n", num_range_pages);
+				return -ENOMEM;
+			}
+
+			current_list_page[0] = 0;
+			if (!prev_list_page)
+				range_pagelist = current_list_page;
+			else {
+				*prev_list_page = (unsigned long) current_list_page;
+				prev_list_page = current_list_page;
+			}
+		}
+	
+		num_in_this_page = num_range_pages - page_start;
+		if (num_in_this_page > POINTERS_PER_PAGE)
+			num_in_this_page = POINTERS_PER_PAGE;
+		
+		for (j = 1; j <= num_in_this_page; j++) {
+			current_list_page[j] = (unsigned long) this_range_page;
+
+			this_range_page = (struct range *) (((unsigned long)
+				(*RANGEPAGELINK(this_range_page))) & PAGE_MASK);
+		}
+		
+		for (j = (num_in_this_page + 1); j <= POINTERS_PER_PAGE; j++)
+			current_list_page[j] = 0;
+
+		if ((num_range_pages - page_start) > POINTERS_PER_PAGE)
+			current_list_page = (unsigned long *) current_list_page[0];
+	}
+
+	return 0;
+}
+
+void put_rangepages_list(void)
+{
+	unsigned long * last;
+
+	while (range_pagelist) {
+		last = range_pagelist;
+		range_pagelist = *((unsigned long **) range_pagelist);
+		free_pages((unsigned long) last, 0);
+	}
+}
+
+int PageRangePage(char * seeking)
+{
+	int i;
+	
+	for (i = 1; i <= num_range_pages; i++)
+		if (get_rangepages_list_entry(i) == 
+			(unsigned long *) seeking)
+			return 1;
+
+	return 0;
+}
+/* relocate_rangepages
+ * 
+ * Called at the start of resuming. As well as absolutising pages, we need
+ * to ensure they won't be overwritten by the kernel we're restoring. 
+ */
+int relocate_rangepages()
+{
+	void **eaten_memory = NULL;
+	void **c = eaten_memory, *m = NULL, *f;
+	int oom = 0, i, numeaten = 0;
+	unsigned long * prev_page = NULL;
+
+	for (i = 1; i <= num_range_pages; i++) {
+		int this_collides = 0;
+		unsigned long * this_page = get_rangepages_list_entry(i);
+
+		this_collides = PageInUse(virt_to_page(this_page));
+
+		if (!this_collides) {
+			prev_page = this_page;
+			continue;
+		}
+
+		while ((m = (void *) get_zeroed_page(GFP_ATOMIC))) {
+			memset(m, 0, PAGE_SIZE);
+			if (!PageInUse(virt_to_page(m))) {
+				copy_page(m, (void *) this_page);
+				free_page((unsigned long) this_page);
+				if (i == 1)
+					first_range_page = m;
+				else
+					*RANGEPAGELINK(prev_page) =
+						(i | (unsigned long) m);
+				prev_page = m;
+				break;
+			}
+			numeaten++;
+			eaten_memory = m;
+			*eaten_memory = c;
+			c = eaten_memory;
+		}
+
+		if (!m) {
+			printk("\nRan out of memory trying to relocate "
+				"rangepages (tried %d pages).\n", numeaten);
+			oom = 1;
+			break;
+		}
+	}
+		
+	c = eaten_memory;
+	while(c) {
+		f = c;
+		c = *c;
+		if (f)
+			free_pages((unsigned long) f, 0);
+	}
+	eaten_memory = NULL;
+	
+	if (oom) 
+		return -ENOMEM;
+	else
+		return 0;
+}
+
+EXPORT_SYMBOL(put_rangepages_list);
+EXPORT_SYMBOL(get_rangepages_list);
+EXPORT_SYMBOL(get_rangepages_list_entry);
+EXPORT_SYMBOL(absolutise_chain);
+EXPORT_SYMBOL(relativise_chain);
+EXPORT_SYMBOL(put_range);
+EXPORT_SYMBOL(put_range_chain);
+EXPORT_SYMBOL(add_to_range_chain);
+EXPORT_SYMBOL(PageRangePage);


