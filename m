Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266238AbUGATTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266238AbUGATTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUGATTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:19:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:39118 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266238AbUGATTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:19:35 -0400
Date: Thu, 1 Jul 2004 14:19:31 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 PPC64: lockfix for rtas error log (third-times-a-charm?)]
Message-ID: <20040701141931.E21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Missed the patch again...  :)
Let me try again ... 


On Wed, Jun 30, 2004 at 01:47:29PM -0500, Benjamin Herrenschmidt wrote:
>
> > Well, the problem was that there is no lock that is protecting the
> > use of the single, global buffer.  Adding yet another lock is bad;
> > it makes hunting for deadlocks that much more tedious and difficult;
> > already, finding deadlocks is error-prone, and subject to bit-rot as
> > future hackers update the code.  So instead, the problem can be
easily
> > avoided by not using a global buffer.  The code below mallocs/frees.
> > Its not perf-critcal, so I don't mind malloc overhead.  Would this
> > work for you?  Patch attached below.
>
> I prefer that, but couldn't we move the kmalloc outside of the spinlock
> and so use GFP_KERNEL instead ?

OK,

Upon closer analysis of the code, I see that log_rtas_error()
was incorrectly named, and was being used incorrectly.  The
solution is to get rid of it entirely; see patch below. So:

-- In one case kmalloc must be GFP_ATOMIC because rtas_call()
can happen in any context, incl. irqs.
-- In the other case, I turned it into GFP_KENREL, at the cost
of doing a needless malloc/free in the vast majority of
cases where there is no error.  Small price, as I beleive
that this routine is very rarely called.

Patch below,
Signed-off-by: Linas Vepstas <linas@linas.org>

--linas

--- arch/ppc64/kernel/rtas.c.orig-pre-lockfix	2004-06-29 17:02:12.000000000 -0500
+++ arch/ppc64/kernel/rtas.c	2004-06-30 15:21:08.000000000 -0500
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
@@ -193,12 +187,19 @@ rtas_call(int token, int nargs, int nret
 			outputs[i] = rtas_args->rets[i+1];
 	ret = (int)((nret > 0) ? rtas_args->rets[0] : 0);
 
+	/* Log the error in the unlikely case that there was one. */
+	if (unlikely(logit)) {
+		buff_copy = kmalloc (RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
+		memcpy (buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
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
 
@@ -460,7 +461,9 @@ asmlinkage int ppc_rtas(struct rtas_args
 {
 	struct rtas_args args;
 	unsigned long flags;
+	char * buff_copy;
 	int nargs;
+	int err_rc;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -479,18 +482,30 @@ asmlinkage int ppc_rtas(struct rtas_args
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
+		if (err_rc == 0) {
+			memcpy (buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+		}
+	}
+	
+	spin_unlock_irqrestore(&rtas.lock, flags);
+
+	if (err_rc) {
+		log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
+	}
+	kfree (buff_copy);
+	
 	/* Copy out args. */
 	if (copy_to_user(uargs->args + nargs,
 			 args.args + nargs,

