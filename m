Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUHXF7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUHXF7v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUHXF7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:59:51 -0400
Received: from ozlabs.org ([203.10.76.45]:3987 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265930AbUHXF7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:59:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16682.55772.155413.911904@cargo.ozlabs.ibm.com>
Date: Tue, 24 Aug 2004 16:02:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, nfont@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Fix enable_surveillance() for power5
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Nathan Fontenot: On some platforms (notably power5) you
can't enable surveillance (firmware/service processor watchdog) from
the kernel (you have to do it in the firmware).  This patch changes
enable_surveillance() to make the message that is printed in this
situation more informative.  Additionaly, the rtas_call was changed to
rtas_set_indicator so as to avoid having to handle RTAS_BUSY returns.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/rtasd.c akpm/arch/ppc64/kernel/rtasd.c
--- linux-2.5/arch/ppc64/kernel/rtasd.c	2004-08-24 11:25:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/rtasd.c	2004-08-24 15:53:41.482097680 +1000
@@ -343,15 +343,18 @@
 {
 	int error;
 
-	error = rtas_call(rtas_token("set-indicator"), 3, 1, NULL,
-			  SURVEILLANCE_TOKEN, 0, timeout);
+	error = rtas_set_indicator(SURVEILLANCE_TOKEN, 0, timeout);
 
-	if (error) {
-		printk(KERN_ERR "rtasd: could not enable surveillance\n");
-		return -1;
+	if (error == 0)
+		return 0;
+
+	if (error == RTAS_NO_SUCH_INDICATOR) {
+		printk(KERN_INFO "rtasd: surveillance not supported\n");
+		return 0;
 	}
 
-	return 0;
+	printk(KERN_ERR "rtasd: could not update surveillance\n");
+	return -1;
 }
 
 static int get_eventscan_parms(void)
diff -urN linux-2.5/include/asm-ppc64/rtas.h akpm/include/asm-ppc64/rtas.h
--- linux-2.5/include/asm-ppc64/rtas.h	2004-08-24 11:25:49.000000000 +1000
+++ akpm/include/asm-ppc64/rtas.h	2004-08-24 15:53:41.524091296 +1000
@@ -22,12 +22,13 @@
 /* Buffer size for ppc_rtas system call. */
 #define RTAS_RMOBUF_MAX (64 * 1024)
 
-/* RTAS return codes */
-#define RTAS_BUSY		-2	/* RTAS Return Status - Busy */
-#define RTAS_EXTENDED_DELAY_MIN 9900
-#define RTAS_EXTENDED_DELAY_MAX 9905
+/* RTAS return status codes */
+#define RTAS_BUSY		-2    /* RTAS Busy */
+#define RTAS_NO_SUCH_INDICATOR	-3    /* No such indicator implemented */
+#define RTAS_EXTENDED_DELAY_MIN	9900
+#define RTAS_EXTENDED_DELAY_MAX	9905
 
-#define RTAS_UNKNOWN_OP		-1099	/* Return Status - Unknown RTAS Token */
+#define RTAS_UNKNOWN_OP		-1099 /* Unknown RTAS Token */
 
 /*
  * In general to call RTAS use rtas_token("string") to lookup
