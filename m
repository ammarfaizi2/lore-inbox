Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268313AbUHYUC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268313AbUHYUC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUHYUC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:02:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3293 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S268313AbUHYUCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:02:16 -0400
Date: Wed, 25 Aug 2004 15:01:38 -0500
To: paulus@au1.ibm.com, paulus@samba.org, anton@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 PPC64:  Another log buffer length patch.
Message-ID: <20040825200138.GN14002@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Paul, Anton,

During the last round of patches fixing the RTAS buffer length, 
the due diligence wasn't as diligent as it should have been. 
Here's one more. Please review and forward upstream.

This patch uses the firmware-defined error log buffer length
for calls to the firmware routine 'check-exception'.   It also
simplifies code in rtasd.c that is attempting to obtain the
error log length.

Signed-off-by: Linas Vepstas <linas@linas.org>

--linas

p.s. please be sure to cc me directly on replies, it 
seems I *still* cannot get email from the linuxppc64-dev 
mailing list.



--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ras-buf-len.patch"

===== arch/ppc64/kernel/ras.c 1.15 vs edited =====
--- 1.15/arch/ppc64/kernel/ras.c	Mon Aug  2 03:00:41 2004
+++ edited/arch/ppc64/kernel/ras.c	Wed Aug 25 14:46:33 2004
@@ -108,6 +108,7 @@
 
 	ras_get_sensor_state_token = rtas_token("get-sensor-state");
 	ras_check_exception_token = rtas_token("check-exception");
+	rtas_get_error_log_max();
 
 	/* Internal Errors */
 	np = of_find_node_by_path("/event-sources/internal-errors");
@@ -161,7 +162,8 @@
 			   RAS_VECTOR_OFFSET,
 			   virt_irq_to_real(irq_offset_down(irq)),
 			   RTAS_EPOW_WARNING | RTAS_POWERMGM_EVENTS,
-			   critical, __pa(&ras_log_buf), RTAS_ERROR_LOG_MAX);
+			   critical, __pa(&ras_log_buf), 
+				rtas_get_error_log_max());
 
 	udbg_printf("EPOW <0x%lx 0x%x 0x%x>\n",
 		    *((unsigned long *)&ras_log_buf), status, state);
@@ -196,7 +198,8 @@
 			   RAS_VECTOR_OFFSET,
 			   virt_irq_to_real(irq_offset_down(irq)),
 			   RTAS_INTERNAL_ERROR, 1 /*Time Critical */,
-			   __pa(&ras_log_buf), RTAS_ERROR_LOG_MAX);
+			   __pa(&ras_log_buf), 
+				rtas_get_error_log_max());
 
 	rtas_elog = (struct rtas_error_log *)ras_log_buf;
 
===== arch/ppc64/kernel/rtasd.c 1.26 vs edited =====
--- 1.26/arch/ppc64/kernel/rtasd.c	Mon Aug  2 03:00:41 2004
+++ edited/arch/ppc64/kernel/rtasd.c	Wed Aug 25 14:34:08 2004
@@ -318,21 +318,8 @@
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
===== include/asm-ppc64/rtas.h 1.20 vs edited =====
--- 1.20/include/asm-ppc64/rtas.h	Fri Jul  2 00:23:45 2004
+++ edited/include/asm-ppc64/rtas.h	Wed Aug 25 14:46:05 2004
@@ -1,6 +1,7 @@
 #ifndef _PPC64_RTAS_H
 #define _PPC64_RTAS_H
 
+#include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <asm/page.h>
 
@@ -199,8 +200,26 @@
 #define RTAS_DEBUG KERN_DEBUG "RTAS: "
  
 #define RTAS_ERROR_LOG_MAX 2048
- 
- 
+    
+/** Return the firmware-specified size of the error log buffer
+ *  for all rtas calls that require an error buffer argument.
+ *  This includes 'check-exception' and 'rtas-last-error'.
+ */
+static inline int rtas_get_error_log_max (void)
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
 /* Event Scan Parameters */
 #define EVENT_SCAN_ALL_EVENTS	0xf0000000
 #define SURVEILLANCE_TOKEN	9000

--IiVenqGWf+H9Y6IX--
