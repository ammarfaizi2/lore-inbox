Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266784AbUF3RkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266784AbUF3RkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266779AbUF3Rjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:39:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55701 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266784AbUF3Rgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:36:45 -0400
Date: Wed, 30 Jun 2004 12:36:37 -0500
From: linas@austin.ibm.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@au1.ibm.com, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
Message-ID: <20040630123637.S21634@forte.austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com> <1088559864.1906.9.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1088559864.1906.9.camel@gaston>; from benh@kernel.crashing.org on Tue, Jun 29, 2004 at 08:44:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 29, 2004 at 08:44:26PM -0500, Benjamin Herrenschmidt wrote:
> On Tue, 2004-06-29 at 17:50, linas@austin.ibm.com wrote:
> > Paul,
> > 
> > Could you please apply the following path to the ameslab tree, and/or
> > forward it to the main 2.6 kernel maintainers.
> > 
> > This patch moves the location of a lock in order to protect
> > the contents of a buffer until it has been copied to its final
> > destination. Prior to this, a race existed whereby the buffer
> > could be filled even while it was being emptied.
> 
> Hrm....
> 
> That's bad, I moved that out of the lock on purpose to avoid deadlocks,

I looked for deadlocks, but didn't see anything obvious.  I'll take your
word, though.

> I think ppc_md.log_error can take the rtas lock again (nvram). We need to
> take a separate lock for the err buf if that function can be called
> concurrently I suppose.

Well, the problem was that there is no lock that is protecting the 
use of the single, global buffer.  Adding yet another lock is bad;
it makes hunting for deadlocks that much more tedious and difficult;
already, finding deadlocks is error-prone, and subject to bit-rot as 
future hackers update the code.  So instead, the problem can be easily 
avoided by not using a global buffer.  The code below mallocs/frees.
Its not perf-critcal, so I don't mind malloc overhead.  Would this
work for you?  Patch attached below.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas




--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rtas-lock-malloc.patch"

--- arch/ppc64/kernel/rtas.c.orig-pre-lockfix	2004-06-29 17:02:12.000000000 -0500
+++ arch/ppc64/kernel/rtas.c	2004-06-30 12:26:51.000000000 -0500
@@ -131,12 +131,20 @@ log_rtas_error(void)
 {
 	unsigned long s;
 	int rc;
+	char * buff_copy = NULL;
 
 	spin_lock_irqsave(&rtas.lock, s);
 	rc = __log_rtas_error();
+	if (rc == 0) {
+		buff_copy = kmalloc (RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
+		memcpy (buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+	}
 	spin_unlock_irqrestore(&rtas.lock, s);
-	if (rc == 0)
-		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
+
+	if (buff_copy) {
+		log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
+		kfree (buff_copy);
+	}
 }
 
 int
@@ -147,6 +155,7 @@ rtas_call(int token, int nargs, int nret
 	int i, logit = 0;
 	unsigned long s;
 	struct rtas_args *rtas_args;
+	char * buff_copy = NULL;
 	int ret;
 
 	PPCDBG(PPCDBG_RTAS, "Entering rtas_call\n");
@@ -193,12 +202,18 @@ rtas_call(int token, int nargs, int nret
 			outputs[i] = rtas_args->rets[i+1];
 	ret = (int)((nret > 0) ? rtas_args->rets[0] : 0);
 
+	if (logit) {
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
 

--FwyhczKCDPOVeYh6--
