Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266370AbUF3Dys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266370AbUF3Dys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 23:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbUF3Dys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 23:54:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3810 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266370AbUF3Dyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 23:54:40 -0400
Date: Tue, 29 Jun 2004 16:41:01 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: Janitor log_rtas_error() call arguments
Message-ID: <20040629164100.O21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Paul,

Please apply the following patch to the ameslab tree and/or forward to
the official 2.6 tree maintainers, as appropriate.  This patch fixes the 
confusing argument aliasing of the log_rtas_error() subroutine.  

This patch makes no functional changes, it just cleans up some 
strange usage.

The rtas_args used to communicate with firmware are always taken
from the paca struct, so as to keep the args at a fixed, low-memory 
location.  But the log_rtas_error() routine also took an rtas_args
pointer, which it assumed was aliased to the paca struct.  This
aliasing is both un-neccessary, and confusing; this patch eliminates
this confusion.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas

--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rtas-args-aliasing.patch"

--- arch/ppc64/kernel/rtas.c.orig	2004-06-29 16:01:47.000000000 -0500
+++ arch/ppc64/kernel/rtas.c	2004-06-29 16:16:08.000000000 -0500
@@ -99,9 +99,9 @@ rtas_token(const char *service)
 
 
 static int
-__log_rtas_error(struct rtas_args *rtas_args)
+__log_rtas_error(void)
 {
-	struct rtas_args err_args, temp_args;
+	struct rtas_args err_args, save_args;
 
 	err_args.token = rtas_token("rtas-last-error");
 	err_args.nargs = 2;
@@ -112,7 +112,7 @@ __log_rtas_error(struct rtas_args *rtas_
 	err_args.args[1] = RTAS_ERROR_LOG_MAX;
 	err_args.args[2] = 0;
 
-	temp_args = *rtas_args;
+	save_args = get_paca()->xRtas;
 	get_paca()->xRtas = err_args;
 
 	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
@@ -121,19 +121,19 @@ __log_rtas_error(struct rtas_args *rtas_
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	err_args = get_paca()->xRtas;
-	get_paca()->xRtas = temp_args;
+	get_paca()->xRtas = save_args;
 
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
@@ -181,7 +181,7 @@ rtas_call(int token, int nargs, int nret
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	if (rtas_args->rets[0] == -1)
-		logit = (__log_rtas_error(rtas_args) == 0);
+		logit = (__log_rtas_error() == 0);
 
 	ifppcdebug(PPCDBG_RTAS) {
 		for(i=0; i < nret ;i++)
@@ -489,7 +489,7 @@ asmlinkage int ppc_rtas(struct rtas_args
 
 	args.rets  = (rtas_arg_t *)&(args.args[nargs]);
 	if (args.rets[0] == -1)
-		log_rtas_error(&args);
+		log_rtas_error();
 
 	/* Copy out args. */
 	if (copy_to_user(uargs->args + nargs,

--ylS2wUBXLOxYXZFQ--
