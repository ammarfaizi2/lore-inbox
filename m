Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266453AbTBCOkp>; Mon, 3 Feb 2003 09:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbTBCOkp>; Mon, 3 Feb 2003 09:40:45 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:50566 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S266453AbTBCOke>; Mon, 3 Feb 2003 09:40:34 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 fixes (1/12).
Date: Mon, 3 Feb 2003 15:47:01 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302031547.01824.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

updates for the channel subsystem driver

This adds the missing support for chp machine checks, i.e.
enabling or disabling a set of devices from the service element.
Some minor bugs in the driver are fixed as well.
diff -urN linux-2.5.59/drivers/s390/cio/chsc.c 
linux-2.5.59-s390/drivers/s390/cio/chsc.c
--- linux-2.5.59/drivers/s390/cio/chsc.c	Fri Jan 17 03:22:16 2003
+++ linux-2.5.59-s390/drivers/s390/cio/chsc.c	Mon Feb  3 14:56:08 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.46 $
+ *   $Revision: 1.53 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -53,12 +53,6 @@
 	return test_bit (sch->schib.pmcw.chpid[chp], chpids_logical);
 }
 
-static inline void
-chsc_clear_chpid(struct subchannel *sch, int chp)
-{
-	clear_bit(sch->schib.pmcw.chpid[chp], chpids);
-}
-
 void
 chsc_validate_chpids(struct subchannel *sch)
 {
@@ -69,17 +63,10 @@
 
 	for (chp = 0; chp <= 7; chp++) {
 		mask = 0x80 >> chp;
-		if (sch->lpm & mask) {
+		if (sch->lpm & mask)
 			if (!chsc_chpid_logical(sch, chp))
 				/* disable using this path */
 				sch->lpm &= ~mask;
-		} else {
-			/* This chpid is not
-			 * available to us */
-			chsc_clear_chpid(sch, chp);
-			if (test_bit(chp, chpids_known))
-				set_chp_status(chp, CHP_STANDBY);
-		}
 	}
 }
 
@@ -528,6 +515,98 @@
 	schedule_work(&work);
 }
 
+static void
+chp_add(int chpid)
+{
+	struct subchannel *sch;
+	int irq, ret;
+	char dbf_txt[15];
+
+	if (!test_bit(chpid, chpids_logical))
+		return; /* no need to do the rest */
+	
+	sprintf(dbf_txt, "cadd%x", chpid);
+	CIO_TRACE_EVENT(2, dbf_txt);
+
+	for (irq = 0; irq <= __MAX_SUBCHANNELS; irq++) {
+		int i;
+
+		sch = ioinfo[irq];
+		if (!sch) {
+			ret = css_probe_device(irq);
+			if (ret == -ENXIO)
+				/* We're through */
+				return;
+			continue;
+		}
+	
+		spin_lock(&sch->lock);
+		for (i=0; i<8; i++)
+			if (sch->schib.pmcw.chpid[i] == chpid) {
+				if (stsch(sch->irq, &sch->schib) != 0) {
+					/* Endgame. */
+					spin_unlock(&sch->lock);
+					return;
+				}
+				break;
+			}
+		if (i==8) {
+			spin_unlock(&sch->lock);
+			return;
+		}
+		sch->lpm = (sch->schib.pmcw.pim &
+			    sch->schib.pmcw.pam &
+			    sch->schib.pmcw.pom)
+			| 0x80 >> i;
+
+		chsc_validate_chpids(sch);
+
+		dev_fsm_event(sch->dev.driver_data, DEV_EVENT_VERIFY);
+
+		spin_unlock(&sch->lock);
+	}
+}
+
+/* 
+ * Handling of crw machine checks with channel path source.
+ */
+void
+chp_process_crw(int chpid)
+{
+	/*
+	 * Update our descriptions. We need this since we don't always
+	 * get machine checks for path come and can't rely on our information
+	 * being consistent otherwise.
+	 */
+	chsc_get_sch_descriptions();
+	if (!cio_chsc_desc_avail) {
+		/*
+		 * Something went wrong...
+		 * We can't reliably say whether a path was there before.
+		 */
+		CIO_CRW_EVENT(0, "Error: Could not retrieve "
+			      "subchannel descriptions, will not process chp"
+			      "machine check...\n");
+		return;
+	}
+
+	if (!test_bit(chpid, chpids)) {
+		/* Path has gone. We use the link incident routine.*/
+		s390_set_chpid_offline(chpid);
+	} else {
+		/* 
+		 * Path has come. Allocate a new channel path structure,
+		 * if needed. 
+		 */
+		if (chps[chpid] == NULL)
+			new_channel_path(chpid, CHP_ONLINE);
+		else
+			set_chp_status(chpid, CHP_ONLINE);
+		/* Avoid the extra overhead in process_rec_acc. */
+		chp_add(chpid);
+	}
+}
+
 /*
  * Function: s390_vary_chpid
  * Varies the specified chpid online or offline
@@ -667,6 +746,7 @@
 	chp = kmalloc(sizeof(struct channel_path), GFP_KERNEL);
 	if (!chp)
 		return -ENOMEM;
+	memset(chp, 0, sizeof(struct channel_path));
 
 	chps[chpid] = chp;
 
diff -urN linux-2.5.59/drivers/s390/cio/cio.c 
linux-2.5.59-s390/drivers/s390/cio/cio.c
--- linux-2.5.59/drivers/s390/cio/cio.c	Fri Jan 17 03:22:55 2003
+++ linux-2.5.59-s390/drivers/s390/cio/cio.c	Mon Feb  3 14:56:08 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.90 $
+ *   $Revision: 1.91 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -197,8 +197,7 @@
 	sch->orb.pfch = sch->options.prefetch == 0;
 	sch->orb.spnd = sch->options.suspend;
 	sch->orb.ssic = sch->options.suspend && sch->options.inter;
-	sch->orb.lpm = (lpm != 0) ? (lpm & sch->lpm) : sch->lpm;
-
+	sch->orb.lpm = (lpm != 0) ? lpm : sch->lpm;
 #ifdef CONFIG_ARCH_S390X
 	/*
 	 * for 64 bit we always support 64 bit IDAWs with 4k page size only
diff -urN linux-2.5.59/drivers/s390/cio/device.c 
linux-2.5.59-s390/drivers/s390/cio/device.c
--- linux-2.5.59/drivers/s390/cio/device.c	Fri Jan 17 03:22:27 2003
+++ linux-2.5.59-s390/drivers/s390/cio/device.c	Mon Feb  3 14:56:08 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device.c
  *  bus driver for ccw devices
- *   $Revision: 1.45 $
+ *   $Revision: 1.49 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -215,6 +215,8 @@
 void
 ccw_device_set_offline(struct ccw_device *cdev)
 {
+	int ret;
+
 	if (!cdev)
 		return;
 	if (!cdev->online || !cdev->drv)
@@ -226,23 +228,36 @@
 
 	cdev->online = 0;
 	spin_lock_irq(cdev->ccwlock);
-	ccw_device_offline(cdev);
+	ret = ccw_device_offline(cdev);
 	spin_unlock_irq(cdev->ccwlock);
-	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	if (ret == 0)
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	else
+		//FIXME: we can't fail!
+		pr_debug(KERN_ERR"ccw_device_offline returned %d, device %s\n",
+			 ret, cdev->dev.bus_id);
 }
 
 void
 ccw_device_set_online(struct ccw_device *cdev)
 {
-	if (!cdev || !cdev->handler)
+	int ret;
+
+	if (!cdev)
 		return;
 	if (cdev->online || !cdev->drv)
 		return;
 
 	spin_lock_irq(cdev->ccwlock);
-	ccw_device_online(cdev);
+	ret = ccw_device_online(cdev);
 	spin_unlock_irq(cdev->ccwlock);
-	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	if (ret == 0)
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	else {
+		pr_debug(KERN_ERR"ccw_device_online returned %d, device %s\n",
+			 ret, cdev->dev.bus_id);
+		return;
+	}
 	if (cdev->private->state != DEV_STATE_ONLINE)
 		return;
 	if (!cdev->drv->set_online || cdev->drv->set_online(cdev) == 0) {
@@ -250,9 +265,13 @@
 		return;
 	}
 	spin_lock_irq(cdev->ccwlock);
-	ccw_device_offline(cdev);
+	ret = ccw_device_offline(cdev);
 	spin_unlock_irq(cdev->ccwlock);
-	wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	if (ret == 0)
+		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
+	else 
+		pr_debug(KERN_ERR"ccw_device_offline returned %d, device %s\n",
+			 ret, cdev->dev.bus_id);
 }
 
 static ssize_t
diff -urN linux-2.5.59/drivers/s390/cio/device_ops.c 
linux-2.5.59-s390/drivers/s390/cio/device_ops.c
--- linux-2.5.59/drivers/s390/cio/device_ops.c	Fri Jan 17 03:22:27 2003
+++ linux-2.5.59-s390/drivers/s390/cio/device_ops.c	Mon Feb  3 14:56:08 2003
@@ -48,7 +48,8 @@
 	if (!cdev)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE &&
-	    cdev->private->state != DEV_STATE_W4SENSE)
+	    cdev->private->state != DEV_STATE_W4SENSE &&
+	    cdev->private->state != DEV_STATE_QDIO_ACTIVE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
 	if (!sch)
@@ -122,6 +123,15 @@
 {
 	struct subchannel *sch;
 	unsigned int stctl;
+	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
+
+	if (cdev->private->state == DEV_STATE_QDIO_ACTIVE) {
+		if (cdev->private->qdio_data)
+			handler = cdev->private->qdio_data->handler;
+		else
+			handler = NULL;
+	} else
+		handler = cdev->handler;
 
 	sch = to_subchannel(cdev->dev.parent);
 
@@ -144,13 +154,9 @@
 	/*
 	 * Now we are ready to call the device driver interrupt handler.
 	 */
-	if (cdev->private->state == DEV_STATE_QDIO_ACTIVE) {
-		if (cdev->private->qdio_data &&
-		    cdev->private->qdio_data->handler)
-			cdev->private->qdio_data->handler(cdev, sch->u_intparm,
-							  &cdev->private->irb);
-	} else
-		cdev->handler (cdev, sch->u_intparm, &cdev->private->irb);
+	if (handler)
+		handler(cdev, sch->u_intparm, &cdev->private->irb);
+
 	/*
 	 * Clear the old and now useless interrupt response block.
 	 */
diff -urN linux-2.5.59/drivers/s390/cio/device_pgid.c 
linux-2.5.59-s390/drivers/s390/cio/device_pgid.c
--- linux-2.5.59/drivers/s390/cio/device_pgid.c	Fri Jan 17 03:22:15 2003
+++ linux-2.5.59-s390/drivers/s390/cio/device_pgid.c	Mon Feb  3 14:56:08 2003
@@ -141,6 +141,8 @@
 	struct subchannel *sch;
 	struct irb *irb;
 	int ret;
+	int opm;
+	int i;
 
 	irb = (struct irb *) __LC_IRB;
 	/* Ignore unsolicited interrupts. */
@@ -154,6 +156,16 @@
 	/* 0, -ETIME, -EOPNOTSUPP, -EAGAIN, -EACCES or -EUSERS */
 	case 0:			/* Sense Path Group ID successful. */
 		cdev->private->flags.pgid_supp = 1;
+		opm = sch->schib.pmcw.pim &
+			sch->schib.pmcw.pam &
+			sch->schib.pmcw.pom;
+		for (i=0;i<8;i++) {
+			if (opm == (0x80 << i)) {
+				/* Don't group single path devices. */
+				cdev->private->flags.pgid_supp = 0;
+				break;
+			}
+		}
 		if (cdev->private->pgid.inf.ps.state1 == SNID_STATE1_RESET)
 			memcpy(&cdev->private->pgid, &global_pgid,
 			       sizeof(struct pgid));
diff -urN linux-2.5.59/drivers/s390/cio/device_status.c 
linux-2.5.59-s390/drivers/s390/cio/device_status.c
--- linux-2.5.59/drivers/s390/cio/device_status.c	Fri Jan 17 03:22:08 2003
+++ linux-2.5.59-s390/drivers/s390/cio/device_status.c	Mon Feb  3 14:56:08 
2003
@@ -348,7 +348,7 @@
 ccw_device_accumulate_and_sense(struct ccw_device *cdev, struct irb *irb)
 {
 	ccw_device_accumulate_irb(cdev, irb);
-	if (irb->scsw.actl != 0)
+	if ((irb->scsw.actl  & (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT)) != 0)
 		return -EBUSY;
 	/* Check for basic sense. */
 	if (cdev->private->flags.dosense &&
diff -urN linux-2.5.59/drivers/s390/cio/ioasm.h 
linux-2.5.59-s390/drivers/s390/cio/ioasm.h
--- linux-2.5.59/drivers/s390/cio/ioasm.h	Fri Jan 17 03:23:01 2003
+++ linux-2.5.59-s390/drivers/s390/cio/ioasm.h	Mon Feb  3 14:56:08 2003
@@ -2,83 +2,6 @@
 #define S390_CIO_IOASM_H
 
 /*
- * area for channel subsystem call
- */
-struct chsc_area {
-	struct {
-		/* word 0 */
-		__u16 command_code1;
-		__u16 command_code2;
-		union {
-			struct {
-				/* word 1 */
-				__u32 reserved1;
-				/* word 2 */
-				__u32 reserved2;
-			} __attribute__ ((packed,aligned(8))) sei_req;
-			struct {
-				/* word 1 */
-				__u16 reserved1;
-				__u16 f_sch;	 /* first subchannel */
-				/* word 2 */
-				__u16 reserved2;
-				__u16 l_sch;	/* last subchannel */
-			} __attribute__ ((packed,aligned(8))) ssd_req;
-		} request_block_data;
-		/* word 3 */
-		__u32 reserved3;
-	} __attribute__ ((packed,aligned(8))) request_block;
-	struct {
-		/* word 0 */
-		__u16 length;
-		__u16 response_code;
-		/* word 1 */
-		__u32 reserved1;
-		union {
-			struct {
-				/* word 2 */
-				__u8  flags;
-				__u8  vf;	  /* validity flags */
-				__u8  rs;	  /* reporting source */
-				__u8  cc;	  /* content code */
-				/* word 3 */
-				__u16 fla;	  /* full link address */
-				__u16 rsid;	  /* reporting source id */
-				/* word 4 */
-				__u32 reserved2;
-				/* word 5 */
-				__u32 reserved3;
-				/* word 6 */
-				__u32 ccdf;	  /* content-code dependent field */
-				/* word 7 */
-				__u32 reserved4;
-				/* word 8 */
-				__u32 reserved5;
-				/* word 9 */
-				__u32 reserved6;
-			} __attribute__ ((packed,aligned(8))) sei_res;
-			struct {
-				/* word 2 */
-				__u8 sch_valid : 1;
-				__u8 dev_valid : 1;
-				__u8 st	       : 3; /* subchannel type */
-				__u8 zeroes    : 3;
-				__u8  unit_addr;  /* unit address */
-				__u16 devno;	  /* device number */
-				/* word 3 */
-				__u8 path_mask;
-				__u8 fla_valid_mask;
-				__u16 sch;	  /* subchannel */
-				/* words 4-5 */
-				__u8 chpid[8];	  /* chpids 0-7 */
-				/* words 6-9 */
-				__u16 fla[8];	  /* full link addresses 0-7 */
-			} __attribute__ ((packed,aligned(8))) ssd_res;
-		} response_block_data;
-	} __attribute__ ((packed,aligned(8))) response_block;
-} __attribute__ ((packed,aligned(PAGE_SIZE)));
-
-/*
  * TPI info structure
  */
 struct tpi_info {
diff -urN linux-2.5.59/drivers/s390/s390mach.c 
linux-2.5.59-s390/drivers/s390/s390mach.c
--- linux-2.5.59/drivers/s390/s390mach.c	Fri Jan 17 03:22:56 2003
+++ linux-2.5.59-s390/drivers/s390/s390mach.c	Mon Feb  3 14:56:08 2003
@@ -21,6 +21,7 @@
 
 extern void css_process_crw(int);
 extern void chsc_process_crw(void);
+extern void chp_process_crw(int);
 
 static void
 s390_handle_damage(char *msg)
@@ -64,7 +65,8 @@
 		case CRW_RSC_CPATH:
 			pr_debug(KERN_NOTICE,
 				 "source is channel path %02X\n",
-				 pcrwe->crw.rsid);
+				 crw.rsid);
+			chp_process_crw(crw.rsid);
 			break;
 		case CRW_RSC_CONFIG:
 			pr_debug(KERN_NOTICE,

