Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVCHJvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVCHJvZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVCHJvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:51:24 -0500
Received: from ozlabs.org ([203.10.76.45]:29397 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261940AbVCHJtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:49:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16941.30010.486284.618596@cargo.ozlabs.ibm.com>
Date: Tue, 8 Mar 2005 20:49:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: johnrose@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 error code cleanups for rtas wrappers
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from John Rose <johnrose@austin.ibm.com>

This patch changes the rtas wrapper functions in rtas.c to map RTAS
failure codes to conventional error values.  The goal is to make
failure conditions obvious in the wrapper functions and in the caller
code.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/kernel/pSeries_smp.c~01_rtas_rcs arch/ppc64/kernel/pSeries_smp.c
--- 2_6_linus_3/arch/ppc64/kernel/pSeries_smp.c~01_rtas_rcs	2005-03-02 14:50:33.000000000 -0600
+++ 2_6_linus_3-johnrose/arch/ppc64/kernel/pSeries_smp.c	2005-03-02 14:50:33.000000000 -0600
@@ -151,7 +151,7 @@ static unsigned int find_physical_cpu_to
 		if (index) {
 			int state;
 			int rc = rtas_get_sensor(9003, *index, &state);
-			if (rc != 0 || state != 1)
+			if (rc < 0 || state != 1)
 				continue;
 		}
 
diff -puN arch/ppc64/kernel/rtas.c~01_rtas_rcs arch/ppc64/kernel/rtas.c
--- 2_6_linus_3/arch/ppc64/kernel/rtas.c~01_rtas_rcs	2005-03-02 14:50:33.000000000 -0600
+++ 2_6_linus_3-johnrose/arch/ppc64/kernel/rtas.c	2005-03-02 14:50:33.000000000 -0600
@@ -255,29 +255,59 @@ rtas_extended_busy_delay_time(int status
 	return ms; 
 }
 
-int
-rtas_get_power_level(int powerdomain, int *level)
+int rtas_error_rc(int rtas_rc)
+{
+	int rc;
+
+	switch (rtas_rc) {
+		case -1: 		/* Hardware Error */
+			rc = -EIO;
+			break;
+		case -3:		/* Bad indicator/domain/etc */
+			rc = -EINVAL;
+			break;
+		case -9000:		/* Isolation error */
+			rc = -EFAULT;
+			break;
+		case -9001:		/* Outstanding TCE/PTE */
+			rc = -EEXIST;
+			break;
+		case -9002:		/* No usable slot */
+			rc = -ENODEV;
+			break;
+		default:
+			printk(KERN_ERR "%s: unexpected RTAS error %d\n",
+					__FUNCTION__, rtas_rc);
+			rc = -ERANGE;
+			break;
+	}
+	return rc;
+}
+
+int rtas_get_power_level(int powerdomain, int *level)
 {
 	int token = rtas_token("get-power-level");
 	int rc;
 
 	if (token == RTAS_UNKNOWN_SERVICE)
-		return RTAS_UNKNOWN_OP;
+		return -ENOENT;
 
 	while ((rc = rtas_call(token, 1, 2, level, powerdomain)) == RTAS_BUSY)
 		udelay(1);
+
+	if (rc < 0)
+		return rtas_error_rc(rc);
 	return rc;
 }
 
-int
-rtas_set_power_level(int powerdomain, int level, int *setlevel)
+int rtas_set_power_level(int powerdomain, int level, int *setlevel)
 {
 	int token = rtas_token("set-power-level");
 	unsigned int wait_time;
 	int rc;
 
 	if (token == RTAS_UNKNOWN_SERVICE)
-		return RTAS_UNKNOWN_OP;
+		return -ENOENT;
 
 	while (1) {
 		rc = rtas_call(token, 2, 2, setlevel, powerdomain, level);
@@ -289,18 +319,20 @@ rtas_set_power_level(int powerdomain, in
 		} else
 			break;
 	}
+
+	if (rc < 0)
+		return rtas_error_rc(rc);
 	return rc;
 }
 
-int
-rtas_get_sensor(int sensor, int index, int *state)
+int rtas_get_sensor(int sensor, int index, int *state)
 {
 	int token = rtas_token("get-sensor-state");
 	unsigned int wait_time;
 	int rc;
 
 	if (token == RTAS_UNKNOWN_SERVICE)
-		return RTAS_UNKNOWN_OP;
+		return -ENOENT;
 
 	while (1) {
 		rc = rtas_call(token, 2, 2, state, sensor, index);
@@ -312,18 +344,20 @@ rtas_get_sensor(int sensor, int index, i
 		} else
 			break;
 	}
+
+	if (rc < 0)
+		return rtas_error_rc(rc);
 	return rc;
 }
 
-int
-rtas_set_indicator(int indicator, int index, int new_value)
+int rtas_set_indicator(int indicator, int index, int new_value)
 {
 	int token = rtas_token("set-indicator");
 	unsigned int wait_time;
 	int rc;
 
 	if (token == RTAS_UNKNOWN_SERVICE)
-		return RTAS_UNKNOWN_OP;
+		return -ENOENT;
 
 	while (1) {
 		rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
@@ -337,6 +371,8 @@ rtas_set_indicator(int indicator, int in
 			break;
 	}
 
+	if (rc < 0)
+		return rtas_error_rc(rc);
 	return rc;
 }
 
diff -puN arch/ppc64/kernel/rtasd.c~01_rtas_rcs arch/ppc64/kernel/rtasd.c
--- 2_6_linus_3/arch/ppc64/kernel/rtasd.c~01_rtas_rcs	2005-03-02 14:50:33.000000000 -0600
+++ 2_6_linus_3-johnrose/arch/ppc64/kernel/rtasd.c	2005-03-02 14:50:33.000000000 -0600
@@ -347,7 +347,7 @@ static int enable_surveillance(int timeo
 	if (error == 0)
 		return 0;
 
-	if (error == RTAS_NO_SUCH_INDICATOR) {
+	if (error == -EINVAL) {
 		printk(KERN_INFO "rtasd: surveillance not supported\n");
 		return 0;
 	}
diff -puN arch/ppc64/kernel/xics.c~01_rtas_rcs arch/ppc64/kernel/xics.c
--- 2_6_linus_3/arch/ppc64/kernel/xics.c~01_rtas_rcs	2005-03-02 14:50:33.000000000 -0600
+++ 2_6_linus_3-johnrose/arch/ppc64/kernel/xics.c	2005-03-02 14:50:33.000000000 -0600
@@ -654,7 +654,7 @@ void xics_migrate_irqs_away(void)
 	/* remove ourselves from the global interrupt queue */
 	status = rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
 		(1UL << interrupt_server_size) - 1 - default_distrib_server, 0);
-	WARN_ON(status != 0);
+	WARN_ON(status < 0);
 
 	/* Allow IPIs again... */
 	ops->cppr_info(cpu, DEFAULT_PRIORITY);
diff -puN include/asm-ppc64/rtas.h~01_rtas_rcs include/asm-ppc64/rtas.h
--- 2_6_linus_3/include/asm-ppc64/rtas.h~01_rtas_rcs	2005-03-02 14:50:33.000000000 -0600
+++ 2_6_linus_3-johnrose/include/asm-ppc64/rtas.h	2005-03-02 14:50:33.000000000 -0600
@@ -24,12 +24,9 @@
 
 /* RTAS return status codes */
 #define RTAS_BUSY		-2    /* RTAS Busy */
-#define RTAS_NO_SUCH_INDICATOR	-3    /* No such indicator implemented */
 #define RTAS_EXTENDED_DELAY_MIN	9900
 #define RTAS_EXTENDED_DELAY_MAX	9905
 
-#define RTAS_UNKNOWN_OP		-1099 /* Unknown RTAS Token */
-
 /*
  * In general to call RTAS use rtas_token("string") to lookup
  * an RTAS token for the given string (e.g. "event-scan").
