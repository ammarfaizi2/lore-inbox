Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131527AbRAXTbv>; Wed, 24 Jan 2001 14:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbRAXTbb>; Wed, 24 Jan 2001 14:31:31 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:6480 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129847AbRAXTbP>;
	Wed, 24 Jan 2001 14:31:15 -0500
Message-ID: <3A6F2D6A.107@valinux.com>
Date: Wed, 24 Jan 2001 12:30:50 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux MM mailing list <linux-mm@kvack.org>
Subject: Re: Page Attribute Table (PAT) support?
In-Reply-To: <20010124174824Z129401-18594+948@vger.kernel.org> <20010124185046Z131368-18595+642@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> ** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Wed, 24 Jan
> 2001 11:45:43 -0700
> 
> 
> 
>> I'm actually writing support for the PAT as we speak.  I already have 
>> working code for PAT setup.  Just having a parameter for ioremap is not 
>> enough, unfortunately.  According to the Intel Architecture Software 
>> Developer's Manual we have to remove all mappings of the page that are 
>> cached.  Only then can they be mapped with per page write combining.  I 
>> should have working code by the 2.5.x timeframe.  I can also discuss the 
>> planned interface if anyone is interested.
> 
> 
> I'm interested.  Would it be possible to port this support to 2.2, or would
> that be too much work?

Its most likely that it will be 2.5.x only for awhile.  I'm not sure at 
this point if it will make it into 2.4.x, much less 2.2.x.

Basically the high level interface will be a several allocation routines 
which handle the cache/remapping issues for you.  They will allocate 
groups of pages at once (to minimize smp cache flush issues.)

Let me give fair warning this is rough writeup of provided interfaces. 
I'm still not completely done with the design, and it might go through 
several iterations before I'm done with it.  There is no plan to provide 
a generic user land interface for these functions.

Here is some function prototypes:

extern int pat_allow_page_write_combine(void);

	This function is called by someone wanting to use the write combine 
allocation routines.  If it returns 1, per page write combining is 
available.


extern struct page_list *pat_wrtcomb_alloc_page_list(int gfp_mask,
	unsigned long order,
	int num_pages);

	An allocation routine which allocates a group of write combined pages.

extern struct virtual_page_list *pat_wrtcomb_vmalloc_page_list(
	int gfp_mask,
	int num_pages);

	An allocation routine which allocates a group of write combined pages and 
maps them contiguously in kernel virtual memory.

extern void pat_wrtcomb_free_page_list(struct page_list *list);
extern void pat_wrtcomb_vfree_page_list(struct virtual_page_list *list);
	The corresponding free routines.


The following functions would be provided for changing a 4mb mapping to 
the individual pte's, and vice versa.


extern int convert_4mb_page_to_individual(unsigned long address);
	This function would test to see if the page address given is mapped 
through a 4mb page in the kernel page tables.  If it is, ever address 
described by this 4mb page will get converted to individual pte entries.

extern int convert_individual_to_4mb_page(unsigned long address);
	This does the opposite of the above function when all pages in a range 
have the same page protection.

These functions are in turn supported by the following page list 
routines, this is the only part which would be arch-independant:
struct page_list {
         unsigned long   *pages;
         int             num_pages;
         unsigned long   order;
};

struct virtual_page_list {
         struct page_list        *list;
         void                    *addr;
};

extern struct page_list *allocate_page_list(int gfp_mask,
                                             unsigned long order,
                                             int num_pages);

extern struct virtual_page_list *vmalloc_page_list(unsigned long size,
                                                    int gfp_mask,
                                                    pgprot_t prot);

	These functions allocate a page_list or a page_list mapped into kernel 
virtual memory.

extern void free_page_list(struct page_list *list);
extern void vfree_page_list(struct virtual_page_list *list);
	The corresponding free routines.



-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
