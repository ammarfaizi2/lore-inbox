Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVBXGGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVBXGGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVBXGGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:06:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64484 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261825AbVBXGG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:06:29 -0500
Date: Wed, 23 Feb 2005 22:04:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: A Proposal for an MMU abstraction layer
In-Reply-To: <Pine.LNX.4.58.0502161646490.11394@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0502232201430.8664@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au>  <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
  <41E5BC60.3090309@yahoo.com.au>  <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
  <20050113031807.GA97340@muc.de>  <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
  <20050113180205.GA17600@muc.de>  <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
  <20050114043944.GB41559@muc.de>  <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
  <20050114170140.GB4634@muc.de>  <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
  <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com> 
 <41FF00CE.8060904@yahoo.com.au>  <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
 <1107304296.5131.13.camel@npiggin-nld.site>
 <Pine.LNX.4.58.0502161646490.11394@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Rationale
============

Currently the Linux kernel implements a hierachical page table utilizing 4
layers. Architectures that have less layers may cause the kernel to not
generate code for certain layers. However, there are other means for mmu
to describe page tables to the system. For example the Itanium (and other
CPUs) support hashed page table structures or linear page tables. IA64 has
to simulate the hierachical layers through its linear page tables and
implements the higher layers in software.

Moreover, different architectures have different means of implementing
huge page table entries. On IA32 this is realized by omitting the lower
layer entries and providing single PMD entry replacing 512/1024 PTE
entries. On IA64 a PTE entry is used for that purpose. Other architecture
realize huge page table entries through groups of PTE entries. There are
hooks for each of these methods in the kernel. Moreover the way of
handling huge pages is not like other pages but they are managed through a
file system. Only one size of huge pages is supported. It would be much
better if huge pages would be handled more like regular pages and also to
have support for multiple page sizes (which then may lead to support
variable page sizes in the VM).

It would be best to hide these implementation differences in an mmu
abstraction layer. Various architectures could then implement their own
way of representing page table entries. We would provide a legacy 4 layer,
3 layer and 2 layer implementation that would take care of the existing
implementations. These generic implementations can then be taken by an
architecture and emendedto provide the huge page table entries in way
fitting for that architecture. For IA64 and otherplatforms that allow
alternate ways of maintaining translations, we could avoid maintaining a
hierachical table.

There are a couple of additional features for page tables that then could
also be worked into that abstraction layer:

A. Global translation entries.
B. Variable page size.
C. Use a transactional scheme to allow a variety of synchronization
schemes.

Early idea for an mmu abstraction layer API
===========================================

Three new opaque types:

mmu_entry_t
mmu_translation_set_t
mmu_transaction_t

*mmu_entry_t* replaces the existing pte_t and has roughly the same features.
However, mmu_entry_t describes a translation of a logical address to a
physical address in general. This means that the mmu_entry_t must be able
to represent all possible mappings including mappings for huge pages and
pages of various sizes if these features are supported by the method of
handling page tables. If statistics need to be kept about entries then this
entry will also contain a number to indicate what counter to update when
inserting or deleting this type of entry [spare bits may be used for this
purpose]

*mmu_translation_set_t* represents a virtual address space for a process and is essentially
a set of mmu_entry_t's plus additional management information that may be necessary to
manage an address space.

*mmu_transaction_t* allows to perform transactions on translation entries and maintains the
state of a transaction. The state information allows to undo changes or commit them in
a way that must appear to be atomic to any other access in the system.

Operations on mmu_translation_set_t
-----------------------------------

void mmu_new_translation_set(struct mmu_translation_set_t *t);
	Generates an empty translation set

void mmu_dup_translation_set(struct mmu_translation_set_t *t, struct mmu_translation_set *t);
	Generates a duplicate of a translation set

void mmu_remove_translation_set(struct mmu_translation_set *t);
	Removes a translation set

void mmu_clear_range(struct mmu_translation_set_t *t, unsigned long start, unsigned long end);
	Wipe out a range of addresses in the translation set

void mmu_copy_range(struct mmu_translation_set *dest, struct
mmu_translation_set_t *src, unsinged long dest_start, unsigned long src_start, unsigned long
length);

These functions are not implemented for the period in which old and new
schemes are coexisting since this would require a major change to mm_struct.

Transactional operations
------------------------

void mmu_transaction(struct mmu_transaction_t *ta, struct mmu_translation_set_t *tr);
	Begin a transaction

For the coexistence period this is implemented as

	mmu_transaction(struct mmu_transaction_t , struct mm_struct *mm,
		struct vm_are_struct *);

void mmu_commit(struct mmu_transaction_t);
	Commit changes done

void mmu_forget(struct mmu_transaction_t);
	Undo changes undone

struct mmu_entry_t mmu_find(struct mmu_transaction_t *ta, unsigned long address);
	Find mmu entry and make this the current entry

void mmu_update(struct mmu_transaction_t *ta, mmu_entry_t entry);
	Update the current entry

void mmu_add(struct mmu_transaction_t *ta, mmu_entry_t entry, unsigned long address);
	Add a new translation entry

void mmu_remove(struct mmu_transaction_t *ta);
	Remove current translation entry

Operations on mmu_entry_t
-------------------------
The same as for pte_t now. Additional

struct mmu_entry mkglobal(struct mmu_entry)
	Define an entry to be global (valid for all translation sets)

struct mmu_entry mksize(struct mmu_entry entry, unsigned order)
	Set the page size in an entry to order.

struct mmu_entry mkcount(struct mmu_entry entry, unsigned long counter)
	Adding and removing this entry must lead to an update of the specified
	counter.

Not for coexistence period.

Statistics
----------

void mmu_stats(struct mmu_translation_set, unsigned long *entries,
	unsigned long *size_in_pages, unsigned long *counters[]);

Not for coexistence period.

Scanning through mmu entries
----------------------------

void mmu_scan(struct mmu_translation_set_t *t, unsigned long start,
	unsigned long end,
	mmu_entry_t (*func)(struct mmu_entry_t, void *private),
	void *private);
