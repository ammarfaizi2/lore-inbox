Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269942AbRHEKvA>; Sun, 5 Aug 2001 06:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269941AbRHEKuw>; Sun, 5 Aug 2001 06:50:52 -0400
Received: from [199.203.76.13] ([199.203.76.13]:30017 "EHLO
	linux.optibase.co.il") by vger.kernel.org with ESMTP
	id <S269940AbRHEKuh>; Sun, 5 Aug 2001 06:50:37 -0400
Message-ID: <3B6D2539.3060906@optibase.com>
Date: Sun, 05 Aug 2001 13:51:37 +0300
From: Constantine Gavrilov <const-g@optibase.com>
Organization: Optibase
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.6-ac5customSMP i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: middelink@polyware.nl
CC: linux Kernel <linux-kernel@vger.kernel.org>
Subject: Use kernel module instead Big Physical Area patch
Content-Type: multipart/mixed;
 boundary="------------020008010307050105080607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020008010307050105080607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I wrote a small kernel module that defines and exports bfree() and 
bmalloc() functions. The idea is to use this kernel module as a 
replacement for big physcial area kernel patch.

For example, zoran kernel driver relies on the big physical area API for 
v4l (used for video-in-a-window) to work. While the driver will compile 
and load with a non-patched kernel, v4l will not work reliably without 
big physical area support since the chip needs about 2megs of contiguous 
memory to display in a window. This means one really has to use a 
patched kernel.

This module removes this requirement and allows v4l to work reliably 
with a non-patched kernel. The idea is to load the module from initrd or 
right after boot. I have used __get_free_pages() and mem_map_reserve() 
to pre-allocate the memory.
I have left the user-mode code that I used to debug allocation and 
garbage collection.  Compiled into a user-space program, the code will 
allocate/free random chunks from a pre-allocated space and print out the 
used list.

Comments?

Questions:
1) On  a 256 MB machine, I was able to pre-allocate 512 pages using 
__get_free_pages(...,get_order(size)). It is enough for one card, but 
not for more. Any ideas on how to pre-allocate more?
2) __get_free_pages(...,get_order(size)) can be used to pre-allocate 2^n 
contiguous pages (2,4,16,...512, ...., 1024). Can I use something else 
from a kernel module to request a number that is not  2^n  (say 750)?

-- 
----------------------------------------
Constantine Gavrilov
Linux Leader
Optibase Ltd
7 Shenkar St, Herzliya 46120, Israel
Phone: (972-9)-970-9140
Fax:   (972-9)-958-6099
----------------------------------------


--------------020008010307050105080607
Content-Type: text/plain;
 name="memreserve.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memreserve.c"

/***************************************************************************
                          memreserve.c  -  description
                             -------------------
    begin                : Tue Jul 31 2001
    copyright            : (C) 2001 by Optibase Ltd
    email                : linux@optibase.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef __KERNEL__
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <errno.h>

/* module stuff */
#define MOD_INC_USE_COUNT
#define MOD_DEC_USE_COUNT
#define EXPORT_SYMBOL(x)
#define MODULE_PARM(x,y)
#define GFP_USER
#define GFP_DMA

/* memory management stuff */
#define kmalloc(x,y) (malloc(x))
#define kfree(x) (free(x))
#define __get_free_pages(x,y) (malloc(y))
#define free_pages(x, y) (free((void *)x))
#define mem_map_reserve(x) (printf("reserve print: 0x%08lx\n",x))
#define mem_map_unreserve(x) (printf("unreserve print: 0x%08lx\n",x))
#define virt_to_page(x) (x)
#define phys_to_virt(x) (x)
#define get_order(x) (x)
/* from asm/page.h */
#define PAGE_SHIFT  12
#define PAGE_SIZE   (1UL << PAGE_SHIFT)
#define PAGE_MASK   (~(PAGE_SIZE-1))
#define PAGE_ALIGN(addr)  (((addr)+PAGE_SIZE-1)&PAGE_MASK)

/* lock stuff */
#define write_lock(x) (pthread_mutex_lock(x))
#define write_unlock(x) (pthread_mutex_unlock(x))
#define RW_LOCK_UNLOCKED PTHREAD_MUTEX_INITIALIZER
#define rwlock_t pthread_mutex_t

/* printk stuff */
#define printk printf
#define KERN_WARNING
#define KERN_INFO
#define KERN_ERR
#define KERN_DEBUG

#else
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/errno.h>
#include <asm/page.h>
#include <asm/io.h>
#include <linux/mm.h>
#include <linux/wrapper.h>
#endif

void bfree(void*, unsigned long);
void* bmalloc(unsigned long);

EXPORT_SYMBOL(bfree);
EXPORT_SYMBOL(bmalloc);

int reserve;
static unsigned long reserve_start;

MODULE_PARM(reserve, "i");

struct reserve_list {
	unsigned long mem;
	unsigned long size;
	struct reserve_list *next;
};

struct reserve_list *used_list=NULL;

static rwlock_t alloc_ops=RW_LOCK_UNLOCKED;

#ifdef __KERNEL__
int init_module(void)
{
	unsigned long adr;
	unsigned long size;
#else
int init_module(int x)
{
	unsigned long adr;
	unsigned long size;

	reserve=x;
#endif
		
	if (!reserve) {
		printk(KERN_ERR "memreserve: Supply a positive reserve param\n");
		return -EINVAL;
	}
	size=reserve*PAGE_SIZE;
	reserve_start = (unsigned long)__get_free_pages(GFP_USER|GFP_DMA,get_order(size));
	if (reserve_start) {
		adr = reserve_start;
		while (size > 0) {
			mem_map_reserve(virt_to_page(phys_to_virt(adr)));
			adr += PAGE_SIZE;
			size -= PAGE_SIZE;
		}
	}
	else {
		printk(KERN_ERR "memreserve: Cannot allocate contiguous memory of %lu bytes\n", size);
		return -EINVAL;
	}
	printk(KERN_INFO "memreserve: Allocated contiguous memory of %lu bytes\n", reserve*PAGE_SIZE);
	return 0;
}

void cleanup_module(void)
{
	unsigned long adr;
	unsigned long size;
	
	if(used_list != NULL) {
		printk(KERN_ERR "memreserve: Memory leak somewhere -- more than zero member in the used list\n");
		printk(KERN_ERR "memreserve: Check your usage count\n");
		printk(KERN_ERR "memreserve: Will not free memory\n");
		return;
	}
	if (reserve_start) {
		adr = reserve_start;
		size = reserve * PAGE_SIZE;
		while (size > 0) {
			mem_map_unreserve(virt_to_page(phys_to_virt(adr)));
			adr += PAGE_SIZE;
			size -= PAGE_SIZE;
		}
		free_pages(reserve_start,get_order(reserve * PAGE_SIZE));
	}
}

void* bmalloc(unsigned long req_size)
{
	/*we need a lock here against simultaneous entry*/

	struct reserve_list *list, *newmember, *prevmember;
	unsigned long prevaddr, size;
	
	write_lock(&alloc_ops);
	size=PAGE_ALIGN(req_size);
	prevaddr=reserve_start;
	prevmember=NULL;
	
	printk(KERN_DEBUG "memreserve: Rounded requested size %lu (0x%08lx) to 0x%08lx (%lu pages)\n", req_size, req_size,size, size/PAGE_SIZE);
	for(list=used_list; list != NULL; list=list->next)
	{
		if( (list->mem - prevaddr) >= size) {
			newmember=(struct reserve_list *)kmalloc(sizeof(struct reserve_list), GFP_USER);
			if (!newmember) {
				printk(KERN_ERR "memreserve: Out of memory\n");
				write_unlock(&alloc_ops);
				return NULL;
			}
			newmember->next=list;
			newmember->mem=prevaddr;
			newmember->size=size;
			if(prevmember != NULL)
				prevmember->next=newmember;
			else
				used_list=newmember;
			MOD_INC_USE_COUNT;
			write_unlock(&alloc_ops);
			return (void *)prevaddr; /* we got our address */
		}
		prevmember=list;
		prevaddr=list->mem+list->size;
	}

   	/* list is NULL here; this code both works for both first and the last list member */
   	if(size <= reserve_start + (PAGE_SIZE * reserve) - prevaddr) {
   		newmember=(struct reserve_list *)kmalloc(sizeof(struct reserve_list), GFP_USER);
   		if (!newmember) {
   			printk(KERN_ERR "memreserve: Out of memory\n");
   			write_unlock(&alloc_ops);
   			return NULL;
   		}
   		newmember->mem=prevaddr;
   		newmember->size=size;
   		if(prevmember == NULL) /* this is the first member */
   			used_list=newmember;
   		else /* this is the last member */
   			prevmember->next=newmember;
		newmember->next=NULL;
   		MOD_INC_USE_COUNT;
   		write_unlock(&alloc_ops);
   		return (void *)prevaddr; /* we got our address */
   	}
   	else
   		printk(KERN_WARNING "memreserve: Could not find big enough region in the free list\n");
   	write_unlock(&alloc_ops);
	return NULL;
}

void bfree(void *mem, unsigned long req_size)
{
	/*we need a lock here against simultaneous entry*/
	struct reserve_list *list, *prevaddr;
	unsigned long size;
	
	write_lock(&alloc_ops);
	size=PAGE_ALIGN(req_size);
	prevaddr=NULL;
	
	for(list=used_list; list != NULL; list=list->next) {
		if(list->mem == (unsigned long)mem && list->size == size) {
			if(prevaddr == NULL)
				used_list=list->next;
			else
				prevaddr->next=list->next;
			kfree(list);
			MOD_DEC_USE_COUNT;
			write_unlock(&alloc_ops);
			return;
		}
		prevaddr=list;
	}
	printk(KERN_WARNING "memreserve: Someone requested illegal deallocation\n");
	write_unlock(&alloc_ops);
}

void print_used_list(void)
{
	/*we need a lock here against simultaneous entry*/
	struct reserve_list *list;
	
	write_lock(&alloc_ops);
	printk(KERN_INFO "Reserve start is 0x%08lx, reserve size is 0x%08lx\n", reserve_start, reserve*PAGE_SIZE);
	for(list=used_list; list != NULL; list=list->next) {
		printk(KERN_INFO "memreserve: Address is 0x%08lx (%lu pages), size is 0x%08lx (%lu pages)\n", list->mem, list->mem/PAGE_SIZE, list->size, list->size/PAGE_SIZE);
	}
	write_unlock(&alloc_ops);
}


#ifndef __KERNEL__
int main()
{
	int n=0;
	int i=0;
	int k;
	struct reserve_list *list;
	unsigned long choose_size(unsigned long);
	int choose_index(int);
	int choose_bool(void);
	

#define MAX_ALLOC 100
	
	if(init_module(MAX_ALLOC) != 0) {
		printf("Could not get memory\n");
		exit(1);
	}
	while(n>=0) {
		if(n<=3) {
			if (bmalloc(choose_size(MAX_ALLOC)/10) != NULL)
				n++;
		}
		else {
			if(choose_bool() == 0) {
				if (bmalloc(choose_size(MAX_ALLOC)/10) != NULL)
					n++;
			}
			else {
				i=choose_index(n);
				list=used_list;
				for(k=0;k<(i-1);k++)
					list=list->next;
				printf("Free index %d\n", i);
				bfree((void *)list->mem, list->size);
				n--;
			}
		}
		print_used_list(); getchar();
	}
	cleanup_module();
	return 0;
}

unsigned long choose_size(unsigned long MAX_SIZE)
{
	double pos;
	
	pos=((double)MAX_SIZE*(double)PAGE_SIZE*(double)random())/(double)(RAND_MAX+1.0);
	return 1+(unsigned long) pos;
}

int choose_index(int MAX_INDEX)
{
	double pos;
	
	pos=((double)MAX_INDEX*(double)random())/(double)(RAND_MAX+1.0);
	return 1+(int) pos;
}

int choose_bool(void)
{
	long pos;
	
	pos=random();
	
	if(pos <= (RAND_MAX/2))
		return 0;
	else
		return 1;
}
	
#endif

--------------020008010307050105080607--

