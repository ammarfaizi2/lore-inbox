Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUETM0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUETM0M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 08:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265050AbUETM0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 08:26:12 -0400
Received: from ozlabs.org ([203.10.76.45]:20373 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265048AbUETMZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 08:25:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16556.41970.241616.7431@cargo.ozlabs.ibm.com>
Date: Thu, 20 May 2004 22:26:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH][PPC64] Make enter_rtas() take unsigned long arg
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We declare enter_rtas with a struct rtas_args * argument, though it
is supposed to be a physical address, and then every time we call it
we cast the unsigned long result from __pa() to a void *.  This patch
changes the declaration of enter_rtas to make it take an unsigned long
argument, and removes the cast from all the callers.  The actual
enter_rtas() routine is in assembler and doesn't need to be changed.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc64/kernel/rtas.c ppc64-2.5-pseries/arch/ppc64/kernel/rtas.c
--- linux-2.5/arch/ppc64/kernel/rtas.c	2004-05-20 08:06:38.000000000 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/rtas.c	2004-05-20 15:06:23.000000000 +1000
@@ -79,7 +79,7 @@
 	args->rets  = (rtas_arg_t *)&(args->args[1]);
 	args->args[0] = (int)c;
 
-	enter_rtas((void *)__pa((unsigned long)args));	
+	enter_rtas(__pa(args));
 
 	spin_unlock_irqrestore(&rtas.lock, s);
 }
@@ -115,9 +115,9 @@
 	get_paca()->xRtas = err_args;
 
 	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
-	       (void *)__pa((unsigned long)&err_args));
-	enter_rtas((void *)__pa((unsigned long)&get_paca()->xRtas));
-	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");	
+	       __pa(&err_args));
+	enter_rtas(__pa(&get_paca()->xRtas));
+	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	err_args = get_paca()->xRtas;
 	get_paca()->xRtas = temp_args;
@@ -174,8 +174,8 @@
 		rtas_args->rets[i] = 0;
 
 	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
-		(void *)__pa((unsigned long)rtas_args));
-	enter_rtas((void *)__pa((unsigned long)rtas_args));
+		__pa(rtas_args));
+	enter_rtas(__pa(rtas_args));
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	if (rtas_args->rets[0] == -1)
@@ -480,7 +480,7 @@
 	spin_lock_irqsave(&rtas.lock, flags);
 
 	get_paca()->xRtas = args;
-	enter_rtas((void *)__pa((unsigned long)&get_paca()->xRtas));
+	enter_rtas(__pa(&get_paca()->xRtas));
 	args = get_paca()->xRtas;
 
 	spin_unlock_irqrestore(&rtas.lock, flags);
@@ -515,7 +515,7 @@
 
 	printk("%u %u Ready to die...\n",
 	       smp_processor_id(), hard_smp_processor_id());
-	enter_rtas((void *)__pa(rtas_args));
+	enter_rtas(__pa(rtas_args));
 
 	panic("Alas, I survived.\n");
 }
diff -urN linux-2.5/include/asm-ppc64/rtas.h ppc64-2.5-pseries/include/asm-ppc64/rtas.h
--- linux-2.5/include/asm-ppc64/rtas.h	2004-04-13 09:25:10.000000000 +1000
+++ ppc64-2.5-pseries/include/asm-ppc64/rtas.h	2004-04-24 10:41:12.000000000 +1000
@@ -166,7 +166,7 @@
 
 extern struct rtas_t rtas;
 
-extern void enter_rtas(struct rtas_args *);
+extern void enter_rtas(unsigned long);
 extern int rtas_token(const char *service);
 extern long rtas_call(int token, int, int, unsigned long *, ...);
 extern void call_rtas_display_status(char);
