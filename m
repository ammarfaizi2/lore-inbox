Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbUKQXhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUKQXhl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUKQXfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:35:31 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:14340
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262686AbUKQXep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:34:45 -0500
Message-Id: <200411180148.iAI1mGQ3006498@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: user-mode-linux-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: And another bug report for UML in latest Linux 2.6-BK repository. 
In-Reply-To: Your message of "Tue, 16 Nov 2004 14:03:09 GMT."
             <1100613788.24599.45.camel@imp.csi.cam.ac.uk> 
References: <1100613788.24599.45.camel@imp.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Nov 2004 20:48:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aia21@cam.ac.uk said:
> sleeping process 29410 got unexpected signal : 11
> I now have to press Ctrl+C to get back to my shell. 

This one is slightly subtle, but I believe that it is fixed by the following 
patch.

				Jeff


Index: 2.6.9/arch/um/kernel/tt/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/process_kern.c	2004-11-16 12:14:15.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/process_kern.c	2004-11-17 18:24:25.000000000 -0500
@@ -65,7 +65,8 @@
 		panic("write of switch_pipe failed, err = %d", -err);
 
 	reading = 1;
-	if((from->exit_state == EXIT_ZOMBIE) || (from->exit_state == EXIT_DEAD))
+	if((from->exit_state == EXIT_ZOMBIE) ||
+	   (from->exit_state == EXIT_DEAD))
 		os_kill_process(os_getpid(), 0);
 
 	err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
@@ -82,7 +83,7 @@
 	prev_sched = current->thread.prev_sched;
 	if((prev_sched->exit_state == EXIT_ZOMBIE) ||
 	   (prev_sched->exit_state == EXIT_DEAD))
-		os_kill_ptraced_process(prev_sched->thread.mode.tt.extern_pid, 1);
+		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
 
 	/* This works around a nasty race with 'jail'.  If we are switching
 	 * between two threads of a threaded app and the incoming process 
Index: 2.6.9/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/tracer.c	2004-11-16 21:26:03.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/tracer.c	2004-11-17 18:21:47.000000000 -0500
@@ -271,10 +271,28 @@
 #endif
 		else if(WIFSIGNALED(status)){
 			sig = WTERMSIG(status);
-			if(sig != 9){
+			if(sig == SIGKILL){
+				/* This is to make sure that processes die
+				 * immediately without becoming zombies on
+				 * all hosts.  Before 2.6.9, kill(pid, SIGKILL)
+				 * was enough to make sure a process went away
+				 * immediately.  After 2.6.9, they don't run
+				 * any more, but they remain as zombies.  So,
+				 * a PTRACE_CONT is necessary in order to put
+				 * them in a normal run state so that they die.
+				 * I do a PTRACE_KILL here for good measure.
+				 * Might as well kill it by all available 
+				 * means.  These calls will likely fail when
+				 * they are not needed because the process has
+				 * already disappeared.  However, they don't
+				 * hurt.
+				 */
+				ptrace(PTRACE_KILL, pid, 0, 0);
+				ptrace(PTRACE_CONT, pid, 0, 0);
+			}
+			else
 				printf("Child %d exited with signal %d\n", pid,
 				       sig);
-			}
 		}
 		else if(WIFSTOPPED(status)){
 			proc_id = pid_to_processor_id(pid);
Index: 2.6.9/arch/um/os-Linux/process.c
===================================================================
--- 2.6.9.orig/arch/um/os-Linux/process.c	2004-11-16 12:14:15.000000000 -0500
+++ 2.6.9/arch/um/os-Linux/process.c	2004-11-17 18:27:52.000000000 -0500
@@ -95,9 +95,16 @@
 		
 }
 
+/* Kill off a ptraced child by all means available.  kill it normally first,
+ * then PTRACE_KILL it, then PTRACE_CONT it in case it's in a run state from
+ * which it can't exit directly.
+ */
+
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
+	ptrace(PTRACE_CONT, pid);
 	if(reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, 0));
 }

