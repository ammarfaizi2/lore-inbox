Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTFFFtk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbTFFFtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:49:40 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:33509 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S265326AbTFFFtg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:49:36 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ameya Mitragotri <ameya.mitragotri@wipro.com>
Reply-To: ameya.mitragotri@wipro.com
Organization: Wipro Technologies
To: manfreds@colorfullife.com, wli@holomorphy.com
Subject: [RFC][PATCH 2.5.70] dynamically tunable semmnu and semume
Date: Fri, 6 Jun 2003 11:44:07 +0530
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, davej@suse.de, indou.takao@jp.fujitsu.com,
       akpm@diego.com, ameya.mitragotri@wipro.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306061141.50965.ameya.mitragotri@wipro.com>
X-OriginalArrivalTime: 06 Jun 2003 06:02:52.0529 (UTC) FILETIME=[440C8610:01C32BF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Find below the patch (RFC) that makes semmnu and semume dynamically
tunable through /proc. 

Please comment/suggest.

thanks
ameya

diff -Nur linux-2.5.70/include/linux/sem.h linux-2.5.70patched/include/linux/sem.h
--- linux-2.5.70/include/linux/sem.h    Tue May 27 06:30:38 2003
+++ linux-2.5.70patched/include/linux/sem.h     Wed Jun  4 21:57:03 2003
@@ -70,10 +70,9 @@
 #define SEMOPM  32             /* <= 1 000 max num of ops per semop call */
 #define SEMVMX  32767           /* <= 32767 semaphore maximum value */
 #define SEMAEM  SEMVMX          /* adjust on exit max value */
-
+#define SEMUME  0x7fffffff      /* max num of undo entries per process */
+#define SEMMNU  0x7fffffff      /* num of undo structures system wide */
 /* unused */
-#define SEMUME  SEMOPM          /* max num of undo entries per process */
-#define SEMMNU  SEMMNS          /* num of undo structures system wide */
 #define SEMMAP  SEMMNS          /* # of entries in semaphore map */
 #define SEMUSZ  20             /* sizeof struct sem_undo */

diff -Nur linux-2.5.70/ipc/sem.c linux-2.5.70patched/ipc/sem.c
--- linux-2.5.70/ipc/sem.c      Tue May 27 06:30:38 2003
+++ linux-2.5.70patched/ipc/sem.c       Thu Jun  5 15:49:22 2003
@@ -96,13 +96,17 @@
  *
  */

-int sem_ctls[4] = {SEMMSL, SEMMNS, SEMOPM, SEMMNI};
+int sem_ctls[6] = {SEMMSL, SEMMNS, SEMOPM, SEMMNI,SEMMNU, SEMUME};
 #define sc_semmsl      (sem_ctls[0])
 #define sc_semmns      (sem_ctls[1])
 #define sc_semopm      (sem_ctls[2])
 #define sc_semmni      (sem_ctls[3])
+#define sc_semmnu      (sem_ctls[4])
+#define sc_semume      (sem_ctls[5])

 static int used_sems;
+static unsigned int sem_undo_count;
+static spinlock_t sem_undo_lock;

 void __init sem_init (void)
 {
@@ -483,9 +487,9 @@
                seminfo.semmsl = sc_semmsl;
                seminfo.semopm = sc_semopm;
                seminfo.semvmx = SEMVMX;
-               seminfo.semmnu = SEMMNU;
+               seminfo.semmnu = sc_semmnu;
                seminfo.semmap = SEMMAP;
-               seminfo.semume = SEMUME;
+               seminfo.semume = sc_semume;
                down(&sem_ids.sem);
                if (cmd == SEM_INFO) {
                        seminfo.semusz = sem_ids.in_use;
@@ -900,6 +904,10 @@
                if(un==u) {
                        un=u->proc_next;
                        *up=un;
+                       spin_lock(&sem_undo_lock);
+                       sem_undo_count--;
+                       current->sysvsem.undo_list->add_count--;
+                       spin_unlock(&sem_undo_lock);
                        kfree(u);
                        return un;
                }
@@ -960,8 +968,21 @@
                kfree(un);
                return error;
        }
-
-
+       spin_lock(&sem_undo_lock);
+       if(sem_undo_count >= sc_semmnu)
+       {
+               unlock_semundo();
+               kfree(un);
+               spin_unlock(&sem_undo_lock);
+               return -ENOSPC;
+       }
+       if(current->sysvsem.undo_list->add_count >= sc_semume)
+       {
+                unlock_semundo();
+                kfree(un);
+                spin_unlock(&sem_undo_lock);
+                return -EAGAIN;
+       }
        /* alloc_undo has just
         * released all locks and reacquired them.
         * But, another thread may have
@@ -978,10 +999,13 @@
        if (new_un != NULL) {
                if (sma->undo != new_un)
                        BUG();
+               spin_unlock(&sem_undo_lock);
                kfree(un);
                un = new_un;
        } else {
                current->sysvsem.undo_list->add_count++;
+               sem_undo_count++;
+               spin_unlock(&sem_undo_lock);
                un->semadj = (short *) &un[1];
                un->semid = semid;
                un->proc_next = undo_list->proc_list;
@@ -1254,6 +1278,10 @@
         */
        for (up = &undo_list->proc_list; (u = *up); *up = u->proc_next, kfree(u)) {
                int semid = u->semid;
+               spin_lock(&sem_undo_lock);
+               sem_undo_count--;
+               current->sysvsem.undo_list->add_count--;
+               spin_unlock(&sem_undo_lock);
                if(semid == -1)
                        continue;
                sma = sem_lock(semid);
diff -Nur linux-2.5.70/kernel/sysctl.c linux-2.5.70patched/kernel/sysctl.c
--- linux-2.5.70/kernel/sysctl.c        Tue May 27 06:30:23 2003
+++ linux-2.5.70patched/kernel/sysctl.c Thu Jun  5 16:27:12 2003
@@ -61,6 +61,11 @@
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
+static int zero = 0;
+static int sem_zero_array[]={0,0,0,0,0,0};
+static int sem_maxint_array[]={0x7fffffff,0x7fffffff,0x7fffffff,0x7fffffff,0x7fffffff,0x7fffffff};
+static int one = 1;
+static int one_hundred = 100;

 #ifdef CONFIG_KMOD
 extern char modprobe_path[];
@@ -235,8 +240,8 @@
         0644, NULL, &proc_dointvec},
        {KERN_MSGMNB, "msgmnb", &msg_ctlmnb, sizeof (int),
         0644, NULL, &proc_dointvec},
-       {KERN_SEM, "sem", &sem_ctls, 4*sizeof (int),
-        0644, NULL, &proc_dointvec},
+       {KERN_SEM, "sem", &sem_ctls, 6*sizeof (int),
+        0644, NULL, &proc_dointvec_minmax, NULL, NULL, sem_zero_array, sem_maxint_array},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
        {KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),
@@ -270,9 +275,6 @@

 /* Constants for minimum and maximum testing in vm_table.
    We use these as one-element integer vectors. */
-static int zero = 0;
-static int one = 1;
-static int one_hundred = 100;

 static ctl_table vm_table[] = {

