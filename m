Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbTIANPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 09:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbTIANPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 09:15:55 -0400
Received: from shower.ispgateway.de ([62.67.200.219]:39054 "HELO
	shower.ispgateway.de") by vger.kernel.org with SMTP id S262877AbTIANPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 09:15:52 -0400
Message-ID: <3F534686.1090106@dot-heine.de>
Date: Mon, 01 Sep 2003 15:15:50 +0200
From: Claus-Justus Heine <ch@dot-heine.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: bug WRT lazy FPU switching and CONFIG_PREEMPT
References: <qCCS.70v.9@gated-at.bofh.it>
In-Reply-To: <qCCS.70v.9@gated-at.bofh.it>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claus-Justus Heine wrote:

[snip]
> diff -u --recursive --new-file linux-2.6.0-test4/include/asm-i386/i387.h linux-2.6.0-test4-mine/include/asm-i386/i387.h
[snip]
> --- linux-2.6.0-test4/include/asm-i386/i387.h    2003-07-27 19:06:54.000000000 +0200
> +++ linux-2.6.0-test4-mine/include/asm-i386/i387.h    2003-08-31 15:39:04.000000000 +0200
> @@ -30,7 +30,7 @@
>  static inline void __save_init_fpu( struct task_struct *tsk )
>  {
>      if ( cpu_has_fxsr ) {
> -        asm volatile( "fxsave %0 ; fnclex"
> +        asm volatile( "fxsave %0 ; fclex"

I'm sorry, changing "fnclex" to "fclex" was a stupid idea, can lead to deadlocks. So that
patch should have looked like this:

#########################################################################################################################
diff -u --recursive --new-file linux-2.6.0-test4/arch/i386/kernel/traps.c linux-2.6.0-test4-mine/arch/i386/kernel/traps.c
--- linux-2.6.0-test4/arch/i386/kernel/traps.c    2003-08-31 15:22:42.000000000 +0200
+++ linux-2.6.0-test4-mine/arch/i386/kernel/traps.c    2003-08-31 15:35:49.000000000 +0200
@@ -605,7 +605,10 @@
       * Save the info for the exception handler and clear the error.
       */
      task = current;
-    save_init_fpu(task);
+    /* don't trigger an unnecessary math_state_restore() */
+    if (task->thread_info->status & TS_USEDFPU) {
+        save_init_fpu(task);
+    }
      task->thread.trap_no = 16;
      task->thread.error_code = 0;
      info.si_signo = SIGFPE;
@@ -667,7 +670,10 @@
       * Save the info for the exception handler and clear the error.
       */
      task = current;
-    save_init_fpu(task);
+    /* don't trigger an unnecessary math_state_restore() */
+    if (task->thread_info->status & TS_USEDFPU) {
+        save_init_fpu(task);
+    }
      task->thread.trap_no = 19;
      task->thread.error_code = 0;
      info.si_signo = SIGFPE;
diff -u --recursive --new-file linux-2.6.0-test4/include/asm-i386/i387.h linux-2.6.0-test4-mine/include/asm-i386/i387.h
--- linux-2.6.0-test4/include/asm-i386/i387.h    2003-07-27 19:06:54.000000000 +0200
+++ linux-2.6.0-test4-mine/include/asm-i386/i387.h    2003-08-31 15:39:04.000000000 +0200
@@ -41,8 +41,10 @@

  static inline void save_init_fpu( struct task_struct *tsk )
  {
+    preempt_disable();
      __save_init_fpu(tsk);
      stts();
+    preempt_enable_no_resched();
  }


@@ -53,11 +55,13 @@

  #define clear_fpu( tsk )                    \
  do {                                \
+    preempt_disable();                    \
      if ((tsk)->thread_info->status & TS_USEDFPU) {        \
          asm volatile("fwait");                \
          (tsk)->thread_info->status &= ~TS_USEDFPU;    \
          stts();                        \
      }                            \
+    preempt_enable_no_resched();                \
  } while (0)

  /*
##########################################################################################################################################


