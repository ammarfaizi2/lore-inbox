Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSKIXBj>; Sat, 9 Nov 2002 18:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSKIXBi>; Sat, 9 Nov 2002 18:01:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56391 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262806AbSKIXBf>; Sat, 9 Nov 2002 18:01:35 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 16:05:23 -0700
In-Reply-To: <Pine.LNX.4.44.0211070731200.5567-100000@home.transmeta.com>
Message-ID: <m1u1iqcpjg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two cases I am seeing users wanting.
1) Load a new kernel on panic.
   - Extra care must be taken so what broke the first kernel does
     not break this one, and so that the shards of the old kernel
     do not break it.
   - Care must be taken so that loading the second kernel does not
     erase valuable data that is desirable to place in a crash dump.
   - This kernel cannot live at the same address as the old one, (at
     least not initially).

2) Load a new kernel under normal operating conditions.
   And when you have a normal user space that boils down to:
   - Acquire the kernel you are going to boot.
   - Run the user space shutdown scripts, so the system is in
     a clean state.
   - Execute the new kernel.
   - The normal case is that the newly loaded kernel will live at the 
     same physical location where the current kernel lives.


Currently my code handles starting a new kernel under normal operating
conditions.  There are currently two ways I can implement a clean user
space shutdown with out needing locked buffers in the kernel until the
very last moment.

Method 1 (This works today with my sample user space):
- copy the kernel to /newkernel
- init 6
- if [ -r /newkernel ]; then
        /sbin/kexec /newkernel
  else
        /sbin/reboot
  fi
- /sbin/kexec reads in /newkernel
- /newkernel is parsed to figure out how it should be loaded
- sys_kexec is called to copy the kernel from user space anonymous
  memory to temporary kernel buffers.

Method 2 (For people with read only roots):
- /sbin/delayed_kexec /path/to/new/kernel 
- Read in the /path/to/new/kernel into anonymous pages
- Parse it and figure out how it should be loaded
- Run the shutdown scripts from /etc/rc6.d/ 
- Call sys_kexec, which will copy the data from user space anonymous
  pages, to kernel space.

This is to just make it clear that I am not working from a
FUNDAMENTALLY BROKEN interface, nor from a broken model of machine
maintenance.  I am quite willing to make changes assuming I understand
what is gained with the change.  



What I currently support is a moderately nice interface, that has the
kernel doing as much as it can without being bogged down in the
specific details in any one file format, or needing something besides
a 32bit entry point to jump to.

I model an image as a set of segments of physical memory.  And I copy
the image loaded with sys_kexec to it's final location, before jumping
to the new image.  There are two reasons for this.  It takes 3
segments to load a bzImage (setup.S, vmlinux, and an initrd).  And an
arbitrary number of segments maps cleanly to a static ELF binary.

There is only one difficult case.  What happens when the buffers the
kernel allocates are physically in one of the segments of memory of
the new kernel image.  Possible especially for the initrd which is
loaded at the end of memory.  

I then use the following algorithm to sort the potential mess out
before I jump to the new code.  And since this code depends on
swapping the contents of pages, knowing the physical location of
the pages, and is not limited to 128MB I am reluctant to look a
vmalloc variant.  I can more get my pages from a slab if I need to
report I have them.

static int kimage_get_off_destination_pages(struct kimage *image)
{
	kimage_entry_t *ptr, *cptr, entry;
	unsigned long buffer, page;
	unsigned long destination = 0;

	/* Here we implement safe guards to insure that
	 * a source page is not copied to it's destination
	 * page before the data on the destination page is
	 * no longer useful.
	 *
	 * To make it work we actually wind up with a 
	 * stronger condition.  For every page considered
	 * it is either it's own destination page or it is
	 * not a destination page of any page considered.
	 *
	 * Invariants 
	 * 1. buffer is not a destination of a previous page.
	 * 2. page is not a destination of a previous page.
	 * 3. destination is not a previous source page.
	 *
	 * Result: Either a source page and a destination page 
	 * are the same or the page is not a destination page.
	 *
	 * These checks could be done when we allocate the pages,
	 * but doing it as a final pass allows us more freedom
	 * on how we allocate pages.
	 * 
	 * Also while the checks are necessary, in practice nothing
	 * happens.  The destination kernel wants to sit in the
	 * same physical addresses as the current kernel so we never
	 * actually allocate a destination page.
	 *
	 * BUGS: This is a O(N^2) algorithm.
	 */

	
	buffer = __get_free_page(GFP_KERNEL);
	if (!buffer) {
		return -ENOMEM;
	}
	buffer = virt_to_phys((void *)buffer);
	for_each_kimage_entry(image, ptr, entry) {
		/* Here we check to see if an allocated page */
		kimage_entry_t *limit;
		if (entry & IND_DESTINATION) {
			destination = entry & PAGE_MASK;
		}
		else if (entry & IND_INDIRECTION) {
			/* Indirection pages must include all of their
			 * contents in limit checking.
			 */
			limit = phys_to_virt(page + PAGE_SIZE - sizeof(*limit));
		}
		if (!((entry & IND_SOURCE) | (entry & IND_INDIRECTION))) {
			continue;
		}
		page = entry & PAGE_MASK;
		limit = ptr;

		/* See if a previous page has the current page as it's 
		 * destination.
		 * i.e. invariant 2
		 */
		cptr = kimage_dst_conflict(image, page, limit);
		if (cptr) {
			unsigned long cpage;
 			kimage_entry_t centry;
			centry = *cptr;
			cpage = centry & PAGE_MASK;
			memcpy(phys_to_virt(buffer), phys_to_virt(page), PAGE_SIZE);
			memcpy(phys_to_virt(page), phys_to_virt(cpage), PAGE_SIZE);
			*cptr = page | (centry & ~PAGE_MASK);
			*ptr = buffer | (entry & ~PAGE_MASK);
			buffer = cpage;
		}
		if (!(entry & IND_SOURCE)) {
			continue;
		}

		/* See if a previous page is our destination page.
		 * If so claim it now.
		 * i.e. invariant 3
		 */
		cptr = kimage_src_conflict(image, destination, limit);
		if (cptr) {
			unsigned long cpage;
 			kimage_entry_t centry;
			centry = *cptr;
			cpage = centry & PAGE_MASK;
			memcpy(phys_to_virt(buffer), phys_to_virt(cpage), PAGE_SIZE);
			memcpy(phys_to_virt(cpage), phys_to_virt(page), PAGE_SIZE);
			*cptr = buffer | (centry & ~PAGE_MASK);
			*ptr = cpage | ( entry & ~PAGE_MASK);
			buffer = page;
		}
		/* If the buffer is my destination page do the copy now 
		 * i.e. invariant 3 & 1
		 */
		if (buffer == destination) {
			memcpy(phys_to_virt(buffer), phys_to_virt(page), PAGE_SIZE);
			*ptr = buffer | (entry & ~PAGE_MASK);
			buffer = page;
		}
	}
	free_page((unsigned long)phys_to_virt(buffer));
	return 0;
}


static kimage_entry_t *kimage_dst_conflict(
	struct kimage *image, unsigned long page, kimage_entry_t *limit)
{
	kimage_entry_t *ptr, entry;
	unsigned long destination = 0;
	for_each_kimage_entry(image, ptr, entry) {
		if (ptr == limit) {
			return 0;
		}
		else if (entry & IND_DESTINATION) {
			destination = entry & PAGE_MASK;
		}
		else if (entry & IND_SOURCE) {
			if (page == destination) {
				return ptr;
			}
			destination += PAGE_SIZE;
		}
	}
	return 0;
}


static kimage_entry_t *kimage_src_conflict(
	struct kimage *image, unsigned long destination, kimage_entry_t *limit)
{
	kimage_entry_t *ptr, entry;
	for_each_kimage_entry(image, ptr, entry) {
		unsigned long page;
		if (ptr == limit) {
			return 0;
		}
		else if (entry & IND_DESTINATION) {
			/* nop */
		}
		else if (entry & IND_DONE) {
			/* nop */
		}
		else {
			/* SOURCE & INDIRECTION */
			page = entry & PAGE_MASK;
			if (page == destination) {
				return ptr;
			}
		}
	}
	return 0;
}





Having had time to digest the idea of starting a new kernel on panic
I can now make some observations and what I believe it would take to
make it as robust as possible.

- On panic because random pieces of the kernel may be broken we want
  to use as little of the kernel as possible.  

- Therefore machine_kexec should not allocate any memory, and as
  quickly as possible it should transition to the new kernel

- So a new page table should be sitting around with the new kernel
  already mapped, and likewise other important tables like the
  gdt, and the idt, should be pre-allocated.

- Then machine_kexec can just switch stacks, page tables, and other
  machine dependent tables and jump to the new kernel.

- The load stage needs to load everything at the physical location it
  will initially run at.  This would likely need support from rmap.

- The load stage needs to preallocate page tables and buffers.

- The load stage would likely work easiest by either requiring a mem=xxx
  line, reserving some of physical memory for the new kernel.  Or
  alternatively using some rmap support to clear out a swath of
  physical memory the new kernel can be loaded into.  

- The new kernel loaded on panic must know about the previous kernel,
  and have various restrictions because of that.


Supporting a kernel loaded from a normal environment is a rather
different problem.  

- It cannot be loaded at it's run location (The current kernel is
  sitting there).

- It should not need to know about the previously executing kernel.

- Work can be done in machine_kexec to allocate memory so everything
  does not need to be pre allocated.

- I can safely use multiple calls to the page allocator instead of
  needing a special mechanism to allocate memory.



And now I go back to the silly exercise of factoring my code so the
new kernel can be kept in locked kernel memory, instead of in a file
while the shutdown scripts are run.

Unless the linux kernel is modified to copy itself to the top of
physical memory when it loads I have trouble seeing how any of this
will help make the panic case easier to implement.

Eric

