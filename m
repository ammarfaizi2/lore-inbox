Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUIBGRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUIBGRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUIBGRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:17:22 -0400
Received: from ozlabs.org ([203.10.76.45]:2700 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267690AbUIBGRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 02:17:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16694.47719.94120.637334@cargo.ozlabs.ibm.com>
Date: Thu, 2 Sep 2004 16:15:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses the firmware-defined error log buffer length
for calls to the firmware routine 'check-exception'.   It also
simplifies code in rtasd.c that is attempting to obtain the
error log length.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/ras.c akpm/arch/ppc64/kernel/ras.c
--- linux-2.5/arch/ppc64/kernel/ras.c	2004-08-24 07:22:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/ras.c	2004-09-02 15:59:54.671421048 +1000
@@ -161,7 +161,8 @@
 			   RAS_VECTOR_OFFSET,
 			   virt_irq_to_real(irq_offset_down(irq)),
 			   RTAS_EPOW_WARNING | RTAS_POWERMGM_EVENTS,
-			   critical, __pa(&ras_log_buf), RTAS_ERROR_LOG_MAX);
+			   critical, __pa(&ras_log_buf),
+				rtas_get_error_log_max());
 
 	udbg_printf("EPOW <0x%lx 0x%x 0x%x>\n",
 		    *((unsigned long *)&ras_log_buf), status, state);
@@ -196,7 +197,8 @@
 			   RAS_VECTOR_OFFSET,
 			   virt_irq_to_real(irq_offset_down(irq)),
 			   RTAS_INTERNAL_ERROR, 1 /*Time Critical */,
-			   __pa(&ras_log_buf), RTAS_ERROR_LOG_MAX);
+			   __pa(&ras_log_buf),
+				rtas_get_error_log_max());
 
 	rtas_elog = (struct rtas_error_log *)ras_log_buf;
 
diff -urN linux-2.5/arch/ppc64/kernel/rtas.c akpm/arch/ppc64/kernel/rtas.c
--- linux-2.5/arch/ppc64/kernel/rtas.c	2004-08-24 07:22:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/rtas.c	2004-09-02 16:02:55.438363592 +1000
@@ -516,6 +516,26 @@
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+/*
+ * Return the firmware-specified size of the error log buffer
+ *  for all rtas calls that require an error buffer argument.
+ *  This includes 'check-exception' and 'rtas-last-error'.
+ */
+int rtas_get_error_log_max(void)
+{
+	static int rtas_error_log_max;
+	if (rtas_error_log_max)
+		return rtas_error_log_max;
+
+	rtas_error_log_max = rtas_token ("rtas-error-log-max");
+	if ((rtas_error_log_max == RTAS_UNKNOWN_SERVICE) ||
+	    (rtas_error_log_max > RTAS_ERROR_LOG_MAX)) {
+		printk (KERN_WARNING "RTAS: bad log buffer size %d\n", rtas_error_log_max);
+		rtas_error_log_max = RTAS_ERROR_LOG_MAX;
+	}
+	return rtas_error_log_max;
+}
+
 EXPORT_SYMBOL(rtas_firmware_flash_list);
 EXPORT_SYMBOL(rtas_token);
 EXPORT_SYMBOL(rtas_call);
@@ -526,3 +546,4 @@
 EXPORT_SYMBOL(rtas_get_power_level);
 EXPORT_SYMBOL(rtas_set_power_level);
 EXPORT_SYMBOL(rtas_set_indicator);
+EXPORT_SYMBOL(rtas_get_error_log_max);
diff -urN linux-2.5/arch/ppc64/kernel/rtasd.c akpm/arch/ppc64/kernel/rtasd.c
--- linux-2.5/arch/ppc64/kernel/rtasd.c	2004-08-25 07:48:20.000000000 +1000
+++ akpm/arch/ppc64/kernel/rtasd.c	2004-09-02 15:58:52.916357664 +1000
@@ -373,21 +373,8 @@
 	rtas_event_scan_rate = *ip;
 	DEBUG("rtas-event-scan-rate %d\n", rtas_event_scan_rate);
 
-	ip = (int *)get_property(node, "rtas-error-log-max", NULL);
-	if (ip == NULL) {
-		printk(KERN_ERR "rtasd: no rtas-error-log-max\n");
-		of_node_put(node);
-		return -1;
-	}
-	rtas_error_log_max = *ip;
-	DEBUG("rtas-error-log-max %d\n", rtas_error_log_max);
-
-	if (rtas_error_log_max > RTAS_ERROR_LOG_MAX) {
-		printk(KERN_ERR "rtasd: truncated error log from %d to %d bytes\n", rtas_error_log_max, RTAS_ERROR_LOG_MAX);
-		rtas_error_log_max = RTAS_ERROR_LOG_MAX;
-	}
-
 	/* Make room for the sequence number */
+	rtas_error_log_max = rtas_get_error_log_max();
 	rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
 
 	of_node_put(node);
diff -urN linux-2.5/include/asm-ppc64/rtas.h akpm/include/asm-ppc64/rtas.h
--- linux-2.5/include/asm-ppc64/rtas.h	2004-08-25 07:48:21.000000000 +1000
+++ akpm/include/asm-ppc64/rtas.h	2004-09-02 16:03:06.937346264 +1000
@@ -211,8 +211,14 @@
 #define RTAS_DEBUG KERN_DEBUG "RTAS: "
  
 #define RTAS_ERROR_LOG_MAX 2048
- 
- 
+
+/*
+ * Return the firmware-specified size of the error log buffer
+ *  for all rtas calls that require an error buffer argument.
+ *  This includes 'check-exception' and 'rtas-last-error'.
+ */
+extern int rtas_get_error_log_max(void);
+    
 /* Event Scan Parameters */
 #define EVENT_SCAN_ALL_EVENTS	0xf0000000
 #define SURVEILLANCE_TOKEN	9000
