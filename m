Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290657AbSBYPBc>; Mon, 25 Feb 2002 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290752AbSBYPBY>; Mon, 25 Feb 2002 10:01:24 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:9120 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290657AbSBYPBJ>;
	Mon, 25 Feb 2002 10:01:09 -0500
Date: Mon, 25 Feb 2002 10:00:25 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
Message-ID: <20020225100025.A1163@elinux01.watson.ibm.com>
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Sat, Feb 23, 2002 at 02:47:25PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty, since I supplied one of those packages available under lse.sourceforge.net
let me make some comments.

(a) why do you need to pin. I simply use the user level address (vaddr)  
    and hash with the <mm,vaddr> to obtain the internal object.
    This also gives me full protection through the general vmm mechanisms.
(b) I like the idea of mmap or shmat with special flags better than going 
    through a device driver.
    Let's make this a real extension rather than going through a device 
    interface. i.e. expand the sys call interface
(c) creation can be done on demand, that's what I do. If you never have 
    to synchronize through the kernel than you don't create the objects. 
    There should be an option to force explicite creation if desired.
(d) The kernel should simply provide waiting and wakeup functionality and 
    the bean counting should be done in user space. There is no need to 
    pin or crossmap.
(e) I really like to see multiple reader/single writer locks as well. I 
    implemented these 
(f) I also implemented convoy avoidance locks, spinning versions of 
    user semaphores.  All over the same simple interface.
    ulocks_wait(read_or_write) and ulocks_signal(read_or_write, num_to_wake_up).
    Ofcourse to cut down on the interface a single system call is enough.
(g) I have an extensive test program and regression test <ulockflex>
    that exercises the hell out of the userlevel approach. 
 
On Sat, Feb 23, 2002 at 02:47:25PM +1100, Rusty Russell wrote:
> Hi all,
> 
> 	There are several lightweight userspace semaphore patches
> flying around, and I'll really like to meld into one good solution we
> can include in 2.5.
> 
> 	This version uses wli's multiplicitive hashing.  And it has
> these yummy properties:
> 
> 1) Interface is: open /dev/usem, pread, pwrite.
> 2) No initialization required: just tell the kernel "this is a
>    semaphore: down/up it".
> 3) No in-kernel arch-specific code.
> 4) Locks in mmaped are persistent (including across reboots!).
> 
> Modifications for tdb to use this interface were pretty trivial (too
> bad it proved no faster than fcntl locks, more investigation needed).
> 
> User library and kernel patch attached,
> Rusty.
> PS. map_usem() is ugly: is there a better way to pin pages?
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/drivers/char/Config.help working-2.5.5-usem/drivers/char/Config.help
> --- linux-2.5.5/drivers/char/Config.help	Thu Jan 31 08:17:08 2002
> +++ working-2.5.5-usem/drivers/char/Config.help	Thu Feb 21 12:33:46 2002
> @@ -1153,3 +1153,9 @@
>  
>    Not sure? It's safe to say N.
>  
> +CONFIG_USERSEM
> +  Say Y here to have support for fast userspace semaphores, or M to
> +  compile it as a module called usersem.o.
> +
> +  If unsure, say Y: everyone else will and you wouldn't want to miss
> +  out.
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/drivers/char/Config.in working-2.5.5-usem/drivers/char/Config.in
> --- linux-2.5.5/drivers/char/Config.in	Mon Feb 11 15:17:18 2002
> +++ working-2.5.5-usem/drivers/char/Config.in	Thu Feb 21 12:33:46 2002
> @@ -227,4 +227,5 @@
>     tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
>  fi
>  
> +dep_tristate 'Fast userspace semaphore support (EXPERIMENTAL)' CONFIG_USERSEM $CONFIG_EXPERIMENTAL
>  endmenu
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/drivers/char/Makefile working-2.5.5-usem/drivers/char/Makefile
> --- linux-2.5.5/drivers/char/Makefile	Mon Feb 11 15:17:18 2002
> +++ working-2.5.5-usem/drivers/char/Makefile	Thu Feb 21 12:33:46 2002
> @@ -229,6 +229,7 @@
>  obj-$(CONFIG_SH_WDT) += shwdt.o
>  obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
>  obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
> +obj-$(CONFIG_USERSEM) += usersem.o
>  
>  subdir-$(CONFIG_MWAVE) += mwave
>  ifeq ($(CONFIG_MWAVE),y)
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/drivers/char/usersem.c working-2.5.5-usem/drivers/char/usersem.c
> --- linux-2.5.5/drivers/char/usersem.c	Thu Jan  1 10:00:00 1970
> +++ working-2.5.5-usem/drivers/char/usersem.c	Sat Feb 23 14:18:28 2002
> @@ -0,0 +1,244 @@
> +/*
> + *  User-accessible semaphores.
> + *  (C) Rusty Russell, IBM 2002
> + *
> + *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
> + *  enough at me, Linus for the original (flawed) idea, Matthew
> + *  Kirkwood for proof-of-concept implementation.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +#include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <linux/wait.h>
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/hash.h>
> +#include <linux/module.h>
> +#include <linux/devfs_fs_kernel.h>
> +#include <asm/uaccess.h>
> +
> +struct usem
> +{
> +	atomic_t count;
> +	unsigned int sleepers;
> +};
> +
> +static spinlock_t usem_lock = SPIN_LOCK_UNLOCKED;
> +
> +/* FIXME: This may be way too small. --RR */
> +#define USEM_HASHBITS 6
> +/* The key for the hash is the address + index + offset within page */
> +static wait_queue_head_t usem_waits[1<<USEM_HASHBITS];
> +
> +static inline wait_queue_head_t *hash_usem(const struct page *page,
> +					   unsigned long offset)
> +{
> +	unsigned long h;
> +
> +	/* Hash based on inode number (if page is backed), has chance
> +	   of persistence across reboots on sane filesystems. */
> +	if (!page->mapping) h = (unsigned long)page;
> +	else h = page->mapping->host->i_ino;
> +
> +	return &usem_waits[hash_long(h + page->index + offset, USEM_HASHBITS)];
> +}
> +
> +/* Must be holding mmap_sem */
> +static inline int pin_page(unsigned long upage_start, struct page **page)
> +{
> +	return get_user_pages(current, current->mm, upage_start,
> +			      1 /* one page */,
> +			      1 /* writable */,
> +			      0 /* don't force */,
> +			      page,
> +			      NULL /* don't return vmas */);
> +}
> +
> +/* Get kernel address of the two variables, and pin them in. */
> +static int map_usem(unsigned long uaddr,
> +		    atomic_t **count,
> +		    unsigned int **sleepers,
> +		    struct page *pages[2])
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned int num_pages;
> +	unsigned long upage_start;
> +	int err;
> +
> +	upage_start = (uaddr & PAGE_MASK);
> +
> +	/* Most times, whole thing on one page */
> +	if (((uaddr + sizeof(struct usem) - 1) & PAGE_MASK) == upage_start) {
> +		num_pages = 1;
> +		pages[1] = NULL;
> +	} else {
> +		num_pages = 2;
> +		/* ... otherwise, page boundary must be between them */
> +		if ((uaddr + offsetof(struct usem, sleepers))%PAGE_SIZE != 0)
> +			return -EINVAL;
> +	}
> +
> +	down_read(&mm->mmap_sem);
> +	/* Pin first page */
> +	err = pin_page(upage_start, &pages[0]);
> +	if (num_pages == 2 && err == 1) {
> +		/* Pin second page */
> +		err = pin_page(upage_start + PAGE_SIZE, &pages[1]);
> +		if (err < 0)
> +			put_page(pages[0]);
> +	}
> +	up_read(&mm->mmap_sem);
> +	if (err < 0)
> +		return err;
> +
> +	/* Set up pointers into pinned page(s) */
> +	*count = page_address(pages[0]) + (uaddr%PAGE_SIZE);
> +	uaddr += offsetof(struct usem, sleepers);
> +	if (num_pages == 1)
> +		*sleepers = page_address(pages[0]) + (uaddr%PAGE_SIZE);
> +	else /* sleepers is on second page */
> +		*sleepers = page_address(pages[1]) + (uaddr%PAGE_SIZE);
> +	return 0;
> +}
> +
> +/* Unpin the variables */
> +static void unmap_usem(struct page *pages[2])
> +{
> +	put_page(pages[0]);
> +	if (pages[1]) put_page(pages[1]);
> +}
> +
> +/* Stolen from arch/i386/kernel/semaphore.c. */
> +static int __usem_down(wait_queue_head_t *wq,
> +		       atomic_t *count,
> +		       unsigned int *sleepers)
> +{
> +	int retval = 0;
> +	DECLARE_WAITQUEUE(wait, current);
> +
> +	current->state = TASK_INTERRUPTIBLE;
> +	add_wait_queue_exclusive(wq, &wait);
> +
> +	spin_lock(&usem_lock);
> +	(*sleepers)++;
> +	for (;;) {
> +		unsigned int sl = *sleepers;
> +
> +		/* With signals pending, this turns into the trylock
> +		 * failure case - we won't be sleeping, and we can't
> +		 * get the lock as it has contention. Just correct the
> +		 * count and exit.  */
> +		if (signal_pending(current)) {
> +			retval = -EINTR;
> +			*sleepers = 0;
> +			atomic_add(sl, count);
> +			break;
> +		}
> +
> +		/* Add "everybody else" into it. They aren't playing,
> +		 * because we own the spinlock. The "-1" is because
> +		 * we're still hoping to get the lock.  */
> +		if (!atomic_add_negative(sl - 1, count)) {
> +			*sleepers = 0;
> +			break;
> +		}
> +		*sleepers = 1;	/* us - see -1 above */
> +		spin_unlock(&usem_lock);
> +
> +		schedule();
> +		current->state = TASK_INTERRUPTIBLE;
> +		spin_lock(&usem_lock);
> +	}
> +	spin_unlock(&usem_lock);
> +	current->state = TASK_RUNNING;
> +	remove_wait_queue(wq, &wait);
> +
> +	/* Wake up everyone else. */
> +	wake_up(wq);
> +	return retval;
> +}
> +
> +/* aka "down" */
> +static ssize_t usem_read(struct file *f, char *u, size_t c, loff_t *ppos)
> +{
> +	struct page *pages[2];
> +	wait_queue_head_t *wqhead;
> +	atomic_t *count;
> +	unsigned int *sleepers;
> +	int ret;
> +
> +	/* Must not vanish underneath us. */
> +	ret = map_usem(*ppos, &count, &sleepers, pages);
> +	if (ret < 0)
> +		return ret;
> +	wqhead = hash_usem(pages[0], *ppos % PAGE_SIZE);
> +	ret = __usem_down(wqhead, count, sleepers);
> +	unmap_usem(pages);
> +	return 0;
> +}
> +	
> +
> +/* aka "up" */
> +static ssize_t
> +usem_write(struct file *f, const char *u, size_t c, loff_t *ppos)
> +{
> +	struct page *pages[2];
> +	wait_queue_head_t *wqhead;
> +	atomic_t *count;
> +	unsigned int *sleepers;
> +	int ret;
> +
> +	/* Must not vanish underneath us: even if they do an up
> +           without a down (userspace bug). */
> +	ret = map_usem(*ppos, &count, &sleepers, pages);
> +	if (ret < 0)
> +		return ret;
> +	wqhead = hash_usem(pages[0], *ppos % PAGE_SIZE);
> +	wake_up(wqhead);
> +	unmap_usem(pages);
> +	return ret;
> +}
> +
> +static struct file_operations usem_fops = {
> +	owner:		THIS_MODULE,
> +	read:		usem_read,
> +	write:		usem_write,
> +};
> +
> +static int usem_major;
> +static devfs_handle_t usem_dev;
> +
> +int __init init(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(usem_waits); i++)
> +		init_waitqueue_head(&usem_waits[i]);
> +	usem_major = devfs_register_chrdev(0, "usem", &usem_fops);
> +	usem_dev = devfs_register(NULL, "usem", DEVFS_FL_NONE, usem_major,
> +				  0, S_IFCHR | 0666, &usem_fops, NULL);
> +	return 0;
> +}
> +
> +void __exit fini(void)
> +{
> +	devfs_unregister(usem_dev);
> +	devfs_unregister_chrdev(usem_major, "usem");
> +}
> +
> +MODULE_LICENSE("GPL");
> +module_init(init);
> +module_exit(fini);
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/include/linux/hash.h working-2.5.5-usem/include/linux/hash.h
> --- linux-2.5.5/include/linux/hash.h	Thu Jan  1 10:00:00 1970
> +++ working-2.5.5-usem/include/linux/hash.h	Thu Feb 21 12:33:46 2002
> @@ -0,0 +1,58 @@
> +#ifndef _LINUX_HASH_H
> +#define _LINUX_HASH_H
> +/* Fast hashing routine for a long.
> +   (C) 2002 William Lee Irwin III, IBM */
> +
> +/*
> + * Knuth recommends primes in approximately golden ratio to the maximum
> + * integer representable by a machine word for multiplicative hashing.
> + * Chuck Lever verified the effectiveness of this technique:
> + * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
> + *
> + * These primes are chosen to be bit-sparse, that is operations on
> + * them can use shifts and additions instead of multiplications for
> + * machines where multiplications are slow.
> + */
> +#if BITS_PER_LONG == 32
> +/* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
> +#define GOLDEN_RATIO_PRIME 0x9e370001UL
> +#elif BITS_PER_LONG == 64
> +/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
> +#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
> +#else
> +#error Define GOLDEN_RATIO_PRIME for your wordsize.
> +#endif
> +
> +static inline unsigned long hash_long(unsigned long val, unsigned int bits)
> +{
> +	unsigned long hash = val;
> +
> +#if BITS_PER_LONG == 64
> +	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
> +	unsigned long n = hash;
> +	n <<= 18;
> +	hash -= n;
> +	n <<= 33;
> +	hash -= n;
> +	n <<= 3;
> +	hash += n;
> +	n <<= 3;
> +	hash -= n;
> +	n <<= 4;
> +	hash += n;
> +	n <<= 2;
> +	hash += n;
> +#else
> +	/* On some cpus multiply is faster, on others gcc will do shifts */
> +	hash *= GOLDEN_RATIO_PRIME;
> +#endif
> +
> +	/* High bits are more random, so use them. */
> +	return hash >> (BITS_PER_LONG - bits);
> +}
> +	
> +static inline unsigned long hash_ptr(void *ptr, unsigned int bits)
> +{
> +	return hash_long((unsigned long)ptr, bits);
> +}
> +#endif /* _LINUX_HASH_H */
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/include/linux/mmzone.h working-2.5.5-usem/include/linux/mmzone.h
> --- linux-2.5.5/include/linux/mmzone.h	Wed Feb 20 16:07:17 2002
> +++ working-2.5.5-usem/include/linux/mmzone.h	Thu Feb 21 12:46:30 2002
> @@ -51,8 +51,7 @@
>  	/*
>  	 * wait_table		-- the array holding the hash table
>  	 * wait_table_size	-- the size of the hash table array
> -	 * wait_table_shift	-- wait_table_size
> -	 * 				== BITS_PER_LONG (1 << wait_table_bits)
> +	 * wait_table_bits	-- wait_table_size == (1 << wait_table_bits)
>  	 *
>  	 * The purpose of all these is to keep track of the people
>  	 * waiting for a page to become available and make them
> @@ -75,7 +74,7 @@
>  	 */
>  	wait_queue_head_t	* wait_table;
>  	unsigned long		wait_table_size;
> -	unsigned long		wait_table_shift;
> +	unsigned long		wait_table_bits;
>  
>  	/*
>  	 * Discontig memory support fields.
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/kernel/ksyms.c working-2.5.5-usem/kernel/ksyms.c
> --- linux-2.5.5/kernel/ksyms.c	Wed Feb 20 16:07:17 2002
> +++ working-2.5.5-usem/kernel/ksyms.c	Thu Feb 21 16:48:59 2002
> @@ -86,6 +86,7 @@
>  EXPORT_SYMBOL(do_munmap);
>  EXPORT_SYMBOL(do_brk);
>  EXPORT_SYMBOL(exit_mm);
> +EXPORT_SYMBOL(get_user_pages);
>  
>  /* internal kernel memory management */
>  EXPORT_SYMBOL(_alloc_pages);
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/mm/filemap.c working-2.5.5-usem/mm/filemap.c
> --- linux-2.5.5/mm/filemap.c	Wed Feb 20 16:07:17 2002
> +++ working-2.5.5-usem/mm/filemap.c	Thu Feb 21 13:01:02 2002
> @@ -25,6 +25,7 @@
>  #include <linux/iobuf.h>
>  #include <linux/compiler.h>
>  #include <linux/fs.h>
> +#include <linux/hash.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/uaccess.h>
> @@ -773,32 +774,8 @@
>  static inline wait_queue_head_t *page_waitqueue(struct page *page)
>  {
>  	const zone_t *zone = page_zone(page);
> -	wait_queue_head_t *wait = zone->wait_table;
> -	unsigned long hash = (unsigned long)page;
>  
> -#if BITS_PER_LONG == 64
> -	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
> -	unsigned long n = hash;
> -	n <<= 18;
> -	hash -= n;
> -	n <<= 33;
> -	hash -= n;
> -	n <<= 3;
> -	hash += n;
> -	n <<= 3;
> -	hash -= n;
> -	n <<= 4;
> -	hash += n;
> -	n <<= 2;
> -	hash += n;
> -#else
> -	/* On some cpus multiply is faster, on others gcc will do shifts */
> -	hash *= GOLDEN_RATIO_PRIME;
> -#endif
> -
> -	hash >>= zone->wait_table_shift;
> -
> -	return &wait[hash];
> +	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
>  }
>  
>  /* 
> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/mm/page_alloc.c working-2.5.5-usem/mm/page_alloc.c
> --- linux-2.5.5/mm/page_alloc.c	Wed Feb 20 16:07:17 2002
> +++ working-2.5.5-usem/mm/page_alloc.c	Thu Feb 21 12:33:46 2002
> @@ -776,8 +776,8 @@
>  		 * per zone.
>  		 */
>  		zone->wait_table_size = wait_table_size(size);
> -		zone->wait_table_shift =
> -			BITS_PER_LONG - wait_table_bits(zone->wait_table_size);
> +		zone->wait_table_bits =
> +			wait_table_bits(zone->wait_table_size);
>  		zone->wait_table = (wait_queue_head_t *)
>  			alloc_bootmem_node(pgdat, zone->wait_table_size
>  						* sizeof(wait_queue_head_t));
> 


