Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUHTKaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUHTKaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHTKaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:30:23 -0400
Received: from ozlabs.org ([203.10.76.45]:40910 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266566AbUHTK30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:29:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16677.53881.496607.688361@cargo.ozlabs.ibm.com>
Date: Fri, 20 Aug 2004 20:29:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Linas Vepstas <linas@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Use correct buffer size in RTAS call
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware expects the size of the buffer that you hand it when you ask
it for information about a hardware error to be of a very specific
size, but different versions of firmware appearently expect different
sizes; using the wrong size results in a painful, hard-to-debug crash
in firmware.  Benh provided a patch for this some months ago, but
appreantly missed this code path.  This patch sets up the log buffer
size dynamically; it also fixes a bug with the return code not being
handled correctly.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN akpm-19aug/arch/ppc64/kernel/rtas.c akpm/arch/ppc64/kernel/rtas.c
--- akpm-19aug/arch/ppc64/kernel/rtas.c	2004-08-19 15:20:22.000000000 +1000
+++ akpm/arch/ppc64/kernel/rtas.c	2004-08-20 20:23:15.666626040 +1000
@@ -22,7 +22,6 @@
 #include <asm/rtas.h>
 #include <asm/semaphore.h>
 #include <asm/machdep.h>
-#include <asm/paca.h>
 #include <asm/page.h>
 #include <asm/param.h>
 #include <asm/system.h>
@@ -73,7 +72,6 @@
 	return tokp ? *tokp : RTAS_UNKNOWN_SERVICE;
 }
 
-
 /** Return a copy of the detailed error text associated with the
  *  most recent failed call to rtas.  Because the error text
  *  might go stale if there are any other intervening rtas calls,
@@ -84,28 +82,32 @@
 __fetch_rtas_last_error(void)
 {
 	struct rtas_args err_args, save_args;
+	u32 bufsz;
+
+	bufsz = rtas_token ("rtas-error-log-max");
+	if ((bufsz == RTAS_UNKNOWN_SERVICE) ||
+	    (bufsz > RTAS_ERROR_LOG_MAX)) {
+		printk (KERN_WARNING "RTAS: bad log buffer size %d\n", bufsz);
+		bufsz = RTAS_ERROR_LOG_MAX;
+	}
 
 	err_args.token = rtas_token("rtas-last-error");
 	err_args.nargs = 2;
 	err_args.nret = 1;
-	err_args.rets = (rtas_arg_t *)&(err_args.args[2]);
 
 	err_args.args[0] = (rtas_arg_t)__pa(rtas_err_buf);
-	err_args.args[1] = RTAS_ERROR_LOG_MAX;
+	err_args.args[1] = bufsz;
 	err_args.args[2] = 0;
 
 	save_args = rtas.args;
 	rtas.args = err_args;
 
-	PPCDBG(PPCDBG_RTAS, "\tentering rtas with 0x%lx\n",
-	       __pa(&err_args));
 	enter_rtas(__pa(&rtas.args));
-	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
 	err_args = rtas.args;
 	rtas.args = save_args;
 
-	return err_args.rets[0];
+	return err_args.args[2];
 }
 
 int rtas_call(int token, int nargs, int nret, int *outputs, ...)
