Return-Path: <linux-kernel-owner+w=401wt.eu-S1161138AbWLPQ7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWLPQ7s (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWLPQ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:59:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40336 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161138AbWLPQ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:59:47 -0500
Date: Sat, 16 Dec 2006 17:57:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061216165738.GA5165@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> This series of patches represent version 0.13 of the kernel memory 
> leak detector. See the Documentation/kmemleak.txt file for a more 
> detailed description. The patches are downloadable from (the whole 
> patch or the broken-out series) http://www.procode.org/kmemleak/

nice stuff!

FYI, i'm working on integrating kmemleak into -rt. Firstly, i needed the 
fixes below when applying it ontop of 2.6.19-rt15.

Secondly, i'm wondering about the following recursion:

 [<c045a7e1>] rt_spin_lock_slowlock+0x98/0x1dc
 [<c045b16b>] rt_spin_lock+0x13/0x4b
 [<c018f155>] kfree+0x3a/0xce
 [<c0192e79>] hash_delete+0x58/0x5f
 [<c019309b>] memleak_free+0xe9/0x1e6
 [<c018ed2e>] __cache_free+0x27/0x414
 [<c018f1d0>] kfree+0xb5/0xce
 [<c02788dd>] acpi_ns_get_node+0xb1/0xbb
 [<c02772fa>] acpi_ns_root_initialize+0x30f/0x31d
 [<c0280194>] acpi_initialize_subsystem+0x58/0x87
 [<c06a4641>] acpi_early_init+0x4f/0x12e
 [<c06888bc>] start_kernel+0x41b/0x44b

kfree() within kfree() ... this probably works on the upstream SLAB 
allocator but makes it pretty nasty to sort out SLAB locking in -rt. 

Wouldnt it be better to just preallocate the hash nodes, like lockdep 
does, to avoid conceptual nesting? Basically debugging infrastructure 
should rely on other infrastructure as little as possible.

also, the number of knobs in the Kconfig is quite large:

 CONFIG_DEBUG_MEMLEAK=y
 CONFIG_DEBUG_MEMLEAK_HASH_BITS=16
 CONFIG_DEBUG_MEMLEAK_TRACE_LENGTH=4
 CONFIG_DEBUG_MEMLEAK_PREINIT_OBJECTS=512
 CONFIG_DEBUG_MEMLEAK_SECONDARY_ALIASES=y
 CONFIG_DEBUG_MEMLEAK_TASK_STACKS=y

i'd suggest to simplify the Kconfig choices to a binary thing: either 
have kmemleak or not have it.

plus the Kconfig dependency on SLAB_DEBUG makes it less likely for 
people to spontaneously try kmemleak. I'd suggest to offer KMEMLEAK 
unconditionally (when KERNEL_DEBUG is specified) and simply select 
SLAB_DEBUG.

	Ingo

---
 fs/fcntl.c           |    4 ++--
 fs/mbcache.c         |    2 +-
 include/linux/list.h |    9 +++++++++
 include/linux/pid.h  |    7 +++++++
 kernel/pid.c         |    2 +-
 5 files changed, 20 insertions(+), 4 deletions(-)

Index: linux/fs/fcntl.c
===================================================================
--- linux.orig/fs/fcntl.c
+++ linux/fs/fcntl.c
@@ -512,7 +512,7 @@ void send_sigio(struct fown_struct *fown
 		goto out_unlock_fown;
 	
 	read_lock(&tasklist_lock);
-	do_each_pid_task(pid, type, p) {
+	__do_each_pid_task(pid, type, p) {
 		send_sigio_to_task(p, fown, fd, band);
 	} while_each_pid_task(pid, type, p);
 	read_unlock(&tasklist_lock);
@@ -543,7 +543,7 @@ int send_sigurg(struct fown_struct *fown
 	ret = 1;
 	
 	read_lock(&tasklist_lock);
-	do_each_pid_task(pid, type, p) {
+	__do_each_pid_task(pid, type, p) {
 		send_sigurg_to_task(p, fown);
 	} while_each_pid_task(pid, type, p);
 	read_unlock(&tasklist_lock);
Index: linux/fs/mbcache.c
===================================================================
--- linux.orig/fs/mbcache.c
+++ linux/fs/mbcache.c
@@ -555,7 +555,7 @@ __mb_cache_entry_find(struct list_head *
 {
 	while (l != head) {
 		struct mb_cache_entry *ce =
-			list_entry(l, struct mb_cache_entry,
+			__list_entry(l, struct mb_cache_entry,
 			           e_indexes[index].o_list);
 		if (ce->e_bdev == bdev && ce->e_indexes[index].o_key == key) {
 			DEFINE_WAIT(wait);
Index: linux/include/linux/list.h
===================================================================
--- linux.orig/include/linux/list.h
+++ linux/include/linux/list.h
@@ -367,6 +367,8 @@ static inline void list_splice_init(stru
  */
 #define list_entry(ptr, type, member) \
 	container_of(ptr, type, member)
+#define __list_entry(ptr, type, member) \
+	__container_of(ptr, type, member)
 
 /**
  * list_for_each	-	iterate over a list
@@ -822,6 +824,7 @@ static inline void hlist_add_after_rcu(s
 }
 
 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
+#define __hlist_entry(ptr, type, member) __container_of(ptr,type,member)
 
 #define hlist_for_each(pos, head) \
 	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
@@ -897,6 +900,12 @@ static inline void hlist_add_after_rcu(s
 	     rcu_dereference(pos) && ({ prefetch(pos->next); 1;}) &&	 \
 		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
 	     pos = pos->next)
+#define __hlist_for_each_entry_rcu(tpos, pos, head, member)		 \
+	for (pos = (head)->first;					 \
+	     rcu_dereference(pos) && ({ prefetch(pos->next); 1;}) &&	 \
+		({ tpos = __hlist_entry(pos, typeof(*tpos), member); 1;}); \
+	     pos = pos->next)
+
 
 #else
 #warning "don't include kernel headers in userspace"
Index: linux/include/linux/pid.h
===================================================================
--- linux.orig/include/linux/pid.h
+++ linux/include/linux/pid.h
@@ -125,6 +125,13 @@ static inline pid_t pid_nr(struct pid *p
 			hlist_for_each_entry_rcu((task), pos___,	\
 				&pid->tasks[type], pids[type].node) {
 
+#define __do_each_pid_task(pid, type, task)				\
+	do {								\
+		struct hlist_node *pos___;				\
+		if (pid != NULL)					\
+			__hlist_for_each_entry_rcu((task), pos___,	\
+				&pid->tasks[type], pids[type].node) {
+
 #define while_each_pid_task(pid, type, task)				\
 			}						\
 	} while (0)
Index: linux/kernel/pid.c
===================================================================
--- linux.orig/kernel/pid.c
+++ linux/kernel/pid.c
@@ -289,7 +289,7 @@ struct task_struct * fastcall pid_task(s
 		struct hlist_node *first;
 		first = rcu_dereference(pid->tasks[type].first);
 		if (first)
-			result = hlist_entry(first, struct task_struct, pids[(type)].node);
+			result = __container_of(first, struct task_struct, pids[(type)].node);
 	}
 	return result;
 }
