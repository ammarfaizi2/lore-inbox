Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUDPF4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUDPF4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:56:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:37769 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262441AbUDPF4c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:56:32 -0400
Subject: [PATCH] ppc64: Fix RTAS races on pSeries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>
Content-Type: text/plain
Message-Id: <1082094687.2135.255.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 15:51:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The low level kernel interface to RTAS (the firmware runtime services)
was plagued with races that could cause from bogus results of RTAS
operations to total machine crashes in some circumstances. This patch
fix the ones I could identify, hoping I didn't miss any. I also added
a WARN_ON (well, it's asm equivalent) to enter_rtas to make sure we
never _ever_ try to call that with interrupts enabled.

Please, apply,
Ben.

===== arch/ppc64/kernel/rtas.c 1.39 vs edited =====
--- 1.39/arch/ppc64/kernel/rtas.c	Tue Apr 13 14:04:32 2004
+++ edited/arch/ppc64/kernel/rtas.c	Fri Apr 16 15:38:11 2004
@@ -68,15 +68,20 @@
 void
 call_rtas_display_status(char c)
 {
-	struct rtas_args *rtas = &(get_paca()->xRtas);
+	struct rtas_args *args = &(get_paca()->xRtas);
+	unsigned long s;
+
+	spin_lock_irqsave(&rtas.lock, s);
 
-	rtas->token = 10;
-	rtas->nargs = 1;
-	rtas->nret  = 1;
-	rtas->rets  = (rtas_arg_t *)&(rtas->args[1]);
-	rtas->args[0] = (int)c;
+	args->token = 10;
+	args->nargs = 1;
+	args->nret  = 1;
+	args->rets  = (rtas_arg_t *)&(args->args[1]);
+	args->args[0] = (int)c;
 
-	enter_rtas((void *)__pa((unsigned long)rtas));	
+	enter_rtas((void *)__pa((unsigned long)args));	
+
+	spin_unlock_irqrestore(&rtas.lock, s);
 }
 
 int
@@ -91,8 +96,9 @@
 	return tokp ? *tokp : RTAS_UNKNOWN_SERVICE;
 }
 
-void
-log_rtas_error(struct rtas_args	*rtas_args)
+
+static int
+__log_rtas_error(struct rtas_args *rtas_args)
 {
 	struct rtas_args err_args, temp_args;
 
@@ -111,14 +117,24 @@
 	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
 	       (void *)__pa((unsigned long)&err_args));
 	enter_rtas((void *)__pa((unsigned long)&get_paca()->xRtas));
-	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
-	
-
+	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");	
 
 	err_args = get_paca()->xRtas;
 	get_paca()->xRtas = temp_args;
 
-	if (err_args.rets[0] == 0)
+	return err_args.rets[0];
+}
+
+void
+log_rtas_error(struct rtas_args	*rtas_args)
+{
+	unsigned long s;
+	int rc;
+
+	spin_lock_irqsave(&rtas.lock, s);
+	rc = __log_rtas_error(rtas_args);
+	spin_unlock_irqrestore(&rtas.lock, s);
+	if (rc == 0)
 		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
 }
 
@@ -127,9 +143,10 @@
 	  unsigned long *outputs, ...)
 {
 	va_list list;
-	int i;
+	int i, logit = 0;
 	unsigned long s;
 	struct rtas_args *rtas_args = &(get_paca()->xRtas);
+	long ret;
 
 	PPCDBG(PPCDBG_RTAS, "Entering rtas_call\n");
 	PPCDBG(PPCDBG_RTAS, "\ttoken    = 0x%x\n", token);
@@ -139,6 +156,9 @@
 	if (token == RTAS_UNKNOWN_SERVICE)
 		return -1;
 
+	/* Gotta do something different here, use global lock for now... */
+	spin_lock_irqsave(&rtas.lock, s);
+
 	rtas_args->token = token;
 	rtas_args->nargs = nargs;
 	rtas_args->nret  = nret;
@@ -151,26 +171,16 @@
 	va_end(list);
 
 	for (i = 0; i < nret; ++i)
-	  rtas_args->rets[i] = 0;
+		rtas_args->rets[i] = 0;
 
-#if 0   /* Gotta do something different here, use global lock for now... */
-	spin_lock_irqsave(&rtas_args->lock, s);
-#else
-	spin_lock_irqsave(&rtas.lock, s);
-#endif
 	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
 		(void *)__pa((unsigned long)rtas_args));
 	enter_rtas((void *)__pa((unsigned long)rtas_args));
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	if (rtas_args->rets[0] == -1)
-		log_rtas_error(rtas_args);
+		logit = (__log_rtas_error(rtas_args) == 0);
 
-#if 0   /* Gotta do something different here, use global lock for now... */
-	spin_unlock_irqrestore(&rtas_args->lock, s);
-#else
-	spin_unlock_irqrestore(&rtas.lock, s);
-#endif
 	ifppcdebug(PPCDBG_RTAS) {
 		for(i=0; i < nret ;i++)
 			udbg_printf("\tnret[%d] = 0x%lx\n", i, (ulong)rtas_args->rets[i]);
@@ -179,7 +189,15 @@
 	if (nret > 1 && outputs != NULL)
 		for (i = 0; i < nret-1; ++i)
 			outputs[i] = rtas_args->rets[i+1];
-	return (ulong)((nret > 0) ? rtas_args->rets[0] : 0);
+	ret = (ulong)((nret > 0) ? rtas_args->rets[0] : 0);
+
+	/* Gotta do something different here, use global lock for now... */
+	spin_unlock_irqrestore(&rtas.lock, s);
+
+	if (logit)
+		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
+
+	return ret;
 }
 
 /* Given an RTAS status code of 990n compute the hinted delay of 10^n
@@ -465,12 +483,12 @@
 	enter_rtas((void *)__pa((unsigned long)&get_paca()->xRtas));
 	args = get_paca()->xRtas;
 
+	spin_unlock_irqrestore(&rtas.lock, flags);
+
 	args.rets  = (rtas_arg_t *)&(args.args[nargs]);
 	if (args.rets[0] == -1)
 		log_rtas_error(&args);
 
-	spin_unlock_irqrestore(&rtas.lock, flags);
-
 	/* Copy out args. */
 	if (copy_to_user(uargs->args + nargs,
 			 args.args + nargs,
@@ -486,7 +504,9 @@
 void rtas_stop_self(void)
 {
 	struct rtas_args *rtas_args = &(get_paca()->xRtas);
+	unsigned long s;
 
+	spin_lock_irqsave(&rtas.lock, s);
 	rtas_args->token = rtas_token("stop-self");
 	BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE);
 	rtas_args->nargs = 0;
@@ -496,6 +516,8 @@
 	printk("%u %u Ready to die...\n",
 	       smp_processor_id(), hard_smp_processor_id());
 	enter_rtas((void *)__pa(rtas_args));
+	spin_unlock_irqrestore(&rtas.lock, s);
+
 	panic("Alas, I survived.\n");
 }
 #endif /* CONFIG_HOTPLUG_CPU */
===== arch/ppc64/kernel/entry.S 1.40 vs edited =====
--- 1.40/arch/ppc64/kernel/entry.S	Thu Apr 15 09:47:36 2004
+++ edited/arch/ppc64/kernel/entry.S	Fri Apr 16 15:06:53 2004
@@ -487,7 +487,7 @@
 	mflr	r0
 	std	r0,16(r1)
         stdu	r1,-RTAS_FRAME_SIZE(r1)	/* Save SP and create stack space. */
-
+	
 	/* Because RTAS is running in 32b mode, it clobbers the high order half
 	 * of all registers that it saves.  We therefore save those registers
 	 * RTAS might touch to the stack.  (r0, r3-r13 are caller saved)
@@ -512,12 +512,25 @@
 	mfsrr1	r10
 	std	r10,_SRR1(r1)
 
+	/* There is no way it is acceptable to get here with interrupts enabled,
+	 * check it with the asm equivalent of WARN_ON
+	 */
+	mfmsr	r6
+	andi.	r0,r6,MSR_EE
+1:	tdnei	r0,0
+.section __bug_table,"a"
+	.llong	1b,__LINE__ + 0x1000000, 1f, 2f
+.previous
+.section .rodata,"a"
+1:	.asciz	__FILE__
+2:	.asciz "enter_rtas"
+.previous
+	
 	/* Unfortunately, the stack pointer and the MSR are also clobbered,
 	 * so they are saved in the PACA which allows us to restore
 	 * our original state after RTAS returns.
          */
 	std	r1,PACAR1(r13)
-	mfmsr	r6
         std	r6,PACASAVEDMSR(r13)
 
 	/* Setup our real return addr */	


