Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752483AbWJ1O1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbWJ1O1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbWJ1O1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 10:27:04 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:15570 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1752483AbWJ1O1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 10:27:01 -0400
Subject: [PATCH] lockdep: annotate DECLARE_WAIT_QUEUE_HEAD
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: marcel@holtmann.org,
       "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       Greg KH <gregkh@suse.de>, Markus Lidel <markus.lidel@shadowconnect.com>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 16:27:39 +0200
Message-Id: <1162045659.24143.149.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel: INFO: trying to register non-static key.
kernel: the code is fine but needs lockdep annotation.
kernel: turning off the locking correctness validator.
kernel:  [<c04051ed>] show_trace_log_lvl+0x58/0x16a
kernel:  [<c04057fa>] show_trace+0xd/0x10
kernel:  [<c0405913>] dump_stack+0x19/0x1b
kernel:  [<c043b1e2>] __lock_acquire+0xf0/0x90d
kernel:  [<c043bf70>] lock_acquire+0x4b/0x6b
kernel:  [<c061472f>] _spin_lock_irqsave+0x22/0x32
kernel:  [<c04363d3>] prepare_to_wait+0x17/0x4b
kernel:  [<f89a24b6>] lpfc_do_work+0xdd/0xcc2 [lpfc]
kernel:  [<c04361b9>] kthread+0xc3/0xf2
kernel:  [<c0402005>] kernel_thread_helper+0x5/0xb

Another case of non-static lockdep keys; duplicate the paradigm set by
DECLARE_COMPLETION_ONSTACK and introduce DECLARE_WAIT_QUEUE_HEAD_ONSTACK.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/bluetooth/bluecard_cs.c  |    2 +-
 drivers/message/i2o/exec-osm.c   |    2 +-
 drivers/scsi/dpt/dpti_i2o.h      |    2 +-
 drivers/scsi/imm.c               |    2 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c |    2 +-
 drivers/scsi/lpfc/lpfc_sli.c     |    4 ++--
 drivers/scsi/ppa.c               |    2 +-
 drivers/usb/net/usbnet.c         |    2 +-
 include/linux/wait.h             |    9 +++++++++
 9 files changed, 18 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/bluetooth/bluecard_cs.c
===================================================================
--- linux-2.6.orig/drivers/bluetooth/bluecard_cs.c
+++ linux-2.6/drivers/bluetooth/bluecard_cs.c
@@ -282,7 +282,7 @@ static void bluecard_write_wakeup(blueca
 		clear_bit(ready_bit, &(info->tx_state));
 
 		if (bt_cb(skb)->pkt_type & 0x80) {
-			DECLARE_WAIT_QUEUE_HEAD(wq);
+			DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 			DEFINE_WAIT(wait);
 
 			unsigned char baud_reg;
Index: linux-2.6/drivers/message/i2o/exec-osm.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/exec-osm.c
+++ linux-2.6/drivers/message/i2o/exec-osm.c
@@ -124,7 +124,7 @@ static void i2o_exec_wait_free(struct i2
 int i2o_msg_post_wait_mem(struct i2o_controller *c, struct i2o_message *msg,
 			  unsigned long timeout, struct i2o_dma *dma)
 {
-	DECLARE_WAIT_QUEUE_HEAD(wq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct i2o_exec_wait *wait;
 	static u32 tcntxt = 0x80000000;
 	unsigned long flags;
Index: linux-2.6/drivers/scsi/dpt/dpti_i2o.h
===================================================================
--- linux-2.6.orig/drivers/scsi/dpt/dpti_i2o.h
+++ linux-2.6/drivers/scsi/dpt/dpti_i2o.h
@@ -49,7 +49,7 @@
 
 #include <linux/wait.h>
 typedef wait_queue_head_t adpt_wait_queue_head_t;
-#define ADPT_DECLARE_WAIT_QUEUE_HEAD(wait) DECLARE_WAIT_QUEUE_HEAD(wait)
+#define ADPT_DECLARE_WAIT_QUEUE_HEAD(wait) DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wait)
 typedef wait_queue_t adpt_wait_queue_t;
 
 /*
Index: linux-2.6/drivers/scsi/imm.c
===================================================================
--- linux-2.6.orig/drivers/scsi/imm.c
+++ linux-2.6/drivers/scsi/imm.c
@@ -1153,7 +1153,7 @@ static int __imm_attach(struct parport *
 {
 	struct Scsi_Host *host;
 	imm_struct *dev;
-	DECLARE_WAIT_QUEUE_HEAD(waiting);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(waiting);
 	DEFINE_WAIT(wait);
 	int ports;
 	int modes, ppb;
Index: linux-2.6/drivers/scsi/lpfc/lpfc_hbadisc.c
===================================================================
--- linux-2.6.orig/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ linux-2.6/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -305,7 +305,7 @@ lpfc_do_work(void *p)
 {
 	struct lpfc_hba *phba = p;
 	int rc;
-	DECLARE_WAIT_QUEUE_HEAD(work_waitq);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(work_waitq);
 
 	set_user_nice(current, -20);
 	phba->work_wait = &work_waitq;
Index: linux-2.6/drivers/scsi/lpfc/lpfc_sli.c
===================================================================
--- linux-2.6.orig/drivers/scsi/lpfc/lpfc_sli.c
+++ linux-2.6/drivers/scsi/lpfc/lpfc_sli.c
@@ -2983,7 +2983,7 @@ lpfc_sli_issue_iocb_wait(struct lpfc_hba
 			 struct lpfc_iocbq * prspiocbq,
 			 uint32_t timeout)
 {
-	DECLARE_WAIT_QUEUE_HEAD(done_q);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(done_q);
 	long timeleft, timeout_req = 0;
 	int retval = IOCB_SUCCESS;
 	uint32_t creg_val;
@@ -3061,7 +3061,7 @@ int
 lpfc_sli_issue_mbox_wait(struct lpfc_hba * phba, LPFC_MBOXQ_t * pmboxq,
 			 uint32_t timeout)
 {
-	DECLARE_WAIT_QUEUE_HEAD(done_q);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(done_q);
 	DECLARE_WAITQUEUE(wq_entry, current);
 	uint32_t timeleft = 0;
 	int retval;
Index: linux-2.6/drivers/scsi/ppa.c
===================================================================
--- linux-2.6.orig/drivers/scsi/ppa.c
+++ linux-2.6/drivers/scsi/ppa.c
@@ -1012,7 +1012,7 @@ static LIST_HEAD(ppa_hosts);
 static int __ppa_attach(struct parport *pb)
 {
 	struct Scsi_Host *host;
-	DECLARE_WAIT_QUEUE_HEAD(waiting);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(waiting);
 	DEFINE_WAIT(wait);
 	ppa_struct *dev;
 	int ports;
Index: linux-2.6/drivers/usb/net/usbnet.c
===================================================================
--- linux-2.6.orig/drivers/usb/net/usbnet.c
+++ linux-2.6/drivers/usb/net/usbnet.c
@@ -554,7 +554,7 @@ static int usbnet_stop (struct net_devic
 {
 	struct usbnet		*dev = netdev_priv(net);
 	int			temp;
-	DECLARE_WAIT_QUEUE_HEAD (unlink_wakeup); 
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK (unlink_wakeup);
 	DECLARE_WAITQUEUE (wait, current);
 
 	netif_stop_queue (net);
Index: linux-2.6/include/linux/wait.h
===================================================================
--- linux-2.6.orig/include/linux/wait.h
+++ linux-2.6/include/linux/wait.h
@@ -79,6 +79,15 @@ struct task_struct;
 
 extern void init_waitqueue_head(wait_queue_head_t *q);
 
+#ifdef CONFIG_LOCKDEP
+# define __WAIT_QUEUE_HEAD_INIT_ONSTACK(name) \
+	({ init_waitqueue_head(&name); name; })
+# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) \
+	wait_queue_head_t name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
+#else
+# define DECLARE_WAIT_QUEUE_HEAD_ONSTACK(name) DECLARE_WAIT_QUEUE_HEAD(name)
+#endif
+
 static inline void init_waitqueue_entry(wait_queue_t *q, struct task_struct *p)
 {
 	q->flags = 0;


