Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTDNSA0 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTDNSA0 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:00:26 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:31411 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id S263600AbTDNRpf (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:35 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (3/16): common i/o layer update.
Date: Mon, 14 Apr 2003 19:48:16 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141948.16211.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Common i/o layer fixes:
 - Fix for path no operational condition in cio_start.
 - Fix handling of user interruption parameter.
 - Add code to wait for devices in init_ccw_bus_type.
 - Move qdio states out of main cio state machine.
 - Reworked chsc data structures.
 - Add ccw_device_start_timeout.
 - Handle path verification required flag.

diffstat:
 cio/airq.c          |    6 
 cio/airq.h          |    4 
 cio/chsc.c          |  338 ++++++++++++++++-----------
 cio/chsc.h          |   83 ------
 cio/cio.c           |   29 --
 cio/cio.h           |    9 
 cio/css.c           |    8 
 cio/css.h           |    1 
 cio/device.c        |   70 +++++
 cio/device.h        |   10 
 cio/device_fsm.c    |  200 +++++++---------
 cio/device_id.c     |   10 
 cio/device_ops.c    |   98 +++++---
 cio/device_pgid.c   |   27 +-
 cio/device_status.c |    4 
 cio/qdio.c          |  635 ++++++++++++++++++++++++++++------------------------
 cio/qdio.h          |  110 +--------
 cio/requestirq.c    |    6 
 s390mach.c          |   14 -
 19 files changed, 859 insertions(+), 803 deletions(-)

diff -urN linux-2.5.67/drivers/s390/cio/airq.c linux-2.5.67-s390/drivers/s390/cio/airq.c
--- linux-2.5.67/drivers/s390/cio/airq.c	Mon Apr  7 19:32:18 2003
+++ linux-2.5.67-s390/drivers/s390/cio/airq.c	Mon Apr 14 19:11:50 2003
@@ -2,7 +2,7 @@
  *  drivers/s390/cio/airq.c
  *   S/390 common I/O routines -- support for adapter interruptions
  *
- *   $Revision: 1.10 $
+ *   $Revision: 1.11 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -87,14 +87,14 @@
 }
 
 void
-do_adapter_IO (__u32 intparm)
+do_adapter_IO (void)
 {
 	CIO_TRACE_EVENT (4, "doaio");
 
 	spin_lock (&adapter_lock);
 
 	if (adapter_handler)
-		(*adapter_handler) (intparm);
+		(*adapter_handler) ();
 
 	spin_unlock (&adapter_lock);
 
diff -urN linux-2.5.67/drivers/s390/cio/airq.h linux-2.5.67-s390/drivers/s390/cio/airq.h
--- linux-2.5.67/drivers/s390/cio/airq.h	Mon Apr  7 19:32:23 2003
+++ linux-2.5.67-s390/drivers/s390/cio/airq.h	Mon Apr 14 19:11:50 2003
@@ -1,10 +1,10 @@
 #ifndef S390_AINTERRUPT_H
 #define S390_AINTERRUPT_H
 
-typedef	int (*adapter_int_handler_t)(__u32 intparm);
+typedef	int (*adapter_int_handler_t)(void);
 
 extern int s390_register_adapter_interrupt(adapter_int_handler_t handler);
 extern int s390_unregister_adapter_interrupt(adapter_int_handler_t handler);
-extern void do_adapter_IO (__u32 intparm);
+extern void do_adapter_IO (void);
 
 #endif
diff -urN linux-2.5.67/drivers/s390/cio/chsc.c linux-2.5.67-s390/drivers/s390/cio/chsc.c
--- linux-2.5.67/drivers/s390/cio/chsc.c	Mon Apr  7 19:31:43 2003
+++ linux-2.5.67-s390/drivers/s390/cio/chsc.c	Mon Apr 14 19:11:50 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.57 $
+ *   $Revision: 1.67 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -76,53 +76,77 @@
 chsc_get_sch_desc_irq(int irq)
 {
 	int ccode, chpid, j;
+	int ret;
 
-	/* FIXME: chsc_area_sei cannot be on the stack since it needs to
-	 * be page-aligned. Implement proper locking or dynamic
-	 * allocation or prove that this function does not have to be
-	 * reentrant! */
-	static struct ssd_area chsc_area_ssd 
-		__attribute__ ((aligned(PAGE_SIZE)));
-
-	typeof (chsc_area_ssd.response_block)
-		*ssd_res = &chsc_area_ssd.response_block;
-
-	chsc_area_ssd = (struct ssd_area) {
-		.request_block = {
-			.command_code1 = 0x0010,
-			.command_code2 = 0x0004,
-			.f_sch = irq,
-			.l_sch = irq,
-		}
+	struct {
+		struct chsc_header request;
+		u16 reserved1;
+		u16 f_sch;	  /* first subchannel */
+		u16 reserved2;
+		u16 l_sch;	  /* last subchannel */
+		u32 reserved3;
+		struct chsc_header response;
+		u32 reserved4;
+		u8 sch_valid : 1;
+		u8 dev_valid : 1;
+		u8 st	     : 3; /* subchannel type */
+		u8 zeroes    : 3;
+		u8  unit_addr;	  /* unit address */
+		u16 devno;	  /* device number */
+		u8 path_mask;
+		u8 fla_valid_mask;
+		u16 sch;	  /* subchannel */
+		u8 chpid[8];	  /* chpids 0-7 */
+		u16 fla[8];	  /* full link addresses 0-7 */
+	} *ssd_area;
+
+	ssd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!ssd_area) {
+		CIO_CRW_EVENT(0, "No memory for ssd area!\n");
+		return -ENOMEM;
+	}
+
+	ssd_area->request = (struct chsc_header) {
+		.length = 0x0010,
+		.code   = 0x0004,
 	};
 
-	ccode = chsc(&chsc_area_ssd);
+	ssd_area->f_sch = irq;
+	ssd_area->l_sch = irq;
+
+	ccode = chsc(ssd_area);
 	if (ccode > 0) {
 		pr_debug("chsc returned with ccode = %d\n", ccode);
-		if (ccode == 3)
-			return -ENODEV;
-		return -EBUSY;
+		ret = (ccode == 3) ? -ENODEV : -EBUSY;
+		goto out;
 	}
 
-	switch (chsc_area_ssd.response_block.response_code) {
+	switch (ssd_area->response.code) {
 	case 0x0001: /* everything ok */
+		ret = 0;
 		break;
 	case 0x0002:
 		CIO_CRW_EVENT(2, "Invalid command!\n");
 	case 0x0003:
 		CIO_CRW_EVENT(2, "Error in chsc request block!\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	case 0x0004:
 		CIO_CRW_EVENT(2, "Model does not provide ssd\n");
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	default:
 		CIO_CRW_EVENT(2, "Unknown CHSC response %d\n",
-			      chsc_area_ssd.response_block.response_code);
-		return -EIO;
+			      ssd_area->response.code);
+		ret = -EIO;
+		break;
 	}
 
+	if (ret != 0)
+		goto out;
+
 	/*
-	 * ssd_res->st stores the type of the detected
+	 * ssd_area->st stores the type of the detected
 	 * subchannel, with the following definitions:
 	 *
 	 * 0: I/O subchannel:	  All fields have meaning
@@ -135,43 +159,45 @@
 	 *
 	 * Other types are currently undefined.
 	 */
-	if (ssd_res->st > 3) { /* uhm, that looks strange... */
+	if (ssd_area->st > 3) { /* uhm, that looks strange... */
 		CIO_CRW_EVENT(0, "Strange subchannel type %d"
-			      " for sch %x\n", ssd_res->st, irq);
+			      " for sch %x\n", ssd_area->st, irq);
 		/*
 		 * There may have been a new subchannel type defined in the
 		 * time since this code was written; since we don't know which
 		 * fields have meaning and what to do with it we just jump out
 		 */
-		return 0;
+		goto out;
 	} else {
-		const char type[4][8] = {"I/O", "chsc", "message", "ADM"};
+		const char *type[4] = {"I/O", "chsc", "message", "ADM"};
 		CIO_CRW_EVENT(6, "ssd: sch %x is %s subchannel\n",
-			      irq, type[ssd_res->st]);
+			      irq, type[ssd_area->st]);
 		if (ioinfo[irq] == NULL)
 			/* FIXME: we should do device rec. here... */
-			return 0;
+			goto out;
 
 		ioinfo[irq]->ssd_info.valid = 1;
-		ioinfo[irq]->ssd_info.type = ssd_res->st;
+		ioinfo[irq]->ssd_info.type = ssd_area->st;
 	}
 
-	if (ssd_res->st == 0 || ssd_res->st == 2) {
+	if (ssd_area->st == 0 || ssd_area->st == 2) {
 		for (j = 0; j < 8; j++) {
-			if (!((0x80 >> j) & ssd_res->path_mask &
-			      ssd_res->fla_valid_mask))
+			if (!((0x80 >> j) & ssd_area->path_mask &
+			      ssd_area->fla_valid_mask))
 				continue;
-			chpid = ssd_res->chpid[j];
+			chpid = ssd_area->chpid[j];
 			if (chpid
 			    && (!test_and_set_bit (chpid, chpids_known))
 			    && (test_bit (chpid, chpids_logical)))
 				set_bit	 (chpid, chpids);
 
 			ioinfo[irq]->ssd_info.chpid[j] = chpid;
-			ioinfo[irq]->ssd_info.fla[j]   = ssd_res->fla[j];
+			ioinfo[irq]->ssd_info.fla[j]   = ssd_area->fla[j];
 		}
 	}
-	return 0;
+out:
+	free_page ((unsigned long) ssd_area);
+	return ret;
 }
 
 static int
@@ -216,6 +242,7 @@
 s390_subchannel_remove_chpid(struct subchannel *sch, __u8 chpid)
 {
 	int j;
+	int mask;
 
 	for (j = 0; j < 8; j++)
 		if (sch->schib.pmcw.chpid[j] == chpid)
@@ -223,16 +250,68 @@
 	if (j >= 8)
 		return;
 
+	mask = 0x80 >> j;
 	spin_lock(&sch->lock);
 
 	chsc_validate_chpids(sch);
 
-	/* just to be sure... */
-	sch->lpm &= ~(0x80>>j);
+	stsch(sch->irq, &sch->schib);
+	if (sch->vpm == mask) {
+		dev_fsm_event(sch->dev.driver_data, DEV_EVENT_NOTOPER);
+		goto out_unlock;
+	}
+	if ((sch->schib.scsw.actl & (SCSW_ACTL_CLEAR_PEND |
+				     SCSW_ACTL_HALT_PEND |
+				     SCSW_ACTL_START_PEND |
+				     SCSW_ACTL_RESUME_PEND)) &&
+	    (sch->schib.pmcw.lpum == mask)) {
+		int cc = cio_cancel(sch);
+		
+		if (cc == -ENODEV) {
+			dev_fsm_event(sch->dev.driver_data, DEV_EVENT_NOTOPER);
+			goto out_unlock;
+		}
+
+		if (cc == -EINVAL) {
+			struct ccw_device *cdev;
+
+			cc = cio_clear(sch);
+			if (cc == -ENODEV) {
+				dev_fsm_event(sch->dev.driver_data,
+					      DEV_EVENT_NOTOPER);
+				goto out_unlock;
+			}
+			/* Call handler. */
+			cdev = sch->dev.driver_data;
+			cdev->private->state = DEV_STATE_CLEAR_VERIFY;
+			if (cdev->handler)
+				cdev->handler(cdev, cdev->private->intparm,
+					      ERR_PTR(-EIO));
+			goto out_unlock;
+		}
+	} else if ((sch->schib.scsw.actl & SCSW_ACTL_DEVACT) &&
+		   (sch->schib.scsw.actl & SCSW_ACTL_SCHACT) &&
+		   (sch->schib.pmcw.lpum == mask)) {
+		struct ccw_device *cdev;
+		int cc;
+
+		cc = cio_clear(sch);
+		if (cc == -ENODEV) {
+			dev_fsm_event(sch->dev.driver_data, DEV_EVENT_NOTOPER);
+			goto out_unlock;
+		}
+		/* Call handler. */
+		cdev = sch->dev.driver_data;
+		cdev->private->state = DEV_STATE_CLEAR_VERIFY;
+		if (cdev->handler)
+			cdev->handler(cdev, cdev->private->intparm,
+				      ERR_PTR(-EIO));
+		goto out_unlock;
+	}
 
 	/* trigger path verification. */
 	dev_fsm_event(sch->dev.driver_data, DEV_EVENT_VERIFY);
-
+out_unlock:
 	spin_unlock(&sch->lock);
 }
 
@@ -265,7 +344,7 @@
 		sch = ioinfo[irq];
 		if (sch == NULL)
 			continue;  /* we don't know the device anyway */
-		/* FIXME: Kill pending I/O. */
+
 		s390_subchannel_remove_chpid(sch, chpid);
 	}
 #endif
@@ -349,7 +428,7 @@
 	if (!test_bit(chpid, chpids_logical))
 		return; /* no need to do the rest */
 
-	for (irq = 0; irq <= __MAX_SUBCHANNELS; irq++) {
+	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
 		int chp_mask;
 
 		sch = ioinfo[irq];
@@ -369,7 +448,6 @@
 			continue;
 		}
 	
-		/* FIXME: Kill pending I/O. */
 		spin_lock_irq(&sch->lock);
 
 		chp_mask = s390_process_res_acc_sch(chpid, fla, fla_mask, sch);
@@ -402,92 +480,97 @@
 static void
 do_process_crw(void *ignore)
 {
-	int do_sei;
+	struct {
+		struct chsc_header request;
+		u32 reserved1;
+		u32 reserved2;
+		u32 reserved3;
+		struct chsc_header response;
+		u32 reserved4;
+		u8  flags;
+		u8  vf;		/* validity flags */
+		u8  rs;		/* reporting source */
+		u8  cc;		/* content code */
+		u16 fla;	/* full link address */
+		u16 rsid;	/* reporting source id */
+		u32 reserved5;
+		u32 reserved6;
+		u32 ccdf;	/* content-code dependent field */
+		u32 reserved7;
+		u32 reserved8;
+		u32 reserved9;
+	} *sei_area;
 
 	/*
 	 * build the chsc request block for store event information
 	 * and do the call
 	 */
+	sei_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 
-	/* FIXME: chsc_area_sei cannot be on the stack since it needs to
-	 * be page-aligned. Implement proper locking or dynamic
-	 * allocation or prove that this function does not have to be
-	 * reentrant! */
-	static struct sei_area chsc_area_sei
-		__attribute__ ((aligned(PAGE_SIZE))) = {
-			.request_block = {
-				.command_code1 = 0x0010,
-				.command_code2 = 0x000e
-			}
-		};
-
-	typeof (chsc_area_sei.response_block)
-		*sei_res = &chsc_area_sei.response_block;
-
+	if (!sei_area) {
+		CIO_CRW_EVENT(0, "No memory for sei area!\n");
+		return;
+	}
 
 	CIO_TRACE_EVENT( 2, "prcss");
 
-	do_sei = 1;
-
-	while (do_sei) {
+	do {
 		int ccode;
+		memset(sei_area, 0, sizeof(*sei_area));
+
+		sei_area->request = (struct chsc_header) {
+			.length = 0x0010,
+			.code   = 0x000e,
+		};
 
-		ccode = chsc(&chsc_area_sei);
+		ccode = chsc(sei_area);
 		if (ccode > 0)
-			return;
+			goto out;
 
-		switch (sei_res->response_code) {
+		switch (sei_area->response.code) {
 			/* for debug purposes, check for problems */
 		case 0x0001:
+			CIO_CRW_EVENT(4, "chsc_process_crw: event information "
+					"successfully stored\n");
 			break; /* everything ok */
 		case 0x0002:
 			CIO_CRW_EVENT(2,
 				      "chsc_process_crw: invalid command!\n");
-			return;
+			goto out;
 		case 0x0003:
 			CIO_CRW_EVENT(2, "chsc_process_crw: error in chsc "
 				      "request block!\n");
-			return;
+			goto out;
 		case 0x0005:
 			CIO_CRW_EVENT(2, "chsc_process_crw: no event "
 				      "information stored\n");
-			return;
+			goto out;
 		default:
 			CIO_CRW_EVENT(2, "chsc_process_crw: chsc response %d\n",
-				      sei_res->response_code);
-			return;
+				      sei_area->response.code);
+			goto out;
 		}
-		
-		CIO_CRW_EVENT(4, "chsc_process_crw: event information "
-			      "successfully stored\n");
-
-		/* Check if there is more event information pending. */
-		if (sei_res->flags & 0x80)
-			CIO_CRW_EVENT( 2, "chsc_process_crw: "
-				       "further event information pending\n");
-		else
-			do_sei = 0;
 
 		/* Check if we might have lost some information. */
-		if (sei_res->flags & 0x40)
-			CIO_CRW_EVENT( 2, "chsc_process_crw: Event information "
+		if (sei_area->flags & 0x40)
+			CIO_CRW_EVENT(2, "chsc_process_crw: Event information "
 				       "has been lost due to overflow!\n");
 
-		if (sei_res->rs != 4) {
+		if (sei_area->rs != 4) {
 			CIO_CRW_EVENT(2, "chsc_process_crw: reporting source "
 				      "(%04X) isn't a chpid!\n",
-				      sei_res->rsid);
+				      sei_area->rsid);
 			continue;
 		}
-		
+
 		/* which kind of information was stored? */
-		switch (sei_res->cc) {
+		switch (sei_area->cc) {
 		case 1: /* link incident*/
 			CIO_CRW_EVENT(4, "chsc_process_crw: "
 				      "channel subsystem reports link incident,"
-				      " source is chpid %x\n", sei_res->rsid);
+				      " source is chpid %x\n", sei_area->rsid);
 			
-			s390_set_chpid_offline(sei_res->rsid);
+			s390_set_chpid_offline(sei_area->rsid);
 			break;
 			
 		case 2: /* i/o resource accessibiliy */
@@ -495,27 +578,27 @@
 				      "channel subsystem reports some I/O "
 				      "devices may have become accessible\n");
 			pr_debug("Data received after sei: \n");
-			pr_debug("Validity flags: %x\n", sei_res->vf);
+			pr_debug("Validity flags: %x\n", sei_area->vf);
 			
 			/* allocate a new channel path structure, if needed */
-			if (chps[sei_res->rsid] == NULL)
-				new_channel_path(sei_res->rsid, CHP_ONLINE);
+			if (chps[sei_area->rsid] == NULL)
+				new_channel_path(sei_area->rsid, CHP_ONLINE);
 			else
-				set_chp_status(sei_res->rsid, CHP_ONLINE);
+				set_chp_status(sei_area->rsid, CHP_ONLINE);
 			
-			if ((sei_res->vf & 0x80) == 0) {
-				pr_debug("chpid: %x\n", sei_res->rsid);
-				s390_process_res_acc(sei_res->rsid, 0, 0);
-			} else if ((sei_res->vf & 0xc0) == 0x80) {
+			if ((sei_area->vf & 0x80) == 0) {
+				pr_debug("chpid: %x\n", sei_area->rsid);
+				s390_process_res_acc(sei_area->rsid, 0, 0);
+			} else if ((sei_area->vf & 0xc0) == 0x80) {
 				pr_debug("chpid: %x link addr: %x\n",
-					 sei_res->rsid, sei_res->fla);
-				s390_process_res_acc(sei_res->rsid,
-						     sei_res->fla, 0xff00);
-			} else if ((sei_res->vf & 0xc0) == 0xc0) {
+					 sei_area->rsid, sei_area->fla);
+				s390_process_res_acc(sei_area->rsid,
+						     sei_area->fla, 0xff00);
+			} else if ((sei_area->vf & 0xc0) == 0xc0) {
 				pr_debug("chpid: %x full link addr: %x\n",
-					 sei_res->rsid, sei_res->fla);
-				s390_process_res_acc(sei_res->rsid,
-						     sei_res->fla, 0xffff);
+					 sei_area->rsid, sei_area->fla);
+				s390_process_res_acc(sei_area->rsid,
+						     sei_area->fla, 0xffff);
 			}
 			pr_debug("\n");
 			
@@ -523,15 +606,13 @@
 			
 		default: /* other stuff */
 			CIO_CRW_EVENT(4, "chsc_process_crw: event %d\n",
-				      sei_res->cc);
+				      sei_area->cc);
 			break;
 		}
-		if (do_sei) {
-			memset(&chsc_area_sei, 0, sizeof(struct sei_area));
-			chsc_area_sei.request_block.command_code1 = 0x0010;
-			chsc_area_sei.request_block.command_code2 = 0x000e;
-		}
-	}
+	} while (sei_area->flags & 0x80);
+
+out:
+	free_page((unsigned long)sei_area);
 }
 
 void
@@ -539,7 +620,7 @@
 {
 	static DECLARE_WORK(work, do_process_crw, 0);
 
-	schedule_work(&work);
+	queue_work(ccw_device_work, &work);
 }
 
 static void
@@ -555,7 +636,7 @@
 	sprintf(dbf_txt, "cadd%x", chpid);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	for (irq = 0; irq <= __MAX_SUBCHANNELS; irq++) {
+	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
 		int i;
 
 		sch = ioinfo[irq];
@@ -567,7 +648,6 @@
 			continue;
 		}
 	
-		/* FIXME: Kill pending I/O. */
 		spin_lock(&sch->lock);
 		for (i=0; i<8; i++)
 			if (sch->schib.pmcw.chpid[i] == chpid) {
@@ -599,26 +679,9 @@
  * Handling of crw machine checks with channel path source.
  */
 void
-chp_process_crw(int chpid)
+chp_process_crw(int chpid, int on)
 {
-	/*
-	 * Update our descriptions. We need this since we don't always
-	 * get machine checks for path come and can't rely on our information
-	 * being consistent otherwise.
-	 */
-	chsc_get_sch_descriptions();
-	if (!cio_chsc_desc_avail) {
-		/*
-		 * Something went wrong...
-		 * We can't reliably say whether a path was there before.
-		 */
-		CIO_CRW_EVENT(0, "Error: Could not retrieve "
-			      "subchannel descriptions, will not process chp"
-			      "machine check...\n");
-		return;
-	}
-
-	if (!test_bit(chpid, chpids)) {
+	if (on == 0) {
 		/* Path has gone. We use the link incident routine.*/
 		s390_set_chpid_offline(chpid);
 	} else {
@@ -646,9 +709,6 @@
 	struct subchannel *sch;
 	int irq;
 
-	if (chpid <=0 || chpid >= NR_CHPIDS)
-		return -EINVAL;
-
 	sprintf(dbf_text, on?"varyon%x":"varyoff%x", chpid);
 	CIO_TRACE_EVENT( 2, dbf_text);
 
diff -urN linux-2.5.67/drivers/s390/cio/chsc.h linux-2.5.67-s390/drivers/s390/cio/chsc.h
--- linux-2.5.67/drivers/s390/cio/chsc.h	Mon Apr  7 19:32:24 2003
+++ linux-2.5.67-s390/drivers/s390/cio/chsc.h	Mon Apr 14 19:11:50 2003
@@ -12,85 +12,10 @@
 #define CHSC_SEI_ACC_LINKADDR     2
 #define CHSC_SEI_ACC_FULLLINKADDR 3
 
-struct sei_area {
-	struct {
-		/* word 0 */
-		__u16 command_code1;
-		__u16 command_code2;
-		/* word 1 */
-		__u32 reserved1;
-		/* word 2 */
-		__u32 reserved2;
-		/* word 3 */
-		__u32 reserved3;
-	} __attribute__ ((packed,aligned(8))) request_block;
-	struct {
-		/* word 0 */
-		__u16 length;
-		__u16 response_code;
-		/* word 1 */
-		__u32 reserved1;
-		/* word 2 */
-		__u8  flags;
-		__u8  vf;	  /* validity flags */
-		__u8  rs;	  /* reporting source */
-		__u8  cc;	  /* content code */
-		/* word 3 */
-		__u16 fla;	  /* full link address */
-		__u16 rsid;	  /* reporting source id */
-		/* word 4 */
-		__u32 reserved2;
-		/* word 5 */
-		__u32 reserved3;
-		/* word 6 */
-		__u32 ccdf;	  /* content-code dependent field */
-		/* word 7 */
-		__u32 reserved4;
-		/* word 8 */
-		__u32 reserved5;
-		/* word 9 */
-		__u32 reserved6;
-	} __attribute__ ((packed,aligned(8))) response_block;
-} __attribute__ ((packed,aligned(PAGE_SIZE)));
-
-struct ssd_area {
-	struct {
-		/* word 0 */
-		__u16 command_code1;
-		__u16 command_code2;
-		/* word 1 */
-		__u16 reserved1;
-		__u16 f_sch;	 /* first subchannel */
-		/* word 2 */
-		__u16 reserved2;
-		__u16 l_sch;	/* last subchannel */
-		/* word 3 */
-		__u32 reserved3;
-	} __attribute__ ((packed,aligned(8))) request_block;
-	struct {
-		/* word 0 */
-		__u16 length;
-		__u16 response_code;
-		/* word 1 */
-		__u32 reserved1;
-		/* word 2 */
-		__u8 sch_valid : 1;
-		__u8 dev_valid : 1;
-		__u8 st	       : 3; /* subchannel type */
-		__u8 zeroes    : 3;
-		__u8  unit_addr;  /* unit address */
-		__u16 devno;	  /* device number */
-		/* word 3 */
-		__u8 path_mask;
-		__u8 fla_valid_mask;
-		__u16 sch;	  /* subchannel */
-		/* words 4-5 */
-		__u8 chpid[8];	  /* chpids 0-7 */
-		/* words 6-9 */
-		__u16 fla[8];	  /* full link addresses 0-7 */
-	} __attribute__ ((packed,aligned(8))) response_block;
-} __attribute__ ((packed,aligned(PAGE_SIZE)));
-
+struct chsc_header {
+	u16 length;
+	u16 code;
+};
 
 struct channel_path {
 	int id;
diff -urN linux-2.5.67/drivers/s390/cio/cio.c linux-2.5.67-s390/drivers/s390/cio/cio.c
--- linux-2.5.67/drivers/s390/cio/cio.c	Mon Apr  7 19:32:55 2003
+++ linux-2.5.67-s390/drivers/s390/cio/cio.c	Mon Apr 14 19:11:50 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.91 $
+ *   $Revision: 1.97 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -176,13 +176,13 @@
 	CIO_TRACE_EVENT(0, dbf_text);
 	CIO_HEX_EVENT(0, &sch->schib, sizeof (struct schib));
 
-	return -ENODEV;
+	return (sch->lpm ? -EACCES : -ENODEV);
 }
 
 int
 cio_start (struct subchannel *sch,	/* subchannel structure */
 	   struct ccw1 * cpa,		/* logical channel prog addr */
-	   unsigned long intparm,	/* interruption parameter */
+	   unsigned int intparm,	/* interruption parameter */
 	   __u8 lpm)			/* logical path mask */
 {
 	char dbf_txt[15];
@@ -191,7 +191,7 @@
 	sprintf (dbf_txt, "stIO%x", sch->irq);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
-	sch->orb.intparm = (__u32) (long) &sch->u_intparm;
+	sch->orb.intparm = intparm;
 	sch->orb.fmt = 1;
 
 	sch->orb.pfch = sch->options.prefetch == 0;
@@ -219,7 +219,6 @@
 		/*
 		 * initialize device status information
 		 */
-		sch->u_intparm = intparm;
 		sch->schib.scsw.actl |= SCSW_ACTL_START_PEND;
 		return 0;
 	case 1:		/* status pending */
@@ -265,13 +264,10 @@
 }
 
 /*
- * Note: The "intparm" parameter is not used by the halt_IO() function
- *	 itself, as no ORB is built for the HSCH instruction. However,
- *	 it allows the device interrupt handler to associate the upcoming
- *	 interrupt with the halt_IO() request.
+ * halt I/O operation
  */
 int
-cio_halt(struct subchannel *sch, unsigned long intparm)
+cio_halt(struct subchannel *sch)
 {
 	char dbf_txt[15];
 	int ccode;
@@ -297,7 +293,6 @@
 
 	switch (ccode) {
 	case 0:
-		sch->u_intparm = intparm;
 		sch->schib.scsw.actl |= SCSW_ACTL_HALT_PEND;
 		return 0;
 	case 1:		/* status pending */
@@ -309,13 +304,10 @@
 }
 
 /*
- * Note: The "intparm" parameter is not used by the clear_IO() function
- *	 itself, as no ORB is built for the CSCH instruction. However,
- *	 it allows the device interrupt handler to associate the upcoming
- *	 interrupt with the clear_IO() request.
+ * Clear I/O operation
  */
 int
-cio_clear(struct subchannel *sch, unsigned long intparm)
+cio_clear(struct subchannel *sch)
 {
 	char dbf_txt[15];
 	int ccode;
@@ -340,7 +332,6 @@
 
 	switch (ccode) {
 	case 0:
-		sch->u_intparm = intparm;
 		sch->schib.scsw.actl |= SCSW_ACTL_CLEAR_PEND;
 		return 0;
 	default:		/* device not operational */
@@ -374,6 +365,8 @@
 
 	switch (ccode) {
 	case 0:		/* success */
+		/* Update information in scsw. */
+		stsch (sch->irq, &sch->schib);
 		return 0;
 	case 1:		/* status pending */
 		return -EBUSY;
@@ -620,7 +613,7 @@
 		 */
 		if (tpi_info->adapter_IO == 1 &&
 		    tpi_info->int_type == IO_INTERRUPT_TYPE) {
-			do_adapter_IO (tpi_info->intparm);
+			do_adapter_IO();
 			continue;
 		}
 		sch = ioinfo[tpi_info->irq];
diff -urN linux-2.5.67/drivers/s390/cio/cio.h linux-2.5.67-s390/drivers/s390/cio/cio.h
--- linux-2.5.67/drivers/s390/cio/cio.h	Mon Apr  7 19:30:34 2003
+++ linux-2.5.67-s390/drivers/s390/cio/cio.h	Mon Apr 14 19:11:50 2003
@@ -98,8 +98,6 @@
 
 	__u8 vpm;		/* verified path mask */
 	__u8 lpm;		/* logical path mask */
-	// TODO: intparm for second start i/o
-	unsigned long u_intparm;	/* user interruption parameter */
 	struct schib schib;	/* subchannel information block */
 	struct orb orb;		/* operation request block */
 	struct ccw1 sense_ccw;	/* static ccw for sense command */
@@ -116,11 +114,10 @@
 extern int cio_enable_subchannel (struct subchannel *, unsigned int);
 extern int cio_disable_subchannel (struct subchannel *);
 extern int cio_cancel (struct subchannel *);
-extern int cio_clear (struct subchannel *, unsigned long);
-extern int cio_do_io (struct subchannel *, struct ccw1 *, unsigned long, __u8);
+extern int cio_clear (struct subchannel *);
 extern int cio_resume (struct subchannel *);
-extern int cio_halt (struct subchannel *, unsigned long);
-extern int cio_start (struct subchannel *, struct ccw1 *, unsigned long, __u8);
+extern int cio_halt (struct subchannel *);
+extern int cio_start (struct subchannel *, struct ccw1 *, unsigned int, __u8);
 extern int cio_cancel (struct subchannel *);
 extern int cio_set_options (struct subchannel *, int);
 extern int cio_get_options (struct subchannel *);
diff -urN linux-2.5.67/drivers/s390/cio/css.c linux-2.5.67-s390/drivers/s390/cio/css.c
--- linux-2.5.67/drivers/s390/cio/css.c	Mon Apr  7 19:30:43 2003
+++ linux-2.5.67-s390/drivers/s390/cio/css.c	Mon Apr 14 19:11:50 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.40 $
+ *   $Revision: 1.43 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -41,7 +41,7 @@
 		/* There already is a struct subchannel for this irq. */
 		return -EBUSY;
 
-	sch = kmalloc (sizeof (*sch), GFP_DMA);
+	sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);
 	if (sch == NULL)
 		return -ENOMEM;
 	ret = cio_validate_subchannel (sch, irq);
@@ -161,7 +161,7 @@
 
 	sch = ioinfo[irq];
 	if (sch == NULL) {
-		schedule_work(&work);
+		queue_work(ccw_device_work, &work);
 		return;
 	}
 	if (!sch->dev.driver_data)
@@ -172,7 +172,7 @@
 	ccode = stsch(irq, &sch->schib);
 	if (!ccode)
 		if (devno != sch->schib.pmcw.dev)
-			schedule_work(&work);
+			queue_work(ccw_device_work, &work);
 }
 
 /*
diff -urN linux-2.5.67/drivers/s390/cio/css.h linux-2.5.67-s390/drivers/s390/cio/css.h
--- linux-2.5.67/drivers/s390/cio/css.h	Mon Apr  7 19:33:04 2003
+++ linux-2.5.67-s390/drivers/s390/cio/css.h	Mon Apr 14 19:11:50 2003
@@ -79,6 +79,7 @@
 		unsigned int esid:1;        /* Ext. SenseID supported by HW */
 		unsigned int dosense:1;	    /* delayed SENSE required */
 	} __attribute__((packed)) flags;
+	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
 	struct irb irb;		/* device status */
 	struct senseid senseid;	/* SenseID info */
diff -urN linux-2.5.67/drivers/s390/cio/device.c linux-2.5.67-s390/drivers/s390/cio/device.c
--- linux-2.5.67/drivers/s390/cio/device.c	Mon Apr  7 19:32:17 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device.c	Mon Apr 14 19:11:50 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.50 $
+ *   $Revision: 1.53 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/device.h>
+#include <linux/workqueue.h>
 
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
@@ -126,14 +127,32 @@
 	.irq = io_subchannel_irq,
 };
 
+struct workqueue_struct *ccw_device_work;
+static wait_queue_head_t ccw_device_init_wq;
+static atomic_t ccw_device_init_count;
+
 static int __init
 init_ccw_bus_type (void)
 {
 	int ret;
+
+	init_waitqueue_head(&ccw_device_init_wq);
+	atomic_set(&ccw_device_init_count, 0);
+
+	ccw_device_work = create_workqueue("cio");
+	if (!ccw_device_work)
+		return -ENOMEM; /* FIXME: better errno ? */
+
 	if ((ret = bus_register (&ccw_bus_type)))
 		return ret;
 
-	return driver_register(&io_subchannel_driver.drv);
+	if ((ret = driver_register(&io_subchannel_driver.drv)))
+		return ret;
+
+	wait_event(ccw_device_init_wq,
+		   atomic_read(&ccw_device_init_count) == 0);
+	flush_workqueue(ccw_device_work);
+	return 0;
 }
 
 static void __exit
@@ -141,6 +160,7 @@
 {
 	driver_unregister(&io_subchannel_driver.drv);
 	bus_unregister(&ccw_bus_type);
+	destroy_workqueue(ccw_device_work);
 }
 
 subsys_initcall(init_ccw_bus_type);
@@ -360,7 +380,7 @@
 /*
  * Register recognized device.
  */
-void
+static void
 io_subchannel_register(void *data)
 {
 	struct ccw_device *cdev;
@@ -389,6 +409,42 @@
 	put_device(&sch->dev);
 }
 
+/*
+ * subchannel recognition done. Called from the state machine.
+ */
+void
+io_subchannel_recog_done(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+
+	if (css_init_done == 0)
+		return;
+	switch (cdev->private->state) {
+	case DEV_STATE_NOT_OPER:
+		/* Remove device found not operational. */
+		sch = to_subchannel(cdev->dev.parent);
+		sch->dev.driver_data = 0;
+		put_device(&sch->dev);
+		if (cdev->dev.release)
+			cdev->dev.release(&cdev->dev);
+		break;
+	case DEV_STATE_OFFLINE:
+		/* 
+		 * We can't register the device in interrupt context so
+		 * we schedule a work item.
+		 */
+		INIT_WORK(&cdev->private->kick_work,
+			  io_subchannel_register, (void *) cdev);
+		queue_work(ccw_device_work, &cdev->private->kick_work);
+		break;
+	case DEV_STATE_BOXED:
+		/* Device did not respond in time. */
+		break;
+	}
+	if (atomic_dec_and_test(&ccw_device_init_count))
+		wake_up(&ccw_device_init_wq);
+}
+
 static void
 io_subchannel_recog(struct ccw_device *cdev, struct subchannel *sch)
 {
@@ -419,6 +475,9 @@
 	/* Do first half of device_register. */
 	device_initialize(&cdev->dev);
 
+	/* Increase counter of devices currently in recognition. */
+	atomic_inc(&ccw_device_init_count);
+
 	/* Start async. device sensing. */
 	spin_lock_irq(cdev->ccwlock);
 	rc = ccw_device_recognition(cdev);
@@ -428,6 +487,8 @@
 		put_device(&sch->dev);
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
+		if (atomic_dec_and_test(&ccw_device_init_count))
+			wake_up(&ccw_device_init_wq);
 	}
 }
 
@@ -452,7 +513,8 @@
 	if (!cdev)
 		return -ENOMEM;
 	memset(cdev, 0, sizeof(struct ccw_device));
-	cdev->private = kmalloc(sizeof(struct ccw_device_private), GFP_DMA);
+	cdev->private = kmalloc(sizeof(struct ccw_device_private), 
+				GFP_KERNEL | GFP_DMA);
 	if (!cdev->private) {
 		kfree(cdev);
 		return -ENOMEM;
diff -urN linux-2.5.67/drivers/s390/cio/device.h linux-2.5.67-s390/drivers/s390/cio/device.h
--- linux-2.5.67/drivers/s390/cio/device.h	Mon Apr  7 19:32:23 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device.h	Mon Apr 14 19:11:50 2003
@@ -14,13 +14,11 @@
 	DEV_STATE_W4SENSE,
 	DEV_STATE_DISBAND_PGID,
 	DEV_STATE_BOXED,
-	/* special states for qdio */
-	DEV_STATE_QDIO_INIT,
-	DEV_STATE_QDIO_ACTIVE,
-	DEV_STATE_QDIO_CLEANUP,
 	/* states to wait for i/o completion before doing something */
 	DEV_STATE_ONLINE_VERIFY,
 	DEV_STATE_W4SENSE_VERIFY,
+	DEV_STATE_CLEAR_VERIFY,
+	DEV_STATE_TIMEOUT_KILL,
 	/* last element! */
 	NR_DEV_STATES
 };
@@ -63,7 +61,9 @@
 		cdev->private->state == DEV_STATE_BOXED);
 }
 
-void io_subchannel_register(void *data);
+extern struct workqueue_struct *ccw_device_work;
+
+void io_subchannel_recog_done(struct ccw_device *cdev);
 
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
diff -urN linux-2.5.67/drivers/s390/cio/device_fsm.c linux-2.5.67-s390/drivers/s390/cio/device_fsm.c
--- linux-2.5.67/drivers/s390/cio/device_fsm.c	Mon Apr  7 19:31:23 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device_fsm.c	Mon Apr 14 19:11:50 2003
@@ -81,14 +81,14 @@
 	if (!(sch->schib.scsw.actl & SCSW_ACTL_CLEAR_PEND)) {
 		/* Stage 2: halt io. */
 		while (cdev->private->iretry-- > 0)
-			if (cio_halt (sch, 0xC8C1D3E3) == 0)
+			if (cio_halt (sch) == 0)
 				return -EBUSY;
 		/* halt io unsuccessful. */
 		cdev->private->iretry = 255;	/* 255 clear retries. */
 	}
 	/* Stage 3: clear io. */
 	while (cdev->private->iretry-- > 0)
-		if (cio_clear (sch, 0x40C3D3D9) == 0)
+		if (cio_clear (sch) == 0)
 			return -EBUSY;
 	panic("Can't stop i/o on subchannel.\n");
 }
@@ -112,10 +112,6 @@
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : unknown device %04X on subchannel %04X\n",
 			  sch->schib.pmcw.dev, sch->irq);
-		sch->dev.driver_data = 0;
-		put_device(&sch->dev);
-		if (cdev->dev.release)
-			cdev->dev.release(&cdev->dev);
 		break;
 	case DEV_STATE_OFFLINE:
 		/* fill out sense information */
@@ -131,11 +127,6 @@
 			  "%04X/%02X\n", sch->schib.pmcw.dev,
 			  cdev->id.cu_type, cdev->id.cu_model,
 			  cdev->id.dev_type, cdev->id.dev_model);
-		if (css_init_done == 0)
-			break;
-		INIT_WORK(&cdev->private->kick_work,
-			  io_subchannel_register, (void *) cdev);
-		schedule_work(&cdev->private->kick_work);
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
@@ -143,6 +134,7 @@
 			  sch->schib.pmcw.dev, sch->irq);
 		break;
 	}
+	io_subchannel_recog_done(cdev);
 	wake_up(&cdev->private->wait_q);
 }
 
@@ -219,9 +211,6 @@
 static void
 ccw_device_recog_timeout(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
 	if (ccw_device_cancel_halt_clear(cdev) == 0)
 		ccw_device_recog_done(cdev, DEV_STATE_BOXED);
 	else
@@ -349,9 +338,6 @@
 static void
 ccw_device_onoff_timeout(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
 	if (ccw_device_cancel_halt_clear(cdev) == 0)
 		ccw_device_done(cdev, DEV_STATE_BOXED);
 	else
@@ -393,8 +379,8 @@
 		// FIXME: not-oper indication to device driver ?
 		ccw_device_call_handler(cdev);
 	}
-	device_unregister(&cdev->dev);
 	wake_up(&cdev->private->wait_q);
+	device_unregister(&cdev->dev);
 }
 
 /*
@@ -438,14 +424,39 @@
 	/* Accumulate status and find out if a basic sense is needed. */
 	ccw_device_accumulate_irb(cdev, irb);
 	if (cdev->private->flags.dosense) {
-		if (ccw_device_do_sense(cdev, irb) == 0)
-			cdev->private->state = DEV_STATE_W4SENSE;
+		if (ccw_device_do_sense(cdev, irb) == 0) {
+			/* Check if we have to trigger path verification. */
+			if (irb->esw.esw0.erw.pvrf)
+				cdev->private->state = DEV_STATE_W4SENSE_VERIFY;
+			else
+				cdev->private->state = DEV_STATE_W4SENSE;
+		}
 		return;
 	}
+	if (irb->esw.esw0.erw.pvrf)
+		/* Try to start path verification. */
+		ccw_device_online_verify(cdev, 0);
 	/* No basic sense required, call the handler. */
 	ccw_device_call_handler(cdev);
 }
 
+/*
+ * Got an timeout in online state.
+ */
+static void
+ccw_device_online_timeout(struct ccw_device *cdev, enum dev_event dev_event)
+{
+	ccw_device_set_timeout(cdev, 0);
+	if (ccw_device_cancel_halt_clear(cdev) != 0) {
+		ccw_device_set_timeout(cdev, 3*HZ);
+		cdev->private->state = DEV_STATE_TIMEOUT_KILL;
+		return;
+	}
+	if (cdev->handler)
+		cdev->handler(cdev, cdev->private->intparm,
+			      ERR_PTR(-ETIMEDOUT));
+}
+
 static void
 ccw_device_irq_verify(struct ccw_device *cdev, enum dev_event dev_event)
 {
@@ -491,11 +502,17 @@
 	/* Add basic sense info to irb. */
 	ccw_device_accumulate_basic_sense(cdev, irb);
 	if (cdev->private->flags.dosense) {
+		/* Check if we have to trigger path verification. */
+		if (irb->esw.esw0.erw.pvrf)
+			cdev->private->state = DEV_STATE_W4SENSE_VERIFY;
 		/* Another basic sense is needed. */
 		ccw_device_do_sense(cdev, irb);
 		return;
 	}
 	cdev->private->state = DEV_STATE_ONLINE;
+	if (irb->esw.esw0.erw.pvrf)
+		/* Try to start path verification. */
+		ccw_device_online_verify(cdev, 0);
 	/* Call the handler. */
 	ccw_device_call_handler(cdev);
 }
@@ -527,103 +544,68 @@
 	ccw_device_call_handler(cdev);
 }
 
-/*
- * No operation action. This is used e.g. to ignore a timeout event in
- * state offline.
- */
 static void
-ccw_device_nop(struct ccw_device *cdev, enum dev_event dev_event)
-{
-}
-
-/*
- * Bug operation action. 
- */
-static void
-ccw_device_bug(struct ccw_device *cdev, enum dev_event dev_event)
-{
-	printk(KERN_EMERG "dev_jumptable[%i][%i] == NULL\n",
-	       cdev->private->state, dev_event);
-	BUG();
-}
-
-/*
- * We've got an interrupt on establish queues. Check for errors and
- * accordingly retry or move on.
- */
-static void
-ccw_device_qdio_init_irq(struct ccw_device *cdev, enum dev_event dev_event)
+ccw_device_clear_verify(struct ccw_device *cdev, enum dev_event dev_event)
 {
 	struct irb *irb;
-	struct subchannel *sch;
 
 	irb = (struct irb *) __LC_IRB;
 	/* Check for unsolicited interrupt. */
 	if (irb->scsw.stctl ==
 	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (cdev->private->qdio_data && 
-		    cdev->private->qdio_data->establish_irq)
-			cdev->private->qdio_data->establish_irq(cdev, 0, irb);
-		wake_up(&cdev->private->wait_q);
+		if (cdev->handler)
+			cdev->handler (cdev, 0, irb);
 		return;
 	}
+	/* Accumulate status. We don't do basic sense. */
 	ccw_device_accumulate_irb(cdev, irb);
-	//FIXME: Basic sense?
-	sch = to_subchannel(cdev->dev.parent);
-	if (cdev->private->qdio_data && cdev->private->qdio_data->establish_irq)
-		cdev->private->qdio_data->establish_irq(cdev, sch->u_intparm,
-							&cdev->private->irb);
-	wake_up(&cdev->private->wait_q);
+	/* Try to start delayed device verification. */
+	ccw_device_online_verify(cdev, 0);
+	/* Note: Don't call handler for cio initiated clear! */
 }
 
-/*
- * Run into a timeout after establish queues, retry if needed.
- */
 static void
-ccw_device_qdio_init_timeout(struct ccw_device *cdev, enum dev_event dev_event)
+ccw_device_killing_irq(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	ccw_device_set_timeout(cdev, 0);
-	if (cdev->private->qdio_data &&
-	    cdev->private->qdio_data->establish_timeout)
-		cdev->private->qdio_data->establish_timeout(cdev);
-	wake_up(&cdev->private->wait_q);
+	/* OK, i/o is dead now. Call interrupt handler. */
+	cdev->private->state = DEV_STATE_ONLINE;
+	if (cdev->handler)
+		cdev->handler(cdev, cdev->private->intparm,
+			      ERR_PTR(-ETIMEDOUT));
 }
 
 static void
-ccw_device_qdio_cleanup_irq(struct ccw_device *cdev,
-			    enum dev_event dev_event)
+ccw_device_killing_timeout(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	struct irb *irb;
-	struct subchannel *sch;
-
-	irb = (struct irb *) __LC_IRB;
-	/* Check for unsolicited interrupt. */
-	if (irb->scsw.stctl ==
-	    		(SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
-		if (cdev->private->qdio_data && 
-		    cdev->private->qdio_data->cleanup_irq)
-			cdev->private->qdio_data->cleanup_irq(cdev, 0, irb);
-		wake_up(&cdev->private->wait_q);
+	if (ccw_device_cancel_halt_clear(cdev) != 0) {
+		ccw_device_set_timeout(cdev, 3*HZ);
 		return;
 	}
-	ccw_device_accumulate_irb(cdev, irb);
-	//FIXME: Basic sense?
-	sch = to_subchannel(cdev->dev.parent);
-	if (cdev->private->qdio_data && cdev->private->qdio_data->cleanup_irq)
-		cdev->private->qdio_data->cleanup_irq(cdev, sch->u_intparm,
-						      &cdev->private->irb);
-	wake_up(&cdev->private->wait_q);
+	//FIXME: Can we get here?
+	cdev->private->state = DEV_STATE_ONLINE;
+	if (cdev->handler)
+		cdev->handler(cdev, cdev->private->intparm,
+			      ERR_PTR(-ETIMEDOUT));
 }
 
+/*
+ * No operation action. This is used e.g. to ignore a timeout event in
+ * state offline.
+ */
 static void
-ccw_device_qdio_cleanup_timeout(struct ccw_device *cdev,
-				enum dev_event dev_event)
+ccw_device_nop(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	ccw_device_set_timeout(cdev, 0);
-	if (cdev->private->qdio_data &&
-	    cdev->private->qdio_data->cleanup_timeout)
-		cdev->private->qdio_data->cleanup_timeout(cdev);
-	wake_up(&cdev->private->wait_q);
+}
+
+/*
+ * Bug operation action. 
+ */
+static void
+ccw_device_bug(struct ccw_device *cdev, enum dev_event dev_event)
+{
+	printk(KERN_EMERG "dev_jumptable[%i][%i] == NULL\n",
+	       cdev->private->state, dev_event);
+	BUG();
 }
 
 /*
@@ -663,7 +645,7 @@
 	[DEV_STATE_ONLINE] {
 		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
 		[DEV_EVENT_INTERRUPT]	ccw_device_irq,
-		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
+		[DEV_EVENT_TIMEOUT]	ccw_device_online_timeout,
 		[DEV_EVENT_VERIFY]	ccw_device_online_verify,
 	},
 	[DEV_STATE_W4SENSE] {
@@ -684,25 +666,6 @@
 		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
 	},
-	/* special states for qdio */
-	[DEV_STATE_QDIO_INIT] {
-		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]   ccw_device_qdio_init_irq,
-		[DEV_EVENT_TIMEOUT]     ccw_device_qdio_init_timeout,
-		[DEV_EVENT_VERIFY]      ccw_device_nop,
-	},
-	[DEV_STATE_QDIO_ACTIVE] {
-		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]   ccw_device_irq,
-		[DEV_EVENT_TIMEOUT]     ccw_device_nop,
-		[DEV_EVENT_VERIFY]      ccw_device_nop,
-	},
-	[DEV_STATE_QDIO_CLEANUP] {
-		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
-		[DEV_EVENT_INTERRUPT]   ccw_device_qdio_cleanup_irq,
-		[DEV_EVENT_TIMEOUT]     ccw_device_qdio_cleanup_timeout,
-		[DEV_EVENT_VERIFY]      ccw_device_nop,
-	},
 	/* states to wait for i/o completion before doing something */
 	[DEV_STATE_ONLINE_VERIFY] {
 		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
@@ -716,6 +679,18 @@
 		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
 		[DEV_EVENT_VERIFY]	ccw_device_nop,
 	},
+	[DEV_STATE_CLEAR_VERIFY] {
+		[DEV_EVENT_NOTOPER]     ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]   ccw_device_clear_verify,
+		[DEV_EVENT_TIMEOUT]	ccw_device_nop,
+		[DEV_EVENT_VERIFY]	ccw_device_nop,
+	},
+	[DEV_STATE_TIMEOUT_KILL] {
+		[DEV_EVENT_NOTOPER]	ccw_device_online_notoper,
+		[DEV_EVENT_INTERRUPT]	ccw_device_killing_irq,
+		[DEV_EVENT_TIMEOUT]	ccw_device_killing_timeout,
+		[DEV_EVENT_VERIFY]	ccw_device_nop, //FIXME
+	},
 };
 
 /*
@@ -736,3 +711,4 @@
 	dev_fsm_event(cdev, DEV_EVENT_INTERRUPT);
 }
 
+EXPORT_SYMBOL_GPL(ccw_device_set_timeout);
diff -urN linux-2.5.67/drivers/s390/cio/device_id.c linux-2.5.67-s390/drivers/s390/cio/device_id.c
--- linux-2.5.67/drivers/s390/cio/device_id.c	Mon Apr  7 19:30:33 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device_id.c	Mon Apr 14 19:11:50 2003
@@ -198,11 +198,13 @@
 			/* 0x00E2C9C4 == ebcdic "SID" */
 			ret = cio_start (sch, cdev->private->iccws,
 					 0x00E2C9C4, cdev->private->imask);
-			/* ret is 0, -EBUSY or -ENODEV */
-			if (ret != -EBUSY)
+			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+			if (ret == -EBUSY) {
+				udelay(100);
+				continue;
+			}
+			if (ret != -EACCES)
 				return ret;
-			udelay(100);
-			continue;
 		}
 		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
diff -urN linux-2.5.67/drivers/s390/cio/device_ops.c linux-2.5.67-s390/drivers/s390/cio/device_ops.c
--- linux-2.5.67/drivers/s390/cio/device_ops.c	Mon Apr  7 19:32:17 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device_ops.c	Mon Apr 14 19:11:50 2003
@@ -49,12 +49,15 @@
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
 	    cdev->private->state != DEV_STATE_W4SENSE &&
-	    cdev->private->state != DEV_STATE_QDIO_ACTIVE)
+	    cdev->private->state != DEV_STATE_ONLINE_VERIFY &&
+	    cdev->private->state != DEV_STATE_W4SENSE_VERIFY)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
 		return -ENODEV;
-	ret = cio_clear(sch, intparm);
+	ret = cio_clear(sch);
+	if (ret == 0)
+		cdev->private->intparm = intparm;
 	return ret;
 }
 
@@ -67,17 +70,35 @@
 
 	if (!cdev)
 		return -ENODEV;
-	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE &&
-	    cdev->private->state != DEV_STATE_QDIO_INIT)
-		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
 		return -ENODEV;
+	if (cdev->private->state != DEV_STATE_ONLINE ||
+	    sch->schib.scsw.actl != 0)
+		return -EBUSY;
 	ret = cio_set_options (sch, flags);
 	if (ret)
 		return ret;
-	ret = cio_start (sch, cpa, intparm, lpm);
+	/* 0xe4e2c5d9 == ebcdic "USER" */
+	ret = cio_start (sch, cpa, 0xe4e2c5d9, lpm);
+	if (ret == 0)
+		cdev->private->intparm = intparm;
+	return ret;
+}
+
+int
+ccw_device_start_timeout(struct ccw_device *cdev, struct ccw1 *cpa,
+			 unsigned long intparm, __u8 lpm, unsigned long flags,
+			 int expires)
+{
+	int ret;
+
+	if (!cdev)
+		return -ENODEV;
+	ccw_device_set_timeout(cdev, expires);
+	ret = ccw_device_start(cdev, cpa, intparm, lpm, flags);
+	if (ret != 0)
+		ccw_device_set_timeout(cdev, 0);
 	return ret;
 }
 
@@ -90,12 +111,16 @@
 	if (!cdev)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE)
+	    cdev->private->state != DEV_STATE_W4SENSE &&
+	    cdev->private->state != DEV_STATE_ONLINE_VERIFY &&
+	    cdev->private->state != DEV_STATE_W4SENSE_VERIFY)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
 		return -ENODEV;
-	ret = cio_halt(sch, intparm);
+	ret = cio_halt(sch);
+	if (ret == 0)
+		cdev->private->intparm = intparm;
 	return ret;
 }
 
@@ -106,12 +131,12 @@
 
 	if (!cdev)
 		return -ENODEV;
-	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE)
-		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
 		return -ENODEV;
+	if (cdev->private->state != DEV_STATE_ONLINE ||
+	    !(sch->schib.scsw.actl & SCSW_ACTL_SUSPENDED))
+		return -EINVAL;
 	return cio_resume(sch);
 }
 
@@ -123,15 +148,6 @@
 {
 	struct subchannel *sch;
 	unsigned int stctl;
-	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
-
-	if (cdev->private->state == DEV_STATE_QDIO_ACTIVE) {
-		if (cdev->private->qdio_data)
-			handler = cdev->private->qdio_data->handler;
-		else
-			handler = NULL;
-	} else
-		handler = cdev->handler;
 
 	sch = to_subchannel(cdev->dev.parent);
 
@@ -154,8 +170,9 @@
 	/*
 	 * Now we are ready to call the device driver interrupt handler.
 	 */
-	if (handler)
-		handler(cdev, sch->u_intparm, &cdev->private->irb);
+	if (cdev->handler)
+		cdev->handler(cdev, cdev->private->intparm,
+			      &cdev->private->irb);
 
 	/*
 	 * Clear the old and now useless interrupt response block.
@@ -192,6 +209,11 @@
 static void
 ccw_device_wake_up(struct ccw_device *cdev, unsigned long ip, struct irb *irb)
 {
+	struct subchannel *sch;
+
+	sch = to_subchannel(cdev->dev.parent);
+	if (!IS_ERR(irb))
+		memcpy(&sch->schib.scsw, &irb->scsw, sizeof(struct scsw));
 	wake_up(&cdev->private->wait_q);
 }
 
@@ -218,8 +240,7 @@
 
 	if (!cdev)
 		return -ENODEV;
-	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE)
+	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EINVAL;
 	if (!buffer || !length)
 		return -EINVAL;
@@ -251,7 +272,13 @@
 			wait_event(cdev->private->wait_q,
 				   sch->schib.scsw.actl == 0);
 			spin_lock_irqsave(&sch->lock, flags);
-			/* FIXME: Check if we got sensible stuff. */
+			/* Check at least for channel end / device end */
+			if ((sch->schib.scsw.dstat !=
+			     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
+			    (sch->schib.scsw.cstat != 0)) {
+				ret = -EIO;
+				continue;
+			}
 			break;
 		}
 	}
@@ -281,8 +308,7 @@
 
 	if (!cdev)
 		return -ENODEV;
-	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE)
+	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EINVAL;
 	if (cdev->private->flags.esid == 0)
 		return -EOPNOTSUPP;
@@ -300,7 +326,7 @@
 	if (!ciw || ciw->cmd == 0)
 		return -EOPNOTSUPP;
 
-	rcd_buf = kmalloc(ciw->count, GFP_DMA);
+	rcd_buf = kmalloc(ciw->count, GFP_KERNEL | GFP_DMA);
  	if (!rcd_buf)
 		return -ENOMEM;
  	memset (rcd_buf, 0, ciw->count);
@@ -325,7 +351,13 @@
 		spin_unlock_irqrestore(&sch->lock, flags);
 		wait_event(cdev->private->wait_q, sch->schib.scsw.actl == 0);
 		spin_lock_irqsave(&sch->lock, flags);
-		/* FIXME: Check if we got sensible stuff. */
+		/* Check at least for channel end / device end */
+		if ((sch->schib.scsw.dstat != 
+		     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
+		    (sch->schib.scsw.cstat != 0)) {
+			ret = -EIO;
+			continue;
+		}
 		break;
 	}
 	/* Restore interrupt handler. */
@@ -363,13 +395,15 @@
 
 
 MODULE_LICENSE("GPL");
+EXPORT_SYMBOL(ccw_device_set_options);
 EXPORT_SYMBOL(ccw_device_clear);
 EXPORT_SYMBOL(ccw_device_halt);
 EXPORT_SYMBOL(ccw_device_resume);
+EXPORT_SYMBOL(ccw_device_start_timeout);
 EXPORT_SYMBOL(ccw_device_start);
 EXPORT_SYMBOL(ccw_device_get_ciw);
 EXPORT_SYMBOL(ccw_device_get_path_mask);
-EXPORT_SYMBOL (read_conf_data);
-EXPORT_SYMBOL (read_dev_chars);
+EXPORT_SYMBOL(read_conf_data);
+EXPORT_SYMBOL(read_dev_chars);
 EXPORT_SYMBOL(_ccw_device_get_subchannel_number);
 EXPORT_SYMBOL(_ccw_device_get_device_number);
diff -urN linux-2.5.67/drivers/s390/cio/device_pgid.c linux-2.5.67-s390/drivers/s390/cio/device_pgid.c
--- linux-2.5.67/drivers/s390/cio/device_pgid.c	Mon Apr  7 19:31:42 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device_pgid.c	Mon Apr 14 19:11:50 2003
@@ -51,14 +51,23 @@
 			/* 0xe2d5c9c4 == ebcdic "SNID" */
 			ret = cio_start (sch, cdev->private->iccws, 
 					 0xE2D5C9C4, cdev->private->imask);
-			/* ret is 0, -EBUSY or -ENODEV */
-			if (ret != -EBUSY)
+			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+			if (ret == -EBUSY) {
+				CIO_MSG_EVENT(2, 
+					      "SNID - device %04X, start_io() "
+					      "reports rc : %d, retrying ...\n",
+					      sch->schib.pmcw.dev, ret);
+				udelay(100);
+				continue;
+			}
+			if (ret != -EACCES)
 				return ret;
-			CIO_MSG_EVENT(2, "SNID - device %04X, start_io() "
-				      "reports rc : %d, retrying ...\n",
-				      sch->schib.pmcw.dev, ret);
-			udelay(100);
-			continue;
+			CIO_MSG_EVENT(2, "SNID - Device %04X on Subchannel "
+				      "%04X, lpm %02X, became 'not "
+				      "operational'\n",
+				      sch->schib.pmcw.dev, sch->irq,
+				      cdev->private->imask);
+
 		}
 		cdev->private->imask >>= 1;
 		cdev->private->iretry = 5;
@@ -231,7 +240,9 @@
 		/* 0xE2D7C9C4 == ebcdic "SPID" */
 		ret = cio_start (sch, cdev->private->iccws,
 				 0xE2D7C9C4, cdev->private->imask);
-		/* ret is 0, -EBUSY or -ENODEV */
+		/* ret is 0, -EBUSY, -EACCES or -ENODEV */
+		if (ret == -EACCES)
+			break;
 		if (ret != -EBUSY)
 			return ret;
 		udelay(100);
diff -urN linux-2.5.67/drivers/s390/cio/device_status.c linux-2.5.67-s390/drivers/s390/cio/device_status.c
--- linux-2.5.67/drivers/s390/cio/device_status.c	Mon Apr  7 19:31:16 2003
+++ linux-2.5.67-s390/drivers/s390/cio/device_status.c	Mon Apr 14 19:11:50 2003
@@ -167,7 +167,7 @@
 
 	/* Copy authorization bit. */
 	cdev_irb->esw.esw0.erw.auth = irb->esw.esw0.erw.auth;
-	/* Copy path verification required flag. FIXME: how to verify ?? */
+	/* Copy path verification required flag. */
 	cdev_irb->esw.esw0.erw.pvrf = irb->esw.esw0.erw.pvrf;
 	/* Copy concurrent sense bit. */
 	cdev_irb->esw.esw0.erw.cons = irb->esw.esw0.erw.cons;
@@ -309,7 +309,7 @@
 	sch->sense_ccw.flags = CCW_FLAG_SLI;
 
 	/* 0xe2C5D5E2 == "SENS" in ebcdic */
-	return cio_start (sch, &sch->sense_ccw, 0xE2C5D5E2, 0);
+	return cio_start (sch, &sch->sense_ccw, 0xE2C5D5E2, 0xff);
 }
 
 /*
diff -urN linux-2.5.67/drivers/s390/cio/qdio.c linux-2.5.67-s390/drivers/s390/cio/qdio.c
--- linux-2.5.67/drivers/s390/cio/qdio.c	Mon Apr  7 19:31:50 2003
+++ linux-2.5.67-s390/drivers/s390/cio/qdio.c	Mon Apr 14 19:11:50 2003
@@ -34,7 +34,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-#include <linux/version.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
@@ -54,8 +53,9 @@
 #include "airq.h"
 #include "qdio.h"
 #include "ioasm.h"
+#include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.34 $"
+#define VERSION_QDIO_C "$Revision: 1.48 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -87,7 +87,6 @@
 static debug_info_t *qdio_dbf_slsb_in;
 #endif /* QDIO_DBF_LIKE_HELL */
 
-static struct qdio_chsc_area *chsc_area;
 /* iQDIO stuff: */
 static volatile struct qdio_q *iq_list=NULL; /* volatile as it could change
 						  during a while loop */
@@ -611,16 +610,13 @@
 iqdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
-#ifdef QDIO_DBF_LIKE_HELL
 	char dbf_text[15];
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	no_used=atomic_read(&q->number_of_buffers_used);
 
 	/* propagate the change from 82 to 80 through VM */
 	SYNC_MEMORY;
 
-#ifdef QDIO_DBF_LIKE_HELL
 	if (no_used) {
 		sprintf(dbf_text,"iqisnt%02x",no_used);
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
@@ -628,7 +624,6 @@
 		QDIO_DBF_TEXT4(0,trace,"iniqisdo");
 	}
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	if (!no_used)
 		return 1;
@@ -664,9 +659,7 @@
 qdio_is_inbound_q_done(struct qdio_q *q)
 {
 	int no_used;
-#ifdef QDIO_DBF_LIKE_HELL
 	char dbf_text[15];
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	no_used=atomic_read(&q->number_of_buffers_used);
 
@@ -677,11 +670,9 @@
 	SYNC_MEMORY;
 
 	if (!no_used) {
-#ifdef QDIO_DBF_LIKE_HELL
 		QDIO_DBF_TEXT4(0,trace,"inqisdnA");
 		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
-#endif /* QDIO_DBF_LIKE_HELL */
 		return 1;
 	}
 
@@ -703,20 +694,16 @@
 	 * has (probably) not moved (see qdio_inbound_processing) 
 	 */
 	if (NOW>GET_SAVED_TIMESTAMP(q)+q->timing.threshold) {
-#ifdef QDIO_DBF_LIKE_HELL
 		QDIO_DBF_TEXT4(0,trace,"inqisdon");
 		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 		sprintf(dbf_text,"pf%02xcn%02x",q->first_to_check,no_used);
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
-#endif /* QDIO_DBF_LIKE_HELL */
 		return 1;
 	} else {
-#ifdef QDIO_DBF_LIKE_HELL
 		QDIO_DBF_TEXT4(0,trace,"inqisntd");
 		QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 		sprintf(dbf_text,"pf%02xcn%02x",q->first_to_check,no_used);
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
-#endif /* QDIO_DBF_LIKE_HELL */
 		return 0;
 	}
 }
@@ -725,12 +712,10 @@
 qdio_kick_inbound_handler(struct qdio_q *q)
 {
 	int count, start, end, real_end, i;
-#ifdef QDIO_DBF_LIKE_HELL
 	char dbf_text[15];
 
 	QDIO_DBF_TEXT4(0,trace,"kickinh");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-#endif /* QDIO_DBF_LIKE_HELL */
 
   	start=q->first_element_to_kick;
  	real_end=q->first_to_check;
@@ -744,10 +729,8 @@
  		i=(i+1)&(QDIO_MAX_BUFFERS_PER_Q-1);
  	}
 
-#ifdef QDIO_DBF_LIKE_HELL
 	sprintf(dbf_text,"s=%2xc=%2x",start,count);
 	QDIO_DBF_TEXT4(0,trace,dbf_text);
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	if (q->state==QDIO_IRQ_STATE_ACTIVE)
 		q->handler(q->cdev,
@@ -950,13 +933,10 @@
 qdio_is_outbound_q_done(struct qdio_q *q)
 {
 	int no_used;
-#ifdef QDIO_DBF_LIKE_HELL
 	char dbf_text[15];
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	no_used=atomic_read(&q->number_of_buffers_used);
 
-#ifdef QDIO_DBF_LIKE_HELL
 	if (no_used) {
 		sprintf(dbf_text,"oqisnt%02x",no_used);
 		QDIO_DBF_TEXT4(0,trace,dbf_text);
@@ -964,7 +944,6 @@
 		QDIO_DBF_TEXT4(0,trace,"oqisdone");
 	}
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
-#endif /* QDIO_DBF_LIKE_HELL */
 	return (no_used==0);
 }
 
@@ -1015,10 +994,7 @@
 qdio_kick_outbound_handler(struct qdio_q *q)
 {
 	int start, end, real_end, count;
-	
-#ifdef QDIO_DBF_LIKE_HELL
 	char dbf_text[15];
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	start = q->first_element_to_kick;
 	/* last_move_ftc was just updated */
@@ -1031,10 +1007,8 @@
 	QDIO_DBF_TEXT4(0,trace,"kickouth");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-#ifdef QDIO_DBF_LIKE_HELL
 	sprintf(dbf_text,"s=%2xc=%2x",start,count);
 	QDIO_DBF_TEXT4(0,trace,dbf_text);
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	if (q->state==QDIO_IRQ_STATE_ACTIVE)
 		q->handler(q->cdev,QDIO_STATUS_OUTBOUND_INT|
@@ -1239,8 +1213,6 @@
 	if (irq_ptr->qdr)
 		kfree(irq_ptr->qdr);
 	kfree(irq_ptr);
-	QDIO_DBF_TEXT3(0,setup,"MOD_DEC_");
-	MOD_DEC_USE_COUNT;
 }
 
 static void
@@ -1482,7 +1454,7 @@
 }
 
 static int
-iqdio_thinint_handler(__u32 intparm)
+iqdio_thinint_handler(void)
 {
 	QDIO_DBF_TEXT4(0,trace,"thin_int");
 
@@ -1500,7 +1472,7 @@
 }
 
 static void
-qdio_set_state(struct qdio_irq *irq_ptr,int state)
+qdio_set_state(struct qdio_irq *irq_ptr, enum qdio_irq_states state)
 {
 	int i;
 	char dbf_text[15];
@@ -1570,23 +1542,90 @@
 	}
 }
 
+static void qdio_establish_handle_irq(struct ccw_device*, int, int);
+
+static inline void
+qdio_handle_activate_check(struct ccw_device *cdev, unsigned long intparm,
+			   int cstat, int dstat)
+{
+	struct qdio_irq *irq_ptr;
+	struct qdio_q *q;
+	char dbf_text[15];
+
+	irq_ptr = cdev->private->qdio_data;
+
+	QDIO_DBF_TEXT2(1, trace, "ick2");
+	sprintf(dbf_text,"%s", cdev->dev.bus_id);
+	QDIO_DBF_TEXT2(1,trace,dbf_text);
+	QDIO_DBF_HEX2(0,trace,&intparm,sizeof(int));
+	QDIO_DBF_HEX2(0,trace,&dstat,sizeof(int));
+	QDIO_DBF_HEX2(0,trace,&cstat,sizeof(int));
+	QDIO_PRINT_ERR("received check condition on activate " \
+		       "queues on device %s (cs=x%x, ds=x%x).\n",
+		       cdev->dev.bus_id, cstat, dstat);
+	if (irq_ptr->no_input_qs) {
+		q=irq_ptr->input_qs[0];
+	} else if (irq_ptr->no_output_qs) {
+		q=irq_ptr->output_qs[0];
+	} else {
+		QDIO_PRINT_ERR("oops... no queue registered for device %s!?\n",
+			       cdev->dev.bus_id);
+		goto omit_handler_call;
+	}
+	q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
+		   QDIO_STATUS_LOOK_FOR_ERROR,
+		   0,0,0,-1,-1,q->int_parm);
+omit_handler_call:
+	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_STOPPED);
+
+}
+
+static void
+qdio_timeout_handler(struct ccw_device *cdev)
+{
+	struct qdio_irq *irq_ptr;
+	char dbf_text[15];
+
+	QDIO_DBF_TEXT2(0, trace, "qtoh");
+	sprintf(dbf_text, "%s", cdev->dev.bus_id);
+	QDIO_DBF_TEXT2(0, trace, dbf_text);
+
+	irq_ptr = cdev->private->qdio_data;
+	sprintf(dbf_text, "state:%d", irq_ptr->state);
+	QDIO_DBF_TEXT2(0, trace, dbf_text);
+
+	switch (irq_ptr->state) {
+	case QDIO_IRQ_STATE_INACTIVE:
+		QDIO_PRINT_ERR("establish queues on irq %04x: timed out\n",
+			       irq_ptr->irq);
+		QDIO_DBF_TEXT2(1,setup,"eq:timeo");
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+		break;
+	case QDIO_IRQ_STATE_CLEANUP:
+		QDIO_PRINT_INFO("Did not get interrupt on cleanup, irq=0x%x.\n",
+				irq_ptr->irq);
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+		break;
+	default:
+		BUG();
+	}
+	wake_up(&cdev->private->wait_q);
+
+}
+
 static void
 qdio_handler(struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 {
 	struct qdio_irq *irq_ptr;
-	struct qdio_q *q;
 	int cstat,dstat;
 	char dbf_text[15];
 
-        cstat = irb->scsw.cstat;
-        dstat = irb->scsw.dstat;
-
 	QDIO_DBF_TEXT4(0, trace, "qint");
 	sprintf(dbf_text, "%s", cdev->dev.bus_id);
 	QDIO_DBF_TEXT4(0, trace, dbf_text);
 	
-	if (!intparm || !cdev) {
-		QDIO_PRINT_STUPID("got unsolicited interrupt in qdio " \
+	if (!intparm) {
+		QDIO_PRINT_ERR("got unsolicited interrupt in qdio " \
 				  "handler, device %s\n", cdev->dev.bus_id);
 		return;
 	}
@@ -1601,39 +1640,58 @@
 		return;
 	}
 
+	if (IS_ERR(irb)) {
+		/* Currently running i/o is in error. */
+		switch (PTR_ERR(irb)) {
+		case -EIO:
+			QDIO_PRINT_ERR("i/o error on device %s\n",
+				       cdev->dev.bus_id);
+			//FIXME: hm?
+			return;
+		case -ETIMEDOUT:
+			qdio_timeout_handler(cdev);
+			return;
+		default:
+			QDIO_PRINT_ERR("unknown error state %ld on device %s\n",
+				       PTR_ERR(irb), cdev->dev.bus_id);
+			return;
+		}
+	}
+
 	qdio_irq_check_sense(irq_ptr->irq, irb);
 
-	if (cstat & SCHN_STAT_PCI) {
-		qdio_handle_pci(irq_ptr);
-		return;
-	}
+	sprintf(dbf_text, "state:%d", irq_ptr->state);
+	QDIO_DBF_TEXT4(0, trace, dbf_text);
 
-	if ((cstat&~SCHN_STAT_PCI)||dstat) {
-		QDIO_DBF_TEXT2(1, trace, "ick2");
-		sprintf(dbf_text,"%s", cdev->dev.bus_id);
-		QDIO_DBF_TEXT2(1,trace,dbf_text);
-		QDIO_DBF_HEX2(0,trace,&intparm,sizeof(int));
-		QDIO_DBF_HEX2(0,trace,&dstat,sizeof(int));
-		QDIO_DBF_HEX2(0,trace,&cstat,sizeof(int));
-		QDIO_PRINT_ERR("received check condition on activate " \
-			       "queues on device %s (cs=x%x, ds=x%x).\n",
-			       cdev->dev.bus_id, cstat, dstat);
-		if (irq_ptr->no_input_qs) {
-			q=irq_ptr->input_qs[0];
-		} else if (irq_ptr->no_output_qs) {
-			q=irq_ptr->output_qs[0];
-		} else {
-			QDIO_PRINT_ERR("oops... no queue registered for " \
-				       "device %s!?\n", cdev->dev.bus_id);
-			goto omit_handler_call;
-		}
-		q->handler(q->cdev,QDIO_STATUS_ACTIVATE_CHECK_CONDITION|
-			   QDIO_STATUS_LOOK_FOR_ERROR,
-			   0,0,0,-1,-1,q->int_parm);
-	omit_handler_call:
-		qdio_set_state(irq_ptr,QDIO_IRQ_STATE_STOPPED);
-		return;
+        cstat = irb->scsw.cstat;
+        dstat = irb->scsw.dstat;
+
+	switch (irq_ptr->state) {
+	case QDIO_IRQ_STATE_INACTIVE:
+		qdio_establish_handle_irq(cdev, cstat, dstat);
+		break;
+
+	case QDIO_IRQ_STATE_CLEANUP:
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
+		break;
+
+	case QDIO_IRQ_STATE_ESTABLISHED:
+	case QDIO_IRQ_STATE_ACTIVE:
+		if (cstat & SCHN_STAT_PCI) {
+			qdio_handle_pci(irq_ptr);
+			break;
+		}
+
+		if ((cstat&~SCHN_STAT_PCI)||dstat) {
+			qdio_handle_activate_check(cdev, intparm, cstat, dstat);
+			break;
+		}
+	default:
+		QDIO_PRINT_ERR("got interrupt for queues in state %d on " \
+			       "device %s?!\n",
+			       irq_ptr->state, cdev->dev.bus_id);
 	}
+	wake_up(&cdev->private->wait_q);
 
 }
 
@@ -1680,60 +1738,108 @@
 static unsigned char
 qdio_check_siga_needs(int sch)
 {
-	int resp_code,result;
+	int result;
+	unsigned char qdioac;
+
+	struct {
+		struct chsc_header request;
+		u16 reserved1;
+		u16 first_sch;
+		u16 reserved2;
+		u16 last_sch;
+		u32 reserved3;
+		struct chsc_header response;
+		u32 reserved4;
+		u8  flags;
+		u8  reserved5;
+		u16 sch;
+		u8  qfmt;
+		u8  reserved6;
+		u8  qdioac;
+		u8  sch_class;
+		u8  reserved7;
+		u8  icnt;
+		u8  reserved8;
+		u8  ocnt;
+	} *ssqd_area;
+
+	ssqd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!ssqd_area) {
+	        QDIO_PRINT_WARN("Could not get memory for chsc. Using all " \
+				"SIGAs for sch x%x.\n", sch);
+		return -1; /* all flags set */
+	}
+	ssqd_area->request = (struct chsc_header) {
+		.length = 0x0010,
+		.code   = 0x0024,
+	};
 
-	memset(chsc_area,0,sizeof(struct qdio_chsc_area));
-	chsc_area->request_block.command_code1=0x0010; /* length */
-	chsc_area->request_block.command_code2=0x0024; /* op code */
-	chsc_area->request_block.first_sch=sch;
-	chsc_area->request_block.last_sch=sch;
+	ssqd_area->first_sch = sch;
+	ssqd_area->last_sch = sch;
 
-	result=chsc(chsc_area);
+	result=chsc(ssqd_area);
 
 	if (result) {
 		QDIO_PRINT_WARN("CHSC returned cc %i. Using all " \
 				"SIGAs for sch x%x.\n",
 				result,sch);
-		return -1; /* all flags set */
+		qdioac = -1; /* all flags set */
+		goto out;
 	}
 
-	resp_code=chsc_area->request_block.operation_data_area.
-		store_qdio_data_response.response_code;
-	if (resp_code!=QDIO_CHSC_RESPONSE_CODE_OK) {
+	if (ssqd_area->response.code != QDIO_CHSC_RESPONSE_CODE_OK) {
 		QDIO_PRINT_WARN("response upon checking SIGA needs " \
 				"is 0x%x. Using all SIGAs for sch x%x.\n",
-				resp_code,sch);
-		return -1; /* all flags set */
+				ssqd_area->response.code, sch);
+		qdioac = -1; /* all flags set */
+		goto out;
 	}
-	if (
-	    (!(chsc_area->request_block.operation_data_area.
-	       store_qdio_data_response.flags&CHSC_FLAG_QDIO_CAPABILITY)) ||
-	    (!(chsc_area->request_block.operation_data_area.
-	       store_qdio_data_response.flags&CHSC_FLAG_VALIDITY)) ||
-	    (chsc_area->request_block.operation_data_area.
-	     store_qdio_data_response.sch!=sch)
-	    ) {
+	if (!(ssqd_area->flags & CHSC_FLAG_QDIO_CAPABILITY) ||
+	    !(ssqd_area->flags & CHSC_FLAG_VALIDITY) ||
+	    (ssqd_area->sch != sch)) {
 		QDIO_PRINT_WARN("huh? problems checking out sch x%x... " \
 				"using all SIGAs.\n",sch);
-		return CHSC_FLAG_SIGA_INPUT_NECESSARY |
+		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY |
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY |
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* worst case */
+		goto out;
 	}
 
-	return chsc_area->request_block.operation_data_area.
-		store_qdio_data_response.qdioac;
+	qdioac = ssqd_area->qdioac;
+out:
+	free_page ((unsigned long) ssqd_area);
+	return qdioac;
 }
 
-/* the chsc_area is locked by the lock in qdio_activate */
 static unsigned int
-iqdio_check_chsc_availability(void) {
+iqdio_check_chsc_availability(void)
+{
 	int result;
-	int i;
 
-	memset(chsc_area,0,sizeof(struct qdio_chsc_area));
-	chsc_area->request_block.command_code1=0x0010;
-	chsc_area->request_block.command_code2=0x0010;
-	result=chsc(chsc_area);
+	struct {
+		struct chsc_header request;
+		u32 reserved1;
+		u32 reserved2;
+		u32 reserved3;
+		struct chsc_header response;
+		u32 reserved4;
+		u32 general_char[510];
+		u32 chsc_char[518];
+	} *scsc_area;
+		
+	scsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!scsc_area) {
+	        QDIO_PRINT_WARN("Was not able to determine available" \
+				"CHSCs due to no memory.\n");
+		return -ENOMEM;
+	}
+
+	scsc_area->request = (struct chsc_header) {
+		.length = 0x0010,
+		.code   = 0x0010,
+	};
+
+	result=chsc(scsc_area);
 	if (result) {
 		QDIO_PRINT_WARN("Was not able to determine " \
 				"available CHSCs, cc=%i.\n",
@@ -1741,10 +1847,8 @@
 		result=-EIO;
 		goto exit;
 	}
-	result=0;
-	i=chsc_area->request_block.operation_data_area.
-		store_qdio_data_response.response_code;
-	if (i!=1) {
+
+	if (scsc_area->response.code != 1) {
 		QDIO_PRINT_WARN("Was not able to determine " \
 				"available CHSCs.\n");
 		result=-EIO;
@@ -1753,24 +1857,24 @@
 	/* 4: request block
 	 * 2: general char
 	 * 512: chsc char */
-	if ( (*(((unsigned int*)(chsc_area))+4+2+1)&0x00800000)!=0x00800000) {
+	if ((scsc_area->general_char[1] & 0x00800000) != 0x00800000) {
 		QDIO_PRINT_WARN("Adapter interruption facility not " \
 				"installed.\n");
 		result=-ENOENT;
 		goto exit;
 	}
-	if ( (*(((unsigned int*)(chsc_area))+4+512+3)&0x00180000)!=
-	     0x00180000 ) {
+	if ((scsc_area->chsc_char[2] & 0x00180000) != 0x00180000) {
 		QDIO_PRINT_WARN("Set Chan Subsys. Char. & Fast-CHSCs " \
 				"not available.\n");
 		result=-ENOENT;
 		goto exit;
 	}
 exit:
+	free_page ((unsigned long) scsc_area);
 	return result;
 }
 
-/* the chsc_area is locked by the lock in qdio_activate */
+
 static unsigned int
 iqdio_set_subchannel_ind(struct qdio_irq *irq_ptr, int reset_to_zero)
 {
@@ -1782,7 +1886,27 @@
 	unsigned int resp_code;
 	int result;
 
-	if (!irq_ptr->is_iqdio_irq) return -ENODEV;
+	struct {
+		struct chsc_header request;
+		u16 operation_code;
+		u16 reserved1;
+		u32 reserved2;
+		u32 reserved3;
+		u64 summary_indicator_addr;
+		u64 subchannel_indicator_addr;
+		u32 ks:4;
+		u32 kc:4;
+		u32 reserved4:21;
+		u32 isc:3;
+		u32 reserved5[2];
+		u32 subsystem_id;
+		u32 reserved6[1004];
+		struct chsc_header response;
+		u32 reserved7;
+	} *scssc_area;
+
+	if (!irq_ptr->is_iqdio_irq)
+		return -ENODEV;
 
 	if (reset_to_zero) {
 		real_addr_local_summary_bit=0;
@@ -1794,52 +1918,57 @@
 			virt_to_phys((volatile void *)irq_ptr->dev_st_chg_ind);
 	}
 
-	memset(chsc_area,0,sizeof(struct qdio_chsc_area));
-	chsc_area->request_block.command_code1=0x0fe0;
-	chsc_area->request_block.command_code2=0x0021;
-	chsc_area->request_block.operation_code=0;
-	chsc_area->request_block.image_id=0;
-
-	chsc_area->request_block.operation_data_area.set_chsc.
-		summary_indicator_addr=real_addr_local_summary_bit;
-	chsc_area->request_block.operation_data_area.set_chsc.
-		subchannel_indicator_addr=real_addr_dev_st_chg_ind;
-	chsc_area->request_block.operation_data_area.set_chsc.
-		ks=QDIO_STORAGE_KEY;
-	chsc_area->request_block.operation_data_area.set_chsc.
-		kc=QDIO_STORAGE_KEY;
-	chsc_area->request_block.operation_data_area.set_chsc.
-		isc=IQDIO_THININT_ISC;
-	chsc_area->request_block.operation_data_area.set_chsc.
-		subsystem_id=(1<<16)+irq_ptr->irq;
+	scssc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!scssc_area) {
+		QDIO_PRINT_WARN("No memory for setting indicators on " \
+				"subchannel x%x.\n", irq_ptr->irq);
+		return -ENOMEM;
+	}
+	scssc_area->request = (struct chsc_header) {
+		.length = 0x0fe0,
+		.code   = 0x0021,
+	};
+	scssc_area->operation_code = 0;
+
+        scssc_area->summary_indicator_addr = real_addr_local_summary_bit;
+	scssc_area->subchannel_indicator_addr = real_addr_dev_st_chg_ind;
+	scssc_area->ks = QDIO_STORAGE_KEY;
+	scssc_area->kc = QDIO_STORAGE_KEY;
+	scssc_area->isc = IQDIO_THININT_ISC;
+	scssc_area->subsystem_id = (1<<16) + irq_ptr->irq;
 
-	result=chsc(chsc_area);
+	result = chsc(scssc_area);
 	if (result) {
 		QDIO_PRINT_WARN("could not set indicators on irq x%x, " \
 				"cc=%i.\n",irq_ptr->irq,result);
-		return -EIO;
+		result = -EIO;
+		goto out;
 	}
 
-	resp_code=chsc_area->response_block.response_code;
+	resp_code = scssc_area->response.code;
 	if (resp_code!=QDIO_CHSC_RESPONSE_CODE_OK) {
 		QDIO_PRINT_WARN("response upon setting indicators " \
 				"is 0x%x.\n",resp_code);
 		sprintf(dbf_text,"sidR%4x",resp_code);
 		QDIO_DBF_TEXT1(0,trace,dbf_text);
 		QDIO_DBF_TEXT1(0,setup,dbf_text);
-		ptr=&chsc_area->response_block;
+		ptr=&scssc_area->response;
 		QDIO_DBF_HEX2(1,setup,&ptr,QDIO_DBF_SETUP_LEN);
-		return -EIO;
+		result = -EIO;
+		goto out;
 	}
 
 	QDIO_DBF_TEXT2(0,setup,"setscind");
 	QDIO_DBF_HEX2(0,setup,&real_addr_local_summary_bit,
 		      sizeof(unsigned long));
 	QDIO_DBF_HEX2(0,setup,&real_addr_dev_st_chg_ind,sizeof(unsigned long));
-	return 0;
+	result = 0;
+out:
+	free_page ((unsigned long) scssc_area);
+	return result;
+
 }
 
-/* chsc_area would have to be locked if called from outside qdio_activate */
 static unsigned int
 iqdio_set_delay_target(struct qdio_irq *irq_ptr, unsigned long delay_target)
 {
@@ -1848,34 +1977,59 @@
 	void *ptr;
 	char dbf_text[15];
 
-	if (!irq_ptr->is_iqdio_irq) return -ENODEV;
+	struct {
+		struct chsc_header request;
+		u16 operation_code;
+		u16 reserved1;
+		u32 reserved2;
+		u32 reserved3;
+		u32 reserved4[2];
+		u32 delay_target;
+		u32 reserved5[1009];
+		struct chsc_header response;
+		u32 reserved6;
+	} *scsscf_area;
 
-	memset(chsc_area,0,sizeof(struct qdio_chsc_area));
-	chsc_area->request_block.command_code1=0x0fe0;
-	chsc_area->request_block.command_code2=0x1027;
-	chsc_area->request_block.operation_data_area.set_chsc_fast.
-		delay_target=delay_target<<16;
+	if (!irq_ptr->is_iqdio_irq)
+		return -ENODEV;
+
+	scsscf_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!scsscf_area) {
+		QDIO_PRINT_WARN("No memory for setting delay target on " \
+				"subchannel x%x.\n", irq_ptr->irq);
+		return -ENOMEM;
+	}
+	scsscf_area->request = (struct chsc_header) {
+		.length = 0x0fe0,
+		.code   = 0x1027,
+	};
 
-	result=chsc(chsc_area);
+	scsscf_area->delay_target = delay_target<<16;
+
+	result=chsc(scsscf_area);
 	if (result) {
 		QDIO_PRINT_WARN("could not set delay target on irq x%x, " \
 				"cc=%i. Continuing.\n",irq_ptr->irq,result);
-		return -EIO;
+		result = -EIO;
+		goto out;
 	}
 
-	resp_code=chsc_area->response_block.response_code;
+	resp_code = scsscf_area->response.code;
 	if (resp_code!=QDIO_CHSC_RESPONSE_CODE_OK) {
 		QDIO_PRINT_WARN("response upon setting delay target " \
 				"is 0x%x. Continuing.\n",resp_code);
 		sprintf(dbf_text,"sdtR%4x",resp_code);
 		QDIO_DBF_TEXT1(0,trace,dbf_text);
 		QDIO_DBF_TEXT1(0,setup,dbf_text);
-		ptr=&chsc_area->response_block;
+		ptr=&scsscf_area->response;
 		QDIO_DBF_HEX2(1,trace,&ptr,QDIO_DBF_TRACE_LEN);
 	}
 	QDIO_DBF_TEXT2(0,trace,"delytrgt");
 	QDIO_DBF_HEX2(0,trace,&delay_target,sizeof(unsigned long));
-	return 0;
+	result = 0; /* not critical */
+out:
+	free_page ((unsigned long) scsscf_area);
+	return result;
 }
 
 int
@@ -1972,19 +2126,22 @@
 		ccw_device_halt(cdev, QDIO_DOING_CLEANUP);
 		timeout=QDIO_CLEANUP_HALT_TIMEOUT;
 	}
-	cdev->private->state = DEV_STATE_QDIO_CLEANUP;
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_CLEANUP);
 	ccw_device_set_timeout(cdev, timeout);
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev),flags);
 
-	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
-
+	wait_event(cdev->private->wait_q,
+		   irq_ptr->state == QDIO_IRQ_STATE_INACTIVE ||
+		   irq_ptr->state == QDIO_IRQ_STATE_ERR);
+	/* Ignore errors. */
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
 out:
 	up(&irq_ptr->setting_up_sema);
 	return result;
 }
 
 static inline void
-qdio_cleanup_finish(struct qdio_irq *irq_ptr)
+qdio_cleanup_finish(struct ccw_device *cdev, struct qdio_irq *irq_ptr)
 {
 	if (irq_ptr->is_iqdio_irq) {
 		qdio_put_indicator((__u32*)irq_ptr->dev_st_chg_ind);
@@ -1992,6 +2149,10 @@
                 /* reset adapter interrupt indicators */
 	}
 
+ 	/* exchange int handlers, if necessary */
+ 	if ((void*)cdev->handler == (void*)qdio_handler)
+ 		cdev->handler=irq_ptr->original_int_handler;
+
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
 }
 
@@ -2014,51 +2175,16 @@
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EINVAL;
 
-	qdio_cleanup_finish(irq_ptr);
+	qdio_cleanup_finish(cdev, irq_ptr);
 	cdev->private->qdio_data = 0;
 
 	up(&irq_ptr->setting_up_sema);
 
 	qdio_release_irq_memory(irq_ptr);
+	module_put(THIS_MODULE);
 	return 0;
 }
 
-static void
-qdio_cleanup_handle_timeout(struct ccw_device *cdev)
-{
-	unsigned long flags;
-	struct qdio_irq *irq_ptr;
-
-	irq_ptr = cdev->private->qdio_data;
-
-	spin_lock_irqsave(get_ccwdev_lock(cdev),flags);
-	QDIO_PRINT_INFO("Did not get interrupt on cleanup, irq=0x%x.\n",
-			irq_ptr->irq);
-
-	spin_unlock_irqrestore(get_ccwdev_lock(cdev),flags);
-
-	cdev->private->state = DEV_STATE_ONLINE;
-	wake_up(&cdev->private->wait_q);
-}
-
-static void
-qdio_cleanup_handle_irq(struct ccw_device *cdev, unsigned long intparm,
-			struct irb *irb)
-{
-	struct qdio_irq *irq_ptr;
-
-	if (intparm == 0)
-		QDIO_PRINT_WARN("Got unsolicited interrupt on cleanup "
-				"(irq 0x%x).\n", cdev->private->irq);
-
-	irq_ptr = cdev->private->qdio_data;
-
-	qdio_irq_check_sense(irq_ptr->irq, irb);
-
-	cdev->private->state = DEV_STATE_ONLINE;
-	wake_up(&cdev->private->wait_q);
-}
-
 static inline void
 qdio_allocate_do_dbf(struct qdio_initialize *init_data)
 {
@@ -2134,24 +2260,6 @@
 	irq_ptr->qdr->qdf0[i+j].dkey=QDIO_STORAGE_KEY;
 }
 
-void
-qdio_establish_handle_timeout(struct ccw_device *cdev)
-{
-	struct qdio_irq *irq_ptr;
-
-	irq_ptr = cdev->private->qdio_data;
-
-	QDIO_PRINT_ERR("establish queues on irq %04x: timed out\n",
-		       irq_ptr->irq);
-	QDIO_DBF_TEXT2(1,setup,"eq:timeo");
-	/*
-	 * FIXME:
-	 * this is broken,
-	 * we are in the context of a timer interrupt and
-	 * qdio_shutdown calls schedule
-	 */
-	qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
-}
 
 static inline void
 qdio_initialize_set_siga_flags_input(struct qdio_irq *irq_ptr)
@@ -2208,7 +2316,7 @@
 		QDIO_PRINT_ERR("received check condition on establish " \
 			       "queues on irq 0x%x (cs=x%x, ds=x%x).\n",
 			       irq_ptr->irq,cstat,dstat);
-		qdio_set_state(irq_ptr,QDIO_IRQ_STATE_STOPPED);
+		qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ERR);
 	}
 	
 	if (!(dstat & DEV_STAT_DEV_END)) {
@@ -2218,13 +2326,7 @@
 		QDIO_PRINT_ERR("establish queues on irq %04x: didn't get "
 			       "device end: dstat=%02x, cstat=%02x\n",
 			       irq_ptr->irq, dstat, cstat);
-		/*
-		 * FIXME:
-		 * this is broken,
-		 * we are probably in the context of an i/o interrupt and
-		 * qdio_shutdown calls schedule
-		 */
-		qdio_shutdown(cdev,QDIO_FLAG_CLEANUP_USING_CLEAR);
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		return 1;
 	}
 
@@ -2236,36 +2338,27 @@
 			       "the following devstat: dstat=%02x, "
 			       "cstat=%02x\n",
 			       irq_ptr->irq, dstat, cstat);
-		cdev->private->state = DEV_STATE_ONLINE;
+		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		return 1;
 	}
 	return 0;
 }
 
 static void
-qdio_establish_handle_irq(struct ccw_device *cdev, unsigned long intparm,
-			  struct irb *irb)
+qdio_establish_handle_irq(struct ccw_device *cdev, int cstat, int dstat)
 {
 	struct qdio_irq *irq_ptr;
-	int cstat, dstat;
 	char dbf_text[15];
 
-        cstat = irb->scsw.cstat;
-        dstat = irb->scsw.dstat;
-
-	irq_ptr = cdev->private->qdio_data;
-
-	if (intparm == 0) {
-		QDIO_PRINT_WARN("Got unsolicited interrupt on establish "
-				"queues (irq 0x%x).\n", cdev->private->irq);
-		return;
-	}
-
-	qdio_irq_check_sense(irq_ptr->irq, irb);
+	sprintf(dbf_text,"qehi%4x",cdev->private->irq);
+	QDIO_DBF_TEXT0(0,setup,dbf_text);
+	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
 	if (qdio_establish_irq_check_for_errors(cdev, cstat, dstat))
 		return;
 
+	irq_ptr = cdev->private->qdio_data;
+
 	if (MACHINE_IS_VM)
 		irq_ptr->qdioac=qdio_check_siga_needs(irq_ptr->irq);
 	else
@@ -2287,6 +2380,7 @@
 	qdio_initialize_set_siga_flags_output(irq_ptr);
 
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ESTABLISHED);
+
 }
 
 int
@@ -2334,7 +2428,7 @@
 	qdio_allocate_do_dbf(init_data);
 
 	/* create irq */
-	irq_ptr=kmalloc(sizeof(struct qdio_irq),GFP_DMA);
+	irq_ptr=kmalloc(sizeof(struct qdio_irq), GFP_KERNEL | GFP_DMA);
 
 	QDIO_DBF_TEXT0(0,setup,"irq_ptr:");
 	QDIO_DBF_HEX0(0,setup,&irq_ptr,sizeof(void*));
@@ -2347,7 +2441,7 @@
 	memset(irq_ptr,0,sizeof(struct qdio_irq));
         /* wipes qib.ac, required by ar7063 */
 
-	irq_ptr->qdr=kmalloc(sizeof(struct qdr),GFP_DMA);
+	irq_ptr->qdr=kmalloc(sizeof(struct qdr), GFP_KERNEL | GFP_DMA);
   	if (!(irq_ptr->qdr)) {
    		kfree(irq_ptr->qdr);
    		kfree(irq_ptr);
@@ -2372,11 +2466,6 @@
 		if (!irq_ptr->dev_st_chg_ind) {
 			QDIO_PRINT_WARN("no indicator location available " \
 					"for irq 0x%x\n",irq_ptr->irq);
-			/*
-			 * FIXME:
-			 * qdio_release_irq_memory does MOD_DEC_USE_COUNT
-			 * in an unbalanced fashion (see 30 lines farther down)
-			 */
 			qdio_release_irq_memory(irq_ptr);
 			return -ENOBUFS;
 		}
@@ -2396,19 +2485,17 @@
 			   init_data->q_format,init_data->flags,
 			   init_data->input_sbal_addr_array,
 			   init_data->output_sbal_addr_array)) {
-		/*
-		 * FIXME:
-		 * qdio_release_irq_memory does MOD_DEC_USE_COUNT
-		 * in an unbalanced fashion (see 10 lines farther down)
-		 */
 		qdio_release_irq_memory(irq_ptr);
 		return -ENOMEM;
 	}
 
 	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_INACTIVE);
 
-	MOD_INC_USE_COUNT;
-	QDIO_DBF_TEXT3(0,setup,"MOD_INC_");
+	if (!try_module_get(THIS_MODULE)) {
+		QDIO_PRINT_CRIT("try_module_get() failed!\n");
+		qdio_release_irq_memory(irq_ptr);
+		return -EINVAL;
+	}
 
 	init_MUTEX_LOCKED(&irq_ptr->setting_up_sema);
 
@@ -2474,6 +2561,10 @@
 	} else
 		irq_ptr->aqueue = *ciw;
 
+	/* Set new interrupt handler. */
+	irq_ptr->original_int_handler = init_data->cdev->handler;
+	init_data->cdev->handler = qdio_handler;
+
 	/* the iqdio CHSC stuff */
 	if (irq_ptr->is_iqdio_irq) {
 /*		iqdio_enable_adapter_int_facility(irq_ptr);*/
@@ -2485,25 +2576,12 @@
 		result=iqdio_set_subchannel_ind(irq_ptr,0);
 		if (result) {
 			up(&irq_ptr->setting_up_sema);
-			/*
-			 * FIXME:
-			 * need some callback pointers to be set already,
-			 * i.e. irq_ptr->cleanup_irq and irq_ptr->cleanup_timeout?
-			 * (see 10 lines farther down)
-			 */
 			qdio_cleanup(init_data->cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 			return result;
 		}
 		iqdio_set_delay_target(irq_ptr,IQDIO_DELAY_TARGET);
 	}
 
-	/* Set callback functions. */
-	irq_ptr->cleanup_irq = qdio_cleanup_handle_irq;
-	irq_ptr->cleanup_timeout = qdio_cleanup_handle_timeout;
-	irq_ptr->establish_irq = qdio_establish_handle_irq;
-	irq_ptr->establish_timeout = qdio_establish_handle_timeout;
-	irq_ptr->handler = qdio_handler;
-
 	up(&irq_ptr->setting_up_sema);
 
 	return 0;
@@ -2538,13 +2616,14 @@
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev),saveflags);
 
-	ccw_device_set_timeout(cdev, QDIO_ESTABLISH_TIMEOUT);
 	ccw_device_set_options(cdev, 0);
-	result=ccw_device_start(cdev,&irq_ptr->ccw,
-				QDIO_DOING_ESTABLISH,0,0);
+	result=ccw_device_start_timeout(cdev,&irq_ptr->ccw,
+					QDIO_DOING_ESTABLISH,0,0,
+					QDIO_ESTABLISH_TIMEOUT);
 	if (result) {
-		result2=ccw_device_start(cdev,&irq_ptr->ccw,
-					 QDIO_DOING_ESTABLISH,0,0);
+		result2=ccw_device_start_timeout(cdev,&irq_ptr->ccw,
+						 QDIO_DOING_ESTABLISH,0,0,
+						 QDIO_ESTABLISH_TIMEOUT);
 		sprintf(dbf_text,"eq:io%4x",result);
 		QDIO_DBF_TEXT2(1,setup,dbf_text);
 		if (result2) {
@@ -2556,8 +2635,7 @@
                            irq_ptr->irq,result,result2);
 		result=result2;
 	}
-	if (result == 0)
-		cdev->private->state = DEV_STATE_QDIO_INIT;
+
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev),saveflags);
 
 	if (result) {
@@ -2567,13 +2645,15 @@
 	}
 	
 	wait_event(cdev->private->wait_q,
-		   dev_fsm_final_state(cdev) ||
-		   (irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED));
+		   irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED ||
+		   irq_ptr->state == QDIO_IRQ_STATE_ERR);
 
-	if (cdev->private->state == DEV_STATE_QDIO_INIT)
+	if (irq_ptr->state == QDIO_IRQ_STATE_ESTABLISHED)
 		result = 0;
-	else 
+	else {
+		qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 		result = -EIO;
+	}
 
 	up(&irq_ptr->setting_up_sema);
 
@@ -2593,7 +2673,7 @@
 	if (!irq_ptr)
 		return -ENODEV;
 
-	if (cdev->private->state != DEV_STATE_QDIO_INIT)
+	if (cdev->private->state != DEV_STATE_ONLINE)
 		return -EINVAL;
 
 	down(&irq_ptr->setting_up_sema);
@@ -2637,8 +2717,6 @@
 	if (result)
 		goto out;
 
-	cdev->private->state = DEV_STATE_QDIO_ACTIVE;
-
 	for (i=0;i<irq_ptr->no_input_qs;i++) {
 		if (irq_ptr->is_iqdio_irq) {
 			/* 
@@ -2659,9 +2737,9 @@
 		}
 	}
 
-	qdio_wait_nonbusy(QDIO_ACTIVATE_DELAY);
+	qdio_wait_nonbusy(QDIO_ACTIVATE_TIMEOUT);
 
-	qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ACTIVE);
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ACTIVE);
 
  out:
 	up(&irq_ptr->setting_up_sema);
@@ -2807,12 +2885,10 @@
 {
 	struct qdio_irq *irq_ptr;
 
-#ifdef QDIO_DBF_LIKE_HELL
 	char dbf_text[20];
 
-	sprintf(dbf_text,"doQD%04x",irq);
+	sprintf(dbf_text,"doQD%04x",cdev->private->irq);
 	QDIO_DBF_TEXT3(0,trace,dbf_text);
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	if ( (qidx>QDIO_MAX_BUFFERS_PER_Q) ||
 	     (count>QDIO_MAX_BUFFERS_PER_Q) ||
@@ -2826,7 +2902,6 @@
 	if (!irq_ptr)
 		return -ENODEV;
 
-#ifdef QDIO_DBF_LIKE_HELL
 	if (callflags&QDIO_FLAG_SYNC_INPUT)
 		QDIO_DBF_HEX3(0,trace,&irq_ptr->input_qs[queue_number],
 			      sizeof(void*));
@@ -2837,7 +2912,6 @@
 	QDIO_DBF_TEXT3(0,trace,dbf_text);
 	sprintf(dbf_text,"qi%02xct%02x",qidx,count);
 	QDIO_DBF_TEXT3(0,trace,dbf_text);
-#endif /* QDIO_DBF_LIKE_HELL */
 
 	if (irq_ptr->state!=QDIO_IRQ_STATE_ACTIVE)
 		return -EBUSY;
@@ -2989,25 +3063,12 @@
 				   GFP_KERNEL);
        	if (!indicators) return -ENOMEM;
 	memset(indicators,0,sizeof(__u32)*(INDICATORS_PER_CACHELINE));
-
-	chsc_area=(struct qdio_chsc_area *)
-		kmalloc(sizeof(struct qdio_chsc_area),GFP_KERNEL);
-	QDIO_DBF_TEXT3(0,trace,"chscarea"); \
-	QDIO_DBF_HEX3(0,trace,&chsc_area,sizeof(void*)); \
-	if (!chsc_area) {
-		QDIO_PRINT_ERR("not enough memory for chsc area. Cannot " \
-			       "initialize QDIO.\n");
-		kfree(indicators);
-		return -ENOMEM;
-	}
-	memset(chsc_area,0,sizeof(struct qdio_chsc_area));
 	return 0;
 }
 
 static void
 qdio_release_qdio_memory(void)
 {
-	kfree(chsc_area);
 	if (indicators)
 		kfree(indicators);
 }
diff -urN linux-2.5.67/drivers/s390/cio/qdio.h linux-2.5.67-s390/drivers/s390/cio/qdio.h
--- linux-2.5.67/drivers/s390/cio/qdio.h	Mon Apr  7 19:30:45 2003
+++ linux-2.5.67-s390/drivers/s390/cio/qdio.h	Mon Apr 14 19:11:50 2003
@@ -1,7 +1,7 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.11 $"
+#define VERSION_CIO_QDIO_H "$Revision: 1.16 $"
 
 //#define QDIO_DBF_LIKE_HELL
 
@@ -48,25 +48,25 @@
 #define QDIO_STATS_CLASSES 2
 #define QDIO_STATS_COUNT_NEEDED 2*/
 
-#define QDIO_ACTIVATE_DELAY 5 /* according to brenton belmar and paul
-				 gioquindo it can take up to 5ms before
-				 queues are really active */
-
 #define QDIO_NO_USE_COUNT_TIME 10
 #define QDIO_NO_USE_COUNT_TIMEOUT 1000 /* wait for 1 sec on each q before
 					  exiting without having use_count
 					  of the queue to 0 */
 
 #define QDIO_ESTABLISH_TIMEOUT 1000
-#define QDIO_ACTIVATE_TIMEOUT 100
+#define QDIO_ACTIVATE_TIMEOUT 5
 #define QDIO_CLEANUP_CLEAR_TIMEOUT 20000
 #define QDIO_CLEANUP_HALT_TIMEOUT 10000
 
-#define QDIO_IRQ_STATE_FRESH 0 /* must be 0 -> memset has set it to 0 */
-#define QDIO_IRQ_STATE_INACTIVE 1
-#define QDIO_IRQ_STATE_ESTABLISHED 2
-#define QDIO_IRQ_STATE_ACTIVE 3
-#define QDIO_IRQ_STATE_STOPPED 4
+enum qdio_irq_states {
+	QDIO_IRQ_STATE_INACTIVE,
+	QDIO_IRQ_STATE_ESTABLISHED,
+	QDIO_IRQ_STATE_ACTIVE,
+	QDIO_IRQ_STATE_STOPPED,
+	QDIO_IRQ_STATE_CLEANUP,
+	QDIO_IRQ_STATE_ERR,
+	NR_QDIO_IRQ_STATES,
+};
 
 /* used as intparm in do_IO: */
 #define QDIO_DOING_SENSEID 0
@@ -443,81 +443,6 @@
 #define CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS 0x08
 #define CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS 0x04
 
-struct qdio_chsc_area {
-	struct {
-		/* word 0 */
-		__u16 command_code1;
-		__u16 command_code2;
-		/* word 1 */
-		__u16 operation_code;
-		__u16 first_sch;
-		/* word 2 */
-		__u8 reserved1;
-		__u8 image_id;
-		__u16 last_sch;
-		/* word 3 */
-		__u32 reserved2;
-
-		/* word 4 */
-		union {
-			struct {
-				/* word 4&5 */
-				__u64 summary_indicator_addr;
-				/* word 6&7 */
-				__u64 subchannel_indicator_addr;
-				/* word 8 */
-				int ks:4;
-				int kc:4;
-				int reserved1:21;
-				int isc:3;
-				/* word 9&10 */
-				__u32 reserved2[2];
-				/* word 11 */
-				__u32 subsystem_id;
-				/* word 12-1015 */
-				__u32 reserved3[1004];
-			} __attribute__ ((packed,aligned(4))) set_chsc;
-			struct {
-				/* word 4&5 */
-				__u32 reserved1[2];	
-				/* word 6 */
-				__u32 delay_target;
-				/* word 7-1015 */
-				__u32 reserved4[1009];
-			} __attribute__ ((packed,aligned(4))) set_chsc_fast;
-			struct {
-				/* word 0 */
-				__u16 length;
-				__u16 response_code;
-				/* word 1 */
-				__u32 reserved1;
-				/* words 2 to 9 for st sch qdio data */
-				__u8 flags;
-				__u8 reserved2;
-				__u16 sch;
-				__u8 qfmt;
-				__u8 reserved3;
-				__u8 qdioac;
-				__u8 sch_class;
-				__u8 reserved4;
-				__u8 icnt;
-				__u8 reserved5;
-				__u8 ocnt;
-				/* plus 5 words of reserved fields */
-			} __attribute__ ((packed,aligned(8)))
-			store_qdio_data_response;
-		} operation_data_area;
-	} __attribute__ ((packed,aligned(8))) request_block;
-	struct {
-		/* word 0 */
-		__u16 length;
-		__u16 response_code;
-		/* word 1 */
-		__u32 reserved1;
-	} __attribute__ ((packed,aligned(8))) response_block;
-} __attribute__ ((packed,aligned(PAGE_SIZE)));
-
-
 #ifdef QDIO_PERFORMANCE_STATS
 struct qdio_perf_stats {
 	unsigned int tl_runs;
@@ -623,7 +548,7 @@
 	struct tasklet_struct tasklet;
 #endif /* QDIO_USE_TIMERS_FOR_POLLING */
 
-	unsigned int state;
+	enum qdio_irq_states state;
 
 	/* used to store the error condition during a data transfer */
 	unsigned int qdio_error;
@@ -674,7 +599,7 @@
 	unsigned int hydra_gives_outbound_pcis;
 	unsigned int sync_done_on_outb_pcis;
 
-	unsigned int state;
+	enum qdio_irq_states state;
 	struct semaphore setting_up_sema;
 
 	unsigned int no_input_qs;
@@ -694,13 +619,8 @@
 
 	struct qib qib;
 	
-	/* Functions called via the generic cio layer */
-	void (*cleanup_irq) (struct ccw_device *, unsigned long, struct irb *);
-	void (*cleanup_timeout) (struct ccw_device *);
-	void (*establish_irq) (struct ccw_device *, unsigned long,
-			       struct irb *);
-	void (*establish_timeout) (struct ccw_device *);
-	void (*handler) (struct ccw_device *, unsigned long, struct irb *);
+ 	void (*original_int_handler) (struct ccw_device *,
+ 				      unsigned long, struct irb *);
 
 };
 #endif
diff -urN linux-2.5.67/drivers/s390/cio/requestirq.c linux-2.5.67-s390/drivers/s390/cio/requestirq.c
--- linux-2.5.67/drivers/s390/cio/requestirq.c	Mon Apr  7 19:32:16 2003
+++ linux-2.5.67-s390/drivers/s390/cio/requestirq.c	Mon Apr 14 19:11:50 2003
@@ -44,7 +44,11 @@
 	/*
 	 * Let's build our path group ID here.
 	 */
-	global_pgid.cpu_addr = *(__u16 *) __LC_CPUADDR;
+#ifdef CONFIG_SMP
+	global_pgid.cpu_addr = hard_smp_processor_id();
+#else
+	global_pgid.cpu_addr = 0;
+#endif
 	global_pgid.cpu_id = ((cpuid_t *) __LC_CPUID)->ident;
 	global_pgid.cpu_model = ((cpuid_t *) __LC_CPUID)->machine;
 	global_pgid.tod_high = (__u32) (get_clock() >> 32);
diff -urN linux-2.5.67/drivers/s390/s390mach.c linux-2.5.67-s390/drivers/s390/s390mach.c
--- linux-2.5.67/drivers/s390/s390mach.c	Mon Apr  7 19:32:58 2003
+++ linux-2.5.67-s390/drivers/s390/s390mach.c	Mon Apr 14 19:11:50 2003
@@ -21,7 +21,7 @@
 
 extern void css_process_crw(int);
 extern void chsc_process_crw(void);
-extern void chp_process_crw(int);
+extern void chp_process_crw(int, int);
 
 static void
 s390_handle_damage(char *msg)
@@ -62,7 +62,17 @@
 			break;
 		case CRW_RSC_CPATH:
 			pr_debug("source is channel path %02X\n", crw.rsid);
-			chp_process_crw(crw.rsid);
+			switch (crw.erc) {
+			case CRW_ERC_IPARM: /* Path has come. */
+				chp_process_crw(crw.rsid, 1);
+				break;
+			case CRW_ERC_PERRI: /* Path has gone. */
+				chp_process_crw(crw.rsid, 0);
+				break;
+			default:
+				pr_debug("Don't know how to handle erc=%x\n",
+					 crw.erc);
+			}
 			break;
 		case CRW_RSC_CONFIG:
 			pr_debug("source is configuration-alert facility\n");

