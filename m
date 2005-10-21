Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVJUO5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVJUO5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVJUO5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:57:50 -0400
Received: from [63.240.77.84] ([63.240.77.84]:47868 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S964969AbVJUO5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:57:50 -0400
Date: Fri, 21 Oct 2005 09:57:26 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Matt_Domsch@dell.com
Subject: [PATCH 8/9] ipmi: kcs error0 delay
Message-ID: <20051021145726.GH19532@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BMCs can get into ERROR0 state while flashing new firmware,
particularly while the BMC is erasing the next flash block, which may
take a just under 2 seconds on a Dell PowerEdge 2800 (1.75 seconds
typical), during which time the single-threaded firmware may not be
able to process new commands.  In particular, clearing OBF may not
take effect immediately.

We want it to delay in ERROR0 after clearing OBF a bit waiting for OBF
to actually be clear before proceeding.

This introduces a new return value from the LLDD's event loop,
SI_SM_CALL_WITH_TICK_DELAY.  This means the calling thread/timer
should schedule_timeout() at least 1 tick, rather than busy-wait.
This is a longer delay than SI_SM_CALL_WITH_DELAY, which is typically
a 250us busy-wait.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.14-rc2/drivers/char/ipmi/ipmi_kcs_sm.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/char/ipmi/ipmi_kcs_sm.c
+++ linux-2.6.14-rc2/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/string.h>
+#include <linux/jiffies.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
@@ -99,6 +100,7 @@ enum kcs_states {
 #define IBF_RETRY_TIMEOUT 1000000
 #define OBF_RETRY_TIMEOUT 1000000
 #define MAX_ERROR_RETRIES 10
+#define ERROR0_OBF_WAIT_JIFFIES (2*HZ)
 
 struct si_sm_data
 {
@@ -115,6 +117,7 @@ struct si_sm_data
 	unsigned int  error_retries;
 	long          ibf_timeout;
 	long          obf_timeout;
+	unsigned long  error0_timeout;
 };
 
 static unsigned int init_kcs_data(struct si_sm_data *kcs,
@@ -187,6 +190,7 @@ static inline void start_error_recovery(
 			printk(KERN_DEBUG "ipmi_kcs_sm: kcs hosed: %s\n", reason);
 		kcs->state = KCS_HOSED;
 	} else {
+		kcs->error0_timeout = jiffies + ERROR0_OBF_WAIT_JIFFIES;
 		kcs->state = KCS_ERROR0;
 	}
 }
@@ -423,6 +427,10 @@ static enum si_sm_result kcs_event(struc
 
 	case KCS_ERROR0:
 		clear_obf(kcs, status);
+		status = read_status(kcs);
+		if  (GET_STATUS_OBF(status)) /* controller isn't responding */
+			if (time_before(jiffies, kcs->error0_timeout))
+				return SI_SM_CALL_WITH_TICK_DELAY;
 		write_cmd(kcs, KCS_GET_STATUS_ABORT);
 		kcs->state = KCS_ERROR1;
 		break;
Index: linux-2.6.14-rc2/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.14-rc2/drivers/char/ipmi/ipmi_si_intf.c
@@ -1965,7 +1965,8 @@ static int try_get_dev_id(struct smi_inf
 	smi_result = smi_info->handlers->event(smi_info->si_sm, 0);
 	for (;;)
 	{
-		if (smi_result == SI_SM_CALL_WITH_DELAY) {
+		if (smi_result == SI_SM_CALL_WITH_DELAY ||
+		    smi_result == SI_SM_CALL_WITH_TICK_DELAY) {
 			schedule_timeout_uninterruptible(1);
 			smi_result = smi_info->handlers->event(
 				smi_info->si_sm, 100);
Index: linux-2.6.14-rc2/drivers/char/ipmi/ipmi_si_sm.h
===================================================================
--- linux-2.6.14-rc2.orig/drivers/char/ipmi/ipmi_si_sm.h
+++ linux-2.6.14-rc2/drivers/char/ipmi/ipmi_si_sm.h
@@ -62,6 +62,7 @@ enum si_sm_result
 {
 	SI_SM_CALL_WITHOUT_DELAY, /* Call the driver again immediately */
 	SI_SM_CALL_WITH_DELAY,	/* Delay some before calling again. */
+	SI_SM_CALL_WITH_TICK_DELAY,	/* Delay at least 1 tick before calling again. */
 	SI_SM_TRANSACTION_COMPLETE, /* A transaction is finished. */
 	SI_SM_IDLE,		/* The SM is in idle state. */
 	SI_SM_HOSED,		/* The hardware violated the state machine. */
