Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266146AbUF3ARp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUF3ARp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUF3ARp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:17:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53163 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266146AbUF3ARm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:17:42 -0400
Date: Tue, 29 Jun 2004 17:50:07 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: lockfix for rtas error log
Message-ID: <20040629175007.P21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Paul, 

Could you please apply the following path to the ameslab tree, and/or 
forward it to the main 2.6 kernel maintainers.

This patch moves the location of a lock in order to protect
the contents of a buffer until it has been copied to its final
destination. Prior to this, a race existed whereby the buffer
could be filled even while it was being emptied.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rtas-erbbuf-lockfix.patch"

--- arch/ppc64/kernel/rtas.c.orig-pre-lockfix	2004-06-29 17:02:12.000000000 -0500
+++ arch/ppc64/kernel/rtas.c	2004-06-29 17:14:05.000000000 -0500
@@ -134,9 +134,10 @@ log_rtas_error(void)
 
 	spin_lock_irqsave(&rtas.lock, s);
 	rc = __log_rtas_error();
-	spin_unlock_irqrestore(&rtas.lock, s);
-	if (rc == 0)
+	if (rc == 0) {
 		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
+	}
+	spin_unlock_irqrestore(&rtas.lock, s);
 }
 
 int
@@ -193,12 +194,13 @@ rtas_call(int token, int nargs, int nret
 			outputs[i] = rtas_args->rets[i+1];
 	ret = (int)((nret > 0) ? rtas_args->rets[0] : 0);
 
+	if (logit) {
+		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
+	}
+	
 	/* Gotta do something different here, use global lock for now... */
 	spin_unlock_irqrestore(&rtas.lock, s);
 
-	if (logit)
-		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
-
 	return ret;
 }
 

--BQPnanjtCNWHyqYD--
