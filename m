Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVLIP3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVLIP3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVLIP3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:29:07 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:32194 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964776AbVLIP2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:28:41 -0500
Date: Fri, 9 Dec 2005 16:28:29 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 13/17] s390: introduce for_each_subchannel.
Message-ID: <20051209152829.GN6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

[patch 13/17] s390: introduce for_each_subchannel.

for_each_subchannel() is an iterator calling a function for every
possible subchannel id until non-zero is returned. Convert the
current iterating functions to it.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/blacklist.c |   46 ++---
 drivers/s390/cio/chsc.c      |  372 ++++++++++++++++++++++---------------------
 drivers/s390/cio/cio.c       |   79 ++++-----
 drivers/s390/cio/css.c       |  110 ++++++------
 drivers/s390/cio/css.h       |    1 
 5 files changed, 318 insertions(+), 290 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2005-12-09 14:25:56.000000000 +0100
@@ -219,6 +219,27 @@ is_blacklisted (int devno)
 }
 
 #ifdef CONFIG_PROC_FS
+static int
+__s390_redo_validation(struct subchannel_id schid, void *data)
+{
+	int ret;
+	struct subchannel *sch;
+
+	sch = get_subchannel_by_schid(schid);
+	if (sch) {
+		/* Already known. */
+		put_device(&sch->dev);
+		return 0;
+	}
+	ret = css_probe_device(schid);
+	if (ret == -ENXIO)
+		return ret; /* We're through. */
+	if (ret == -ENOMEM)
+		/* Stop validation for now. Bad, but no need for a panic. */
+		return ret;
+	return 0;
+}
+
 /*
  * Function: s390_redo_validation
  * Look for no longer blacklisted devices
@@ -226,30 +247,9 @@ is_blacklisted (int devno)
 static inline void
 s390_redo_validation (void)
 {
-	struct subchannel_id schid;
-
 	CIO_TRACE_EVENT (0, "redoval");
-	init_subchannel_id(&schid);
-	do {
-		int ret;
-		struct subchannel *sch;
-
-		sch = get_subchannel_by_schid(schid);
-		if (sch) {
-			/* Already known. */
-			put_device(&sch->dev);
-			continue;
-		}
-		ret = css_probe_device(schid);
-		if (ret == -ENXIO)
-			break; /* We're through. */
-		if (ret == -ENOMEM)
-			/*
-			 * Stop validation for now. Bad, but no need for a
-			 * panic.
-			 */
-			break;
-	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+
+	for_each_subchannel(__s390_redo_validation, NULL);
 }
 
 /*
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2005-12-09 14:25:56.000000000 +0100
@@ -310,9 +310,14 @@ s390_set_chpid_offline( __u8 chpid)
 		queue_work(slow_path_wq, &slow_path_work);
 }
 
+struct res_acc_data {
+	struct channel_path *chp;
+	u32 fla_mask;
+	u16 fla;
+};
+
 static int
-s390_process_res_acc_sch(u8 chpid, __u16 fla, u32 fla_mask,
-			 struct subchannel *sch)
+s390_process_res_acc_sch(struct res_acc_data *res_data, struct subchannel *sch)
 {
 	int found;
 	int chp;
@@ -324,8 +329,9 @@ s390_process_res_acc_sch(u8 chpid, __u16
 		 * check if chpid is in information updated by ssd
 		 */
 		if (sch->ssd_info.valid &&
-		    sch->ssd_info.chpid[chp] == chpid &&
-		    (sch->ssd_info.fla[chp] & fla_mask) == fla) {
+		    sch->ssd_info.chpid[chp] == res_data->chp->id &&
+		    (sch->ssd_info.fla[chp] & res_data->fla_mask)
+		    == res_data->fla) {
 			found = 1;
 			break;
 		}
@@ -345,18 +351,80 @@ s390_process_res_acc_sch(u8 chpid, __u16
 	return 0x80 >> chp;
 }
 
+static inline int
+s390_process_res_acc_new_sch(struct subchannel_id schid)
+{
+	struct schib schib;
+	int ret;
+	/*
+	 * We don't know the device yet, but since a path
+	 * may be available now to the device we'll have
+	 * to do recognition again.
+	 * Since we don't have any idea about which chpid
+	 * that beast may be on we'll have to do a stsch
+	 * on all devices, grr...
+	 */
+	if (stsch(schid, &schib))
+		/* We're through */
+		return need_rescan ? -EAGAIN : -ENXIO;
+
+	/* Put it on the slow path. */
+	ret = css_enqueue_subchannel_slow(schid);
+	if (ret) {
+		css_clear_subchannel_slow_list();
+		need_rescan = 1;
+		return -EAGAIN;
+	}
+	return 0;
+}
+
 static int
-s390_process_res_acc (u8 chpid, __u16 fla, u32 fla_mask)
+__s390_process_res_acc(struct subchannel_id schid, void *data)
 {
+	int chp_mask, old_lpm;
+	struct res_acc_data *res_data;
 	struct subchannel *sch;
+
+	res_data = (struct res_acc_data *)data;
+	sch = get_subchannel_by_schid(schid);
+	if (!sch)
+		/* Check if a subchannel is newly available. */
+		return s390_process_res_acc_new_sch(schid);
+
+	spin_lock_irq(&sch->lock);
+
+	chp_mask = s390_process_res_acc_sch(res_data, sch);
+
+	if (chp_mask == 0) {
+		spin_unlock_irq(&sch->lock);
+		return 0;
+	}
+	old_lpm = sch->lpm;
+	sch->lpm = ((sch->schib.pmcw.pim &
+		     sch->schib.pmcw.pam &
+		     sch->schib.pmcw.pom)
+		    | chp_mask) & sch->opm;
+	if (!old_lpm && sch->lpm)
+		device_trigger_reprobe(sch);
+	else if (sch->driver && sch->driver->verify)
+		sch->driver->verify(&sch->dev);
+
+	spin_unlock_irq(&sch->lock);
+	put_device(&sch->dev);
+	return (res_data->fla_mask == 0xffff) ? -ENODEV : 0;
+}
+
+
+static int
+s390_process_res_acc (struct res_acc_data *res_data)
+{
 	int rc;
-	struct subchannel_id schid;
 	char dbf_txt[15];
 
-	sprintf(dbf_txt, "accpr%x", chpid);
+	sprintf(dbf_txt, "accpr%x", res_data->chp->id);
 	CIO_TRACE_EVENT( 2, dbf_txt);
-	if (fla != 0) {
-		sprintf(dbf_txt, "fla%x", fla);
+	if (res_data->fla != 0) {
+		sprintf(dbf_txt, "fla%x", res_data->fla);
 		CIO_TRACE_EVENT( 2, dbf_txt);
 	}
 
@@ -367,71 +435,11 @@ s390_process_res_acc (u8 chpid, __u16 fl
 	 * The more information we have (info), the less scanning
 	 * will we have to do.
 	 */
-
-	if (!get_chp_status(chpid))
-		return 0; /* no need to do the rest */
-
-	rc = 0;
-	init_subchannel_id(&schid);
-	do {
-		int chp_mask, old_lpm;
-
-		sch = get_subchannel_by_schid(schid);
-		if (!sch) {
-			struct schib schib;
-			int ret;
-			/*
-			 * We don't know the device yet, but since a path
-			 * may be available now to the device we'll have
-			 * to do recognition again.
-			 * Since we don't have any idea about which chpid
-			 * that beast may be on we'll have to do a stsch
-			 * on all devices, grr...
-			 */
-			if (stsch(schid, &schib)) {
-				/* We're through */
-				if (need_rescan)
-					rc = -EAGAIN;
-				break;
-			}
-			if (need_rescan) {
-				rc = -EAGAIN;
-				continue;
-			}
-			/* Put it on the slow path. */
-			ret = css_enqueue_subchannel_slow(schid);
-			if (ret) {
-				css_clear_subchannel_slow_list();
-				need_rescan = 1;
-			}
-			rc = -EAGAIN;
-			continue;
-		}
-	
-		spin_lock_irq(&sch->lock);
-
-		chp_mask = s390_process_res_acc_sch(chpid, fla, fla_mask, sch);
-
-		if (chp_mask == 0) {
-
-			spin_unlock_irq(&sch->lock);
-			continue;
-		}
-		old_lpm = sch->lpm;
-		sch->lpm = ((sch->schib.pmcw.pim &
-			     sch->schib.pmcw.pam &
-			     sch->schib.pmcw.pom)
-			    | chp_mask) & sch->opm;
-		if (!old_lpm && sch->lpm)
-			device_trigger_reprobe(sch);
-		else if (sch->driver && sch->driver->verify)
-			sch->driver->verify(&sch->dev);
-
-		spin_unlock_irq(&sch->lock);
-		put_device(&sch->dev);
-		if (fla_mask == 0xffff)
-			break;
-	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+	rc = for_each_subchannel(__s390_process_res_acc, res_data);
+	if (css_slow_subchannels_exist())
+		rc = -EAGAIN;
+	else if (rc != -EAGAIN)
+		rc = 0;
 	return rc;
 }
 
@@ -469,6 +477,7 @@ int
 chsc_process_crw(void)
 {
 	int chpid, ret;
+	struct res_acc_data res_data;
 	struct {
 		struct chsc_header request;
 		u32 reserved1;
@@ -503,7 +512,7 @@ chsc_process_crw(void)
 	do {
 		int ccode, status;
 		memset(sei_area, 0, sizeof(*sei_area));
-
+		memset(&res_data, 0, sizeof(struct res_acc_data));
 		sei_area->request = (struct chsc_header) {
 			.length = 0x0010,
 			.code   = 0x000e,
@@ -576,26 +585,23 @@ chsc_process_crw(void)
 			if (status < 0)
 				new_channel_path(sei_area->rsid);
 			else if (!status)
-				return 0;
-			if ((sei_area->vf & 0x80) == 0) {
-				pr_debug("chpid: %x\n", sei_area->rsid);
-				ret = s390_process_res_acc(sei_area->rsid,
-							   0, 0);
-			} else if ((sei_area->vf & 0xc0) == 0x80) {
-				pr_debug("chpid: %x link addr: %x\n",
-					 sei_area->rsid, sei_area->fla);
-				ret = s390_process_res_acc(sei_area->rsid,
-							   sei_area->fla,
-							   0xff00);
-			} else if ((sei_area->vf & 0xc0) == 0xc0) {
-				pr_debug("chpid: %x full link addr: %x\n",
-					 sei_area->rsid, sei_area->fla);
-				ret = s390_process_res_acc(sei_area->rsid,
-							   sei_area->fla,
-							   0xffff);
+				break;
+			res_data.chp = chps[sei_area->rsid];
+			pr_debug("chpid: %x", sei_area->rsid);
+			if ((sei_area->vf & 0xc0) != 0) {
+				res_data.fla = sei_area->fla;
+				if ((sei_area->vf & 0xc0) == 0xc0) {
+					pr_debug(" full link addr: %x",
+						 sei_area->fla);
+					res_data.fla_mask = 0xffff;
+				} else {
+					pr_debug(" link addr: %x",
+						 sei_area->fla);
+					res_data.fla_mask = 0xff00;
+				}
 			}
-			pr_debug("\n");
-			
+			ret = s390_process_res_acc(&res_data);
+			pr_debug("\n\n");
 			break;
 			
 		default: /* other stuff */
@@ -607,12 +613,70 @@ chsc_process_crw(void)
 	return ret;
 }
 
+static inline int
+__chp_add_new_sch(struct subchannel_id schid)
+{
+	struct schib schib;
+	int ret;
+
+	if (stsch(schid, &schib))
+		/* We're through */
+		return need_rescan ? -EAGAIN : -ENXIO;
+
+	/* Put it on the slow path. */
+	ret = css_enqueue_subchannel_slow(schid);
+	if (ret) {
+		css_clear_subchannel_slow_list();
+		need_rescan = 1;
+		return -EAGAIN;
+	}
+	return 0;
+}
+
+
 static int
-chp_add(int chpid)
+__chp_add(struct subchannel_id schid, void *data)
 {
+	int i;
+	struct channel_path *chp;
 	struct subchannel *sch;
-	int ret, rc;
-	struct subchannel_id schid;
+
+	chp = (struct channel_path *)data;
+	sch = get_subchannel_by_schid(schid);
+	if (!sch)
+		/* Check if the subchannel is now available. */
+		return __chp_add_new_sch(schid);
+	spin_lock(&sch->lock);
+	for (i=0; i<8; i++)
+		if (sch->schib.pmcw.chpid[i] == chp->id) {
+			if (stsch(sch->schid, &sch->schib) != 0) {
+				/* Endgame. */
+				spin_unlock(&sch->lock);
+				return -ENXIO;
+			}
+			break;
+		}
+	if (i==8) {
+		spin_unlock(&sch->lock);
+		return 0;
+	}
+	sch->lpm = ((sch->schib.pmcw.pim &
+		     sch->schib.pmcw.pam &
+		     sch->schib.pmcw.pom)
+		    | 0x80 >> i) & sch->opm;
+
+	if (sch->driver && sch->driver->verify)
+		sch->driver->verify(&sch->dev);
+
+	spin_unlock(&sch->lock);
+	put_device(&sch->dev);
+	return 0;
+}
+
+static int
+chp_add(int chpid)
+{
+	int rc;
 	char dbf_txt[15];
 
 	if (!get_chp_status(chpid))
@@ -621,60 +685,11 @@ chp_add(int chpid)
 	sprintf(dbf_txt, "cadd%x", chpid);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	rc = 0;
-	init_subchannel_id(&schid);
-	do {
-		int i;
-
-		sch = get_subchannel_by_schid(schid);
-		if (!sch) {
-			struct schib schib;
-
-			if (stsch(schid, &schib)) {
-				/* We're through */
-				if (need_rescan)
-					rc = -EAGAIN;
-				break;
-			}
-			if (need_rescan) {
-				rc = -EAGAIN;
-				continue;
-			}
-			/* Put it on the slow path. */
-			ret = css_enqueue_subchannel_slow(schid);
-			if (ret) {
-				css_clear_subchannel_slow_list();
-				need_rescan = 1;
-			}
-			rc = -EAGAIN;
-			continue;
-		}
-	
-		spin_lock(&sch->lock);
-		for (i=0; i<8; i++)
-			if (sch->schib.pmcw.chpid[i] == chpid) {
-				if (stsch(sch->schid, &sch->schib) != 0) {
-					/* Endgame. */
-					spin_unlock(&sch->lock);
-					return rc;
-				}
-				break;
-			}
-		if (i==8) {
-			spin_unlock(&sch->lock);
-			return rc;
-		}
-		sch->lpm = ((sch->schib.pmcw.pim &
-			     sch->schib.pmcw.pam &
-			     sch->schib.pmcw.pom)
-			    | 0x80 >> i) & sch->opm;
-
-		if (sch->driver && sch->driver->verify)
-			sch->driver->verify(&sch->dev);
-
-		spin_unlock(&sch->lock);
-		put_device(&sch->dev);
-	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+	rc = for_each_subchannel(__chp_add, chps[chpid]);
+	if (css_slow_subchannels_exist())
+		rc = -EAGAIN;
+	if (rc != -EAGAIN)
+		rc = 0;
 	return rc;
 }
 
@@ -786,6 +801,29 @@ s390_subchannel_vary_chpid_on(struct dev
 	return 0;
 }
 
+static int
+__s390_vary_chpid_on(struct subchannel_id schid, void *data)
+{
+	struct schib schib;
+	struct subchannel *sch;
+
+	sch = get_subchannel_by_schid(schid);
+	if (sch) {
+		put_device(&sch->dev);
+		return 0;
+	}
+	if (stsch(schid, &schib))
+		/* We're through */
+		return -ENXIO;
+	/* Put it on the slow path. */
+	if (css_enqueue_subchannel_slow(schid)) {
+		css_clear_subchannel_slow_list();
+		need_rescan = 1;
+		return -EAGAIN;
+	}
+	return 0;
+}
+
 /*
  * Function: s390_vary_chpid
  * Varies the specified chpid online or offline
@@ -794,9 +832,7 @@ static int
 s390_vary_chpid( __u8 chpid, int on)
 {
 	char dbf_text[15];
-	int status, ret;
-	struct subchannel_id schid;
-	struct subchannel *sch;
+	int status;
 
 	sprintf(dbf_text, on?"varyon%x":"varyoff%x", chpid);
 	CIO_TRACE_EVENT( 2, dbf_text);
@@ -821,31 +857,9 @@ s390_vary_chpid( __u8 chpid, int on)
 	bus_for_each_dev(&css_bus_type, NULL, &chpid, on ?
 			 s390_subchannel_vary_chpid_on :
 			 s390_subchannel_vary_chpid_off);
-	if (!on)
-		goto out;
-	/* Scan for new devices on varied on path. */
-	init_subchannel_id(&schid);
-	do {
-		struct schib schib;
-
-		if (need_rescan)
-			break;
-		sch = get_subchannel_by_schid(schid);
-		if (sch) {
-			put_device(&sch->dev);
-			continue;
-		}
-		if (stsch(schid, &schib))
-			/* We're through */
-			break;
-		/* Put it on the slow path. */
-		ret = css_enqueue_subchannel_slow(schid);
-		if (ret) {
-			css_clear_subchannel_slow_list();
-			need_rescan = 1;
-		}
-	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
-out:
+	if (on)
+		/* Scan for new devices on varied on path. */
+		for_each_subchannel(__s390_vary_chpid_on, NULL);
 	if (need_rescan || css_slow_subchannels_exist())
 		queue_work(slow_path_wq, &slow_path_work);
 	return 0;
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2005-12-09 14:25:56.000000000 +0100
@@ -691,7 +691,22 @@ wait_cons_dev (void)
 }
 
 static int
-cio_console_irq(void)
+cio_test_for_console(struct subchannel_id schid, void *data)
+{
+	if (stsch(schid, &console_subchannel.schib) != 0)
+		return -ENXIO;
+	if (console_subchannel.schib.pmcw.dnv &&
+	    console_subchannel.schib.pmcw.dev ==
+	    console_devno) {
+		console_irq = schid.sch_no;
+		return 1; /* found */
+	}
+	return 0;
+}
+
+
+static int
+cio_get_console_sch_no(void)
 {
 	struct subchannel_id schid;
 	
@@ -705,16 +720,7 @@ cio_console_irq(void)
 		console_devno = console_subchannel.schib.pmcw.dev;
 	} else if (console_devno != -1) {
 		/* At least the console device number is known. */
-		do {
-			if (stsch(schid, &console_subchannel.schib) != 0)
-				break;
-			if (console_subchannel.schib.pmcw.dnv &&
-			    console_subchannel.schib.pmcw.dev ==
-			    console_devno) {
-				console_irq = schid.sch_no;
-				break;
-			}
-		} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+		for_each_subchannel(cio_test_for_console, NULL);
 		if (console_irq == -1)
 			return -1;
 	} else {
@@ -730,19 +736,19 @@ cio_console_irq(void)
 struct subchannel *
 cio_probe_console(void)
 {
-	int irq, ret;
+	int sch_no, ret;
 	struct subchannel_id schid;
 
 	if (xchg(&console_subchannel_in_use, 1) != 0)
 		return ERR_PTR(-EBUSY);
-	irq = cio_console_irq();
-	if (irq == -1) {
+	sch_no = cio_get_console_sch_no();
+	if (sch_no == -1) {
 		console_subchannel_in_use = 0;
 		return ERR_PTR(-ENODEV);
 	}
 	memset(&console_subchannel, 0, sizeof(struct subchannel));
 	init_subchannel_id(&schid);
-	schid.sch_no = irq;
+	schid.sch_no = sch_no;
 	ret = cio_validate_subchannel(&console_subchannel, schid);
 	if (ret) {
 		console_subchannel_in_use = 0;
@@ -830,32 +836,33 @@ __clear_subchannel_easy(struct subchanne
 }
 
 extern void do_reipl(unsigned long devno);
+static int
+__shutdown_subchannel_easy(struct subchannel_id schid, void *data)
+{
+	struct schib schib;
+
+	if (stsch(schid, &schib))
+		return -ENXIO;
+	if (!schib.pmcw.ena)
+		return 0;
+	switch(__disable_subchannel_easy(schid, &schib)) {
+	case 0:
+	case -ENODEV:
+		break;
+	default: /* -EBUSY */
+		if (__clear_subchannel_easy(schid))
+			break; /* give up... */
+		stsch(schid, &schib);
+		__disable_subchannel_easy(schid, &schib);
+	}
+	return 0;
+}
 
-/* Clear all subchannels. */
 void
 clear_all_subchannels(void)
 {
-	struct subchannel_id schid;
-
 	local_irq_disable();
-	init_subchannel_id(&schid);
-	do {
-		struct schib schib;
-		if (stsch(schid, &schib))
-			break; /* break out of the loop */
-		if (!schib.pmcw.ena)
-			continue;
-		switch(__disable_subchannel_easy(schid, &schib)) {
-		case 0:
-		case -ENODEV:
-			break;
-		default: /* -EBUSY */
-			if (__clear_subchannel_easy(schid))
-				break; /* give up... jump out of switch */
-			stsch(schid, &schib);
-			__disable_subchannel_easy(schid, &schib);
-		}
-	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+	for_each_subchannel(__shutdown_subchannel_easy, NULL);
 }
 
 /* Make sure all subchannels are quiet before we re-ipl an lpar. */
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2005-12-09 14:25:56.000000000 +0100
@@ -21,7 +21,6 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-unsigned int highest_subchannel;
 int need_rescan = 0;
 int css_init_done = 0;
 
@@ -32,6 +31,22 @@ struct device css_bus_device = {
 	.bus_id = "css0",
 };
 
+inline int
+for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *data)
+{
+	struct subchannel_id schid;
+	int ret;
+
+	init_subchannel_id(&schid);
+	ret = -ENODEV;
+	do {
+		ret = fn(schid, data);
+		if (ret)
+			break;
+	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+	return ret;
+}
+
 static struct subchannel *
 css_alloc_subchannel(struct subchannel_id schid)
 {
@@ -280,25 +295,10 @@ css_evaluate_subchannel(struct subchanne
 	return ret;
 }
 
-static void
-css_rescan_devices(void)
+static int
+css_rescan_devices(struct subchannel_id schid, void *data)
 {
-	int ret;
-	struct subchannel_id schid;
-
-	init_subchannel_id(&schid);
-	do {
-		ret = css_evaluate_subchannel(schid, 1);
-		/* No more memory. It doesn't make sense to continue. No
-		 * panic because this can happen in midflight and just
-		 * because we can't use a new device is no reason to crash
-		 * the system. */
-		if (ret == -ENOMEM)
-			break;
-		/* -ENXIO indicates that there are no more subchannels. */
-		if (ret == -ENXIO)
-			break;
-	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+	return css_evaluate_subchannel(schid, 1);
 }
 
 struct slow_subchannel {
@@ -316,7 +316,7 @@ css_trigger_slow_path(void)
 
 	if (need_rescan) {
 		need_rescan = 0;
-		css_rescan_devices();
+		for_each_subchannel(css_rescan_devices, NULL);
 		return;
 	}
 
@@ -383,6 +383,43 @@ css_process_crw(int irq)
 	return ret;
 }
 
+static int __init
+__init_channel_subsystem(struct subchannel_id schid, void *data)
+{
+	struct subchannel *sch;
+	int ret;
+
+	if (cio_is_console(schid))
+		sch = cio_get_console_subchannel();
+	else {
+		sch = css_alloc_subchannel(schid);
+		if (IS_ERR(sch))
+			ret = PTR_ERR(sch);
+		else
+			ret = 0;
+		switch (ret) {
+		case 0:
+			break;
+		case -ENOMEM:
+			panic("Out of memory in init_channel_subsystem\n");
+		/* -ENXIO: no more subchannels. */
+		case -ENXIO:
+			return ret;
+		default:
+			return 0;
+		}
+	}
+	/*
+	 * We register ALL valid subchannels in ioinfo, even those
+	 * that have been present before init_channel_subsystem.
+	 * These subchannels can't have been registered yet (kmalloc
+	 * not working) so we do it now. This is true e.g. for the
+	 * console subchannel.
+	 */
+	css_register_subchannel(sch);
+	return 0;
+}
+
 static void __init
 css_generate_pgid(void)
 {
@@ -410,7 +447,6 @@ static int __init
 init_channel_subsystem (void)
 {
 	int ret;
-	struct subchannel_id schid;
 
 	if (chsc_determine_css_characteristics() == 0)
 		css_characteristics_avail = 1;
@@ -426,38 +462,8 @@ init_channel_subsystem (void)
 
 	ctl_set_bit(6, 28);
 
-	init_subchannel_id(&schid);
-	do {
-		struct subchannel *sch;
-
-		if (cio_is_console(schid))
-			sch = cio_get_console_subchannel();
-		else {
-			sch = css_alloc_subchannel(schid);
-			if (IS_ERR(sch))
-				ret = PTR_ERR(sch);
-			else
-				ret = 0;
-			if (ret == -ENOMEM)
-				panic("Out of memory in "
-				      "init_channel_subsystem\n");
-			/* -ENXIO: no more subchannels. */
-			if (ret == -ENXIO)
-				break;
-			if (ret)
-				continue;
-		}
-		/*
-		 * We register ALL valid subchannels in ioinfo, even those
-		 * that have been present before init_channel_subsystem.
-		 * These subchannels can't have been registered yet (kmalloc
-		 * not working) so we do it now. This is true e.g. for the
-		 * console subchannel.
-		 */
-		css_register_subchannel(sch);
-	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
-
 out_bus:
 	bus_unregister(&css_bus_type);
 out:
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2005-12-09 14:25:56.000000000 +0100
@@ -126,6 +126,7 @@ extern struct css_driver io_subchannel_d
 extern int css_probe_device(struct subchannel_id);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
+extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
 
 #define __MAX_SUBCHANNEL 65535
 
