Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTHaPmf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTHaPmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:42:35 -0400
Received: from shower.ispgateway.de ([62.67.200.219]:39303 "HELO
	shower.ispgateway.de") by vger.kernel.org with SMTP id S262272AbTHaPmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:42:14 -0400
Message-ID: <3F521753.2030705@dot-heine.de>
Date: Sun, 31 Aug 2003 17:42:11 +0200
From: Claus-Justus Heine <ch@dot-heine.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4: bug WRT lazy FPU switching and CONFIG_PREEMPT
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There seems to be a bug with CONFIG_PREEMPT=y and lazy FPU switching. The following small program just unmasks math exceptions 
and then continously triggers a divide by zero. When CONFIG_PREEMPT is in effect this eventually leads to other processes 
inheriting the math-status of this brain-damaged but legal user level program. Especially, their math-exceptions are unmasked 
and so they might catch an unwanted SIGFPE.

######################################### snip ####################################
#include <signal.h>
#include <stdio.h>
#include <fenv.h>

double volatile foobar = 0.0;

static void sigfpe(int sig)
{
	static int cnt;

	if (++cnt % 100000 == 0) {
		fprintf(stderr, ".");
	}
}

int main(int argc, char *argv[])
{
	signal(SIGFPE, sigfpe);
	feenableexcept(FE_ALL_EXCEPT);
	foobar = 1.0/foobar;
}
######################################## snap ######################################

The following patch seems to fix the problem. However, I must admit that I didn't fully understand why this happens. The problem 
seems to be a preemption occuring between the __save_init_fpu() (i.e. fsave/fxsave) and the stts(). But why should this be a 
problem?

The patch touches two files:

include/asm-i386/i387.h:
   here save_init_fpu() is defined and this seems to be the location of the problem

arch/i386/kernel/traps.c:
   by checking for TS_USEDFPU we spare an additional "device not available" fault (with CONFIG_PREEMPT=y) and thereby a 
superflous math_state_restore(). There is not point in restoring the math-state just to save it again (but this didn't cause the 
shooting with wild SIGFPEs).

Regards

Claus

######################################### snip ##########################################################################
diff -u --recursive --new-file linux-2.6.0-test4/arch/i386/kernel/traps.c linux-2.6.0-test4-mine/arch/i386/kernel/traps.c
--- linux-2.6.0-test4/arch/i386/kernel/traps.c	2003-08-31 15:22:42.000000000 +0200
+++ linux-2.6.0-test4-mine/arch/i386/kernel/traps.c	2003-08-31 15:35:49.000000000 +0200
@@ -605,7 +605,10 @@
  	 * Save the info for the exception handler and clear the error.
  	 */
  	task = current;
-	save_init_fpu(task);
+	/* don't trigger an unnecessary math_state_restore() */
+	if (task->thread_info->status & TS_USEDFPU) {
+		save_init_fpu(task);
+	}
  	task->thread.trap_no = 16;
  	task->thread.error_code = 0;
  	info.si_signo = SIGFPE;
@@ -667,7 +670,10 @@
  	 * Save the info for the exception handler and clear the error.
  	 */
  	task = current;
-	save_init_fpu(task);
+	/* don't trigger an unnecessary math_state_restore() */
+	if (task->thread_info->status & TS_USEDFPU) {
+		save_init_fpu(task);
+	}
  	task->thread.trap_no = 19;
  	task->thread.error_code = 0;
  	info.si_signo = SIGFPE;
diff -u --recursive --new-file linux-2.6.0-test4/include/asm-i386/i387.h linux-2.6.0-test4-mine/include/asm-i386/i387.h
--- linux-2.6.0-test4/include/asm-i386/i387.h	2003-07-27 19:06:54.000000000 +0200
+++ linux-2.6.0-test4-mine/include/asm-i386/i387.h	2003-08-31 15:39:04.000000000 +0200
@@ -30,7 +30,7 @@
  static inline void __save_init_fpu( struct task_struct *tsk )
  {
  	if ( cpu_has_fxsr ) {
-		asm volatile( "fxsave %0 ; fnclex"
+		asm volatile( "fxsave %0 ; fclex"
  			      : "=m" (tsk->thread.i387.fxsave) );
  	} else {
  		asm volatile( "fnsave %0 ; fwait"
@@ -41,8 +41,10 @@

  static inline void save_init_fpu( struct task_struct *tsk )
  {
+	preempt_disable();
  	__save_init_fpu(tsk);
  	stts();
+	preempt_enable_no_resched();
  }


@@ -53,11 +55,13 @@

  #define clear_fpu( tsk )					\
  do {								\
+	preempt_disable();					\
  	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
  		asm volatile("fwait");				\
  		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
  		stts();						\
  	}							\
+	preempt_enable_no_resched();				\
  } while (0)

  /*



