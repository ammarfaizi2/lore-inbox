Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUBXX47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUBXX46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:56:58 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:10131 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262532AbUBXXwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:52:05 -0500
Message-ID: <403BE39D.2080207@acm.org>
Date: Tue, 24 Feb 2004 17:51:57 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] IPMI driver updates, part 1b
References: <403B57B8.2000008@acm.org>
In-Reply-To: <403B57B8.2000008@acm.org>
Content-Type: multipart/mixed;
 boundary="------------070203080802000606080309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070203080802000606080309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It helps to actually attach the code.

Sorry,

-Corey

Corey Minyard wrote:

> It looks like part 1 of the IPMI driver updates was a little too big 
> to get through.  So I've split it up.  Part 1a and part1b must both be 
> applied.  Here's the original message.  Also, this is for the 2.6.3 
> kernel.
>
> It has been far too long since the last IPMI driver updates, but now 
> all the planets have aligned and all the pieces I needed are in and 
> all seem to be working.  This update is coming as four parts that must 
> be applied in order, but the later parts do not have to be applied for 
> the former parts to work.
>
> This first part does basic updates to the IPMI infrastructure.  It 
> adds support for messaging through an IPMI LAN interface, which is 
> required for some system software that already exists on other IPMI 
> drivers.  It also does some renaming (in preparation for one of the 
> later patches) and a lot of little cleanups.
>
> FYI, IPMI is a standard for monitoring and maintaining a system.  It 
> provides interfaces for detecting sensors (voltage, temperature, etc.) 
> in the system and monitoring those sensors.  Many systems have 
> extended capabilities that allow IPMI to control the system, doing 
> things like lighting leds and controlling hot-swap.  This driver 
> allows access to the IPMI system.
>
> -Corey
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--------------070203080802000606080309
Content-Type: text/plain;
 name="linux-2.6.3-ipmi-part1b-msghandler.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.3-ipmi-part1b-msghandler.diff"

diff -urN linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c linux-a1/drivers/char/ipmi/ipmi_kcs_intf.c
--- linux.orig/drivers/char/ipmi/ipmi_kcs_intf.c	2003-12-17 20:57:58.000000000 -0600
+++ linux-a1/drivers/char/ipmi/ipmi_kcs_intf.c	2004-02-23 08:19:35.000000000 -0600
@@ -55,7 +55,8 @@
 #include <linux/rcupdate.h>
 #include <linux/ipmi_smi.h>
 #include <asm/io.h>
+#include <asm/irq.h>
-#include "ipmi_kcs_sm.h"
+#include "ipmi_si_sm.h"
 #include <linux/init.h>
 
 /* Measure times between events in the driver. */
@@ -73,6 +73,8 @@
 /* This forces a dependency to the config file for this option. */
 #endif
 
+extern struct si_sm_handlers kcs_smi_handlers;
+
 enum kcs_intf_state {
 	KCS_NORMAL,
 	KCS_GETTING_FLAGS,
@@ -88,7 +90,7 @@
 struct kcs_info
 {
 	ipmi_smi_t          intf;
-	struct kcs_data     *kcs_sm;
+	struct si_sm_data   *kcs_sm;
 	spinlock_t          kcs_lock;
 	spinlock_t          msg_lock;
 	struct list_head    xmit_msgs;
@@ -113,8 +115,10 @@
 	   out. */
 	int                 run_to_completion;
 
+	struct si_sm_io     io;
+
 	/* The I/O port of a KCS interface. */
-	int                 port;
+	unsigned int        port;
 
 	/* zero if no irq; */
 	int                 irq;
@@ -165,7 +169,7 @@
 	deliver_recv_msg(kcs_info, msg);
 }
 
-static enum kcs_result start_next_msg(struct kcs_info *kcs_info)
+static enum si_sm_result start_next_msg(struct kcs_info *kcs_info)
 {
 	int              rv;
 	struct list_head *entry = NULL;
@@ -186,7 +190,7 @@
 
 	if (!entry) {
 		kcs_info->curr_msg = NULL;
-		rv = KCS_SM_IDLE;
+		rv = SI_SM_IDLE;
 	} else {
 		int err;
 
@@ -198,14 +202,15 @@
 		do_gettimeofday(&t);
 		printk("**Start2: %d.%9.9d\n", t.tv_sec, t.tv_usec);
 #endif
-		err = start_kcs_transaction(kcs_info->kcs_sm,
-					   kcs_info->curr_msg->data,
-					   kcs_info->curr_msg->data_size);
+		err = kcs_smi_handlers.start_transaction(
+		    kcs_info->kcs_sm,
+		    kcs_info->curr_msg->data,
+		    kcs_info->curr_msg->data_size);
 		if (err) {
 			return_hosed_msg(kcs_info);
 		}
 
-		rv = KCS_CALL_WITHOUT_DELAY;
+		rv = SI_SM_CALL_WITHOUT_DELAY;
 	}
 	spin_unlock(&(kcs_info->msg_lock));
 
@@ -221,7 +226,7 @@
 	msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
 	msg[1] = IPMI_GET_BMC_GLOBAL_ENABLES_CMD;
 
-	start_kcs_transaction(kcs_info->kcs_sm, msg, 2);
+	kcs_smi_handlers.start_transaction(kcs_info->kcs_sm, msg, 2);
 	kcs_info->kcs_state = KCS_ENABLE_INTERRUPTS1;
 }
 
@@ -234,7 +239,7 @@
 	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
 	msg[2] = WDT_PRE_TIMEOUT_INT;
 
-	start_kcs_transaction(kcs_info->kcs_sm, msg, 3);
+	kcs_smi_handlers.start_transaction(kcs_info->kcs_sm, msg, 3);
 	kcs_info->kcs_state = KCS_CLEARING_FLAGS;
 }
 
@@ -281,9 +286,10 @@
 		kcs_info->curr_msg->data[1] = IPMI_GET_MSG_CMD;
 		kcs_info->curr_msg->data_size = 2;
 
-		start_kcs_transaction(kcs_info->kcs_sm,
-				      kcs_info->curr_msg->data,
-				      kcs_info->curr_msg->data_size);
+		kcs_smi_handlers.start_transaction(
+		    kcs_info->kcs_sm,
+		    kcs_info->curr_msg->data,
+		    kcs_info->curr_msg->data_size);
 		kcs_info->kcs_state = KCS_GETTING_MESSAGES;
 	} else if (kcs_info->msg_flags & EVENT_MSG_BUFFER_FULL) {
 		/* Events available. */
@@ -299,9 +305,10 @@
 		kcs_info->curr_msg->data[1] = IPMI_READ_EVENT_MSG_BUFFER_CMD;
 		kcs_info->curr_msg->data_size = 2;
 
-		start_kcs_transaction(kcs_info->kcs_sm,
-				      kcs_info->curr_msg->data,
-				      kcs_info->curr_msg->data_size);
+		kcs_smi_handlers.start_transaction(
+		    kcs_info->kcs_sm,
+		    kcs_info->curr_msg->data,
+		    kcs_info->curr_msg->data_size);
 		kcs_info->kcs_state = KCS_GETTING_EVENTS;
 	} else {
 		kcs_info->kcs_state = KCS_NORMAL;
@@ -323,9 +330,10 @@
 			break;
 			
 		kcs_info->curr_msg->rsp_size
-			= kcs_get_result(kcs_info->kcs_sm,
-					 kcs_info->curr_msg->rsp,
-					 IPMI_MAX_MSG_LENGTH);
+			= kcs_smi_handlers.get_result(
+			    kcs_info->kcs_sm,
+			    kcs_info->curr_msg->rsp,
+			    IPMI_MAX_MSG_LENGTH);
 		
 		/* Do this here becase deliver_recv_msg() releases the
 		   lock, and a new message can be put in during the
@@ -341,7 +349,7 @@
 		unsigned int  len;
 
 		/* We got the flags from the KCS, now handle them. */
-		len = kcs_get_result(kcs_info->kcs_sm, msg, 4);
+		len = kcs_smi_handlers.get_result(kcs_info->kcs_sm, msg, 4);
 		if (msg[2] != 0) {
 			/* Error fetching flags, just give up for
 			   now. */
@@ -363,7 +371,7 @@
 		unsigned char msg[3];
 
 		/* We cleared the flags. */
-		kcs_get_result(kcs_info->kcs_sm, msg, 3);
+		kcs_smi_handlers.get_result(kcs_info->kcs_sm, msg, 3);
 		if (msg[2] != 0) {
 			/* Error clearing flags */
 			printk(KERN_WARNING
@@ -380,9 +388,9 @@
 	case KCS_GETTING_EVENTS:
 	{
 		kcs_info->curr_msg->rsp_size
-			= kcs_get_result(kcs_info->kcs_sm,
-					 kcs_info->curr_msg->rsp,
-					 IPMI_MAX_MSG_LENGTH);
+			= kcs_smi_handlers.get_result(kcs_info->kcs_sm,
+						      kcs_info->curr_msg->rsp,
+						      IPMI_MAX_MSG_LENGTH);
 
 		/* Do this here becase deliver_recv_msg() releases the
 		   lock, and a new message can be put in during the
@@ -405,9 +413,9 @@
 	case KCS_GETTING_MESSAGES:
 	{
 		kcs_info->curr_msg->rsp_size
-			= kcs_get_result(kcs_info->kcs_sm,
-					 kcs_info->curr_msg->rsp,
-					 IPMI_MAX_MSG_LENGTH);
+			= kcs_smi_handlers.get_result(kcs_info->kcs_sm,
+						      kcs_info->curr_msg->rsp,
+						      IPMI_MAX_MSG_LENGTH);
 
 		/* Do this here becase deliver_recv_msg() releases the
 		   lock, and a new message can be put in during the
@@ -432,7 +440,7 @@
 		unsigned char msg[4];
 
 		/* We got the flags from the KCS, now handle them. */
-		kcs_get_result(kcs_info->kcs_sm, msg, 4);
+		kcs_smi_handlers.get_result(kcs_info->kcs_sm, msg, 4);
 		if (msg[2] != 0) {
 			printk(KERN_WARNING
 			       "ipmi_kcs: Could not enable interrupts"
@@ -442,7 +450,8 @@
 			msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
 			msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
 			msg[2] = msg[3] | 1; /* enable msg queue int */
-			start_kcs_transaction(kcs_info->kcs_sm, msg,3);
+			kcs_smi_handlers.start_transaction(
+			    kcs_info->kcs_sm, msg,3);
 			kcs_info->kcs_state = KCS_ENABLE_INTERRUPTS2;
 		}
 		break;
@@ -453,7 +462,7 @@
 		unsigned char msg[4];
 
 		/* We got the flags from the KCS, now handle them. */
-		kcs_get_result(kcs_info->kcs_sm, msg, 4);
+		kcs_smi_handlers.get_result(kcs_info->kcs_sm, msg, 4);
 		if (msg[2] != 0) {
 			printk(KERN_WARNING
 			       "ipmi_kcs: Could not enable interrupts"
@@ -467,9 +476,10 @@
 
 /* Called on timeouts and events.  Timeouts should pass the elapsed
    time, interrupts should pass in zero. */
-static enum kcs_result kcs_event_handler(struct kcs_info *kcs_info, int time)
+static enum si_sm_result kcs_event_handler(struct kcs_info *kcs_info,
+					   int time)
 {
-	enum kcs_result kcs_result;
+	enum si_sm_result kcs_result;
 
  restart:
 	/* There used to be a loop here that waited a little while
@@ -478,19 +488,19 @@
 	   range, which is far too long to wait in an interrupt.  So
 	   we just run until the state machine tells us something
 	   happened or it needs a delay. */
-	kcs_result = kcs_event(kcs_info->kcs_sm, time);
+	kcs_result = kcs_smi_handlers.event(kcs_info->kcs_sm, time);
 	time = 0;
-	while (kcs_result == KCS_CALL_WITHOUT_DELAY)
+	while (kcs_result == SI_SM_CALL_WITHOUT_DELAY)
 	{
-		kcs_result = kcs_event(kcs_info->kcs_sm, 0);
+		kcs_result = kcs_smi_handlers.event(kcs_info->kcs_sm, 0);
 	}
 
-	if (kcs_result == KCS_TRANSACTION_COMPLETE)
+	if (kcs_result == SI_SM_TRANSACTION_COMPLETE)
 	{
 		handle_transaction_done(kcs_info);
-		kcs_result = kcs_event(kcs_info->kcs_sm, 0);
+		kcs_result = kcs_smi_handlers.event(kcs_info->kcs_sm, 0);
 	}
-	else if (kcs_result == KCS_SM_HOSED)
+	else if (kcs_result == SI_SM_HOSED)
 	{
 		if (kcs_info->curr_msg != NULL) {
 			/* If we were handling a user message, format
@@ -498,12 +508,12 @@
                            tell it about the error. */
 			return_hosed_msg(kcs_info);
 		}
-		kcs_result = kcs_event(kcs_info->kcs_sm, 0);
+		kcs_result = kcs_smi_handlers.event(kcs_info->kcs_sm, 0);
 		kcs_info->kcs_state = KCS_NORMAL;
 	}
 
 	/* We prefer handling attn over new messages. */
-	if (kcs_result == KCS_ATTN)
+	if (kcs_result == SI_SM_ATTN)
 	{
 		unsigned char msg[2];
 
@@ -515,19 +525,19 @@
 		msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
 		msg[1] = IPMI_GET_MSG_FLAGS_CMD;
 
-		start_kcs_transaction(kcs_info->kcs_sm, msg, 2);
+		kcs_smi_handlers.start_transaction(kcs_info->kcs_sm, msg, 2);
 		kcs_info->kcs_state = KCS_GETTING_FLAGS;
 		goto restart;
 	}
 
 	/* If we are currently idle, try to start the next message. */
-	if (kcs_result == KCS_SM_IDLE) {
+	if (kcs_result == SI_SM_IDLE) {
 		kcs_result = start_next_msg(kcs_info);
-		if (kcs_result != KCS_SM_IDLE)
+		if (kcs_result != SI_SM_IDLE)
 			goto restart;
         }
 
-	if ((kcs_result == KCS_SM_IDLE)
+	if ((kcs_result == SI_SM_IDLE)
 	    && (atomic_read(&kcs_info->req_events)))
 	{
 		/* We are idle and the upper layer requested that I fetch
@@ -538,7 +548,7 @@
 		msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
 		msg[1] = IPMI_GET_MSG_FLAGS_CMD;
 
-		start_kcs_transaction(kcs_info->kcs_sm, msg, 2);
+		kcs_smi_handlers.start_transaction(kcs_info->kcs_sm, msg, 2);
 		kcs_info->kcs_state = KCS_GETTING_FLAGS;
 		goto restart;
 	}
@@ -550,11 +560,11 @@
 		   struct ipmi_smi_msg *msg,
 		   int                 priority)
 {
-	struct kcs_info *kcs_info = (struct kcs_info *) send_info;
-	enum kcs_result result;
-	unsigned long   flags;
+	struct kcs_info    *kcs_info = (struct kcs_info *) send_info;
+	enum si_sm_result  result;
+	unsigned long      flags;
 #ifdef DEBUG_TIMING
-	struct timeval t;
+	struct timeval     t;
 #endif
 
 	spin_lock_irqsave(&(kcs_info->msg_lock), flags);
@@ -575,7 +585,7 @@
 
 		spin_lock_irqsave(&(kcs_info->kcs_lock), flags);
 		result = kcs_event_handler(kcs_info, 0);
-		while (result != KCS_SM_IDLE) {
+		while (result != SI_SM_IDLE) {
 			udelay(KCS_SHORT_TIMEOUT_USEC);
 			result = kcs_event_handler(kcs_info,
 						   KCS_SHORT_TIMEOUT_USEC);
@@ -603,16 +613,16 @@
 
 static void set_run_to_completion(void *send_info, int i_run_to_completion)
 {
-	struct kcs_info *kcs_info = (struct kcs_info *) send_info;
-	enum kcs_result result;
-	unsigned long   flags;
+	struct kcs_info    *kcs_info = (struct kcs_info *) send_info;
+	enum si_sm_result  result;
+	unsigned long      flags;
 
 	spin_lock_irqsave(&(kcs_info->kcs_lock), flags);
 
 	kcs_info->run_to_completion = i_run_to_completion;
 	if (i_run_to_completion) {
 		result = kcs_event_handler(kcs_info, 0);
-		while (result != KCS_SM_IDLE) {
+		while (result != SI_SM_IDLE) {
 			udelay(KCS_SHORT_TIMEOUT_USEC);
 			result = kcs_event_handler(kcs_info,
 						   KCS_SHORT_TIMEOUT_USEC);
@@ -667,13 +677,13 @@
 
 static void kcs_timeout(unsigned long data)
 {
-	struct kcs_info *kcs_info = (struct kcs_info *) data;
-	enum kcs_result kcs_result;
-	unsigned long   flags;
-	unsigned long   jiffies_now;
-	unsigned long   time_diff;
+	struct kcs_info    *kcs_info = (struct kcs_info *) data;
+	enum si_sm_result  kcs_result;
+	unsigned long      flags;
+	unsigned long      jiffies_now;
+	unsigned long      time_diff;
 #ifdef DEBUG_TIMING
-	struct timeval t;
+	struct timeval     t;
 #endif
 
 	if (kcs_info->stop_operation) {
@@ -703,7 +713,7 @@
 	/* If the state machine asks for a short delay, then shorten
            the timer timeout. */
 #ifdef CONFIG_HIGH_RES_TIMERS
-	if (kcs_result == KCS_CALL_WITH_DELAY) {
+	if (kcs_result == SI_SM_CALL_WITH_DELAY) {
 		kcs_info->kcs_timer.sub_expires
 			+= usec_to_arch_cycles(KCS_SHORT_TIMEOUT_USEC);
 		while (kcs_info->kcs_timer.sub_expires >= cycles_per_jiffies) {
@@ -716,7 +726,7 @@
 	}
 #else
 	/* If requested, take the shortest delay possible */
-	if (kcs_result == KCS_CALL_WITH_DELAY) {
+	if (kcs_result == SI_SM_CALL_WITH_DELAY) {
 		kcs_info->kcs_timer.expires = jiffies + 1;
 	} else {
 		kcs_info->kcs_timer.expires = jiffies + KCS_TIMEOUT_JIFFIES;
@@ -767,12 +777,12 @@
 extern int kcs_dbg;
 static int ipmi_kcs_detect_hardware(unsigned int port,
 				    unsigned char *addr,
-				    struct kcs_data *data)
+				    struct si_sm_data *data)
 {
-	unsigned char   msg[2];
-	unsigned char   resp[IPMI_MAX_MSG_LENGTH];
-	unsigned long   resp_len;
-	enum kcs_result kcs_result;
+	unsigned char      msg[2];
+	unsigned char      resp[IPMI_MAX_MSG_LENGTH];
+	unsigned long      resp_len;
+	enum si_sm_result  kcs_result;
 
 	/* It's impossible for the KCS status register to be all 1's,
 	   (assuming a properly functioning, self-initialized BMC)
@@ -789,29 +799,31 @@
 	   useful info. */
 	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
 	msg[1] = IPMI_GET_DEVICE_ID_CMD;
-	start_kcs_transaction(data, msg, 2);
+	kcs_smi_handlers.start_transaction(data, msg, 2);
 	
-	kcs_result = kcs_event(data, 0);
+	kcs_result = kcs_smi_handlers.event(data, 0);
 	for (;;)
 	{
-		if (kcs_result == KCS_CALL_WITH_DELAY) {
-			udelay(100);
-			kcs_result = kcs_event(data, 100);
+		if (kcs_result == SI_SM_CALL_WITH_DELAY) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
+			kcs_result = kcs_smi_handlers.event(data, 100);
 		}
-		else if (kcs_result == KCS_CALL_WITHOUT_DELAY)
+		else if (kcs_result == SI_SM_CALL_WITHOUT_DELAY)
 		{
-			kcs_result = kcs_event(data, 0);
+			kcs_result = kcs_smi_handlers.event(data, 0);
 		}
 		else
 			break;
 	}
-	if (kcs_result == KCS_SM_HOSED) {
+	if (kcs_result == SI_SM_HOSED) {
 		/* We couldn't get the state machine to run, so whatever's at
 		   the port is probably not an IPMI KCS interface. */
 		return -ENODEV;
 	}
 	/* Otherwise, we got some data. */
-	resp_len = kcs_get_result(data, resp, IPMI_MAX_MSG_LENGTH);
+	resp_len = kcs_smi_handlers.get_result(data, resp,
+					       IPMI_MAX_MSG_LENGTH);
 	if (resp_len < 6)
 		/* That's odd, it should be longer. */
 		return -EINVAL;
@@ -851,6 +863,36 @@
 MODULE_PARM(kcs_irqs, "1-4i");
 MODULE_PARM(kcs_ports, "1-4i");
 
+static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
+{
+	struct kcs_info *info = io->info;
+
+	return inb(info->port+offset);
+}
+
+static void port_outb(struct si_sm_io *io, unsigned int offset,
+		      unsigned char b)
+{
+	struct kcs_info *info = io->info;
+
+	outb(b, info->port+offset);
+}
+
+static unsigned char mem_inb(struct si_sm_io *io, unsigned int offset)
+{
+	struct kcs_info *info = io->info;
+
+	return readb(info->addr+offset);
+}
+
+static void mem_outb(struct si_sm_io *io, unsigned int offset,
+		     unsigned char b)
+{
+	struct kcs_info *info = io->info;
+
+	writeb(b, info->addr+offset);
+}
+
 /* Returns 0 if initialized, or negative on an error. */
 static int init_one_kcs(int kcs_port, 
 			int irq, 
@@ -893,6 +935,9 @@
 		       	       kcs_port);
 			return -EIO;
 		}
+		new_kcs->io.outputb = port_outb;
+		new_kcs->io.inputb = port_inb;
+		new_kcs->io.info = new_kcs;
 	} else {
 		if (request_mem_region(kcs_physaddr, 2, DEVICE_NAME) == NULL) {
 			kfree(new_kcs);
@@ -908,15 +953,18 @@
 		       	       kcs_physaddr);
 			return -EIO;
 		}
+		new_kcs->io.outputb = mem_outb;
+		new_kcs->io.inputb = mem_inb;
+		new_kcs->io.info = new_kcs;
 	}
 
-	new_kcs->kcs_sm = kmalloc(kcs_size(), GFP_KERNEL);
+	new_kcs->kcs_sm = kmalloc(kcs_smi_handlers.size(), GFP_KERNEL);
 	if (!new_kcs->kcs_sm) {
 		printk(KERN_ERR "ipmi_kcs: out of memory\n");
 		rv = -ENOMEM;
 		goto out_err;
 	}
-	init_kcs_data(new_kcs->kcs_sm, kcs_port, new_kcs->addr);
+	kcs_smi_handlers.init_data(new_kcs->kcs_sm, &(new_kcs->io));
 	spin_lock_init(&(new_kcs->kcs_lock));
 	spin_lock_init(&(new_kcs->msg_lock));
 
@@ -1021,47 +1069,47 @@
 #include <linux/acpi.h>
 
 struct SPMITable {
-	s8      Signature[4];
-	u32     Length;
-	u8      Revision;
-	u8      Checksum;
-	s8      OEMID[6];
-	s8      OEMTableID[8];
-	s8      OEMRevision[4];
-	s8      CreatorID[4];
-	s8      CreatorRevision[4];
-	u8      InterfaceType[2];
-	s16     SpecificationRevision;
+	s8	Signature[4];
+	u32	Length;
+	u8	Revision;
+	u8	Checksum;
+	s8	OEMID[6];
+	s8	OEMTableID[8];
+	s8	OEMRevision[4];
+	s8	CreatorID[4];
+	s8	CreatorRevision[4];
+	u8	InterfaceType[2];
+	s16	SpecificationRevision;
 
 	/*
 	 * Bit 0 - SCI interrupt supported
 	 * Bit 1 - I/O APIC/SAPIC
 	 */
-	u8      InterruptType;
+	u8	InterruptType;
 
 	/* If bit 0 of InterruptType is set, then this is the SCI
 	   interrupt in the GPEx_STS register. */
-	u8      GPE;
+	u8	GPE;
 
-	s16     Reserved;
+	s16	Reserved;
 
 	/* If bit 1 of InterruptType is set, then this is the I/O
-	   APIC/SAPIC interrupt. */
-	u32     GlobalSystemInterrupt;
+           APIC/SAPIC interrupt. */
+	u32	GlobalSystemInterrupt;
 
 	/* The actual register address. */
 	struct acpi_generic_address addr;
 
-	u8      UID[4];
+	u8	UID[4];
 
 	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
 };
 
 static int acpi_find_bmc(unsigned long *physaddr, int *port)
 {
-	acpi_status          status;
-	struct SPMITable     *spmi;
-	
+	acpi_status status;
+	struct SPMITable  *spmi;
+
 	status = acpi_get_firmware_table("SPMI", 1,
 					 ACPI_LOGICAL_ADDRESSING,
 					 (struct acpi_table_header **) &spmi);
@@ -1084,8 +1132,8 @@
 	} else if (spmi->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 		*port = spmi->addr.address;
 		printk("ipmi_kcs_intf: Found ACPI-specified state machine"
-		       " at I/O address 0x%lx\n",
-		       (unsigned long) spmi->addr.address);
+		       " at I/O address 0x%x\n",
+		       (unsigned int) spmi->addr.address);
 	} else
 		goto not_found; /* Not an address type we recognise. */
 
@@ -1134,7 +1182,7 @@
 	if (kcs_trydefaults && (pos == 0)) {
 		rv = -EINVAL;
 #ifdef CONFIG_ACPI_INTERPRETER
-		if (rv && (physaddr = acpi_find_bmc(&physaddr, &port) == 0)) {
+		if (rv && (acpi_find_bmc(&physaddr, &port) == 0)) {
 			rv = init_one_kcs(port, 
 					  0, 
 					  physaddr, 
@@ -1205,6 +1253,7 @@
 	/* Wait for the timer to stop.  This avoids problems with race
 	   conditions removing the timer here. */
 	while (!to_clean->timer_stopped) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 
diff -urN linux.orig/drivers/char/ipmi/ipmi_kcs_sm.c linux-a1/drivers/char/ipmi/ipmi_kcs_sm.c
--- linux.orig/drivers/char/ipmi/ipmi_kcs_sm.c	2003-12-17 20:58:15.000000000 -0600
+++ linux-a1/drivers/char/ipmi/ipmi_kcs_sm.c	2004-02-23 08:19:36.000000000 -0600
@@ -37,10 +37,12 @@
  * that document.
  */
 
-#include <asm/io.h>
-#include <asm/string.h>		/* Gets rid of memcpy warning */
+#include <linux/kernel.h> /* For printk. */
+#include <linux/string.h>
+#include <linux/ipmi_msgdefs.h>		/* for completion codes */
+#include "ipmi_si_sm.h"
 
-#include "ipmi_kcs_sm.h"
+#define IPMI_KCS_VERSION "v30"
 
 /* Set this if you want a printout of why the state machine was hosed
    when it gets hosed. */
@@ -92,32 +94,28 @@
 #define OBF_RETRY_TIMEOUT 1000000
 #define MAX_ERROR_RETRIES 10
 
-#define IPMI_ERR_MSG_TRUNCATED	0xc6
-#define IPMI_ERR_UNSPECIFIED	0xff
-
-struct kcs_data
+struct si_sm_data
 {
-	enum kcs_states state;
-	unsigned int    port;
-	unsigned char	*addr;
-	unsigned char   write_data[MAX_KCS_WRITE_SIZE];
-	int             write_pos;
-	int             write_count;
-	int             orig_write_count;
-	unsigned char   read_data[MAX_KCS_READ_SIZE];
-	int             read_pos;
-	int	        truncated;
+	enum kcs_states  state;
+	struct si_sm_io *io;
+	unsigned char    write_data[MAX_KCS_WRITE_SIZE];
+	int              write_pos;
+	int              write_count;
+	int              orig_write_count;
+	unsigned char    read_data[MAX_KCS_READ_SIZE];
+	int              read_pos;
+	int	         truncated;
 
 	unsigned int  error_retries;
 	long          ibf_timeout;
 	long          obf_timeout;
 };
 
-void init_kcs_data(struct kcs_data *kcs, unsigned int port, unsigned char *addr)
+static unsigned int init_kcs_data(struct si_sm_data *kcs,
+				  struct si_sm_io *io)
 {
 	kcs->state = KCS_IDLE;
-	kcs->port = port;
-	kcs->addr = addr;
+	kcs->io = io;
 	kcs->write_pos = 0;
 	kcs->write_count = 0;
 	kcs->orig_write_count = 0;
@@ -126,40 +124,29 @@
 	kcs->truncated = 0;
 	kcs->ibf_timeout = IBF_RETRY_TIMEOUT;
 	kcs->obf_timeout = OBF_RETRY_TIMEOUT;
-}
 
-/* Remember, init_one_kcs() insured port and addr can't both be set */
+	/* Reserve 2 I/O bytes. */
+	return 2;
+}
 
-static inline unsigned char read_status(struct kcs_data *kcs)
+static inline unsigned char read_status(struct si_sm_data *kcs)
 {
-        if (kcs->port)
-		return inb(kcs->port + 1);
-        else
-		return readb(kcs->addr + 1);
+	return kcs->io->inputb(kcs->io, 1);
 }
 
-static inline unsigned char read_data(struct kcs_data *kcs)
+static inline unsigned char read_data(struct si_sm_data *kcs)
 {
-        if (kcs->port)
-		return inb(kcs->port + 0);
-        else
-		return readb(kcs->addr + 0);
+	return kcs->io->inputb(kcs->io, 0);
 }
 
-static inline void write_cmd(struct kcs_data *kcs, unsigned char data)
+static inline void write_cmd(struct si_sm_data *kcs, unsigned char data)
 {
-        if (kcs->port)
-		outb(data, kcs->port + 1);
-        else
-		writeb(data, kcs->addr + 1);
+	kcs->io->outputb(kcs->io, 1, data);
 }
 
-static inline void write_data(struct kcs_data *kcs, unsigned char data)
+static inline void write_data(struct si_sm_data *kcs, unsigned char data)
 {
-        if (kcs->port)
-		outb(data, kcs->port + 0);
-        else
-		writeb(data, kcs->addr + 0);
+	kcs->io->outputb(kcs->io, 0, data);
 }
 
 /* Control codes. */
@@ -179,14 +166,14 @@
 #define GET_STATUS_OBF(status) ((status) & 0x01)
 
 
-static inline void write_next_byte(struct kcs_data *kcs)
+static inline void write_next_byte(struct si_sm_data *kcs)
 {
 	write_data(kcs, kcs->write_data[kcs->write_pos]);
 	(kcs->write_pos)++;
 	(kcs->write_count)--;
 }
 
-static inline void start_error_recovery(struct kcs_data *kcs, char *reason)
+static inline void start_error_recovery(struct si_sm_data *kcs, char *reason)
 {
 	(kcs->error_retries)++;
 	if (kcs->error_retries > MAX_ERROR_RETRIES) {
@@ -199,7 +186,7 @@
 	}
 }
 
-static inline void read_next_byte(struct kcs_data *kcs)
+static inline void read_next_byte(struct si_sm_data *kcs)
 {
 	if (kcs->read_pos >= MAX_KCS_READ_SIZE) {
 		/* Throw the data away and mark it truncated. */
@@ -212,9 +199,8 @@
 	write_data(kcs, KCS_READ_BYTE);
 }
 
-static inline int check_ibf(struct kcs_data *kcs,
-			    unsigned char   status,
-			    long            time)
+static inline int check_ibf(struct si_sm_data *kcs, unsigned char status,
+			    long time)
 {
 	if (GET_STATUS_IBF(status)) {
 		kcs->ibf_timeout -= time;
@@ -229,9 +215,8 @@
 	return 1;
 }
 
-static inline int check_obf(struct kcs_data *kcs,
-			    unsigned char   status,
-			    long            time)
+static inline int check_obf(struct si_sm_data *kcs, unsigned char status,
+			    long time)
 {
 	if (! GET_STATUS_OBF(status)) {
 		kcs->obf_timeout -= time;
@@ -245,13 +230,13 @@
 	return 1;
 }
 
-static void clear_obf(struct kcs_data *kcs, unsigned char status)
+static void clear_obf(struct si_sm_data *kcs, unsigned char status)
 {
 	if (GET_STATUS_OBF(status))
 		read_data(kcs);
 }
 
-static void restart_kcs_transaction(struct kcs_data *kcs)
+static void restart_kcs_transaction(struct si_sm_data *kcs)
 {
 	kcs->write_count = kcs->orig_write_count;
 	kcs->write_pos = 0;
@@ -262,7 +247,8 @@
 	write_cmd(kcs, KCS_WRITE_START);
 }
 
-int start_kcs_transaction(struct kcs_data *kcs, char *data, unsigned int size)
+static int start_kcs_transaction(struct si_sm_data *kcs, unsigned char *data,
+				 unsigned int size)
 {
 	if ((size < 2) || (size > MAX_KCS_WRITE_SIZE)) {
 		return -1;
@@ -284,7 +270,8 @@
 	return 0;
 }
 
-int kcs_get_result(struct kcs_data *kcs, unsigned char *data, int length)
+static int get_kcs_result(struct si_sm_data *kcs, unsigned char *data,
+			  unsigned int length)
 {
 	if (length < kcs->read_pos) {
 		kcs->read_pos = length;
@@ -313,7 +300,7 @@
 /* This implements the state machine defined in the IPMI manual, see
    that for details on how this works.  Divide that flowchart into
    sections delimited by "Wait for IBF" and this will become clear. */
-enum kcs_result kcs_event(struct kcs_data *kcs, long time)
+static enum si_sm_result kcs_event(struct si_sm_data *kcs, long time)
 {
 	unsigned char status;
 	unsigned char state;
@@ -325,7 +312,7 @@
 #endif
 	/* All states wait for ibf, so just do it here. */
 	if (!check_ibf(kcs, status, time))
-		return KCS_CALL_WITH_DELAY;
+		return SI_SM_CALL_WITH_DELAY;
 
 	/* Just about everything looks at the KCS state, so grab that, too. */
 	state = GET_STATUS_STATE(status);
@@ -336,9 +323,9 @@
 		clear_obf(kcs, status);
 
 		if (GET_STATUS_ATN(status))
-			return KCS_ATTN;
+			return SI_SM_ATTN;
 		else
-			return KCS_SM_IDLE;
+			return SI_SM_IDLE;
 
 	case KCS_START_OP:
 		if (state != KCS_IDLE) {
@@ -405,7 +392,7 @@
 
 		if (state == KCS_READ_STATE) {
 			if (! check_obf(kcs, status, time))
-				return KCS_CALL_WITH_DELAY;
+				return SI_SM_CALL_WITH_DELAY;
 			read_next_byte(kcs);
 		} else {
 			/* We don't implement this exactly like the state
@@ -418,7 +405,7 @@
 			clear_obf(kcs, status);
 			kcs->orig_write_count = 0;
 			kcs->state = KCS_IDLE;
-			return KCS_TRANSACTION_COMPLETE;
+			return SI_SM_TRANSACTION_COMPLETE;
 		}
 		break;
 
@@ -441,7 +428,7 @@
 			break;
 		}
 		if (! check_obf(kcs, status, time))
-			return KCS_CALL_WITH_DELAY;
+			return SI_SM_CALL_WITH_DELAY;
 
 		clear_obf(kcs, status);
 		write_data(kcs, KCS_READ_BYTE);
@@ -456,14 +443,14 @@
 		}
 
 		if (! check_obf(kcs, status, time))
-			return KCS_CALL_WITH_DELAY;
+			return SI_SM_CALL_WITH_DELAY;
 
 		clear_obf(kcs, status);
 		if (kcs->orig_write_count) {
 			restart_kcs_transaction(kcs);
 		} else {
 			kcs->state = KCS_IDLE;
-			return KCS_TRANSACTION_COMPLETE;
+			return SI_SM_TRANSACTION_COMPLETE;
 		}
 		break;
 			
@@ -472,14 +459,42 @@
 	}
 
 	if (kcs->state == KCS_HOSED) {
-		init_kcs_data(kcs, kcs->port, kcs->addr);
-		return KCS_SM_HOSED;
+		init_kcs_data(kcs, kcs->io);
+		return SI_SM_HOSED;
 	}
 
-	return KCS_CALL_WITHOUT_DELAY;
+	return SI_SM_CALL_WITHOUT_DELAY;
+}
+
+static int kcs_size(void)
+{
+	return sizeof(struct si_sm_data);
+}
+
+static int kcs_detect(struct si_sm_data *kcs)
+{
+	/* It's impossible for the KCS status register to be all 1's,
+	   (assuming a properly functioning, self-initialized BMC)
+	   but that's what you get from reading a bogus address, so we
+	   test that first. */
+	if (read_status(kcs) == 0xff)
+		return 1; 
+
+	return 0;
 }
 
-int kcs_size(void)
+static void kcs_cleanup(struct si_sm_data *kcs)
 {
-	return sizeof(struct kcs_data);
 }
+
+struct si_sm_handlers kcs_smi_handlers =
+{
+	.version           = IPMI_KCS_VERSION,
+	.init_data         = init_kcs_data,
+	.start_transaction = start_kcs_transaction,
+	.get_result        = get_kcs_result,
+	.event             = kcs_event,
+	.detect            = kcs_detect,
+	.cleanup           = kcs_cleanup,
+	.size              = kcs_size,
+};
diff -urN linux.orig/drivers/char/ipmi/ipmi_kcs_sm.h linux-a1/drivers/char/ipmi/ipmi_kcs_sm.h
--- linux.orig/drivers/char/ipmi/ipmi_kcs_sm.h	2003-12-17 20:59:05.000000000 -0600
+++ linux-a1/drivers/char/ipmi/ipmi_kcs_sm.h	1969-12-31 18:00:00.000000000 -0600
@@ -1,70 +0,0 @@
-/*
- * ipmi_kcs_sm.h
- *
- * State machine for handling IPMI KCS interfaces.
- *
- * Author: MontaVista Software, Inc.
- *         Corey Minyard <minyard@mvista.com>
- *         source@mvista.com
- *
- * Copyright 2002 MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License as published by the
- *  Free Software Foundation; either version 2 of the License, or (at your
- *  option) any later version.
- *
- *
- *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
- *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
- *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
- *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
- *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
- *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-struct kcs_data;
-
-void init_kcs_data(struct kcs_data *kcs,
-		   unsigned int    port,
-		   unsigned char   *addr);
-
-/* Start a new transaction in the state machine.  This will return -2
-   if the state machine is not idle, -1 if the size is invalid (to
-   large or too small), or 0 if the transaction is successfully
-   completed. */
-int start_kcs_transaction(struct kcs_data *kcs, char *data, unsigned int size);
-
-/* Return the results after the transaction.  This will return -1 if
-   the buffer is too small, zero if no transaction is present, or the
-   actual length of the result data. */
-int kcs_get_result(struct kcs_data *kcs, unsigned char *data, int length);
-
-enum kcs_result
-{
-	KCS_CALL_WITHOUT_DELAY, /* Call the driver again immediately */
-	KCS_CALL_WITH_DELAY,	/* Delay some before calling again. */
-	KCS_TRANSACTION_COMPLETE, /* A transaction is finished. */
-	KCS_SM_IDLE,		/* The SM is in idle state. */
-	KCS_SM_HOSED,		/* The hardware violated the state machine. */
-	KCS_ATTN		/* The hardware is asserting attn and the
-				   state machine is idle. */
-};
-
-/* Call this periodically (for a polled interface) or upon receiving
-   an interrupt (for a interrupt-driven interface).  If interrupt
-   driven, you should probably poll this periodically when not in idle
-   state.  This should be called with the time that passed since the
-   last call, if it is significant.  Time is in microseconds. */
-enum kcs_result kcs_event(struct kcs_data *kcs, long time);
-
-/* Return the size of the KCS structure in bytes. */
-int kcs_size(void);
diff -urN linux.orig/drivers/char/ipmi/ipmi_msghandler.c linux-a1/drivers/char/ipmi/ipmi_msghandler.c
--- linux.orig/drivers/char/ipmi/ipmi_msghandler.c	2003-12-17 20:58:57.000000000 -0600
+++ linux-a1/drivers/char/ipmi/ipmi_msghandler.c	2004-02-23 08:19:36.000000000 -0600
@@ -44,16 +44,21 @@
 #include <linux/ipmi_smi.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
+#include <linux/proc_fs.h>
+
+#define IPMI_MSGHANDLER_VERSION "v30"
 
 struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
 
 static int initialized = 0;
 
+static struct proc_dir_entry *proc_ipmi_root = NULL;
+
 #define MAX_EVENTS_IN_QUEUE	25
 
 /* Don't let a message sit in a queue forever, always time it with at lest
-   the max message timer. */
+   the max message timer.  This is in milliseconds. */
 #define MAX_MSG_TIMEOUT		60000
 
 struct ipmi_user
@@ -82,7 +87,8 @@
 
 struct seq_table
 {
-	int                  inuse : 1;
+	unsigned int         inuse : 1;
+	unsigned int         broadcast : 1;
 
 	unsigned long        timeout;
 	unsigned long        orig_timeout;
@@ -111,10 +117,19 @@
 
 #define NEXT_SEQID(seqid) (((seqid) + 1) & 0x3fffff)
 
+struct ipmi_channel
+{
+	unsigned char medium;
+	unsigned char protocol;
+};
 
 #define IPMI_IPMB_NUM_SEQ	64
+#define IPMI_MAX_CHANNELS       8
 struct ipmi_smi
 {
+	/* What interface number are we? */
+	int intf_num;
+
 	/* The list of upper layers that are using me.  We read-lock
            this when delivering messages to the upper layer to keep
            the user from going away while we are processing the
@@ -182,6 +197,86 @@
 	   it.  Note that the message will still be freed by the
 	   caller.  This only works on the system interface. */
 	void (*null_user_handler)(ipmi_smi_t intf, struct ipmi_smi_msg *msg);
+
+	/* When we are scanning the channels for an SMI, this will
+	   tell which channel we are scanning. */
+	int curr_channel;
+
+	/* Channel information */
+	struct ipmi_channel channels[IPMI_MAX_CHANNELS];
+
+	/* Proc FS stuff. */
+	struct proc_dir_entry *proc_dir;
+	char                  proc_dir_name[10];
+
+	spinlock_t   counter_lock; /* For making counters atomic. */
+
+	/* Commands we got that were invalid. */
+	unsigned int sent_invalid_commands;
+
+	/* Commands we sent to the MC. */
+	unsigned int sent_local_commands;
+	/* Responses from the MC that were delivered to a user. */
+	unsigned int handled_local_responses;
+	/* Responses from the MC that were not delivered to a user. */
+	unsigned int unhandled_local_responses;
+
+	/* Commands we sent out to the IPMB bus. */
+	unsigned int sent_ipmb_commands;
+	/* Commands sent on the IPMB that had errors on the SEND CMD */
+	unsigned int sent_ipmb_command_errs;
+	/* Each retransmit increments this count. */
+	unsigned int retransmitted_ipmb_commands;
+	/* When a message times out (runs out of retransmits) this is
+           incremented. */
+	unsigned int timed_out_ipmb_commands;
+
+	/* This is like above, but for broadcasts.  Broadcasts are
+           *not* included in the above count (they are expected to
+           time out). */
+	unsigned int timed_out_ipmb_broadcasts;
+
+	/* Responses I have sent to the IPMB bus. */
+	unsigned int sent_ipmb_responses;
+
+	/* The response was delivered to the user. */
+	unsigned int handled_ipmb_responses;
+	/* The response had invalid data in it. */
+	unsigned int invalid_ipmb_responses;
+	/* The response didn't have anyone waiting for it. */
+	unsigned int unhandled_ipmb_responses;
+
+	/* Commands we sent out to the IPMB bus. */
+	unsigned int sent_lan_commands;
+	/* Commands sent on the IPMB that had errors on the SEND CMD */
+	unsigned int sent_lan_command_errs;
+	/* Each retransmit increments this count. */
+	unsigned int retransmitted_lan_commands;
+	/* When a message times out (runs out of retransmits) this is
+           incremented. */
+	unsigned int timed_out_lan_commands;
+
+	/* Responses I have sent to the IPMB bus. */
+	unsigned int sent_lan_responses;
+
+	/* The response was delivered to the user. */
+	unsigned int handled_lan_responses;
+	/* The response had invalid data in it. */
+	unsigned int invalid_lan_responses;
+	/* The response didn't have anyone waiting for it. */
+	unsigned int unhandled_lan_responses;
+
+	/* The command was delivered to the user. */
+	unsigned int handled_commands;
+	/* The command had invalid data in it. */
+	unsigned int invalid_commands;
+	/* The command didn't have anyone waiting for it. */
+	unsigned int unhandled_commands;
+
+	/* Invalid data in an event. */
+	unsigned int invalid_events;
+	/* Events that were received with the proper format. */
+	unsigned int events;
 };
 
 int
@@ -264,6 +359,23 @@
 	return 0;
 }
 
+static void
+call_smi_watchers(int i)
+{
+	struct list_head *entry;
+
+	down_read(&smi_watchers_sem);
+	list_for_each(entry, &smi_watchers) {
+		struct ipmi_smi_watcher *w;
+		w = list_entry(entry, struct ipmi_smi_watcher, link);
+		if (try_module_get(w->owner)) {
+			w->new_smi(i);
+			module_put(w->owner);
+		}
+	}
+	up_read(&smi_watchers_sem);
+}
+
 int
 ipmi_addr_equal(struct ipmi_addr *addr1, struct ipmi_addr *addr2)
 {
@@ -293,6 +405,19 @@
 			&& (ipmb_addr1->lun == ipmb_addr2->lun));
 	}
 
+	if (addr1->addr_type == IPMI_LAN_ADDR_TYPE) {
+		struct ipmi_lan_addr *lan_addr1
+			= (struct ipmi_lan_addr *) addr1;
+		struct ipmi_lan_addr *lan_addr2
+		    = (struct ipmi_lan_addr *) addr2;
+
+		return ((lan_addr1->remote_SWID == lan_addr2->remote_SWID)
+			&& (lan_addr1->local_SWID == lan_addr2->local_SWID)
+			&& (lan_addr1->session_handle
+			    == lan_addr2->session_handle)
+			&& (lan_addr1->lun == lan_addr2->lun));
+	}
+
 	return 1;
 }
 
@@ -322,6 +447,13 @@
 		return 0;
 	}
 
+	if (addr->addr_type == IPMI_LAN_ADDR_TYPE) {
+		if (len < sizeof(struct ipmi_lan_addr)) {
+			return -EINVAL;
+		}
+		return 0;
+	}
+
 	return -EINVAL;
 }
 
@@ -341,7 +473,7 @@
 
 static void deliver_response(struct ipmi_recv_msg *msg)
 {
-    msg->user->handler->ipmi_recv_hndl(msg, msg->user->handler_data);
+	msg->user->handler->ipmi_recv_hndl(msg, msg->user->handler_data);
 }
 
 /* Find the next sequence number not being used and add the given
@@ -351,6 +483,7 @@
 			 struct ipmi_recv_msg *recv_msg,
 			 unsigned long        timeout,
 			 int                  retries,
+			 int                  broadcast,
 			 unsigned char        *seq,
 			 long                 *seqid)
 {
@@ -373,6 +506,7 @@
 		intf->seq_table[i].timeout = MAX_MSG_TIMEOUT;
 		intf->seq_table[i].orig_timeout = timeout;
 		intf->seq_table[i].retries_left = retries;
+		intf->seq_table[i].broadcast = broadcast;
 		intf->seq_table[i].inuse = 1;
 		intf->seq_table[i].seqid = NEXT_SEQID(intf->seq_table[i].seqid);
 		*seq = i;
@@ -425,8 +559,8 @@
 
 
 /* Start the timer for a specific sequence table entry. */
-static int intf_start_seq_timer(ipmi_smi_t           intf,
-				long                 msgid)
+static int intf_start_seq_timer(ipmi_smi_t intf,
+				long       msgid)
 {
 	int           rv = -ENODEV;
 	unsigned long flags;
@@ -451,6 +585,46 @@
 	return rv;
 }
 
+/* Got an error for the send message for a specific sequence number. */
+static int intf_err_seq(ipmi_smi_t   intf,
+			long         msgid,
+			unsigned int err)
+{
+	int                  rv = -ENODEV;
+	unsigned long        flags;
+	unsigned char        seq;
+	unsigned long        seqid;
+	struct ipmi_recv_msg *msg = NULL;
+
+
+	GET_SEQ_FROM_MSGID(msgid, seq, seqid);
+
+	spin_lock_irqsave(&(intf->seq_lock), flags);
+	/* We do this verification because the user can be deleted
+           while a message is outstanding. */
+	if ((intf->seq_table[seq].inuse)
+	    && (intf->seq_table[seq].seqid == seqid))
+	{
+		struct seq_table *ent = &(intf->seq_table[seq]);
+
+		ent->inuse = 0;
+		msg = ent->recv_msg;
+		rv = 0;
+	}
+	spin_unlock_irqrestore(&(intf->seq_lock), flags);
+
+	if (msg) {
+		msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
+		msg->msg_data[0] = err;
+		msg->msg.netfn |= 1; /* Convert to a response. */
+		msg->msg.data_len = 1;
+		msg->msg.data = msg->msg_data;
+		deliver_response(msg);
+	}
+
+	return rv;
+}
+
 
 int ipmi_create_user(unsigned int          if_num,
 		     struct ipmi_user_hndl *handler,
@@ -771,6 +945,43 @@
 	smi_msg->msgid = msgid;
 }
 
+static inline void format_lan_msg(struct ipmi_smi_msg   *smi_msg,
+				  struct ipmi_msg       *msg,
+				  struct ipmi_lan_addr  *lan_addr,
+				  long                  msgid,
+				  unsigned char         ipmb_seq,
+				  unsigned char         source_lun)
+{
+	/* Format the IPMB header data. */
+	smi_msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
+	smi_msg->data[1] = IPMI_SEND_MSG_CMD;
+	smi_msg->data[2] = lan_addr->channel;
+	smi_msg->data[3] = lan_addr->session_handle;
+	smi_msg->data[4] = lan_addr->remote_SWID;
+	smi_msg->data[5] = (msg->netfn << 2) | (lan_addr->lun & 0x3);
+	smi_msg->data[6] = ipmb_checksum(&(smi_msg->data[4]), 2);
+	smi_msg->data[7] = lan_addr->local_SWID;
+	smi_msg->data[8] = (ipmb_seq << 2) | source_lun;
+	smi_msg->data[9] = msg->cmd;
+
+	/* Now tack on the data to the message. */
+	if (msg->data_len > 0)
+		memcpy(&(smi_msg->data[10]), msg->data,
+		       msg->data_len);
+	smi_msg->data_size = msg->data_len + 10;
+
+	/* Now calculate the checksum and tack it on. */
+	smi_msg->data[smi_msg->data_size]
+		= ipmb_checksum(&(smi_msg->data[7]),
+				smi_msg->data_size-7);
+
+	/* Add on the checksum size and the offset from the
+	   broadcast. */
+	smi_msg->data_size += 1;
+
+	smi_msg->msgid = msgid;
+}
+
 /* Separate from ipmi_request so that the user does not have to be
    supplied in certain circumstances (mainly at panic time).  If
    messages are supplied, they will be freed, even if an error
@@ -780,11 +991,14 @@
 				 struct ipmi_addr     *addr,
 				 long                 msgid,
 				 struct ipmi_msg      *msg,
+				 void                 *user_msg_data,
 				 void                 *supplied_smi,
 				 struct ipmi_recv_msg *supplied_recv,
 				 int                  priority,
 				 unsigned char        source_address,
-				 unsigned char        source_lun)
+				 unsigned char        source_lun,
+				 int                  retries,
+				 unsigned int         retry_time_ms)
 {
 	int                  rv = 0;
 	struct ipmi_smi_msg  *smi_msg;
@@ -800,6 +1014,7 @@
 			return -ENOMEM;
 		}
 	}
+	recv_msg->user_msg_data = user_msg_data;
 
 	if (supplied_smi) {
 		smi_msg = (struct ipmi_smi_msg *) supplied_smi;
@@ -811,11 +1026,6 @@
 		}
 	}
 
-	if (addr->channel > IPMI_NUM_CHANNELS) {
-	    rv = -EINVAL;
-	    goto out_err;
-	}
-
 	recv_msg->user = user;
 	recv_msg->msgid = msgid;
 	/* Store the message to send in the receive message so timeout
@@ -825,10 +1035,20 @@
 	if (addr->addr_type == IPMI_SYSTEM_INTERFACE_ADDR_TYPE) {
 		struct ipmi_system_interface_addr *smi_addr;
 
+		if (msg->netfn & 1) {
+			/* Responses are not allowed to the SMI. */
+			rv = -EINVAL;
+			goto out_err;
+		}
 
 		smi_addr = (struct ipmi_system_interface_addr *) addr;
-		if (smi_addr->lun > 3)
-			return -EINVAL;
+		if (smi_addr->lun > 3) {
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+			rv = -EINVAL;
+			goto out_err;
+		}
 
 		memcpy(&recv_msg->addr, smi_addr, sizeof(*smi_addr));
 
@@ -839,11 +1059,17 @@
 		{
 			/* We don't let the user do these, since we manage
 			   the sequence numbers. */
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
 			rv = -EINVAL;
 			goto out_err;
 		}
 
 		if ((msg->data_len + 2) > IPMI_MAX_MSG_LENGTH) {
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
 			rv = -EMSGSIZE;
 			goto out_err;
 		}
@@ -855,41 +1081,69 @@
 		if (msg->data_len > 0)
 			memcpy(&(smi_msg->data[2]), msg->data, msg->data_len);
 		smi_msg->data_size = msg->data_len + 2;
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->sent_local_commands++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
 	} else if ((addr->addr_type == IPMI_IPMB_ADDR_TYPE)
 		   || (addr->addr_type == IPMI_IPMB_BROADCAST_ADDR_TYPE))
 	{
 		struct ipmi_ipmb_addr *ipmb_addr;
 		unsigned char         ipmb_seq;
 		long                  seqid;
-		int                   broadcast;
-		int                   retries;
+		int                   broadcast = 0;
 
-		if (addr == NULL) {
+		if (addr->channel > IPMI_NUM_CHANNELS) {
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+			rv = -EINVAL;
+			goto out_err;
+		}
+
+		if (intf->channels[addr->channel].medium
+		    != IPMI_CHANNEL_MEDIUM_IPMB)
+		{
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
 			rv = -EINVAL;
 			goto out_err;
 		}
 
+		if (retries < 0) {
+		    if (addr->addr_type == IPMI_IPMB_BROADCAST_ADDR_TYPE)
+			retries = 0; /* Don't retry broadcasts. */
+		    else
+			retries = 4;
+		}
 		if (addr->addr_type == IPMI_IPMB_BROADCAST_ADDR_TYPE) {
 		    /* Broadcasts add a zero at the beginning of the
 		       message, but otherwise is the same as an IPMB
 		       address. */
 		    addr->addr_type = IPMI_IPMB_ADDR_TYPE;
 		    broadcast = 1;
-		    retries = 0; /* Don't retry broadcasts. */
-		} else {
-		    broadcast = 0;
-		    retries = 4;
 		}
 
+
+		/* Default to 1 second retries. */
+		if (retry_time_ms == 0)
+		    retry_time_ms = 1000;
+
 		/* 9 for the header and 1 for the checksum, plus
                    possibly one for the broadcast. */
 		if ((msg->data_len + 10 + broadcast) > IPMI_MAX_MSG_LENGTH) {
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
 			rv = -EMSGSIZE;
 			goto out_err;
 		}
 
 		ipmb_addr = (struct ipmi_ipmb_addr *) addr;
 		if (ipmb_addr->lun > 3) {
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
 			rv = -EINVAL;
 			goto out_err;
 		}
@@ -899,21 +1153,32 @@
 		if (recv_msg->msg.netfn & 0x1) {
 			/* It's a response, so use the user's sequence
                            from msgid. */
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_ipmb_responses++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
 			format_ipmb_msg(smi_msg, msg, ipmb_addr, msgid,
 					msgid, broadcast,
 					source_address, source_lun);
+
+			/* Save the receive message so we can use it
+			   to deliver the response. */
+			smi_msg->user_data = recv_msg;
 		} else {
 			/* It's a command, so get a sequence for it. */
 
 			spin_lock_irqsave(&(intf->seq_lock), flags);
 
+			spin_lock(&intf->counter_lock);
+			intf->sent_ipmb_commands++;
+			spin_unlock(&intf->counter_lock);
+
 			/* Create a sequence number with a 1 second
                            timeout and 4 retries. */
-			/* FIXME - magic number for the timeout. */
 			rv = intf_next_seq(intf,
 					   recv_msg,
-					   1000,
+					   retry_time_ms,
 					   retries,
+					   broadcast,
 					   &ipmb_seq,
 					   &seqid);
 			if (rv) {
@@ -947,18 +1212,132 @@
                            to be correct. */
 			spin_unlock_irqrestore(&(intf->seq_lock), flags);
 		}
+	} else if (addr->addr_type == IPMI_LAN_ADDR_TYPE) {
+		struct ipmi_lan_addr  *lan_addr;
+		unsigned char         ipmb_seq;
+		long                  seqid;
+
+		if (addr->channel > IPMI_NUM_CHANNELS) {
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+			rv = -EINVAL;
+			goto out_err;
+		}
+
+		if ((intf->channels[addr->channel].medium
+		    != IPMI_CHANNEL_MEDIUM_8023LAN)
+		    && (intf->channels[addr->channel].medium
+			!= IPMI_CHANNEL_MEDIUM_ASYNC))
+		{
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+			rv = -EINVAL;
+			goto out_err;
+		}
+
+		retries = 4;
+
+		/* Default to 1 second retries. */
+		if (retry_time_ms == 0)
+		    retry_time_ms = 1000;
+
+		/* 11 for the header and 1 for the checksum. */
+		if ((msg->data_len + 12) > IPMI_MAX_MSG_LENGTH) {
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+			rv = -EMSGSIZE;
+			goto out_err;
+		}
+
+		lan_addr = (struct ipmi_lan_addr *) addr;
+		if (lan_addr->lun > 3) {
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_invalid_commands++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+			rv = -EINVAL;
+			goto out_err;
+		}
+
+		memcpy(&recv_msg->addr, lan_addr, sizeof(*lan_addr));
+
+		if (recv_msg->msg.netfn & 0x1) {
+			/* It's a response, so use the user's sequence
+                           from msgid. */
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			intf->sent_lan_responses++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+			format_lan_msg(smi_msg, msg, lan_addr, msgid,
+				       msgid, source_lun);
+
+			/* Save the receive message so we can use it
+			   to deliver the response. */
+			smi_msg->user_data = recv_msg;
+		} else {
+			/* It's a command, so get a sequence for it. */
+
+			spin_lock_irqsave(&(intf->seq_lock), flags);
+
+			spin_lock(&intf->counter_lock);
+			intf->sent_lan_commands++;
+			spin_unlock(&intf->counter_lock);
+
+			/* Create a sequence number with a 1 second
+                           timeout and 4 retries. */
+			rv = intf_next_seq(intf,
+					   recv_msg,
+					   retry_time_ms,
+					   retries,
+					   0,
+					   &ipmb_seq,
+					   &seqid);
+			if (rv) {
+				/* We have used up all the sequence numbers,
+				   probably, so abort. */
+				spin_unlock_irqrestore(&(intf->seq_lock),
+						       flags);
+				goto out_err;
+			}
+
+			/* Store the sequence number in the message,
+                           so that when the send message response
+                           comes back we can start the timer. */
+			format_lan_msg(smi_msg, msg, lan_addr,
+				       STORE_SEQ_IN_MSGID(ipmb_seq, seqid),
+				       ipmb_seq, source_lun);
+
+			/* Copy the message into the recv message data, so we
+			   can retransmit it later if necessary. */
+			memcpy(recv_msg->msg_data, smi_msg->data,
+			       smi_msg->data_size);
+			recv_msg->msg.data = recv_msg->msg_data;
+			recv_msg->msg.data_len = smi_msg->data_size;
+
+			/* We don't unlock until here, because we need
+                           to copy the completed message into the
+                           recv_msg before we release the lock.
+                           Otherwise, race conditions may bite us.  I
+                           know that's pretty paranoid, but I prefer
+                           to be correct. */
+			spin_unlock_irqrestore(&(intf->seq_lock), flags);
+		}
 	} else {
 	    /* Unknown address type. */
-	    rv = -EINVAL;
-	    goto out_err;
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->sent_invalid_commands++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
+		rv = -EINVAL;
+		goto out_err;
 	}
 
 #if DEBUG_MSGING
 	{
-	    int m;
-	    for (m=0; m<smi_msg->data_size; m++)
-		printk(" %2.2x", smi_msg->data[m]);
-	    printk("\n");
+		int m;
+		for (m=0; m<smi_msg->data_size; m++)
+			printk(" %2.2x", smi_msg->data[m]);
+		printk("\n");
 	}
 #endif
 	intf->handlers->sender(intf->send_info, smi_msg, priority);
@@ -975,6 +1354,7 @@
 		 struct ipmi_addr *addr,
 		 long             msgid,
 		 struct ipmi_msg  *msg,
+		 void             *user_msg_data,
 		 int              priority)
 {
 	return i_ipmi_request(user,
@@ -982,16 +1362,42 @@
 			      addr,
 			      msgid,
 			      msg,
+			      user_msg_data,
 			      NULL, NULL,
 			      priority,
 			      user->intf->my_address,
-			      user->intf->my_lun);
+			      user->intf->my_lun,
+			      -1, 0);
+}
+
+int ipmi_request_settime(ipmi_user_t      user,
+			 struct ipmi_addr *addr,
+			 long             msgid,
+			 struct ipmi_msg  *msg,
+			 void             *user_msg_data,
+			 int              priority,
+			 int              retries,
+			 unsigned int     retry_time_ms)
+{
+	return i_ipmi_request(user,
+			      user->intf,
+			      addr,
+			      msgid,
+			      msg,
+			      user_msg_data,
+			      NULL, NULL,
+			      priority,
+			      user->intf->my_address,
+			      user->intf->my_lun,
+			      retries,
+			      retry_time_ms);
 }
 
 int ipmi_request_supply_msgs(ipmi_user_t          user,
 			     struct ipmi_addr     *addr,
 			     long                 msgid,
 			     struct ipmi_msg      *msg,
+			     void                 *user_msg_data,
 			     void                 *supplied_smi,
 			     struct ipmi_recv_msg *supplied_recv,
 			     int                  priority)
@@ -1001,17 +1407,20 @@
 			      addr,
 			      msgid,
 			      msg,
+			      user_msg_data,
 			      supplied_smi,
 			      supplied_recv,
 			      priority,
 			      user->intf->my_address,
-			      user->intf->my_lun);
+			      user->intf->my_lun,
+			      -1, 0);
 }
 
 int ipmi_request_with_source(ipmi_user_t      user,
 			     struct ipmi_addr *addr,
 			     long             msgid,
 			     struct ipmi_msg  *msg,
+			     void             *user_msg_data,
 			     int              priority,
 			     unsigned char    source_address,
 			     unsigned char    source_lun)
@@ -1021,10 +1430,212 @@
 			      addr,
 			      msgid,
 			      msg,
+			      user_msg_data,
 			      NULL, NULL,
 			      priority,
 			      source_address,
-			      source_lun);
+			      source_lun,
+			      -1, 0);
+}
+
+static int ipmb_file_read_proc(char *page, char **start, off_t off,
+			       int count, int *eof, void *data)
+{
+	char       *out = (char *) page;
+	ipmi_smi_t intf = data;
+
+	return sprintf(out, "%x\n", intf->my_address);
+}
+
+static int version_file_read_proc(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	char       *out = (char *) page;
+	ipmi_smi_t intf = data;
+
+	return sprintf(out, "%d.%d\n",
+		       intf->version_major, intf->version_minor);
+}
+
+static int stat_file_read_proc(char *page, char **start, off_t off,
+			       int count, int *eof, void *data)
+{
+	char       *out = (char *) page;
+	ipmi_smi_t intf = data;
+
+	out += sprintf(out, "sent_invalid_commands:       %d\n",
+		       intf->sent_invalid_commands);
+	out += sprintf(out, "sent_local_commands:         %d\n",
+		       intf->sent_local_commands);
+	out += sprintf(out, "handled_local_responses:     %d\n",
+		       intf->handled_local_responses);
+	out += sprintf(out, "unhandled_local_responses:   %d\n",
+		       intf->unhandled_local_responses);
+	out += sprintf(out, "sent_ipmb_commands:          %d\n",
+		       intf->sent_ipmb_commands);
+	out += sprintf(out, "sent_ipmb_command_errs:      %d\n",
+		       intf->sent_ipmb_command_errs);
+	out += sprintf(out, "retransmitted_ipmb_commands: %d\n",
+		       intf->retransmitted_ipmb_commands);
+	out += sprintf(out, "timed_out_ipmb_commands:     %d\n",
+		       intf->timed_out_ipmb_commands);
+	out += sprintf(out, "timed_out_ipmb_broadcasts:   %d\n",
+		       intf->timed_out_ipmb_broadcasts);
+	out += sprintf(out, "sent_ipmb_responses:         %d\n",
+		       intf->sent_ipmb_responses);
+	out += sprintf(out, "handled_ipmb_responses:      %d\n",
+		       intf->handled_ipmb_responses);
+	out += sprintf(out, "invalid_ipmb_responses:      %d\n",
+		       intf->invalid_ipmb_responses);
+	out += sprintf(out, "unhandled_ipmb_responses:    %d\n",
+		       intf->unhandled_ipmb_responses);
+	out += sprintf(out, "sent_lan_commands:           %d\n",
+		       intf->sent_lan_commands);
+	out += sprintf(out, "sent_lan_command_errs:       %d\n",
+		       intf->sent_lan_command_errs);
+	out += sprintf(out, "retransmitted_lan_commands:  %d\n",
+		       intf->retransmitted_lan_commands);
+	out += sprintf(out, "timed_out_lan_commands:      %d\n",
+		       intf->timed_out_lan_commands);
+	out += sprintf(out, "sent_lan_responses:          %d\n",
+		       intf->sent_lan_responses);
+	out += sprintf(out, "handled_lan_responses:       %d\n",
+		       intf->handled_lan_responses);
+	out += sprintf(out, "invalid_lan_responses:       %d\n",
+		       intf->invalid_lan_responses);
+	out += sprintf(out, "unhandled_lan_responses:     %d\n",
+		       intf->unhandled_lan_responses);
+	out += sprintf(out, "handled_commands:            %d\n",
+		       intf->handled_commands);
+	out += sprintf(out, "invalid_commands:            %d\n",
+		       intf->invalid_commands);
+	out += sprintf(out, "unhandled_commands:          %d\n",
+		       intf->unhandled_commands);
+	out += sprintf(out, "invalid_events:              %d\n",
+		       intf->invalid_events);
+	out += sprintf(out, "events:                      %d\n",
+		       intf->events);
+
+	return (out - ((char *) page));
+}
+
+int ipmi_smi_add_proc_entry(ipmi_smi_t smi, char *name,
+			    read_proc_t *read_proc, write_proc_t *write_proc,
+			    void *data, struct module *owner)
+{
+	struct proc_dir_entry *file;
+	int                   rv = 0;
+
+	file = create_proc_entry(name, 0, smi->proc_dir);
+	if (!file)
+		rv = -ENOMEM;
+	else {
+		file->nlink = 1;
+		file->data = data;
+		file->read_proc = read_proc;
+		file->write_proc = write_proc;
+		file->owner = owner;
+	}
+
+	return rv;
+}
+
+static int add_proc_entries(ipmi_smi_t smi, int num)
+{
+	int rv = 0;
+
+	sprintf(smi->proc_dir_name, "%d", num);
+	smi->proc_dir = proc_mkdir(smi->proc_dir_name, proc_ipmi_root);
+	if (!smi->proc_dir)
+		rv = -ENOMEM;
+	else {
+		smi->proc_dir->owner = THIS_MODULE;
+	}
+
+	if (rv == 0)
+		rv = ipmi_smi_add_proc_entry(smi, "stats",
+					     stat_file_read_proc, NULL,
+					     smi, THIS_MODULE);
+
+	if (rv == 0)
+		rv = ipmi_smi_add_proc_entry(smi, "ipmb",
+					     ipmb_file_read_proc, NULL,
+					     smi, THIS_MODULE);
+
+	if (rv == 0)
+		rv = ipmi_smi_add_proc_entry(smi, "version",
+					     version_file_read_proc, NULL,
+					     smi, THIS_MODULE);
+
+	return rv;
+}
+
+static int
+send_channel_info_cmd(ipmi_smi_t intf, int chan)
+{
+	struct ipmi_msg                   msg;
+	unsigned char                     data[1];
+	struct ipmi_system_interface_addr si;
+
+	si.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	si.channel = IPMI_BMC_CHANNEL;
+	si.lun = 0;
+
+	msg.netfn = IPMI_NETFN_APP_REQUEST;
+	msg.cmd = IPMI_GET_CHANNEL_INFO_CMD;
+	msg.data = data;
+	msg.data_len = 1;
+	data[0] = chan;
+	return i_ipmi_request(NULL,
+			      intf,
+			      (struct ipmi_addr *) &si,
+			      0,
+			      &msg,
+			      NULL,
+			      NULL,
+			      NULL,
+			      0,
+			      intf->my_address,
+			      intf->my_lun,
+			      -1, 0);
+}
+
+static void
+channel_handler(ipmi_smi_t intf, struct ipmi_smi_msg *msg)
+{
+	int rv = 0;
+	int chan;
+
+	if ((msg->rsp[0] == (IPMI_NETFN_APP_RESPONSE << 2))
+	    && (msg->rsp[1] == IPMI_GET_CHANNEL_INFO_CMD))
+	{
+		/* It's the one we want */
+		if (msg->rsp[2] != 0) {
+			/* Got an error from the channel, just go on. */
+			goto next_channel;
+		}
+		if (msg->rsp_size < 6) {
+			/* Message not big enough, just go on. */
+			goto next_channel;
+		}
+		chan = intf->curr_channel;
+		intf->channels[chan].medium = msg->rsp[4] & 0x7f;
+		intf->channels[chan].protocol = msg->rsp[5] & 0x1f;
+
+	next_channel:
+		intf->curr_channel++;
+		if (intf->curr_channel >= IPMI_MAX_CHANNELS)
+			call_smi_watchers(intf->intf_num);
+		else
+			rv = send_channel_info_cmd(intf, intf->curr_channel);
+
+		if (rv) {
+			/* Got an error somehow, just give up. */
+			printk(KERN_WARNING "ipmi_msghandler: Error sending"
+			       "channel information: 0x%x\n",
+			       rv);
+		}
+	}
 }
 
 int ipmi_register_smi(struct ipmi_smi_handlers *handlers,
@@ -1036,7 +1647,6 @@
 	int              i, j;
 	int              rv;
 	ipmi_smi_t       new_intf;
-	struct list_head *entry;
 	unsigned long    flags;
 
 
@@ -1055,12 +1665,16 @@
 	new_intf = kmalloc(sizeof(*new_intf), GFP_KERNEL);
 	if (!new_intf)
 		return -ENOMEM;
+	memset(new_intf, 0, sizeof(*new_intf));
+
+	new_intf->proc_dir = NULL;
 
 	rv = -ENOMEM;
 
 	down_write(&interfaces_sem);
 	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
 		if (ipmi_interfaces[i] == NULL) {
+			new_intf->intf_num = i;
 			new_intf->version_major = version_major;
 			new_intf->version_minor = version_minor;
 			new_intf->my_address = IPMI_BMC_SLAVE_ADDR;
@@ -1084,6 +1698,8 @@
 			INIT_LIST_HEAD(&(new_intf->cmd_rcvrs));
 			new_intf->all_cmd_rcvr = NULL;
 
+			spin_lock_init(&(new_intf->counter_lock));
+
 			spin_lock_irqsave(&interfaces_lock, flags);
 			ipmi_interfaces[i] = new_intf;
 			spin_unlock_irqrestore(&interfaces_lock, flags);
@@ -1096,22 +1712,38 @@
 
 	downgrade_write(&interfaces_sem);
 
+	if (rv == 0)
+		rv = add_proc_entries(*intf, i);
+
 	if (rv == 0) {
-		/* Call all the watcher interfaces to tell them that a
-		   new interface is available. */
-		down_read(&smi_watchers_sem);
-		list_for_each(entry, &smi_watchers) {
-			struct ipmi_smi_watcher *w;
-			w = list_entry(entry, struct ipmi_smi_watcher, link);
-			w->new_smi(i);
-		}
-		up_read(&smi_watchers_sem);
+		if ((version_major > 1)
+		    || ((version_major == 1) && (version_minor >= 5)))
+		{
+			/* Start scanning the channels to see what is
+			   available. */
+			(*intf)->null_user_handler = channel_handler;
+			(*intf)->curr_channel = 0;
+			rv = send_channel_info_cmd(*intf, 0);
+		} else {
+			/* Assume a single IPMB channel at zero. */
+			(*intf)->channels[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
+			(*intf)->channels[0].protocol
+				= IPMI_CHANNEL_PROTOCOL_IPMB;
+
+			/* Call all the watcher interfaces to tell
+			   them that a new interface is available. */
+			call_smi_watchers(i);
+  		}
 	}
 
 	up_read(&interfaces_sem);
 
-	if (rv)
+	if (rv) {
+		if (new_intf->proc_dir)
+			remove_proc_entry(new_intf->proc_dir_name,
+					  proc_ipmi_root);
 		kfree(new_intf);
+	}
 
 	return rv;
 }
@@ -1169,6 +1801,8 @@
 	{
 		for (i=0; i<MAX_IPMI_INTERFACES; i++) {
 			if (ipmi_interfaces[i] == intf) {
+				remove_proc_entry(intf->proc_dir_name,
+						  proc_ipmi_root);
 				spin_lock_irqsave(&interfaces_lock, flags);
 				ipmi_interfaces[i] = NULL;
 				clean_up_interface_data(intf);
@@ -1203,20 +1837,28 @@
 	return 0;
 }
 
-static int handle_get_msg_rsp(ipmi_smi_t          intf,
-			      struct ipmi_smi_msg *msg)
+static int handle_ipmb_get_msg_rsp(ipmi_smi_t          intf,
+				   struct ipmi_smi_msg *msg)
 {
 	struct ipmi_ipmb_addr ipmb_addr;
 	struct ipmi_recv_msg  *recv_msg;
+	unsigned long         flags;
 
 	
-	if (msg->rsp_size < 11)
+	/* This is 11, not 10, because the response must contain a
+	 * completion code. */
+	if (msg->rsp_size < 11) {
 		/* Message not big enough, just ignore it. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->invalid_ipmb_responses++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
 		return 0;
+	}
 
-	if (msg->rsp[2] != 0)
+	if (msg->rsp[2] != 0) {
 		/* An error getting the response, just ignore it. */
 		return 0;
+	}
 
 	ipmb_addr.addr_type = IPMI_IPMB_ADDR_TYPE;
 	ipmb_addr.slave_addr = msg->rsp[6];
@@ -1235,6 +1877,9 @@
 	{
 		/* We were unable to find the sequence number,
 		   so just nuke the message. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->unhandled_ipmb_responses++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
 		return 0;
 	}
 
@@ -1248,26 +1893,34 @@
 	recv_msg->msg.data = recv_msg->msg_data;
 	recv_msg->msg.data_len = msg->rsp_size - 10;
 	recv_msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
+	spin_lock_irqsave(&intf->counter_lock, flags);
+	intf->handled_ipmb_responses++;
+	spin_unlock_irqrestore(&intf->counter_lock, flags);
 	deliver_response(recv_msg);
 
 	return 0;
 }
 
-static int handle_get_msg_cmd(ipmi_smi_t          intf,
-			      struct ipmi_smi_msg *msg)
+static int handle_ipmb_get_msg_cmd(ipmi_smi_t          intf,
+				   struct ipmi_smi_msg *msg)
 {
-	struct list_head *entry;
+	struct list_head      *entry;
 	struct cmd_rcvr       *rcvr;
-	int              rv = 0;
-	unsigned char    netfn;
-	unsigned char    cmd;
-	ipmi_user_t      user = NULL;
+	int                   rv = 0;
+	unsigned char         netfn;
+	unsigned char         cmd;
+	ipmi_user_t           user = NULL;
 	struct ipmi_ipmb_addr *ipmb_addr;
 	struct ipmi_recv_msg  *recv_msg;
+	unsigned long         flags;
 
-	if (msg->rsp_size < 10)
+	if (msg->rsp_size < 10) {
 		/* Message not big enough, just ignore it. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->invalid_commands++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
 		return 0;
+	}
 
 	if (msg->rsp[2] != 0) {
 		/* An error getting the response, just ignore it. */
@@ -1295,6 +1948,10 @@
 
 	if (user == NULL) {
 		/* We didn't find a user, deliver an error response. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->unhandled_commands++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
+
 		msg->data[0] = (IPMI_NETFN_APP_REQUEST << 2);
 		msg->data[1] = IPMI_SEND_MSG_CMD;
 		msg->data[2] = msg->rsp[3];
@@ -1309,12 +1966,25 @@
 		msg->data[10] = ipmb_checksum(&(msg->data[6]), 4);
 		msg->data_size = 11;
 
+#if DEBUG_MSGING
+	{
+		int m;
+		printk("Invalid command:");
+		for (m=0; m<msg->data_size; m++)
+			printk(" %2.2x", msg->data[m]);
+		printk("\n");
+	}
+#endif
 		intf->handlers->sender(intf->send_info, msg, 0);
 
 		rv = -1; /* We used the message, so return the value that
 			    causes it to not be freed or queued. */
 	} else {
 		/* Deliver the message to the user. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->handled_commands++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
+
 		recv_msg = ipmi_alloc_recv_msg();
 		if (! recv_msg) {
 			/* We couldn't allocate memory for the
@@ -1322,18 +1992,24 @@
                            later. */
 			rv = 1;
 		} else {
+			/* Extract the source address from the data. */
 			ipmb_addr = (struct ipmi_ipmb_addr *) &recv_msg->addr;
 			ipmb_addr->addr_type = IPMI_IPMB_ADDR_TYPE;
 			ipmb_addr->slave_addr = msg->rsp[6];
 			ipmb_addr->lun = msg->rsp[7] & 3;
-			ipmb_addr->channel = msg->rsp[3];
+			ipmb_addr->channel = msg->rsp[3] & 0xf;
 
+			/* Extract the rest of the message information
+			   from the IPMB header.*/
 			recv_msg->user = user;
 			recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
 			recv_msg->msgid = msg->rsp[7] >> 2;
 			recv_msg->msg.netfn = msg->rsp[4] >> 2;
 			recv_msg->msg.cmd = msg->rsp[8];
 			recv_msg->msg.data = recv_msg->msg_data;
+
+			/* We chop off 10, not 9 bytes because the checksum
+			   at the end also needs to be removed. */
 			recv_msg->msg.data_len = msg->rsp_size - 10;
 			memcpy(recv_msg->msg_data,
 			       &(msg->rsp[9]),
@@ -1345,6 +2021,171 @@
 	return rv;
 }
 
+static int handle_lan_get_msg_rsp(ipmi_smi_t          intf,
+				  struct ipmi_smi_msg *msg)
+{
+	struct ipmi_lan_addr  lan_addr;
+	struct ipmi_recv_msg  *recv_msg;
+	unsigned long         flags;
+
+
+	/* This is 13, not 12, because the response must contain a
+	 * completion code. */
+	if (msg->rsp_size < 13) {
+		/* Message not big enough, just ignore it. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->invalid_lan_responses++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
+		return 0;
+	}
+
+	if (msg->rsp[2] != 0) {
+		/* An error getting the response, just ignore it. */
+		return 0;
+	}
+
+	lan_addr.addr_type = IPMI_LAN_ADDR_TYPE;
+	lan_addr.session_handle = msg->rsp[4];
+	lan_addr.remote_SWID = msg->rsp[8];
+	lan_addr.local_SWID = msg->rsp[5];
+	lan_addr.channel = msg->rsp[3] & 0x0f;
+	lan_addr.privilege = msg->rsp[3] >> 4;
+	lan_addr.lun = msg->rsp[9] & 3;
+
+	/* It's a response from a remote entity.  Look up the sequence
+	   number and handle the response. */
+	if (intf_find_seq(intf,
+			  msg->rsp[9] >> 2,
+			  msg->rsp[3] & 0x0f,
+			  msg->rsp[10],
+			  (msg->rsp[6] >> 2) & (~1),
+			  (struct ipmi_addr *) &(lan_addr),
+			  &recv_msg))
+	{
+		/* We were unable to find the sequence number,
+		   so just nuke the message. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->unhandled_lan_responses++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
+		return 0;
+	}
+
+	memcpy(recv_msg->msg_data,
+	       &(msg->rsp[11]),
+	       msg->rsp_size - 11);
+	/* The other fields matched, so no need to set them, except
+           for netfn, which needs to be the response that was
+           returned, not the request value. */
+	recv_msg->msg.netfn = msg->rsp[6] >> 2;
+	recv_msg->msg.data = recv_msg->msg_data;
+	recv_msg->msg.data_len = msg->rsp_size - 12;
+	recv_msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
+	spin_lock_irqsave(&intf->counter_lock, flags);
+	intf->handled_lan_responses++;
+	spin_unlock_irqrestore(&intf->counter_lock, flags);
+	deliver_response(recv_msg);
+
+	return 0;
+}
+
+static int handle_lan_get_msg_cmd(ipmi_smi_t          intf,
+				  struct ipmi_smi_msg *msg)
+{
+	struct list_head      *entry;
+	struct cmd_rcvr       *rcvr;
+	int                   rv = 0;
+	unsigned char         netfn;
+	unsigned char         cmd;
+	ipmi_user_t           user = NULL;
+	struct ipmi_lan_addr  *lan_addr;
+	struct ipmi_recv_msg  *recv_msg;
+	unsigned long         flags;
+
+	if (msg->rsp_size < 12) {
+		/* Message not big enough, just ignore it. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->invalid_commands++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
+		return 0;
+	}
+
+	if (msg->rsp[2] != 0) {
+		/* An error getting the response, just ignore it. */
+		return 0;
+	}
+
+	netfn = msg->rsp[6] >> 2;
+	cmd = msg->rsp[10];
+
+	read_lock(&(intf->cmd_rcvr_lock));
+	
+	if (intf->all_cmd_rcvr) {
+		user = intf->all_cmd_rcvr;
+	} else {
+		/* Find the command/netfn. */
+		list_for_each(entry, &(intf->cmd_rcvrs)) {
+			rcvr = list_entry(entry, struct cmd_rcvr, link);
+			if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)) {
+				user = rcvr->user;
+				break;
+			}
+		}
+	}
+	read_unlock(&(intf->cmd_rcvr_lock));
+
+	if (user == NULL) {
+		/* We didn't find a user, deliver an error response. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->unhandled_commands++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
+
+		rv = 0; /* Don't do anything with these messages, just
+			   allow them to be freed. */
+	} else {
+		/* Deliver the message to the user. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->handled_commands++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
+
+		recv_msg = ipmi_alloc_recv_msg();
+		if (! recv_msg) {
+			/* We couldn't allocate memory for the
+                           message, so requeue it for handling
+                           later. */
+			rv = 1;
+		} else {
+			/* Extract the source address from the data. */
+			lan_addr = (struct ipmi_lan_addr *) &recv_msg->addr;
+			lan_addr->addr_type = IPMI_LAN_ADDR_TYPE;
+			lan_addr->session_handle = msg->rsp[4];
+			lan_addr->remote_SWID = msg->rsp[8];
+			lan_addr->local_SWID = msg->rsp[5];
+			lan_addr->lun = msg->rsp[9] & 3;
+			lan_addr->channel = msg->rsp[3] & 0xf;
+			lan_addr->privilege = msg->rsp[3] >> 4;
+
+			/* Extract the rest of the message information
+			   from the IPMB header.*/
+			recv_msg->user = user;
+			recv_msg->recv_type = IPMI_CMD_RECV_TYPE;
+			recv_msg->msgid = msg->rsp[9] >> 2;
+			recv_msg->msg.netfn = msg->rsp[6] >> 2;
+			recv_msg->msg.cmd = msg->rsp[10];
+			recv_msg->msg.data = recv_msg->msg_data;
+
+			/* We chop off 12, not 11 bytes because the checksum
+			   at the end also needs to be removed. */
+			recv_msg->msg.data_len = msg->rsp_size - 12;
+			memcpy(recv_msg->msg_data,
+			       &(msg->rsp[11]),
+			       msg->rsp_size - 12);
+			deliver_response(recv_msg);
+		}
+	}
+
+	return rv;
+}
+
 static void copy_event_into_recv_msg(struct ipmi_recv_msg *recv_msg,
 				     struct ipmi_smi_msg  *msg)
 {
@@ -1378,6 +2219,9 @@
 
 	if (msg->rsp_size < 19) {
 		/* Message is too small to be an IPMB event. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->invalid_events++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
 		return 0;
 	}
 
@@ -1390,6 +2234,10 @@
 
 	spin_lock_irqsave(&(intf->events_lock), flags);
 
+	spin_lock(&intf->counter_lock);
+	intf->events++;
+	spin_unlock(&intf->counter_lock);
+
 	/* Allocate and fill in one message for every user that is getting
 	   events. */
 	list_for_each(entry, &(intf->users)) {
@@ -1463,6 +2311,7 @@
 	struct ipmi_recv_msg *recv_msg;
 	int                  found = 0;
 	struct list_head     *entry;
+	unsigned long        flags;
 
 	recv_msg = (struct ipmi_recv_msg *) msg->user_data;
 
@@ -1482,10 +2331,16 @@
 		if (!recv_msg->user && intf->null_user_handler)
 			intf->null_user_handler(intf, msg);
 		/* The user for the message went away, so give up. */
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->unhandled_local_responses++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
 		ipmi_free_recv_msg(recv_msg);
 	} else {
 		struct ipmi_system_interface_addr *smi_addr;
 
+		spin_lock_irqsave(&intf->counter_lock, flags);
+		intf->handled_local_responses++;
+		spin_unlock_irqrestore(&intf->counter_lock, flags);
 		recv_msg->recv_type = IPMI_RESPONSE_RECV_TYPE;
 		recv_msg->msgid = msg->msgid;
 		smi_addr = ((struct ipmi_system_interface_addr *)
@@ -1513,28 +2368,86 @@
 			       struct ipmi_smi_msg *msg)
 {
 	int requeue;
+	int chan;
 
+#if DEBUG_MSGING
+	int m;
+	printk("Recv:");
+	for (m=0; m<msg->rsp_size; m++)
+		printk(" %2.2x", msg->rsp[m]);
+	printk("\n");
+#endif
 	if (msg->rsp_size < 2) {
 		/* Message is too small to be correct. */
 		requeue = 0;
-	} else if (msg->rsp[1] == IPMI_GET_MSG_CMD) {
-#if DEBUG_MSGING
-		int m;
-		printk("Response:");
-		for (m=0; m<msg->rsp_size; m++)
-			printk(" %2.2x", msg->rsp[m]);
-		printk("\n");
-#endif
+	} else if ((msg->rsp[0] == ((IPMI_NETFN_APP_REQUEST|1) << 2))
+		   && (msg->rsp[1] == IPMI_SEND_MSG_CMD)
+		   && (msg->user_data != NULL))
+	{
+		/* It's a response to a response we sent.  For this we
+		   deliver a send message response to the user. */
+		struct ipmi_recv_msg *recv_msg = msg->user_data;
+
+		requeue = 0;
+		if (msg->rsp_size < 2)
+			/* Message is too small to be correct. */
+			goto out;
+
+		chan = msg->data[2] & 0x0f;
+		if (chan >= IPMI_MAX_CHANNELS)
+			/* Invalid channel number */
+			goto out;
+
+		if (recv_msg) {
+			recv_msg->recv_type = IPMI_RESPONSE_RESPONSE_TYPE;
+			recv_msg->msg.data = recv_msg->msg_data;
+			recv_msg->msg.data_len = 1;
+			recv_msg->msg_data[0] = msg->rsp[2];
+			deliver_response(recv_msg);
+		}
+	} else if ((msg->rsp[0] == ((IPMI_NETFN_APP_REQUEST|1) << 2))
+		   && (msg->rsp[1] == IPMI_GET_MSG_CMD))
+	{
 		/* It's from the receive queue. */
-		if (msg->rsp[4] & 0x04) {
-			/* It's a response, so find the
-			   requesting message and send it up. */
-			requeue = handle_get_msg_rsp(intf, msg);
-		} else {
-			/* It's a command to the SMS from some other
-			   entity.  Handle that. */
-			requeue = handle_get_msg_cmd(intf, msg);
+		chan = msg->rsp[3] & 0xf;
+		if (chan >= IPMI_MAX_CHANNELS) {
+			/* Invalid channel number */
+			requeue = 0;
+			goto out;
 		}
+
+		switch (intf->channels[chan].medium) {
+		case IPMI_CHANNEL_MEDIUM_IPMB:
+			if (msg->rsp[4] & 0x04) {
+				/* It's a response, so find the
+				   requesting message and send it up. */
+				requeue = handle_ipmb_get_msg_rsp(intf, msg);
+			} else {
+				/* It's a command to the SMS from some other
+				   entity.  Handle that. */
+				requeue = handle_ipmb_get_msg_cmd(intf, msg);
+			}
+			break;
+
+		case IPMI_CHANNEL_MEDIUM_8023LAN:
+		case IPMI_CHANNEL_MEDIUM_ASYNC:
+			if (msg->rsp[6] & 0x04) {
+				/* It's a response, so find the
+				   requesting message and send it up. */
+				requeue = handle_lan_get_msg_rsp(intf, msg);
+			} else {
+				/* It's a command to the SMS from some other
+				   entity.  Handle that. */
+				requeue = handle_lan_get_msg_cmd(intf, msg);
+			}
+			break;
+
+		default:
+			/* We don't handle the channel type, so just
+			 * free the message. */
+			requeue = 0;
+		}
+
 	} else if (msg->rsp[1] == IPMI_READ_EVENT_MSG_BUFFER_CMD) {
 		/* It's an asyncronous event. */
 		requeue = handle_read_event_rsp(intf, msg);
@@ -1543,6 +2456,7 @@
 		requeue = handle_bmc_rsp(intf, msg);
 	}
 
+ out:
 	return requeue;
 }
 
@@ -1558,10 +2472,43 @@
 	   working on it. */
 	read_lock(&(intf->users_lock));
 
-	if ((msg->data_size >= 2) && (msg->data[1] == IPMI_SEND_MSG_CMD)) {
-		/* This is the local response to a send, start the
-                   timer for these. */
-		intf_start_seq_timer(intf, msg->msgid);
+	if ((msg->data_size >= 2)
+	    && (msg->data[0] == (IPMI_NETFN_APP_REQUEST << 2))
+	    && (msg->data[1] == IPMI_SEND_MSG_CMD)
+	    && (msg->user_data == NULL)) {
+		/* This is the local response to a command send, start
+                   the timer for these.  The user_data will not be
+                   NULL if this is a response send, and we will let
+                   response sends just go through. */
+
+		/* Check for errors, if we get certain errors (ones
+                   that mean basically we can try again later), we
+                   ignore them and start the timer.  Otherwise we
+                   report the error immediately. */
+		if ((msg->rsp_size >= 3) && (msg->rsp[2] != 0)
+		    && (msg->rsp[2] != IPMI_NODE_BUSY_ERR)
+		    && (msg->rsp[2] != IPMI_LOST_ARBITRATION_ERR))
+		{
+			int chan = msg->rsp[3] & 0xf;
+
+			/* Got an error sending the message, handle it. */
+			spin_lock_irqsave(&intf->counter_lock, flags);
+			if (chan >= IPMI_MAX_CHANNELS)
+				; /* This shouldn't happen */
+			else if ((intf->channels[chan].medium
+				  == IPMI_CHANNEL_MEDIUM_8023LAN)
+				 || (intf->channels[chan].medium
+				     == IPMI_CHANNEL_MEDIUM_ASYNC))
+				intf->sent_lan_command_errs++;
+			else
+				intf->sent_ipmb_command_errs++;
+			spin_unlock_irqrestore(&intf->counter_lock, flags);
+			intf_err_seq(intf, msg->msgid, msg->rsp[2]);
+		} else {
+			/* The message was sent, start the timer. */
+			intf_start_seq_timer(intf, msg->msgid);
+		}
+
 		ipmi_free_smi_msg(msg);
 		goto out_unlock;
 	}
@@ -1706,6 +2653,15 @@
 				ent->inuse = 0;
 				msg = ent->recv_msg;
 				list_add_tail(&(msg->link), &timeouts);
+				spin_lock(&intf->counter_lock);
+				if (ent->broadcast)
+					intf->timed_out_ipmb_broadcasts++;
+				else if (ent->recv_msg->addr.addr_type
+					 == IPMI_LAN_ADDR_TYPE)
+					intf->timed_out_lan_commands++;
+				else
+					intf->timed_out_ipmb_commands++;
+				spin_unlock(&intf->counter_lock);
 			} else {
 				/* More retries, send again. */
 
@@ -1715,6 +2671,13 @@
 				ent->retries_left--;
 				send_from_recv_msg(intf, ent->recv_msg, NULL,
 						   j, ent->seqid);
+				spin_lock(&intf->counter_lock);
+				if (ent->recv_msg->addr.addr_type
+				    == IPMI_LAN_ADDR_TYPE)
+					intf->retransmitted_lan_commands++;
+				else
+					intf->retransmitted_ipmb_commands++;
+				spin_unlock(&intf->counter_lock);
 			}
 		}
 		spin_unlock_irqrestore(&(intf->seq_lock), flags);
@@ -1747,13 +2710,16 @@
 
 static struct timer_list ipmi_timer;
 
-/* Call every 100 ms. */
+/* Call every ~100 ms. */
 #define IPMI_TIMEOUT_TIME	100
-#define IPMI_TIMEOUT_JIFFIES	((IPMI_TIMEOUT_TIME * HZ)/1000)
 
-/* Request events from the queue every second.  Hopefully, in the
-   future, IPMI will add a way to know immediately if an event is
-   in the queue. */
+/* How many jiffies does it take to get to the timeout time. */
+#define IPMI_TIMEOUT_JIFFIES	((IPMI_TIMEOUT_TIME * HZ) / 1000)
+
+/* Request events from the queue every second (this is the number of
+   IPMI_TIMEOUT_TIMES between event requests).  Hopefully, in the
+   future, IPMI will add a way to know immediately if an event is in
+   the queue and this silliness can go away. */
 #define IPMI_REQUEST_EV_TIME	(1000 / (IPMI_TIMEOUT_TIME))
 
 static volatile int stop_operation = 0;
@@ -1796,6 +2762,7 @@
 	rv = kmalloc(sizeof(struct ipmi_smi_msg), GFP_ATOMIC);
 	if (rv) {
 		rv->done = free_smi_msg;
+		rv->user_data = NULL;
 		atomic_inc(&smi_msg_inuse_count);
 	}
 	return rv;
@@ -1883,7 +2850,7 @@
 	data[4] = 0x6f; /* Sensor specific, IPMI table 36-1 */
 	data[5] = 0xa1; /* Runtime stop OEM bytes 2 & 3. */
 
-	/* Put a few breadcrumbs in.  Hopefully later we can add more things
+	/* Put a few breadcrums in.  Hopefully later we can add more things
 	   to make the panic events more useful. */
 	if (str) {
 		data[3] = str[0];
@@ -1907,11 +2874,13 @@
 			       &addr,
 			       0,
 			       &msg,
+			       NULL,
 			       &smi_msg,
 			       &recv_msg,
 			       0,
 			       intf->my_address,
-			       intf->my_lun);
+			       intf->my_lun,
+			       0, 1); /* Don't retry, and don't wait. */
 	}
 
 #ifdef CONFIG_IPMI_PANIC_STRING
@@ -1951,11 +2920,13 @@
 			       &addr,
 			       0,
 			       &msg,
+			       NULL,
 			       &smi_msg,
 			       &recv_msg,
 			       0,
 			       intf->my_address,
-			       intf->my_lun);
+			       intf->my_lun,
+			       0, 1); /* Don't retry, and don't wait. */
 
 		if (intf->local_event_generator) {
 			/* Request the event receiver from the local MC. */
@@ -1969,11 +2940,13 @@
 				       &addr,
 				       0,
 				       &msg,
+				       NULL,
 				       &smi_msg,
 				       &recv_msg,
 				       0,
 				       intf->my_address,
-				       intf->my_lun);
+				       intf->my_lun,
+				       0, 1); /* no retry, and no wait. */
 		}
 		intf->null_user_handler = NULL;
 
@@ -2029,11 +3002,13 @@
 				       &addr,
 				       0,
 				       &msg,
+				       NULL,
 				       &smi_msg,
 				       &recv_msg,
 				       0,
 				       intf->my_address,
-				       intf->my_lun);
+				       intf->my_lun,
+				       0, 1); /* no retry, and no wait. */
 		}
 	}	
 #endif /* CONFIG_IPMI_PANIC_STRING */
@@ -2075,7 +3050,6 @@
 	200   /* priority: INT_MAX >= x >= 0 */
 };
 
-
 static __init int ipmi_init_msghandler(void)
 {
 	int i;
@@ -2083,10 +3057,21 @@
 	if (initialized)
 		return 0;
 
+	printk(KERN_INFO "ipmi message handler version "
+	       IPMI_MSGHANDLER_VERSION "\n");
+
 	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
 		ipmi_interfaces[i] = NULL;
 	}
 
+	proc_ipmi_root = proc_mkdir("ipmi", 0);
+	if (!proc_ipmi_root) {
+	    printk("Unable to create IPMI proc dir");
+	    return -ENOMEM;
+	}
+
+	proc_ipmi_root->owner = THIS_MODULE;
+
 	init_timer(&ipmi_timer);
 	ipmi_timer.data = 0;
 	ipmi_timer.function = ipmi_timeout;
@@ -2097,8 +3082,6 @@
 
 	initialized = 1;
 
-	printk(KERN_INFO "ipmi: message handler initialized\n");
-
 	return 0;
 }
 
@@ -2118,9 +3101,12 @@
 	   problems with race conditions removing the timer here. */
 	stop_operation = 1;
 	while (!timer_stopped) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
 	}
 
+	remove_proc_entry(proc_ipmi_root->name, &proc_root);
+
 	initialized = 0;
 
 	/* Check for buffer leaks. */
@@ -2143,6 +3129,7 @@
 EXPORT_SYMBOL(ipmi_destroy_user);
 EXPORT_SYMBOL(ipmi_get_version);
 EXPORT_SYMBOL(ipmi_request);
+EXPORT_SYMBOL(ipmi_request_settime);
 EXPORT_SYMBOL(ipmi_request_supply_msgs);
 EXPORT_SYMBOL(ipmi_request_with_source);
 EXPORT_SYMBOL(ipmi_register_smi);
@@ -2164,3 +3151,4 @@
 EXPORT_SYMBOL(ipmi_get_my_address);
 EXPORT_SYMBOL(ipmi_set_my_LUN);
 EXPORT_SYMBOL(ipmi_get_my_LUN);
+EXPORT_SYMBOL(ipmi_smi_add_proc_entry);
diff -urN linux.orig/drivers/char/ipmi/ipmi_si_sm.h linux-a1/drivers/char/ipmi/ipmi_si_sm.h
--- linux.orig/drivers/char/ipmi/ipmi_si_sm.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-a1/drivers/char/ipmi/ipmi_si_sm.h	2004-02-23 08:19:36.000000000 -0600
@@ -0,0 +1,112 @@
+/*
+ * ipmi_si_sm.h
+ *
+ * State machine interface for low-level IPMI system management
+ * interface state machines.  This code is the interface between
+ * the ipmi_smi code (that handles the policy of a KCS, SMIC, or
+ * BT interface) and the actual low-level state machine.
+ *
+ * Author: MontaVista Software, Inc.
+ *         Corey Minyard <minyard@mvista.com>
+ *         source@mvista.com
+ *
+ * Copyright 2002 MontaVista Software Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or (at your
+ *  option) any later version.
+ *
+ *
+ *  THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
+ *  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
+ *  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
+ *  OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ *  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
+ *  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
+ *  USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/* This is defined by the state machines themselves, it is an opaque
+   data type for them to use. */
+struct si_sm_data;
+
+/* The structure for doing I/O in the state machine.  The state
+   machine doesn't have the actual I/O routines, they are done through
+   this interface. */
+struct si_sm_io
+{
+	unsigned char (*inputb)(struct si_sm_io *io, unsigned int offset);
+	void (*outputb)(struct si_sm_io *io,
+			unsigned int  offset,
+			unsigned char b);
+
+	/* Generic info used by the actual handling routines, the
+           state machine shouldn't touch these. */
+	void *info;
+	void *addr;
+};
+
+/* Results of SMI events. */
+enum si_sm_result
+{
+	SI_SM_CALL_WITHOUT_DELAY, /* Call the driver again immediately */
+	SI_SM_CALL_WITH_DELAY,	/* Delay some before calling again. */
+	SI_SM_TRANSACTION_COMPLETE, /* A transaction is finished. */
+	SI_SM_IDLE,		/* The SM is in idle state. */
+	SI_SM_HOSED,		/* The hardware violated the state machine. */
+	SI_SM_ATTN		/* The hardware is asserting attn and the
+				   state machine is idle. */
+};
+
+/* Handlers for the SMI state machine. */
+struct si_sm_handlers
+{
+	/* Put the version number of the state machine here so the
+           upper layer can print it. */
+	char *version;
+
+	/* Initialize the data and return the amount of I/O space to
+           reserve for the space. */
+	unsigned int (*init_data)(struct si_sm_data *smi,
+				  struct si_sm_io   *io);
+
+	/* Start a new transaction in the state machine.  This will
+	   return -2 if the state machine is not idle, -1 if the size
+	   is invalid (to large or too small), or 0 if the transaction
+	   is successfully completed. */
+	int (*start_transaction)(struct si_sm_data *smi,
+				 unsigned char *data, unsigned int size);
+
+	/* Return the results after the transaction.  This will return
+	   -1 if the buffer is too small, zero if no transaction is
+	   present, or the actual length of the result data. */
+	int (*get_result)(struct si_sm_data *smi,
+			  unsigned char *data, unsigned int length);
+
+	/* Call this periodically (for a polled interface) or upon
+	   receiving an interrupt (for a interrupt-driven interface).
+	   If interrupt driven, you should probably poll this
+	   periodically when not in idle state.  This should be called
+	   with the time that passed since the last call, if it is
+	   significant.  Time is in microseconds. */
+	enum si_sm_result (*event)(struct si_sm_data *smi, long time);
+
+	/* Attempt to detect an SMI.  Returns 0 on success or nonzero
+           on failure. */
+	int (*detect)(struct si_sm_data *smi);
+
+	/* The interface is shutting down, so clean it up. */
+	void (*cleanup)(struct si_sm_data *smi);
+
+	/* Return the size of the SMI structure in bytes. */
+	int (*size)(void);
+};
+

--------------070203080802000606080309--

