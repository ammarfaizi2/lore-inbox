Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268660AbRG0GwD>; Fri, 27 Jul 2001 02:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268677AbRG0Gv4>; Fri, 27 Jul 2001 02:51:56 -0400
Received: from dsl-136-124.power.net ([207.151.136.124]:60660 "EHLO
	sandbass.cpqcorp.net") by vger.kernel.org with ESMTP
	id <S268660AbRG0Gvj>; Fri, 27 Jul 2001 02:51:39 -0400
Date: Thu, 26 Jul 2001 19:43:40 -0700
From: "Brian J. Watson" <bwatson@sandbass.cpqcorp.net>
Message-Id: <200107270243.f6R2heO30837@sandbass.cpqcorp.net>
To: Andi Kleen <ak@suse.de>, Bill Pringlemeir <bpringle@sympatico.ca>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Larry McVoy <lm@bitmover.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
Subject: [PATCH 2.4.7] generic hash table implementation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Thanks to everyone who participated in the 'Common hash table implementation' 
thread. With your comments in mind, I molded Richard's code into something 
that might work for the kernel community (and Linus).

Included in the following patch are the generic hash implementation, 
documentation, and some test code. The test code will be stripped out when 
it's time to submit the patch for inclusion. To turn on the test code, set 
HASH_TEST to 1.

Before submitting, we probably want to port one or more kernel hash tables 
onto the generic implementation. I was thinking about porting the dcache 
sometime next week if I have time, then running it on my laptop to see if 
there's any problems.

Let me know what you think.

-- 
Brian Watson                | "The common people of England... so 
Linux Kernel Developer      |  jealous of their liberty, but like the 
Open SSI Clustering Project |  common people of most other countries 
Compaq Computer Corp        |  never rightly considering wherein it 
Los Angeles, CA             |  consists..."
                            |     -Adam Smith, Wealth of Nations, 1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/


== cut ==
--- linux-2.4.7/Documentation/hash.txt	Thu Jul 26 18:33:53 2001
+++ linux/Documentation/hash.txt	Thu Jul 26 01:06:15 2001
@@ -0,0 +1,217 @@
+Generic Hash Table Implementation
+=================================
+
+Introduction
+------------
+
+A hash table is a data structure for holding a collection of similar
+objects. Similar objects in C are objects of the same datatype, but
+not necessarily containing the same data.
+
+Other data structures for holding collections of similar objects 
+include arrays and linked lists. Arrays have the advantage of quick 
+access to any element, regardless of the array's size. They also
+allow quick addition to and deletion from the end of the array. This
+makes them an excellent choice for implementing a stack. On the down
+side, large arrays offer horrible performance for addition to and 
+deletion from an arbitrary position. Furthermore, arrays in C are
+statically sized, and it is up to the programmer to avoid going past
+the end of the array.
+
+Linked lists are dynamically sized. They can either use NULL pointers
+to mark the beginning and end of the list, or they can be made circular,
+so it is impossible to go past the end. Lists offer fast addition to 
+and deletion from arbitrary positions. On the other hand, finding an 
+object in a large list is generally an expensive proposition.  On 
+average, half of the objects in the list have to be looked at before 
+the object of interest is found. Specific uses of linked lists, such
+as queues, avoid this problem.
+
+Hash tables offer a middle ground between arrays and linked lists.
+A hash table consists of an array of pointers. Each of these pointers
+can either be NULL or point at the beginning of a linked list. Although
+the array is statically sized, the linked lists hanging off of it are
+dynamically sized.
+
+When adding an object to a hash table, a hashing function is used to 
+select the particular list to add the object to. The hashing function 
+takes some data from the object, munges it, and returns a bucket number. 
+The bucket number refers to the appropriate list.
+
+When finding an object in a hash table, it helps to already know the
+data needed by the hashing function. That way only the list containing
+the object of interest needs to be searched. Without this data, the 
+entire table needs to be searched, which is a bit more expensive than
+searching a single linked list.
+
+
+Sample Hash Table Declaration
+-----------------------------
+
+#include <linux/hash.h>
+
+struct foo {
+	int			foo_id;
+	struct list_head	foo_hash;
+	...
+};
+
+#define HASHSIZE 100
+
+static int hash_id(int *id)
+{
+	return *id % HASHSIZE;
+}
+
+static int hash_ent(struct foo *entry)
+{
+	return hash_id(&entry->foo_id);
+}
+
+DECLARE_HASH_FUNCS(bar, struct foo, foo_hash, hash_ent, hash_id, int);
+
+static DECLARE_HASH_STATIC(bar, HASHSIZE);
+
+
+Hash Table Declarations
+-----------------------
+
+The generic hash table implementation is contained in include/linux/hash.h.
+
+First the datatype to be hashed must be defined. At a minimum, it must 
+include a struct list_head not being used simultaneously for membership 
+in another linked list or hash table, and it must include the data 
+for the hashing function.
+
+It is then necessary to define two versions of the hashing function. 
+The first must take a pointer to a hash entry, and return a number 
+that can be used to index an array. The bit width of the number and 
+whether it is signed or unsigned is not too important. Don't return 
+a floating point number (which shouldn't be used in the kernel anyway).
+
+The second function can take a single pointer to an arbitrary datatype.
+It, too, must return an index, although it need not be the same type
+as the first function's return value. Of course, one of these functions
+can be implemented in terms of the other, as shown in the example above.
+
+Next use the DECLARE_HASH_FUNCS() macro to generate the accessor
+functions for the table. All of the functions are declared 'static' 
+or 'static inline', so DECLARE_HASH_FUNCS() can be safely used in a 
+header file or multiple source files for a given hash table.
+
+The arguments taken by DECLARE_HASH_FUNCS() are:
+
+  - the name of the hash table (e.g., bar)
+  - the structure type to be hashed (e.g., struct foo)
+  - the fieldname of that structure's list_head (e.g., foo_hash)
+  - the name of the hash function taking an entry pointer (e.g., hash_ent)
+  - the name of the hash function taking a data pointer (e.g., hash_id)
+  - the pointer type taken by the second function (e.g., int)
+
+To declare the hash table itself, use either DECLARE_HASH_STATIC() or 
+DECLARE_HASH_DYNAMIC(). The former statically allocates the hash table. 
+Note that this has nothing to do with static scope. If the 'static' 
+keyword was not used in the example above, the hash table could be 
+accessed from other source files. Remember that if the 'static' keyword 
+is not used, DECLARE_HASH_STATIC() and DECLARE_HASH_DYNAMIC() can
+only be used once in the kernel for a given name. This is basic 
+C semantics for global variables.
+
+DECLARE_HASH_DYNAMIC() only declares a pointer to the hash table. It is
+up to the user to allocate the table with KMALLOC_HASH() before it's 
+needed. It is also up to the user to free the hash with KFREE_HASH()
+after its purpose has been served. Do not use kmalloc() or kfree(),
+because the real name of the hash table is not the same as the name 
+used with these macros. Don't forget to check the return value of 
+KMALLOC_HASH(). If it's NULL, the system was too low on memory to 
+allocate the table.
+
+If a hash table will be needed for as long as the system is up or as 
+long as a particular module is loaded, then DECLARE_HASH_STATIC() 
+should be used. If the table is only needed to deal with an unusual 
+situation and there's no need to hog memory all the time for that table,
+use DECLARE_HASH_DYNAMIC(), KMALLOC_HASH(), and KFREE_HASH().
+
+The arguments taken by DECLARE_HASH_STATIC() are:
+
+  - a unique name to identify the hash table (e.g., bar)
+  - the number of hash buckets (e.g., 100)
+
+The argument taken by DECLARE_HASH_DYNAMIC() is:
+
+  - a unique name to identify the hash table (e.g., bar)
+
+The arguments taken by KMALLOC_HASH() are:
+
+  - the name of the hash table previously declared dynamic
+  - the number of hash buckets (e.g., 100)
+  - the allocation flags (e.g., GFP_USER, GFP_KERNEL)
+
+The argument taken by KFREE_HASH() is:
+
+  - the name of the hash table to be freed
+
+
+Accessor Functions
+------------------
+
+After using the DECLARE_HASH_FUNCS() macro, the following accessor 
+functions can be called for hash table 'bar':
+
+ - bar_hash_add()
+     * takes a pointer to a new entry and inserts it into the table
+     * the data used by the first hash function (the one that takes
+       entry pointers) must already be initialized in the entry
+     * the entry better _not_ be in the table, or Bad Things might happen
+
+ - bar_hash_del()
+     * takes a pointer to an entry and removes it from the table
+     * the entry better be in the table, or Bad Things might happen
+
+ - bar_hash_find()
+     * takes an argument for the second hashing function (the one that
+       takes an arbitrary pointer)
+     * also takes a pointer to a comparison function and a pointer to 
+       search criteria
+     * bar_hash_find() calculates the appropriate hash bucket and 
+       applies the comparison function to every entry in that bucket
+       until it finds a match
+     * the comparison function should take a pointer to an entry and a 
+       pointer to the search criteria
+     * the comparison function should return non-zero if the entry matches 
+       the search criteria, otherwise it should return zero
+     * bar_hash_find() returns a pointer to the first entry in the bucket
+       that matches, otherwise it returns NULL
+     * if NULL is given for the comparison function, the first entry
+       in the bucket is returned
+
+  - bar_is_hashed()
+     * takes a pointer to an entry
+     * returns the entry pointer if it is hashed in the table
+     * otherwise returns NULL
+
+  - bar_hash_gfind()
+     * takes a pointer to a comparison function and a pointer 
+       to search criteria
+     * searches the entire table for the first entry that matches
+       the search criteria
+     * returns a pointer to the first matching entry
+     * returns NULL if there are no matches in the table
+     * if NULL is given for the comparison function, the first entry
+       in the table is returned
+
+  - bar_hash_gfind_next()
+     * takes a pointer to the last entry retrieved from the table
+     * also takes a pointer to a comparison function and a pointer 
+       to search criteria
+     * searches the remainder of the table for the next entry that 
+       matches the search criteria
+     * returns a pointer to the next matching entry
+     * returns NULL if there are no more matches in the table
+     * if NULL is given for the comparison function, the next entry
+       in the table is returned
+
+
+--
+Copyright (C) 2001 Compaq Computer Corp. <Brian.J.Watson@compaq.com>
+All rights reserved.
--- linux-2.4.7/include/linux/hash.h	Thu Jul 26 18:33:53 2001
+++ linux/include/linux/hash.h	Thu Jul 26 18:29:58 2001
@@ -0,0 +1,222 @@
+#ifndef _HASH_H
+#define _HASH_H
+
+/* XXX: for testing purposes only */
+#define inline
+
+/*
+ * hash.h
+ *
+ * Copyright (C) 1999, 2000 Richard Guenther
+ * Copyright (C) 2001 Compaq Computer Corp. <Brian.J.Watson@compaq.com>
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+/* see Documentation/hash.txt for more information */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+
+typedef int __hash_cmp_f(void *entry, void *data);
+typedef void * __hash_entry_f(struct list_head *ptr);
+
+static inline void __hash_add(
+		struct list_head *ptr, 
+		struct list_head **bucket)
+{
+	if (!*bucket) {
+		INIT_LIST_HEAD(ptr);
+		*bucket = ptr;
+	} else
+		list_add(ptr, *bucket);
+}
+
+static inline void __hash_del(
+		struct list_head *ptr, 
+		struct list_head **bucket)
+{
+	if (*bucket == ptr)
+		*bucket = ptr->next;
+	if (list_empty(ptr))
+		*bucket = NULL;
+	else
+		list_del(ptr);
+}
+
+static inline void * __hash_find(
+		struct list_head *bucket, 
+		struct list_head *last, 
+		__hash_cmp_f *cmp_f,
+		void *data,
+		__hash_entry_f *entry_f)
+{
+	struct list_head *cur;
+
+	if (!bucket)
+		return NULL;
+
+	if (!last)
+		cur = bucket;
+	else if (last->next == bucket)
+		return NULL;
+	else
+		cur = last->next;
+
+	if (!cmp_f)
+		return entry_f(cur);
+
+	do {
+		void *entry = entry_f(cur);
+		if (cmp_f(entry, data))
+			return entry;
+		cur = cur->next;
+	} while (cur != bucket);
+	return NULL;
+}
+
+static inline void * __hash_gfind(
+		struct list_head **bucket, 
+		struct list_head **end, 
+		struct list_head *last, 
+		__hash_cmp_f *cmp_f,
+		void *data,
+		__hash_entry_f *entry_f)
+{
+	struct list_head **cur;
+	for (cur = bucket; cur < end; ++cur) {
+		void *entry = __hash_find(*cur, last, cmp_f, data, entry_f);
+		if (entry)
+			return entry;
+		last = NULL;
+	}
+	return NULL;
+}
+
+static int __hash_cmp_is_self(void *entry, void *data)
+{
+	return entry == data;
+}
+
+#define DECLARE_HASH_FUNCS(NAME, TYPE, MEMBER,				\
+		CALCENT, CALCDATA, DATATYPE)				\
+									\
+extern unsigned long __##NAME##_hash_size;				\
+extern struct list_head **__##NAME##_hash_tbl;				\
+									\
+static inline void NAME##_hash_add(TYPE *entry)				\
+{									\
+	__hash_add(							\
+		&entry->MEMBER,						\
+		&__##NAME##_hash_tbl[CALCENT(entry)]);			\
+}									\
+									\
+static inline void NAME##_hash_del(TYPE *entry)				\
+{									\
+	__hash_del(							\
+		&entry->MEMBER,						\
+		&__##NAME##_hash_tbl[CALCENT(entry)]);			\
+}									\
+									\
+static void * __##NAME##_hash_entry(struct list_head *ptr)		\
+{									\
+	return list_entry(ptr, TYPE, MEMBER);				\
+}									\
+									\
+static inline TYPE * NAME##_hash_find(					\
+		DATATYPE *hashdata, __hash_cmp_f *cmp_f, void *cmpdata)	\
+{									\
+	return __hash_find(						\
+			__##NAME##_hash_tbl[CALCDATA(hashdata)],	\
+			NULL,						\
+			cmp_f,						\
+			cmpdata,					\
+			__##NAME##_hash_entry);				\
+}									\
+									\
+static inline TYPE * NAME##_is_hashed(TYPE *entry)			\
+{									\
+	return __hash_find(						\
+			__##NAME##_hash_tbl[CALCENT(entry)],		\
+			NULL,						\
+			__hash_cmp_is_self,				\
+			entry,						\
+			__##NAME##_hash_entry);				\
+}									\
+									\
+static inline TYPE * NAME##_hash_gfind(					\
+		__hash_cmp_f *cmp_f, void *cmpdata)			\
+{									\
+	return __hash_gfind(						\
+			__##NAME##_hash_tbl,				\
+			&__##NAME##_hash_tbl[__##NAME##_hash_size],	\
+			NULL,						\
+			cmp_f,						\
+			cmpdata,					\
+			__##NAME##_hash_entry);				\
+}									\
+									\
+static inline TYPE * NAME##_hash_gfind_next(				\
+		TYPE *last, __hash_cmp_f *cmp_f, void *cmpdata)		\
+{									\
+	return __hash_gfind(						\
+			&__##NAME##_hash_tbl[CALCENT(last)],		\
+			&__##NAME##_hash_tbl[__##NAME##_hash_size],	\
+			&last->MEMBER,					\
+			cmp_f,						\
+			cmpdata,					\
+			__##NAME##_hash_entry);				\
+}									\
+									\
+extern struct list_head **__##NAME##_hash_tbl
+
+static inline struct list_head ** __kmalloc_hash(
+		struct list_head ***tbl, unsigned long *sizep, 
+		size_t size, int flags)
+{
+	size_t tmp = size * sizeof(void *);
+	*tbl = kmalloc(tmp, flags);
+	if (*tbl) {
+		memset(*tbl, 0, tmp);
+		*sizep = size;
+	}
+	return *tbl;
+}
+
+#define DECLARE_HASH_STATIC(NAME, SIZE)					\
+	unsigned long __##NAME##_hash_size = SIZE;			\
+	struct list_head *__##NAME##_hash_array[SIZE];			\
+	struct list_head **__##NAME##_hash_tbl = __##NAME##_hash_array
+
+#define DECLARE_HASH_DYNAMIC(NAME)					\
+	unsigned long __##NAME##_hash_size = 0;				\
+	struct list_head **__##NAME##_hash_tbl = NULL
+
+#define KMALLOC_HASH(NAME, SIZE, FLAGS)					\
+	__kmalloc_hash(&__##NAME##_hash_tbl, &__##NAME##_hash_size,	\
+			SIZE, FLAGS)
+
+#define KFREE_HASH(NAME)						\
+	do {								\
+		__##NAME##_hash_size = 0;				\
+		kfree(__##NAME##_hash_tbl);				\
+	} while (0)
+
+/* XXX */
+#undef inline
+
+#endif /* _HASH_H */
--- linux-2.4.7/include/hash_test.h	Thu Jul 26 18:33:53 2001
+++ linux/include/hash_test.h	Thu Jul 26 19:13:56 2001
@@ -0,0 +1,165 @@
+/* XXX: temporary file for testing purposes only */
+
+#define HASH_TEST 0
+
+#if (!HASH_TEST)
+
+#define hash_test()	do {} while (0)
+
+#else
+
+#include <linux/sched.h>
+#include <linux/hash.h>
+
+struct foo {
+	int			foo_id;
+	struct list_head	foo_hash;
+	char			*foo_name;
+};
+
+#define HASHSIZE 3
+
+static int hash_id(int *id)
+{
+	return *id % HASHSIZE;
+}
+
+static int hash_ent(struct foo *entry)
+{
+	return hash_id(&entry->foo_id);
+}
+
+DECLARE_HASH_FUNCS(bar, struct foo, foo_hash, hash_ent, hash_id, int);
+
+static void print_is_hashed(struct foo *entry)
+{
+	if (bar_is_hashed(entry))
+		printk("%s is hashed\n", entry->foo_name);
+	else
+		printk("%s is _not_ hashed\n", entry->foo_name);
+}
+
+static int test_id(struct foo *entry, int *id)
+{
+	return entry->foo_id == *id;
+}
+
+static void find_and_print(int id)
+{
+	struct foo *entry = bar_hash_find(&id, test_id, &id);
+	if (!entry)
+		printk("nobody has an id of %d\n", id);
+	else
+		printk("%s has an id of %d\n", entry->foo_name, id);
+
+	entry = bar_hash_gfind(test_id, &id);
+	while (entry) {
+		printk("%s has an id of %d\n", entry->foo_name, id);
+		entry = bar_hash_gfind_next(entry, test_id, &id);
+	}
+}
+
+static struct foo a = { foo_id: 0, foo_name: "alpha" };
+static struct foo b = { foo_id: 1, foo_name: "bravo" };
+static struct foo c = { foo_id: 2, foo_name: "charlie" };
+static struct foo d = { foo_id: 2, foo_name: "delta" };
+static struct foo e = { foo_id: 1, foo_name: "echo" };
+static struct foo f = { foo_id: 0, foo_name: "foxtrot" };
+static struct foo g = { foo_id: 4, foo_name: "golf" };
+static struct foo h = { foo_id: 3, foo_name: "hotel" };
+static struct foo i = { foo_id: 2, foo_name: "india" };
+static struct foo j = { foo_id: 1, foo_name: "juliet" };
+
+static void print_stuff(void)
+{
+	print_is_hashed(&a);
+	print_is_hashed(&b);
+	print_is_hashed(&c);
+	print_is_hashed(&d);
+	print_is_hashed(&e);
+	print_is_hashed(&f);
+	print_is_hashed(&g);
+	print_is_hashed(&h);
+	print_is_hashed(&i);
+	print_is_hashed(&j);
+	printk("\n");
+
+	find_and_print(0);
+	find_and_print(1);
+	find_and_print(2);
+	find_and_print(3);
+	find_and_print(4);
+	find_and_print(5);
+	printk("\n");
+}
+
+static void hash_test(void)
+{
+	int id;
+
+	printk("\n");
+	printk("Move over init -- we're testing hashes now\n");
+	printk("------------------------------------------\n");
+	printk("\n");
+
+	KMALLOC_HASH(bar, HASHSIZE, GFP_KERNEL);
+
+	bar_hash_add(&a);
+	bar_hash_add(&b);
+	bar_hash_add(&c);
+	bar_hash_add(&d);
+	bar_hash_add(&e);
+
+	print_stuff();
+
+	bar_hash_add(&f);
+	bar_hash_add(&g);
+	bar_hash_add(&h);
+	bar_hash_add(&i);
+	bar_hash_add(&j);
+
+	print_stuff();
+
+	bar_hash_del(&b);
+	bar_hash_del(&d);
+	bar_hash_del(&f);
+	bar_hash_del(&h);
+	bar_hash_del(&j);
+
+	print_stuff();
+
+	bar_hash_del(&a);
+	bar_hash_del(&c);
+	bar_hash_del(&e);
+	bar_hash_del(&g);
+	bar_hash_del(&i);
+
+	print_stuff();
+
+	bar_hash_add(&e);
+	bar_hash_add(&d);
+	bar_hash_add(&c);
+	bar_hash_add(&b);
+	bar_hash_add(&a);
+
+	print_stuff();
+
+	bar_hash_add(&j);
+	bar_hash_add(&i);
+	bar_hash_add(&h);
+	bar_hash_add(&g);
+	bar_hash_add(&f);
+
+	print_stuff();
+
+	KFREE_HASH(bar);
+
+	do {
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule();
+	} while (1);
+}
+
+static DECLARE_HASH_DYNAMIC(bar);
+
+#endif /* HASH_TEST */
--- linux-2.4.7/init/main.c	Thu Jul 26 18:33:53 2001
+++ linux/init/main.c	Thu Jul 26 19:16:00 2001
@@ -11,6 +11,8 @@
 
 #define __KERNEL_SYSCALLS__
 
+#include <hash_test.h>
+
 #include <linux/config.h>
 #include <linux/proc_fs.h>
 #include <linux/devfs_fs_kernel.h>
@@ -799,6 +801,8 @@
 	 * The Bourne shell can be used instead of init if we are 
 	 * trying to recover a really broken machine.
 	 */
+
+	hash_test(); /* XXX: temporary call for testing purposes only */
 
 	if (execute_command)
 		execve(execute_command,argv_init,envp_init);
