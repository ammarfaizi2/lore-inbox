Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbUL1Imv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUL1Imv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 03:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUL1Imv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 03:42:51 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:5031 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261775AbUL1Iaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 03:30:35 -0500
Date: Tue, 28 Dec 2004 09:28:59 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] s390: SCLP device driver cleanup
Message-ID: <20041228082859.GI7988@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 8/8] s390: sclp driver.

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

sclp: core driver cleanup

Details:
- moved signal shutdown (quiesce) handling into a separate file
- cleanup of SCLP core driver:
  . introduced driver states instead of bits
  . introduced request retry count and retry limit
  . sclp_add_request now returns an error code if a request couldn't be started
  . introduced separate request structure for init_mask requests to simplify
    code
  . request timer is now manually checked in sclp_sync_wait because timer
    interrupts are disabled in this context
  . removed busy timer - request timer now handles both cases
  . split up sclp_start_request into __sclp_start_request and sclp_process
    queue
  . removed sclp_error_message (unused)
  . introduced sclp_check_handler function to split up initial init mask
    test from standard init mask request processing
  . introduced sclp_deactivate and sclp_reactivate for simplified reboot
    event handling (and potential use in suspend/resume scenario)
  . added protection against multiple concurrent init mask calls
- minor changes in SCLP core driver:
  . updated comments
  . renamed functions to be consistent with "function name starts with __ =>
    needs lock"
  . renamed internal functions for consistency reasons
  . introduced inlined helper functions to simplify code
  . moved EXPORT_SYMBOL definitions next to function definition
- changes in sclp console driver
  . removed callback recursion to prevent stack overflow
- changes to CPI module
  . added check for sclp_add_request return code
  . changed printks to specify a message level
- changes to generic sclp tty layer
  . removed timed buffer retry after error (timers may not work in some
    situations)
  . introduced return code for sclp_emit_buffer
- changes to sclp tty driver
  . removed callback recursion
- changes to sclp vt220 driver
  . removed callback recursion
  . removed timed buffer retry after error
- modified sclp_init_mask to prevent problems with some compiler versions

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 drivers/s390/char/Makefile       |    2 
 drivers/s390/char/sclp.c         | 1266 ++++++++++++++++++++-------------------
 drivers/s390/char/sclp.h         |    6 
 drivers/s390/char/sclp_con.c     |   39 -
 drivers/s390/char/sclp_cpi.c     |   19 
 drivers/s390/char/sclp_quiesce.c |  114 +++
 drivers/s390/char/sclp_rw.c      |   62 -
 drivers/s390/char/sclp_rw.h      |    4 
 drivers/s390/char/sclp_tty.c     |   40 -
 drivers/s390/char/sclp_vt220.c   |   94 +-
 10 files changed, 896 insertions(+), 750 deletions(-)

diff -urN linux-2.6/drivers/s390/char/Makefile linux-2.6-patched/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	2004-12-28 08:50:53.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/Makefile	2004-12-28 08:50:53.000000000 +0100
@@ -11,7 +11,7 @@
 
 obj-$(CONFIG_TN3215) += con3215.o
 
-obj-$(CONFIG_SCLP) += sclp.o sclp_rw.o
+obj-$(CONFIG_SCLP) += sclp.o sclp_rw.o sclp_quiesce.o
 obj-$(CONFIG_SCLP_TTY) += sclp_tty.o
 obj-$(CONFIG_SCLP_CONSOLE) += sclp_con.o
 obj-$(CONFIG_SCLP_VT220_TTY) += sclp_vt220.o
diff -urN linux-2.6/drivers/s390/char/sclp.c linux-2.6-patched/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	2004-12-24 22:35:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp.c	2004-12-28 08:50:53.000000000 +0100
@@ -8,82 +8,99 @@
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
-#include <linux/kmod.h>
-#include <linux/bootmem.h>
 #include <linux/err.h>
-#include <linux/ptrace.h>
-#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
-#include <linux/init.h>
-#include <linux/cpumask.h>
 #include <linux/reboot.h>
+#include <linux/jiffies.h>
+#include <asm/types.h>
 #include <asm/s390_ext.h>
-#include <asm/processor.h>
 
 #include "sclp.h"
 
-#define SCLP_CORE_PRINT_HEADER "sclp low level driver: "
+#define SCLP_HEADER		"sclp: "
 
 /* Structure for register_early_external_interrupt. */
 static ext_int_info_t ext_int_info_hwc;
 
-/* spinlock to protect global variables of sclp_core */
-static spinlock_t sclp_lock;
+/* Lock to protect internal data consistency. */
+static spinlock_t sclp_lock = SPIN_LOCK_UNLOCKED;
 
-/* Mask of valid sclp events */
+/* Mask of events that we can receive from the sclp interface. */
 static sccb_mask_t sclp_receive_mask;
+
+/* Mask of events that we can send to the sclp interface. */
 static sccb_mask_t sclp_send_mask;
 
-/* List of registered event types */
+/* List of registered event listeners and senders. */
 static struct list_head sclp_reg_list;
 
-/* sccb queue */
+/* List of queued requests. */
 static struct list_head sclp_req_queue;
 
-/* sccb for unconditional read */
+/* Data for read and and init requests. */
 static struct sclp_req sclp_read_req;
+static struct sclp_req sclp_init_req;
 static char sclp_read_sccb[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
-/* sccb for write mask sccb */
 static char sclp_init_sccb[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
-/* Timer for init mask retries. */
-static struct timer_list retry_timer;
-
-/* Timer for busy retries. */
-static struct timer_list sclp_busy_timer;
+/* Timer for request retries. */
+static struct timer_list sclp_request_timer;
 
-static volatile unsigned long sclp_status = 0;
-/* some status flags */
-#define SCLP_INIT		0
-#define SCLP_RUNNING		1
-#define SCLP_READING		2
-#define SCLP_SHUTDOWN		3
-
-#define SCLP_INIT_POLL_INTERVAL	1
-#define SCLP_BUSY_POLL_INTERVAL	1
-
-#define SCLP_COMMAND_INITIATED	0
-#define SCLP_BUSY		2
-#define SCLP_NOT_OPERATIONAL	3
+/* Internal state: is the driver initialized? */
+static volatile enum sclp_init_state_t {
+	sclp_init_state_uninitialized,
+	sclp_init_state_initializing,
+	sclp_init_state_initialized
+} sclp_init_state = sclp_init_state_uninitialized;
+
+/* Internal state: is a request active at the sclp? */
+static volatile enum sclp_running_state_t {
+	sclp_running_state_idle,
+	sclp_running_state_running
+} sclp_running_state = sclp_running_state_idle;
+
+/* Internal state: is a read request pending? */
+static volatile enum sclp_reading_state_t {
+	sclp_reading_state_idle,
+	sclp_reading_state_reading
+} sclp_reading_state = sclp_reading_state_idle;
+
+/* Internal state: is the driver currently serving requests? */
+static volatile enum sclp_activation_state_t {
+	sclp_activation_state_active,
+	sclp_activation_state_deactivating,
+	sclp_activation_state_inactive,
+	sclp_activation_state_activating
+} sclp_activation_state = sclp_activation_state_active;
+
+/* Internal state: is an init mask request pending? */
+static volatile enum sclp_mask_state_t {
+	sclp_mask_state_idle,
+	sclp_mask_state_initializing
+} sclp_mask_state = sclp_mask_state_idle;
+
+/* Maximum retry counts */
+#define SCLP_INIT_RETRY		3
+#define SCLP_MASK_RETRY		3
+#define SCLP_REQUEST_RETRY	3
+
+/* Timeout intervals in seconds.*/
+#define SCLP_BUSY_INTERVAL	2
+#define SCLP_RETRY_INTERVAL	5
+
+static void sclp_process_queue(void);
+static int sclp_init_mask(int calculate);
+static int sclp_init(void);
 
-/*
- * assembler instruction for Service Call
- */
+/* Perform service call. Return 0 on success, non-zero otherwise. */
 static int
-__service_call(sclp_cmdw_t command, void *sccb)
+service_call(sclp_cmdw_t command, void *sccb)
 {
 	int cc;
 
-	/*
-	 *  Mnemonic:	SERVC	Rx, Ry	[RRE]
-	 *
-	 *  Rx: SCLP command word
-	 *  Ry: address of SCCB
-	 */
 	__asm__ __volatile__(
 		"   .insn rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
 		"   ipm	  %0\n"
@@ -91,61 +108,94 @@
 		: "=&d" (cc)
 		: "d" (command), "a" (__pa(sccb))
 		: "cc", "memory" );
-	/*
-	 * cc == 0:   Service Call succesful initiated
-	 * cc == 2:   SCLP busy, new Service Call not initiated,
-	 *	      new SCCB unchanged
-	 * cc == 3:   SCLP function not operational
-	 */
-	if (cc == SCLP_NOT_OPERATIONAL)
+	if (cc == 3)
 		return -EIO;
-	if (cc == SCLP_BUSY)
+	if (cc == 2)
 		return -EBUSY;
 	return 0;
 }
 
+/* Request timeout handler. Restart the request queue. If DATA is non-zero,
+ * force restart of running request. */
 static void
-sclp_start_request(void)
+sclp_request_timeout(unsigned long data)
+{
+	unsigned long flags;
+
+	if (data) {
+		spin_lock_irqsave(&sclp_lock, flags);
+		sclp_running_state = sclp_running_state_idle;
+		spin_unlock_irqrestore(&sclp_lock, flags);
+	}
+	sclp_process_queue();
+}
+
+/* Set up request retry timer. Called while sclp_lock is locked. */
+static inline void
+__sclp_set_request_timer(unsigned long time, void (*function)(unsigned long),
+			 unsigned long data)
+{
+	del_timer(&sclp_request_timer);
+	sclp_request_timer.function = function;
+	sclp_request_timer.data = data;
+	sclp_request_timer.expires = jiffies + time;
+	add_timer(&sclp_request_timer);
+}
+
+/* Try to start a request. Return zero if the request was successfully
+ * started or if it will be started at a later time. Return non-zero otherwise.
+ * Called while sclp_lock is locked. */
+static int
+__sclp_start_request(struct sclp_req *req)
+{
+	int rc;
+
+	if (sclp_running_state != sclp_running_state_idle)
+		return 0;
+	del_timer(&sclp_request_timer);
+	if (req->start_count <= SCLP_REQUEST_RETRY) {
+		rc = service_call(req->command, req->sccb);
+		req->start_count++;
+	} else
+		rc = -EIO;
+	if (rc == 0) {
+		/* Sucessfully started request */
+		req->status = SCLP_REQ_RUNNING;
+		sclp_running_state = sclp_running_state_running;
+		__sclp_set_request_timer(SCLP_RETRY_INTERVAL * HZ,
+					 sclp_request_timeout, 1);
+		return 0;
+	} else if (rc == -EBUSY) {
+		/* Try again later */
+		__sclp_set_request_timer(SCLP_BUSY_INTERVAL * HZ,
+					 sclp_request_timeout, 0);
+		return 0;
+	}
+	/* Request failed */
+	req->status = SCLP_REQ_FAILED;
+	return rc;
+}
+
+/* Try to start queued requests. */
+static void
+sclp_process_queue(void)
 {
 	struct sclp_req *req;
 	int rc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sclp_lock, flags);
-	/* quick exit if sclp is already in use */
-	if (test_bit(SCLP_RUNNING, &sclp_status)) {
+	if (sclp_running_state != sclp_running_state_idle) {
 		spin_unlock_irqrestore(&sclp_lock, flags);
 		return;
 	}
-	/* Try to start requests from the request queue. */
+	del_timer(&sclp_request_timer);
 	while (!list_empty(&sclp_req_queue)) {
 		req = list_entry(sclp_req_queue.next, struct sclp_req, list);
-		rc = __service_call(req->command, req->sccb);
-		if (rc == 0) {
-			/* Sucessfully started request. */
-			req->status = SCLP_REQ_RUNNING;
-			/* Request active. Set running indication. */
-			set_bit(SCLP_RUNNING, &sclp_status);
+		rc = __sclp_start_request(req);
+		if (rc == 0)
 			break;
-		}
-		if (rc == -EBUSY) {
-			/**
-			 * SCLP is busy but no request is running.
-			 * Try again later.
-			 */
-			if (!timer_pending(&sclp_busy_timer) ||
-			    !mod_timer(&sclp_busy_timer,
-				       jiffies + SCLP_BUSY_POLL_INTERVAL*HZ)) {
-				sclp_busy_timer.function =
-					(void *) sclp_start_request;
-				sclp_busy_timer.expires =
-					jiffies + SCLP_BUSY_POLL_INTERVAL*HZ;
-				add_timer(&sclp_busy_timer);
-			}
-			break;
-		}
 		/* Request failed. */
-		req->status = SCLP_REQ_FAILED;
 		list_del(&req->list);
 		if (req->callback) {
 			spin_unlock_irqrestore(&sclp_lock, flags);
@@ -156,265 +206,258 @@
 	spin_unlock_irqrestore(&sclp_lock, flags);
 }
 
+/* Queue a new request. Return zero on success, non-zero otherwise. */
+int
+sclp_add_request(struct sclp_req *req)
+{
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&sclp_lock, flags);
+	if ((sclp_init_state != sclp_init_state_initialized ||
+	     sclp_activation_state != sclp_activation_state_active) &&
+	    req != &sclp_init_req) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return -EIO;
+	}
+	req->status = SCLP_REQ_QUEUED;
+	req->start_count = 0;
+	list_add_tail(&req->list, &sclp_req_queue);
+	rc = 0;
+	/* Start if request is first in list */
+	if (req->list.prev == &sclp_req_queue) {
+		rc = __sclp_start_request(req);
+		if (rc)
+			list_del(&req->list);
+	}
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	return rc;
+}
+
+EXPORT_SYMBOL(sclp_add_request);
+
+/* Dispatch events found in request buffer to registered listeners. Return 0
+ * if all events were dispatched, non-zero otherwise. */
 static int
-sclp_process_evbufs(struct sccb_header *sccb)
+sclp_dispatch_evbufs(struct sccb_header *sccb)
 {
-	int result;
 	unsigned long flags;
 	struct evbuf_header *evbuf;
 	struct list_head *l;
-	struct sclp_register *t;
+	struct sclp_register *reg;
+	int offset;
+	int rc;
 
 	spin_lock_irqsave(&sclp_lock, flags);
-	evbuf = (struct evbuf_header *) (sccb + 1);
-	result = 0;
-	while ((addr_t) evbuf < (addr_t) sccb + sccb->length) {
-		/* check registered event */
-		t = NULL;
+	rc = 0;
+	for (offset = sizeof(struct sccb_header); offset < sccb->length;
+	     offset += evbuf->length) {
+		/* Search for event handler */
+		evbuf = (struct evbuf_header *) ((addr_t) sccb + offset);
+		reg = NULL;
 		list_for_each(l, &sclp_reg_list) {
-			t = list_entry(l, struct sclp_register, list);
-			if (t->receive_mask & (1 << (32 - evbuf->type))) {
-				if (t->receiver_fn != NULL) {
-					spin_unlock_irqrestore(&sclp_lock,
-							       flags);
-					t->receiver_fn(evbuf);
-					spin_lock_irqsave(&sclp_lock, flags);
-				}
+			reg = list_entry(l, struct sclp_register, list);
+			if (reg->receive_mask & (1 << (32 - evbuf->type)))
 				break;
-			}
 			else
-				t = NULL;
+				reg = NULL;
 		}
-		/* Check for unrequested event buffer */
-		if (t == NULL)
-			result = -ENOSYS;
-		evbuf = (struct evbuf_header *)
-				((addr_t) evbuf + evbuf->length);
+		if (reg && reg->receiver_fn) {
+			spin_unlock_irqrestore(&sclp_lock, flags);
+			reg->receiver_fn(evbuf);
+			spin_lock_irqsave(&sclp_lock, flags);
+		} else if (reg == NULL)
+			rc = -ENOSYS;
 	}
 	spin_unlock_irqrestore(&sclp_lock, flags);
-	return result;
-}
-
-char *
-sclp_error_message(u16 rc)
-{
-	static struct {
-		u16 code; char *msg;
-	} sclp_errors[] = {
-		{ 0x0000, "No response code stored (machine malfunction)" },
-		{ 0x0020, "Normal Completion" },
-		{ 0x0040, "SCLP equipment check" },
-		{ 0x0100, "SCCB boundary violation" },
-		{ 0x01f0, "Invalid command" },
-		{ 0x0220, "Normal Completion; suppressed buffers pending" },
-		{ 0x0300, "Insufficient SCCB length" },
-		{ 0x0340, "Contained SCLP equipment check" },
-		{ 0x05f0, "Target resource in improper state" },
-		{ 0x40f0, "Invalid function code/not installed" },
-		{ 0x60f0, "No buffers stored" },
-		{ 0x62f0, "No buffers stored; suppressed buffers pending" },
-		{ 0x70f0, "Invalid selection mask" },
-		{ 0x71f0, "Event buffer exceeds available space" },
-		{ 0x72f0, "Inconsistent lengths" },
-		{ 0x73f0, "Event buffer syntax error" }
-	};
-	int i;
-	for (i = 0; i < sizeof(sclp_errors)/sizeof(sclp_errors[0]); i++)
-		if (rc == sclp_errors[i].code)
-			return sclp_errors[i].msg;
-	return "Invalid response code";
+	return rc;
 }
 
-/*
- * postprocessing of unconditional read service call
- */
+/* Read event data request callback. */
 static void
-sclp_unconditional_read_cb(struct sclp_req *read_req, void *data)
+sclp_read_cb(struct sclp_req *req, void *data)
 {
+	unsigned long flags;
 	struct sccb_header *sccb;
 
-	sccb = read_req->sccb;
-	if (sccb->response_code == 0x0020 ||
-	    sccb->response_code == 0x0220) {
-		if (sclp_process_evbufs(sccb) != 0)
-			printk(KERN_WARNING SCLP_CORE_PRINT_HEADER
-			       "unconditional read: "
-			       "unrequested event buffer received.\n");
-	}
-
-	if (sccb->response_code != 0x0020)
-		printk(KERN_WARNING SCLP_CORE_PRINT_HEADER
-		       "unconditional read: %s (response code=0x%x).\n",
-		       sclp_error_message(sccb->response_code),
-		       sccb->response_code);
-
-	clear_bit(SCLP_READING, &sclp_status);
+	sccb = (struct sccb_header *) req->sccb;
+	if (req->status == SCLP_REQ_DONE && (sccb->response_code == 0x20 ||
+	    sccb->response_code == 0x220))
+		sclp_dispatch_evbufs(sccb);
+	spin_lock_irqsave(&sclp_lock, flags);
+	sclp_reading_state = sclp_reading_state_idle;
+	spin_unlock_irqrestore(&sclp_lock, flags);
 }
 
-/*
- * Function to queue Read Event Data/Unconditional Read
- */
-static void
-__sclp_unconditional_read(void)
+/* Prepare read event data request. Called while sclp_lock is locked. */
+static inline void
+__sclp_make_read_req(void)
 {
 	struct sccb_header *sccb;
-	struct sclp_req *read_req;
 
-	/*
-	 * Don't try to initiate Unconditional Read if we are not able to
-	 * receive anything
-	 */
-	if (sclp_receive_mask == 0)
-		return;
-	/* Don't try reading if a read is already outstanding */
-	if (test_and_set_bit(SCLP_READING, &sclp_status))
-		return;
-	/* Initialize read sccb */
 	sccb = (struct sccb_header *) sclp_read_sccb;
 	clear_page(sccb);
+	memset(&sclp_read_req, 0, sizeof(struct sclp_req));
+	sclp_read_req.command = SCLP_CMDW_READDATA;
+	sclp_read_req.status = SCLP_REQ_QUEUED;
+	sclp_read_req.start_count = 0;
+	sclp_read_req.callback = sclp_read_cb;
+	sclp_read_req.sccb = sccb;
 	sccb->length = PAGE_SIZE;
-	sccb->function_code = 0;	/* unconditional read */
-	sccb->control_mask[2] = 0x80;	/* variable length response */
-	/* Initialize request structure */
-	read_req = &sclp_read_req;
-	read_req->command = SCLP_CMDW_READDATA;
-	read_req->status = SCLP_REQ_QUEUED;
-	read_req->callback = sclp_unconditional_read_cb;
-	read_req->sccb = sccb;
-	/* Add read request to the head of queue */
-	list_add(&read_req->list, &sclp_req_queue);
-}
-
-/* Bit masks to interpret external interruption parameter contents. */
-#define EXT_INT_SCCB_MASK		0xfffffff8
-#define EXT_INT_STATECHANGE_PENDING	0x00000002
-#define EXT_INT_EVBUF_PENDING		0x00000001
+	sccb->function_code = 0;
+	sccb->control_mask[2] = 0x80;
+}
 
-/*
- * Handler for service-signal external interruptions
- */
+/* Search request list for request with matching sccb. Return request if found,
+ * NULL otherwise. Called while sclp_lock is locked. */
+static inline struct sclp_req *
+__sclp_find_req(u32 sccb)
+{
+	struct list_head *l;
+	struct sclp_req *req;
+
+	list_for_each(l, &sclp_req_queue) {
+		req = list_entry(l, struct sclp_req, list);
+		if (sccb == (u32) (addr_t) req->sccb)
+				return req;
+	}
+	return NULL;
+}
+
+/* Handler for external interruption. Perform request post-processing.
+ * Prepare read event data request if necessary. Start processing of next
+ * request on queue. */
 static void
 sclp_interrupt_handler(struct pt_regs *regs, __u16 code)
 {
-	u32 ext_int_param, finished_sccb, evbuf_pending;
-	struct list_head *l;
-	struct sclp_req *req, *tmp;
+	struct sclp_req *req;
+	u32 finished_sccb;
+	u32 evbuf_pending;
 
 	spin_lock(&sclp_lock);
-	/*
-	 * Only process interrupt if sclp is initialized.
-	 * This avoids strange effects for a pending request
-	 * from before the last re-ipl.
-	 */
-	if (!test_bit(SCLP_INIT, &sclp_status)) {
-		/* Now clear the running bit */
-		clear_bit(SCLP_RUNNING, &sclp_status);
-		spin_unlock(&sclp_lock);
-		return;
-	}
-	ext_int_param = S390_lowcore.ext_params;
-	finished_sccb = ext_int_param & EXT_INT_SCCB_MASK;
-	evbuf_pending = ext_int_param & (EXT_INT_EVBUF_PENDING |
-					 EXT_INT_STATECHANGE_PENDING);
-	req = NULL;
-	if (finished_sccb != 0U) {
-		list_for_each(l, &sclp_req_queue) {
-			tmp = list_entry(l, struct sclp_req, list);
-			if (finished_sccb == (u32)(addr_t) tmp->sccb) {
-				list_del(&tmp->list);
-				req = tmp;
-				break;
+	finished_sccb = S390_lowcore.ext_params & 0xfffffff8;
+	evbuf_pending = S390_lowcore.ext_params & 0x3;
+	if (finished_sccb) {
+		req = __sclp_find_req(finished_sccb);
+		if (req) {
+			/* Request post-processing */
+			list_del(&req->list);
+			req->status = SCLP_REQ_DONE;
+			if (req->callback) {
+				spin_unlock(&sclp_lock);
+				req->callback(req, req->callback_data);
+				spin_lock(&sclp_lock);
 			}
 		}
+		sclp_running_state = sclp_running_state_idle;
 	}
-	spin_unlock(&sclp_lock);
-	/* Perform callback */
-	if (req != NULL) {
-		req->status = SCLP_REQ_DONE;
-		if (req->callback != NULL)
-			req->callback(req, req->callback_data);
+	if (evbuf_pending && sclp_receive_mask != 0 &&
+	    sclp_reading_state == sclp_reading_state_idle &&
+	    sclp_activation_state == sclp_activation_state_active ) {
+		sclp_reading_state = sclp_reading_state_reading;
+		__sclp_make_read_req();
+		/* Add request to head of queue */
+		list_add(&sclp_read_req.list, &sclp_req_queue);
 	}
-	spin_lock(&sclp_lock);
-	/* Head queue a read sccb if an event buffer is pending */
-	if (evbuf_pending)
-		__sclp_unconditional_read();
-	/* Now clear the running bit if SCLP indicated a finished SCCB */
-	if (finished_sccb != 0U)
-		clear_bit(SCLP_RUNNING, &sclp_status);
 	spin_unlock(&sclp_lock);
-	/* and start next request on the queue */
-	sclp_start_request();
+	sclp_process_queue();
 }
 
-/*
- * Wait synchronously for external interrupt of sclp. We may not receive
- * any other external interrupt, so we disable all other external interrupts
- * in control register 0.
- */
+/* Return current Time-Of-Day clock. */
+static inline u64
+sclp_get_clock(void)
+{
+	u64 result;
+
+	asm volatile ("STCK 0(%1)" : "=m" (result) : "a" (&(result)) : "cc");
+	return result;
+}
+
+/* Convert interval in jiffies to TOD ticks. */
+static inline u64
+sclp_tod_from_jiffies(unsigned long jiffies)
+{
+	return (u64) (jiffies / HZ) << 32;
+}
+
+/* Wait until a currently running request finished. Note: while this function
+ * is running, no timers are served on the calling CPU. */
 void
 sclp_sync_wait(void)
 {
 	unsigned long psw_mask;
 	unsigned long cr0, cr0_sync;
+	u64 timeout;
 
-	/* Prevent BH from executing. */
+	/* We'll be disabling timer interrupts, so we need a custom timeout
+	 * mechanism */
+	timeout = 0;
+	if (timer_pending(&sclp_request_timer)) {
+		/* Get timeout TOD value */
+		timeout = sclp_get_clock() +
+			  sclp_tod_from_jiffies(sclp_request_timer.expires -
+						jiffies);
+	}
+	/* Prevent bottom half from executing once we force interrupts open */
 	local_bh_disable();
-	/*
-	 * save cr0
-	 * enable service signal external interruption (cr0.22)
-	 * disable cr0.20-21, cr0.25, cr0.27, cr0.30-31
-	 * don't touch any other bit in cr0
-	 */
+	/* Enable service-signal interruption, disable timer interrupts */
 	__ctl_store(cr0, 0, 0);
 	cr0_sync = cr0;
 	cr0_sync |= 0x00000200;
 	cr0_sync &= 0xFFFFF3AC;
 	__ctl_load(cr0_sync, 0, 0);
-
-	/* enable external interruptions (PSW-mask.7) */
 	asm volatile ("STOSM 0(%1),0x01"
 		      : "=m" (psw_mask) : "a" (&psw_mask) : "memory");
-
-	/* wait until ISR signals receipt of interrupt */
-	while (test_bit(SCLP_RUNNING, &sclp_status)) {
+	/* Loop until driver state indicates finished request */
+	while (sclp_running_state != sclp_running_state_idle) {
+		/* Check for expired request timer */
+		if (timer_pending(&sclp_request_timer) &&
+		    sclp_get_clock() > timeout &&
+		    del_timer(&sclp_request_timer))
+			sclp_request_timer.function(sclp_request_timer.data);
 		barrier();
 		cpu_relax();
 	}
-
-	/* disable external interruptions */
+	/* Restore interrupt settings */
 	asm volatile ("SSM 0(%0)"
 		      : : "a" (&psw_mask) : "memory");
-
-	/* restore cr0 */
 	__ctl_load(cr0, 0, 0);
 	__local_bh_enable();
 }
 
-/*
- * Queue an SCLP request. Request will immediately be processed if queue is
- * empty.
- */
-void
-sclp_add_request(struct sclp_req *req)
+EXPORT_SYMBOL(sclp_sync_wait);
+
+/* Dispatch changes in send and receive mask to registered listeners. */
+static inline void
+sclp_dispatch_state_change(void)
 {
+	struct list_head *l;
+	struct sclp_register *reg;
 	unsigned long flags;
+	sccb_mask_t receive_mask;
+	sccb_mask_t send_mask;
 
-	if (!test_bit(SCLP_INIT, &sclp_status)) {
-		req->status = SCLP_REQ_FAILED;
-		if (req->callback != NULL)
-			req->callback(req, req->callback_data);
-		return;
-	}
-	spin_lock_irqsave(&sclp_lock, flags);
-	/* queue the request */
-	req->status = SCLP_REQ_QUEUED;
-	list_add_tail(&req->list, &sclp_req_queue);
-	spin_unlock_irqrestore(&sclp_lock, flags);
-	/* try to start the first request on the queue */
-	sclp_start_request();
+	do {
+		spin_lock_irqsave(&sclp_lock, flags);
+		reg = NULL;
+		list_for_each(l, &sclp_reg_list) {
+			reg = list_entry(l, struct sclp_register, list);
+			receive_mask = reg->receive_mask & sclp_receive_mask;
+			send_mask = reg->send_mask & sclp_send_mask;
+			if (reg->sclp_receive_mask != receive_mask ||
+			    reg->sclp_send_mask != send_mask) {
+				reg->sclp_receive_mask = receive_mask;
+				reg->sclp_send_mask = send_mask;
+				break;
+			} else
+				reg = NULL;
+		}
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		if (reg && reg->state_change_fn)
+			reg->state_change_fn(reg);
+	} while (reg);
 }
 
-/* state change notification */
 struct sclp_statechangebuf {
 	struct evbuf_header	header;
 	u8		validity_sclp_active_facility_mask : 1;
@@ -429,148 +472,126 @@
 	u32		read_data_function_mask;
 } __attribute__((packed));
 
-static inline void
-__sclp_notify_state_change(void)
-{
-	struct list_head *l;
-	struct sclp_register *t;
-	sccb_mask_t receive_mask, send_mask;
-
-	list_for_each(l, &sclp_reg_list) {
-		t = list_entry(l, struct sclp_register, list);
-		receive_mask = t->receive_mask & sclp_receive_mask;
-		send_mask = t->send_mask & sclp_send_mask;
-		if (t->sclp_receive_mask != receive_mask ||
-		    t->sclp_send_mask != send_mask) {
-			t->sclp_receive_mask = receive_mask;
-			t->sclp_send_mask = send_mask;
-			if (t->state_change_fn != NULL)
-				t->state_change_fn(t);
-		}
-	}
-}
 
+/* State change event callback. Inform listeners of changes. */
 static void
-sclp_state_change(struct evbuf_header *evbuf)
+sclp_state_change_cb(struct evbuf_header *evbuf)
 {
 	unsigned long flags;
 	struct sclp_statechangebuf *scbuf;
 
-	spin_lock_irqsave(&sclp_lock, flags);
 	scbuf = (struct sclp_statechangebuf *) evbuf;
-
-	if (scbuf->validity_sclp_receive_mask) {
-		if (scbuf->mask_length != sizeof(sccb_mask_t))
-			printk(KERN_WARNING SCLP_CORE_PRINT_HEADER
-			       "state change event with mask length %i\n",
-			       scbuf->mask_length);
-		else
-			/* set new receive mask */
-			sclp_receive_mask = scbuf->sclp_receive_mask;
-	}
-
-	if (scbuf->validity_sclp_send_mask) {
-		if (scbuf->mask_length != sizeof(sccb_mask_t))
-			printk(KERN_WARNING SCLP_CORE_PRINT_HEADER
-			       "state change event with mask length %i\n",
-			       scbuf->mask_length);
-		else
-			/* set new send mask */
-			sclp_send_mask = scbuf->sclp_send_mask;
-	}
-
-	__sclp_notify_state_change();
+	if (scbuf->mask_length != sizeof(sccb_mask_t))
+		return;
+	spin_lock_irqsave(&sclp_lock, flags);
+	if (scbuf->validity_sclp_receive_mask)
+		sclp_receive_mask = scbuf->sclp_receive_mask;
+	if (scbuf->validity_sclp_send_mask)
+		sclp_send_mask = scbuf->sclp_send_mask;
 	spin_unlock_irqrestore(&sclp_lock, flags);
+	sclp_dispatch_state_change();
 }
 
 static struct sclp_register sclp_state_change_event = {
 	.receive_mask = EvTyp_StateChange_Mask,
-	.receiver_fn = sclp_state_change
+	.receiver_fn = sclp_state_change_cb
 };
 
-
-/*
- * SCLP quiesce event handler
- */
-#ifdef CONFIG_SMP
-static void
-do_load_quiesce_psw(void * __unused)
+/* Calculate receive and send mask of currently registered listeners.
+ * Called while sclp_lock is locked. */
+static inline void
+__sclp_get_mask(sccb_mask_t *receive_mask, sccb_mask_t *send_mask)
 {
-	static atomic_t cpuid = ATOMIC_INIT(-1);
-	psw_t quiesce_psw;
-	__u32 status;
-	int i;
-
-	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
-		signal_processor(smp_processor_id(), sigp_stop);
-	/* Wait for all other cpus to enter stopped state */
-	i = 1;
-	while (i < NR_CPUS) {
-		if (!cpu_online(i)) {
-			i++;
-			continue;
-		}
-		switch (signal_processor_ps(&status, 0, i, sigp_sense)) {
-		case sigp_order_code_accepted:
-		case sigp_status_stored:
-			/* Check for stopped and check stop state */
-			if (status & 0x50)
-				i++;
-			break;
-		case sigp_busy:
-			break;
-		case sigp_not_operational:
-			i++;
-			break;
-		}
+	struct list_head *l;
+	struct sclp_register *t;
+
+	*receive_mask = 0;
+	*send_mask = 0;
+	list_for_each(l, &sclp_reg_list) {
+		t = list_entry(l, struct sclp_register, list);
+		*receive_mask |= t->receive_mask;
+		*send_mask |= t->send_mask;
 	}
-	/* Quiesce the last cpu with the special psw */
-	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
-	quiesce_psw.addr = 0xfff;
-	__load_psw(quiesce_psw);
 }
 
-static void
-do_machine_quiesce(void)
+/* Register event listener. Return 0 on success, non-zero otherwise. */
+int
+sclp_register(struct sclp_register *reg)
 {
-	on_each_cpu(do_load_quiesce_psw, NULL, 0, 0);
+	unsigned long flags;
+	sccb_mask_t receive_mask;
+	sccb_mask_t send_mask;
+	int rc;
+
+	rc = sclp_init();
+	if (rc)
+		return rc;
+	spin_lock_irqsave(&sclp_lock, flags);
+	/* Check event mask for collisions */
+	__sclp_get_mask(&receive_mask, &send_mask);
+	if (reg->receive_mask & receive_mask || reg->send_mask & send_mask) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return -EBUSY;
+	}
+	/* Trigger initial state change callback */
+	reg->sclp_receive_mask = 0;
+	reg->sclp_send_mask = 0;
+	list_add(&reg->list, &sclp_reg_list);
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	rc = sclp_init_mask(1);
+	if (rc) {
+		spin_lock_irqsave(&sclp_lock, flags);
+		list_del(&reg->list);
+		spin_unlock_irqrestore(&sclp_lock, flags);
+	}
+	return rc;
 }
-#else
-static void
-do_machine_quiesce(void)
+
+EXPORT_SYMBOL(sclp_register);
+
+/* Unregister event listener. */
+void
+sclp_unregister(struct sclp_register *reg)
 {
-	psw_t quiesce_psw;
+	unsigned long flags;
 
-	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
-	quiesce_psw.addr = 0xfff;
-	__load_psw(quiesce_psw);
+	spin_lock_irqsave(&sclp_lock, flags);
+	list_del(&reg->list);
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	sclp_init_mask(1);
 }
-#endif
 
-extern void ctrl_alt_del(void);
+EXPORT_SYMBOL(sclp_unregister);
 
-static void
-sclp_quiesce(struct evbuf_header *evbuf)
+/* Remove event buffers which are marked processed. Return the number of
+ * remaining event buffers. */
+int
+sclp_remove_processed(struct sccb_header *sccb)
 {
-	/*
-	 * We got a "shutdown" request.
-	 * Add a call to an appropriate "shutdown" routine here. This
-	 * routine should set all PSWs to 'disabled-wait', 'stopped'
-	 * or 'check-stopped' - except 1 PSW which needs to carry a
-	 * special bit pattern called 'quiesce PSW'.
-	 */
-	_machine_restart = (void *) do_machine_quiesce;
-	_machine_halt = do_machine_quiesce;
-	_machine_power_off = do_machine_quiesce;
-	ctrl_alt_del();
-}
-
-static struct sclp_register sclp_quiesce_event = {
-	.receive_mask = EvTyp_SigQuiesce_Mask,
-	.receiver_fn = sclp_quiesce
-};
+	struct evbuf_header *evbuf;
+	int unprocessed;
+	u16 remaining;
+
+	evbuf = (struct evbuf_header *) (sccb + 1);
+	unprocessed = 0;
+	remaining = sccb->length - sizeof(struct sccb_header);
+	while (remaining > 0) {
+		remaining -= evbuf->length;
+		if (evbuf->flags & 0x80) {
+			sccb->length -= evbuf->length;
+			memcpy(evbuf, (void *) ((addr_t) evbuf + evbuf->length),
+			       remaining);
+		} else {
+			unprocessed++;
+			evbuf = (struct evbuf_header *)
+					((addr_t) evbuf + evbuf->length);
+		}
+	}
+	return unprocessed;
+}
+
+EXPORT_SYMBOL(sclp_remove_processed);
 
-/* initialisation of SCLP */
 struct init_sccb {
 	struct sccb_header header;
 	u16 _reserved;
@@ -581,273 +602,314 @@
 	sccb_mask_t sclp_receive_mask;
 } __attribute__((packed));
 
-static void sclp_init_mask_retry(unsigned long);
-
-static int
-sclp_init_mask(void)
+/* Prepare init mask request. Called while sclp_lock is locked. */
+static inline void
+__sclp_make_init_req(u32 receive_mask, u32 send_mask)
 {
-	unsigned long flags;
 	struct init_sccb *sccb;
-	struct sclp_req *req;
-	struct list_head *l;
-	struct sclp_register *t;
-	int rc;
 
 	sccb = (struct init_sccb *) sclp_init_sccb;
-	/* stick the request structure to the end of the init sccb page */
-	req = (struct sclp_req *) ((addr_t) sccb + PAGE_SIZE) - 1;
-
-	/* SCLP setup concerning receiving and sending Event Buffers */
-	req->command = SCLP_CMDW_WRITEMASK;
-	req->status = SCLP_REQ_QUEUED;
-	req->callback = NULL;
-	req->sccb = sccb;
-	/* setup sccb for writemask command */
-	memset(sccb, 0, sizeof(struct init_sccb));
+	clear_page(sccb);
+	memset(&sclp_init_req, 0, sizeof(struct sclp_req));
+	sclp_init_req.command = SCLP_CMDW_WRITEMASK;
+	sclp_init_req.status = SCLP_REQ_FILLED;
+	sclp_init_req.start_count = 0;
+	sclp_init_req.callback = NULL;
+	sclp_init_req.callback_data = NULL;
+	sclp_init_req.sccb = sccb;
 	sccb->header.length = sizeof(struct init_sccb);
 	sccb->mask_length = sizeof(sccb_mask_t);
-	/* copy in the sccb mask of the registered event types */
-	spin_lock_irqsave(&sclp_lock, flags);
-	if (!test_bit(SCLP_SHUTDOWN, &sclp_status)) {
-		list_for_each(l, &sclp_reg_list) {
-			t = list_entry(l, struct sclp_register, list);
-			sccb->receive_mask |= t->receive_mask;
-			sccb->send_mask |= t->send_mask;
-		}
-	}
+	sccb->receive_mask = receive_mask;
+	sccb->send_mask = send_mask;
 	sccb->sclp_receive_mask = 0;
 	sccb->sclp_send_mask = 0;
-	if (test_bit(SCLP_INIT, &sclp_status)) {
-		/* add request to sclp queue */
-		list_add_tail(&req->list, &sclp_req_queue);
-		spin_unlock_irqrestore(&sclp_lock, flags);
-		/* and start if SCLP is idle */
-		sclp_start_request();
-		/* now wait for completion */
-		while (req->status != SCLP_REQ_DONE &&
-		       req->status != SCLP_REQ_FAILED)
+}
+
+/* Start init mask request. If calculate is non-zero, calculate the mask as
+ * requested by registered listeners. Use zero mask otherwise. Return 0 on
+ * success, non-zero otherwise. */
+static int
+sclp_init_mask(int calculate)
+{
+	unsigned long flags;
+	struct init_sccb *sccb = (struct init_sccb *) sclp_init_sccb;
+	sccb_mask_t receive_mask;
+	sccb_mask_t send_mask;
+	int retry;
+	int rc;
+	unsigned long wait;
+
+	spin_lock_irqsave(&sclp_lock, flags);
+	/* Check if interface is in appropriate state */
+	if (sclp_mask_state != sclp_mask_state_idle) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return -EBUSY;
+	}
+	if (sclp_activation_state == sclp_activation_state_inactive) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return -EINVAL;
+	}
+	sclp_mask_state = sclp_mask_state_initializing;
+	/* Determine mask */
+	if (calculate)
+		__sclp_get_mask(&receive_mask, &send_mask);
+	else {
+		receive_mask = 0;
+		send_mask = 0;
+	}
+	rc = -EIO;
+	for (retry = 0; retry <= SCLP_MASK_RETRY; retry++) {
+		/* Prepare request */
+		__sclp_make_init_req(receive_mask, send_mask);
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		if (sclp_add_request(&sclp_init_req)) {
+			/* Try again later */
+			wait = jiffies + SCLP_BUSY_INTERVAL * HZ;
+			while (time_before(jiffies, wait))
+				sclp_sync_wait();
+			spin_lock_irqsave(&sclp_lock, flags);
+			continue;
+		}
+		while (sclp_init_req.status != SCLP_REQ_DONE &&
+		       sclp_init_req.status != SCLP_REQ_FAILED)
 			sclp_sync_wait();
 		spin_lock_irqsave(&sclp_lock, flags);
-	} else {
-		/*
-		 * Special case for the very first write mask command.
-		 * The interrupt handler is not removing request from
-		 * the request queue and doesn't call callbacks yet
-		 * because there might be an pending old interrupt
-		 * after a Re-IPL. We have to receive and ignore it.
-		 */
-		do {
-			rc = __service_call(req->command, req->sccb);
-			if (rc == 0)
-				set_bit(SCLP_RUNNING, &sclp_status);
+		if (sclp_init_req.status == SCLP_REQ_DONE &&
+		    sccb->header.response_code == 0x20) {
+			/* Successful request */
+			if (calculate) {
+				sclp_receive_mask = sccb->sclp_receive_mask;
+				sclp_send_mask = sccb->sclp_send_mask;
+			} else {
+				sclp_receive_mask = 0;
+				sclp_send_mask = 0;
+			}
 			spin_unlock_irqrestore(&sclp_lock, flags);
-			if (rc == -EIO)
-				return -ENOSYS;
-			sclp_sync_wait();
+			sclp_dispatch_state_change();
 			spin_lock_irqsave(&sclp_lock, flags);
-		} while (rc == -EBUSY);
-	}
-	if (sccb->header.response_code != 0x0020) {
-		/* WRITEMASK failed - we cannot rely on receiving a state
-		   change event, so initially, polling is the only alternative
-		   for us to ever become operational. */
-		if (!test_bit(SCLP_SHUTDOWN, &sclp_status) &&
-		    (!timer_pending(&retry_timer) ||
-		     !mod_timer(&retry_timer,
-			       jiffies + SCLP_INIT_POLL_INTERVAL*HZ))) {
-			retry_timer.function = sclp_init_mask_retry;
-			retry_timer.data = 0;
-			retry_timer.expires = jiffies +
-				SCLP_INIT_POLL_INTERVAL*HZ;
-			add_timer(&retry_timer);
+			rc = 0;
+			break;
 		}
-	} else {
-		sclp_receive_mask = sccb->sclp_receive_mask;
-		sclp_send_mask = sccb->sclp_send_mask;
-		__sclp_notify_state_change();
 	}
+	sclp_mask_state = sclp_mask_state_idle;
 	spin_unlock_irqrestore(&sclp_lock, flags);
-	return 0;
-}
-
-static void
-sclp_init_mask_retry(unsigned long data) 
-{
-	sclp_init_mask();
+	return rc;
 }
 
-/* Reboot event handler - reset send and receive mask to prevent pending SCLP
- * events from interfering with rebooted system. */
-static int
-sclp_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
+/* Deactivate SCLP interface. On success, new requests will be rejected,
+ * events will no longer be dispatched. Return 0 on success, non-zero
+ * otherwise. */
+int
+sclp_deactivate(void)
 {
 	unsigned long flags;
+	int rc;
 
-	/* Note: need spinlock to maintain atomicity when accessing global
-         * variables. */
 	spin_lock_irqsave(&sclp_lock, flags);
-	set_bit(SCLP_SHUTDOWN, &sclp_status);
+	/* Deactivate can only be called when active */
+	if (sclp_activation_state != sclp_activation_state_active) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return -EINVAL;
+	}
+	sclp_activation_state = sclp_activation_state_deactivating;
 	spin_unlock_irqrestore(&sclp_lock, flags);
-	sclp_init_mask();
-	return NOTIFY_DONE;
+	rc = sclp_init_mask(0);
+	spin_lock_irqsave(&sclp_lock, flags);
+	if (rc == 0)
+		sclp_activation_state = sclp_activation_state_inactive;
+	else
+		sclp_activation_state = sclp_activation_state_active;
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	return rc;
 }
 
-static struct notifier_block sclp_reboot_notifier = {
-	.notifier_call = sclp_reboot_event
-};
+EXPORT_SYMBOL(sclp_deactivate);
 
-/*
- * sclp setup function. Called early (no kmalloc!) from sclp_console_init().
- */
-static int
-sclp_init(void)
+/* Reactivate SCLP interface after sclp_deactivate. On success, new
+ * requests will be accepted, events will be dispatched again. Return 0 on
+ * success, non-zero otherwise. */
+int
+sclp_reactivate(void)
 {
+	unsigned long flags;
 	int rc;
 
-	if (test_bit(SCLP_INIT, &sclp_status))
-		/* Already initialized. */
-		return 0;
-
-	spin_lock_init(&sclp_lock);
-	INIT_LIST_HEAD(&sclp_req_queue);
-
-	/* init event list */
-	INIT_LIST_HEAD(&sclp_reg_list);
-	list_add(&sclp_state_change_event.list, &sclp_reg_list);
-	list_add(&sclp_quiesce_event.list, &sclp_reg_list);
-
-	rc = register_reboot_notifier(&sclp_reboot_notifier);
-	if (rc)
-		return rc;
+	spin_lock_irqsave(&sclp_lock, flags);
+	/* Reactivate can only be called when inactive */
+	if (sclp_activation_state != sclp_activation_state_inactive) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return -EINVAL;
+	}
+	sclp_activation_state = sclp_activation_state_activating;
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	rc = sclp_init_mask(1);
+	spin_lock_irqsave(&sclp_lock, flags);
+	if (rc == 0)
+		sclp_activation_state = sclp_activation_state_active;
+	else
+		sclp_activation_state = sclp_activation_state_inactive;
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	return rc;
+}
 
-	/*
-	 * request the 0x2401 external interrupt
-	 * The sclp driver is initialized early (before kmalloc works). We
-	 * need to use register_early_external_interrupt.
-	 */
-	if (register_early_external_interrupt(0x2401, sclp_interrupt_handler,
-					      &ext_int_info_hwc) != 0)
-		return -EBUSY;
+EXPORT_SYMBOL(sclp_reactivate);
 
-	/* enable service-signal external interruptions,
-	 * Control Register 0 bit 22 := 1
-	 * (besides PSW bit 7 must be set to 1 sometimes for external
-	 * interruptions)
-	 */
-	ctl_set_bit(0, 9);
+/* Handler for external interruption used during initialization. Modify
+ * request state to done. */
+static void
+sclp_check_handler(struct pt_regs *regs, __u16 code)
+{
+	u32 finished_sccb;
 
-	init_timer(&retry_timer);
-	init_timer(&sclp_busy_timer);
-	/* do the initial write event mask */
-	rc = sclp_init_mask();
-	if (rc == 0) {
-		/* Ok, now everything is setup right. */
-		set_bit(SCLP_INIT, &sclp_status);
-		return 0;
+	finished_sccb = S390_lowcore.ext_params & 0xfffffff8;
+	/* Is this the interrupt we are waiting for? */
+	if (finished_sccb == 0)
+		return;
+	if (finished_sccb != (u32) (addr_t) sclp_init_sccb) {
+		printk(KERN_WARNING SCLP_HEADER "unsolicited interrupt "
+		       "for buffer at 0x%x\n", finished_sccb);
+		return;
 	}
-
-	/* The sclp_init_mask failed. SCLP is broken, unregister and exit. */
-	ctl_clear_bit(0,9);
-	unregister_early_external_interrupt(0x2401, sclp_interrupt_handler,
-					    &ext_int_info_hwc);
-
-	return rc;
+	spin_lock(&sclp_lock);
+	if (sclp_running_state == sclp_running_state_running) {
+		sclp_init_req.status = SCLP_REQ_DONE;
+		sclp_running_state = sclp_running_state_idle;
+	}
+	spin_unlock(&sclp_lock);
 }
 
-/*
- * Register the SCLP event listener identified by REG. Return 0 on success.
- * Some error codes and their meaning:
- *
- *  -ENODEV = SCLP interface is not supported on this machine
- *   -EBUSY = there is already a listener registered for the requested
- *            event type
- *     -EIO = SCLP interface is currently not operational
- */
-int
-sclp_register(struct sclp_register *reg)
+/* Initial init mask request timed out. Modify request state to failed. */
+static void
+sclp_check_timeout(unsigned long data)
 {
 	unsigned long flags;
-	struct list_head *l;
-	struct sclp_register *t;
-
-	if (!MACHINE_HAS_SCLP)
-		return -ENODEV;
 
-	if (!test_bit(SCLP_INIT, &sclp_status))
-		sclp_init();
 	spin_lock_irqsave(&sclp_lock, flags);
-	/* check already registered event masks for collisions */
-	list_for_each(l, &sclp_reg_list) {
-		t = list_entry(l, struct sclp_register, list);
-		if (t->receive_mask & reg->receive_mask ||
-		    t->send_mask & reg->send_mask) {
-			spin_unlock_irqrestore(&sclp_lock, flags);
-			return -EBUSY;
-		}
+	if (sclp_running_state == sclp_running_state_running) {
+		sclp_init_req.status = SCLP_REQ_FAILED;
+		sclp_running_state = sclp_running_state_idle;
 	}
-	/*
-	 * set present mask to 0 to trigger state change
-	 * callback in sclp_init_mask
-	 */
-	reg->sclp_receive_mask = 0;
-	reg->sclp_send_mask = 0;
-	list_add(&reg->list, &sclp_reg_list);
 	spin_unlock_irqrestore(&sclp_lock, flags);
-	sclp_init_mask();
-	return 0;
 }
 
-/*
- * Unregister the SCLP event listener identified by REG.
- */
-void
-sclp_unregister(struct sclp_register *reg)
+/* Perform a check of the SCLP interface. Return zero if the interface is
+ * available and there are no pending requests from a previous instance.
+ * Return non-zero otherwise. */
+static int
+sclp_check_interface(void)
 {
+	struct init_sccb *sccb;
 	unsigned long flags;
+	int retry;
+	int rc;
 
 	spin_lock_irqsave(&sclp_lock, flags);
-	list_del(&reg->list);
+	/* Prepare init mask command */
+	rc = register_early_external_interrupt(0x2401, sclp_check_handler,
+					       &ext_int_info_hwc);
+	if (rc) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return rc;
+	}
+	for (retry = 0; retry <= SCLP_INIT_RETRY; retry++) {
+		__sclp_make_init_req(0, 0);
+		sccb = (struct init_sccb *) sclp_init_req.sccb;
+		rc = service_call(sclp_init_req.command, sccb);
+		if (rc == -EIO)
+			break;
+		sclp_init_req.status = SCLP_REQ_RUNNING;
+		sclp_running_state = sclp_running_state_running;
+		__sclp_set_request_timer(SCLP_RETRY_INTERVAL * HZ,
+					 sclp_check_timeout, 0);
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		/* Enable service-signal interruption - needs to happen
+		 * with IRQs enabled. */
+		ctl_set_bit(0, 9);
+		/* Wait for signal from interrupt or timeout */
+		sclp_sync_wait();
+		/* Disable service-signal interruption - needs to happen
+		 * with IRQs enabled. */
+		ctl_clear_bit(0,9);
+		spin_lock_irqsave(&sclp_lock, flags);
+		del_timer(&sclp_request_timer);
+		if (sclp_init_req.status == SCLP_REQ_DONE &&
+		    sccb->header.response_code == 0x20) {
+			rc = 0;
+			break;
+		} else
+			rc = -EBUSY;
+	}
+	unregister_early_external_interrupt(0x2401, sclp_check_handler,
+					    &ext_int_info_hwc);
 	spin_unlock_irqrestore(&sclp_lock, flags);
-	sclp_init_mask();
+	return rc;
 }
 
-#define	SCLP_EVBUF_PROCESSED	0x80
+/* Reboot event handler. Reset send and receive mask to prevent pending SCLP
+ * events from interfering with rebooted system. */
+static int
+sclp_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	sclp_deactivate();
+	return NOTIFY_DONE;
+}
 
-/*
- * Traverse array of event buffers contained in SCCB and remove all buffers
- * with a set "processed" flag. Return the number of unprocessed buffers.
- */
-int
-sclp_remove_processed(struct sccb_header *sccb)
+static struct notifier_block sclp_reboot_notifier = {
+	.notifier_call = sclp_reboot_event
+};
+
+/* Initialize SCLP driver. Return zero if driver is operational, non-zero
+ * otherwise. */
+static int
+sclp_init(void)
 {
-	struct evbuf_header *evbuf;
-	int unprocessed;
-	u16 remaining;
+	unsigned long flags;
+	int rc;
 
-	evbuf = (struct evbuf_header *) (sccb + 1);
-	unprocessed = 0;
-	remaining = sccb->length - sizeof(struct sccb_header);
-	while (remaining > 0) {
-		remaining -= evbuf->length;
-		if (evbuf->flags & SCLP_EVBUF_PROCESSED) {
-			sccb->length -= evbuf->length;
-			memcpy((void *) evbuf,
-			       (void *) ((addr_t) evbuf + evbuf->length),
-			       remaining);
-		} else {
-			unprocessed++;
-			evbuf = (struct evbuf_header *)
-					((addr_t) evbuf + evbuf->length);
-		}
+	if (!MACHINE_HAS_SCLP)
+		return -ENODEV;
+	spin_lock_irqsave(&sclp_lock, flags);
+	/* Check for previous or running initialization */
+	if (sclp_init_state != sclp_init_state_uninitialized) {
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return 0;
 	}
-
-	return unprocessed;
+	sclp_init_state = sclp_init_state_initializing;
+	/* Set up variables */
+	INIT_LIST_HEAD(&sclp_req_queue);
+	INIT_LIST_HEAD(&sclp_reg_list);
+	list_add(&sclp_state_change_event.list, &sclp_reg_list);
+	init_timer(&sclp_request_timer);
+	/* Check interface */
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	rc = sclp_check_interface();
+	spin_lock_irqsave(&sclp_lock, flags);
+	if (rc) {
+		sclp_init_state = sclp_init_state_uninitialized;
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return rc;
+	}
+	/* Register reboot handler */
+	rc = register_reboot_notifier(&sclp_reboot_notifier);
+	if (rc) {
+		sclp_init_state = sclp_init_state_uninitialized;
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return rc;
+	}
+	/* Register interrupt handler */
+	rc = register_early_external_interrupt(0x2401, sclp_interrupt_handler,
+					       &ext_int_info_hwc);
+	if (rc) {
+		unregister_reboot_notifier(&sclp_reboot_notifier);
+		sclp_init_state = sclp_init_state_uninitialized;
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		return rc;
+	}
+	sclp_init_state = sclp_init_state_initialized;
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	/* Enable service-signal external interruption - needs to happen with
+	 * IRQs enabled. */
+	ctl_set_bit(0, 9);
+	sclp_init_mask(1);
+	return 0;
 }
-
-module_init(sclp_init);
-
-EXPORT_SYMBOL(sclp_add_request);
-EXPORT_SYMBOL(sclp_sync_wait);
-EXPORT_SYMBOL(sclp_register);
-EXPORT_SYMBOL(sclp_unregister);
-EXPORT_SYMBOL(sclp_error_message);
diff -urN linux-2.6/drivers/s390/char/sclp_con.c linux-2.6-patched/drivers/s390/char/sclp_con.c
--- linux-2.6/drivers/s390/char/sclp_con.c	2004-12-24 22:34:46.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_con.c	2004-12-28 08:50:53.000000000 +0100
@@ -49,25 +49,22 @@
 sclp_conbuf_callback(struct sclp_buffer *buffer, int rc)
 {
 	unsigned long flags;
-	struct sclp_buffer *next;
 	void *page;
 
-	/* Ignore return code - because console-writes aren't critical,
-	   we do without a sophisticated error recovery mechanism.  */
-	page = sclp_unmake_buffer(buffer);
-	spin_lock_irqsave(&sclp_con_lock, flags);
-	/* Remove buffer from outqueue */
-	list_del(&buffer->list);
-	sclp_con_buffer_count--;
-	list_add_tail((struct list_head *) page, &sclp_con_pages);
-	/* Check if there is a pending buffer on the out queue. */
-	next = NULL;
-	if (!list_empty(&sclp_con_outqueue))
-		next = list_entry(sclp_con_outqueue.next,
-				  struct sclp_buffer, list);
-	spin_unlock_irqrestore(&sclp_con_lock, flags);
-	if (next != NULL)
-		sclp_emit_buffer(next, sclp_conbuf_callback);
+	do {
+		page = sclp_unmake_buffer(buffer);
+		spin_lock_irqsave(&sclp_con_lock, flags);
+		/* Remove buffer from outqueue */
+		list_del(&buffer->list);
+		sclp_con_buffer_count--;
+		list_add_tail((struct list_head *) page, &sclp_con_pages);
+		/* Check if there is a pending buffer on the out queue. */
+		buffer = NULL;
+		if (!list_empty(&sclp_con_outqueue))
+			buffer = list_entry(sclp_con_outqueue.next,
+					    struct sclp_buffer, list);
+		spin_unlock_irqrestore(&sclp_con_lock, flags);
+	} while (buffer && sclp_emit_buffer(buffer, sclp_conbuf_callback));
 }
 
 static inline void
@@ -76,6 +73,7 @@
 	struct sclp_buffer* buffer;
 	unsigned long flags;
 	int count;
+	int rc;
 
 	spin_lock_irqsave(&sclp_con_lock, flags);
 	buffer = sclp_conbuf;
@@ -87,8 +85,11 @@
 	list_add_tail(&buffer->list, &sclp_con_outqueue);
 	count = sclp_con_buffer_count++;
 	spin_unlock_irqrestore(&sclp_con_lock, flags);
-	if (count == 0)
-		sclp_emit_buffer(buffer, sclp_conbuf_callback);
+	if (count)
+		return;
+	rc = sclp_emit_buffer(buffer, sclp_conbuf_callback);
+	if (rc)
+		sclp_conbuf_callback(buffer, rc);
 }
 
 /*
diff -urN linux-2.6/drivers/s390/char/sclp_cpi.c linux-2.6-patched/drivers/s390/char/sclp_cpi.c
--- linux-2.6/drivers/s390/char/sclp_cpi.c	2004-12-24 22:34:57.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_cpi.c	2004-12-28 08:50:53.000000000 +0100
@@ -196,18 +196,20 @@
 	rc = sclp_register(&sclp_cpi_event);
 	if (rc) {
 		/* could not register sclp event. Die. */
-		printk("cpi: could not register to hardware console.\n");
+		printk(KERN_WARNING "cpi: could not register to hardware "
+		       "console.\n");
 		return -EINVAL;
 	}
 	if (!(sclp_cpi_event.sclp_send_mask & EvTyp_CtlProgIdent_Mask)) {
-		printk("cpi: no control program identification support\n");
+		printk(KERN_WARNING "cpi: no control program identification "
+		       "support\n");
 		sclp_unregister(&sclp_cpi_event);
 		return -ENOTSUPP;
 	}
 
 	req = cpi_prepare_req();
 	if (IS_ERR(req)) {
-		printk("cpi: couldn't allocate request\n");
+		printk(KERN_WARNING "cpi: couldn't allocate request\n");
 		sclp_unregister(&sclp_cpi_event);
 		return PTR_ERR(req);
 	}
@@ -216,13 +218,20 @@
 	sema_init(&sem, 0);
 	req->callback_data = &sem;
 	/* Add request to sclp queue */
-	sclp_add_request(req);
+	rc = sclp_add_request(req);
+	if (rc) {
+		printk(KERN_WARNING "cpi: could not start request\n");
+		cpi_free_req(req);
+		sclp_unregister(&sclp_cpi_event);
+		return rc;
+	}
 	/* make "insmod" sleep until callback arrives */
 	down(&sem);
 
 	rc = ((struct cpi_sccb *) req->sccb)->header.response_code;
 	if (rc != 0x0020) {
-		printk("cpi: failed with response code 0x%x\n", rc);
+		printk(KERN_WARNING "cpi: failed with response code 0x%x\n",
+		       rc);
 		rc = -ECOMM;
 	} else
 		rc = 0;
diff -urN linux-2.6/drivers/s390/char/sclp.h linux-2.6-patched/drivers/s390/char/sclp.h
--- linux-2.6/drivers/s390/char/sclp.h	2004-12-24 22:34:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp.h	2004-12-28 08:50:53.000000000 +0100
@@ -95,6 +95,7 @@
 	sclp_cmdw_t command;		/* sclp command to execute */
 	void	*sccb;			/* pointer to the sccb to execute */
 	char	status;			/* status of this request */
+	int     start_count;		/* number of SVCs done for this req */
 	/* Callback that is called after reaching final status. */
 	void (*callback)(struct sclp_req *, void *data);
 	void *callback_data;
@@ -123,12 +124,13 @@
 };
 
 /* externals from sclp.c */
-void sclp_add_request(struct sclp_req *req);
+int sclp_add_request(struct sclp_req *req);
 void sclp_sync_wait(void);
 int sclp_register(struct sclp_register *reg);
 void sclp_unregister(struct sclp_register *reg);
-char *sclp_error_message(u16 response_code);
 int sclp_remove_processed(struct sccb_header *sccb);
+int sclp_deactivate(void);
+int sclp_reactivate(void);
 
 /* useful inlines */
 
diff -urN linux-2.6/drivers/s390/char/sclp_quiesce.c linux-2.6-patched/drivers/s390/char/sclp_quiesce.c
--- linux-2.6/drivers/s390/char/sclp_quiesce.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_quiesce.c	2004-12-28 08:50:53.000000000 +0100
@@ -0,0 +1,114 @@
+/*
+ *  drivers/s390/char/sclp_quiesce.c
+ *     signal quiesce handler
+ *
+ *  (C) Copyright IBM Corp. 1999,2004
+ *  Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *             Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/cpumask.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <asm/atomic.h>
+#include <asm/ptrace.h>
+#include <asm/sigp.h>
+
+#include "sclp.h"
+
+
+#ifdef CONFIG_SMP
+/* Signal completion of shutdown process. All CPUs except the first to enter
+ * this function: go to stopped state. First CPU: wait until all other
+ * CPUs are in stopped or check stop state. Afterwards, load special PSW
+ * to indicate completion. */
+static void
+do_load_quiesce_psw(void * __unused)
+{
+	static atomic_t cpuid = ATOMIC_INIT(-1);
+	psw_t quiesce_psw;
+	__u32 status;
+	int i;
+
+	if (atomic_compare_and_swap(-1, smp_processor_id(), &cpuid))
+		signal_processor(smp_processor_id(), sigp_stop);
+	/* Wait for all other cpus to enter stopped state */
+	i = 1;
+	while (i < NR_CPUS) {
+		if (!cpu_online(i)) {
+			i++;
+			continue;
+		}
+		switch (signal_processor_ps(&status, 0, i, sigp_sense)) {
+		case sigp_order_code_accepted:
+		case sigp_status_stored:
+			/* Check for stopped and check stop state */
+			if (status & 0x50)
+				i++;
+			break;
+		case sigp_busy:
+			break;
+		case sigp_not_operational:
+			i++;
+			break;
+		}
+	}
+	/* Quiesce the last cpu with the special psw */
+	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
+	quiesce_psw.addr = 0xfff;
+	__load_psw(quiesce_psw);
+}
+
+/* Shutdown handler. Perform shutdown function on all CPUs. */
+static void
+do_machine_quiesce(void)
+{
+	on_each_cpu(do_load_quiesce_psw, NULL, 0, 0);
+}
+#else
+/* Shutdown handler. Signal completion of shutdown by loading special PSW. */
+static void
+do_machine_quiesce(void)
+{
+	psw_t quiesce_psw;
+
+	quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
+	quiesce_psw.addr = 0xfff;
+	__load_psw(quiesce_psw);
+}
+#endif
+
+extern void ctrl_alt_del(void);
+
+/* Handler for quiesce event. Start shutdown procedure. */
+static void
+sclp_quiesce_handler(struct evbuf_header *evbuf)
+{
+	_machine_restart = (void *) do_machine_quiesce;
+	_machine_halt = do_machine_quiesce;
+	_machine_power_off = do_machine_quiesce;
+	ctrl_alt_del();
+}
+
+static struct sclp_register sclp_quiesce_event = {
+	.receive_mask = EvTyp_SigQuiesce_Mask,
+	.receiver_fn = sclp_quiesce_handler
+};
+
+/* Initialize quiesce driver. */
+static int __init
+sclp_quiesce_init(void)
+{
+	int rc;
+
+	rc = sclp_register(&sclp_quiesce_event);
+	if (rc)
+		printk(KERN_WARNING "sclp: could not register quiesce handler "
+		       "(rc=%d)\n", rc);
+	return rc;
+}
+
+module_init(sclp_quiesce_init);
diff -urN linux-2.6/drivers/s390/char/sclp_rw.c linux-2.6-patched/drivers/s390/char/sclp_rw.c
--- linux-2.6/drivers/s390/char/sclp_rw.c	2004-12-24 22:34:44.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_rw.c	2004-12-28 08:50:53.000000000 +0100
@@ -54,7 +54,6 @@
 	buffer = ((struct sclp_buffer *) ((addr_t) sccb + PAGE_SIZE)) - 1;
 	buffer->sccb = sccb;
 	buffer->retry_count = 0;
-	init_timer(&buffer->retry_timer);
 	buffer->mto_number = 0;
 	buffer->mto_char_sum = 0;
 	buffer->current_line = NULL;
@@ -365,17 +364,7 @@
 	return rc;
 }
 
-static void
-sclp_buffer_retry(unsigned long data)
-{
-	struct sclp_buffer *buffer = (struct sclp_buffer *) data;
-	buffer->request.status = SCLP_REQ_FILLED;
-	buffer->sccb->header.response_code = 0x0000;
-	sclp_add_request(&buffer->request);
-}
-
-#define SCLP_BUFFER_MAX_RETRY		5
-#define	SCLP_BUFFER_RETRY_INTERVAL	2
+#define SCLP_BUFFER_MAX_RETRY		1
 
 /*
  * second half of Write Event Data-function that has to be done after
@@ -404,7 +393,7 @@
 		break;
 
 	case 0x0340: /* Contained SCLP equipment check */
-		if (buffer->retry_count++ > SCLP_BUFFER_MAX_RETRY) {
+		if (++buffer->retry_count > SCLP_BUFFER_MAX_RETRY) {
 			rc = -EIO;
 			break;
 		}
@@ -413,26 +402,26 @@
 			/* not all buffers were processed */
 			sccb->header.response_code = 0x0000;
 			buffer->request.status = SCLP_REQ_FILLED;
-			sclp_add_request(request);
-			return;
-		}
-		rc = 0;
+			rc = sclp_add_request(request);
+			if (rc == 0)
+				return;
+		} else
+			rc = 0;
 		break;
 
 	case 0x0040: /* SCLP equipment check */
 	case 0x05f0: /* Target resource in improper state */
-		if (buffer->retry_count++ > SCLP_BUFFER_MAX_RETRY) {
+		if (++buffer->retry_count > SCLP_BUFFER_MAX_RETRY) {
 			rc = -EIO;
 			break;
 		}
-		/* wait some time, then retry request */
-		buffer->retry_timer.function = sclp_buffer_retry;
-		buffer->retry_timer.data = (unsigned long) buffer;
-		buffer->retry_timer.expires = jiffies +
-						SCLP_BUFFER_RETRY_INTERVAL*HZ;
-		add_timer(&buffer->retry_timer);
-		return;
-
+		/* retry request */
+		sccb->header.response_code = 0x0000;
+		buffer->request.status = SCLP_REQ_FILLED;
+		rc = sclp_add_request(request);
+		if (rc == 0)
+			return;
+		break;
 	default:
 		if (sccb->header.response_code == 0x71f0)
 			rc = -ENOMEM;
@@ -446,9 +435,10 @@
 
 /*
  * Setup the request structure in the struct sclp_buffer to do SCLP Write
- * Event Data and pass the request to the core SCLP loop.
+ * Event Data and pass the request to the core SCLP loop. Return zero on
+ * success, non-zero otherwise.
  */
-void
+int
 sclp_emit_buffer(struct sclp_buffer *buffer,
 		 void (*callback)(struct sclp_buffer *, int))
 {
@@ -459,11 +449,8 @@
 		sclp_finalize_mto(buffer);
 
 	/* Are there messages in the output buffer ? */
-	if (buffer->mto_number == 0) {
-		if (callback != NULL)
-			callback(buffer, 0);
-		return;
-	}
+	if (buffer->mto_number == 0)
+		return -EIO;
 
 	sccb = buffer->sccb;
 	if (sclp_rw_event.sclp_send_mask & EvTyp_Msg_Mask)
@@ -472,16 +459,13 @@
 	else if (sclp_rw_event.sclp_send_mask & EvTyp_PMsgCmd_Mask)
 		/* Use write priority message */
 		sccb->msg_buf.header.type = EvTyp_PMsgCmd;
-	else {
-		if (callback != NULL)
-			callback(buffer, -ENOSYS);
-		return;
-	}
+	else
+		return -ENOSYS;
 	buffer->request.command = SCLP_CMDW_WRITEDATA;
 	buffer->request.status = SCLP_REQ_FILLED;
 	buffer->request.callback = sclp_writedata_callback;
 	buffer->request.callback_data = buffer;
 	buffer->request.sccb = sccb;
 	buffer->callback = callback;
-	sclp_add_request(&buffer->request);
+	return sclp_add_request(&buffer->request);
 }
diff -urN linux-2.6/drivers/s390/char/sclp_rw.h linux-2.6-patched/drivers/s390/char/sclp_rw.h
--- linux-2.6/drivers/s390/char/sclp_rw.h	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_rw.h	2004-12-28 08:50:53.000000000 +0100
@@ -12,7 +12,6 @@
 #define __SCLP_RW_H__
 
 #include <linux/list.h>
-#include <linux/timer.h>
 
 struct mto {
 	u16 length;
@@ -74,7 +73,6 @@
 	char *current_line;
 	int current_length;
 	int retry_count;
-	struct timer_list retry_timer;
 	/* output format settings */
 	unsigned short columns;
 	unsigned short htab;
@@ -90,7 +88,7 @@
 void *sclp_unmake_buffer(struct sclp_buffer *);
 int sclp_buffer_space(struct sclp_buffer *);
 int sclp_write(struct sclp_buffer *buffer, const unsigned char *, int);
-void sclp_emit_buffer(struct sclp_buffer *,void (*)(struct sclp_buffer *,int));
+int sclp_emit_buffer(struct sclp_buffer *,void (*)(struct sclp_buffer *,int));
 void sclp_set_columns(struct sclp_buffer *, unsigned short);
 void sclp_set_htab(struct sclp_buffer *, unsigned short);
 int sclp_chars_in_buffer(struct sclp_buffer *);
diff -urN linux-2.6/drivers/s390/char/sclp_tty.c linux-2.6-patched/drivers/s390/char/sclp_tty.c
--- linux-2.6/drivers/s390/char/sclp_tty.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_tty.c	2004-12-28 08:50:53.000000000 +0100
@@ -255,25 +255,22 @@
 sclp_ttybuf_callback(struct sclp_buffer *buffer, int rc)
 {
 	unsigned long flags;
-	struct sclp_buffer *next;
 	void *page;
 
-	/* Ignore return code - because tty-writes aren't critical,
-	   we do without a sophisticated error recovery mechanism.  */
-	page = sclp_unmake_buffer(buffer);
-	spin_lock_irqsave(&sclp_tty_lock, flags);
-	/* Remove buffer from outqueue */
-	list_del(&buffer->list);
-	sclp_tty_buffer_count--;
-	list_add_tail((struct list_head *) page, &sclp_tty_pages);
-	/* Check if there is a pending buffer on the out queue. */
-	next = NULL;
-	if (!list_empty(&sclp_tty_outqueue))
-		next = list_entry(sclp_tty_outqueue.next,
-				  struct sclp_buffer, list);
-	spin_unlock_irqrestore(&sclp_tty_lock, flags);
-	if (next != NULL)
-		sclp_emit_buffer(next, sclp_ttybuf_callback);
+	do {
+		page = sclp_unmake_buffer(buffer);
+		spin_lock_irqsave(&sclp_tty_lock, flags);
+		/* Remove buffer from outqueue */
+		list_del(&buffer->list);
+		sclp_tty_buffer_count--;
+		list_add_tail((struct list_head *) page, &sclp_tty_pages);
+		/* Check if there is a pending buffer on the out queue. */
+		buffer = NULL;
+		if (!list_empty(&sclp_tty_outqueue))
+			buffer = list_entry(sclp_tty_outqueue.next,
+					    struct sclp_buffer, list);
+		spin_unlock_irqrestore(&sclp_tty_lock, flags);
+	} while (buffer && sclp_emit_buffer(buffer, sclp_ttybuf_callback));
 	wake_up(&sclp_tty_waitq);
 	/* check if the tty needs a wake up call */
 	if (sclp_tty != NULL) {
@@ -286,14 +283,17 @@
 {
 	unsigned long flags;
 	int count;
+	int rc;
 
 	spin_lock_irqsave(&sclp_tty_lock, flags);
 	list_add_tail(&buffer->list, &sclp_tty_outqueue);
 	count = sclp_tty_buffer_count++;
 	spin_unlock_irqrestore(&sclp_tty_lock, flags);
-
-	if (count == 0)
-		sclp_emit_buffer(buffer, sclp_ttybuf_callback);
+	if (count)
+		return;
+	rc = sclp_emit_buffer(buffer, sclp_ttybuf_callback);
+	if (rc)
+		sclp_ttybuf_callback(buffer, rc);
 }
 
 /*
diff -urN linux-2.6/drivers/s390/char/sclp_vt220.c linux-2.6-patched/drivers/s390/char/sclp_vt220.c
--- linux-2.6/drivers/s390/char/sclp_vt220.c	2004-12-24 22:34:30.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_vt220.c	2004-12-28 08:50:53.000000000 +0100
@@ -42,7 +42,6 @@
 	struct list_head list;
 	struct sclp_req sclp_req;
 	int retry_count;
-	struct timer_list retry_timer;
 };
 
 /* VT220 SCCB */
@@ -96,7 +95,7 @@
 static int sclp_vt220_flush_later;
 
 static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf);
-static void __sclp_vt220_emit(struct sclp_vt220_request *request);
+static int __sclp_vt220_emit(struct sclp_vt220_request *request);
 static void sclp_vt220_emit_current(void);
 
 /* Registration structure for our interest in SCLP event buffers */
@@ -116,25 +115,24 @@
 sclp_vt220_process_queue(struct sclp_vt220_request *request)
 {
 	unsigned long flags;
-	struct sclp_vt220_request *next;
 	void *page;
 
-	/* Put buffer back to list of empty buffers */
-	page = request->sclp_req.sccb;
-	spin_lock_irqsave(&sclp_vt220_lock, flags);
-	/* Move request from outqueue to empty queue */
-	list_del(&request->list);
-	sclp_vt220_outqueue_count--;
-	list_add_tail((struct list_head *) page, &sclp_vt220_empty);
-	/* Check if there is a pending buffer on the out queue. */
-	next = NULL;
-	if (!list_empty(&sclp_vt220_outqueue))
-		next = list_entry(sclp_vt220_outqueue.next,
-				  struct sclp_vt220_request, list);
-	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
-	if (next != NULL)
-		__sclp_vt220_emit(next);
-	else if (sclp_vt220_flush_later)
+	do {
+		/* Put buffer back to list of empty buffers */
+		page = request->sclp_req.sccb;
+		spin_lock_irqsave(&sclp_vt220_lock, flags);
+		/* Move request from outqueue to empty queue */
+		list_del(&request->list);
+		sclp_vt220_outqueue_count--;
+		list_add_tail((struct list_head *) page, &sclp_vt220_empty);
+		/* Check if there is a pending buffer on the out queue. */
+		request = NULL;
+		if (!list_empty(&sclp_vt220_outqueue))
+			request = list_entry(sclp_vt220_outqueue.next,
+					     struct sclp_vt220_request, list);
+		spin_unlock_irqrestore(&sclp_vt220_lock, flags);
+	} while (request && __sclp_vt220_emit(request));
+	if (request == NULL && sclp_vt220_flush_later)
 		sclp_vt220_emit_current();
 	wake_up(&sclp_vt220_waitq);
 	/* Check if the tty needs a wake up call */
@@ -143,25 +141,7 @@
 	}
 }
 
-/*
- * Retry sclp write request after waiting some time for an sclp equipment
- * check to pass.
- */
-static void
-sclp_vt220_retry(unsigned long data)
-{
-	struct sclp_vt220_request *request;
-	struct sclp_vt220_sccb *sccb;
-
-	request = (struct sclp_vt220_request *) data;
-	request->sclp_req.status = SCLP_REQ_FILLED;
-	sccb = (struct sclp_vt220_sccb *) request->sclp_req.sccb;
-	sccb->header.response_code = 0x0000;
-	sclp_add_request(&request->sclp_req);
-}
-
-#define SCLP_BUFFER_MAX_RETRY		5
-#define	SCLP_BUFFER_RETRY_INTERVAL	2
+#define SCLP_BUFFER_MAX_RETRY		1
 
 /*
  * Callback through which the result of a write request is reported by the
@@ -189,29 +169,26 @@
 		break;
 
 	case 0x0340: /* Contained SCLP equipment check */
-		if (vt220_request->retry_count++ > SCLP_BUFFER_MAX_RETRY)
+		if (++vt220_request->retry_count > SCLP_BUFFER_MAX_RETRY)
 			break;
 		/* Remove processed buffers and requeue rest */
 		if (sclp_remove_processed((struct sccb_header *) sccb) > 0) {
 			/* Not all buffers were processed */
 			sccb->header.response_code = 0x0000;
 			vt220_request->sclp_req.status = SCLP_REQ_FILLED;
-			sclp_add_request(request);
-			return;
+			if (sclp_add_request(request) == 0)
+				return;
 		}
 		break;
 
 	case 0x0040: /* SCLP equipment check */
-		if (vt220_request->retry_count++ > SCLP_BUFFER_MAX_RETRY)
+		if (++vt220_request->retry_count > SCLP_BUFFER_MAX_RETRY)
 			break;
-		/* Wait some time, then retry request */
-		vt220_request->retry_timer.function = sclp_vt220_retry;
-		vt220_request->retry_timer.data =
-			(unsigned long) vt220_request;
-		vt220_request->retry_timer.expires =
-			jiffies + SCLP_BUFFER_RETRY_INTERVAL*HZ;
-		add_timer(&vt220_request->retry_timer);
-		return;
+		sccb->header.response_code = 0x0000;
+		vt220_request->sclp_req.status = SCLP_REQ_FILLED;
+		if (sclp_add_request(request) == 0)
+			return;
+		break;
 
 	default:
 		break;
@@ -220,22 +197,22 @@
 }
 
 /*
- * Emit vt220 request buffer to SCLP.
+ * Emit vt220 request buffer to SCLP. Return zero on success, non-zero
+ * otherwise.
  */
-static void
+static int
 __sclp_vt220_emit(struct sclp_vt220_request *request)
 {
 	if (!(sclp_vt220_register.sclp_send_mask & EvTyp_VT220Msg_Mask)) {
 		request->sclp_req.status = SCLP_REQ_FAILED;
-		sclp_vt220_callback(&request->sclp_req, (void *) request);
-		return;
+		return -EIO;
 	}
 	request->sclp_req.command = SCLP_CMDW_WRITEDATA;
 	request->sclp_req.status = SCLP_REQ_FILLED;
 	request->sclp_req.callback = sclp_vt220_callback;
 	request->sclp_req.callback_data = (void *) request;
 
-	sclp_add_request(&request->sclp_req);
+	return sclp_add_request(&request->sclp_req);
 }
 
 /*
@@ -253,12 +230,12 @@
 	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
 	/* Emit only the first buffer immediately - callback takes care of
 	 * the rest */
-	if (count == 0)
-		__sclp_vt220_emit(request);
+	if (count == 0 && __sclp_vt220_emit(request))
+		sclp_vt220_process_queue(request);
 }
 
 /*
- * Queue and emit current request.
+ * Queue and emit current request. Return zero on success, non-zero otherwise.
  */
 static void
 sclp_vt220_emit_current(void)
@@ -300,7 +277,6 @@
 	/* Place request structure at end of page */
 	request = ((struct sclp_vt220_request *)
 			((addr_t) page + PAGE_SIZE)) - 1;
-	init_timer(&request->retry_timer);
 	request->retry_count = 0;
 	request->sclp_req.sccb = page;
 	/* SCCB goes at start of page */
