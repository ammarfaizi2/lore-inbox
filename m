Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272736AbRI0NeK>; Thu, 27 Sep 2001 09:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272859AbRI0NeA>; Thu, 27 Sep 2001 09:34:00 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:35087 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272736AbRI0Ndo>; Thu, 27 Sep 2001 09:33:44 -0400
Date: Thu, 27 Sep 2001 15:34:11 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: [PATCH] Linux 0.01 disk lockup
Message-ID: <Pine.LNX.3.96.1010927150812.28147B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Linux 0.01 has a bug in disk request sorting - when interrupt happens
while sorting is active, the interrupt routine won't clear do_hd - thus
the disk will stay locked up forever. 

Function add_request also lacks memory barriers - the compiler could
reorder writes to variable sorting and writes to request queue - producing
race conditions. Because gcc 1.40 does not have __asm__("":::"memory"), I
had to use dummy function call as a memory barrier. 

The following patch fixes both issues.

Mikulas

diff -u -r linux-orig/kernel/hd.c linux/kernel/hd.c
--- linux-orig/kernel/hd.c	Tue Sep 17 17:05:21 1991
+++ linux/kernel/hd.c	Thu Sep 27 15:14:38 2001
@@ -55,9 +55,9 @@
 ((s1)->head<(s2)->head || (s1)->head==(s2)->head && \
 ((s1)->sector<(s2)->sector))))
 
-static struct hd_request * this_request = NULL;
+struct hd_request * this_request = NULL;
 
-static int sorting=0;
+int sorting=0;
 
 static void do_request(void);
 static void reset_controller(void);
@@ -293,8 +293,10 @@
 {
 	int i,r;
 
-	if (sorting)
+	if (sorting) {
+		do_hd=NULL;
 		return;
+	}
 	if (!this_request) {
 		do_hd=NULL;
 		return;
@@ -319,6 +321,8 @@
 		panic("unknown hd-command");
 }
 
+void barrier();
+
 /*
  * add-request adds a request to the linked list.
  * It sets the 'sorting'-variable when doing something
@@ -338,6 +342,7 @@
  * disabling interrupts.
  */
 	sorting=1;
+	barrier();
 	if (!(tmp=this_request))
 		this_request=req;
 	else {
@@ -354,15 +359,19 @@
 			tmp->next=req;
 		}
 	}
+	barrier();
 	sorting=0;
+	barrier();
 /*
  * NOTE! As a result of sorting, the interrupts may have died down,
  * as they aren't redone due to locking with sorting=1. They might
  * also never have started, if this is the first request in the queue,
  * so we restart them if necessary.
  */
-	if (!do_hd)
+	if (!do_hd) {
+		barrier();
 		do_request();
+	}
 }
 
 void rw_abs_hd(int rw,unsigned int nr,unsigned int sec,unsigned int head,
diff -u -r linux-orig/kernel/system_call.s linux/kernel/system_call.s
--- linux-orig/kernel/system_call.s	Tue Sep 17 17:50:52 1991
+++ linux/kernel/system_call.s	Thu Sep 27 14:59:37 2001
@@ -47,7 +47,7 @@
 
 nr_system_calls = 67
 
-.globl _system_call,_sys_fork,_timer_interrupt,_hd_interrupt,_sys_execve
+.globl _system_call,_sys_fork,_timer_interrupt,_hd_interrupt,_sys_execve,_barrier
 
 .align 2
 bad_sys_call:
@@ -186,6 +186,9 @@
 	call _copy_process
 	addl $20,%esp
 1:	ret
+
+_barrier:
+	ret
 
 _hd_interrupt:
 	pushl %eax

