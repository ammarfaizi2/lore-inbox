Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUCQRLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUCQRLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:11:48 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41692 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261558AbUCQRKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:10:01 -0500
Subject: Re: boot time node and memory limit options
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Robert Picco <Robert.Picco@hp.com>, Jesse Barnes <jbarnes@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Dobson <colpatch@us.ibm.com>
In-Reply-To: <1745150000.1079541412@[10.10.2.4]>
References: <4057392A.8000602@hp.com> <20040316174329.GA29992@sgi.com>
	 <34060000.1079465992@flay> <405879BC.7060904@hp.com>
	 <1745150000.1079541412@[10.10.2.4]>
Content-Type: multipart/mixed; boundary="=-xDvXL4RGAMje3MRaCh8s"
Message-Id: <1079543385.5789.152.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 09:09:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xDvXL4RGAMje3MRaCh8s
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-03-17 at 08:36, Martin J. Bligh wrote:
> > The patch I posted was arrived at after some people suggested an 
> > architecture independent patch.  My patch basically allocates memory 
> > from the bootmem allocator before mem_init calls free_all_bootmem_core.  
> > It's architecture independent.  If the real goal is to limit physical 
> > memory before the bootmem allocator is initialized, then my current 
> > patch doesn't accomplish this. 
>
> Don't we have the same arch dependant issue with the current mem= anyway?
> Can we come up with something where the arch code calls back into a generic
> function to derive limitations, and thereby at least get the parsing done
> in a common routine for consistency? There aren't *that* many NUMA arches
> to change anyway ...

The problem with doing it in generic code is that it has to happen
_after_ the memory layout is discovered.  It's a mess to reconstruct all
of the necessary information about where holes stop and start, at least
from the current information that we store.  Then, you have to go track
down any information that might have "leaked" into the arch code before
you parsed the mem=, which includes all of the {min,max)_{high,low}_pfn
variable.  I prefer to just take care of it at its source where NUMA
information is read out of the hardware.

Every arch has its own way of describing its layout.  Some use "chunks"
and others like ppc64 use LMB (logical memory blocks).  If each arch was
willing to store their memory layout information in a generic way, then
we might have a shot at doing a generic mem= or a NUMA version.  

I coded this up a few days ago to see if I could replace the x440 SRAT
chunks with it.  I never got around to actually doing that part, but
something like this is what we need to do *layout* manipulation in an
architecture-agnostic way.

I started coding this before I thought *too* much about it.  What I want
is a way to get rid of all of the crap that each architecture (and
subarch) have to store their physical memory layout.  On normal x86 we
have the e820 and the EFI tables and on Summit/x440, we have yet another
way to do it.  

What I'd like to do is present a standard way for all of these
architectures to store the information that they need to record at boot
time, plus make something flexible enough that we can use it for stuff
at runtime when hotplug memory is involved.

The code I'd like to see go away from boot-time is anything that deals
with arch-specific structures like the e820, functions like
lmb_end_of_DRAM(), or any code that deals with zholes.  I'd like to get
it to a point where we can do a mostly arch-independent mem=.  

So, here's a little bit of (now userspace) code that implements a very
simple way to track physical memory areas.

stuff that sucks:
- long type names/indiscriminate use of u64
- "section" is on my brain from CONFIG_NONLINEAR, probably don't want
  to use that name again
- Doesn't coalesce adjacent sections with identical attributes, only
  extends existing ones.
- could sort arrays instead of using lists for speed/space
- can leave "UNDEF" holes
- can't add new sections spanning 2 old ones


-- dave

--=-xDvXL4RGAMje3MRaCh8s
Content-Disposition: attachment; filename=layout.c
Content-Type: text/x-c; name=layout.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

#include <stdlib.h>
#include "list.h"
typedef unsigned long long u64;


#define	PHYS_SECTION_UNDEF	0
#define	PHYS_SECTION_DEF		~0ul
#define	PHYS_SECTION_RAM		1<<0
#define	PHYS_SECTION_RAM_DISABLED	1<<1
#define	PHYS_SECTION_HOLE		1<<2

#define PHYS_SECTION_ATTR_END	3

/* these would be in per-arch headers */
#define PHYS_SECTION_PCI_SPACE	1<<(PHYS_SECTION_ATTR_END+0)
#define PHYS_SECTION_RESERVED	1<<(PHYS_SECTION_ATTR_END+1)
#define PHYS_SECTION_BAR	1<<(PHYS_SECTION_ATTR_END+2)
/* this would copy any arch-private fields */
#define section_attr_copy_arch(...)	do {} while(0);
struct phys_layout_section_arch {
	u64 numa_proximity;
};
/* end of per-arch headers */

struct phys_layout_section {
	u64 start_phys_addr;
	u64 end_phys_addr;

	unsigned long attributes;
	struct phys_layout_section_arch arch;
	
	struct list_head list;
};

#define MAX_SECTIONS 128
static struct phys_layout_section sections[MAX_SECTIONS];
int sections_used = 0;

void section_attr_copy(struct phys_layout_section *dst, struct phys_layout_section *src)
{
	dst->arch = src->arch;
	section_attr_copy_arch(dst, src);
}

void add_next_section(struct phys_layout_section *new, struct phys_layout_section *head)
{
	list_add(&new->list, &head->list);
}
void add_prev_section(struct phys_layout_section *new, struct phys_layout_section *head)
{
	list_add_tail(&new->list, &head->list);
}

struct phys_layout_section *alloc_phys_section()
{
	return &sections[sections_used++];
}

int section_contains(struct phys_layout_section * section, u64 addr)
{
	return (addr >= section->start_phys_addr &&
		addr < section->end_phys_addr);
}

LIST_HEAD(section_list);

void print_section(int i, struct phys_layout_section *section)
{
	printf("section %d: %016Lx-%016Lx %08lx\n",
		i++, section->start_phys_addr,
		section->end_phys_addr,
		section->attributes);
}
void print_sections(void)
{
	struct list_head *entry = NULL;
	int i=0;
	
	list_for_each(entry, &section_list) {
		struct phys_layout_section *section;
		section = list_entry(entry, struct phys_layout_section, list);
		print_section(i++, section);
	}
	printf("--------------------------------------------\n");
}


struct phys_layout_section *add_phys_section(u64 new_start_addr, u64 new_end_addr, unsigned long attributes)
{
	struct list_head *entry = NULL;
	struct phys_layout_section *section = NULL;
	struct phys_layout_section *new_section;
	struct phys_layout_section *split_section;
	int i=0;
	u64 old_end_addr;
	
	list_for_each(entry, &section_list) {
		section = list_entry(entry, struct phys_layout_section, list);
		if (!section_contains(section, new_start_addr))
			continue;

		/* same attributes, just extend it */
		if (section->attributes == attributes) {
			if (section->end_phys_addr < new_end_addr)
				section->end_phys_addr = new_end_addr;
			break;
		}

		/* new section needed */
		new_section = alloc_phys_section();
		new_section->start_phys_addr = new_start_addr;
		new_section->end_phys_addr = new_end_addr;
		new_section->attributes = attributes;
		
		/* This started in the same place as the old one */
		if (section->start_phys_addr == new_start_addr) {
			/* shift start of the old one up */
			section->start_phys_addr = new_end_addr;
			add_prev_section(new_section, section);
			break;
		}

		/* 
		 * New section started in the middle of the old one.
		 * Truncate the old one, so that it ends at the start
		 * of the new one.
		 */
		old_end_addr = section->end_phys_addr;
		section->end_phys_addr = new_start_addr;
		add_next_section(new_section, section);

		/* New section covered the rest of the old section */
		if (old_end_addr == new_end_addr)
			break;

		/* 
		 * The new section was spanned by the old one, and the old
		 * one had to be split. Another section is needed for the 
		 * remainder of the old area.  Extend the "new_section", so
		 * that the split section can truncate it in the recursion.
		 *
		 * This will only recurse once, and terminate at the break
		 * immediately above.
		 */
		new_section->end_phys_addr = old_end_addr;
		split_section = add_phys_section(new_end_addr, old_end_addr, 
						 section->attributes);
		section_attr_copy(split_section, section);
		break;
	}
	return new_section;
}

u64 get_total_attr_size(unsigned long attr)
{
        struct list_head *entry = NULL;
	u64 result = 0;
                                                                              
	list_for_each(entry, &section_list) {
		struct phys_layout_section *section;
		section = list_entry(entry, struct phys_layout_section, list);

		if (section->attributes & attr)
			result += section->end_phys_addr - section->start_phys_addr;
	}
		
	return result;
}

int main()
{
	int i;
	sections_used = 1;
	sections[0].end_phys_addr = -1;
	sections[0].attributes = PHYS_SECTION_UNDEF;
	INIT_LIST_HEAD(&sections[0].list);
	list_add(&sections[0].list, &section_list);
	print_sections();

	add_phys_section(0x0000, 0x1000, PHYS_SECTION_HOLE);
	add_phys_section(0x1000, 0x2000, PHYS_SECTION_RAM);
	add_phys_section(0x2000, 0x9000, PHYS_SECTION_HOLE);
	add_phys_section(0x3000, 0x6000, PHYS_SECTION_RAM);
	/* disable some ram for mem= */
	add_phys_section(0x5000, 0x6000, PHYS_SECTION_RAM_DISABLED);
	print_sections();
	printf("disabled RAM size: %Ld\n", get_total_attr_size(PHYS_SECTION_RAM_DISABLED));
	printf("         RAM size: %Ld\n", get_total_attr_size(PHYS_SECTION_RAM));
	printf("        hole size: %Ld\n", get_total_attr_size(PHYS_SECTION_HOLE));
	printf("         any size: %Ld\n", get_total_attr_size(PHYS_SECTION_DEF));
}


--=-xDvXL4RGAMje3MRaCh8s
Content-Disposition: attachment; filename=list.h
Content-Type: text/x-c-header; name=list.h; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

#define prefetch(X)	(X)

/*
 * These are non-NULL pointers that will result in page faults
 * under normal circumstances, used to verify that nobody uses
 * non-initialized list entries.
 */
#define LIST_POISON1  ((void *) 0x00100100)
#define LIST_POISON2  ((void *) 0x00200200)

/*
 * Simple doubly linked list implementation.
 *
 * Some of the internal functions ("__xxx") are useful when
 * manipulating whole lists rather than single entries, as
 * sometimes we already know the next/prev entries and we can
 * generate better code by using them directly rather than
 * using the generic single-entry routines.
 */

struct list_head {
	struct list_head *next, *prev;
};

#define LIST_HEAD_INIT(name) { &(name), &(name) }

#define LIST_HEAD(name) \
	struct list_head name = LIST_HEAD_INIT(name)

#define INIT_LIST_HEAD(ptr) do { \
	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
} while (0)

/*
 * Insert a new entry between two known consecutive entries. 
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new,
			      struct list_head *prev,
			      struct list_head *next)
{
	next->prev = new;
	new->next = next;
	new->prev = prev;
	prev->next = new;
}

/**
 * list_add - add a new entry
 * @new: new entry to be added
 * @head: list head to add it after
 *
 * Insert a new entry after the specified head.
 * This is good for implementing stacks.
 */
static inline void list_add(struct list_head *new, struct list_head *head)
{
	__list_add(new, head, head->next);
}

/**
 * list_add_tail - add a new entry
 * @new: new entry to be added
 * @head: list head to add it before
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new, struct list_head *head)
{
	__list_add(new, head->prev, head);
}

/*
 * Insert a new entry between two known consecutive entries. 
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static __inline__ void __list_add_rcu(struct list_head * new,
	struct list_head * prev,
	struct list_head * next)
{
	new->next = next;
	new->prev = prev;
	smp_wmb();
	next->prev = new;
	prev->next = new;
}

/**
 * list_add_rcu - add a new entry to rcu-protected list
 * @new: new entry to be added
 * @head: list head to add it after
 *
 * Insert a new entry after the specified head.
 * This is good for implementing stacks.
 */
static __inline__ void list_add_rcu(struct list_head *new, struct list_head *head)
{
	__list_add_rcu(new, head, head->next);
}

/**
 * list_add_tail_rcu - add a new entry to rcu-protected list
 * @new: new entry to be added
 * @head: list head to add it before
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static __inline__ void list_add_tail_rcu(struct list_head *new, struct list_head *head)
{
	__list_add_rcu(new, head->prev, head);
}

/*
 * Delete a list entry by making the prev/next entries
 * point to each other.
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head * prev, struct list_head * next)
{
	next->prev = prev;
	prev->next = next;
}

/**
 * list_del - deletes entry from list.
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
	__list_del(entry->prev, entry->next);
	entry->next = LIST_POISON1;
	entry->prev = LIST_POISON2;
}

/**
 * list_del_rcu - deletes entry from list without re-initialization
 * @entry: the element to delete from the list.
 *
 * Note: list_empty on entry does not return true after this, 
 * the entry is in an undefined state. It is useful for RCU based
 * lockfree traversal.
 *
 * In particular, it means that we can not poison the forward 
 * pointers that may still be used for walking the list.
 */
static inline void list_del_rcu(struct list_head *entry)
{
	__list_del(entry->prev, entry->next);
	entry->prev = LIST_POISON2;
}

/**
 * list_del_init - deletes entry from list and reinitialize it.
 * @entry: the element to delete from the list.
 */
static inline void list_del_init(struct list_head *entry)
{
	__list_del(entry->prev, entry->next);
	INIT_LIST_HEAD(entry); 
}

/**
 * list_move - delete from one list and add as another's head
 * @list: the entry to move
 * @head: the head that will precede our entry
 */
static inline void list_move(struct list_head *list, struct list_head *head)
{
        __list_del(list->prev, list->next);
        list_add(list, head);
}

/**
 * list_move_tail - delete from one list and add as another's tail
 * @list: the entry to move
 * @head: the head that will follow our entry
 */
static inline void list_move_tail(struct list_head *list,
				  struct list_head *head)
{
        __list_del(list->prev, list->next);
        list_add_tail(list, head);
}

/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
	return head->next == head;
}

/**
 * list_empty_careful - tests whether a list is
 * empty _and_ checks that no other CPU might be
 * in the process of still modifying either member
 *
 * NOTE: using list_empty_careful() without synchronization
 * can only be safe if the only activity that can happen
 * to the list entry is list_del_init(). Eg. it cannot be used
 * if another CPU could re-list_add() it.
 *
 * @head: the list to test.
 */
static inline int list_empty_careful(const struct list_head *head)
{
	struct list_head *next = head->next;
	return (next == head) && (next == head->prev);
}

static inline void __list_splice(struct list_head *list,
				 struct list_head *head)
{
	struct list_head *first = list->next;
	struct list_head *last = list->prev;
	struct list_head *at = head->next;

	first->prev = head;
	head->next = first;

	last->next = at;
	at->prev = last;
}

/**
 * list_splice - join two lists
 * @list: the new list to add.
 * @head: the place to add it in the first list.
 */
static inline void list_splice(struct list_head *list, struct list_head *head)
{
	if (!list_empty(list))
		__list_splice(list, head);
}

/**
 * list_splice_init - join two lists and reinitialise the emptied list.
 * @list: the new list to add.
 * @head: the place to add it in the first list.
 *
 * The list at @list is reinitialised
 */
static inline void list_splice_init(struct list_head *list,
				    struct list_head *head)
{
	if (!list_empty(list)) {
		__list_splice(list, head);
		INIT_LIST_HEAD(list);
	}
}

#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
#define container_of(ptr, type, member) ({                      \
	const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
	(type *)( (char *)__mptr - offsetof(type,member) );})


/**
 * list_entry - get the struct for this entry
 * @ptr:	the &struct list_head pointer.
 * @type:	the type of the struct this is embedded in.
 * @member:	the name of the list_struct within the struct.
 */
#define list_entry(ptr, type, member) \
	container_of(ptr, type, member)

/**
 * list_for_each	-	iterate over a list
 * @pos:	the &struct list_head to use as a loop counter.
 * @head:	the head for your list.
 */
#define list_for_each(pos, head) \
	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
        	pos = pos->next, prefetch(pos->next))

/**
 * __list_for_each	-	iterate over a list
 * @pos:	the &struct list_head to use as a loop counter.
 * @head:	the head for your list.
 *
 * This variant differs from list_for_each() in that it's the
 * simplest possible list iteration code, no prefetching is done.
 * Use this for code that knows the list to be very short (empty
 * or 1 entry) most of the time.
 */
#define __list_for_each(pos, head) \
	for (pos = (head)->next; pos != (head); pos = pos->next)

/**
 * list_for_each_prev	-	iterate over a list backwards
 * @pos:	the &struct list_head to use as a loop counter.
 * @head:	the head for your list.
 */
#define list_for_each_prev(pos, head) \
	for (pos = (head)->prev, prefetch(pos->prev); pos != (head); \
        	pos = pos->prev, prefetch(pos->prev))
        	
/**
 * list_for_each_safe	-	iterate over a list safe against removal of list entry
 * @pos:	the &struct list_head to use as a loop counter.
 * @n:		another &struct list_head to use as temporary storage
 * @head:	the head for your list.
 */
#define list_for_each_safe(pos, n, head) \
	for (pos = (head)->next, n = pos->next; pos != (head); \
		pos = n, n = pos->next)

/**
 * list_for_each_entry	-	iterate over list of given type
 * @pos:	the type * to use as a loop counter.
 * @head:	the head for your list.
 * @member:	the name of the list_struct within the struct.
 */
#define list_for_each_entry(pos, head, member)				\
	for (pos = list_entry((head)->next, typeof(*pos), member),	\
		     prefetch(pos->member.next);			\
	     &pos->member != (head); 					\
	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
		     prefetch(pos->member.next))

/**
 * list_for_each_entry_reverse - iterate backwards over list of given type.
 * @pos:	the type * to use as a loop counter.
 * @head:	the head for your list.
 * @member:	the name of the list_struct within the struct.
 */
#define list_for_each_entry_reverse(pos, head, member)			\
	for (pos = list_entry((head)->prev, typeof(*pos), member),	\
		     prefetch(pos->member.prev);			\
	     &pos->member != (head); 					\
	     pos = list_entry(pos->member.prev, typeof(*pos), member),	\
		     prefetch(pos->member.prev))

/**
 * list_prepare_entry - prepare a pos entry for use as a start point in
 *			list_for_each_entry_continue
 * @pos:	the type * to use as a start point
 * @head:	the head of the list
 * @member:	the name of the list_struct within the struct.
 */
#define list_prepare_entry(pos, head, member) \
	((pos) ? : list_entry(head, typeof(*pos), member))

/**
 * list_for_each_entry_continue -	iterate over list of given type
 *			continuing after existing point
 * @pos:	the type * to use as a loop counter.
 * @head:	the head for your list.
 * @member:	the name of the list_struct within the struct.
 */
#define list_for_each_entry_continue(pos, head, member) 		\
	for (pos = list_entry(pos->member.next, typeof(*pos), member),	\
		     prefetch(pos->member.next);			\
	     &pos->member != (head);					\
	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
		     prefetch(pos->member.next))

/**
 * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
 * @pos:	the type * to use as a loop counter.
 * @n:		another type * to use as temporary storage
 * @head:	the head for your list.
 * @member:	the name of the list_struct within the struct.
 */
#define list_for_each_entry_safe(pos, n, head, member)			\
	for (pos = list_entry((head)->next, typeof(*pos), member),	\
		n = list_entry(pos->member.next, typeof(*pos), member);	\
	     &pos->member != (head); 					\
	     pos = n, n = list_entry(n->member.next, typeof(*n), member))

/**
 * list_for_each_rcu	-	iterate over an rcu-protected list
 * @pos:	the &struct list_head to use as a loop counter.
 * @head:	the head for your list.
 */
#define list_for_each_rcu(pos, head) \
	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
        	pos = pos->next, ({ smp_read_barrier_depends(); 0;}), prefetch(pos->next))
        	
#define __list_for_each_rcu(pos, head) \
	for (pos = (head)->next; pos != (head); \
        	pos = pos->next, ({ smp_read_barrier_depends(); 0;}))
        	
/**
 * list_for_each_safe_rcu	-	iterate over an rcu-protected list safe
 *					against removal of list entry
 * @pos:	the &struct list_head to use as a loop counter.
 * @n:		another &struct list_head to use as temporary storage
 * @head:	the head for your list.
 */
#define list_for_each_safe_rcu(pos, n, head) \
	for (pos = (head)->next, n = pos->next; pos != (head); \
		pos = n, ({ smp_read_barrier_depends(); 0;}), n = pos->next)

/**
 * list_for_each_entry_rcu	-	iterate over rcu list of given type
 * @pos:	the type * to use as a loop counter.
 * @head:	the head for your list.
 * @member:	the name of the list_struct within the struct.
 */
#define list_for_each_entry_rcu(pos, head, member)			\
	for (pos = list_entry((head)->next, typeof(*pos), member),	\
		     prefetch(pos->member.next);			\
	     &pos->member != (head); 					\
	     pos = list_entry(pos->member.next, typeof(*pos), member),	\
		     ({ smp_read_barrier_depends(); 0;}),		\
		     prefetch(pos->member.next))


/**
 * list_for_each_continue_rcu	-	iterate over an rcu-protected list 
 *			continuing after existing point.
 * @pos:	the &struct list_head to use as a loop counter.
 * @head:	the head for your list.
 */
#define list_for_each_continue_rcu(pos, head) \
	for ((pos) = (pos)->next, prefetch((pos)->next); (pos) != (head); \
        	(pos) = (pos)->next, ({ smp_read_barrier_depends(); 0;}), prefetch((pos)->next))

/* 
 * Double linked lists with a single pointer list head. 
 * Mostly useful for hash tables where the two pointer list head is 
 * too wasteful.
 * You lose the ability to access the tail in O(1).
 */ 

struct hlist_head { 
	struct hlist_node *first; 
}; 

struct hlist_node { 
	struct hlist_node *next, **pprev; 
}; 

#define HLIST_HEAD_INIT { .first = NULL } 
#define HLIST_HEAD(name) struct hlist_head name = {  .first = NULL }
#define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL) 
#define INIT_HLIST_NODE(ptr) ((ptr)->next = NULL, (ptr)->pprev = NULL)

static __inline__ int hlist_unhashed(const struct hlist_node *h) 
{ 
	return !h->pprev;
} 

static __inline__ int hlist_empty(const struct hlist_head *h) 
{ 
	return !h->first;
} 

static __inline__ void __hlist_del(struct hlist_node *n) 
{
	struct hlist_node *next = n->next;
	struct hlist_node **pprev = n->pprev;
	*pprev = next;  
	if (next) 
		next->pprev = pprev;
}  

static __inline__ void hlist_del(struct hlist_node *n)
{
	__hlist_del(n);
	n->next = LIST_POISON1;
	n->pprev = LIST_POISON2;
}

/**
 * hlist_del_rcu - deletes entry from hash list without re-initialization
 * @n: the element to delete from the hash list.
 *
 * Note: list_unhashed() on entry does not return true after this, 
 * the entry is in an undefined state. It is useful for RCU based
 * lockfree traversal.
 *
 * In particular, it means that we can not poison the forward
 * pointers that may still be used for walking the hash list.
 */
static inline void hlist_del_rcu(struct hlist_node *n)
{
	__hlist_del(n);
	n->pprev = LIST_POISON2;
}

static __inline__ void hlist_del_init(struct hlist_node *n) 
{
	if (n->pprev)  {
		__hlist_del(n);
		INIT_HLIST_NODE(n);
	}
}  

#define hlist_del_rcu_init hlist_del_init

static __inline__ void hlist_add_head(struct hlist_node *n, struct hlist_head *h) 
{ 
	struct hlist_node *first = h->first;
	n->next = first; 
	if (first) 
		first->pprev = &n->next;
	h->first = n; 
	n->pprev = &h->first; 
} 

static __inline__ void hlist_add_head_rcu(struct hlist_node *n, struct hlist_head *h) 
{ 
	struct hlist_node *first = h->first;
	n->next = first;
	n->pprev = &h->first; 
	smp_wmb();
	if (first) 
		first->pprev = &n->next;
	h->first = n; 
} 

/* next must be != NULL */
static __inline__ void hlist_add_before(struct hlist_node *n, struct hlist_node *next)
{
	n->pprev = next->pprev;
	n->next = next; 
	next->pprev = &n->next; 
	*(n->pprev) = n;
}

static __inline__ void hlist_add_after(struct hlist_node *n,
				       struct hlist_node *next)
{
	next->next	= n->next;
	*(next->pprev)	= n;
	n->next		= next;
}

#define hlist_entry(ptr, type, member) container_of(ptr,type,member)

/* Cannot easily do prefetch unfortunately */
#define hlist_for_each(pos, head) \
	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
	     pos = pos->next) 

#define hlist_for_each_safe(pos, n, head) \
	for (pos = (head)->first; n = pos ? pos->next : 0, pos; \
	     pos = n)

/**
 * hlist_for_each_entry	- iterate over list of given type
 * @tpos:	the type * to use as a loop counter.
 * @pos:	the &struct hlist_node to use as a loop counter.
 * @head:	the head for your list.
 * @member:	the name of the hlist_node within the struct.
 */
#define hlist_for_each_entry(tpos, pos, head, member)			 \
	for (pos = (head)->first;					 \
	     pos && ({ prefetch(pos->next); 1;}) &&			 \
		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
	     pos = pos->next)

/**
 * hlist_for_each_entry_continue - iterate over a hlist continuing after existing point
 * @tpos:	the type * to use as a loop counter.
 * @pos:	the &struct hlist_node to use as a loop counter.
 * @member:	the name of the hlist_node within the struct.
 */
#define hlist_for_each_entry_continue(tpos, pos, member)		 \
	for (pos = (pos)->next;						 \
	     pos && ({ prefetch(pos->next); 1;}) &&			 \
		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
	     pos = pos->next)

/**
 * hlist_for_each_entry_from - iterate over a hlist continuing from existing point
 * @tpos:	the type * to use as a loop counter.
 * @pos:	the &struct hlist_node to use as a loop counter.
 * @member:	the name of the hlist_node within the struct.
 */
#define hlist_for_each_entry_from(tpos, pos, member)			 \
	for (; pos && ({ prefetch(pos->next); 1;}) &&			 \
		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
	     pos = pos->next)

/**
 * hlist_for_each_entry_safe - iterate over list of given type safe against removal of list entry
 * @tpos:	the type * to use as a loop counter.
 * @pos:	the &struct hlist_node to use as a loop counter.
 * @n:		another &struct hlist_node to use as temporary storage
 * @head:	the head for your list.
 * @member:	the name of the hlist_node within the struct.
 */
#define hlist_for_each_entry_safe(tpos, pos, n, head, member) 		 \
	for (pos = (head)->first;					 \
	     pos && ({ n = pos->next; 1; }) && 				 \
		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
	     pos = n)

--=-xDvXL4RGAMje3MRaCh8s--

