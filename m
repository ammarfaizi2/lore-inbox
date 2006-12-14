Return-Path: <linux-kernel-owner+w=401wt.eu-S1750798AbWLNODJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWLNODJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWLNODI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:03:08 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:58509
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbWLNODF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:03:05 -0500
Date: Thu, 14 Dec 2006 05:37:55 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] lock stat kills lock meter for -rt (core)
Message-ID: <20061214133755.GA22194@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Core infrastructure files with /proc interface


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="core.diff"

============================================================
--- include/linux/lock_stat.h	554e4c1a2bc399f8a4fe4a1634b29aae6f4bb4de
+++ include/linux/lock_stat.h	554e4c1a2bc399f8a4fe4a1634b29aae6f4bb4de
@@ -0,0 +1,147 @@
+/*
+ * By Bill Huey (hui) at <billh@gnuppy.monkey.org>
+ *
+ * Release under the what ever the Linux kernel chooses for a
+ * license, GNU Public License GPL v2
+ *
+ * Tue Sep  5 17:27:48 PDT 2006
+ *	Created lock_stat.h
+ *
+ * Wed Sep  6 15:36:14 PDT 2006
+ *	Thinking about the object lifetime of a spinlock. Please refer to
+ *	comments in kernel/lock_stat.c instead.
+ *
+ */
+
+#ifndef	LOCK_STAT_H
+#define LOCK_STAT_H
+
+#ifdef CONFIG_LOCK_STAT
+
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <linux/kallsyms.h>
+#include <linux/string.h>
+
+#include <asm/atomic.h>
+
+typedef struct lock_stat {
+	char	function[KSYM_NAME_LEN];
+	int	line;
+	char	*file;
+
+	atomic_t		ncontended;
+	unsigned int		ntracked;
+	atomic_t		ninlined;
+	atomic_t		nspinnable;
+
+	struct rb_node		rb_node;
+	struct list_head	list_head;
+} lock_stat_t;
+
+typedef lock_stat_t *lock_stat_ref_t;
+
+struct task_struct;
+
+#define LOCK_STAT_INIT(field)
+#define LOCK_STAT_INITIALIZER(field) { 			\
+		__FILE__, __FUNCTION__, __LINE__,	\
+		ATOMIC_INIT(0), LIST_HEAD_INIT(field)}
+
+#define LOCK_STAT_NOTE			__FILE__, __FUNCTION__, __LINE__
+#define LOCK_STAT_NOTE_VARS		_file, _function, _line
+#define LOCK_STAT_NOTE_PARAM_DECL	const char *_file,	\
+					const char *_function,	\
+					int _line
+
+#define __COMMA_LOCK_STAT_FN_DECL	, const char *_function
+#define __COMMA_LOCK_STAT_FN_VAR	, _function
+#define __COMMA_LOCK_STAT_NOTE_FN	, __FUNCTION__
+
+#define __COMMA_LOCK_STAT_NOTE		, LOCK_STAT_NOTE
+#define __COMMA_LOCK_STAT_NOTE_VARS	, LOCK_STAT_NOTE_VARS
+#define __COMMA_LOCK_STAT_NOTE_PARAM_DECL , LOCK_STAT_NOTE_PARAM_DECL
+
+
+#define __COMMA_LOCK_STAT_NOTE_FLLN_DECL , const char *_file, int _line
+#define __COMMA_LOCK_STAT_NOTE_FLLN	 , __FILE__, __LINE__
+#define __COMMA_LOCK_STAT_NOTE_FLLN_VARS , _file, _line
+
+#define __COMMA_LOCK_STAT_INITIALIZER	, .lock_stat = NULL,
+
+#define __COMMA_LOCK_STAT_IP_DECL	, unsigned long _ip
+#define __COMMA_LOCK_STAT_IP		, _ip
+#define __COMMA_LOCK_STAT_RET_IP	, (unsigned long) __builtin_return_address(0)
+
+extern void lock_stat_init(struct lock_stat *ls);
+extern void lock_stat_sys_init(void);
+
+#define lock_stat_is_initialized(o) ((unsigned long) (*o)->file)
+
+extern void lock_stat_note_contention(lock_stat_ref_t *ls, struct task_struct *owner, unsigned long ip);
+extern void lock_stat_print(void);
+extern void lock_stat_scoped_attach(lock_stat_ref_t *_s, LOCK_STAT_NOTE_PARAM_DECL);
+
+#define ksym_strcmp(a, b) strncmp(a, b, KSYM_NAME_LEN)
+#define ksym_strcpy(a, b) strncpy(a, b, KSYM_NAME_LEN)
+#define ksym_strlen(a) strnlen(a, KSYM_NAME_LEN)
+
+/*
+static inline char * ksym_strdup(const char *a)
+{
+	char *s = (char *) kmalloc(ksym_strlen(a), GFP_KERNEL);
+	return strncpy(s, a, KSYM_NAME_LEN);
+}
+*/
+
+#define LS_INIT(name, h) {				\
+	/*.function,*/ .file = h, .line = 1,		\
+	.ntracked = 0, .ncontended = ATOMIC_INIT(0),	\
+	.list_head = LIST_HEAD_INIT(name.list_head),	\
+	.rb_node.rb_left = NULL, .rb_node.rb_left = NULL \
+	}
+
+#define DECLARE_LS_ENTRY(name)				\
+	extern struct lock_stat _lock_stat_##name##_entry
+
+/*	char _##name##_string[] = #name;		\
+*/
+
+#define DEFINE_LS_ENTRY(name)				\
+	struct lock_stat _lock_stat_##name##_entry = LS_INIT(_lock_stat_##name##_entry, #name "_string")
+
+DECLARE_LS_ENTRY(d_alloc);
+DECLARE_LS_ENTRY(eventpoll_init_file);
+/*
+DECLARE_LS_ENTRY(get_empty_filp);
+DECLARE_LS_ENTRY(init_once_1);
+DECLARE_LS_ENTRY(init_once_2);
+DECLARE_LS_ENTRY(inode_init_once_1);
+DECLARE_LS_ENTRY(inode_init_once_2);
+DECLARE_LS_ENTRY(inode_init_once_3);
+DECLARE_LS_ENTRY(inode_init_once_4);
+DECLARE_LS_ENTRY(inode_init_once_5);
+DECLARE_LS_ENTRY(inode_init_once_6);
+DECLARE_LS_ENTRY(inode_init_once_7);
+*/
+
+#else /* CONFIG_LOCK_STAT  */
+
+#define __COMMA_LOCK_STAT_FN_DECL
+#define __COMMA_LOCK_STAT_FN_VAR
+#define __COMMA_LOCK_STAT_NOTE_FN
+
+#define __COMMA_LOCK_STAT_NOTE_FLLN_DECL
+#define __COMMA_LOCK_STAT_NOTE_FLLN
+#define __COMMA_LOCK_STAT_NOTE_FLLN_VARS
+
+#define __COMMA_LOCK_STAT_INITIALIZER	
+
+#define __COMMA_LOCK_STAT_IP_DECL
+#define __COMMA_LOCK_STAT_IP
+#define __COMMA_LOCK_STAT_RET_IP
+
+#endif /* CONFIG_LOCK_STAT */
+
+#endif /* LOCK_STAT_H */
+
============================================================
--- kernel/lock_stat.c	093f5e0726a6cb43f37f1dfef93493725871a584
+++ kernel/lock_stat.c	093f5e0726a6cb43f37f1dfef93493725871a584
@@ -0,0 +1,677 @@
+/*
+ * lock_stat.h
+ *
+ * By Bill Huey (hui) billh@gnuppy.monkey.org
+ * Release under GPL license compatible with the Linux kernel
+ *
+ * Tue Sep  5 17:27:48 PDT 2006
+ * Started after thinking about the problem the of Burning Man 2006 and lock
+ * lifetimes, scoping of those objects, etc...
+ *
+ * Thu Sep 14 04:01:26 PDT 2006
+ * Some of this elaborate list handling stuff might not be necessary since I
+ * can attach all of the spinlocks at spin_lock_init() time, etc... It can be
+ * done out of line from the contention event. It's just a matter of how to
+ * detect and record contentions for spinlocks are statically initialized
+ * being the last part of what I need get this all going. I thought about that
+ * last night after going to BaG and talking to Mitch a bunch about this.
+ *
+ * Fri Sep 15 04:27:47 PDT 2006
+ * I maybe have greatly simplified this today during the drive down here to
+ * SD. Keep all of the statically defined stuff late, but protect the
+ * persistent list by a simple spinlock and append it to the list immediately.
+ * This is possible because the static initializer stuff handles proper insert
+ * of the lock_stat struct during calls to spin_lock_init() for all other
+ * insertion cases.
+ * 
+ * Special thanks go to Zwane and Peter for helping me with an initial
+ * implemention using RCU and lists even though that's now been replaced by
+ * something that's better and much simpler.
+ *
+ * Thu Sep 21 23:38:48 PDT 2006 
+ * I'm in San Diego this last week or so and I've been auditing the kernel
+ * for spinlock and rwlocks to see if they are statically defined or scoped.
+ * I finished that audit last night.
+ *
+ * Mon Sep 25 21:49:43 PDT 2006
+ * Back in SF as of last night. Think about what I need to do to get rudimentary
+ * testing in place so that I know this code isn't going to crash the kernel.
+ *
+ * Fri Nov 24 19:06:31 PST 2006
+ * As suggested by peterz, I removed the init_wait_queue stuff since lockdep
+ * already apparently has handled it.
+ * 
+ * --billh
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include <linux/lock_stat.h>
+#include <linux/slab.h>
+
+#include <linux/spinlock.h>
+#include <linux/module.h>
+
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <linux/kallsyms.h>
+
+#include <asm/atomic.h>
+#include <asm/kdebug.h>
+
+static DEFINE_RAW_SPINLOCK(free_store_lock);
+static LIST_HEAD(lock_stat_free_store);
+
+static DEFINE_RAW_SPINLOCK(persistent_store_lock);
+static LIST_HEAD(lock_stat_persistent_store);
+
+static char null_string[]		= "";
+static char static_string[]		= "-";
+static char special_static_string[]	= "-";
+
+struct lock_stat _lock_stat_null_entry	= LS_INIT(_lock_stat_null_entry,   null_string);
+EXPORT_SYMBOL(_lock_stat_null_entry);
+
+static DEFINE_LS_ENTRY(inline);		/* lock_stat_inline_entry	*/
+static DEFINE_LS_ENTRY(untracked);	/* lock_stat_untracked_entry	*/
+static DEFINE_LS_ENTRY(preinit);	/* lock_stat_preinit_entry	*/
+
+/* To be use for avoiding the dynamic attachment of spinlocks at runtime
+ * by attaching it inline with the lock initialization function */
+
+DEFINE_LS_ENTRY(d_alloc);
+EXPORT_SYMBOL(_lock_stat_d_alloc_entry);
+
+DEFINE_LS_ENTRY(eventpoll_init_file);
+EXPORT_SYMBOL(_lock_stat_eventpoll_init_file_entry);
+
+/*
+static DEFINE_LS_ENTRY(__pte_alloc);
+static DEFINE_LS_ENTRY(get_empty_filp);
+static DEFINE_LS_ENTRY(init_waitqueue_head);
+static DEFINE_LS_ENTRY(init_buffer_head_1);
+static DEFINE_LS_ENTRY(init_buffer_head_2);
+static DEFINE_LS_ENTRY(init_once_1);
+static DEFINE_LS_ENTRY(init_once_2);
+static DEFINE_LS_ENTRY(inode_init_once_1);
+static DEFINE_LS_ENTRY(inode_init_once_2);
+static DEFINE_LS_ENTRY(inode_init_once_3);
+static DEFINE_LS_ENTRY(inode_init_once_4);
+static DEFINE_LS_ENTRY(inode_init_once_5);
+static DEFINE_LS_ENTRY(inode_init_once_6);
+static DEFINE_LS_ENTRY(inode_init_once_7);
+static DEFINE_LS_ENTRY(inode_init_once_8);
+static DEFINE_LS_ENTRY(mm_init_1);
+static DEFINE_LS_ENTRY(mm_init_2);
+static DEFINE_LS_ENTRY(mm_init_3);
+static DEFINE_LS_ENTRY(skb_queue_init);
+static DEFINE_LS_ENTRY(tcp_init_1);
+static DEFINE_LS_ENTRY(tcp_init_2);
+*/
+
+/* I should never have to create more entries that this since I audited the kernel
+ * and found out that there are only ~1500 or so places in the kernel where these
+ * rw/spinlocks are initialized. Use the initialization points as a hash value to
+ * look up the backing objects */
+
+#define MAGIC_ENTRIES 1600
+
+static int lock_stat_procfs_init(void);
+static void lock_stat_insert_persistent_store(struct lock_stat *);
+
+static int lock_stat_inited = 0;
+
+static
+DEFINE_PER_CPU(atomic_t, lock_stat_total_events);
+
+void lock_stat_init(struct lock_stat *_s)
+{
+	_s->function[0]	= 0;
+	_s->file	= NULL;
+	_s->line	= 0;
+
+	_s->ntracked	= 0;
+	atomic_set(&_s->ninlined, 0);
+	atomic_set(&_s->ncontended, 0);
+	atomic_set(&_s->nspinnable, 0);
+
+	INIT_LIST_HEAD(&_s->list_head);
+	_s->rb_node.rb_left = _s->rb_node.rb_right = NULL;
+}
+
+void lock_stat_reset_contention_count(void) {
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		atomic_set(&per_cpu(lock_stat_total_events, cpu), 0);
+	}
+}
+
+void lock_stat_sys_init(void)
+{
+	struct lock_stat *s;
+	int i;
+
+	for (i = 0; i < MAGIC_ENTRIES; ++i) {
+		s = (struct lock_stat *) kmalloc(sizeof(struct lock_stat), GFP_KERNEL);
+
+		if (s) {
+			lock_stat_init(s);
+			list_add_tail(&s->list_head, &lock_stat_free_store);
+		}
+		else {
+			printk("%s: kmalloc returned NULL\n", __func__);
+			return;
+		}
+	}
+
+	lock_stat_insert_persistent_store(&_lock_stat_inline_entry); 
+	lock_stat_insert_persistent_store(&_lock_stat_untracked_entry); 
+	lock_stat_insert_persistent_store(&_lock_stat_preinit_entry); 
+
+	lock_stat_insert_persistent_store(&_lock_stat_d_alloc_entry); 
+	lock_stat_insert_persistent_store(&_lock_stat_eventpoll_init_file_entry);
+
+	lock_stat_procfs_init();
+
+	lock_stat_reset_contention_count();
+	lock_stat_inited = 1;
+}
+
+static
+struct lock_stat *lock_stat_allocate_object(void) {
+	unsigned long flags;
+
+	spin_lock_irqsave(&free_store_lock, flags);
+	if (!list_empty(&lock_stat_free_store)) {
+		struct list_head *e = lock_stat_free_store.next;
+		struct lock_stat *s;
+
+		s = container_of(e, struct lock_stat, list_head);
+		list_del(e);
+
+		spin_unlock_irqrestore(&free_store_lock, flags);
+
+		return s;
+	}
+	spin_unlock_irqrestore(&free_store_lock, flags);
+
+	panic("%s: out of preallocated objects\n", __func__);
+
+	return NULL;
+}
+
+/*
+ * Comparision, greater to/less than or equals. zero is equals.
+ * Suitable for ordered insertion into a tree
+ *
+ * The (entry - object) order of comparison is switched from the parameter definition
+ */
+static
+int lock_stat_compare_objs(struct lock_stat *a, struct lock_stat *b)
+{
+	int d;
+
+	(d = ksym_strcmp(a->function, b->function))	||
+	(d = ksym_strcmp(a->file, b->file))		||
+	(d = (a->line - b->line))/**/;
+
+	/* return short circut result */
+	return d;
+}
+
+static
+int lock_stat_compare_key_to_obj(LOCK_STAT_NOTE_PARAM_DECL, struct lock_stat *b)
+{
+	int d;
+
+	(d = ksym_strcmp(_function, b->function))	||
+	(d = ksym_strcmp(_file, b->file))		||
+	(d = (_line - b->line));
+
+	/* return short circut result */
+	return d;
+}
+
+static
+int lock_stat_key_equals_obj(LOCK_STAT_NOTE_PARAM_DECL, struct lock_stat *_s)
+{
+	if (   _file == NULL ||    _function == NULL ||
+	    _s->file == NULL || _s->function == NULL) {
+		return -1;
+	}
+
+	return !ksym_strcmp(_s->function, _function)/* && !ksym_strcmp(_s->file, _file)*/;
+}
+
+static
+void lock_stat_print_hash(struct lock_stat *o, char *s, char *fn)
+{
+	printk("%s: %s [%s, %s, %d]\n", fn, s, o->file, o->function, o->line);
+}
+
+static
+void lock_stat_print_entry(struct seq_file *seq, struct lock_stat *o) {
+	seq_printf(seq, "[%d, %d :: %d, %d]\t\t{%s, %s, %d}\n",
+						atomic_read(&o->ncontended),
+						atomic_read(&o->nspinnable),
+						o->ntracked,
+						atomic_read(&o->ninlined),
+						o->function,
+						o->file,
+						o->line
+						);
+}
+
+static
+struct rb_root lock_stat_rbtree_db = RB_ROOT;
+
+static void lock_stat_rbtree_db_print(struct seq_file *seq);
+static void _lock_stat_rbtree_db_print(struct seq_file *seq, struct rb_node *node, int level);
+
+static void lock_stat_rbtree_db_zero(void);
+static void _lock_stat_rbtree_db_zero(struct rb_node *node);
+
+static
+void lock_stat_rbtree_db_zero(void) {
+	_lock_stat_rbtree_db_zero(lock_stat_rbtree_db.rb_node);
+}
+
+static
+void _lock_stat_rbtree_db_zero(struct rb_node *node) {
+
+	struct lock_stat *o = container_of(node, struct lock_stat, rb_node);
+
+	if (!node)
+		return;
+
+	_lock_stat_rbtree_db_zero(node->rb_left);
+	atomic_set(&o->ncontended, 0);
+	_lock_stat_rbtree_db_zero(node->rb_right);
+}
+
+static
+void lock_stat_rbtree_db_print(struct seq_file *seq) {
+	_lock_stat_rbtree_db_print(seq, lock_stat_rbtree_db.rb_node, 0);
+}
+
+static
+void _lock_stat_rbtree_db_print(struct seq_file *seq, struct rb_node *node, int level) {
+
+	struct lock_stat *o = container_of(node, struct lock_stat, rb_node);
+
+	if (!node)
+		return;
+
+	++level;
+
+	_lock_stat_rbtree_db_print(seq, node->rb_left, level);
+	lock_stat_print_entry(seq, o);
+	_lock_stat_rbtree_db_print(seq, node->rb_right, level);
+}
+
+static int missed = 0, attached = 0, left_insert = 0, right_insert = 0, calls = 0;
+
+static
+struct lock_stat *lock_stat_insert_rbtree_db(struct lock_stat *o)
+{
+	struct rb_node **p = &lock_stat_rbtree_db.rb_node;
+	struct rb_node *parent = NULL;
+	struct lock_stat *cursor;
+
+	++calls;
+	while (*p) {
+		parent = *p;
+		cursor = container_of(parent, struct lock_stat, rb_node);
+
+		if (lock_stat_compare_objs(o, cursor) < 0) {
+			p = &(*p)->rb_left;
+			++left_insert;
+		}
+		else if (lock_stat_compare_objs(o, cursor) > 0) {
+			p = &(*p)->rb_right;
+			++right_insert;
+		}
+		else { /* means we found a duplicate */
+			++missed;
+			return o;
+		}
+	}
+
+        rb_link_node(&o->rb_node, parent, p);
+	rb_insert_color(&o->rb_node, &lock_stat_rbtree_db);
+
+	++attached;
+
+	return NULL;
+}
+
+static
+struct lock_stat *lock_stat_lookup_rbtree_db(LOCK_STAT_NOTE_PARAM_DECL)
+{
+	struct rb_node *node = lock_stat_rbtree_db.rb_node;
+	struct lock_stat *cursor;
+
+	while (node)
+	{
+		cursor = container_of(node, struct lock_stat, rb_node);
+		/*
+		 * item less than-> left
+		 * item great than -> right
+		 *
+		 * The relationship of lock_stat_obj_compare() parameter is
+		 * reversed so reverse the comparison as well.
+		 */
+		if (lock_stat_compare_key_to_obj(LOCK_STAT_NOTE_VARS, cursor) < 0)
+			node = node->rb_left;
+		else if (lock_stat_compare_key_to_obj(LOCK_STAT_NOTE_VARS, cursor) > 0)
+			node = node->rb_right;
+		else
+			return cursor;
+	}
+	return NULL;
+}
+
+/* must hold persistent_store_lock */
+static
+struct lock_stat * lock_stat_lookup_persistent_store(LOCK_STAT_NOTE_PARAM_DECL)
+{
+#if 1
+	return lock_stat_lookup_rbtree_db(LOCK_STAT_NOTE_VARS);
+#else
+	struct list_head *e;
+
+	list_for_each(e, &lock_stat_persistent_store) {
+		struct lock_stat *s = container_of(e, struct lock_stat, list_head);
+
+		if (lock_stat_key_equals_obj(LOCK_STAT_NOTE_VARS, s)) {
+			return s;
+		}
+	}
+
+	return NULL;
+#endif
+}
+
+/* Must hold persistent_store_lock */
+static
+void lock_stat_insert_persistent_store(struct lock_stat *o)
+{
+#if 1
+	lock_stat_insert_rbtree_db(o);
+#else
+	BUG_ON(!_s);
+	list_add_tail(&_s->list_head, &lock_stat_persistent_store);
+#endif
+}
+
+#if 0
+static 
+void lock_stat_persistent_print_store(struct seq_file *seq) {
+	struct list_head *e;
+
+	list_for_each(e, &lock_stat_persistent_store) {
+		struct lock_stat *s;
+
+		s = container_of(e, struct lock_stat, list_head);
+		lock_stat_print_entry(seq, s);
+	}
+}
+
+static
+void lock_stat_insert_persistent_store_zero(struct lock_stat *o) {
+	struct list_head *e;
+	unsigned long flags;
+
+	spin_lock_irqsave(&persistent_store_lock, flags);
+	list_for_each(e, &lock_stat_persistent_store) {
+		struct lock_stat *s = container_of(e, struct lock_stat, list_head);
+
+		atomic_set(&s->ncontended, 0);
+	}
+	spin_unlock_irqrestore(&persistent_store_lock, flags);
+
+	lock_stat_reset_contention_count();
+}
+#endif
+
+/*
+ * (1) either immediately allocate or link the backing object at a spin_lock_init()
+ * call
+ *
+ * For rtmutexes that are statically scoped, there is a only one occurance of a
+ * mutex that exists and you only have to worry about one backing object for that
+ * instance. Blindly adding this to the lock_stat dictionary is ok since this
+ * happens only once and this should have little effect on the overall system.
+ * It's a one time operation at the first contention.
+ *
+ * For cases where a rtmutex is dynamically allocate and there multipule instances,
+ * you still track it with one backing object but it's connect to this object by
+ * the initialization point (file, function, line) of the rtmutex. That place in
+ * the source file is also used as an identifying key for that instance and it is
+ * used as to associate it with a backing statistical object. They are forever
+ * connected together from that point by that key. That backing object holds the
+ * total number of contentions and other stats for all objects associated with
+ * that key.
+ *
+ * There maybe other initialization points for that same structure effecting how
+ * the keys are utilized, but they should * all effectively be connected to a single
+ * lock_stat object representing the * overall contention behavior and use of that
+ * object.
+ *
+ * Connecting the rtmutex to the lock_stat object at spin_lock_init() time. It's
+ * not a critical path. There are cases where a C99 style struct initializer is
+ * used so I can't insert it into the lock_stat dictionary and those initializer
+ * must be converted to use spin_lock_init() instead.
+ *
+ */
+void lock_stat_scoped_attach(lock_stat_ref_t *_s, LOCK_STAT_NOTE_PARAM_DECL)
+{
+	unsigned long flags;
+	struct lock_stat *o = NULL;
+
+	BUG_ON(!_s);
+
+	if (!lock_stat_inited)
+		return;
+
+	if (_file == NULL || _function == NULL) {
+		*_s = &_lock_stat_null_entry;
+		return;
+	}
+
+	spin_lock_irqsave(&persistent_store_lock, flags);
+
+	/* If it doesn't exist, make the backing object and insert it
+	 * into the dictionary */
+
+	o = lock_stat_lookup_persistent_store(LOCK_STAT_NOTE_VARS);
+
+	if (!o) {
+		o = lock_stat_allocate_object();
+
+		BUG_ON(!o);
+
+		ksym_strcpy(o->function, _function);
+		o->file	= (char *)_file;
+		o->line	= _line;
+
+		*_s = o;
+		lock_stat_insert_persistent_store(o);
+	} else {
+		*_s = o;
+	}
+
+	++(*_s)->ntracked;
+	spin_unlock_irqrestore(&persistent_store_lock, flags);
+}
+
+
+static int found = 0;
+
+/*
+ * (2) This is for a late detection case for statically allocated spinlock structures.
+ */
+static
+void lock_stat_static_attach(lock_stat_ref_t *_s, LOCK_STAT_NOTE_PARAM_DECL)
+{
+	unsigned long flags;
+	struct lock_stat *o, *p;
+
+	BUG_ON(!_s);
+#if 1
+	if (_file == NULL || _function == NULL) {
+		*_s = &_lock_stat_null_entry;
+		return;
+	}
+
+	spin_lock_irqsave(&persistent_store_lock, flags);
+
+	/* try it again, just in case */
+	if (*_s)
+		goto out;
+
+	if ((p = lock_stat_lookup_persistent_store(LOCK_STAT_NOTE_VARS)))
+		++found;
+
+	o = lock_stat_allocate_object();
+
+	BUG_ON(!o);
+
+	*_s = o;
+	++((*_s)->ntracked);
+
+	ksym_strcpy(o->function, _function);
+	o->file		= (char *) _file;
+	o->line		= _line;
+
+	lock_stat_insert_persistent_store(o);
+
+out:
+	spin_unlock_irqrestore(&persistent_store_lock, flags);
+#endif
+}
+
+static
+char *ksym_get(unsigned long address, char *namebuffer)
+{ 
+	unsigned long offset = 0, symsize;
+	char *modname;
+	const char *symname;
+
+	symname = kallsyms_lookup(address, &symsize, &offset, &modname, namebuffer); 
+
+	if (!symname) {
+		return null_string;
+	}
+
+	return (char *) symname;
+}
+
+void lock_stat_note_contention(lock_stat_ref_t *_s, struct task_struct *owner, unsigned long ip)
+{
+	char ksym_scoped_namebuf[KSYM_NAME_LEN+1];
+
+	BUG_ON(!_s);
+
+	if (unlikely(!lock_stat_inited))
+		return;
+
+	ksym_scoped_namebuf[KSYM_NAME_LEN] = '\0';
+
+	if (unlikely(!(*_s))) {
+		char *r = NULL;
+	/*
+	 * Case (2) for statically defined rtmutex
+	 *
+	 * Fri Oct 27 00:26:08 PDT 2006
+	 * This is for the cases where a statically defined lock is passed to a structure
+	 * that's dynamically allocated. I didn't know that the kernel did this until today
+	 * looking at the function as_work_handler()
+	 */
+
+		r = ksym_get(ip, ksym_scoped_namebuf);
+		BUG_ON(strnlen(ksym_scoped_namebuf, KSYM_NAME_LEN) >= KSYM_NAME_LEN);
+
+		lock_stat_static_attach(_s, special_static_string, ksym_scoped_namebuf, 0);
+//		printk("%s: function [0x%08lx, %s]\n", __func__, ip, ksym_scoped_namebuf);
+	}
+
+	BUG_ON(!_s);
+
+//	if (task_curr(owner))
+//		atomic_inc(&((*_s)->nspinnable));
+//	else
+		atomic_inc(&((*_s)->ncontended));
+
+	atomic_inc(&per_cpu(lock_stat_total_events, get_cpu()));
+	put_cpu();
+
+}
+
+static int lock_stat_procfs_open(struct inode *, struct file *);
+static int lock_stat_procfs_write(struct file *file, const char *buf, size_t count, loff_t *off);
+
+struct proc_dir_entry *lock_stat_procfs_dir;
+struct proc_dir_entry *lock_stat_procfs_entry;
+
+static struct file_operations lock_stat_procfs_ops = {
+	.open		= lock_stat_procfs_open,
+	.read		= seq_read,
+	.write		= lock_stat_procfs_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static int lock_stat_procfs_init(void)
+{
+	int error = 0;
+
+	lock_stat_procfs_dir = proc_mkdir("lock_stat", NULL);
+	if (lock_stat_procfs_dir == NULL) {
+		error = -ENOMEM;
+		return error;
+	}
+
+	lock_stat_procfs_entry = create_proc_entry("contention", 0666, lock_stat_procfs_dir);
+	if (lock_stat_procfs_entry == NULL) {
+		error = -ENOMEM;
+		return error;
+	}
+	else {
+		lock_stat_procfs_entry->proc_fops = &lock_stat_procfs_ops;
+	}
+
+	return 0;
+}
+
+static int lock_stat_procfs_show(struct seq_file *sq, void *v) {
+	int cpu, count = 0;
+
+	for_each_possible_cpu(cpu) {
+		count += atomic_read(&per_cpu(lock_stat_total_events, cpu));
+	}
+
+	seq_printf(sq, "@contention events = %d\n", count);
+	seq_printf(sq, "@found = %d\n", found);
+
+	lock_stat_rbtree_db_print(sq);
+	return 0;
+}
+
+static int lock_stat_procfs_write (struct file *file, const char *buf, size_t count, loff_t *off)
+{
+#if 1
+	lock_stat_rbtree_db_zero();
+#else
+	lock_stat_persistent_store_zero();
+#endif
+	lock_stat_reset_contention_count();
+	return count;
+}
+
+static int lock_stat_procfs_open(struct inode *inode, struct file *file) {
+	return single_open (file, &lock_stat_procfs_show, NULL /* void *data */);
+}
+

--r5Pyd7+fXNt84Ff3--
