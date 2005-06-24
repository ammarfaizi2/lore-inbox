Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVFXD2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVFXD2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVFXD2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:28:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14721 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263021AbVFXD0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:26:33 -0400
Date: Thu, 23 Jun 2005 23:26:32 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: gcc4 compile fix for recent ia64 xpc changes.
Message-ID: <20050624032632.GA26322@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc4 doesn't like volatile casts as lvalues. Make the structure
members volatile instead.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/arch/ia64/sn/kernel/xpc.h~	2005-06-22 15:10:37.000000000 -0400
+++ linux-2.6.12/arch/ia64/sn/kernel/xpc.h	2005-06-22 15:14:19.000000000 -0400
@@ -138,7 +138,7 @@ struct xpc_vars {
  * occupies half a cacheline.
  */
 struct xpc_vars_part {
-	u64 magic;
+	volatile u64 magic;
 
 	u64 openclose_args_pa;	/* physical address of open and close args */
 	u64 GPs_pa;		/* physical address of Get/Put values */
@@ -185,8 +185,8 @@ struct xpc_vars_part {
  * Define a Get/Put value pair (pointers) used with a message queue.
  */
 struct xpc_gp {
-	s64 get;	/* Get value */
-	s64 put;	/* Put value */
+	volatile s64 get;	/* Get value */
+	volatile s64 put;	/* Put value */
 };
 
 #define XPC_GP_SIZE \
@@ -231,7 +231,7 @@ struct xpc_openclose_args {
  */
 struct xpc_notify {
 	struct semaphore sema;		/* notify semaphore */
-	u8 type;			/* type of notification */
+	volatile u8 type;			/* type of notification */
 
 	/* the following two fields are only used if type == XPC_N_CALL */
 	xpc_notify_func func;		/* user's notify function */
@@ -439,7 +439,7 @@ struct xpc_partition {
 
 	/* XPC infrastructure referencing and teardown control */
 
-	u8 setup_state;			/* infrastructure setup state */
+	volatile u8 setup_state;			/* infrastructure setup state */
 	wait_queue_head_t teardown_wq;	/* kthread waiting to teardown infra */
 	atomic_t references;		/* #of references to infrastructure */
 
--- 1/arch/ia64/sn/kernel/xpc_channel.c	2005-06-17 15:48:29.000000000 -0400
+++ 2/arch/ia64/sn/kernel/xpc_channel.c	2005-06-22 15:14:17.000000000 -0400
@@ -209,7 +209,7 @@ xpc_setup_infrastructure(struct xpc_part
 	 * With the setting of the partition setup_state to XPC_P_SETUP, we're
 	 * declaring that this partition is ready to go.
 	 */
-	(volatile u8) part->setup_state = XPC_P_SETUP;
+	part->setup_state = XPC_P_SETUP;
 
 
 	/*
@@ -227,7 +227,7 @@ xpc_setup_infrastructure(struct xpc_part
 	xpc_vars_part[partid].IPI_phys_cpuid =
 					cpu_physical_id(smp_processor_id());
 	xpc_vars_part[partid].nchannels = part->nchannels;
-	(volatile u64) xpc_vars_part[partid].magic = XPC_VP_MAGIC1;
+	xpc_vars_part[partid].magic = XPC_VP_MAGIC1;
 
 	return xpcSuccess;
 }
@@ -355,7 +355,7 @@ xpc_pull_remote_vars_part(struct xpc_par
 
 		/* let the other side know that we've pulled their variables */
 
-		(volatile u64) xpc_vars_part[partid].magic = XPC_VP_MAGIC2;
+		xpc_vars_part[partid].magic = XPC_VP_MAGIC2;
 	}
 
 	if (pulled_entry->magic == XPC_VP_MAGIC1) {
@@ -1183,7 +1183,7 @@ xpc_process_msg_IPI(struct xpc_partition
 		 */
 		xpc_clear_local_msgqueue_flags(ch);
 
-		(volatile s64) ch->w_remote_GP.get = ch->remote_GP.get;
+		ch->w_remote_GP.get = ch->remote_GP.get;
 
 		dev_dbg(xpc_chan, "w_remote_GP.get changed to %ld, partid=%d, "
 			"channel=%d\n", ch->w_remote_GP.get, ch->partid,
@@ -1211,7 +1211,7 @@ xpc_process_msg_IPI(struct xpc_partition
 		 */
 		xpc_clear_remote_msgqueue_flags(ch);
 
-		(volatile s64) ch->w_remote_GP.put = ch->remote_GP.put;
+		ch->w_remote_GP.put = ch->remote_GP.put;
 
 		dev_dbg(xpc_chan, "w_remote_GP.put changed to %ld, partid=%d, "
 			"channel=%d\n", ch->w_remote_GP.put, ch->partid,
@@ -1875,7 +1875,7 @@ xpc_send_msg(struct xpc_channel *ch, str
 		notify = &ch->notify_queue[msg_number % ch->local_nentries];
 		notify->func = func;
 		notify->key = key;
-		(volatile u8) notify->type = notify_type;
+		notify->type = notify_type;
 
 		// >>> is a mb() needed here?
 
--- linux-2.6.12/arch/ia64/sn/kernel/xpc.h~	2005-06-22 16:30:55.000000000 -0400
+++ linux-2.6.12/arch/ia64/sn/kernel/xpc.h	2005-06-22 16:31:04.000000000 -0400
@@ -87,7 +87,7 @@ struct xpc_rsvd_page {
 	u8 partid;		/* partition ID from SAL */
 	u8 version;
 	u8 pad[6];		/* pad to u64 align */
-	u64 vars_pa;
+	volatile u64 vars_pa;
 	u64 part_nasids[XP_NASID_MASK_WORDS] ____cacheline_aligned;
 	u64 mach_nasids[XP_NASID_MASK_WORDS] ____cacheline_aligned;
 };
--- linux-2.6.12/arch/ia64/sn/kernel/xpc_partition.c~	2005-06-22 16:31:06.000000000 -0400
+++ linux-2.6.12/arch/ia64/sn/kernel/xpc_partition.c	2005-06-22 16:31:10.000000000 -0400
@@ -253,7 +253,7 @@ xpc_rsvd_page_init(void)
 	 * This signifies to the remote partition that our reserved
 	 * page is initialized.
 	 */
-	(volatile u64) rp->vars_pa = __pa(xpc_vars);
+	rp->vars_pa = __pa(xpc_vars);
 
 	return rp;
 }
