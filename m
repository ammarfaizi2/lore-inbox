Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUHSFoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUHSFoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 01:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUHSFoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 01:44:14 -0400
Received: from ozlabs.org ([203.10.76.45]:31630 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265211AbUHSFoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 01:44:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16676.15957.61557.503764@cargo.ozlabs.ibm.com>
Date: Thu, 19 Aug 2004 15:44:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 rtas_call was calling kmalloc too early
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At present rtas_call() can be called before the kmalloc subsystem is
initialized, and if RTAS reports a hardware error, the code tries to
do a kmalloc to make a copy of the error report.  This patch changes
it so that we don't do the kmalloc in that situation.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN akpm-18aug/arch/ppc64/kernel/rtas.c akpm/arch/ppc64/kernel/rtas.c
--- akpm-18aug/arch/ppc64/kernel/rtas.c	2004-08-03 08:07:43.000000000 +1000
+++ akpm/arch/ppc64/kernel/rtas.c	2004-08-19 15:20:22.927953816 +1000
@@ -165,9 +165,12 @@
 
 	/* Log the error in the unlikely case that there was one. */
 	if (unlikely(logit)) {
-		buff_copy = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
-		if (buff_copy) {
-			memcpy(buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+		buff_copy = rtas_err_buf;
+		if (mem_init_done) {
+			buff_copy = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
+			if (buff_copy)
+				memcpy(buff_copy, rtas_err_buf,
+				       RTAS_ERROR_LOG_MAX);
 		}
 	}
 
@@ -176,7 +179,8 @@
 
 	if (buff_copy) {
 		log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
-		kfree(buff_copy);
+		if (mem_init_done)
+			kfree(buff_copy);
 	}
 	return ret;
 }
diff -urN akpm-18aug/include/asm-ppc64/system.h akpm/include/asm-ppc64/system.h
--- akpm-18aug/include/asm-ppc64/system.h	2004-07-12 09:12:04.000000000 +1000
+++ akpm/include/asm-ppc64/system.h	2004-08-19 15:24:47.249973728 +1000
@@ -128,6 +128,8 @@
 }
 #endif
 
+extern int mem_init_done;	/* set on boot once kmalloc can be called */
+
 /* EBCDIC -> ASCII conversion for [0-9A-Z] on iSeries */
 extern unsigned char e2a(unsigned char);
 
