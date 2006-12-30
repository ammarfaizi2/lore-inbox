Return-Path: <linux-kernel-owner+w=401wt.eu-S1755131AbWL3O47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbWL3O47 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 09:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755136AbWL3O47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 09:56:59 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:23736 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131AbWL3O46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 09:56:58 -0500
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2 [was Re: 2.6.19-rt14
	slowdown compared to 2.6.19]
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <billh@gnuppy.monkey.org>, "Chen, Tim C" <tim.c.chen@intel.com>,
       linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20061230111940.GA8412@elte.hu>
References: <9D2C22909C6E774EBFB8B5583AE5291C019998CA@fmsmsx414.amr.corp.intel.com>
	 <20061229232618.GA11239@gnuppy.monkey.org>  <20061230111940.GA8412@elte.hu>
Content-Type: text/plain
Date: Sat, 30 Dec 2006 06:56:08 -0800
Message-Id: <1167490569.14081.71.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-30 at 12:19 +0100, Ingo Molnar wrote:

> 
>  - Documentation/CodingStyle compliance - the code is not ugly per se
>    but still looks a bit 'alien' - please try to make it look Linuxish,
>    if i apply this we'll probably stick with it forever. This is the
>    major reason i havent applied it yet.

I did some cleanup while reviewing the patch, nothing very exciting but
it's an attempt to bring it more into the "Linuxish" scope .. I didn't
compile it so be warned.

There lots of ifdef'd code under CONFIG_LOCK_STAT inside rtmutex.c I
suspect it would be a benefit to move that all into a header and ifdef
only in the header .

Daniel



Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/lock_stat.h |   25 +++++++++++++++----------
 kernel/lock_stat.c        |   34 ++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 22 deletions(-)

Index: linux-2.6.19/include/linux/lock_stat.h
===================================================================
--- linux-2.6.19.orig/include/linux/lock_stat.h
+++ linux-2.6.19/include/linux/lock_stat.h
@@ -26,9 +26,9 @@
 #include <asm/atomic.h>
 
 typedef struct lock_stat {
-	char	function[KSYM_NAME_LEN];
-	int	line;
-	char	*file;
+	char			function[KSYM_NAME_LEN];
+	int			line;
+	char			*file;
 
 	atomic_t		ncontended;
 	atomic_t		nhandoff;
@@ -52,7 +52,7 @@ struct task_struct;
 #define LOCK_STAT_INIT(field)
 #define LOCK_STAT_INITIALIZER(field) { 			\
 		__FILE__, __FUNCTION__, __LINE__,	\
-		ATOMIC_INIT(0), LIST_HEAD_INIT(field)}
+		ATOMIC_INIT(0), LIST_HEAD_INIT(field) }
 
 #define LOCK_STAT_NOTE			__FILE__, __FUNCTION__, __LINE__
 #define LOCK_STAT_NOTE_VARS		_file, _function, _line
@@ -84,9 +84,12 @@ extern void lock_stat_sys_init(void);
 
 #define lock_stat_is_initialized(o) ((unsigned long) (*o)->file)
 
-extern void lock_stat_note_contention(lock_stat_ref_t *ls, struct task_struct *owner, unsigned long ip, int handoff);
+extern void lock_stat_note_contention(lock_stat_ref_t *ls,
+				      struct task_struct *owner,
+				      unsigned long ip, int handoff);
 extern void lock_stat_print(void);
-extern void lock_stat_scoped_attach(lock_stat_ref_t *_s, LOCK_STAT_NOTE_PARAM_DECL);
+extern void lock_stat_scoped_attach(lock_stat_ref_t *_s,
+				    LOCK_STAT_NOTE_PARAM_DECL);
 
 #define ksym_strcmp(a, b) strncmp(a, b, KSYM_NAME_LEN)
 #define ksym_strcpy(a, b) strncpy(a, b, KSYM_NAME_LEN)
@@ -102,10 +105,11 @@ static inline char * ksym_strdup(const c
 
 #define LS_INIT(name, h) {				\
 	/*.function,*/ .file = h, .line = 1,		\
-	.nhandoff = ATOMIC_INIT(0), .ntracked = 0, .ncontended = ATOMIC_INIT(0),	\
+	.nhandoff = ATOMIC_INIT(0), .ntracked = 0,	\
+	.ncontended = ATOMIC_INIT(0),			\
 	.list_head = LIST_HEAD_INIT(name.list_head),	\
-	.rb_node.rb_left = NULL, .rb_node.rb_left = NULL \
-	}
+	.rb_node.rb_left = NULL,			\
+	.rb_node.rb_left = NULL }			\
 
 #define DECLARE_LS_ENTRY(name)				\
 	extern struct lock_stat _lock_stat_##name##_entry
@@ -114,7 +118,8 @@ static inline char * ksym_strdup(const c
 */
 
 #define DEFINE_LS_ENTRY(name)				\
-	struct lock_stat _lock_stat_##name##_entry = LS_INIT(_lock_stat_##name##_entry, #name "_string")
+	struct lock_stat _lock_stat_##name##_entry = 	\
+		LS_INIT(_lock_stat_##name##_entry, #name "_string")
 
 DECLARE_LS_ENTRY(d_alloc);
 DECLARE_LS_ENTRY(eventpoll_init_file);
Index: linux-2.6.19/kernel/lock_stat.c
===================================================================
--- linux-2.6.19.orig/kernel/lock_stat.c
+++ linux-2.6.19/kernel/lock_stat.c
@@ -71,7 +71,9 @@ static char null_string[]		= "";
 static char static_string[]		= "-";
 static char special_static_string[]	= "-";
 
-struct lock_stat _lock_stat_null_entry	= LS_INIT(_lock_stat_null_entry,   null_string);
+struct lock_stat _lock_stat_null_entry	=
+	LS_INIT(_lock_stat_null_entry, null_string);
+
 EXPORT_SYMBOL(_lock_stat_null_entry);
 
 static DEFINE_LS_ENTRY(inline);		/* lock_stat_inline_entry	*/
@@ -111,10 +113,12 @@ static DEFINE_LS_ENTRY(tcp_init_1);
 static DEFINE_LS_ENTRY(tcp_init_2);
 */
 
-/* I should never have to create more entries that this since I audited the kernel
- * and found out that there are only ~1500 or so places in the kernel where these
- * rw/spinlocks are initialized. Use the initialization points as a hash value to
- * look up the backing objects */
+/*
+ * I should never have to create more entries that this since I audited the
+ * kernel and found out that there are only ~1500 or so places in the kernel
+ * where these rw/spinlocks are initialized. Use the initialization points as a
+ * hash value to look up the backing objects
+ */
 
 #define MAGIC_ENTRIES 1600
 
@@ -156,7 +160,7 @@ void lock_stat_sys_init(void)
 	int i;
 
 	for (i = 0; i < MAGIC_ENTRIES; ++i) {
-		s = (struct lock_stat *) kmalloc(sizeof(struct lock_stat), GFP_KERNEL);
+		s = kmalloc(sizeof(struct lock_stat), GFP_KERNEL);
 
 		if (s) {
 			lock_stat_init(s);
@@ -182,7 +186,8 @@ void lock_stat_sys_init(void)
 }
 
 static
-struct lock_stat *lock_stat_allocate_object(void) {
+struct lock_stat *lock_stat_allocate_object(void)
+{
 	unsigned long flags;
 
 	spin_lock_irqsave(&free_store_lock, flags);
@@ -208,7 +213,8 @@ struct lock_stat *lock_stat_allocate_obj
  * Comparision, greater to/less than or equals. zero is equals.
  * Suitable for ordered insertion into a tree
  *
- * The (entry - object) order of comparison is switched from the parameter definition
+ * The (entry - object) order of comparison is switched from the parameter
+ * definition
  */
 static
 int lock_stat_compare_objs(struct lock_stat *a, struct lock_stat *b)
@@ -254,7 +260,8 @@ void lock_stat_print_hash(struct lock_st
 }
 
 static
-void lock_stat_print_entry(struct seq_file *seq, struct lock_stat *o) {
+void lock_stat_print_entry(struct seq_file *seq, struct lock_stat *o)
+{
 	seq_printf(seq, "[%d, %d, %d :: %d, %d]\t\t{%s, %s, %d}\n",
 						atomic_read(&o->ncontended),
 						atomic_read(&o->nspinnable),
@@ -282,7 +289,8 @@ void lock_stat_rbtree_db_zero(void) {
 }
 
 static
-void _lock_stat_rbtree_db_zero(struct rb_node *node) {
+void _lock_stat_rbtree_db_zero(struct rb_node *node)
+{
 
 	struct lock_stat *o = container_of(node, struct lock_stat, rb_node);
 
@@ -295,12 +303,14 @@ void _lock_stat_rbtree_db_zero(struct rb
 }
 
 static
-void lock_stat_rbtree_db_print(struct seq_file *seq) {
+void lock_stat_rbtree_db_print(struct seq_file *seq)
+{
 	_lock_stat_rbtree_db_print(seq, lock_stat_rbtree_db.rb_node, 0);
 }
 
 static
-void _lock_stat_rbtree_db_print(struct seq_file *seq, struct rb_node *node, int level) {
+void _lock_stat_rbtree_db_print(struct seq_file *seq, struct rb_node *node, int level)
+{
 
 	struct lock_stat *o = container_of(node, struct lock_stat, rb_node);
 



