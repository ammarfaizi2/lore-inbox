Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130839AbRBXA1Z>; Fri, 23 Feb 2001 19:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130939AbRBXA1Q>; Fri, 23 Feb 2001 19:27:16 -0500
Received: from k2.llnl.gov ([134.9.1.1]:3580 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S130932AbRBXA1J>;
	Fri, 23 Feb 2001 19:27:09 -0500
From: Reto Baettig <baettig@k2.llnl.gov>
Message-Id: <200102240026.QAA09446@k2.llnl.gov>
Subject: RFC: vmalloc improvements
To: linux-mm@kvack.org (MM Linux), linux-kernel@vger.kernel.org (Kernel Linux)
Date: Fri, 23 Feb 2001 16:26:56 -0800 (PST)
Cc: frey@scs.ch (Martin Frey), baettig@scs.ch
Reply-To: Reto Baettig <baettig@scs.ch>
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We have an application that makes extensive use of vmalloc (we need
lots of large virtual contiguous buffers. The buffers don't have to be
physically contiguous).

vmalloc/vfree is very slow when the vmlist gets long.

I don't know if this problem is already on a todo list or if we are the
first ones who want to use vmalloc extensively. Maybe We're also missing
something.

We would volounteer to improve vmalloc if there is any chance of
getting it into the main kernel tree. We also have an idea how we
Could do that (quite similar to the process address space management):

1.      Create a generic avl-tree headerfile (similar to list.h)

2.      We change the vm_struct to something like:

struct vm_struct {
        unsigned long flags;
        void * addr;
        unsigned long size;
        struct avl_entry avl;
        struct list_head empty_list;
        struct list_head vm_list;
};

with struct avl_entry:

struct avl_entry {
        unsigned long key;
        short height;
        struct avl_entry * avl_left;
        struct avl_entry * avl_right;
}

3.      We have a avl-tree (vm_avl_used) for the used memory areas (sorted
by the address), a hashtable for the unused memory areas (vm_hash_unused,
hashed by the size) and a sorted linear list (vm_list) of all the memory
areas (used and unused). The vm_hash_unused hashtable is initially empty
and gets only filled when previously used areas are freed and the memory
space gets segmented.

4.      When we free an area, we first find it in the avl tree. After we
have the vm_struct, we can look in the vm_list if there are any direct
neighbours. If yes and the neighbour is also free, the areas get merged.

5.      When we have to allocate a new area (get_free_area)
and the hash table can not satisfy the request, we allocate a new area
starting after the end of the used memory areas.

Is this something that makes sense to do and that could make it
into the 2.4 or the 2.5 kernel?

Reto

