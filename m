Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWKGPzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWKGPzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWKGPzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:55:52 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:53538 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S932682AbWKGPz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:55:27 -0500
Date: Tue, 7 Nov 2006 16:55:56 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC/Patch 4/5] s390: Make the per-subchannel lock dynamic.
Message-ID: <20061107165556.6eaa733f@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061107163730.0c8f3dad@gondolin.boeblingen.de.ibm.com>
References: <20061107163730.0c8f3dad@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Convert the subchannel lock to a pointer to a lock. Needed for the dynamic
subchannel mapping patch.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/s390/cio/chsc.c       |   28 ++++++++++----------
 drivers/s390/cio/cio.c        |   58 +++++++++++++++++++++++++++++-------------
 drivers/s390/cio/cio.h        |    4 ++
 drivers/s390/cio/css.c        |   22 ++++++++-------
 drivers/s390/cio/device.c     |   21 ++++++++++-----
 drivers/s390/cio/device_ops.c |   28 ++++++++++----------
 6 files changed, 98 insertions(+), 63 deletions(-)

--- linux-2.6-CH.orig/drivers/s390/cio/chsc.c
+++ linux-2.6-CH/drivers/s390/cio/chsc.c
@@ -183,7 +183,7 @@ css_get_ssd_info(struct subchannel *sch)
 	page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!page)
 		return -ENOMEM;
-	spin_lock_irq(&sch->lock);
+	spin_lock_irq(sch->lock);
 	ret = chsc_get_sch_desc_irq(sch, page);
 	if (ret) {
 		static int cio_chsc_err_msg;
@@ -197,7 +197,7 @@ css_get_ssd_info(struct subchannel *sch)
 			cio_chsc_err_msg = 1;
 		}
 	}
-	spin_unlock_irq(&sch->lock);
+	spin_unlock_irq(sch->lock);
 	free_page((unsigned long)page);
 	if (!ret) {
 		int j, chpid, mask;
@@ -233,7 +233,7 @@ s390_subchannel_remove_chpid(struct devi
 	if (j >= 8)
 		return 0;
 
-	spin_lock_irq(&sch->lock);
+	spin_lock_irq(sch->lock);
 
 	stsch(sch->schid, &schib);
 	if (!schib.pmcw.dnv)
@@ -263,10 +263,10 @@ s390_subchannel_remove_chpid(struct devi
 	else if (sch->lpm == mask)
 		goto out_unreg;
 out_unlock:
-	spin_unlock_irq(&sch->lock);
+	spin_unlock_irq(sch->lock);
 	return 0;
 out_unreg:
-	spin_unlock_irq(&sch->lock);
+	spin_unlock_irq(sch->lock);
 	sch->lpm = 0;
 	if (css_enqueue_subchannel_slow(sch->schid)) {
 		css_clear_subchannel_slow_list();
@@ -376,12 +376,12 @@ __s390_process_res_acc(struct subchannel
 		/* Check if a subchannel is newly available. */
 		return s390_process_res_acc_new_sch(schid);
 
-	spin_lock_irq(&sch->lock);
+	spin_lock_irq(sch->lock);
 
 	chp_mask = s390_process_res_acc_sch(res_data, sch);
 
 	if (chp_mask == 0) {
-		spin_unlock_irq(&sch->lock);
+		spin_unlock_irq(sch->lock);
 		put_device(&sch->dev);
 		return 0;
 	}
@@ -395,7 +395,7 @@ __s390_process_res_acc(struct subchannel
 	else if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
 
-	spin_unlock_irq(&sch->lock);
+	spin_unlock_irq(sch->lock);
 	put_device(&sch->dev);
 	return 0;
 }
@@ -633,21 +633,21 @@ __chp_add(struct subchannel_id schid, vo
 	if (!sch)
 		/* Check if the subchannel is now available. */
 		return __chp_add_new_sch(schid);
-	spin_lock_irq(&sch->lock);
+	spin_lock_irq(sch->lock);
 	for (i=0; i<8; i++) {
 		mask = 0x80 >> i;
 		if ((sch->schib.pmcw.pim & mask) &&
 		    (sch->schib.pmcw.chpid[i] == chp->id)) {
 			if (stsch(sch->schid, &sch->schib) != 0) {
 				/* Endgame. */
-				spin_unlock_irq(&sch->lock);
+				spin_unlock_irq(sch->lock);
 				return -ENXIO;
 			}
 			break;
 		}
 	}
 	if (i==8) {
-		spin_unlock_irq(&sch->lock);
+		spin_unlock_irq(sch->lock);
 		return 0;
 	}
 	sch->lpm = ((sch->schib.pmcw.pim &
@@ -658,7 +658,7 @@ __chp_add(struct subchannel_id schid, vo
 	if (sch->driver && sch->driver->verify)
 		sch->driver->verify(&sch->dev);
 
-	spin_unlock_irq(&sch->lock);
+	spin_unlock_irq(sch->lock);
 	put_device(&sch->dev);
 	return 0;
 }
@@ -731,7 +731,7 @@ __s390_subchannel_vary_chpid(struct subc
 	if (!sch->ssd_info.valid)
 		return;
 	
-	spin_lock_irqsave(&sch->lock, flags);
+	spin_lock_irqsave(sch->lock, flags);
 	old_lpm = sch->lpm;
 	for (chp = 0; chp < 8; chp++) {
 		if (sch->ssd_info.chpid[chp] != chpid)
@@ -760,7 +760,7 @@ __s390_subchannel_vary_chpid(struct subc
 		}
 		break;
 	}
-	spin_unlock_irqrestore(&sch->lock, flags);
+	spin_unlock_irqrestore(sch->lock, flags);
 }
 
 static int
--- linux-2.6-CH.orig/drivers/s390/cio/cio.c
+++ linux-2.6-CH/drivers/s390/cio/cio.c
@@ -141,11 +141,11 @@ cio_tpi(void)
 		return 1;
 	local_bh_disable();
 	irq_enter ();
-	spin_lock(&sch->lock);
+	spin_lock(sch->lock);
 	memcpy (&sch->schib.scsw, &irb->scsw, sizeof (struct scsw));
 	if (sch->driver && sch->driver->irq)
 		sch->driver->irq(&sch->dev);
-	spin_unlock(&sch->lock);
+	spin_unlock(sch->lock);
 	irq_exit ();
 	_local_bh_enable();
 	return 1;
@@ -494,6 +494,15 @@ cio_disable_subchannel (struct subchanne
 	return ret;
 }
 
+static int cio_create_sch_lock(struct subchannel *sch)
+{
+	sch->lock = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
+	if (!sch->lock)
+		return -ENOMEM;
+	spin_lock_init(sch->lock);
+	return 0;
+}
+
 /*
  * cio_validate_subchannel()
  *
@@ -511,6 +520,7 @@ cio_validate_subchannel (struct subchann
 {
 	char dbf_txt[15];
 	int ccode;
+	int err;
 
 	sprintf (dbf_txt, "valsch%x", schid.sch_no);
 	CIO_TRACE_EVENT (4, dbf_txt);
@@ -518,9 +528,15 @@ cio_validate_subchannel (struct subchann
 	/* Nuke all fields. */
 	memset(sch, 0, sizeof(struct subchannel));
 
-	spin_lock_init(&sch->lock);
+	sch->schid = schid;
+	if (cio_is_console(schid)) {
+		sch->lock = cio_get_console_lock();
+	} else {
+		err = cio_create_sch_lock(sch);
+		if (err)
+			goto out;
+	}
 	mutex_init(&sch->reg_mutex);
-
 	/* Set a name for the subchannel */
 	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
 		  schid.sch_no);
@@ -532,10 +548,10 @@ cio_validate_subchannel (struct subchann
 	 *  is not valid.
 	 */
 	ccode = stsch_err (schid, &sch->schib);
-	if (ccode)
-		return (ccode == 3) ? -ENXIO : ccode;
-
-	sch->schid = schid;
+	if (ccode) {
+		err = (ccode == 3) ? -ENXIO : ccode;
+		goto out;
+	}
 	/* Copy subchannel type from path management control word. */
 	sch->st = sch->schib.pmcw.st;
 
@@ -548,14 +564,16 @@ cio_validate_subchannel (struct subchann
 			  "non-I/O subchannel type %04X\n",
 			  sch->schid.ssid, sch->schid.sch_no, sch->st);
 		/* We stop here for non-io subchannels. */
-		return sch->st;
+		err = sch->st;
+		goto out;
 	}
 
 	/* Initialization for io subchannels. */
-	if (!sch->schib.pmcw.dnv)
+	if (!sch->schib.pmcw.dnv) {
 		/* io subchannel but device number is invalid. */
-		return -ENODEV;
-
+		err = -ENODEV;
+		goto out;
+	}
 	/* Devno is valid. */
 	if (is_blacklisted (sch->schid.ssid, sch->schib.pmcw.dev)) {
 		/*
@@ -565,7 +583,8 @@ cio_validate_subchannel (struct subchann
 		CIO_MSG_EVENT(0, "Blacklisted device detected "
 			      "at devno %04X, subchannel set %x\n",
 			      sch->schib.pmcw.dev, sch->schid.ssid);
-		return -ENODEV;
+		err = -ENODEV;
+		goto out;
 	}
 	sch->opm = 0xff;
 	if (!cio_is_console(sch->schid))
@@ -593,6 +612,11 @@ cio_validate_subchannel (struct subchann
 	if ((sch->lpm & (sch->lpm - 1)) != 0)
 		sch->schib.pmcw.mp = 1;	/* multipath mode */
 	return 0;
+out:
+	if (!cio_is_console(schid))
+		kfree(sch->lock);
+	sch->lock = NULL;
+	return err;
 }
 
 /*
@@ -635,7 +659,7 @@ do_IRQ (struct pt_regs *regs)
 		}
 		sch = (struct subchannel *)(unsigned long)tpi_info->intparm;
 		if (sch)
-			spin_lock(&sch->lock);
+			spin_lock(sch->lock);
 		/* Store interrupt response block to lowcore. */
 		if (tsch (tpi_info->schid, irb) == 0 && sch) {
 			/* Keep subchannel information word up to date. */
@@ -646,7 +670,7 @@ do_IRQ (struct pt_regs *regs)
 				sch->driver->irq(&sch->dev);
 		}
 		if (sch)
-			spin_unlock(&sch->lock);
+			spin_unlock(sch->lock);
 		/*
 		 * Are more interrupts pending?
 		 * If so, the tpi instruction will update the lowcore
@@ -685,10 +709,10 @@ wait_cons_dev (void)
 	__ctl_load (cr6, 6, 6);
 
 	do {
-		spin_unlock(&console_subchannel.lock);
+		spin_unlock(console_subchannel.lock);
 		if (!cio_tpi())
 			cpu_relax();
-		spin_lock(&console_subchannel.lock);
+		spin_lock(console_subchannel.lock);
 	} while (console_subchannel.schib.scsw.actl != 0);
 	/*
 	 * restore previous isc value
--- linux-2.6-CH.orig/drivers/s390/cio/cio.h
+++ linux-2.6-CH/drivers/s390/cio/cio.h
@@ -87,7 +87,7 @@ struct orb {
 /* subchannel data structure used by I/O subroutines */
 struct subchannel {
 	struct subchannel_id schid;
-	spinlock_t lock;	/* subchannel lock */
+	spinlock_t *lock;	/* subchannel lock */
 	struct mutex reg_mutex;
 	enum {
 		SUBCHANNEL_TYPE_IO = 0,
@@ -137,9 +137,11 @@ extern struct subchannel *cio_probe_cons
 extern void cio_release_console(void);
 extern int cio_is_console(struct subchannel_id);
 extern struct subchannel *cio_get_console_subchannel(void);
+extern spinlock_t * cio_get_console_lock(void);
 #else
 #define cio_is_console(schid) 0
 #define cio_get_console_subchannel() NULL
+#define cio_get_console_lock() NULL;
 #endif
 
 extern int cio_show_msg;
--- linux-2.6-CH.orig/drivers/s390/cio/css.c
+++ linux-2.6-CH/drivers/s390/cio/css.c
@@ -91,9 +91,9 @@ css_free_subchannel(struct subchannel *s
 		/* Reset intparm to zeroes. */
 		sch->schib.pmcw.intparm = 0;
 		cio_modify(sch);
+		kfree(sch->lock);
 		kfree(sch);
 	}
-	
 }
 
 static void
@@ -102,8 +102,10 @@ css_subchannel_release(struct device *de
 	struct subchannel *sch;
 
 	sch = to_subchannel(dev);
-	if (!cio_is_console(sch->schid))
+	if (!cio_is_console(sch->schid)) {
+		kfree(sch->lock);
 		kfree(sch);
+	}
 }
 
 extern int css_get_ssd_info(struct subchannel *sch);
@@ -206,18 +208,18 @@ static int css_evaluate_known_subchannel
 	unsigned long flags;
 	enum { NONE, UNREGISTER, UNREGISTER_PROBE, REPROBE } action;
 
-	spin_lock_irqsave(&sch->lock, flags);
+	spin_lock_irqsave(sch->lock, flags);
 	disc = device_is_disconnected(sch);
 	if (disc && slow) {
 		/* Disconnected devices are evaluated directly only.*/
-		spin_unlock_irqrestore(&sch->lock, flags);
+		spin_unlock_irqrestore(sch->lock, flags);
 		return 0;
 	}
 	/* No interrupt after machine check - kill pending timers. */
 	device_kill_pending_timer(sch);
 	if (!disc && !slow) {
 		/* Non-disconnected devices are evaluated on the slow path. */
-		spin_unlock_irqrestore(&sch->lock, flags);
+		spin_unlock_irqrestore(sch->lock, flags);
 		return -EAGAIN;
 	}
 	event = css_get_subchannel_status(sch);
@@ -242,9 +244,9 @@ static int css_evaluate_known_subchannel
 		/* Ask driver what to do with device. */
 		action = UNREGISTER;
 		if (sch->driver && sch->driver->notify) {
-			spin_unlock_irqrestore(&sch->lock, flags);
+			spin_unlock_irqrestore(sch->lock, flags);
 			ret = sch->driver->notify(&sch->dev, event);
-			spin_lock_irqsave(&sch->lock, flags);
+			spin_lock_irqsave(sch->lock, flags);
 			if (ret)
 				action = NONE;
 		}
@@ -269,9 +271,9 @@ static int css_evaluate_known_subchannel
 	case UNREGISTER:
 	case UNREGISTER_PROBE:
 		/* Unregister device (will use subchannel lock). */
-		spin_unlock_irqrestore(&sch->lock, flags);
+		spin_unlock_irqrestore(sch->lock, flags);
 		css_sch_device_unregister(sch);
-		spin_lock_irqsave(&sch->lock, flags);
+		spin_lock_irqsave(sch->lock, flags);
 
 		/* Reset intparm to zeroes. */
 		sch->schib.pmcw.intparm = 0;
@@ -283,7 +285,7 @@ static int css_evaluate_known_subchannel
 	default:
 		break;
 	}
-	spin_unlock_irqrestore(&sch->lock, flags);
+	spin_unlock_irqrestore(sch->lock, flags);
 	/* Probe if necessary. */
 	if (action == UNREGISTER_PROBE)
 		ret = css_probe_device(sch->schid);
--- linux-2.6-CH.orig/drivers/s390/cio/device.c
+++ linux-2.6-CH/drivers/s390/cio/device.c
@@ -754,9 +754,9 @@ io_subchannel_register(void *data)
 		printk (KERN_WARNING "%s: could not register %s\n",
 			__func__, cdev->dev.bus_id);
 		put_device(&cdev->dev);
-		spin_lock_irqsave(&sch->lock, flags);
+		spin_lock_irqsave(sch->lock, flags);
 		sch->dev.driver_data = NULL;
-		spin_unlock_irqrestore(&sch->lock, flags);
+		spin_unlock_irqrestore(sch->lock, flags);
 		kfree (cdev->private);
 		kfree (cdev);
 		put_device(&sch->dev);
@@ -837,7 +837,7 @@ io_subchannel_recog(struct ccw_device *c
 
 	sch->dev.driver_data = cdev;
 	sch->driver = &io_subchannel_driver;
-	cdev->ccwlock = &sch->lock;
+	cdev->ccwlock = sch->lock;
 
 	/* Init private data. */
 	priv = cdev->private;
@@ -857,9 +857,9 @@ io_subchannel_recog(struct ccw_device *c
 	atomic_inc(&ccw_device_init_count);
 
 	/* Start async. device sensing. */
-	spin_lock_irq(&sch->lock);
+	spin_lock_irq(sch->lock);
 	rc = ccw_device_recognition(cdev);
-	spin_unlock_irq(&sch->lock);
+	spin_unlock_irq(sch->lock);
 	if (rc) {
 		if (atomic_dec_and_test(&ccw_device_init_count))
 			wake_up(&ccw_device_init_wq);
@@ -901,9 +901,9 @@ io_subchannel_probe (struct subchannel *
 
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc) {
-		spin_lock_irqsave(&sch->lock, flags);
+		spin_lock_irqsave(sch->lock, flags);
 		sch->dev.driver_data = NULL;
-		spin_unlock_irqrestore(&sch->lock, flags);
+		spin_unlock_irqrestore(sch->lock, flags);
 		if (cdev->dev.release)
 			cdev->dev.release(&cdev->dev);
 	}
@@ -1010,6 +1010,13 @@ static struct ccw_device console_cdev;
 static struct ccw_device_private console_private;
 static int console_cdev_in_use;
 
+static DEFINE_SPINLOCK(ccw_console_lock);
+
+spinlock_t * cio_get_console_lock(void)
+{
+	return &ccw_console_lock;
+}
+
 static int
 ccw_device_console_enable (struct ccw_device *cdev, struct subchannel *sch)
 {
--- linux-2.6-CH.orig/drivers/s390/cio/device_ops.c
+++ linux-2.6-CH/drivers/s390/cio/device_ops.c
@@ -316,9 +316,9 @@ __ccw_device_retry_loop(struct ccw_devic
 			ccw_device_set_timeout(cdev, 0);
 		if (ret == -EBUSY) {
 			/* Try again later. */
-			spin_unlock_irq(&sch->lock);
+			spin_unlock_irq(sch->lock);
 			msleep(10);
-			spin_lock_irq(&sch->lock);
+			spin_lock_irq(sch->lock);
 			continue;
 		}
 		if (ret != 0)
@@ -326,12 +326,12 @@ __ccw_device_retry_loop(struct ccw_devic
 			break;
 		/* Wait for end of request. */
 		cdev->private->intparm = magic;
-		spin_unlock_irq(&sch->lock);
+		spin_unlock_irq(sch->lock);
 		wait_event(cdev->private->wait_q,
 			   (cdev->private->intparm == -EIO) ||
 			   (cdev->private->intparm == -EAGAIN) ||
 			   (cdev->private->intparm == 0));
-		spin_lock_irq(&sch->lock);
+		spin_lock_irq(sch->lock);
 		/* Check at least for channel end / device end */
 		if (cdev->private->intparm == -EIO) {
 			/* Non-retryable error. */
@@ -342,9 +342,9 @@ __ccw_device_retry_loop(struct ccw_devic
 			/* Success. */
 			break;
 		/* Try again later. */
-		spin_unlock_irq(&sch->lock);
+		spin_unlock_irq(sch->lock);
 		msleep(10);
-		spin_lock_irq(&sch->lock);
+		spin_lock_irq(sch->lock);
 	} while (1);
 
 	return ret;
@@ -389,7 +389,7 @@ read_dev_chars (struct ccw_device *cdev,
 		return ret;
 	}
 
-	spin_lock_irq(&sch->lock);
+	spin_lock_irq(sch->lock);
 	/* Save interrupt handler. */
 	handler = cdev->handler;
 	/* Temporarily install own handler. */
@@ -406,7 +406,7 @@ read_dev_chars (struct ccw_device *cdev,
 
 	/* Restore interrupt handler. */
 	cdev->handler = handler;
-	spin_unlock_irq(&sch->lock);
+	spin_unlock_irq(sch->lock);
 
 	clear_normalized_cda (rdc_ccw);
 	kfree(rdc_ccw);
@@ -463,7 +463,7 @@ read_conf_data_lpm (struct ccw_device *c
 	rcd_ccw->count = ciw->count;
 	rcd_ccw->flags = CCW_FLAG_SLI;
 
-	spin_lock_irq(&sch->lock);
+	spin_lock_irq(sch->lock);
 	/* Save interrupt handler. */
 	handler = cdev->handler;
 	/* Temporarily install own handler. */
@@ -480,7 +480,7 @@ read_conf_data_lpm (struct ccw_device *c
 
 	/* Restore interrupt handler. */
 	cdev->handler = handler;
-	spin_unlock_irq(&sch->lock);
+	spin_unlock_irq(sch->lock);
 
  	/*
  	 * on success we update the user input parms
@@ -537,7 +537,7 @@ ccw_device_stlck(struct ccw_device *cdev
 		kfree(buf);
 		return -ENOMEM;
 	}
-	spin_lock_irqsave(&sch->lock, flags);
+	spin_lock_irqsave(sch->lock, flags);
 	ret = cio_enable_subchannel(sch, 3);
 	if (ret)
 		goto out_unlock;
@@ -559,9 +559,9 @@ ccw_device_stlck(struct ccw_device *cdev
 		goto out_unlock;
 	}
 	cdev->private->irb.scsw.actl |= SCSW_ACTL_START_PEND;
-	spin_unlock_irqrestore(&sch->lock, flags);
+	spin_unlock_irqrestore(sch->lock, flags);
 	wait_event(cdev->private->wait_q, cdev->private->irb.scsw.actl == 0);
-	spin_lock_irqsave(&sch->lock, flags);
+	spin_lock_irqsave(sch->lock, flags);
 	cio_disable_subchannel(sch); //FIXME: return code?
 	if ((cdev->private->irb.scsw.dstat !=
 	     (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
@@ -572,7 +572,7 @@ ccw_device_stlck(struct ccw_device *cdev
 out_unlock:
 	kfree(buf);
 	kfree(buf2);
-	spin_unlock_irqrestore(&sch->lock, flags);
+	spin_unlock_irqrestore(sch->lock, flags);
 	return ret;
 }
 
