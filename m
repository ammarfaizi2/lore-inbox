Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319120AbSIJNXQ>; Tue, 10 Sep 2002 09:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319118AbSIJNXQ>; Tue, 10 Sep 2002 09:23:16 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:41738 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S319120AbSIJNXP>; Tue, 10 Sep 2002 09:23:15 -0400
Date: Tue, 10 Sep 2002 17:27:42 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: SIGSTKFLT on alpha, mips and sparc
Message-ID: <20020910172742.A28993@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SIGSTKFLT (stack fault on coprocessor) is not defined on these
platforms, so signal.c won't compile.

I would suggest something like this.

Ivan.

--- 2.5.34/kernel/signal.c	Tue Sep 10 01:15:36 2002
+++ linux/kernel/signal.c	Tue Sep 10 11:27:46 2002
@@ -75,10 +75,17 @@ int max_queued_signals = 1024;
 
 #define M(sig) (1UL << (sig))
 
+/* SIGSTKFLT does not exist on some architectures */
+#ifdef	SIGSTKFLT
+#define	M_SIGSTKFLT	M(SIGSTKFLT)
+#else
+#define	M_SIGSTKFLT	0
+#endif
+
 #define SIG_USER_SPECIFIC_MASK (\
 	M(SIGILL)    |  M(SIGTRAP)   |  M(SIGABRT)   |  M(SIGBUS)    | \
 	M(SIGFPE)    |  M(SIGSEGV)   |  M(SIGPIPE)   |  M(SIGXFSZ)   | \
-	M(SIGPROF)   |  M(SIGSYS)    |  M(SIGSTKFLT) |  M(SIGCONT)   )
+	M(SIGPROF)   |  M(SIGSYS)    |  M_SIGSTKFLT  |  M(SIGCONT)   )
 
 #define SIG_USER_LOAD_BALANCE_MASK (\
         M(SIGHUP)    |  M(SIGINT)    |  M(SIGQUIT)   |  M(SIGUSR1)   | \
@@ -95,7 +102,7 @@ int max_queued_signals = 1024;
 	M(SIGKILL)   |  M(SIGUSR1)   |  M(SIGSEGV)   |  M(SIGUSR2)   | \
 	M(SIGPIPE)   |  M(SIGALRM)   |  M(SIGTERM)   |  M(SIGXCPU)   | \
 	M(SIGXFSZ)   |  M(SIGVTALRM) |  M(SIGPROF)   |  M(SIGPOLL)   | \
-	M(SIGSYS)    |  M(SIGSTKFLT) |  M(SIGPWR)    |  M(SIGCONT)   | \
+	M(SIGSYS)    |  M_SIGSTKFLT  |  M(SIGPWR)    |  M(SIGCONT)   | \
         M(SIGSTOP)   |  M(SIGTSTP)   |  M(SIGTTIN)   |  M(SIGTTOU)   )
 
 #define SIG_KERNEL_ONLY_MASK (\
