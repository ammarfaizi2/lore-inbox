Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293086AbSBWDsJ>; Fri, 22 Feb 2002 22:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293087AbSBWDry>; Fri, 22 Feb 2002 22:47:54 -0500
Received: from [202.135.142.194] ([202.135.142.194]:45585 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293085AbSBWDrd>; Fri, 22 Feb 2002 22:47:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Lightweight userspace semaphores...
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <2863.1014435501.0@rustcorp.com.au>
Date: Sat, 23 Feb 2002 14:47:25 +1100
Message-Id: <E16eT9h-0000kE-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2863.1014435501.1@rustcorp.com.au>

Hi all,

	There are several lightweight userspace semaphore patches
flying around, and I'll really like to meld into one good solution we
can include in 2.5.

	This version uses wli's multiplicitive hashing.  And it has
these yummy properties:

1) Interface is: open /dev/usem, pread, pwrite.
2) No initialization required: just tell the kernel "this is a
   semaphore: down/up it".
3) No in-kernel arch-specific code.
4) Locks in mmaped are persistent (including across reboots!).

Modifications for tdb to use this interface were pretty trivial (too
bad it proved no faster than fcntl locks, more investigation needed).

User library and kernel patch attached,
Rusty.
PS. map_usem() is ugly: is there a better way to pin pages?
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/drivers/char/Config.help working-2.5.5-usem/drivers/char/Config.help
--- linux-2.5.5/drivers/char/Config.help	Thu Jan 31 08:17:08 2002
+++ working-2.5.5-usem/drivers/char/Config.help	Thu Feb 21 12:33:46 2002
@@ -1153,3 +1153,9 @@
 
   Not sure? It's safe to say N.
 
+CONFIG_USERSEM
+  Say Y here to have support for fast userspace semaphores, or M to
+  compile it as a module called usersem.o.
+
+  If unsure, say Y: everyone else will and you wouldn't want to miss
+  out.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/drivers/char/Config.in working-2.5.5-usem/drivers/char/Config.in
--- linux-2.5.5/drivers/char/Config.in	Mon Feb 11 15:17:18 2002
+++ working-2.5.5-usem/drivers/char/Config.in	Thu Feb 21 12:33:46 2002
@@ -227,4 +227,5 @@
    tristate 'ACP Modem (Mwave) support' CONFIG_MWAVE
 fi
 
+dep_tristate 'Fast userspace semaphore support (EXPERIMENTAL)' CONFIG_USERSEM $CONFIG_EXPERIMENTAL
 endmenu
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/drivers/char/Makefile working-2.5.5-usem/drivers/char/Makefile
--- linux-2.5.5/drivers/char/Makefile	Mon Feb 11 15:17:18 2002
+++ working-2.5.5-usem/drivers/char/Makefile	Thu Feb 21 12:33:46 2002
@@ -229,6 +229,7 @@
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+obj-$(CONFIG_USERSEM) += usersem.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/drivers/char/usersem.c working-2.5.5-usem/drivers/char/usersem.c
--- linux-2.5.5/drivers/char/usersem.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.5-usem/drivers/char/usersem.c	Sat Feb 23 14:18:28 2002
@@ -0,0 +1,244 @@
+/*
+ *  User-accessible semaphores.
+ *  (C) Rusty Russell, IBM 2002
+ *
+ *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
+ *  enough at me, Linus for the original (flawed) idea, Matthew
+ *  Kirkwood for proof-of-concept implementation.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/hash.h>
+#include <linux/module.h>
+#include <linux/devfs_fs_kernel.h>
+#include <asm/uaccess.h>
+
+struct usem
+{
+	atomic_t count;
+	unsigned int sleepers;
+};
+
+static spinlock_t usem_lock = SPIN_LOCK_UNLOCKED;
+
+/* FIXME: This may be way too small. --RR */
+#define USEM_HASHBITS 6
+/* The key for the hash is the address + index + offset within page */
+static wait_queue_head_t usem_waits[1<<USEM_HASHBITS];
+
+static inline wait_queue_head_t *hash_usem(const struct page *page,
+					   unsigned long offset)
+{
+	unsigned long h;
+
+	/* Hash based on inode number (if page is backed), has chance
+	   of persistence across reboots on sane filesystems. */
+	if (!page->mapping) h = (unsigned long)page;
+	else h = page->mapping->host->i_ino;
+
+	return &usem_waits[hash_long(h + page->index + offset, USEM_HASHBITS)];
+}
+
+/* Must be holding mmap_sem */
+static inline int pin_page(unsigned long upage_start, struct page **page)
+{
+	return get_user_pages(current, current->mm, upage_start,
+			      1 /* one page */,
+			      1 /* writable */,
+			      0 /* don't force */,
+			      page,
+			      NULL /* don't return vmas */);
+}
+
+/* Get kernel address of the two variables, and pin them in. */
+static int map_usem(unsigned long uaddr,
+		    atomic_t **count,
+		    unsigned int **sleepers,
+		    struct page *pages[2])
+{
+	struct mm_struct *mm = current->mm;
+	unsigned int num_pages;
+	unsigned long upage_start;
+	int err;
+
+	upage_start = (uaddr & PAGE_MASK);
+
+	/* Most times, whole thing on one page */
+	if (((uaddr + sizeof(struct usem) - 1) & PAGE_MASK) == upage_start) {
+		num_pages = 1;
+		pages[1] = NULL;
+	} else {
+		num_pages = 2;
+		/* ... otherwise, page boundary must be between them */
+		if ((uaddr + offsetof(struct usem, sleepers))%PAGE_SIZE != 0)
+			return -EINVAL;
+	}
+
+	down_read(&mm->mmap_sem);
+	/* Pin first page */
+	err = pin_page(upage_start, &pages[0]);
+	if (num_pages == 2 && err == 1) {
+		/* Pin second page */
+		err = pin_page(upage_start + PAGE_SIZE, &pages[1]);
+		if (err < 0)
+			put_page(pages[0]);
+	}
+	up_read(&mm->mmap_sem);
+	if (err < 0)
+		return err;
+
+	/* Set up pointers into pinned page(s) */
+	*count = page_address(pages[0]) + (uaddr%PAGE_SIZE);
+	uaddr += offsetof(struct usem, sleepers);
+	if (num_pages == 1)
+		*sleepers = page_address(pages[0]) + (uaddr%PAGE_SIZE);
+	else /* sleepers is on second page */
+		*sleepers = page_address(pages[1]) + (uaddr%PAGE_SIZE);
+	return 0;
+}
+
+/* Unpin the variables */
+static void unmap_usem(struct page *pages[2])
+{
+	put_page(pages[0]);
+	if (pages[1]) put_page(pages[1]);
+}
+
+/* Stolen from arch/i386/kernel/semaphore.c. */
+static int __usem_down(wait_queue_head_t *wq,
+		       atomic_t *count,
+		       unsigned int *sleepers)
+{
+	int retval = 0;
+	DECLARE_WAITQUEUE(wait, current);
+
+	current->state = TASK_INTERRUPTIBLE;
+	add_wait_queue_exclusive(wq, &wait);
+
+	spin_lock(&usem_lock);
+	(*sleepers)++;
+	for (;;) {
+		unsigned int sl = *sleepers;
+
+		/* With signals pending, this turns into the trylock
+		 * failure case - we won't be sleeping, and we can't
+		 * get the lock as it has contention. Just correct the
+		 * count and exit.  */
+		if (signal_pending(current)) {
+			retval = -EINTR;
+			*sleepers = 0;
+			atomic_add(sl, count);
+			break;
+		}
+
+		/* Add "everybody else" into it. They aren't playing,
+		 * because we own the spinlock. The "-1" is because
+		 * we're still hoping to get the lock.  */
+		if (!atomic_add_negative(sl - 1, count)) {
+			*sleepers = 0;
+			break;
+		}
+		*sleepers = 1;	/* us - see -1 above */
+		spin_unlock(&usem_lock);
+
+		schedule();
+		current->state = TASK_INTERRUPTIBLE;
+		spin_lock(&usem_lock);
+	}
+	spin_unlock(&usem_lock);
+	current->state = TASK_RUNNING;
+	remove_wait_queue(wq, &wait);
+
+	/* Wake up everyone else. */
+	wake_up(wq);
+	return retval;
+}
+
+/* aka "down" */
+static ssize_t usem_read(struct file *f, char *u, size_t c, loff_t *ppos)
+{
+	struct page *pages[2];
+	wait_queue_head_t *wqhead;
+	atomic_t *count;
+	unsigned int *sleepers;
+	int ret;
+
+	/* Must not vanish underneath us. */
+	ret = map_usem(*ppos, &count, &sleepers, pages);
+	if (ret < 0)
+		return ret;
+	wqhead = hash_usem(pages[0], *ppos % PAGE_SIZE);
+	ret = __usem_down(wqhead, count, sleepers);
+	unmap_usem(pages);
+	return 0;
+}
+	
+
+/* aka "up" */
+static ssize_t
+usem_write(struct file *f, const char *u, size_t c, loff_t *ppos)
+{
+	struct page *pages[2];
+	wait_queue_head_t *wqhead;
+	atomic_t *count;
+	unsigned int *sleepers;
+	int ret;
+
+	/* Must not vanish underneath us: even if they do an up
+           without a down (userspace bug). */
+	ret = map_usem(*ppos, &count, &sleepers, pages);
+	if (ret < 0)
+		return ret;
+	wqhead = hash_usem(pages[0], *ppos % PAGE_SIZE);
+	wake_up(wqhead);
+	unmap_usem(pages);
+	return ret;
+}
+
+static struct file_operations usem_fops = {
+	owner:		THIS_MODULE,
+	read:		usem_read,
+	write:		usem_write,
+};
+
+static int usem_major;
+static devfs_handle_t usem_dev;
+
+int __init init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(usem_waits); i++)
+		init_waitqueue_head(&usem_waits[i]);
+	usem_major = devfs_register_chrdev(0, "usem", &usem_fops);
+	usem_dev = devfs_register(NULL, "usem", DEVFS_FL_NONE, usem_major,
+				  0, S_IFCHR | 0666, &usem_fops, NULL);
+	return 0;
+}
+
+void __exit fini(void)
+{
+	devfs_unregister(usem_dev);
+	devfs_unregister_chrdev(usem_major, "usem");
+}
+
+MODULE_LICENSE("GPL");
+module_init(init);
+module_exit(fini);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/include/linux/hash.h working-2.5.5-usem/include/linux/hash.h
--- linux-2.5.5/include/linux/hash.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.5-usem/include/linux/hash.h	Thu Feb 21 12:33:46 2002
@@ -0,0 +1,58 @@
+#ifndef _LINUX_HASH_H
+#define _LINUX_HASH_H
+/* Fast hashing routine for a long.
+   (C) 2002 William Lee Irwin III, IBM */
+
+/*
+ * Knuth recommends primes in approximately golden ratio to the maximum
+ * integer representable by a machine word for multiplicative hashing.
+ * Chuck Lever verified the effectiveness of this technique:
+ * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
+ *
+ * These primes are chosen to be bit-sparse, that is operations on
+ * them can use shifts and additions instead of multiplications for
+ * machines where multiplications are slow.
+ */
+#if BITS_PER_LONG == 32
+/* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
+#define GOLDEN_RATIO_PRIME 0x9e370001UL
+#elif BITS_PER_LONG == 64
+/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
+#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
+#else
+#error Define GOLDEN_RATIO_PRIME for your wordsize.
+#endif
+
+static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+{
+	unsigned long hash = val;
+
+#if BITS_PER_LONG == 64
+	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
+	unsigned long n = hash;
+	n <<= 18;
+	hash -= n;
+	n <<= 33;
+	hash -= n;
+	n <<= 3;
+	hash += n;
+	n <<= 3;
+	hash -= n;
+	n <<= 4;
+	hash += n;
+	n <<= 2;
+	hash += n;
+#else
+	/* On some cpus multiply is faster, on others gcc will do shifts */
+	hash *= GOLDEN_RATIO_PRIME;
+#endif
+
+	/* High bits are more random, so use them. */
+	return hash >> (BITS_PER_LONG - bits);
+}
+	
+static inline unsigned long hash_ptr(void *ptr, unsigned int bits)
+{
+	return hash_long((unsigned long)ptr, bits);
+}
+#endif /* _LINUX_HASH_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/include/linux/mmzone.h working-2.5.5-usem/include/linux/mmzone.h
--- linux-2.5.5/include/linux/mmzone.h	Wed Feb 20 16:07:17 2002
+++ working-2.5.5-usem/include/linux/mmzone.h	Thu Feb 21 12:46:30 2002
@@ -51,8 +51,7 @@
 	/*
 	 * wait_table		-- the array holding the hash table
 	 * wait_table_size	-- the size of the hash table array
-	 * wait_table_shift	-- wait_table_size
-	 * 				== BITS_PER_LONG (1 << wait_table_bits)
+	 * wait_table_bits	-- wait_table_size == (1 << wait_table_bits)
 	 *
 	 * The purpose of all these is to keep track of the people
 	 * waiting for a page to become available and make them
@@ -75,7 +74,7 @@
 	 */
 	wait_queue_head_t	* wait_table;
 	unsigned long		wait_table_size;
-	unsigned long		wait_table_shift;
+	unsigned long		wait_table_bits;
 
 	/*
 	 * Discontig memory support fields.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/kernel/ksyms.c working-2.5.5-usem/kernel/ksyms.c
--- linux-2.5.5/kernel/ksyms.c	Wed Feb 20 16:07:17 2002
+++ working-2.5.5-usem/kernel/ksyms.c	Thu Feb 21 16:48:59 2002
@@ -86,6 +86,7 @@
 EXPORT_SYMBOL(do_munmap);
 EXPORT_SYMBOL(do_brk);
 EXPORT_SYMBOL(exit_mm);
+EXPORT_SYMBOL(get_user_pages);
 
 /* internal kernel memory management */
 EXPORT_SYMBOL(_alloc_pages);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/mm/filemap.c working-2.5.5-usem/mm/filemap.c
--- linux-2.5.5/mm/filemap.c	Wed Feb 20 16:07:17 2002
+++ working-2.5.5-usem/mm/filemap.c	Thu Feb 21 13:01:02 2002
@@ -25,6 +25,7 @@
 #include <linux/iobuf.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/hash.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -773,32 +774,8 @@
 static inline wait_queue_head_t *page_waitqueue(struct page *page)
 {
 	const zone_t *zone = page_zone(page);
-	wait_queue_head_t *wait = zone->wait_table;
-	unsigned long hash = (unsigned long)page;
 
-#if BITS_PER_LONG == 64
-	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
-	unsigned long n = hash;
-	n <<= 18;
-	hash -= n;
-	n <<= 33;
-	hash -= n;
-	n <<= 3;
-	hash += n;
-	n <<= 3;
-	hash -= n;
-	n <<= 4;
-	hash += n;
-	n <<= 2;
-	hash += n;
-#else
-	/* On some cpus multiply is faster, on others gcc will do shifts */
-	hash *= GOLDEN_RATIO_PRIME;
-#endif
-
-	hash >>= zone->wait_table_shift;
-
-	return &wait[hash];
+	return &zone->wait_table[hash_ptr(page, zone->wait_table_bits)];
 }
 
 /* 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.5/mm/page_alloc.c working-2.5.5-usem/mm/page_alloc.c
--- linux-2.5.5/mm/page_alloc.c	Wed Feb 20 16:07:17 2002
+++ working-2.5.5-usem/mm/page_alloc.c	Thu Feb 21 12:33:46 2002
@@ -776,8 +776,8 @@
 		 * per zone.
 		 */
 		zone->wait_table_size = wait_table_size(size);
-		zone->wait_table_shift =
-			BITS_PER_LONG - wait_table_bits(zone->wait_table_size);
+		zone->wait_table_bits =
+			wait_table_bits(zone->wait_table_size);
 		zone->wait_table = (wait_queue_head_t *)
 			alloc_bootmem_node(pgdat, zone->wait_table_size
 						* sizeof(wait_queue_head_t));


------- =_aaaaaaaaaa0
Content-Type: application/octet-stream; name="usem.tar.gz"
Content-ID: <2863.1014435501.2@rustcorp.com.au>
Content-Transfer-Encoding: base64

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
Af+1/LwAoAAA

------- =_aaaaaaaaaa0--
