Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSKRTiu>; Mon, 18 Nov 2002 14:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSKRTiR>; Mon, 18 Nov 2002 14:38:17 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:21463 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264743AbSKRTY5> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:57 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (16/16): sclp driver part 2.
Date: Mon, 18 Nov 2002 20:29:23 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182023.47751.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reworked sclp driver part 2.

diff -urN linux-2.5.48/drivers/s390/char/sclp.c linux-2.5.48-s390/drivers/s390/char/sclp.c
--- linux-2.5.48/drivers/s390/char/sclp.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/drivers/s390/char/sclp.c	Mon Nov 18 20:14:52 2002
@@ -0,0 +1,663 @@
+/*
+ *  drivers/s390/char/sclp.c
+ *     core function to access sclp interface
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kmod.h>
+#include <linux/bootmem.h>
+#include <linux/err.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <asm/s390_ext.h>
+
+#include "sclp.h"
+
+#define SCLP_CORE_PRINT_HEADER "sclp low level driver: "
+
+/*
+ * decides wether we make use of the macro MACHINE_IS_VM to
+ * configure the driver for VM at run time (a little bit
+ * different behaviour); otherwise we use the default
+ * settings in sclp_data.init_ioctls
+ */
+#define	 USE_VM_DETECTION
+
+/* Structure for register_early_external_interrupt. */
+static ext_int_info_t ext_int_info_hwc;
+
+/* spinlock to protect global variables of sclp_core */
+static spinlock_t sclp_lock;
+
+/* Mask of valid sclp events */
+static sccb_mask_t sclp_receive_mask;
+static sccb_mask_t sclp_send_mask;
+
+/* List of registered event types */
+static struct list_head sclp_reg_list;
+
+/* sccb queue */
+struct list_head sclp_req_queue;
+
+/* sccb for unconditional read */
+static struct sclp_req sclp_read_req;
+static char sclp_read_sccb[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
+/* sccb for write mask sccb */
+static char sclp_init_sccb[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
+
+static unsigned long sclp_status = 0;
+/* some status flags */
+#define SCLP_INIT		0
+#define SCLP_RUNNING		1
+#define SCLP_READING		2
+
+/*
+ * assembler instruction for Service Call
+ */
+static int
+__service_call(sclp_cmdw_t command, void *sccb)
+{
+	int cc;
+
+	/*
+	 *  Mnemonic:	SERVC	Rx, Ry	[RRE]
+	 *
+	 *  Rx: SCLP command word
+	 *  Ry: address of SCCB
+	 */
+	__asm__ __volatile__(
+		"   .insn rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
+		"   ipm	  %0\n"
+		"   srl	  %0,28"
+		: "=&d" (cc)
+		: "d" (command), "a" (__pa(sccb))
+		: "cc", "memory" );
+	/*
+	 * cc == 0:   Service Call succesful initiated
+	 * cc == 2:   SCLP busy, new Service Call not initiated,
+	 *	      new SCCB unchanged
+	 * cc == 3:   SCLP function not operational
+	 */
+	if (cc == 3)
+		return -EIO;
+	/*
+	 * We set the SCLP_RUNNING bit for cc 2 as well because if
+	 * service_call returns cc 2 some old request is running
+	 * that has to complete first
+	 */
+	set_bit(SCLP_RUNNING, &sclp_status);
+	if (cc == 2)
+		return -EBUSY;
+	return 0;
+}
+
+static int
+__sclp_start_request(void)
+{
+	struct sclp_req *req;
+	int rc;
+
+	/* quick exit if sclp is already in use */
+	if (test_bit(SCLP_RUNNING, &sclp_status))
+		return -EBUSY;
+	/* quick exit if queue is empty */
+	if (list_empty(&sclp_req_queue))
+		return -EINVAL;
+	/* try to start the first request on the request queue. */
+	req = list_entry(sclp_req_queue.next, struct sclp_req, list);
+	rc = __service_call(req->command, req->sccb);
+	switch (rc) {
+	case 0:
+		req->status = SCLP_REQ_RUNNING;
+		break;
+	case -EIO:
+		req->status = SCLP_REQ_FAILED;
+		if (req->callback != NULL)
+			req->callback(req, req->callback_data);
+		break;
+	}
+	return rc;
+}
+
+static int
+sclp_process_evbufs(struct sccb_header *sccb)
+{
+	unsigned long flags;
+	struct evbuf_header *evbuf;
+	struct list_head *l;
+	struct sclp_register *t;
+
+	spin_lock_irqsave(&sclp_lock, flags);
+	evbuf = (struct evbuf_header *) (sccb + 1);
+	while ((void *) evbuf < (void *) sccb + sccb->length) {
+		/* check registered event */
+		list_for_each(l, &sclp_reg_list) {
+			t = list_entry(l, struct sclp_register, list);
+			if (t->receive_mask & (1 << (32 - evbuf->type))) {
+				if (t->receiver_fn != NULL)
+					t->receiver_fn(evbuf);
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	return -ENOSYS;
+}
+
+/*
+ * postprocessing of unconditional read service call
+ */
+static void
+sclp_unconditional_read_cb(struct sclp_req *read_req, void *data)
+{
+	static struct {
+		u16 code; char *msg;
+	} errors[] = {
+		{ 0x0040, "SCLP equipment check" },
+		{ 0x0100, "SCCB boundary violation" },
+		{ 0x01f0, "invalid command" },
+		{ 0x0300, "insufficient SCCB length" },
+		{ 0x40f0, "invalid function code" },
+		{ 0x60f0, "got interrupt but no data found" },
+		{ 0x62f0, "got interrupt but no data found" },
+		{ 0x70f0, "invalid selection mask" }
+	};
+	struct sccb_header *sccb;
+	char *errmsg;
+	int i;
+
+	sccb = read_req->sccb;
+	if (sccb->response_code == 0x0020 ||
+	    sccb->response_code == 0x0220) {
+		/* normal read completion, event buffers stored in sccb */
+		if (sclp_process_evbufs(sccb) == 0) {
+			clear_bit(SCLP_READING, &sclp_status);
+			return;
+		}
+		errmsg = "invalid response code";
+	} else {
+		errmsg = NULL;
+		for (i = 0; i < sizeof(errors)/sizeof(errors[0]); i++)
+			if (sccb->response_code == errors[i].code) {
+				errmsg = errors[i].msg;
+				break;
+			}
+		if (errmsg == NULL)
+			errmsg = "invalid response code";
+	}
+	printk(KERN_WARNING SCLP_CORE_PRINT_HEADER
+	       "unconditional read: %s (response code =0x%x).\n",
+	       errmsg, sccb->response_code);
+	clear_bit(SCLP_READING, &sclp_status);
+}
+
+/*
+ * Function to issue Read Event Data/Unconditional Read
+ */
+static void
+__sclp_unconditional_read(void)
+{
+	struct sccb_header *sccb;
+	struct sclp_req *read_req;
+
+	/*
+	 * Don´t try to initiate Unconditional Read if we are not able to
+	 * receive anything
+	 */
+	if (sclp_receive_mask == 0)
+		return;
+	/* Don't try reading if a read is already outstanding */
+	if (test_and_set_bit(SCLP_READING, &sclp_status))
+		return;
+	/* Initialise read sccb */
+	sccb = (struct sccb_header *) sclp_read_sccb;
+	clear_page(sccb);
+	sccb->length = PAGE_SIZE;
+	sccb->function_code = 0;	/* unconditional read */
+	sccb->control_mask[2] = 0x80;	/* variable length response */
+	/* stick the request structure to the end of the page */
+	read_req = &sclp_read_req;
+	read_req->command = SCLP_CMDW_READDATA;
+	read_req->status = SCLP_REQ_QUEUED;
+	read_req->callback = sclp_unconditional_read_cb;
+	read_req->sccb = sccb;
+	/* Add read request to the head of queue */
+	list_add(&read_req->list, &sclp_req_queue);
+}
+
+/*
+ * Handler for service-signal external interruptions
+ */
+static void
+sclp_interrupt_handler(struct pt_regs *regs, __u16 code)
+{
+	u32 ext_int_param, finished_sccb, evbuf_pending;
+	struct list_head *l;
+	struct sclp_req *req, *tmp;
+	int cpu;
+
+	cpu = smp_processor_id();
+	ext_int_param = S390_lowcore.ext_params;
+	finished_sccb = ext_int_param & -8U;
+	evbuf_pending = ext_int_param & 1;
+	irq_enter();
+	/*
+	 * Only do request callsbacks if sclp is initialised.
+	 * This avoids strange effects for a pending request
+	 * from before the last re-ipl.
+	 */
+	if (test_bit(SCLP_INIT, &sclp_status)) {
+		spin_lock(&sclp_lock);
+		req = NULL;
+		if (finished_sccb != 0U) {
+			list_for_each(l, &sclp_req_queue) {
+				tmp = list_entry(l, struct sclp_req, list);
+				if (finished_sccb == (u32)(addr_t) tmp->sccb) {
+					list_del(&tmp->list);
+					req = tmp;
+					break;
+				}
+			}
+		}
+		spin_unlock(&sclp_lock);
+		if (req != NULL) {
+			req->status = SCLP_REQ_DONE;
+			if (req->callback != NULL)
+				req->callback(req, req->callback_data);
+		}
+	}
+	spin_lock(&sclp_lock);
+	/* Head queue a read sccb if an event buffer is pending */
+	if (evbuf_pending)
+		__sclp_unconditional_read();
+	/* Now clear the running bit */
+	clear_bit(SCLP_RUNNING, &sclp_status);
+	/* and start next request on the queue */
+	__sclp_start_request();
+	spin_unlock(&sclp_lock);
+	irq_exit();
+}
+
+/*
+ * Wait synchronously for external interrupt of sclp. We may not receive
+ * any other external interrupt, so we disable all other external interrupts
+ * in control register 0.
+ */
+void
+sclp_sync_wait(void)
+{
+	unsigned long psw_mask;
+	unsigned long cr0, cr0_sync;
+
+	/*
+	 * save cr0
+	 * enable service signal external interruption (cr0.22)
+	 * disable cr0.20-21, cr0.25, cr0.27, cr0.30-31
+	 * don't touch any other bit in cr0
+	 */
+	__ctl_store(cr0, 0, 0);
+	cr0_sync = cr0;
+	cr0_sync |= 0x00000200;
+	cr0_sync &= 0xFFFFF3AC;
+	__ctl_load(cr0_sync, 0, 0);
+
+	/* enable external interruptions (PSW-mask.7) */
+	asm volatile ("STOSM 0(%1),0x01"
+		      : "=m" (psw_mask) : "a" (&psw_mask) : "memory");
+
+	/* wait until ISR signals receipt of interrupt */
+	while (test_bit(SCLP_RUNNING, &sclp_status))
+		barrier();
+
+	/* disable external interruptions */
+	asm volatile ("SSM 0(%0)"
+		      : : "a" (&psw_mask) : "memory");
+
+	/* restore cr0 */
+	__ctl_load(cr0, 0, 0);
+}
+
+/*
+ * Queue a request to the tail of the ccw_queue. Start the I/O if
+ * possible.
+ */
+void
+sclp_add_request(struct sclp_req *req)
+{
+	unsigned long flags;
+
+	if (!test_bit(SCLP_INIT, &sclp_status))
+		return;
+	spin_lock_irqsave(&sclp_lock, flags);
+	/* queue the request */
+	req->status = SCLP_REQ_QUEUED;
+	list_add_tail(&req->list, &sclp_req_queue);
+	/* try to start the first request on the queue */
+	__sclp_start_request();
+	spin_unlock_irqrestore(&sclp_lock, flags);
+}
+
+/* state change notification */
+struct sclp_statechangebuf {
+	struct evbuf_header	header;
+	u8		validity_sclp_active_facility_mask : 1;
+	u8		validity_sclp_receive_mask : 1;
+	u8		validity_sclp_send_mask : 1;
+	u8		validity_read_data_function_mask : 1;
+	u16		_zeros : 12;
+	u16		mask_length;
+	u64		sclp_active_facility_mask;
+	sccb_mask_t	sclp_receive_mask;
+	sccb_mask_t	sclp_send_mask;
+	u32		read_data_function_mask;
+} __attribute__((packed));
+
+static inline void
+__sclp_notify_state_change(void)
+{
+	struct list_head *l;
+	struct sclp_register *t;
+	sccb_mask_t receive_mask, send_mask;
+
+	list_for_each(l, &sclp_reg_list) {
+		t = list_entry(l, struct sclp_register, list);
+		receive_mask = t->receive_mask & sclp_receive_mask;
+		send_mask = t->send_mask & sclp_send_mask;
+		if (t->sclp_receive_mask != receive_mask ||
+		    t->sclp_send_mask != send_mask) {
+			t->sclp_receive_mask = receive_mask;
+			t->sclp_send_mask = send_mask;
+			if (t->state_change_fn != NULL)
+				t->state_change_fn(t);
+		}
+	}
+}
+
+static void
+sclp_state_change(struct evbuf_header *evbuf)
+{
+	unsigned long flags;
+	struct sclp_statechangebuf *scbuf;
+
+	spin_lock_irqsave(&sclp_lock, flags);
+	scbuf = (struct sclp_statechangebuf *) evbuf;
+
+	if (scbuf->validity_sclp_receive_mask) {
+		if (scbuf->mask_length != 4)
+			printk(KERN_WARNING SCLP_CORE_PRINT_HEADER
+			       "state change event with mask length %i\n",
+			       scbuf->mask_length);
+		else
+			/* set new send mask */
+			sclp_receive_mask = scbuf->sclp_receive_mask;
+	}
+
+	if (scbuf->validity_sclp_send_mask) {
+		if (scbuf->mask_length != 4)
+			printk(KERN_WARNING SCLP_CORE_PRINT_HEADER
+			       "state change event with mask length %i\n",
+			       scbuf->mask_length);
+		else
+			/* set new send mask */
+			sclp_send_mask = scbuf->sclp_send_mask;
+	}
+
+	__sclp_notify_state_change();
+	spin_unlock_irqrestore(&sclp_lock, flags);
+}
+
+struct sclp_register sclp_state_change_event = {
+	.receive_mask = EvTyp_StateChange_Mask,
+	.receiver_fn = sclp_state_change
+};
+
+
+/*
+ * SCLP quiesce event handler
+ */
+#ifdef CONFIG_SMP
+static volatile unsigned long cpu_quiesce_map;
+
+static void
+do_load_quiesce_psw(void * __unused)
+{
+	psw_t quiesce_psw;
+
+	clear_bit(smp_processor_id(), &cpu_quiesce_map);
+	if (smp_processor_id() == 0) {
+		/* Wait for all other cpus to enter do_load_quiesce_psw */
+		while (cpu_quiesce_map != 0);
+		/* Quiesce the last cpu with the special psw */
+		quiesce_psw.mask = PSW_BASE_BITS | PSW_MASK_WAIT;
+		quiesce_psw.addr = 0xfff;
+		__load_psw(quiesce_psw);
+	}
+	signal_processor(smp_processor_id(), sigp_stop);
+}
+
+static void
+do_machine_quiesce(void)
+{
+	cpu_quiesce_map = cpu_online_map;
+	smp_call_function(do_load_quiesce_psw, NULL, 0, 0);
+	do_load_quiesce_psw(NULL);
+}
+#else
+static void
+do_machine_quiesce(void)
+{
+	psw_t quiesce_psw;
+
+	quiesce_psw.mask = _DW_PSW_MASK;
+	queisce_psw.addr = 0xfff;
+	__load_psw(quiesce_psw);
+}
+#endif
+
+extern void ctrl_alt_del(void);
+
+static void
+sclp_quiesce(struct evbuf_header *evbuf)
+{
+	/*
+	 * We got a "shutdown" request.
+	 * Add a call to an appropriate "shutdown" routine here. This
+	 * routine should set all PSWs to 'disabled-wait', 'stopped'
+	 * or 'check-stopped' - except 1 PSW which needs to carry a
+	 * special bit pattern called 'quiesce PSW'.
+	 */
+	_machine_restart = (void *) do_machine_quiesce;
+	_machine_halt = do_machine_quiesce;
+	_machine_power_off = do_machine_quiesce;
+	ctrl_alt_del();
+}
+
+struct sclp_register sclp_quiesce_event = {
+	.receive_mask = EvTyp_SigQuiesce_Mask,
+	.receiver_fn = sclp_quiesce
+};
+
+/* initialisation of SCLP */
+struct init_sccb {
+	struct sccb_header header;
+	u16 _reserved;
+	u16 mask_length;
+	sccb_mask_t receive_mask;
+	sccb_mask_t send_mask;
+	sccb_mask_t sclp_send_mask;
+	sccb_mask_t sclp_receive_mask;
+} __attribute__((packed));
+
+static int
+sclp_init_mask(void)
+{
+	unsigned long flags;
+	struct init_sccb *sccb;
+	struct sclp_req *req;
+	struct list_head *l;
+	struct sclp_register *t;
+	int rc;
+
+	sccb = (struct init_sccb *) sclp_init_sccb;
+	/* stick the request structure to the end of the init sccb page */
+	req = (struct sclp_req *) ((addr_t) sccb + PAGE_SIZE) - 1;
+
+	/* SCLP setup concerning receiving and sending Event Buffers */
+	req->command = SCLP_CMDW_WRITEMASK;
+	req->status = SCLP_REQ_QUEUED;
+	req->callback = NULL;
+	req->sccb = sccb;
+	/* setup sccb for writemask command */
+	memset(sccb, 0, sizeof(struct init_sccb));
+	sccb->header.length = sizeof(struct init_sccb);
+	sccb->mask_length = sizeof(sccb_mask_t);
+	/* copy in the sccb mask of the registered event types */
+	spin_lock_irqsave(&sclp_lock, flags);
+	list_for_each(l, &sclp_reg_list) {
+		t = list_entry(l, struct sclp_register, list);
+		sccb->receive_mask |= t->receive_mask;
+		sccb->send_mask |= t->send_mask;
+	}
+	sccb->sclp_receive_mask = 0;
+	sccb->sclp_send_mask = 0;
+	if (test_bit(SCLP_INIT, &sclp_status)) {
+		/* add request to sclp queue */
+		list_add_tail(&req->list, &sclp_req_queue);
+		/* and start if SCLP is idle */
+		if (!test_bit(SCLP_RUNNING, &sclp_status))
+			__sclp_start_request();
+		spin_unlock_irqrestore(&sclp_lock, flags);
+		/* now wait for completion */
+		while (req->status != SCLP_REQ_DONE &&
+		       req->status != SCLP_REQ_FAILED)
+			sclp_sync_wait();
+		spin_lock_irqsave(&sclp_lock, flags);
+	} else {
+		/*
+		 * Special case for the very first write mask command.
+		 * The interrupt handler is not removing request from
+		 * the request queue and doesn't call callbacks yet
+		 * because there might be an pending old interrupt
+		 * after a Re-IPL. We have to receive and ignore it.
+		 */
+		do {
+			rc = __service_call(req->command, req->sccb);
+			spin_unlock_irqrestore(&sclp_lock, flags);
+			if (rc == -EIO)
+				return -ENOSYS;
+			sclp_sync_wait();
+			spin_lock_irqsave(&sclp_lock, flags);
+		} while (rc == -EBUSY);
+	}
+	sclp_receive_mask = sccb->sclp_receive_mask;
+	sclp_send_mask = sccb->sclp_send_mask;
+	__sclp_notify_state_change();
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	return 0;
+}
+
+/*
+ * sclp setup function. Called early (no kmalloc!) from sclp_console_init().
+ */
+static int
+sclp_init(void)
+{
+	int rc;
+
+	if (test_bit(SCLP_INIT, &sclp_status))
+		/* Already initialised. */
+		return 0;
+
+	/*
+	 * request the 0x2401 external interrupt
+	 * The sclp driver is initialized early (before kmalloc works). We
+	 * need to use register_early_external_interrupt.
+	 */
+	if (register_early_external_interrupt(0x2401, sclp_interrupt_handler,
+					      &ext_int_info_hwc) != 0)
+		return -EBUSY;
+
+	spin_lock_init(&sclp_lock);
+	INIT_LIST_HEAD(&sclp_req_queue);
+
+	/* init event list */
+	INIT_LIST_HEAD(&sclp_reg_list);
+	list_add(&sclp_state_change_event.list, &sclp_reg_list);
+	list_add(&sclp_quiesce_event.list, &sclp_reg_list);
+
+	/* enable service-signal external interruptions,
+	 * Control Register 0 bit 22 := 1
+	 * (besides PSW bit 7 must be set to 1 sometimes for external
+	 * interruptions)
+	 */
+	ctl_set_bit(0, 9);
+
+	/* do the initial write event mask */
+	rc = sclp_init_mask();
+	if (rc == 0) {
+		/* Ok, now everything is setup right. */
+		set_bit(SCLP_INIT, &sclp_status);
+		return 0;
+	}
+
+	/* The sclp_init_mask failed. SCLP is broken, unregister and exit. */
+	ctl_clear_bit(0,9);
+	unregister_early_external_interrupt(0x2401, sclp_interrupt_handler,
+					    &ext_int_info_hwc);
+
+	return rc;
+}
+
+int
+sclp_register(struct sclp_register *reg)
+{
+	unsigned long flags;
+	struct list_head *l;
+	struct sclp_register *t;
+
+	if (!MACHINE_HAS_SCLP)
+		return -ENODEV;
+
+	if (!test_bit(SCLP_INIT, &sclp_status))
+		sclp_init();
+	spin_lock_irqsave(&sclp_lock, flags);
+	/* check already registered event masks for collisions */
+	list_for_each(l, &sclp_reg_list) {
+		t = list_entry(l, struct sclp_register, list);
+		if (t->receive_mask & reg->receive_mask ||
+		    t->send_mask & reg->send_mask) {
+			spin_unlock_irqrestore(&sclp_lock, flags);
+			return -EBUSY;
+		}
+	}
+	/*
+	 * set present mask to 0 to trigger state change
+	 * callback in sclp_init_mask
+	 */
+	reg->sclp_receive_mask = 0;
+	reg->sclp_send_mask = 0;
+	list_add(&reg->list, &sclp_reg_list);
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	sclp_init_mask();
+	return 0;
+}
+
+void
+sclp_unregister(struct sclp_register *reg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sclp_lock, flags);
+	list_del(&reg->list);
+	spin_unlock_irqrestore(&sclp_lock, flags);
+	sclp_init_mask();
+}
+
diff -urN linux-2.5.48/drivers/s390/char/sclp.h linux-2.5.48-s390/drivers/s390/char/sclp.h
--- linux-2.5.48/drivers/s390/char/sclp.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/drivers/s390/char/sclp.h	Mon Nov 18 20:14:52 2002
@@ -0,0 +1,157 @@
+/*
+ *  drivers/s390/char/sclp.h
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#ifndef __SCLP_H__
+#define __SCLP_H__
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+#include <asm/ebcdic.h>
+
+/* maximum number of pages concerning our own memory management */
+#define MAX_KMEM_PAGES (sizeof(unsigned long) << 3)
+#define MAX_CONSOLE_PAGES	4
+
+#define EvTyp_OpCmd		0x01
+#define EvTyp_Msg		0x02
+#define EvTyp_StateChange	0x08
+#define EvTyp_PMsgCmd		0x09
+#define EvTyp_CntlProgOpCmd	0x20
+#define EvTyp_CntlProgIdent	0x0B
+#define EvTyp_SigQuiesce	0x1D
+
+#define EvTyp_OpCmd_Mask	0x80000000
+#define EvTyp_Msg_Mask		0x40000000
+#define EvTyp_StateChange_Mask	0x01000000
+#define EvTyp_PMsgCmd_Mask	0x00800000
+#define EvTyp_CtlProgOpCmd_Mask	0x00000001
+#define EvTyp_CtlProgIdent_Mask	0x00200000
+#define EvTyp_SigQuiesce_Mask	0x00000008
+
+#define GnrlMsgFlgs_DOM		0x8000
+#define GnrlMsgFlgs_SndAlrm	0x4000
+#define GnrlMsgFlgs_HoldMsg	0x2000
+
+#define LnTpFlgs_CntlText	0x8000
+#define LnTpFlgs_LabelText	0x4000
+#define LnTpFlgs_DataText	0x2000
+#define LnTpFlgs_EndText	0x1000
+#define LnTpFlgs_PromptText	0x0800
+
+#define SCLP_COMMAND_INITIATED	0
+#define SCLP_BUSY		2
+#define SCLP_NOT_OPERATIONAL	3
+
+typedef unsigned int sclp_cmdw_t;
+
+#define SCLP_CMDW_READDATA	0x00770005
+#define SCLP_CMDW_WRITEDATA	0x00760005
+#define SCLP_CMDW_WRITEMASK	0x00780005
+
+#define GDS_ID_MDSMU		0x1310
+#define GDS_ID_MDSRouteInfo	0x1311
+#define GDS_ID_AgUnWrkCorr	0x1549
+#define GDS_ID_SNACondReport	0x1532
+#define GDS_ID_CPMSU		0x1212
+#define GDS_ID_RoutTargInstr	0x154D
+#define GDS_ID_OpReq		0x8070
+#define GDS_ID_TextCmd		0x1320
+
+#define GDS_KEY_SelfDefTextMsg	0x31
+
+typedef u32 sccb_mask_t;	/* ATTENTION: assumes 32bit mask !!! */
+
+struct sccb_header {
+	u16	length;
+	u8	function_code;
+	u8	control_mask[3];
+	u16	response_code;
+} __attribute__((packed));
+
+struct gds_subvector {
+	u8	length;
+	u8	key;
+} __attribute__((packed));
+
+struct gds_vector {
+	u16	length;
+	u16	gds_id;
+} __attribute__((packed));
+
+struct evbuf_header {
+	u16	length;
+	u8	type;
+	u8	flags;
+	u16	_reserved;
+} __attribute__((packed));
+
+struct sclp_req {
+	struct list_head list;		/* list_head for request queueing. */
+	sclp_cmdw_t command;		/* sclp command to execute */
+	void	*sccb;			/* pointer to the sccb to execute */
+	char	status;			/* status of this request */
+	/* Callback that is called after reaching final status. */
+	void (*callback)(struct sclp_req *, void *data);
+	void *callback_data;
+};
+
+#define SCLP_REQ_FILLED	  0x00	/* request is ready to be processed */
+#define SCLP_REQ_QUEUED	  0x01	/* request is queued to be processed */
+#define SCLP_REQ_RUNNING  0x02	/* request is currently running */
+#define SCLP_REQ_DONE	  0x03	/* request is completed successfully */
+#define SCLP_REQ_FAILED	  0x05	/* request is finally failed */
+
+/* function pointers that a high level driver has to use for registration */
+/* of some routines it wants to be called from the low level driver */
+struct sclp_register {
+	struct list_head list;
+	/* event masks this user is registered for */
+	sccb_mask_t receive_mask;
+	sccb_mask_t send_mask;
+	/* actually present events */
+	sccb_mask_t sclp_receive_mask;
+	sccb_mask_t sclp_send_mask;
+	/* called if event type availability changes */
+	void (*state_change_fn)(struct sclp_register *);
+	/* called for events in cp_receive_mask/sclp_receive_mask */
+	void (*receiver_fn)(struct evbuf_header *);
+};
+
+/* externals from sclp.c */
+void sclp_add_request(struct sclp_req *req);
+void sclp_sync_wait(void);
+int sclp_register(struct sclp_register *reg);
+void sclp_unregister(struct sclp_register *reg);
+
+/* useful inlines */
+
+/* VM uses EBCDIC 037, LPAR+native(SE+HMC) use EBCDIC 500 */
+/* translate single character from ASCII to EBCDIC */
+static inline unsigned char
+sclp_ascebc(unsigned char ch)
+{
+	return (MACHINE_IS_VM) ? _ascebc[ch] : _ascebc_500[ch];
+}
+
+/* translate string from EBCDIC to ASCII */
+static inline void
+sclp_ebcasc_str(unsigned char *str, int nr)
+{
+	(MACHINE_IS_VM) ? EBCASC(str, nr) : EBCASC_500(str, nr);
+}
+
+/* translate string from ASCII to EBCDIC */
+static inline void
+sclp_ascebc_str(unsigned char *str, int nr)
+{
+	(MACHINE_IS_VM) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
+}
+
+#endif	 /* __SCLP_H__ */
diff -urN linux-2.5.48/drivers/s390/char/sclp_con.c linux-2.5.48-s390/drivers/s390/char/sclp_con.c
--- linux-2.5.48/drivers/s390/char/sclp_con.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/drivers/s390/char/sclp_con.c	Mon Nov 18 20:14:52 2002
@@ -0,0 +1,237 @@
+/*
+ *  drivers/s390/char/sclp_con.c
+ *    SCLP line mode console driver
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kmod.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/bootmem.h>
+
+#include "sclp.h"
+#include "sclp_rw.h"
+
+#define SCLP_CON_PRINT_HEADER "sclp console driver: "
+
+#define sclp_console_major 4		/* TTYAUX_MAJOR */
+#define sclp_console_minor 64
+#define sclp_console_name  "console"
+
+/* Lock to guard over changes to global variables */
+static spinlock_t sclp_con_lock;
+/* List of free pages that can be used for console output buffering */
+static struct list_head sclp_con_pages;
+/* List of full struct sclp_buffer structures ready for output */
+static struct list_head sclp_con_outqueue;
+/* Counter how many buffers are emitted (max 1) and how many */
+/* are on the output queue. */
+static int sclp_con_buffer_count;
+/* Pointer to current console buffer */
+static struct sclp_buffer *sclp_conbuf;
+/* Timer for delayed output of console messages */
+static struct timer_list sclp_con_timer;
+
+/* Output format for console messages */
+static unsigned short sclp_con_columns;
+static unsigned short sclp_con_width_htab;
+
+static void
+sclp_conbuf_callback(struct sclp_buffer *buffer, int rc)
+{
+	unsigned long flags;
+	struct sclp_buffer *next;
+	void *page;
+
+	/* FIXME: what if rc != 0x0020 */
+	page = sclp_unmake_buffer(buffer);
+	spin_lock_irqsave(&sclp_con_lock, flags);
+	list_add_tail((struct list_head *) page, &sclp_con_pages);
+	sclp_con_buffer_count--;
+	/* Remove buffer from outqueue */
+	list_del(&buffer->list);
+	/* Check if there is a pending buffer on the out queue. */
+	next = NULL;
+	if (!list_empty(&sclp_con_outqueue))
+		next = list_entry(sclp_con_outqueue.next,
+				  struct sclp_buffer, list);
+	spin_unlock_irqrestore(&sclp_con_lock, flags);
+	if (next != NULL)
+		sclp_emit_buffer(next, sclp_conbuf_callback);
+}
+
+static inline void
+__sclp_conbuf_emit(struct sclp_buffer *buffer)
+{
+	list_add_tail(&buffer->list, &sclp_con_outqueue);
+	if (sclp_con_buffer_count++ == 0)
+		sclp_emit_buffer(buffer, sclp_conbuf_callback);
+}
+
+/*
+ * When this routine is called from the timer then we flush the
+ * temporary write buffer without further waiting on a final new line.
+ */
+static void
+sclp_console_timeout(unsigned long data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sclp_con_lock, flags);
+	if (sclp_conbuf != NULL) {
+		__sclp_conbuf_emit(sclp_conbuf);
+		sclp_conbuf = NULL;
+	}
+	spin_unlock_irqrestore(&sclp_con_lock, flags);
+}
+
+/*
+ * Writes the given message to S390 system console
+ */
+void
+sclp_console_write(struct console *console, const char *message,
+		   unsigned int count)
+{
+	unsigned long flags;
+	void *page;
+	int written;
+
+	if (count <= 0)
+		return;
+	spin_lock_irqsave(&sclp_con_lock, flags);
+	/*
+	 * process escape characters, write message into buffer,
+	 * send buffer to SCLP
+	 */
+	do {
+		/* make sure we have a console output buffer */
+		if (sclp_conbuf == NULL) {
+			while (list_empty(&sclp_con_pages)) {
+				spin_unlock_irqrestore(&sclp_con_lock, flags);
+				sclp_sync_wait();
+				spin_lock_irqsave(&sclp_con_lock, flags);
+			}
+			page = sclp_con_pages.next;
+			list_del((struct list_head *) page);
+			sclp_conbuf = sclp_make_buffer(page, sclp_con_columns,
+						       sclp_con_width_htab);
+		}
+		/* try to write the string to the current output buffer */
+		written = sclp_write(sclp_conbuf, message, count, 0);
+		if (written == -EFAULT || written == count)
+			break;
+		/*
+		 * Not all characters could be written to the current
+		 * output buffer. Emit the buffer, create a new buffer
+		 * and then output the rest of the string.
+		 */
+		__sclp_conbuf_emit(sclp_conbuf);
+		sclp_conbuf = NULL;
+		message += written;
+		count -= written;
+	} while (count > 0);
+	/* Setup timer to output current console buffer after 1/10 second */
+	if (sclp_conbuf != NULL && !timer_pending(&sclp_con_timer)) {
+		init_timer(&sclp_con_timer);
+		sclp_con_timer.function = sclp_console_timeout;
+		sclp_con_timer.data = 0UL;
+		sclp_con_timer.expires = jiffies + HZ/10;
+		add_timer(&sclp_con_timer);
+	}
+	spin_unlock_irqrestore(&sclp_con_lock, flags);
+}
+
+/* returns the device number of the SCLP console */
+kdev_t
+sclp_console_device(struct console *c)
+{
+	return	mk_kdev(sclp_console_major, sclp_console_minor);
+}
+
+/*
+ * This routine is called from panic when the kernel
+ * is going to give up. We have to make sure that all buffers
+ * will be flushed to the SCLP.
+ */
+void
+sclp_console_unblank(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sclp_con_lock, flags);
+	if (timer_pending(&sclp_con_timer))
+		del_timer(&sclp_con_timer);
+	if (sclp_conbuf != NULL) {
+		__sclp_conbuf_emit(sclp_conbuf);
+		sclp_conbuf = NULL;
+	}
+	while (sclp_con_buffer_count > 0) {
+		spin_unlock_irqrestore(&sclp_con_lock, flags);
+		sclp_sync_wait();
+		spin_lock_irqsave(&sclp_con_lock, flags);
+	}
+	spin_unlock_irqrestore(&sclp_con_lock, flags);
+}
+
+/*
+ * used to register the SCLP console to the kernel and to
+ * give printk necessary information
+ */
+struct console sclp_console =
+{
+	.name = sclp_console_name,
+	.write = sclp_console_write,
+	.device = sclp_console_device,
+	.unblank = sclp_console_unblank,
+	.flags = CON_PRINTBUFFER
+};
+
+/*
+ * called by console_init() in drivers/char/tty_io.c at boot-time.
+ */
+void __init
+sclp_console_init(void)
+{
+	void *page;
+	int i;
+
+	if (!CONSOLE_IS_SCLP)
+		return;
+	if (sclp_rw_init() != 0)
+		return;
+	/* Allocate pages for output buffering */
+	INIT_LIST_HEAD(&sclp_con_pages);
+	for (i = 0; i < MAX_CONSOLE_PAGES; i++) {
+		page = alloc_bootmem_low_pages(PAGE_SIZE);
+		if (page == NULL)
+			return;
+		list_add_tail((struct list_head *) page, &sclp_con_pages);
+	}
+	INIT_LIST_HEAD(&sclp_con_outqueue);
+	spin_lock_init(&sclp_con_lock);
+	sclp_con_buffer_count = 0;
+	sclp_conbuf = NULL;
+	init_timer(&sclp_con_timer);
+
+	/* Set output format */
+	if (MACHINE_IS_VM)
+		/*
+		 * save 4 characters for the CPU number
+		 * written at start of each line by VM/CP
+		 */
+		sclp_con_columns = 76;
+	else
+		sclp_con_columns = 80;
+	sclp_con_width_htab = 8;
+
+	/* enable printk´s access to this driver */
+	register_console(&sclp_console);
+}
diff -urN linux-2.5.48/drivers/s390/char/sclp_cpi.c linux-2.5.48-s390/drivers/s390/char/sclp_cpi.c
--- linux-2.5.48/drivers/s390/char/sclp_cpi.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/drivers/s390/char/sclp_cpi.c	Mon Nov 18 20:14:52 2002
@@ -0,0 +1,243 @@
+/*
+ * Author: Martin Peschke <mpeschke@de.ibm.com>
+ * Copyright (C) 2001 IBM Entwicklung GmbH, IBM Corporation
+ *
+ * SCLP Control-Program Identification.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kmod.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <asm/ebcdic.h>
+#include <asm/semaphore.h>
+
+#include "sclp.h"
+#include "sclp_rw.h"
+
+#define CPI_LENGTH_SYSTEM_TYPE	8
+#define CPI_LENGTH_SYSTEM_NAME	8
+#define CPI_LENGTH_SYSPLEX_NAME	8
+
+struct cpi_evbuf {
+	struct evbuf_header header;
+	u8	id_format;
+	u8	reserved0;
+	u8	system_type[CPI_LENGTH_SYSTEM_TYPE];
+	u64	reserved1;
+	u8	system_name[CPI_LENGTH_SYSTEM_NAME];
+	u64	reserved2;
+	u64	system_level;
+	u64	reserved3;
+	u8	sysplex_name[CPI_LENGTH_SYSPLEX_NAME];
+	u8	reserved4[16];
+} __attribute__((packed));
+
+struct cpi_sccb {
+	struct sccb_header header;
+	struct cpi_evbuf cpi_evbuf;
+} __attribute__((packed));
+
+/* Event type structure for write message and write priority message */
+static struct sclp_register sclp_cpi_event =
+{
+	.send_mask = EvTyp_CtlProgIdent_Mask
+};
+
+MODULE_AUTHOR(
+	"Martin Peschke, IBM Deutschland Entwicklung GmbH "
+	"<mpeschke@de.ibm.com>");
+
+MODULE_DESCRIPTION(
+	"identify this operating system instance to the S/390 "
+	"or zSeries hardware");
+
+static char *system_name = NULL;
+MODULE_PARM(system_name, "s");
+MODULE_PARM_DESC(system_name, "e.g. hostname - max. 8 characters");
+
+static char *sysplex_name = NULL;
+#ifdef ALLOW_SYSPLEX_NAME
+MODULE_PARM(sysplex_name, "s");
+MODULE_PARM_DESC(sysplex_name, "if applicable - max. 8 characters");
+#endif
+
+/* use default value for this field (as well as for system level) */
+static char *system_type = "LINUX";
+
+static int
+cpi_check_parms(void)
+{
+	/* reject if no system type specified */
+	if (!system_type) {
+		printk("cpi: bug: no system type specified\n");
+		return -EINVAL;
+	}
+
+	/* reject if system type larger than 8 characters */
+	if (strlen(system_type) > CPI_LENGTH_SYSTEM_NAME) {
+		printk("cpi: bug: system type has length of %li characters - "
+		       "only %i characters supported\n",
+		       strlen(system_type), CPI_LENGTH_SYSTEM_TYPE);
+		return -EINVAL;
+	}
+
+	/* reject if no system name specified */
+	if (!system_name) {
+		printk("cpi: no system name specified\n");
+		return -EINVAL;
+	}
+
+	/* reject if system name larger than 8 characters */
+	if (strlen(system_name) > CPI_LENGTH_SYSTEM_NAME) {
+		printk("cpi: system name has length of %li characters - "
+		       "only %i characters supported\n",
+		       strlen(system_name), CPI_LENGTH_SYSTEM_NAME);
+		return -EINVAL;
+	}
+
+	/* reject if specified sysplex name larger than 8 characters */
+	if (sysplex_name && strlen(sysplex_name) > CPI_LENGTH_SYSPLEX_NAME) {
+		printk("cpi: sysplex name has length of %li characters"
+		       " - only %i characters supported\n",
+		       strlen(sysplex_name), CPI_LENGTH_SYSPLEX_NAME);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void
+cpi_callback(struct sclp_req *req, void *data)
+{
+	struct semaphore *sem;
+
+	sem = (struct semaphore *) data;
+	up(sem);
+}
+
+static struct sclp_req *
+cpi_prepare_req(void)
+{
+	struct sclp_req *req;
+	struct cpi_sccb *sccb;
+	struct cpi_evbuf *evb;
+
+	req = (struct sclp_req *) kmalloc(sizeof(struct sclp_req), GFP_KERNEL);
+	if (req == NULL)
+		return ERR_PTR(-ENOMEM);
+	sccb = (struct cpi_sccb *) get_free_page(GFP_KERNEL);
+	if (sccb == NULL) {
+		kfree(req);
+		return ERR_PTR(-ENOMEM);
+	}
+	memset(sccb, 0, sizeof(struct cpi_sccb));
+
+	/* setup SCCB for Control-Program Identification */
+	sccb->header.length = sizeof(struct cpi_sccb);
+	sccb->cpi_evbuf.header.length = sizeof(struct cpi_evbuf);
+	sccb->cpi_evbuf.header.type = 0x0B;
+	evb = &sccb->cpi_evbuf;
+
+	/* set system type */
+	memset(evb->system_type, ' ', CPI_LENGTH_SYSTEM_TYPE);
+	memcpy(evb->system_type, system_type, strlen(system_type));
+	sclp_ascebc_str(evb->system_type, CPI_LENGTH_SYSTEM_TYPE);
+	EBC_TOUPPER(evb->system_type, CPI_LENGTH_SYSTEM_TYPE);
+
+	/* set system name */
+	memset(evb->system_name, ' ', CPI_LENGTH_SYSTEM_NAME);
+	memcpy(evb->system_name, system_name, strlen(system_name));
+	sclp_ascebc_str(evb->system_name, CPI_LENGTH_SYSTEM_NAME);
+	EBC_TOUPPER(evb->system_name, CPI_LENGTH_SYSTEM_NAME);
+
+	/* set sytem level */
+	evb->system_level = LINUX_VERSION_CODE;
+
+	/* set sysplex name */
+	if (sysplex_name) {
+		memset(evb->sysplex_name, ' ', CPI_LENGTH_SYSPLEX_NAME);
+		memcpy(evb->sysplex_name, sysplex_name, strlen(sysplex_name));
+		sclp_ascebc_str(evb->sysplex_name, CPI_LENGTH_SYSPLEX_NAME);
+		EBC_TOUPPER(evb->sysplex_name, CPI_LENGTH_SYSPLEX_NAME);
+	}
+
+	/* prepare request data structure presented to SCLP driver */
+	req->command = SCLP_CMDW_WRITEDATA;
+	req->sccb = sccb;
+	req->status = SCLP_REQ_FILLED;
+	req->callback = cpi_callback;
+	return req;
+}
+
+static void
+cpi_free_req(struct sclp_req *req)
+{
+	free_page((unsigned long) req->sccb);
+	kfree(req);
+}
+
+static int __init
+cpi_module_init(void)
+{
+	struct semaphore sem;
+	struct sclp_req *req;
+	int rc;
+
+	rc = cpi_check_parms();
+	if (rc)
+		return rc;
+
+	rc = sclp_register(&sclp_cpi_event);
+	if (rc) {
+		/* could not register sclp event. Die. */
+		printk("cpi: could not register to hardware console.\n");
+		return -EINVAL;
+	}
+	if (!(sclp_cpi_event.sclp_send_mask & EvTyp_CtlProgIdent_Mask)) {
+		printk("cpi: no control program identification support\n");
+		sclp_unregister(&sclp_cpi_event);
+		return -ENOTSUPP;
+	}
+
+	req = cpi_prepare_req();
+	if (IS_ERR(req)) {
+		printk("cpi: couldn't allocate request\n");
+		sclp_unregister(&sclp_cpi_event);
+		return PTR_ERR(req);
+	}
+
+	/* Prepare semaphore */
+	sema_init(&sem, 0);
+	req->callback_data = &sem;
+	/* Add request to sclp queue */
+	sclp_add_request(req);
+	/* make "insmod" sleep until callback arrives */
+	down(&sem);
+
+	rc = ((struct cpi_sccb *) req->sccb)->header.response_code;
+	if (rc != 0x0020) {
+		printk("cpi: failed with response code 0x%x\n", rc);
+		rc = -ECOMM;
+	} else
+		rc = 0;
+
+	cpi_free_req(req);
+
+	return rc;
+}
+
+
+static void __exit cpi_module_exit(void)
+{
+}
+
+
+/* declare driver module init/cleanup functions */
+module_init(cpi_module_init);
+module_exit(cpi_module_exit);
+
diff -urN linux-2.5.48/drivers/s390/char/sclp_rw.c linux-2.5.48-s390/drivers/s390/char/sclp_rw.c
--- linux-2.5.48/drivers/s390/char/sclp_rw.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/drivers/s390/char/sclp_rw.c	Mon Nov 18 20:14:52 2002
@@ -0,0 +1,458 @@
+/*
+ *  drivers/s390/char/sclp_rw.c
+ *     driver: reading from and writing to system console on S/390 via SCLP
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kmod.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/ctype.h>
+#include <asm/uaccess.h>
+
+#include "sclp.h"
+#include "sclp_rw.h"
+
+#define SCLP_RW_PRINT_HEADER "sclp low level driver: "
+
+/*
+ * The room for the SCCB (only for writing) is not equal to a pages size
+ * (as it is specified as the maximum size in the the SCLP ducumentation)
+ * because of the additional data structure described above.
+ */
+#define MAX_SCCB_ROOM (PAGE_SIZE - sizeof(struct sclp_buffer))
+
+/* Event type structure for write message and write priority message */
+struct sclp_register sclp_rw_event = {
+	.send_mask = EvTyp_Msg_Mask | EvTyp_PMsgCmd_Mask
+};
+
+/*
+ * Setup a sclp write buffer. Gets a page as input (4K) and returns
+ * a pointer to a struct sclp_buffer structure that is located at the
+ * end of the input page. This reduces the buffer space by a few
+ * bytes but simplifies things.
+ */
+struct sclp_buffer *
+sclp_make_buffer(void *page, unsigned short columns, unsigned short htab)
+{
+	struct sclp_buffer *buffer;
+	struct write_sccb *sccb;
+
+	sccb = (struct write_sccb *) page;
+	/*
+	 * We keep the struct sclp_buffer structure at the end
+	 * of the sccb page.
+	 */
+	buffer = ((struct sclp_buffer *) ((addr_t) sccb + PAGE_SIZE)) - 1;
+	buffer->sccb = sccb;
+	buffer->mto_number = 0;
+	buffer->mto_char_sum = 0;
+	buffer->current_line = NULL;
+	buffer->current_length = 0;
+	buffer->columns = columns;
+	buffer->htab = htab;
+
+	/* initialize sccb */
+	memset(sccb, 0, sizeof(struct write_sccb));
+	sccb->header.length = sizeof(struct write_sccb);
+	sccb->msg_buf.header.length = sizeof(struct msg_buf);
+	sccb->msg_buf.header.type = EvTyp_Msg;
+	sccb->msg_buf.mdb.header.length = sizeof(struct mdb);
+	sccb->msg_buf.mdb.header.type = 1;
+	sccb->msg_buf.mdb.header.tag = 0xD4C4C240;	/* ebcdic "MDB " */
+	sccb->msg_buf.mdb.header.revision_code = 1;
+	sccb->msg_buf.mdb.go.length = sizeof(struct go);
+	sccb->msg_buf.mdb.go.type = 1;
+
+	return buffer;
+}
+
+/*
+ * Return a pointer to the orignal page that has been used to create
+ * the buffer.
+ */
+void *
+sclp_unmake_buffer(struct sclp_buffer *buffer)
+{
+	return buffer->sccb;
+}
+
+/*
+ * Creates a new Message Text Object with enough room for str_len
+ * characters. This function will create a new sccb for buffering
+ * the mto if the current buffer sccb is full. A full buffer sccb
+ * is submitted for output.
+ * Returns a pointer to the start of the string in the mto.
+ */
+static int
+sclp_create_mto(struct sclp_buffer *buffer, int max_len)
+{
+	struct write_sccb *sccb;
+	struct mto *mto;
+	int mto_size;
+
+	/* max size of new Message Text Object including message text  */
+	mto_size = sizeof(struct mto) + max_len;
+
+	/* check if current buffer sccb can contain the mto */
+	sccb = buffer->sccb;
+	if ((MAX_SCCB_ROOM - sccb->header.length) < mto_size)
+		return -ENOMEM;
+
+	/* find address of new message text object */
+	mto = (struct mto *)(((unsigned long) sccb) + sccb->header.length);
+
+	/*
+	 * fill the new Message-Text Object,
+	 * starting behind the former last byte of the SCCB
+	 */
+	memset(mto, 0, sizeof(struct mto));
+	mto->length = sizeof(struct mto);
+	mto->type = 4;	/* message text object */
+	mto->line_type_flags = LnTpFlgs_EndText; /* end text */
+
+	/* set pointer to first byte after struct mto. */
+	buffer->current_line = (char *) (mto + 1);
+	buffer->current_length = 0;
+
+	return 0;
+}
+
+/*
+ * Add the mto created with sclp_create_mto to the buffer sccb using
+ * the str_len parameter as the real length of the string.
+ */
+static void
+sclp_add_mto(struct sclp_buffer *buffer)
+{
+	struct write_sccb *sccb;
+	struct mto *mto;
+	int str_len, mto_size;
+
+	str_len = buffer->current_length;
+	buffer->current_line = NULL;
+	buffer->current_length = 0;
+
+	/* real size of new Message Text Object including message text	*/
+	mto_size = sizeof(struct mto) + str_len;
+
+	/* find address of new message text object */
+	sccb = buffer->sccb;
+	mto = (struct mto *)(((unsigned long) sccb) + sccb->header.length);
+
+	/* set size of message text object */
+	mto->length = mto_size;
+
+	/*
+	 * update values of sizes
+	 * (SCCB, Event(Message) Buffer, Message Data Block)
+	 */
+	sccb->header.length += mto_size;
+	sccb->msg_buf.header.length += mto_size;
+	sccb->msg_buf.mdb.header.length += mto_size;
+
+	/*
+	 * count number of buffered messages (= number of Message Text
+	 * Objects) and number of buffered characters
+	 * for the SCCB currently used for buffering and at all
+	 */
+	buffer->mto_number++;
+	buffer->mto_char_sum += str_len;
+}
+
+void
+sclp_move_current_line(struct sclp_buffer *to, struct sclp_buffer *from)
+{
+	if (from->current_line == NULL)
+		return;
+	if (sclp_create_mto(to, from->columns) != 0)
+		return;
+	if (from->current_length > 0) {
+		memcpy(to->current_line,
+		       from->current_line - from->current_length,
+		       from->current_length);
+		to->current_line += from->current_length;
+		to->current_length = from->current_length;
+	}
+	from->current_line = NULL;
+}
+
+/*
+ * processing of a message including escape characters,
+ * returns number of characters written to the output sccb
+ * ("processed" means that is not guaranteed that the character have already
+ *  been sent to the SCLP but that it will be done at least next time the SCLP
+ *  is not busy)
+ */
+int
+sclp_write(struct sclp_buffer *buffer,
+	   const char *msg, int count, int from_user)
+{
+	int spaces, i_msg;
+	char ch;
+	int rc;
+
+	/*
+	 * parse msg for escape sequences (\t,\v ...) and put formated
+	 * msg into an mto (created by sclp_create_mto).
+	 *
+	 * We have to do this work ourselfs because there is no support for
+	 * these characters on the native machine and only partial support
+	 * under VM (Why does VM interpret \n but the native machine doesn't ?)
+	 *
+	 * Depending on i/o-control setting the message is always written
+	 * immediatly or we wait for a final new line maybe coming with the
+	 * next message. Besides we avoid a buffer overrun by writing its
+	 * content.
+	 *
+	 * RESTRICTIONS:
+	 *
+	 * \r and \b work within one line because we are not able to modify
+	 * previous output that have already been accepted by the SCLP.
+	 *
+	 * \t combined with following \r is not correctly represented because
+	 * \t is expanded to some spaces but \r does not know about a
+	 * previous \t and decreases the current position by one column.
+	 * This is in order to a slim and quick implementation.
+	 */
+	for (i_msg = 0; i_msg < count; i_msg++) {
+		if (from_user) {
+			if (get_user(ch, msg + i_msg) != 0)
+				return -EFAULT;
+		} else
+			ch = msg[i_msg];
+
+		switch (ch) {
+		case '\n':	/* new line, line feed (ASCII)	*/
+			/* check if new mto needs to be created */
+			if (buffer->current_line == NULL) {
+				rc = sclp_create_mto(buffer, 0);
+				if (rc)
+					return i_msg;
+			}
+			sclp_add_mto(buffer);
+			break;
+		case '\a':	/* bell, one for several times	*/
+			/* set SCLP sound alarm bit in General Object */
+			buffer->sccb->msg_buf.mdb.go.general_msg_flags |=
+				GnrlMsgFlgs_SndAlrm;
+			break;
+		case '\t':	/* horizontal tabulator	 */
+			/* check if new mto needs to be created */
+			if (buffer->current_line == NULL) {
+				rc = sclp_create_mto(buffer, buffer->columns);
+				if (rc)
+					return i_msg;
+			}
+			/* "go to (next htab-boundary + 1, same line)" */
+			do {
+				if (buffer->current_length >= buffer->columns)
+					break;
+				/* ok, add a blank */
+				*buffer->current_line++ = 0x40;
+				buffer->current_length++;
+			} while (buffer->current_length % buffer->htab);
+			break;
+		case '\f':	/* form feed  */
+		case '\v':	/* vertical tabulator  */
+			/* "go to (actual column, actual line + 1)" */
+			/* = new line, leading spaces */
+			if (buffer->current_line != NULL) {
+				spaces = buffer->current_length;
+				sclp_add_mto(buffer);
+				rc = sclp_create_mto(buffer, buffer->columns);
+				if (rc)
+					return i_msg;
+				memset(buffer->current_line, 0x40, spaces);
+				buffer->current_line += spaces;
+				buffer->current_length = spaces;
+			} else {
+				/* one an empty line this is the same as \n */
+				rc = sclp_create_mto(buffer, buffer->columns);
+				if (rc)
+					return i_msg;
+				sclp_add_mto(buffer);
+			}
+			break;
+		case '\b':	/* backspace  */
+			/* "go to (actual column - 1, actual line)" */
+			/* decrement counter indicating position, */
+			/* do not remove last character */
+			if (buffer->current_line != NULL &&
+			    buffer->current_length > 0) {
+				buffer->current_length--;
+				buffer->current_line--;
+			}
+			break;
+		case 0x00:	/* end of string  */
+			/* transfer current line to SCCB */
+			if (buffer->current_line != NULL)
+				sclp_add_mto(buffer);
+			/* skip the rest of the message including the 0 byte */
+			i_msg = count;
+			break;
+		default:	/* no escape character	*/
+			/* do not output unprintable characters */
+			if (!isprint(ch))
+				break;
+			/* check if new mto needs to be created */
+			if (buffer->current_line == NULL) {
+				rc = sclp_create_mto(buffer, buffer->columns);
+				if (rc)
+					return i_msg;
+			}
+			*buffer->current_line++ = sclp_ascebc(ch);
+			buffer->current_length++;
+			break;
+		}
+		/* check if current mto is full */
+		if (buffer->current_line != NULL &&
+		    buffer->current_length >= buffer->columns)
+			sclp_add_mto(buffer);
+	}
+
+	/* return number of processed characters */
+	return i_msg;
+}
+
+/*
+ * Return the number of free bytes in the sccb
+ */
+int
+sclp_buffer_space(struct sclp_buffer *buffer)
+{
+	int count;
+
+	count = MAX_SCCB_ROOM - buffer->sccb->header.length;
+	if (buffer->current_line != NULL)
+		count -= sizeof(struct mto) + buffer->current_length;
+	return count;
+}
+
+/*
+ * Return number of characters in buffer
+ */
+int
+sclp_chars_in_buffer(struct sclp_buffer *buffer)
+{
+	int count;
+
+	count = buffer->mto_char_sum;
+	if (buffer->current_line != NULL)
+		count += buffer->current_length;
+	return count;
+}
+
+/*
+ * sets or provides some values that influence the drivers behaviour
+ */
+void
+sclp_set_columns(struct sclp_buffer *buffer, unsigned short columns)
+{
+	buffer->columns = columns;
+	if (buffer->current_line != NULL &&
+	    buffer->current_length > buffer->columns)
+		sclp_add_mto(buffer);
+}
+
+void
+sclp_set_htab(struct sclp_buffer *buffer, unsigned short htab)
+{
+	buffer->htab = htab;
+}
+
+/*
+ * called by sclp_console_init and/or sclp_tty_init
+ */
+int
+sclp_rw_init(void)
+{
+	static int init_done = 0;
+
+	if (init_done)
+		return 0;
+	init_done = 1;
+	return sclp_register(&sclp_rw_event);
+}
+
+/*
+ * second half of Write Event Data-function that has to be done after
+ * interruption indicating completion of Service Call.
+ */
+static void
+sclp_writedata_callback(struct sclp_req *request, void *data)
+{
+	struct sclp_buffer *buffer;
+	struct write_sccb *sccb;
+
+	buffer = (struct sclp_buffer *) data;
+	sccb = buffer->sccb;
+
+	/* FIXME: proper error handling */
+	/* check SCLP response code and choose suitable action	*/
+	switch (sccb->header.response_code) {
+	case 0x0020 :
+		/* normal completion, buffer processed, message(s) sent */
+		break;
+
+	case 0x0340:	/* contained SCLP equipment check */
+	case 0x40F0:	/* function code disabled in SCLP receive mask */
+		break;
+	default:
+		/* sclp_free_sccb(sccb); */
+		printk(KERN_WARNING SCLP_RW_PRINT_HEADER
+		       "write event data failed "
+		       "(response code: 0x%x SCCB address %p).\n",
+		       sccb->header.response_code, sccb);
+		break;
+	}
+	if (buffer->callback != NULL)
+		buffer->callback(buffer, sccb->header.response_code);
+}
+
+/*
+ * Setup the request structure in the struct sclp_buffer to do SCLP Write
+ * Event Data and pass the request to the core SCLP loop.
+ */
+void
+sclp_emit_buffer(struct sclp_buffer *buffer,
+		 void (*callback)(struct sclp_buffer *, int))
+{
+	struct write_sccb *sccb;
+
+	/* add current line if there is one */
+	if (buffer->current_line != NULL)
+		sclp_add_mto(buffer);
+
+	/* Are there messages in the output buffer ? */
+	if (buffer->mto_number <= 0)
+		return;
+
+	sccb = buffer->sccb;
+	if (sclp_rw_event.sclp_send_mask & EvTyp_Msg_Mask)
+		/* Use normal write message */
+		sccb->msg_buf.header.type = EvTyp_Msg;
+	else if (sclp_rw_event.sclp_send_mask & EvTyp_PMsgCmd_Mask)
+		/* Use write priority message */
+		sccb->msg_buf.header.type = EvTyp_PMsgCmd;
+	else {
+		callback(buffer, -ENOSYS);
+		return;
+	}
+	buffer->request.command = SCLP_CMDW_WRITEDATA;
+	buffer->request.status = SCLP_REQ_FILLED;
+	buffer->request.callback = sclp_writedata_callback;
+	buffer->request.callback_data = buffer;
+	buffer->request.sccb = sccb;
+	buffer->callback = callback;
+	sclp_add_request(&buffer->request);
+}
diff -urN linux-2.5.48/drivers/s390/char/sclp_rw.h linux-2.5.48-s390/drivers/s390/char/sclp_rw.h
--- linux-2.5.48/drivers/s390/char/sclp_rw.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/drivers/s390/char/sclp_rw.h	Mon Nov 18 20:14:52 2002
@@ -0,0 +1,94 @@
+/*
+ *  drivers/s390/char/sclp_rw.h
+ *    interface to the SCLP-read/write driver
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#ifndef __SCLP_RW_H__
+#define __SCLP_RW_H__
+
+struct mto {
+	u16 length;
+	u16 type;
+	u16 line_type_flags;
+	u8  alarm_control;
+	u8  _reserved[3];
+} __attribute__((packed));
+
+struct go {
+	u16 length;
+	u16 type;
+	u32 domid;
+	u8  hhmmss_time[8];
+	u8  th_time[3];
+	u8  reserved_0;
+	u8  dddyyyy_date[7];
+	u8  _reserved_1;
+	u16 general_msg_flags;
+	u8  _reserved_2[10];
+	u8  originating_system_name[8];
+	u8  job_guest_name[8];
+} __attribute__((packed));
+
+struct mdb_header {
+	u16 length;
+	u16 type;
+	u32 tag;
+	u32 revision_code;
+} __attribute__((packed));
+
+struct mdb {
+	struct mdb_header header;
+	struct go go;
+} __attribute__((packed));
+
+struct msg_buf {
+	struct evbuf_header header;
+	struct mdb mdb;
+} __attribute__((packed));
+
+struct write_sccb {
+	struct sccb_header header;
+	struct msg_buf msg_buf;
+} __attribute__((packed));
+
+/* The number of empty mto buffers that can be contained in a single sccb. */
+#define NR_EMPTY_MTO_PER_SCCB ((PAGE_SIZE - sizeof(struct sclp_buffer) - \
+			sizeof(struct write_sccb)) / sizeof(struct mto))
+
+/*
+ * data structure for information about list of SCCBs (only for writing),
+ * will be located at the end of a SCCBs page
+ */
+struct sclp_buffer {
+	struct list_head list;		/* list_head for sccb_info chain */
+	struct sclp_req request;
+	struct write_sccb *sccb;
+	char *current_line;
+	int current_length;
+	/* output format settings */
+	unsigned short columns;
+	unsigned short htab;
+	/* statistics about this buffer */
+	unsigned int mto_char_sum;	/* # chars in sccb */
+	unsigned int mto_number;	/* # mtos in sccb */
+	/* Callback that is called after reaching final status. */
+	void (*callback)(struct sclp_buffer *, int);
+};
+
+int sclp_rw_init(void);
+struct sclp_buffer *sclp_make_buffer(void *, unsigned short, unsigned short);
+void *sclp_unmake_buffer(struct sclp_buffer *);
+int sclp_buffer_space(struct sclp_buffer *);
+int sclp_write(struct sclp_buffer *buffer, const char *, int, int);
+void sclp_move_current_line(struct sclp_buffer *, struct sclp_buffer *);
+void sclp_emit_buffer(struct sclp_buffer *,void (*)(struct sclp_buffer *,int));
+void sclp_set_columns(struct sclp_buffer *, unsigned short);
+void sclp_set_htab(struct sclp_buffer *, unsigned short);
+int sclp_chars_in_buffer(struct sclp_buffer *);
+
+#endif	/* __SCLP_RW_H__ */
diff -urN linux-2.5.48/drivers/s390/char/sclp_tty.c linux-2.5.48-s390/drivers/s390/char/sclp_tty.c
--- linux-2.5.48/drivers/s390/char/sclp_tty.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/drivers/s390/char/sclp_tty.c	Mon Nov 18 20:14:52 2002
@@ -0,0 +1,798 @@
+/*
+ *  drivers/s390/char/sclp_tty.c
+ *    SCLP line mode terminal driver.
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kmod.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/slab.h>
+#include <asm/uaccess.h>
+
+#include "ctrlchar.h"
+#include "sclp.h"
+#include "sclp_rw.h"
+#include "sclp_tty.h"
+
+#define SCLP_TTY_PRINT_HEADER "sclp tty driver: "
+
+/*
+ * size of a buffer that collects single characters coming in
+ * via sclp_tty_put_char()
+ */
+#define SCLP_TTY_BUF_SIZE 512
+
+/*
+ * There is excatly one SCLP terminal, so we can keep things simple
+ * and allocate all variables statically.
+ */
+
+/* Lock to guard over changes to global variables. */
+static spinlock_t sclp_tty_lock;
+/* List of free pages that can be used for console output buffering. */
+static struct list_head sclp_tty_pages;
+/* List of full struct sclp_buffer structures ready for output. */
+static struct list_head sclp_tty_outqueue;
+/* Counter how many buffers are emitted. */
+static int sclp_tty_buffer_count;
+/* Pointer to current console buffer. */
+static struct sclp_buffer *sclp_ttybuf;
+/* Timer for delayed output of console messages. */
+static struct timer_list sclp_tty_timer;
+/* Waitqueue to wait for buffers to get empty. */
+static wait_queue_head_t sclp_tty_waitq;
+
+static struct tty_struct *sclp_tty;
+static unsigned char sclp_tty_chars[SCLP_TTY_BUF_SIZE];
+static unsigned short int sclp_tty_chars_count;
+
+static struct tty_driver sclp_tty_driver;
+static struct tty_struct * sclp_tty_table[1];
+static struct termios * sclp_tty_termios[1];
+static struct termios * sclp_tty_termios_locked[1];
+static int sclp_tty_refcount = 0;
+
+extern struct termios  tty_std_termios;
+
+static struct sclp_ioctls sclp_ioctls;
+static struct sclp_ioctls sclp_ioctls_init =
+{
+	8,			/* 1 hor. tab. = 8 spaces */
+	0,			/* no echo of input by this driver */
+	80,			/* 80 characters/line */
+	1,			/* write after 1/10 s without final new line */
+	MAX_KMEM_PAGES,		/* quick fix: avoid __alloc_pages */
+	MAX_KMEM_PAGES,		/* take 32/64 pages from kernel memory, */
+	0,			/* do not convert to lower case */
+	0x6c			/* to seprate upper and lower case */
+				/* ('%' in EBCDIC) */
+};
+
+/* This routine is called whenever we try to open a SCLP terminal. */
+static int
+sclp_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	/* only 1 SCLP terminal supported */
+	if (minor(tty->device) != tty->driver.minor_start)
+		return -ENODEV;
+	sclp_tty = tty;
+	tty->driver_data = NULL;
+	tty->low_latency = 0;
+	return 0;
+}
+
+/* This routine is called when the SCLP terminal is closed. */
+static void
+sclp_tty_close(struct tty_struct *tty, struct file *filp)
+{
+	/* only 1 SCLP terminal supported */
+	if (minor(tty->device) != tty->driver.minor_start)
+		return;
+	if (tty->count > 1)
+		return;
+	sclp_tty = NULL;
+}
+
+/* execute commands to control the i/o behaviour of the SCLP tty at runtime */
+static int
+sclp_tty_ioctl(struct tty_struct *tty, struct file * file,
+	       unsigned int cmd, unsigned long arg)
+{
+	unsigned long flags;
+	unsigned int obuf;
+	int check;
+	int rc;
+
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+	rc = 0;
+	check = 0;
+	switch (cmd) {
+	case TIOCSCLPSHTAB:
+		/* set width of horizontal tab	*/
+		if (get_user(sclp_ioctls.htab, (unsigned short *) arg))
+			rc = -EFAULT;
+		else
+			check = 1;
+		break;
+	case TIOCSCLPGHTAB:
+		/* get width of horizontal tab	*/
+		if (put_user(sclp_ioctls.htab, (unsigned short *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPSECHO:
+		/* enable/disable echo of input */
+		if (get_user(sclp_ioctls.echo, (unsigned char *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPGECHO:
+		/* Is echo of input enabled ?  */
+		if (put_user(sclp_ioctls.echo, (unsigned char *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPSCOLS:
+		/* set number of columns for output  */
+		if (get_user(sclp_ioctls.columns, (unsigned short *) arg))
+			rc = -EFAULT;
+		else
+			check = 1;
+		break;
+	case TIOCSCLPGCOLS:
+		/* get number of columns for output  */
+		if (put_user(sclp_ioctls.columns, (unsigned short *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPSNL:
+		/* enable/disable writing without final new line character  */
+		if (get_user(sclp_ioctls.final_nl, (signed char *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPGNL:
+		/* Is writing without final new line character enabled ?  */
+		if (put_user(sclp_ioctls.final_nl, (signed char *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPSOBUF:
+		/*
+		 * set the maximum buffers size for output, will be rounded
+		 * up to next 4kB boundary and stored as number of SCCBs
+		 * (4kB Buffers) limitation: 256 x 4kB
+		 */
+		if (get_user(obuf, (unsigned int *) arg) == 0) {
+			if (obuf & 0xFFF)
+				sclp_ioctls.max_sccb = (obuf >> 12) + 1;
+			else
+				sclp_ioctls.max_sccb = (obuf >> 12);
+		} else
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPGOBUF:
+		/* get the maximum buffers size for output  */
+		obuf = sclp_ioctls.max_sccb << 12;
+		if (put_user(obuf, (unsigned int *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPGKBUF:
+		/* get the number of buffers got from kernel at startup */
+		if (put_user(sclp_ioctls.kmem_sccb, (unsigned short *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPSCASE:
+		/* enable/disable conversion from upper to lower case */
+		if (get_user(sclp_ioctls.tolower, (unsigned char *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPGCASE:
+		/* Is conversion from upper to lower case of input enabled? */
+		if (put_user(sclp_ioctls.tolower, (unsigned char *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPSDELIM:
+		/*
+		 * set special character used for seperating upper and
+		 * lower case, 0x00 disables this feature
+		 */
+		if (get_user(sclp_ioctls.delim, (unsigned char *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPGDELIM:
+		/*
+		 * get special character used for seperating upper and
+		 * lower case, 0x00 disables this feature
+		 */
+		if (put_user(sclp_ioctls.delim, (unsigned char *) arg))
+			rc = -EFAULT;
+		break;
+	case TIOCSCLPSINIT:
+		/* set initial (default) sclp ioctls  */
+		sclp_ioctls = sclp_ioctls_init;
+		check = 1;
+		break;
+	default:
+		rc = -ENOIOCTLCMD;
+		break;
+	}
+	if (check) {
+		spin_lock_irqsave(&sclp_tty_lock, flags);
+		if (sclp_ttybuf != NULL) {
+			sclp_set_htab(sclp_ttybuf, sclp_ioctls.htab);
+			sclp_set_columns(sclp_ttybuf, sclp_ioctls.columns);
+		}
+		spin_unlock_irqrestore(&sclp_tty_lock, flags);
+	}
+	return rc;
+}
+
+/*
+ * This routine returns the numbers of characters the tty driver
+ * will accept for queuing to be written.  This number is subject
+ * to change as output buffers get emptied, or if the output flow
+ * control is acted. This is not an exact number because not every
+ * character needs the same space in the sccb. The worst case is
+ * a string of newlines. Every newlines creates a new mto which
+ * needs 8 bytes.
+ */
+static int
+sclp_tty_write_room (struct tty_struct *tty)
+{
+	unsigned long flags;
+	struct list_head *l;
+	int count;
+
+	spin_lock_irqsave(&sclp_tty_lock, flags);
+	count = 0;
+	if (sclp_ttybuf != NULL)
+		count = sclp_buffer_space(sclp_ttybuf) / sizeof(struct mto);
+	list_for_each(l, &sclp_tty_pages)
+		count += NR_EMPTY_MTO_PER_SCCB;
+	spin_unlock_irqrestore(&sclp_tty_lock, flags);
+	return count;
+}
+
+static void
+sclp_ttybuf_callback(struct sclp_buffer *buffer, int rc)
+{
+	unsigned long flags;
+	struct sclp_buffer *next;
+	void *page;
+
+	/* FIXME: what if rc != 0x0020 */
+	page = sclp_unmake_buffer(buffer);
+	spin_lock_irqsave(&sclp_tty_lock, flags);
+	list_add_tail((struct list_head *) page, &sclp_tty_pages);
+	sclp_tty_buffer_count--;
+	/* Remove buffer from outqueue */
+	list_del(&buffer->list);
+	/* Check if there is a pending buffer on the out queue. */
+	next = NULL;
+	if (!list_empty(&sclp_tty_outqueue))
+		next = list_entry(sclp_tty_outqueue.next,
+				  struct sclp_buffer, list);
+	spin_unlock_irqrestore(&sclp_tty_lock, flags);
+	if (next != NULL)
+		sclp_emit_buffer(next, sclp_ttybuf_callback);
+	wake_up(&sclp_tty_waitq);
+	/* check if the tty needs a wake up call */
+	if (sclp_tty != NULL) {
+		if ((sclp_tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
+		    sclp_tty->ldisc.write_wakeup)
+			(sclp_tty->ldisc.write_wakeup)(sclp_tty);
+		wake_up_interruptible(&sclp_tty->write_wait);
+	}
+}
+
+static inline void
+__sclp_ttybuf_emit(struct sclp_buffer *buffer)
+{
+	list_add_tail(&buffer->list, &sclp_tty_outqueue);
+	if (sclp_tty_buffer_count++ == 0)
+		sclp_emit_buffer(buffer, sclp_ttybuf_callback);
+}
+
+/*
+ * When this routine is called from the timer then we flush the
+ * temporary write buffer.
+ */
+static void
+sclp_tty_timeout(unsigned long data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sclp_tty_lock, flags);
+	if (sclp_ttybuf != NULL) {
+		__sclp_ttybuf_emit(sclp_ttybuf);
+		sclp_ttybuf = NULL;
+	}
+	spin_unlock_irqrestore(&sclp_tty_lock, flags);
+}
+
+/*
+ * Write a string to the sclp tty.
+ */
+static void
+sclp_tty_write_string(const unsigned char *str, int count, int from_user)
+{
+	unsigned long flags;
+	void *page;
+	int written;
+
+	if (count <= 0)
+		return;
+	spin_lock_irqsave(&sclp_tty_lock, flags);
+	do {
+		/* Create a sclp output buffer if none exists yet */
+		if (sclp_ttybuf == NULL) {
+			while (list_empty(&sclp_tty_pages)) {
+				spin_unlock_irqrestore(&sclp_tty_lock, flags);
+				wait_event(sclp_tty_waitq,
+					   !list_empty(&sclp_tty_pages));
+				spin_lock_irqsave(&sclp_tty_lock, flags);
+			}
+			page = sclp_tty_pages.next;
+			list_del((struct list_head *) page);
+			sclp_ttybuf = sclp_make_buffer(page,
+						       sclp_ioctls.columns,
+						       sclp_ioctls.htab);
+		}
+		/* try to write the string to the current output buffer */
+		written = sclp_write(sclp_ttybuf, str, count, from_user);
+		if (written == -EFAULT || written == count)
+			break;
+		/*
+		 * Not all characters could be written to the current
+		 * output buffer. Emit the buffer, create a new buffer
+		 * and then output the rest of the string.
+		 */
+		__sclp_ttybuf_emit(sclp_ttybuf);
+		sclp_ttybuf = NULL;
+		str += written;
+		count -= written;
+	} while (count > 0);
+	/* Setup timer to output current console buffer after 1/10 second */
+	if (sclp_ioctls.final_nl) {
+		if (sclp_ttybuf != NULL && !timer_pending(&sclp_tty_timer)) {
+			init_timer(&sclp_tty_timer);
+			sclp_tty_timer.function = sclp_tty_timeout;
+			sclp_tty_timer.data = 0UL;
+			sclp_tty_timer.expires = jiffies + HZ/10;
+			add_timer(&sclp_tty_timer);
+		}
+	} else {
+		__sclp_ttybuf_emit(sclp_ttybuf);
+		sclp_ttybuf = NULL;
+	}
+	spin_unlock_irqrestore(&sclp_tty_lock, flags);
+}
+
+/*
+ * This routine is called by the kernel to write a series of characters to the
+ * tty device. The characters may come from user space or kernel space. This
+ * routine will return the number of characters actually accepted for writing.
+ */
+static int
+sclp_tty_write(struct tty_struct *tty, int from_user,
+	       const unsigned char *buf, int count)
+{
+	if (sclp_tty_chars_count > 0) {
+		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
+		sclp_tty_chars_count = 0;
+	}
+	sclp_tty_write_string(buf, count, from_user);
+	return count;
+}
+
+/*
+ * This routine is called by the kernel to write a single character to the tty
+ * device. If the kernel uses this routine, it must call the flush_chars()
+ * routine (if defined) when it is done stuffing characters into the driver.
+ *
+ * Characters provided to sclp_tty_put_char() are buffered by the SCLP driver.
+ * If the given character is a '\n' the contents of the SCLP write buffer
+ * - including previous characters from sclp_tty_put_char() and strings from
+ * sclp_write() without final '\n' - will be written.
+ */
+static void
+sclp_tty_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	sclp_tty_chars[sclp_tty_chars_count++] = ch;
+	if (ch == '\n' || sclp_tty_chars_count >= SCLP_TTY_BUF_SIZE) {
+		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
+		sclp_tty_chars_count = 0;
+	}
+}
+
+/*
+ * This routine is called by the kernel after it has written a series of
+ * characters to the tty device using put_char().
+ */
+static void
+sclp_tty_flush_chars(struct tty_struct *tty)
+{
+	if (sclp_tty_chars_count > 0) {
+		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
+		sclp_tty_chars_count = 0;
+	}
+}
+
+/*
+ * This routine returns the number of characters in the write buffer of the
+ * SCLP driver. The provided number includes all characters that are stored
+ * in the SCCB (will be written next time the SCLP is not busy) as well as
+ * characters in the write buffer (will not be written as long as there is a
+ * final line feed missing).
+ */
+static int
+sclp_tty_chars_in_buffer(struct tty_struct *tty)
+{
+	unsigned long flags;
+	struct list_head *l;
+	struct sclp_buffer *t;
+	int count;
+
+	spin_lock_irqsave(&sclp_tty_lock, flags);
+	count = 0;
+	if (sclp_ttybuf != NULL)
+		count = sclp_chars_in_buffer(sclp_ttybuf);
+	list_for_each(l, &sclp_tty_outqueue) {
+		t = list_entry(l, struct sclp_buffer, list);
+		count += sclp_chars_in_buffer(sclp_ttybuf);
+	}
+	spin_unlock_irqrestore(&sclp_tty_lock, flags);
+	return count;
+}
+
+/*
+ * removes all content from buffers of low level driver
+ */
+static void
+sclp_tty_flush_buffer(struct tty_struct *tty)
+{
+	if (sclp_tty_chars_count > 0) {
+		sclp_tty_write_string(sclp_tty_chars, sclp_tty_chars_count, 0);
+		sclp_tty_chars_count = 0;
+	}
+}
+
+/*
+ * push input to tty
+ */
+void sclp_tty_input(unsigned char* buf, unsigned int count)
+{
+	unsigned int cchar;
+
+	/*
+	 * If this tty driver is currently closed
+	 * then throw the received input away.
+	 */
+	if (sclp_tty == NULL)
+		return;
+	cchar = ctrlchar_handle(buf, count, sclp_tty);
+	switch (cchar & CTRLCHAR_MASK) {
+	case CTRLCHAR_SYSRQ:
+		break;
+	case CTRLCHAR_CTRL:
+		sclp_tty->flip.count++;
+		*sclp_tty->flip.flag_buf_ptr++ = TTY_NORMAL;
+		*sclp_tty->flip.char_buf_ptr++ = cchar;
+		tty_flip_buffer_push(sclp_tty);
+		break;
+	case CTRLCHAR_NONE:
+		/* send (normal) input to line discipline */
+		memcpy(sclp_tty->flip.char_buf_ptr, buf, count);
+		if (count < 2 ||
+		    strncmp (buf + count - 2, "^n", 2) ||
+		    strncmp (buf + count - 2, "\0252n", 2)) {
+			sclp_tty->flip.char_buf_ptr[count] = '\n';
+			count++;
+		} else
+			count -= 2;
+		memset(sclp_tty->flip.flag_buf_ptr, TTY_NORMAL, count);
+		sclp_tty->flip.char_buf_ptr += count;
+		sclp_tty->flip.flag_buf_ptr += count;
+		sclp_tty->flip.count += count;
+		tty_flip_buffer_push(sclp_tty);
+		break;
+	}
+}
+
+/*
+ * get a EBCDIC string in upper/lower case,
+ * find out characters in lower/upper case seperated by a special character,
+ * modifiy original string,
+ * returns length of resulting string
+ */
+static int
+sclp_switch_cases(unsigned char *buf, int count,
+		  unsigned char delim, int tolower)
+{
+	unsigned char *ip, *op;
+	int toggle;
+
+	/* initially changing case is off */
+	toggle = 0;
+	ip = op = buf;
+	while (count-- > 0) {
+		/* compare with special character */
+		if (*ip == delim) {
+			/* followed by another special character? */
+			if (count && ip[1] == delim) {
+				/*
+				 * ... then put a single copy of the special
+				 * character to the output string
+				 */
+				*op++ = *ip++;
+				count--;
+			} else
+				/*
+				 * ... special character follower by a normal
+				 * character toggles the case change behaviour
+				 */
+				toggle = ~toggle;
+			/* skip special character */
+			ip++;
+		} else
+			/* not the special character */
+			if (toggle)
+				/* but case switching is on */
+				if (tolower)
+					/* switch to uppercase */
+					*op++ = _ebc_toupper[(int) *ip++];
+				else
+					/* switch to lowercase */
+					*op++ = _ebc_tolower[(int) *ip++];
+			else
+				/* no case switching, copy the character */
+				*op++ = *ip++;
+	}
+	/* return length of reformatted string. */
+	return op - buf;
+}
+
+static void
+sclp_get_input(char *start, char *end)
+{
+	int count;
+
+	count = end - start;
+	/*
+	 * if set in ioctl convert EBCDIC to lower case
+	 * (modify original input in SCCB)
+	 */
+	if (sclp_ioctls.tolower)
+		EBC_TOLOWER(start, count);
+
+	/*
+	 * if set in ioctl find out characters in lower or upper case
+	 * (depends on current case) seperated by a special character,
+	 * works on EBCDIC
+	 */
+	if (sclp_ioctls.delim)
+		count = sclp_switch_cases(start, count,
+					  sclp_ioctls.delim,
+					  sclp_ioctls.tolower);
+
+	/* convert EBCDIC to ASCII (modify original input in SCCB) */
+	sclp_ebcasc_str(start, count);
+
+	/* if set in ioctl write operators input to console  */
+	if (sclp_ioctls.echo)
+		sclp_tty_write(sclp_tty, 0, start, count);
+
+	/* transfer input to high level driver */
+	sclp_tty_input(start, count);
+}
+
+static inline struct gds_vector *
+find_gds_vector(struct gds_vector *start, struct gds_vector *end, u16 id)
+{
+	struct gds_vector *vec;
+
+	for (vec = start; vec < end; (void *) vec += vec->length)
+		if (vec->gds_id == id)
+			return vec;
+	return NULL;
+}
+
+static inline struct gds_subvector *
+find_gds_subvector(struct gds_subvector *start,
+		   struct gds_subvector *end, u8 key)
+{
+	struct gds_subvector *subvec;
+
+	for (subvec = start; subvec < end; (void *) subvec += subvec->length)
+		if (subvec->key == key)
+			return subvec;
+	return NULL;
+}
+
+static inline void
+sclp_eval_selfdeftextmsg(struct gds_subvector *start,
+			 struct gds_subvector *end)
+{
+	struct gds_subvector *subvec;
+
+	subvec = start;
+	while (subvec < end) {
+		subvec = find_gds_subvector(subvec, end, 0x30);
+		if (!subvec)
+			break;
+		sclp_get_input((void *)(subvec + 1),
+			       (void *) subvec + subvec->length);
+		(void *) subvec += subvec->length;
+	}
+}
+
+static inline void
+sclp_eval_textcmd(struct gds_subvector *start,
+		  struct gds_subvector *end)
+{
+	struct gds_subvector *subvec;
+
+	subvec = start;
+	while (subvec < end) {
+		subvec = find_gds_subvector(subvec, end,
+					    GDS_KEY_SelfDefTextMsg);
+		if (!subvec)
+			break;
+		sclp_eval_selfdeftextmsg((struct gds_subvector *)(subvec + 1),
+					 (void *)subvec + subvec->length);
+		(void *) subvec += subvec->length;
+	}
+}
+
+static inline void
+sclp_eval_cpmsu(struct gds_vector *start, struct gds_vector *end)
+{
+	struct gds_vector *vec;
+
+	vec = start;
+	while (vec < end) {
+		vec = find_gds_vector(vec, end, GDS_ID_TextCmd);
+		if (!vec)
+			break;
+		sclp_eval_textcmd((struct gds_subvector *)(vec + 1),
+				  (void *) vec + vec->length);
+		(void *) vec += vec->length;
+	}
+}
+
+
+static inline void
+sclp_eval_mdsmu(struct gds_vector *start, void *end)
+{
+	struct gds_vector *vec;
+
+	vec = find_gds_vector(start, end, GDS_ID_CPMSU);
+	if (vec)
+		sclp_eval_cpmsu(vec + 1, (void *) vec + vec->length);
+}
+
+static void
+sclp_tty_receiver(struct evbuf_header *evbuf)
+{
+	struct gds_vector *start, *end, *vec;
+
+	start = (struct gds_vector *)(evbuf + 1);
+	end = (void *) evbuf + evbuf->length;
+	vec = find_gds_vector(start, end, GDS_ID_MDSMU);
+	if (vec)
+		sclp_eval_mdsmu(vec + 1, (void *) vec + vec->length);
+}
+
+static void
+sclp_tty_state_change(struct sclp_register *reg)
+{
+}
+
+struct sclp_register sclp_input_event =
+{
+	.receive_mask = EvTyp_OpCmd_Mask | EvTyp_PMsgCmd_Mask,
+	.state_change_fn = sclp_tty_state_change,
+	.receiver_fn = sclp_tty_receiver
+};
+
+void
+sclp_tty_init(void)
+{
+	void *page;
+	int i;
+
+	if (!CONSOLE_IS_SCLP)
+		return;
+	if (sclp_rw_init() != 0)
+		return;
+	/* Allocate pages for output buffering */
+	INIT_LIST_HEAD(&sclp_tty_pages);
+	for (i = 0; i < MAX_KMEM_PAGES; i++) {
+		page = (void *) get_zeroed_page(GFP_KERNEL);
+		if (page == NULL)
+			return;
+		list_add_tail((struct list_head *) page, &sclp_tty_pages);
+	}
+	INIT_LIST_HEAD(&sclp_tty_outqueue);
+	spin_lock_init(&sclp_tty_lock);
+	init_waitqueue_head(&sclp_tty_waitq);
+	init_timer(&sclp_tty_timer);
+	sclp_ttybuf = NULL;
+	sclp_tty_buffer_count = 0;
+	if (MACHINE_IS_VM) {
+		/*
+		 * save 4 characters for the CPU number
+		 * written at start of each line by VM/CP
+		 */
+		sclp_ioctls_init.columns = 76;
+		/* case input lines to lowercase */
+		sclp_ioctls_init.tolower = 1;
+	}
+	sclp_ioctls = sclp_ioctls_init;
+	sclp_tty_chars_count = 0;
+	sclp_tty = NULL;
+
+	if (sclp_register(&sclp_input_event) != 0)
+		return;
+
+	memset (&sclp_tty_driver, 0, sizeof(struct tty_driver));
+	sclp_tty_driver.magic = TTY_DRIVER_MAGIC;
+	sclp_tty_driver.driver_name = "tty_sclp";
+	sclp_tty_driver.name = "ttyS";
+	sclp_tty_driver.name_base = 0;
+	sclp_tty_driver.major = TTY_MAJOR;
+	sclp_tty_driver.minor_start = 64;
+	sclp_tty_driver.num = 1;
+	sclp_tty_driver.type = TTY_DRIVER_TYPE_SYSTEM;
+	sclp_tty_driver.subtype = SYSTEM_TYPE_TTY;
+	sclp_tty_driver.init_termios = tty_std_termios;
+	sclp_tty_driver.init_termios.c_iflag = IGNBRK | IGNPAR;
+	sclp_tty_driver.init_termios.c_oflag = ONLCR | XTABS;
+	sclp_tty_driver.init_termios.c_lflag = ISIG | ECHO;
+	sclp_tty_driver.flags = TTY_DRIVER_REAL_RAW;
+	sclp_tty_driver.refcount = &sclp_tty_refcount;
+	/* sclp_tty_driver.proc_entry ?	 */
+	sclp_tty_driver.table = sclp_tty_table;
+	sclp_tty_driver.termios = sclp_tty_termios;
+	sclp_tty_driver.termios_locked = sclp_tty_termios_locked;
+	sclp_tty_driver.open = sclp_tty_open;
+	sclp_tty_driver.close = sclp_tty_close;
+	sclp_tty_driver.write = sclp_tty_write;
+	sclp_tty_driver.put_char = sclp_tty_put_char;
+	sclp_tty_driver.flush_chars = sclp_tty_flush_chars;
+	sclp_tty_driver.write_room = sclp_tty_write_room;
+	sclp_tty_driver.chars_in_buffer = sclp_tty_chars_in_buffer;
+	sclp_tty_driver.flush_buffer = sclp_tty_flush_buffer;
+	sclp_tty_driver.ioctl = sclp_tty_ioctl;
+	/*
+	 * No need for these function because they would be only called when
+	 * the line discipline is close to full. That means that there must be
+	 * collected nearly 4kB of input data. I suppose it is very difficult
+	 * for the operator to enter lines quickly enough to let overrun the
+	 * line discipline. Besides the n_tty line discipline does not try to
+	 * call such functions if the pointers are set to NULL. Finally I have
+	 * no idea what to do within these function. I can not prevent the
+	 * operator and the SCLP to deliver input. Because of the reasons
+	 * above it seems not worth to implement a buffer mechanism.
+	 */
+	sclp_tty_driver.throttle = NULL;
+	sclp_tty_driver.unthrottle = NULL;
+	sclp_tty_driver.send_xchar = NULL;
+	sclp_tty_driver.set_termios = NULL;
+	sclp_tty_driver.set_ldisc = NULL;
+	sclp_tty_driver.stop = NULL;
+	sclp_tty_driver.start = NULL;
+	sclp_tty_driver.hangup = NULL;
+	sclp_tty_driver.break_ctl = NULL;
+	sclp_tty_driver.wait_until_sent = NULL;
+	sclp_tty_driver.read_proc = NULL;
+	sclp_tty_driver.write_proc = NULL;
+
+	if (tty_register_driver(&sclp_tty_driver))
+		panic("Couldn't register sclp_tty driver\n");
+}
diff -urN linux-2.5.48/drivers/s390/char/sclp_tty.h linux-2.5.48-s390/drivers/s390/char/sclp_tty.h
--- linux-2.5.48/drivers/s390/char/sclp_tty.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.48-s390/drivers/s390/char/sclp_tty.h	Mon Nov 18 20:14:52 2002
@@ -0,0 +1,67 @@
+/*
+ *  drivers/s390/char/sclp_tty.h
+ *    interface to the SCLP-read/write driver
+ *
+ *  S390 version
+ *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Martin Peschke <mpeschke@de.ibm.com>
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ */
+
+#ifndef __SCLP_TTY_H__
+#define __SCLP_TTY_H__
+
+#include <linux/ioctl.h>
+
+/* This is the type of data structures storing sclp ioctl setting. */
+struct sclp_ioctls {
+	unsigned short htab;
+	unsigned char echo;
+	unsigned short columns;
+	signed char final_nl;
+	unsigned short max_sccb;
+	unsigned short kmem_sccb;	/* can´t be modified at run time */
+	unsigned char tolower;
+	unsigned char delim;
+};
+
+/* must be unique, FIXME: must be added in Documentation/ioctl_number.txt */
+#define SCLP_IOCTL_LETTER 'B'
+
+/* set width of horizontal tabulator */
+#define TIOCSCLPSHTAB	_IOW(SCLP_IOCTL_LETTER, 0, unsigned short)
+/* enable/disable echo of input (independent from line discipline) */
+#define TIOCSCLPSECHO	_IOW(SCLP_IOCTL_LETTER, 1, unsigned char)
+/* set number of colums for output */
+#define TIOCSCLPSCOLS	_IOW(SCLP_IOCTL_LETTER, 2, unsigned short)
+/* enable/disable writing without final new line character */
+#define TIOCSCLPSNL	_IOW(SCLP_IOCTL_LETTER, 4, signed char)
+/* set the maximum buffers size for output, rounded up to next 4kB boundary */
+#define TIOCSCLPSOBUF	_IOW(SCLP_IOCTL_LETTER, 5, unsigned short)
+/* set initial (default) sclp ioctls */
+#define TIOCSCLPSINIT	_IO(SCLP_IOCTL_LETTER, 6)
+/* enable/disable conversion from upper to lower case of input */
+#define TIOCSCLPSCASE	_IOW(SCLP_IOCTL_LETTER, 7, unsigned char)
+/* set special character used for seperating upper and lower case, */
+/* 0x00 disables this feature */
+#define TIOCSCLPSDELIM	_IOW(SCLP_IOCTL_LETTER, 9, unsigned char)
+
+/* get width of horizontal tabulator */
+#define TIOCSCLPGHTAB	_IOR(SCLP_IOCTL_LETTER, 10, unsigned short)
+/* Is echo of input enabled ? (independent from line discipline) */
+#define TIOCSCLPGECHO	_IOR(SCLP_IOCTL_LETTER, 11, unsigned char)
+/* get number of colums for output */
+#define TIOCSCLPGCOLS	_IOR(SCLP_IOCTL_LETTER, 12, unsigned short)
+/* Is writing without final new line character enabled ? */
+#define TIOCSCLPGNL	_IOR(SCLP_IOCTL_LETTER, 14, signed char)
+/* get the maximum buffers size for output */
+#define TIOCSCLPGOBUF	_IOR(SCLP_IOCTL_LETTER, 15, unsigned short)
+/* Is conversion from upper to lower case of input enabled ? */
+#define TIOCSCLPGCASE	_IOR(SCLP_IOCTL_LETTER, 17, unsigned char)
+/* get special character used for seperating upper and lower case, */
+/* 0x00 disables this feature */
+#define TIOCSCLPGDELIM	_IOR(SCLP_IOCTL_LETTER, 19, unsigned char)
+/* get the number of buffers/pages got from kernel at startup */
+#define TIOCSCLPGKBUF	_IOR(SCLP_IOCTL_LETTER, 20, unsigned short)
+
+#endif	/* __SCLP_TTY_H__ */

