Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSKGTUx>; Thu, 7 Nov 2002 14:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbSKGTUx>; Thu, 7 Nov 2002 14:20:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:47083 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261505AbSKGTUv>;
	Thu, 7 Nov 2002 14:20:51 -0500
Message-ID: <3DCABE9D.F71530DB@digeo.com>
Date: Thu, 07 Nov 2002 11:27:25 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Templates and tweaks (for size performance and more)
References: <20021107190910.GC6164@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 19:27:25.0132 (UTC) FILETIME=[B399F0C0:01C28693]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> Comments?

You missed this little fella: 

   text    data     bss     dec     hex filename
   1735    1120  131104  133959   20b47 kernel/pid.o


Have a controversial patch which takes it to:

   text    data     bss     dec     hex filename
   1614    1120    2080    4814    12ce kernel/pid.o



 include/linux/pid.h |    1 +
 kernel/pid.c        |   24 +++++++++++++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)

--- 25/kernel/pid.c~unbloat-pid	Sun Oct 27 23:43:15 2002
+++ 25-akpm/kernel/pid.c	Sun Oct 27 23:43:15 2002
@@ -22,11 +22,13 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include <linux/hash.h>
 #include <linux/bootmem.h>
 
-#define PIDHASH_SIZE 4096
-#define pid_hashfn(nr) ((nr >> 8) ^ nr) & (PIDHASH_SIZE - 1)
-static struct list_head pid_hash[PIDTYPE_MAX][PIDHASH_SIZE];
+#define PIDHASH_SHIFT 8
+#define PIDHASH_SIZE (1 << PIDHASH_SHIFT)
+#define pid_hashfn(nr, type) hash_long(nr * PIDTYPE_MAX + type, PIDHASH_SHIFT)
+static struct list_head pid_hash[PIDHASH_SIZE];
 
 int pid_max = PID_MAX_DEFAULT;
 int last_pid;
@@ -146,12 +148,12 @@ failure:
 
 inline struct pid *find_pid(enum pid_type type, int nr)
 {
-	struct list_head *elem, *bucket = &pid_hash[type][pid_hashfn(nr)];
+	struct list_head *elem, *bucket = &pid_hash[pid_hashfn(nr, type)];
 	struct pid *pid;
 
 	__list_for_each(elem, bucket) {
 		pid = list_entry(elem, struct pid, hash_chain);
-		if (pid->nr == nr)
+		if (pid->nr == nr && pid->type == type)
 			return pid;
 	}
 	return NULL;
@@ -173,11 +175,12 @@ int attach_pid(task_t *task, enum pid_ty
 	else {
 		pid = &task->pids[type].pid;
 		pid->nr = nr;
+		pid->type = type;
 		atomic_set(&pid->count, 1);
 		INIT_LIST_HEAD(&pid->task_list);
 		pid->task = task;
 		get_task_struct(task);
-		list_add(&pid->hash_chain, &pid_hash[type][pid_hashfn(nr)]);
+		list_add(&pid->hash_chain, &pid_hash[pid_hashfn(nr, type)]);
 	}
 	list_add_tail(&task->pids[type].pid_chain, &pid->task_list);
 	task->pids[type].pidptr = pid;
@@ -260,7 +263,7 @@ void switch_exec_pids(task_t *leader, ta
 
 void __init pidhash_init(void)
 {
-	int i, j;
+	int i;
 
 	/*
 	 * Allocate PID 0, and hash it via all PID types:
@@ -269,9 +272,8 @@ void __init pidhash_init(void)
 	set_bit(0, pidmap_array->page);
 	atomic_dec(&pidmap_array->nr_free);
 
-	for (i = 0; i < PIDTYPE_MAX; i++) {
-		for (j = 0; j < PIDHASH_SIZE; j++)
-			INIT_LIST_HEAD(&pid_hash[i][j]);
+	for (i = 0; i < ARRAY_SIZE(pid_hash); i++)
+		INIT_LIST_HEAD(&pid_hash[i]);
+	for (i = 0; i < PIDTYPE_MAX; i++)
 		attach_pid(current, i, 0);
-	}
 }
--- 25/include/linux/pid.h~unbloat-pid	Sun Oct 27 23:43:15 2002
+++ 25-akpm/include/linux/pid.h	Sun Oct 27 23:43:15 2002
@@ -13,6 +13,7 @@ enum pid_type
 struct pid
 {
 	int nr;
+	enum pid_type type;
 	atomic_t count;
 	struct task_struct *task;
 	struct list_head task_list;

.
