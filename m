Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136472AbREDRwm>; Fri, 4 May 2001 13:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136473AbREDRwd>; Fri, 4 May 2001 13:52:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:27574 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136472AbREDRwV>;
	Fri, 4 May 2001 13:52:21 -0400
Date: Fri, 4 May 2001 13:52:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Todd Inglett <tinglett@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Re: SMP races in proc with thread_struct
In-Reply-To: <3AF2A1CC.C22A48E7@vnet.ibm.com>
Message-ID: <Pine.GSO.4.21.0105041319520.19970-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, could you consider the patch below? As it is, access to
/proc/<pid>/status of dead process with dead parent is possible and
leads to access to freed memory. Besides, cd /proc/<pid> means
that even after <pid> is gone, readdir() _and_ lookup on /proc/<pid> work.
Patch makes sure that ->p_pptr is NULL once the process is gone (fixes
readdir/lookup stuff) and adds obvious couple of checks in array.c.
								Al

diff -urN S5-pre1/fs/proc/array.c S5-pre1-p_pptr/fs/proc/array.c
--- S5-pre1/fs/proc/array.c	Sat Apr 28 02:12:56 2001
+++ S5-pre1-p_pptr/fs/proc/array.c	Fri May  4 13:15:47 2001
@@ -157,7 +157,9 @@
 		"Uid:\t%d\t%d\t%d\t%d\n"
 		"Gid:\t%d\t%d\t%d\t%d\n",
 		get_task_state(p),
-		p->pid, p->p_opptr->pid, p->p_pptr->pid != p->p_opptr->pid ? p->p_pptr->pid : 0,
+		p->pid, p->p_opptr->pid,
+		p->p_pptr && p->p_pptr->pid != p->p_opptr->pid
+			? p->p_pptr->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);	
@@ -339,7 +341,7 @@
 	nice = task->nice;
 
 	read_lock(&tasklist_lock);
-	ppid = task->p_opptr->pid;
+	ppid = task->p_pptr ? task->p_opptr->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
diff -urN S5-pre1/kernel/exit.c S5-pre1-p_pptr/kernel/exit.c
--- S5-pre1/kernel/exit.c	Fri Feb 16 22:52:15 2001
+++ S5-pre1-p_pptr/kernel/exit.c	Fri May  4 13:18:33 2001
@@ -62,6 +62,9 @@
 		current->counter += p->counter;
 		if (current->counter >= MAX_COUNTER)
 			current->counter = MAX_COUNTER;
+		write_lock_irq(&tasklist_lock);
+		p->p_pptr = NULL;
+		write_unlock_irq(&tasklist_lock);
 		free_task_struct(p);
 	} else {
 		printk("task releasing itself\n");


