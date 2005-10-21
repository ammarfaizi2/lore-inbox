Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVJUOu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVJUOu7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVJUOu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:50:59 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:53495 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964962AbVJUOu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:50:58 -0400
Date: Fri, 21 Oct 2005 09:50:55 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 2/9] ipmi: various si cleanup
Message-ID: <20051021145055.GB19532@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of small changes for the various system interface
drivers, consolidated from a number of patches from Matt Domsch.

Clear B2H_ATN and drain the BMC message buffer on command timeout.
This prevents further commands from failing after a timeout.

Add bt_debug and smic_debug module parameters, expose them in sysfs.
This lets you enable and disable debugging messages at runtime.

Unsigned jiffies math in ipmi_si_intf.c causes a too-large value to be
passed to ->event() after jiffies wrap-around.  The BT driver had
caught this, but didn't know how to fix it.  Now all calls to
->event() use a sane value for time.

Increase timeout for commands handed to the BT driver from 2 seconds to
5 seconds.  This is necessary particularly when the previous command
was a "Clear SEL", as that command completes, yet the BMC isn't really
ready to handle another command yet.

Silence BT debugging messages which were being printed on the
console.

Increase SMIC timeout form 1/10s to 2s.  This is needed on Dell
PowerEdge 2650 and PowerEdge 750 with ERA/O cards to allow commands to
complete without timing out.

Adds kcs_debug module param, to match behavior of BT and SMIC.  This
also prevents messages from being sent to the console unless
explicitly requested.

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: asdf/drivers/char/ipmi/ipmi_bt_sm.c
===================================================================
--- asdf.orig/drivers/char/ipmi/ipmi_bt_sm.c
+++ asdf/drivers/char/ipmi/ipmi_bt_sm.c
@@ -28,6 +28,8 @@
 
 #include <linux/kernel.h> /* For printk. */
 #include <linux/string.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
@@ -36,6 +38,8 @@ static int bt_debug = 0x00;	/* Productio
 #define	BT_DEBUG_ENABLE	1
 #define BT_DEBUG_MSG	2
 #define BT_DEBUG_STATES	4
+module_param(bt_debug, int, 0644);
+MODULE_PARM_DESC(bt_debug, "debug bitmask, 1=enable, 2=messages, 4=states");
 
 /* Typical "Get BT Capabilities" values are 2-3 retries, 5-10 seconds,
    and 64 byte buffers.  However, one HP implementation wants 255 bytes of
@@ -43,7 +47,7 @@ static int bt_debug = 0x00;	/* Productio
    Since the Open IPMI architecture is single-message oriented at this
    stage, the queue depth of BT is of no concern. */
 
-#define BT_NORMAL_TIMEOUT	2000000	/* seconds in microseconds */
+#define BT_NORMAL_TIMEOUT	5000000	/* seconds in microseconds */
 #define BT_RETRY_LIMIT		2
 #define BT_RESET_DELAY		6000000	/* 6 seconds after warm reset */
 
@@ -202,7 +206,7 @@ static int bt_get_result(struct si_sm_da
 	msg_len = bt->read_count - 2;		/* account for length & seq */
 	/* Always NetFn, Cmd, cCode */
 	if (msg_len < 3 || msg_len > IPMI_MAX_MSG_LENGTH) {
-		printk(KERN_WARNING "BT results: bad msg_len = %d\n", msg_len);
+		printk(KERN_DEBUG "BT results: bad msg_len = %d\n", msg_len);
 		data[0] = bt->write_data[1] | 0x4;	/* Kludge a response */
 		data[1] = bt->write_data[3];
 		data[2] = IPMI_ERR_UNSPECIFIED;
@@ -240,7 +244,7 @@ static void reset_flags(struct si_sm_dat
 	       BT_CONTROL(BT_B_BUSY);
 	BT_CONTROL(BT_CLR_WR_PTR);
 	BT_CONTROL(BT_SMS_ATN);
-#ifdef DEVELOPMENT_ONLY_NOT_FOR_PRODUCTION
+
 	if (BT_STATUS & BT_B2H_ATN) {
 		int i;
 		BT_CONTROL(BT_H_BUSY);
@@ -250,7 +254,6 @@ static void reset_flags(struct si_sm_dat
 		       BMC2HOST;
 		BT_CONTROL(BT_H_BUSY);
 	}
-#endif
 }
 
 static inline void write_all_bytes(struct si_sm_data *bt)
@@ -295,7 +298,7 @@ static inline int read_all_bytes(struct 
 	    	printk ("\n");
 	}
 	if (bt->seq != bt->write_data[2])	/* idiot check */
-		printk(KERN_WARNING "BT: internal error: sequence mismatch\n");
+		printk(KERN_DEBUG "BT: internal error: sequence mismatch\n");
 
 	/* per the spec, the (NetFn, Seq, Cmd) tuples should match */
 	if ((bt->read_data[3] == bt->write_data[3]) &&		/* Cmd */
@@ -321,18 +324,18 @@ static void error_recovery(struct si_sm_
 	bt->timeout = BT_NORMAL_TIMEOUT; /* various places want to retry */
 
 	status = BT_STATUS;
-	printk(KERN_WARNING "BT: %s in %s %s ", reason, STATE2TXT,
+	printk(KERN_DEBUG "BT: %s in %s %s\n", reason, STATE2TXT,
 	       STATUS2TXT(buf));
 
 	(bt->error_retries)++;
 	if (bt->error_retries > BT_RETRY_LIMIT) {
-		printk("retry limit (%d) exceeded\n", BT_RETRY_LIMIT);
+		printk(KERN_DEBUG "retry limit (%d) exceeded\n", BT_RETRY_LIMIT);
 		bt->state = BT_STATE_HOSED;
 		if (!bt->nonzero_status)
 			printk(KERN_ERR "IPMI: BT stuck, try power cycle\n");
 		else if (bt->seq == FIRST_SEQ + BT_RETRY_LIMIT) {
 			/* most likely during insmod */
-			printk(KERN_WARNING "IPMI: BT reset (takes 5 secs)\n");
+			printk(KERN_DEBUG "IPMI: BT reset (takes 5 secs)\n");
         		bt->state = BT_STATE_RESET1;
 		}
 	return;
@@ -340,11 +343,11 @@ static void error_recovery(struct si_sm_
 
 	/* Sometimes the BMC queues get in an "off-by-one" state...*/
 	if ((bt->state == BT_STATE_B2H_WAIT) && (status & BT_B2H_ATN)) {
-    		printk("retry B2H_WAIT\n");
+    		printk(KERN_DEBUG "retry B2H_WAIT\n");
 		return;
 	}
 
-	printk("restart command\n");
+	printk(KERN_DEBUG "restart command\n");
 	bt->state = BT_STATE_RESTART;
 }
 
@@ -372,17 +375,6 @@ static enum si_sm_result bt_event(struct
 	       return SI_SM_HOSED;
 
 	if (bt->state != BT_STATE_IDLE) {	/* do timeout test */
-
-		/* Certain states, on error conditions, can lock up a CPU
-		   because they are effectively in an infinite loop with
-		   CALL_WITHOUT_DELAY (right back here with time == 0).
-		   Prevent infinite lockup by ALWAYS decrementing timeout. */
-
-    	/* FIXME: bt_event is sometimes called with time > BT_NORMAL_TIMEOUT
-              (noticed in ipmi_smic_sm.c January 2004) */
-
-		if ((time <= 0) || (time >= BT_NORMAL_TIMEOUT))
-		       time = 100;
 		bt->timeout -= time;
 		if ((bt->timeout < 0) && (bt->state < BT_STATE_RESET1)) {
 			error_recovery(bt, "timed out");
Index: asdf/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- asdf.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ asdf/drivers/char/ipmi/ipmi_si_intf.c
@@ -819,7 +819,7 @@ static void smi_timeout(unsigned long da
 	enum si_sm_result smi_result;
 	unsigned long     flags;
 	unsigned long     jiffies_now;
-	unsigned long     time_diff;
+	long              time_diff;
 #ifdef DEBUG_TIMING
 	struct timeval    t;
 #endif
@@ -835,7 +835,7 @@ static void smi_timeout(unsigned long da
 	printk("**Timer: %d.%9.9d\n", t.tv_sec, t.tv_usec);
 #endif
 	jiffies_now = jiffies;
-	time_diff = ((jiffies_now - smi_info->last_timeout_jiffies)
+	time_diff = (((long)jiffies_now - (long)smi_info->last_timeout_jiffies)
 		     * SI_USEC_PER_JIFFY);
 	smi_result = smi_event_handler(smi_info, time_diff);
 
Index: asdf/drivers/char/ipmi/ipmi_smic_sm.c
===================================================================
--- asdf.orig/drivers/char/ipmi/ipmi_smic_sm.c
+++ asdf/drivers/char/ipmi/ipmi_smic_sm.c
@@ -43,6 +43,8 @@
 
 #include <linux/kernel.h> /* For printk. */
 #include <linux/string.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
@@ -56,6 +58,8 @@
 #define	SMIC_DEBUG_ENABLE	1
 
 static int smic_debug = 1;
+module_param(smic_debug, int, 0644);
+MODULE_PARM_DESC(smic_debug, "debug bitmask, 1=enable, 2=messages, 4=states");
 
 enum smic_states {
 	SMIC_IDLE,
@@ -76,7 +80,7 @@ enum smic_states {
 #define SMIC_MAX_ERROR_RETRIES 3
 
 /* Timeouts in microseconds. */
-#define SMIC_RETRY_TIMEOUT 100000
+#define SMIC_RETRY_TIMEOUT 2000000
 
 /* SMIC Flags Register Bits */
 #define SMIC_RX_DATA_READY	0x80
Index: asdf/drivers/char/ipmi/ipmi_kcs_sm.c
===================================================================
--- asdf.orig/drivers/char/ipmi/ipmi_kcs_sm.c
+++ asdf/drivers/char/ipmi/ipmi_kcs_sm.c
@@ -38,16 +38,24 @@
  */
 
 #include <linux/kernel.h> /* For printk. */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/string.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
 #include "ipmi_si_sm.h"
 
-/* Set this if you want a printout of why the state machine was hosed
-   when it gets hosed. */
-#define DEBUG_HOSED_REASON
-
-/* Print the state machine state on entry every time. */
-#undef DEBUG_STATE
+/* kcs_debug is a bit-field
+ *	KCS_DEBUG_ENABLE -	turned on for now
+ *	KCS_DEBUG_MSG    -	commands and their responses
+ *	KCS_DEBUG_STATES -	state machine
+ */
+#define KCS_DEBUG_STATES	4
+#define KCS_DEBUG_MSG		2
+#define	KCS_DEBUG_ENABLE	1
+
+static int kcs_debug;
+module_param(kcs_debug, int, 0644);
+MODULE_PARM_DESC(kcs_debug, "debug bitmask, 1=enable, 2=messages, 4=states");
 
 /* The states the KCS driver may be in. */
 enum kcs_states {
@@ -175,9 +183,8 @@ static inline void start_error_recovery(
 {
 	(kcs->error_retries)++;
 	if (kcs->error_retries > MAX_ERROR_RETRIES) {
-#ifdef DEBUG_HOSED_REASON
-		printk("ipmi_kcs_sm: kcs hosed: %s\n", reason);
-#endif
+		if (kcs_debug & KCS_DEBUG_ENABLE)
+			printk(KERN_DEBUG "ipmi_kcs_sm: kcs hosed: %s\n", reason);
 		kcs->state = KCS_HOSED;
 	} else {
 		kcs->state = KCS_ERROR0;
@@ -248,14 +255,21 @@ static void restart_kcs_transaction(stru
 static int start_kcs_transaction(struct si_sm_data *kcs, unsigned char *data,
 				 unsigned int size)
 {
+	unsigned int i;
+
 	if ((size < 2) || (size > MAX_KCS_WRITE_SIZE)) {
 		return -1;
 	}
-
 	if ((kcs->state != KCS_IDLE) && (kcs->state != KCS_HOSED)) {
 		return -2;
 	}
-
+	if (kcs_debug & KCS_DEBUG_MSG) {
+		printk(KERN_DEBUG "start_kcs_transaction -");
+		for (i = 0; i < size; i ++) {
+			printk(" %02x", (unsigned char) (data [i]));
+		}
+		printk ("\n");
+	}
 	kcs->error_retries = 0;
 	memcpy(kcs->write_data, data, size);
 	kcs->write_count = size;
@@ -305,9 +319,9 @@ static enum si_sm_result kcs_event(struc
 
 	status = read_status(kcs);
 
-#ifdef DEBUG_STATE
-	printk("  State = %d, %x\n", kcs->state, status);
-#endif
+	if (kcs_debug & KCS_DEBUG_STATES)
+		printk(KERN_DEBUG "KCS: State = %d, %x\n", kcs->state, status);
+
 	/* All states wait for ibf, so just do it here. */
 	if (!check_ibf(kcs, status, time))
 		return SI_SM_CALL_WITH_DELAY;
