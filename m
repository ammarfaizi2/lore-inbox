Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbTGDRpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 13:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbTGDRpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 13:45:14 -0400
Received: from [213.39.233.138] ([213.39.233.138]:52649 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266071AbTGDRpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 13:45:01 -0400
Date: Fri, 4 Jul 2003 19:58:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       linuxppc64-dev@lists.linuxppc.org, paulus@au.ibm.com, anton@au.ibm.com,
       engebret@us.ibm.com
Subject: [PATCH 2.5.73] Signal handling fix for ppc
Message-ID: <20030704175859.GF22152@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de> <20030704174558.GC22152@wohnheim.fh-wedel.de> <20030704175439.GE22152@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030704175439.GE22152@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch causes an application with a broken stack to die with a
SIGSEGV (and a core dump and all that) instead of a silent do_exit.

Most other architectures already have it, so ppc should get it as
well.

Anton, did I understand it correctly that you already have the
equivalent for ppc64 in the queue?

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster

--- linux-2.5.73/arch/ppc/kernel/signal.c~sigsegv_ppc	2003-07-03 19:17:21.000000000 +0200
+++ linux-2.5.73/arch/ppc/kernel/signal.c	2003-07-04 19:01:55.000000000 +0200
@@ -234,7 +234,9 @@
 	return 0;
 
 badframe:
-	do_exit(SIGSEGV);
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 static void
@@ -285,7 +287,9 @@
 	printk("badframe in setup_rt_frame, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	do_exit(SIGSEGV);
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 /*
@@ -332,7 +336,9 @@
 	return 0;
 
 badframe:
-	do_exit(SIGSEGV);
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }	
 
 /*
@@ -375,7 +381,9 @@
 	printk("badframe in setup_frame, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	do_exit(SIGSEGV);
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 /*
@@ -462,7 +470,9 @@
 	       regs, frame, *newspp);
 	printk("sc=%p sig=%d ka=%p info=%p oldset=%p\n", sc, sig, ka, info, oldset);
 #endif
-	do_exit(SIGSEGV);
+	if (sig == SIGSEGV)
+		ka->sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 /*
