Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293088AbSCOSok>; Fri, 15 Mar 2002 13:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293091AbSCOSoc>; Fri, 15 Mar 2002 13:44:32 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42903 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293088AbSCOSo0>; Fri, 15 Mar 2002 13:44:26 -0500
Date: Fri, 15 Mar 2002 13:44:20 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, Pete Zaitcev <zaitcev@redhat.com>
Subject: 2.4.19-pre3 s390 ret_from_fork patch
Message-ID: <20020315134420.F24597@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

The 2.4.19-pre3 works just dandy as it is without this patch,
but it is needed for O(1) scheduler. I think Martin was going
to forward this into 2.5.x tree, where O(1) is standard.

The problem is that schedule_tail() is supposed to unlock
runqueue, but if interrupts are enabled before that happens,
a timer tick may squeeze in and deadlock. I observed such
situation myself.

So, I would like this to be in 2.4.19 for the sake of O(1) users.
Any objections?

-- Pete

diff -ur -X dontdiff linux-2.4.19-pre3/arch/s390/kernel/entry.S linux-2.4.19-pre3-390/arch/s390/kernel/entry.S
--- linux-2.4.19-pre3/arch/s390/kernel/entry.S	Tue Mar 12 10:53:36 2002
+++ linux-2.4.19-pre3-390/arch/s390/kernel/entry.S	Fri Mar 15 09:18:52 2002
@@ -254,13 +254,14 @@
 ret_from_fork:  
         basr    %r13,0
         l       %r13,.Lentry_base-.(%r13)  # setup base pointer to &entry_base
+	# not saving R14 here because we go to sysc_return ultimately
+	l	%r1,BASED(.Lschedtail)
+	basr	%r14,%r1          # call schedule_tail (unlock stuff)
         GET_CURRENT               # load pointer to task_struct to R9
         stosm   24(%r15),0x03     # reenable interrupts
         sr      %r0,%r0           # child returns 0
         st      %r0,SP_R2(%r15)   # store return value (change R2 on stack)
-        l       %r1,BASED(.Lschedtail)
-	la      %r14,BASED(sysc_return)
-        br      %r1               # call schedule_tail, return to sysc_return
+	b	BASED(sysc_return)
 
 #
 # clone, fork, vfork, exec and sigreturn need glue,
diff -ur -X dontdiff linux-2.4.19-pre3/arch/s390x/kernel/entry.S linux-2.4.19-pre3-390/arch/s390x/kernel/entry.S
--- linux-2.4.19-pre3/arch/s390x/kernel/entry.S	Tue Mar 12 10:53:36 2002
+++ linux-2.4.19-pre3-390/arch/s390x/kernel/entry.S	Fri Mar 15 09:20:33 2002
@@ -240,11 +240,11 @@
 #
         .globl  ret_from_fork
 ret_from_fork:  
+	brasl	%r14,schedule_tail
         GET_CURRENT               # load pointer to task_struct to R9
         stosm   48(%r15),0x03     # reenable interrupts
 	xc      SP_R2(8,%r15),SP_R2(%r15) # child returns 0
-	larl    %r14,sysc_return
-        jg      schedule_tail     # return to sysc_return
+	j	sysc_return
 
 #
 # clone, fork, vfork, exec and sigreturn need glue,
