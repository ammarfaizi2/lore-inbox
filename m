Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbRBTWtk>; Tue, 20 Feb 2001 17:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbRBTWtb>; Tue, 20 Feb 2001 17:49:31 -0500
Received: from auemail1.lucent.com ([192.11.223.161]:46803 "EHLO
	auemlsrv.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S129563AbRBTWtX>; Tue, 20 Feb 2001 17:49:23 -0500
Cc: torvalds@transmeta.com, alan@redhat.com
Message-ID: <3A92F460.E732BE37@avaya.com>
Date: Tue, 20 Feb 2001 15:49:04 -0700
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
Organization: Avaya Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Original-CC: torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] SysV IPC semaphores, kernel 2.2.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soliciting comments to some enhancements I have made to the
implementation of SysV semaphores in the 2.2 kernel, to clean up kernel
resources (semaphores) on process exits. Please Cc: me at
bhavesh(at)avaya.com

Thanks,
- Bhavesh 
-- 
Bhavesh P. Davda
Avaya Inc.

--- /root2/usr/src/linux-2.2.16/ipc/sem.c       Wed May  3 18:16:53 2000
+++ /usr/src/linux-2.2.16/ipc/sem.c     Tue Feb 20 15:04:25 2001
@@ -48,6 +48,23 @@
  *      better but only get the semops right which only wait for zero
or
  *      increase. If there are decrement operations in the operations
  *      array we do the same as before.
+ *
+ * Enhancements added February 2001:
+ * Copyright (C) 2001 Bhavesh Davda
+ *  One can ask for semaphores that are accounted for using two new
flags
+ *  when creating the semaphore set:
+ *  IPC_CLNUP:  maintains a count of the number of processes that have
a
+ *              handle to the semaphore set, and frees the semaphore
set
+ *              when the last process with a handle to the set goes
away
+ *  IPC_TMWU:   (Take Me With U) frees the semaphore set when the
creator
+ *              of the semaphore set goes away
+ * These enhancements were added to plug a Denial-Of-Service hole that
has
+ * always existed with semaphores as a system resource. Accidental DOS,
for
+ * example "kill -9" leaving semaphore sets around can be prevented by 
+ * freeing system resources when they are no longer being used, by 
+ * passing these flags when creating the semaphores.
+ * WORK NEEDED: locks to protect data structures (linked lists) from
race
+ * conditions (specifically in insertlist(), deletelist() and
eatlist())
  */
 
 #include <linux/malloc.h>
@@ -66,6 +83,26 @@
 static struct wait_queue *sem_lock = NULL;
 static int max_semid = 0;
 
+struct proclist {
+       struct proclist *next;
+       pid_t pid;
+};
+
+struct semproc {
+       int numclients;
+       pid_t creator;
+       struct proclist *head;
+};
+
+static struct semproc persemid[SEMMNI];
+
+struct semlist {
+       struct semlist *next;
+       int semid;
+};
+
+static struct semlist *perprocess[PID_MAX];
+
 static unsigned short sem_seq = 0;
 
 void __init sem_init (void)
@@ -74,11 +111,191 @@
 
        sem_lock = NULL;
        used_sems = used_semids = max_semid = sem_seq = 0;
-       for (i = 0; i < SEMMNI; i++)
+       for (i = 0; i < SEMMNI; i++) {
                semary[i] = (struct semid_ds *) IPC_UNUSED;
+               persemid[i].numclients = SEM_DONTCOUNT;
+               persemid[i].creator = SEM_DONTCOUNT;
+               persemid[i].head = NULL;
+       }
+       for (i = 0; i < PID_MAX; i++) {
+               perprocess[i] = NULL;
+       }
        return;
 }
 
+static void insertlist(int pid, int semid)
+{
+       struct semlist *newsem;
+       struct proclist *newproc;
+       /* create a new node for the per process list */
+       newsem = (struct semlist *) 
+               kmalloc(sizeof(struct semlist), GFP_ATOMIC);
+       newsem->semid = semid;
+       newsem->next = NULL;
+       if (perprocess[pid]) {
+               /* linked list exists, prepend to it */
+               newsem->next = perprocess[pid];
+       }
+       perprocess[pid] = newsem;
+
+       /* create a new node for the per semid list */
+       newproc = (struct proclist *) 
+               kmalloc(sizeof(struct proclist), GFP_ATOMIC);
+       newproc->pid = pid;
+       newproc->next = NULL;
+       if (persemid[semid].head) {
+               /* linked list exists, prepend to it */
+               newproc->next = persemid[semid].head;
+       }
+       persemid[semid].head = newproc;
+}
+
+#ifdef DEBUG
+static void dumplists (int pid, int semid)
+{
+       struct semlist *currsem;
+       struct proclist *currproc;
+
+       printk("Linked list of semids for pid %d\n", pid);
+       currsem = perprocess[pid];
+       while (currsem) {
+               printk("[%d]->", currsem->semid);
+               currsem = currsem->next;
+       }
+       printk("$\n");
+
+       printk("Linked list of pids for semid %d\n", semid);
+       currproc = persemid[semid].head;
+       while (currproc) {
+               printk("[%d]->", currproc->pid);
+               currproc = currproc->next;
+       }
+       printk("$\n");
+}
+#endif
+
+static void deletelist(int pid, int semid)
+{
+       struct semlist *currsem, *prevsem;
+       struct proclist *currproc, *prevproc;
+
+       /* first delete semaphore from perprocess list */
+       prevsem = NULL;
+       currsem = perprocess[pid];
+
+       while (currsem && (currsem->semid != semid)) {
+               prevsem = currsem;
+               currsem = currsem->next;
+       }
+
+       /* didn't find it */
+       if (currsem == NULL) {
+               return;
+       }
+
+#ifdef DEBUG
+printk("deletelist: About to remove node semid %d from
perprocess[%d]\n",
+               semid, pid);
+#endif
+       if (prevsem == NULL) {
+               /* head of list */
+               perprocess[pid] = currsem->next;
+       } else {
+               /* middle of list */
+               prevsem->next = currsem->next;
+       }
+       kfree(currsem);
+#ifdef DEBUG
+printk("deletelist: Removed node semid %d from perprocess[%d]\n",
+               semid, pid);
+#endif
+
+       /* next delete process from per semid list */
+       prevproc = NULL;
+       currproc = persemid[semid].head;
+
+       while (currproc && (currproc->pid != pid)) {
+               prevproc = currproc;
+               currproc = currproc->next;
+       }
+
+       /* didn't find it */
+       if (currproc == NULL) {
+               return;
+       }
+
+#ifdef DEBUG
+printk("deletelist: About to remove node pid %d from persemid[%d]\n",
+               pid, semid);
+#endif
+       if (prevproc == NULL) {
+               /* head of list */
+               persemid[semid].head = currproc->next;
+       } else {
+               /* middle of list */
+               prevproc->next = currproc->next;
+       }
+       kfree(currproc);
+#ifdef DEBUG 
+printk("deletelist: Removed node pid %d from persemid[%d]\n",
+               pid, semid);
+printk("Calling dumplists(%d, %d) from deletelist\n", pid, semid);
+dumplists(pid, semid);
+#endif
+}
+
+static void eatlist(int pid)
+{
+       struct semlist *currelem, *prevelem;
+       int semid;
+       prevelem = NULL;
+       currelem = perprocess[pid];
+       while (currelem) {
+               semid = currelem->semid;
+#ifdef DEBUG
+printk("eatlist: About to remove node semid %d from perprocess[%d]\n",
semid, pid);
+#endif
+               prevelem = currelem;
+               currelem = currelem->next;
+               /* only delete semaphore from perprocess list */
+               perprocess[pid] = currelem;
+               kfree(prevelem);
+#ifdef DEBUG
+printk("eatlist: Removed node semid %d from perprocess[%d]\n", semid,
pid);
+printk("Calling dumplists(%d, %d) from eatlist\n", pid, semid);
+dumplists(pid, semid);
+#endif
+               /* 
+                * if this semaphore was deleted by another process
+                * skip updating persemid[semid].numclients
+                *
+                * NOTE NOTE NOTE NOTE NOTE NOTE
+                * there is a hole here that needs to be fixed:
+                * Process A creates semid with IPC_TMWU|IPC_CLNUP
+                * Process B does a semget and gets the semid
+                *      numclients = 2
+                * Process A dies, freeary'ing the semid
+                *      numclients = SEM_DONTCOUNT
+                * semid is still in Process B's list
+                * Process C creates same semid with IPC_CLNUP
+                *      numclients = 1
+                * Process B exits
+                *      numclients = 0
+                *      causing the semaphore to be deleted incorrectly
+                */
+               if (persemid[semid].numclients == SEM_DONTCOUNT) 
+                       continue;
+
+               persemid[semid].numclients --;
+               /* if last client for semaphore */
+               if ( (persemid[semid].numclients <= 0)
+               /* or creator of semaphore (IPC_TMWU flag was set) */
+                       || (persemid[semid].creator == pid) ) {
+                       freeary(semid);
+               }
+       }
+}
+
 static int findkey (key_t key)
 {
        int id;
@@ -139,6 +356,14 @@
                max_semid = id;
        used_semids++;
        semary[id] = sma;
+       /* if accounted semaphore */
+       if (semflg & IPC_CLNUP) {
+               persemid[id].numclients = 1;
+               if (semflg & IPC_TMWU) {
+                       persemid[id].creator = current->pid;
+               }
+               insertlist(current->pid, id);
+       }
        wake_up (&sem_lock);
        return (unsigned int) sma->sem_perm.seq * SEMMNI + id;
 }
@@ -162,6 +387,14 @@
                err = -EEXIST;
        } else {
                sma = semary[id];
+               /* 
+                * Account only if accounting flag was turned on 
+                * when semaphore was created 
+                */
+               if (persemid[id].numclients != SEM_DONTCOUNT) {
+                       persemid[id].numclients ++;
+                       insertlist(current->pid, id);
+               }
                if (nsems > sma->sem_nsems)
                        err = -EINVAL;
                else if (ipcperms(&sma->sem_perm, semflg))
@@ -355,6 +588,8 @@
        struct sem_undo *un;
        struct sem_queue *q;
 
+       if (sma == IPC_UNUSED)
+               return;
        /* Invalidate this semaphore set */
        sma->sem_perm.seq++;
        sem_seq = (sem_seq+1) % ((unsigned)(1<<31)/SEMMNI); /*
increment, but avoid overflow */
@@ -362,6 +597,9 @@
        if (id == max_semid)
                while (max_semid && (semary[--max_semid] ==
IPC_UNUSED));
        semary[id] = (struct semid_ds *) IPC_UNUSED;
+       persemid[id].numclients = SEM_DONTCOUNT;
+       persemid[id].creator = SEM_DONTCOUNT;
+       deletelist(current->pid, id);
        used_semids--;
 
        /* Invalidate the existing undo structures for this semaphore
set.
@@ -767,7 +1005,7 @@
        struct sem_queue *q;
        struct sem_undo *u, *un = NULL, **up, **unp;
        struct semid_ds *sma;
-       int nsems, i;
+       int nsems, i, semid;
 
        /* If the current process was sleeping for a semaphore,
         * remove it from the queue.
@@ -781,7 +1019,8 @@
        for (up = &current->semundo; (u = *up); *up = u->proc_next,
kfree(u)) {
                if (u->semid == -1)
                        continue;
-               sma = semary[(unsigned int) u->semid % SEMMNI];
+               semid = u->semid % SEMMNI;
+               sma = semary[semid];
                if (sma == IPC_UNUSED || sma == IPC_NOID)
                        continue;
                if (sma->sem_perm.seq != (unsigned int) u->semid /
SEMMNI)
@@ -807,6 +1046,14 @@
                sma->sem_otime = CURRENT_TIME;
                /* maybe some queued-up processes were waiting for this
*/
                update_queue(sma);
+       }
+       eatlist(current->pid);
+       if (perprocess[current->pid]) {
+       /* 
+        * this should never happen, once eatlist and deletelist are 
+        * serialized by using locks
+        */
+printk("FATAL ERROR: pid %d, couldn't delete linked list\n",
current->pid);
        }
        current->semundo = NULL;
 }

--- /root2/usr/src/linux-2.2.16/include/linux/ipc.h     Sun Dec 27
23:18:28 1998
+++ /usr/src/linux-2.2.16/include/linux/ipc.h   Tue Feb 20 14:16:31 2001
@@ -27,6 +27,10 @@
 #define IPC_DIPC 00010000  /* make it distributed */
 #define IPC_OWN  00020000  /* this machine is the DIPC owner */
 
+/* these flags are used for semaphore accounting */
+#define IPC_CLNUP      00100000  
+#define IPC_TMWU       00200000  
+
 /* 
  * Control commands used with semctl, msgctl and shmctl 
  * see also specific commands in sem.h, msg.h and shm.h
@@ -41,6 +45,9 @@
 /* special shmsegs[id], msgque[id] or semary[id]  values */
 #define IPC_UNUSED     ((void *) -1)
 #define IPC_NOID       ((void *) -2)           /* being
allocated/destroyed */
+
+/* special semaphore count value */
+#define SEM_DONTCOUNT  -2
 
 #endif /* __KERNEL__ */
