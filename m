Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTF0O5D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTF0OyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:54:17 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:50605 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S264456AbTF0OvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:51:14 -0400
Date: Fri, 27 Jun 2003 17:03:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/7): base fix.
Message-ID: <20030627150358.GB3591@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove unused variables from smp.c.
- Reserve system call number 110 for sys_lookup_dcache.
- Fix show_trace.
- Remove superfluous asm include file.
- Add statfs64 structure.

diffstat:
 arch/s390/defconfig         |    6 +
 arch/s390/kernel/smp.c      |    2 
 arch/s390/kernel/syscalls.S |    2 
 arch/s390/kernel/traps.c    |   10 +-
 include/asm-s390/hardirq.h  |    2 
 include/asm-s390/queue.h    |  170 --------------------------------------------
 include/asm-s390/statfs.h   |   27 ++++--
 7 files changed, 31 insertions(+), 188 deletions(-)

diff -urN linux-2.5/arch/s390/defconfig linux-2.5-s390/arch/s390/defconfig
--- linux-2.5/arch/s390/defconfig	Sun Jun 22 20:33:12 2003
+++ linux-2.5-s390/arch/s390/defconfig	Fri Jun 27 16:04:36 2003
@@ -68,6 +68,11 @@
 # CONFIG_PCMCIA is not set
 
 #
+# Generic Driver Options
+#
+# CONFIG_FW_LOADER is not set
+
+#
 # SCSI support
 #
 # CONFIG_SCSI is not set
@@ -166,6 +171,7 @@
 # CONFIG_INET6_AH is not set
 # CONFIG_INET6_ESP is not set
 # CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_TUNNEL is not set
 # CONFIG_XFRM_USER is not set
 
 #
diff -urN linux-2.5/arch/s390/kernel/smp.c linux-2.5-s390/arch/s390/kernel/smp.c
--- linux-2.5/arch/s390/kernel/smp.c	Sun Jun 22 20:32:28 2003
+++ linux-2.5-s390/arch/s390/kernel/smp.c	Fri Jun 27 16:04:36 2003
@@ -419,8 +419,6 @@
 	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
         current_thread_info()->cpu = 0;
         num_cpus = 1;
-	cpu_possible_map = 1;
-	cpu_online_map = 1;
         for (curr_cpu = 0;
              curr_cpu <= 65535 && num_cpus < max_cpus; curr_cpu++) {
                 if ((__u16) curr_cpu == boot_cpu_addr)
diff -urN linux-2.5/arch/s390/kernel/syscalls.S linux-2.5-s390/arch/s390/kernel/syscalls.S
--- linux-2.5/arch/s390/kernel/syscalls.S	Sun Jun 22 20:32:32 2003
+++ linux-2.5-s390/arch/s390/kernel/syscalls.S	Fri Jun 27 16:04:36 2003
@@ -118,7 +118,7 @@
 SYSCALL(sys_newlstat,sys_newlstat,compat_sys_newlstat_wrapper)
 SYSCALL(sys_newfstat,sys_newfstat,compat_sys_newfstat_wrapper)
 NI_SYSCALL							/* old uname syscall */
-NI_SYSCALL							/* 110 iopl for i386 */
+NI_SYSCALL							/* reserved for sys_lookup_dcache */
 SYSCALL(sys_vhangup,sys_vhangup,sys_vhangup)
 NI_SYSCALL							/* old "idle" system call */
 NI_SYSCALL							/* vm86old for i386 */
diff -urN linux-2.5/arch/s390/kernel/traps.c linux-2.5-s390/arch/s390/kernel/traps.c
--- linux-2.5/arch/s390/kernel/traps.c	Sun Jun 22 20:32:41 2003
+++ linux-2.5-s390/arch/s390/kernel/traps.c	Fri Jun 27 16:04:36 2003
@@ -78,7 +78,7 @@
 
 #endif /* CONFIG_ARCH_S390X */
 
-void show_trace(unsigned long * stack)
+void show_trace(struct task_struct *task, unsigned long * stack)
 {
 	unsigned long backchain, low_addr, high_addr, ret_addr;
 
@@ -109,10 +109,10 @@
 	 */
 	if (tsk->state == TASK_RUNNING)
 		return;
-	show_trace((unsigned long *) tsk->thread.ksp);
+	show_trace(tsk, (unsigned long *) tsk->thread.ksp);
 }
 
-void show_stack(unsigned long *sp)
+void show_stack(struct task_struct *task, unsigned long *sp)
 {
 	unsigned long *stack;
 	int i;
@@ -132,7 +132,7 @@
 		printk("%p ", (void *)*stack++);
 	}
 	printk("\n");
-	show_trace(sp);
+	show_trace(task, sp);
 }
 
 /*
@@ -140,7 +140,7 @@
  */
 void dump_stack(void)
 {
-	show_stack(0);
+	show_stack(current, 0);
 }
 
 void show_registers(struct pt_regs *regs)
diff -urN linux-2.5/include/asm-s390/hardirq.h linux-2.5-s390/include/asm-s390/hardirq.h
--- linux-2.5/include/asm-s390/hardirq.h	Sun Jun 22 20:33:35 2003
+++ linux-2.5-s390/include/asm-s390/hardirq.h	Fri Jun 27 16:04:36 2003
@@ -105,6 +105,4 @@
   extern void synchronize_irq(unsigned int irq);
 #endif /* CONFIG_SMP */
 
-extern void show_stack(unsigned long * esp);
-
 #endif /* __ASM_HARDIRQ_H */
diff -urN linux-2.5/include/asm-s390/queue.h linux-2.5-s390/include/asm-s390/queue.h
--- linux-2.5/include/asm-s390/queue.h	Sun Jun 22 20:33:04 2003
+++ linux-2.5-s390/include/asm-s390/queue.h	Thu Jan  1 01:00:00 1970
@@ -1,170 +0,0 @@
-/*
- *  include/asm-s390/queue.h
- *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
- *
- *  A little set of queue utilies.
- */
-#ifndef __ASM_QUEUE_H
-#define __ASM_QUEUE_H
-#include <linux/stddef.h>
-
-typedef struct queue
-{
-	struct queue *next;	
-} queue;
-
-typedef queue list;
-
-typedef struct
-{
-	queue *head;
-	queue *tail;
-} qheader;
-
-static __inline__ void init_queue(qheader *qhead)
-{
-	memset(qhead,0,sizeof(*qhead));
-}
-
-static __inline__ void enqueue_tail(qheader *qhead,queue *member)
-{	
-	if(member)
-	{
-		queue *tail=qhead->tail;
-
-		if(tail)
-			tail->next=member;
-		else
-			
-			qhead->head=member;
-		qhead->tail=member;
-		member->next=NULL;
-	}
-} 
-
-static __inline__ queue *dequeue_head(qheader *qhead)
-{
-	queue *head=qhead->head,*next_head;
-
-	if(head)
-	{
-		next_head=head->next;
-		qhead->head=next_head;
-	        if(!next_head)
-			qhead->tail=NULL;
-	}
-	return(head);
-}
-
-static __inline__ void init_list(list **lhead)
-{
-	*lhead=NULL;
-}
-
-static __inline__ void add_to_list(list **lhead,list *member)
-{
-	member->next=*lhead;
-	*lhead=member;
-}
-
-static __inline__ list *remove_listhead(list **lhead)
-{
-	list *oldhead=*lhead;
-
-	if(oldhead)
-		*lhead=(*lhead)->next;
-	return(oldhead);
-}
-
-static __inline__ void add_to_list_tail(list **lhead,list *member)
-{
-	list *curr,*prev;
-	if(*lhead==NULL)
-		*lhead=member;
-	else
-	{
-		prev=*lhead;
-		for(curr=(*lhead)->next;curr!=NULL;curr=curr->next)
-			prev=curr;
-		prev->next=member;
-	}
-}
-static __inline__ void add_to_list_tail_null(list **lhead,list *member)
-{
-	member->next=NULL;
-	add_to_list_tail_null(lhead,member);
-}
-
-
-static __inline__ int is_in_list(list *lhead,list *member)
-{
-	list *curr;
-
-	for(curr=lhead;curr!=NULL;curr=curr->next)
-		if(curr==member)
-			return(1);
-	return(0);
-}
-
-static __inline__ int get_prev(list *lhead,list *member,list **prev)
-{
-	list *curr;
-
-	*prev=NULL;
-	for(curr=lhead;curr!=NULL;curr=curr->next)
-	{
-		if(curr==member)
-			return(1);
-		*prev=curr;
-	}
-	*prev=NULL;
-	return(0);
-}
-
-
-
-static __inline__ int remove_from_list(list **lhead,list *member)
-{
-	list *prev;
-
-	if(get_prev(*lhead,member,&prev))
-	{
-
-		if(prev)
-			prev->next=member->next;
-		else
-			*lhead=member->next;
-		return(1);
-	}
-	return(0);
-}
-
-static __inline__ int remove_from_queue(qheader *qhead,queue *member)
-{
-	queue *prev;
-
-	if(get_prev(qhead->head,(list *)member,(list **)&prev))
-	{
-
-		if(prev)
-		{
-			prev->next=member->next;
-			if(prev->next==NULL)
-				qhead->tail=prev;
-		}
-		else
-		{
-			if(qhead->head==qhead->tail)
-				qhead->tail=NULL;
-			qhead->head=member->next;
-		}
-		return(1);
-	}
-	return(0);
-}
-
-#endif /* __ASM_QUEUE_H */
-
diff -urN linux-2.5/include/asm-s390/statfs.h linux-2.5-s390/include/asm-s390/statfs.h
--- linux-2.5/include/asm-s390/statfs.h	Sun Jun 22 20:33:34 2003
+++ linux-2.5-s390/include/asm-s390/statfs.h	Fri Jun 27 16:04:36 2003
@@ -9,6 +9,10 @@
 #ifndef _S390_STATFS_H
 #define _S390_STATFS_H
 
+#ifndef __s390x__
+#include <asm-generic/statfs.h>
+#else
+
 #ifndef __KERNEL_STRICT_NAMES
 
 #include <linux/types.h>
@@ -17,19 +21,25 @@
 
 #endif
 
+/*
+ * This is ugly -- we're already 64-bit clean, so just duplicate the 
+ * definitions.
+ */
 struct statfs {
-#ifndef __s390x__
-	long f_type;
-	long f_bsize;
+	int  f_type;
+	int  f_bsize;
 	long f_blocks;
 	long f_bfree;
 	long f_bavail;
 	long f_files;
 	long f_ffree;
 	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_spare[6];
-#else /* __s390x__ */
+	int  f_namelen;
+	int  f_frsize;
+	int  f_spare[5];
+};
+
+struct statfs64 {
 	int  f_type;
 	int  f_bsize;
 	long f_blocks;
@@ -39,8 +49,9 @@
 	long f_ffree;
 	__kernel_fsid_t f_fsid;
 	int  f_namelen;
-	int  f_spare[6];
-#endif /* __s390x__ */
+	int  f_frsize;
+	int  f_spare[5];
 };
 
+#endif /* __s390x__ */
 #endif
