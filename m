Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154161-7845>; Tue, 25 Aug 1998 04:21:31 -0400
Received: from dm.cobaltmicro.com ([209.133.34.35]:1200 "EHLO dm.cobaltmicro.com" ident: "davem") by vger.rutgers.edu with ESMTP id <154542-7845>; Tue, 25 Aug 1998 03:13:02 -0400
Date: Tue, 25 Aug 1998 01:33:14 -0700
Message-Id: <199808250833.BAA32289@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: sct@redhat.com
CC: rdm@bamboo.verinet.com, linux-kernel@vger.rutgers.edu, sct@redhat.com, torvalds@transmeta.com, mingo@valerie.inf.elte.hu, number6@the-village.bc.nu, haible@ma2s2.mathematik.uni-karlsruhe.de
In-reply-to: <199808241008.LAA18963@dax.dcs.ed.ac.uk> (sct@redhat.com)
Subject: Fuzzy hash stuff.. (was Re: 2.1.xxx makes Electric Fence 22x slower)
References: <199808202227.QAA32085@bamboo.verinet.com> <199808241008.LAA18963@dax.dcs.ed.ac.uk>
Sender: owner-linux-kernel@vger.rutgers.edu


As promised here is my work in progress fuzzy hash VMA lookup stuff.

Actually, two months ago I sat down for an hour or so and tried to do
all the 2.1.x changes necessary to do a complete job of it, alas not
only did I get distracted before finishing, I also cannot find the
half done patch I saved somewhere (hmph...).

Anyways, the following is enough to demonstrate how the layout would
look and how each fundamental operation on the data structure needs to
be implemented.  I suppose someone with Linux VM experience could
implant the following ideas into their skull and have something at
least half working in a day or two.

The fuzzy hashing scheme used here was first formulated by Thomas
Schoebel, I fixed all the minor quirks and bugs in his initial
formulation and together we converged on the algorithm as used here.
To my knowledge it is the only hashing scheme which can handle range
based lookups and multiple keys in this manner.  (As an interesting
side note, this scheme could be very useful for other applications,
for example a c++ exception handling implementation could make good
use of it with careful crafting).

The reason I like this scheme so much compared to any other VMA lookup
engine is that I _know_ that if the full work is implemented properly
it will be as fast or cheaper _even_ in the common case than what we
have now.  Sort of like scalability at no latency cost, the best
kind.  (I know there is a slight space cost, and I'm not trying to
ignore that issue, yet I believe this cost to be on the same scale as
that incurred by the old AVL trees)

Enjoy.

#define NULL	((void *)0)

typedef unsigned long pgd_t;
struct semaphore {
	unsigned long count1, count2;
};

#define MM_MMAP_HASHSZ	16

struct mm_struct {
	struct vm_area_struct	*mmap_hash[MM_MMAP_HASHSZ];

	struct vm_area_struct	*mmap_cache;
	struct vm_area_struct	*mmap_neighbours;
	pgd_t			*pgd;
	int count, map_count;
	struct semaphore mmap_sem;
	unsigned long context;
	unsigned long start_code, end_code, start_data, end_data;
	unsigned long start_brk, brk, start_stack;
	unsigned long arg_start, arg_end, env_start, env_end;
	unsigned long rss, total_vm, locked_vm;
	unsigned long def_flags;
	unsigned long cpu_vm_mask;
	/*
	 * This is an architecture-specific pointer: the portable
	 * part of Linux does not know about any segments.
	 */
	void * segments;
};

typedef unsigned long pgprot_t;
struct vm_operations_struct;

struct vm_area_struct {
/*0x00*/unsigned long			vm_start;
/*0x08*/unsigned long			vm_end;
/*0x10*/struct vm_area_struct		*vm_hash_next;
/*0x18*/struct vm_area_struct		*vm_neighbour_next;

/*0x20*/unsigned long			vm_offset;
/*0x28*/unsigned short			vm_flags;
/*0x30*/struct mm_struct		*vm_mm;
/*0x38*/struct vm_operations_struct	*vm_ops;

/*0x40*/pgprot_t			vm_page_prot;
/*0x48*/struct file			*vm_file;
/*0x50*/struct vm_area_struct		**vm_hash_pprev;
/*0x58*/struct vm_area_struct		**vm_neighbour_pprev;

	/* For areas with inode, the list inode->i_mmap, for shm areas,
	 * the list of attaches, otherwise unused.
	 */
/*0x60*/struct vm_area_struct		*vm_next_share;
/*0x68*/struct vm_area_struct		**vm_pprev_share;
/*0x70*/unsigned long			vm_pte;		/* shared mem */
};

#define vmahash(__addr_key)	(((__addr_key)>>13) & (MM_MMAP_HASHSZ - 1))

/* The main search engine is not expanded inline everywhere. */
struct vm_area_struct *__find_vma(struct mm_struct *mm, unsigned long addr)
{
	struct vm_area_struct *vma;
	unsigned int hash = vmahash(addr);
	unsigned int starthash = hash;

	do {	vma = mm->mmap_hash[hash];
		if((vma != NULL) && (vma->vm_start > addr))
			goto start_search;
		hash = ((hash - 1) & (MM_MMAP_HASHSZ - 1));
	} while(hash != starthash);
	return mm->mmap_neighbours;

start_search:
	/* Here is where things get interesting. */
	while(1) {
		struct vm_area_struct *tmp = vma->vm_hash_next;
		if((tmp != NULL) && (tmp->vm_start > addr)) {
			vma = tmp;
		} else if(((tmp = vma->vm_neighbour_next) != NULL) &&
			  (tmp->vm_start > addr)) {
			vma = tmp;
		} else {
			vma = vma->vm_neighbour_next;
			break;
		}
	}
	return vma;
}

struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
{
	struct vm_area_struct *vma = NULL;
	if(mm) {
		/* Check cache inline quickly.
		 *
		 * Sad point: The mmap cache doesn't work for stack
		 *            growth faults, a fix would be welcome.  -DaveM
		 */
		vma = mm->mmap_cache;
		if(vma == NULL			||
		   (vma->vm_end <= addr)	||
		   (vma->vm_start > addr))
			mm->mmap_cache =
				vma =
				__find_vma(mm, addr);
	}
	return vma;
}

static __inline__ void vma_insert_neighbour(struct mm_struct *mm, struct vm_area_struct *vma)
{
	struct vm_area_struct **vpp = &mm->mmap_neighbours;
	unsigned long start = vma->vm_start;

	for( ; *vpp && (*vpp)->vm_start > start; vpp = &(*vpp)->vm_neighbour_next)
		;
	if((vma->vm_neighbour_next = *vpp) != NULL)
		(*vpp)->vm_neighbour_pprev = &vma->vm_neighbour_next;
	*vpp = vma;
	vma->vm_neighbour_pprev = vpp;
}

static __inline__ void vma_insert_hash(struct mm_struct *mm, struct vm_area_struct *vma)
{
	unsigned long start = vma->vm_start;
	struct vm_area_struct **vpp = &mm->mmap_hash[vmahash(start)];

	for( ; *vpp && (*vpp)->vm_start > start; vpp = &(*vpp)->vm_hash_next)
		;
	if((vma->vm_hash_next = *vpp) != NULL)
		(*vpp)->vm_hash_pprev = &vma->vm_hash_next;
	*vpp = vma;
	vma->vm_hash_pprev = vpp;
}

void vma_insert(struct mm_struct *mm, struct vm_area_struct *vma)
{
	vma_insert_neighbour(mm, vma);
	vma_insert_hash(mm, vma);
}

void vma_remove(struct vm_area_struct *vma)
{
	struct vm_area_struct *n_next = vma->vm_neighbour_next;
	struct vm_area_struct *h_next = vma->vm_hash_next;
	if(n_next) n_next->vm_neighbour_pprev = vma->vm_neighbour_pprev;
	if(h_next) h_next->vm_hash_pprev = vma->vm_hash_pprev;
	*vma->vm_neighbour_pprev = n_next;
	*vma->vm_hash_pprev = h_next;
}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
