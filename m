Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266309AbTGHDAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 23:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266443AbTGHDAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 23:00:25 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:14566 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266309AbTGHC77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 22:59:59 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Tue, 8 Jul 2003 13:14:31 +1000
Message-ID: <16138.14103.197071.478105@wombat.disy.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bx99zz6f9U"
Content-Transfer-Encoding: 7bit
Subject: [PATCH] Microstate accounting:  account for some more things
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bx99zz6f9U
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


Hi,
	The appended patch goes on top of the patch at 
http://marc.theaimsgroup.com/?l=linux-kernel&m=105662514529349&w=2 
to add accounting for time spent in poll/select, sleeping handling
major pagefaults, and time spent asleep on futexes.

Running this patch, I found a problem with major fault accounting in
the kernel: there are combinations of circumstances that can lead to a
major fault being reported when no I/O is done (for example if the
page has been prefaulted)


--bx99zz6f9U
Content-Type: text/plain
Content-Disposition: inline;
	filename="p1"
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1402  -> 1.1403 
#	         fs/select.c	1.20    -> 1.21   
#	arch/i386/kernel/irq.c	1.39    -> 1.40   
#	      kernel/futex.c	1.28    -> 1.29   
#	        kernel/msa.c	1.1     -> 1.2    
#	arch/ia64/kernel/irq_ia64.c	1.14    -> 1.15   
#	         mm/memory.c	1.125   -> 1.126  
#	      fs/proc/base.c	1.52    -> 1.53   
#	 include/linux/msa.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/08	peterc@gelato.unsw.edu.au	1.1403
# Add new states: time sleeping for page I/O, in poll/select/epoll and in futex.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Tue Jul  8 13:13:30 2003
+++ b/arch/i386/kernel/irq.c	Tue Jul  8 13:13:30 2003
@@ -429,7 +429,7 @@
 	unsigned int status;
 
 	irq_enter();
-	msa_start_irq(cpu, irq);
+	msa_start_irq(irq);
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
@@ -509,7 +509,7 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
-	msa_finish_irq(cpu, irq);
+	msa_finish_irq(irq);
 
 	return 1;
 }
diff -Nru a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
--- a/arch/ia64/kernel/irq_ia64.c	Tue Jul  8 13:13:30 2003
+++ b/arch/ia64/kernel/irq_ia64.c	Tue Jul  8 13:13:30 2003
@@ -122,7 +122,7 @@
 	saved_tpr = ia64_get_tpr();
 	ia64_srlz_d();
 	oldvector = vector;
-	msa_start_irq(cpu, local_vector_to_irq(vector));
+	msa_start_irq(local_vector_to_irq(vector));
 	while (vector != IA64_SPURIOUS_INT_VECTOR) {
 		if (!IS_RESCHEDULE(vector)) {
 			ia64_set_tpr(vector);
@@ -139,7 +139,7 @@
 		ia64_eoi();
 		oldvector = vector;
 		vector = ia64_get_ivr();		
-		msa_continue_irq(cpu, local_vector_to_irq(oldvector),
+		msa_continue_irq(local_vector_to_irq(oldvector),
 				 local_vector_to_irq(vector));
 	}
 	/*
@@ -150,7 +150,7 @@
 	if (local_softirq_pending())
 		do_softirq();
 
-	msa_finish_irq(cpu, local_vector_to_irq(vector));
+	msa_finish_irq(local_vector_to_irq(vector));
 }
 
 #ifdef CONFIG_SMP
diff -Nru a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	Tue Jul  8 13:13:30 2003
+++ b/fs/proc/base.c	Tue Jul  8 13:13:30 2003
@@ -302,9 +302,7 @@
 static int proc_pid_msa(struct task_struct *task, char *buffer) 
 {
 	struct microstates *msp = &task->microstates;
-  
 	static char *statenames[] = {
-		"Unknown",
 		"User",
 		"System",
 		"Interruptible",
@@ -313,32 +311,40 @@
 		"OnExpiredQueue",
 		"Zombie",
 		"Stopped",
+		"Paging",
+		"Futex",
+		"Poll",
 		"Interrupted",
 	};
+  
 	return sprintf(buffer, 
-		 "State:         %s\n"		\
-		 "ONCPU_USER     %15llu\n"	\
-		 "ONCPU_SYS      %15llu\n"	\
-		 "INTERRUPTIBLE  %15llu\n"	\
-		 "UNINTERRUPTIBLE%15llu\n"	\
-		 "INTERRUPTED    %15llu\n"	\
-		 "ACTIVEQUEUE    %15llu\n"	\
-		 "EXPIREDQUEUE   %15llu\n"	\
-		 "STOPPED        %15llu\n"	\
-		 "ZOMBIE         %15llu\n"	\
-		 "UNKNOWN        %15llu\n",
-		 msp->cur_state <= INTERRUPTED ?
+		       "State:         %s\n"		\
+		       "ONCPU_USER     %15llu\n"	\
+		       "ONCPU_SYS      %15llu\n"	\
+		       "INTERRUPTIBLE  %15llu\n"	\
+		       "UNINTERRUPTIBLE%15llu\n"	\
+		       "INTERRUPTED    %15llu\n"	\
+		       "ACTIVEQUEUE    %15llu\n"	\
+		       "EXPIREDQUEUE   %15llu\n"	\
+		       "STOPPED        %15llu\n"	\
+		       "ZOMBIE         %15llu\n"	\
+		       "SLP_POLL       %15llu\n"	\
+		       "SLP_PAGING     %15llu\n"	\
+		       "SLP_FUTEX      %15llu\n",	\
+		       msp->cur_state >= 0 && msp->cur_state < NR_MICRO_STATES ?
 		       statenames[msp->cur_state] : "Impossible",
-		 msp->timers[ONCPU_USER],
-		 msp->timers[ONCPU_SYS],
-		 msp->timers[INTERRUPTIBLE_SLEEP],
-		 msp->timers[UNINTERRUPTIBLE_SLEEP],
-		 msp->timers[INTERRUPTED],
-		 msp->timers[ONACTIVEQUEUE],
-		 msp->timers[ONEXPIREDQUEUE],
-		 msp->timers[STOPPED],
-		 msp->timers[ZOMBIE],
-		 msp->timers[UNKNOWN]);
+		       msp->timers[ONCPU_USER],
+		       msp->timers[ONCPU_SYS],
+		       msp->timers[INTERRUPTIBLE_SLEEP],
+		       msp->timers[UNINTERRUPTIBLE_SLEEP],
+		       msp->timers[INTERRUPTED],
+		       msp->timers[ONACTIVEQUEUE],
+		       msp->timers[ONEXPIREDQUEUE],
+		       msp->timers[STOPPED],
+		       msp->timers[ZOMBIE],
+		       msp->timers[POLL_SLEEP],
+		       msp->timers[PAGING_SLEEP],
+		       msp->timers[FUTEX_SLEEP]);
 }
 #endif /* CONFIG_MICROSTATE */
 
diff -Nru a/fs/select.c b/fs/select.c
--- a/fs/select.c	Tue Jul  8 13:13:30 2003
+++ b/fs/select.c	Tue Jul  8 13:13:30 2003
@@ -253,6 +253,7 @@
 			retval = table.error;
 			break;
 		}
+		msa_next_state(current, POLL_SLEEP);
 		__timeout = schedule_timeout(__timeout);
 	}
 	__set_current_state(TASK_RUNNING);
@@ -443,6 +444,7 @@
 		count = wait->error;
 		if (count)
 			break;
+		msa_next_state(current, POLL_SLEEP);
 		timeout = schedule_timeout(timeout);
 	}
 	__set_current_state(TASK_RUNNING);
diff -Nru a/include/linux/msa.h b/include/linux/msa.h
--- a/include/linux/msa.h	Tue Jul  8 13:13:30 2003
+++ b/include/linux/msa.h	Tue Jul  8 13:13:30 2003
@@ -18,7 +18,7 @@
  */
 
 enum thread_state {
-	UNKNOWN,
+	UNKNOWN = -1,
 	ONCPU_USER,
 	ONCPU_SYS,
 	INTERRUPTIBLE_SLEEP,
@@ -28,6 +28,10 @@
 	ZOMBIE,
 	STOPPED,
 	INTERRUPTED,
+	PAGING_SLEEP,
+	FUTEX_SLEEP,
+	POLL_SLEEP,
+	
 	NR_MICRO_STATES /* Must be last */
 };
 
@@ -76,9 +80,9 @@
 void msa_update_parent(struct task_struct *parent, struct task_struct *this);
 void msa_init(struct task_struct *p);
 void msa_set_timer(struct task_struct *p, int state);
-void msa_start_irq(int cpu, int irq);
-void msa_continue_irq(int cpu, int oldirq, int newirq);
-void msa_finish_irq(int cpu, int irq);
+void msa_start_irq(int irq);
+void msa_continue_irq(int oldirq, int newirq);
+void msa_finish_irq(int irq);
 clk_t msa_irq_time(int cpu, int irq);
 
 #ifdef TASK_STRUCT_DEFINED
diff -Nru a/kernel/futex.c b/kernel/futex.c
--- a/kernel/futex.c	Tue Jul  8 13:13:30 2003
+++ b/kernel/futex.c	Tue Jul  8 13:13:30 2003
@@ -34,6 +34,7 @@
 #include <linux/futex.h>
 #include <linux/vcache.h>
 #include <linux/mount.h>
+#include <linux/msa.h>
 
 #define FUTEX_HASHBITS 8
 
@@ -349,6 +350,7 @@
 	 * the waiter from the list.
 	 */
 	add_wait_queue(&q.waiters, &wait);
+	msa_next_state(current, FUTEX_SLEEP);
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (!list_empty(&q.list)) {
 		unlock_futex_mm();
diff -Nru a/kernel/msa.c b/kernel/msa.c
--- a/kernel/msa.c	Tue Jul  8 13:13:30 2003
+++ b/kernel/msa.c	Tue Jul  8 13:13:30 2003
@@ -62,36 +62,78 @@
 	msnext->timers[msnext->cur_state] += now - msnext->last_change;
 	
 	/* Update states */
-	if (msprev->next_state != UNKNOWN) {
-		next_state = msprev->next_state;
-		msprev->next_state = UNKNOWN;
-	} else switch(prev->state) {
-	case TASK_INTERRUPTIBLE:
-		next_state = INTERRUPTIBLE_SLEEP;
-		break;
+	switch (msprev->next_state) {
+	case UNKNOWN: /*
+		       * Infer from actual state
+		       */
+		switch (prev->state) {
+		case TASK_INTERRUPTIBLE:
+			next_state = INTERRUPTIBLE_SLEEP;
+			break;
 		
-	case TASK_UNINTERRUPTIBLE:
-		next_state = UNINTERRUPTIBLE_SLEEP;
-		break;
-
-	case TASK_STOPPED:
-		next_state = STOPPED;
-		break;
-
-	case TASK_ZOMBIE:
-		next_state = ZOMBIE;
-		break;
-
-	case TASK_DEAD:
-		next_state = ZOMBIE;
+		case TASK_UNINTERRUPTIBLE:
+			next_state = UNINTERRUPTIBLE_SLEEP;
+			break;
+
+		case TASK_STOPPED:
+			next_state = STOPPED;
+			break;
+
+		case TASK_ZOMBIE:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_DEAD:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_RUNNING:		
+			next_state = ONACTIVEQUEUE;
+			break;
+
+		default:
+			next_state = UNKNOWN;
+			break;
+
+		} 
+		break;
+
+	case PAGING_SLEEP: /*
+			    * Sleep states are PAGING_SLEEP;
+			    * others inferred from task state
+			    */
+		switch(prev->state) {
+		case TASK_INTERRUPTIBLE: /* FALLTHROUGH */
+		case TASK_UNINTERRUPTIBLE:
+			next_state = PAGING_SLEEP;
+			break;
+
+		case TASK_STOPPED:
+			next_state = STOPPED;
+			break;
+
+		case TASK_ZOMBIE:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_DEAD:
+			next_state = ZOMBIE;
+			break;
+
+		case TASK_RUNNING:		
+			next_state = ONACTIVEQUEUE;
+			break;
+
+		default:
+			next_state = UNKNOWN;
+			break;
+		}
 		break;
 
-	case TASK_RUNNING:		
-		next_state = ONACTIVEQUEUE;
+	default: /* Explicitly set next state */
+		next_state = msprev->next_state;
+		msprev->next_state = UNKNOWN;
 		break;
-
-	default:
-		next_state = UNKNOWN;
 	}
 
 	msprev->cur_state = next_state;
@@ -159,11 +201,12 @@
 	}
 }
 
-void msa_start_irq(int cpu, int irq) 
+void msa_start_irq(int irq) 
 {
 	struct task_struct *p = current;
 	struct microstates *mp = &p->microstates;
 	clk_t now;
+	int cpu = smp_processor_id();
 
 	MSA_NOW(now);
 	mp->timers[mp->cur_state] += now - mp->last_change;
@@ -175,9 +218,10 @@
 	msa_irq_pids[cpu][irq] = current->pid;
 }
 
-void msa_continue_irq(int cpu, int oldirq, int newirq) 
+void msa_continue_irq(int oldirq, int newirq) 
 {
 	clk_t now;
+	int cpu = smp_processor_id();
 	MSA_NOW(now);
 
 	msa_irq_times[cpu][oldirq] += now - msa_irq_entered[cpu][oldirq];
@@ -186,11 +230,12 @@
 }
 
 
-void msa_finish_irq(int cpu, int irq) 
+void msa_finish_irq(int irq) 
 {
 	struct task_struct *p = current;
 	struct microstates *mp = &p->microstates;
 	clk_t now;
+	int cpu = smp_processor_id();
 
 	MSA_NOW(now);
 
@@ -249,7 +294,7 @@
 	}
 
 	tp = which == MSA_SELF ? msp->timers : msp->child_timers;
-	for (i = UNKNOWN; i < ntimers; i++) {
+	for (i = 0; i < ntimers; i++) {
 		clk_t x = MSA_TO_NSEC(*tp++);
 		if (copy_to_user(timers++, &x, sizeof x))
 			return -EFAULT;
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Tue Jul  8 13:13:30 2003
+++ b/mm/memory.c	Tue Jul  8 13:13:30 2003
@@ -1532,6 +1532,7 @@
 	if (is_vm_hugetlb_page(vma))
 		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
 
+	msa_next_state(current, PAGING_SLEEP);
 	/*
 	 * We need the page table lock to synchronize with kswapd
 	 * and the SMP-safe atomic PTE updates.
@@ -1541,10 +1542,14 @@
 
 	if (pmd) {
 		pte_t * pte = pte_alloc_map(mm, pmd, address);
-		if (pte)
-			return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+		if (pte) {
+			int ret = handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+			msa_next_state(current, UNKNOWN);
+			return ret;
+		}
 	}
 	spin_unlock(&mm->page_table_lock);
+	msa_next_state(current, UNKNOWN);
 	return VM_FAULT_OOM;
 }
 

--bx99zz6f9U--
