Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266138AbUHVEtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUHVEtu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 00:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUHVEtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 00:49:50 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:41068 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266138AbUHVEti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 00:49:38 -0400
Message-ID: <4128252E.1080002@yahoo.com.au>
Date: Sun, 22 Aug 2004 14:46:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] use hlist for pid hash
References: <412824BE.4040801@yahoo.com.au>
In-Reply-To: <412824BE.4040801@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------060807030905090507060305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060807030905090507060305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Any reason why this shouldn't be done? Anyone know of a decent test that
stresses the pid hash?

--------------060807030905090507060305
Content-Type: text/x-patch;
 name="pid-use-hlist.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pid-use-hlist.patch"



Use hlists for the PID hashes. This halves the memory footprint of these
hashes. No benchmarks, but I think this is a worthy improvement because
the hashes are something that would be likely to have significant portions
loaded into the cache of every CPU on some workloads.

This comes at the "expense" of
	1. reintroducing the memory  prefetch into the hash traversal loop;
	2. adding new pids to the head of the list instead of the tail. I
	   suspect that if this was a big problem then the hash isn't sized
	   well or could benefit from moving hot entries to the head.

Also, account for all the pid hashes when reporting hash memory usage.


---

 linux-2.6-npiggin/include/linux/pid.h |    2 +-
 linux-2.6-npiggin/kernel/pid.c        |   19 ++++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff -puN kernel/pid.c~pid-use-hlist kernel/pid.c
--- linux-2.6/kernel/pid.c~pid-use-hlist	2004-08-22 14:42:56.000000000 +1000
+++ linux-2.6-npiggin/kernel/pid.c	2004-08-22 14:42:56.000000000 +1000
@@ -27,7 +27,7 @@
 #include <linux/hash.h>
 
 #define pid_hashfn(nr) hash_long((unsigned long)nr, pidhash_shift)
-static struct list_head *pid_hash[PIDTYPE_MAX];
+static struct hlist_head *pid_hash[PIDTYPE_MAX];
 static int pidhash_shift;
 
 int pid_max = PID_MAX_DEFAULT;
@@ -150,11 +150,11 @@ failure:
 
 fastcall struct pid *find_pid(enum pid_type type, int nr)
 {
-	struct list_head *elem, *bucket = &pid_hash[type][pid_hashfn(nr)];
+	struct hlist_node *elem;
 	struct pid *pid;
 
-	__list_for_each(elem, bucket) {
-		pid = list_entry(elem, struct pid, hash_chain);
+	hlist_for_each_entry(pid, elem,
+			&pid_hash[type][pid_hashfn(nr)], hash_chain) {
 		if (pid->nr == nr)
 			return pid;
 	}
@@ -181,7 +181,8 @@ int fastcall attach_pid(task_t *task, en
 		INIT_LIST_HEAD(&pid->task_list);
 		pid->task = task;
 		get_task_struct(task);
-		list_add(&pid->hash_chain, &pid_hash[type][pid_hashfn(nr)]);
+		hlist_add_head(&pid->hash_chain,
+				&pid_hash[type][pid_hashfn(nr)]);
 	}
 	list_add_tail(&task->pids[type].pid_chain, &pid->task_list);
 	task->pids[type].pidptr = pid;
@@ -200,7 +201,7 @@ static inline int __detach_pid(task_t *t
 		return 0;
 
 	nr = pid->nr;
-	list_del(&pid->hash_chain);
+	hlist_del(&pid->hash_chain);
 	put_task_struct(pid->task);
 
 	return nr;
@@ -282,9 +283,9 @@ void __init pidhash_init(void)
 	pidhash_shift = min(12, pidhash_shift);
 	pidhash_size = 1 << pidhash_shift;
 
-	printk("PID hash table entries: %d (order %d: %Zd bytes)\n",
+	printk("PID hash table entries: %d (order: %d, %Zd bytes)\n",
 		pidhash_size, pidhash_shift,
-		pidhash_size * sizeof(struct list_head));
+		PIDTYPE_MAX * pidhash_size * sizeof(struct hlist_head));
 
 	for (i = 0; i < PIDTYPE_MAX; i++) {
 		pid_hash[i] = alloc_bootmem(pidhash_size *
@@ -292,7 +293,7 @@ void __init pidhash_init(void)
 		if (!pid_hash[i])
 			panic("Could not alloc pidhash!\n");
 		for (j = 0; j < pidhash_size; j++)
-			INIT_LIST_HEAD(&pid_hash[i][j]);
+			INIT_HLIST_HEAD(&pid_hash[i][j]);
 	}
 #ifdef CONFIG_KGDB
 	kgdb_pid_init_done++;
diff -puN include/linux/pid.h~pid-use-hlist include/linux/pid.h
--- linux-2.6/include/linux/pid.h~pid-use-hlist	2004-08-22 14:42:56.000000000 +1000
+++ linux-2.6-npiggin/include/linux/pid.h	2004-08-22 14:42:56.000000000 +1000
@@ -16,7 +16,7 @@ struct pid
 	atomic_t count;
 	struct task_struct *task;
 	struct list_head task_list;
-	struct list_head hash_chain;
+	struct hlist_node hash_chain;
 };
 
 struct pid_link

_

--------------060807030905090507060305--
