Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266267AbUGAUcC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUGAUcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 16:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUGAUcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 16:32:02 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:4285 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266267AbUGAUbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 16:31:55 -0400
Date: Thu, 1 Jul 2004 15:31:17 -0500
From: linas@austin.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Cc: paulus@au1.ibm.com, Paul Mackerras <paulus@samba.org>,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6 PPC64: lockfix for rtas error log (third-times-a-charm?)]
Message-ID: <20040701153117.H21634@forte.austin.ibm.com>
References: <20040701141931.E21634@forte.austin.ibm.com> <1088711355.21679.152.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1088711355.21679.152.camel@nighthawk>; from haveblue@us.ibm.com on Thu, Jul 01, 2004 at 12:49:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 12:49:16PM -0700, Dave Hansen wrote:
> 
> You forgot to check the allocation for failure.

Ooops.  Here's another one.

------------------------------------------

> Upon closer analysis of the code, I see that log_rtas_error()
> was incorrectly named, and was being used incorrectly.  The
> solution is to get rid of it entirely; see patch below. So:
> 
> -- In one case kmalloc must be GFP_ATOMIC because rtas_call()
> can happen in any context, incl. irqs.
> -- In the other case, I turned it into GFP_KENREL, at the cost
> of doing a needless malloc/free in the vast majority of
> cases where there is no error.  Small price, as I beleive
> that this routine is very rarely called.
> 
> Patch below,
> Signed-off-by: Linas Vepstas <linas@linas.org>
> 

--- arch/ppc64/kernel/rtas.c.orig-pre-lockfix	2004-06-29 17:02:12.000000000 -0500
+++ arch/ppc64/kernel/rtas.c	2004-07-01 15:26:34.000000000 -0500
@@ -98,8 +98,14 @@ rtas_token(const char *service)
 }
 
 
+/** Return a copy of the detailed error text associated with the 
+ *  most recent failed call to rtas.  Because the error text 
+ *  might go stale if there are any other intervening rtas calls,
+ *  this routine must be called atomically with whatever produced
+ *  the error (i.e. with rtas.lock still held from the previous call). 
+ */
 static int
-__log_rtas_error(void)
+__fetch_rtas_last_error(void)
 {
 	struct rtas_args err_args, save_args;
 
@@ -126,19 +132,6 @@ __log_rtas_error(void)
 	return err_args.rets[0];
 }
 
-void
-log_rtas_error(void)
-{
-	unsigned long s;
-	int rc;
-
-	spin_lock_irqsave(&rtas.lock, s);
-	rc = __log_rtas_error();
-	spin_unlock_irqrestore(&rtas.lock, s);
-	if (rc == 0)
-		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
-}
-
 int
 rtas_call(int token, int nargs, int nret,
 	  unsigned long *outputs, ...)
@@ -147,6 +140,7 @@ rtas_call(int token, int nargs, int nret
 	int i, logit = 0;
 	unsigned long s;
 	struct rtas_args *rtas_args;
+	char * buff_copy = NULL;
 	int ret;
 
 	PPCDBG(PPCDBG_RTAS, "Entering rtas_call\n");
@@ -181,7 +175,7 @@ rtas_call(int token, int nargs, int nret
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	if (rtas_args->rets[0] == -1)
-		logit = (__log_rtas_error() == 0);
+		logit = (__fetch_rtas_last_error() == 0);
 
 	ifppcdebug(PPCDBG_RTAS) {
 		for(i=0; i < nret ;i++)
@@ -193,12 +187,21 @@ rtas_call(int token, int nargs, int nret
 			outputs[i] = rtas_args->rets[i+1];
 	ret = (int)((nret > 0) ? rtas_args->rets[0] : 0);
 
+	/* Log the error in the unlikely case that there was one. */
+	if (unlikely(logit)) {
+		buff_copy = kmalloc (RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
+		if (buff_copy) {
+			memcpy (buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+		}
+	}
+	
 	/* Gotta do something different here, use global lock for now... */
 	spin_unlock_irqrestore(&rtas.lock, s);
 
-	if (logit)
-		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
-
+	if (buff_copy) {
+		log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
+		kfree (buff_copy);
+	}
 	return ret;
 }
 
@@ -460,7 +463,9 @@ asmlinkage int ppc_rtas(struct rtas_args
 {
 	struct rtas_args args;
 	unsigned long flags;
+	char * buff_copy;
 	int nargs;
+	int err_rc;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -479,18 +484,32 @@ asmlinkage int ppc_rtas(struct rtas_args
 			   nargs * sizeof(rtas_arg_t)) != 0)
 		return -EFAULT;
 
+	buff_copy = kmalloc (RTAS_ERROR_LOG_MAX, GFP_KERNEL);
+
 	spin_lock_irqsave(&rtas.lock, flags);
 
 	get_paca()->xRtas = args;
 	enter_rtas(__pa(&get_paca()->xRtas));
 	args = get_paca()->xRtas;
 
-	spin_unlock_irqrestore(&rtas.lock, flags);
-
 	args.rets  = (rtas_arg_t *)&(args.args[nargs]);
-	if (args.rets[0] == -1)
-		log_rtas_error();
 
+	if (args.rets[0] == -1) {
+		err_rc = __fetch_rtas_last_error();
+		if ((err_rc == 0) && buff_copy) {
+			memcpy (buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+		}
+	}
+	
+	spin_unlock_irqrestore(&rtas.lock, flags);
+
+	if (buff_copy) {
+		if ((args.rets[0] == -1) && (err_rc == 0)) {
+			log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
+		}
+		kfree (buff_copy);
+	}
+	
 	/* Copy out args. */
 	if (copy_to_user(uargs->args + nargs,
 			 args.args + nargs,

