Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbTBCOqm>; Mon, 3 Feb 2003 09:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbTBCOq3>; Mon, 3 Feb 2003 09:46:29 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:35722 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S266643AbTBCOoK>; Mon, 3 Feb 2003 09:44:10 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 fixes (11/12).
Date: Mon, 3 Feb 2003 15:50:38 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302031550.38656.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix support for thread local storage on s390
diff -urN linux-2.5.59/arch/s390/kernel/process.c 
linux-2.5.59-s390/arch/s390/kernel/process.c
--- linux-2.5.59/arch/s390/kernel/process.c	Fri Jan 17 03:22:28 2003
+++ linux-2.5.59-s390/arch/s390/kernel/process.c	Mon Feb  3 15:18:29 2003
@@ -196,8 +196,6 @@
 
         /* new return point is ret_from_fork */
         frame->gprs[8] = (unsigned long) ret_from_fork;
-	/* start disabled because of schedule_tick and rq->lock being held */
-	frame->childregs.psw.mask &= ~0x03000000;
 
         /* fake return stack for resume(), don't go back to schedule */
         frame->gprs[9]  = (unsigned long) frame;
@@ -213,6 +211,10 @@
 	p->thread.ar4 = get_fs().ar4;
         /* Don't copy debug registers */
         memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
+
+	/* Set a new TLS ?  */
+	if (clone_flags & CLONE_SETTLS)
+		frame->childregs.acrs[0] = regs->gprs[6];
         return 0;
 }
 
@@ -335,7 +337,7 @@
 	int count = 0;
 	if (!p || p == current || p->state == TASK_RUNNING)
 		return 0;
-	stack_page = (unsigned long) p;
+	stack_page = (unsigned long) p->thread_info;
 	r15 = p->thread.ksp;
         if (!stack_page || r15 < stack_page || r15 >= 8188+stack_page)
                 return 0;
diff -urN linux-2.5.59/arch/s390x/kernel/process.c 
linux-2.5.59-s390/arch/s390x/kernel/process.c
--- linux-2.5.59/arch/s390x/kernel/process.c	Fri Jan 17 03:22:25 2003
+++ linux-2.5.59-s390/arch/s390x/kernel/process.c	Mon Feb  3 15:18:29 2003
@@ -203,6 +203,19 @@
 	p->thread.ar4 = get_fs().ar4;
         /* Don't copy debug registers */
         memset(&p->thread.per_info,0,sizeof(p->thread.per_info));
+
+	/* Set a new TLS ?  */
+	if (clone_flags & CLONE_SETTLS) {
+		if (current->thread.flags & S390_FLAG_31BIT) {
+			frame->childregs.acrs[0] =
+				(unsigned int) regs->gprs[6];
+		} else {
+			frame->childregs.acrs[0] =
+				(unsigned int)(regs->gprs[6] >> 32);
+			frame->childregs.acrs[1] =
+				(unsigned int) regs->gprs[6];
+		}
+	}
         return 0;
 }
 
@@ -319,7 +332,7 @@
         int count = 0;
         if (!p || p == current || p->state == TASK_RUNNING)
                 return 0;
-        stack_page = (unsigned long) p;
+	stack_page = (unsigned long) p->thread_info;
         r15 = p->thread.ksp;
         if (!stack_page || r15 < stack_page || r15 >= 16380+stack_page)
                 return 0;

