Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266640AbUF3ML5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUF3ML5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUF3ML5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:11:57 -0400
Received: from ozlabs.org ([203.10.76.45]:3297 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266640AbUF3ML2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:11:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.44533.113909.519100@cargo.ozlabs.ibm.com>
Date: Wed, 30 Jun 2004 22:11:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@austin.ibm.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: Janitor log_rtas_error() call arguments
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch from Linas Vepstas (rediffed by me) fixes the confusing
argument aliasing of the log_rtas_error() subroutine.

This patch makes no functional changes, it just cleans up some 
strange usage.

The rtas_args used to communicate with firmware are always taken
from the paca struct, so as to keep the args at a fixed, low-memory 
location.  But the log_rtas_error() routine also took an rtas_args
pointer, which it assumed was aliased to the paca struct.  This
aliasing is both un-neccessary, and confusing; this patch eliminates
this confusion.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/rtas.c ppc64-2.5-pseries/arch/ppc64/kernel/rtas.c
--- linux-2.5/arch/ppc64/kernel/rtas.c	2004-06-30 22:00:43.437979400 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/rtas.c	2004-06-30 21:55:51.000000000 +1000
@@ -75,9 +75,9 @@
 
 
 static int
-__log_rtas_error(struct rtas_args *rtas_args)
+__log_rtas_error(void)
 {
-	struct rtas_args err_args, temp_args;
+	struct rtas_args err_args, save_args;
 
 	err_args.token = rtas_token("rtas-last-error");
 	err_args.nargs = 2;
@@ -88,7 +88,7 @@
 	err_args.args[1] = RTAS_ERROR_LOG_MAX;
 	err_args.args[2] = 0;
 
-	temp_args = *rtas_args;
+	save_args = rtas.args;
 	rtas.args = err_args;
 
 	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
@@ -97,19 +97,19 @@
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	err_args = rtas.args;
-	rtas.args = temp_args;
+	rtas.args = save_args;
 
 	return err_args.rets[0];
 }
 
 void
-log_rtas_error(struct rtas_args	*rtas_args)
+log_rtas_error(void)
 {
 	unsigned long s;
 	int rc;
 
 	spin_lock_irqsave(&rtas.lock, s);
-	rc = __log_rtas_error(rtas_args);
+	rc = __log_rtas_error();
 	spin_unlock_irqrestore(&rtas.lock, s);
 	if (rc == 0)
 		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
@@ -155,7 +155,7 @@
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	if (rtas_args->rets[0] == -1)
-		logit = (__log_rtas_error(rtas_args) == 0);
+		logit = (__log_rtas_error() == 0);
 
 	ifppcdebug(PPCDBG_RTAS) {
 		for(i=0; i < nret ;i++)
@@ -447,7 +447,7 @@
 
 	args.rets  = (rtas_arg_t *)&(args.args[nargs]);
 	if (args.rets[0] == -1)
-		log_rtas_error(&args);
+		log_rtas_error();
 
 	/* Copy out args. */
 	if (copy_to_user(uargs->args + nargs,
