Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVLIP2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVLIP2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVLIP2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:28:33 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:57565 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964772AbVLIP2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:28:17 -0500
Date: Fri, 9 Dec 2005 16:28:14 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 12/17] s390: introduce struct subchannel_id.
Message-ID: <20051209152814.GM6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

[patch 12/17] s390: introduce struct subchannel_id.

This patch introduces a struct subchannel_id containing the subchannel number
(formerly referred to as "irq") and switches code formerly relying on the
subchannel number over to it.
While we're touching inline assemblies anyway, make sure they have correct
memory constraints.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/blacklist.c     |   23 ++++----
 drivers/s390/cio/chsc.c          |   63 ++++++++++++----------
 drivers/s390/cio/cio.c           |   84 ++++++++++++++++--------------
 drivers/s390/cio/cio.h           |   11 ++--
 drivers/s390/cio/cmf.c           |    8 +-
 drivers/s390/cio/css.c           |   69 +++++++++++++------------
 drivers/s390/cio/css.h           |   13 ++--
 drivers/s390/cio/device.c        |   17 +++++-
 drivers/s390/cio/device.h        |    1 
 drivers/s390/cio/device_fsm.c    |   18 +++---
 drivers/s390/cio/device_id.c     |    6 +-
 drivers/s390/cio/device_ops.c    |    4 -
 drivers/s390/cio/device_pgid.c   |   13 ++--
 drivers/s390/cio/device_status.c |    8 +-
 drivers/s390/cio/ioasm.h         |   55 +++++++++++---------
 drivers/s390/cio/qdio.c          |  107 ++++++++++++++++++++-------------------
 drivers/s390/cio/qdio.h          |   26 +++++----
 drivers/s390/cio/schid.h         |   25 +++++++++
 18 files changed, 313 insertions(+), 238 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2005-12-09 14:25:54.000000000 +0100
@@ -35,7 +35,7 @@
  */
 
 /* 65536 bits to indicate if a devno is blacklisted or not */
-#define __BL_DEV_WORDS ((__MAX_SUBCHANNELS + (8*sizeof(long) - 1)) / \
+#define __BL_DEV_WORDS ((__MAX_SUBCHANNEL + (8*sizeof(long) - 1)) / \
 			 (8*sizeof(long)))
 static unsigned long bl_dev[__BL_DEV_WORDS];
 typedef enum {add, free} range_action;
@@ -50,7 +50,7 @@ blacklist_range (range_action action, un
 	if (!to)
 		to = from;
 
-	if (from > to || to > __MAX_SUBCHANNELS) {
+	if (from > to || to > __MAX_SUBCHANNEL) {
 		printk (KERN_WARNING "Invalid blacklist range "
 			"0x%04x to 0x%04x, skipping\n", from, to);
 		return;
@@ -143,7 +143,7 @@ blacklist_parse_parameters (char *str, r
 		if (strncmp(str,"all,",4) == 0 || strcmp(str,"all") == 0 ||
 		    strncmp(str,"all\n",4) == 0 || strncmp(str,"all ",4) == 0) {
 			from = 0;
-			to = __MAX_SUBCHANNELS;
+			to = __MAX_SUBCHANNEL;
 			str += 3;
 		} else {
 			int rc;
@@ -226,20 +226,21 @@ is_blacklisted (int devno)
 static inline void
 s390_redo_validation (void)
 {
-	unsigned int irq;
+	struct subchannel_id schid;
 
 	CIO_TRACE_EVENT (0, "redoval");
-	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
+	init_subchannel_id(&schid);
+	do {
 		int ret;
 		struct subchannel *sch;
 
-		sch = get_subchannel_by_schid(irq);
+		sch = get_subchannel_by_schid(schid);
 		if (sch) {
 			/* Already known. */
 			put_device(&sch->dev);
 			continue;
 		}
-		ret = css_probe_device(irq);
+		ret = css_probe_device(schid);
 		if (ret == -ENXIO)
 			break; /* We're through. */
 		if (ret == -ENOMEM)
@@ -248,7 +249,7 @@ s390_redo_validation (void)
 			 * panic.
 			 */
 			break;
-	}
+	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
 }
 
 /*
@@ -289,12 +290,12 @@ static int cio_ignore_read (char *page, 
 	len = 0;
 	for (devno = off; /* abuse the page variable
 			   * as counter, see fs/proc/generic.c */
-	     devno < __MAX_SUBCHANNELS && len + entry_size < count; devno++) {
+	     devno < __MAX_SUBCHANNEL && len + entry_size < count; devno++) {
 		if (!test_bit(devno, bl_dev))
 			continue;
 		len += sprintf(page + len, "0.0.%04lx", devno);
 		if (test_bit(devno + 1, bl_dev)) { /* print range */
-			while (++devno < __MAX_SUBCHANNELS)
+			while (++devno < __MAX_SUBCHANNEL)
 				if (!test_bit(devno, bl_dev))
 					break;
 			len += sprintf(page + len, "-0.0.%04lx", --devno);
@@ -302,7 +303,7 @@ static int cio_ignore_read (char *page, 
 		len += sprintf(page + len, "\n");
 	}
 
-	if (devno < __MAX_SUBCHANNELS)
+	if (devno < __MAX_SUBCHANNEL)
 		*eof = 1;
 	*start = (char *) (devno - off); /* number of checked entries */
 	return len;
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2005-12-09 14:25:54.000000000 +0100
@@ -104,8 +104,8 @@ chsc_get_sch_desc_irq(struct subchannel 
 		.code   = 0x0004,
 	};
 
-	ssd_area->f_sch = sch->irq;
-	ssd_area->l_sch = sch->irq;
+	ssd_area->f_sch = sch->schid.sch_no;
+	ssd_area->l_sch = sch->schid.sch_no;
 
 	ccode = chsc(ssd_area);
 	if (ccode > 0) {
@@ -147,7 +147,8 @@ chsc_get_sch_desc_irq(struct subchannel 
 	 */
 	if (ssd_area->st > 3) { /* uhm, that looks strange... */
 		CIO_CRW_EVENT(0, "Strange subchannel type %d"
-			      " for sch %04x\n", ssd_area->st, sch->irq);
+			      " for sch %04x\n", ssd_area->st,
+			      sch->schid.sch_no);
 		/*
 		 * There may have been a new subchannel type defined in the
 		 * time since this code was written; since we don't know which
@@ -157,7 +158,7 @@ chsc_get_sch_desc_irq(struct subchannel 
 	} else {
 		const char *type[4] = {"I/O", "chsc", "message", "ADM"};
 		CIO_CRW_EVENT(6, "ssd: sch %04x is %s subchannel\n",
-			      sch->irq, type[ssd_area->st]);
+			      sch->schid.sch_no, type[ssd_area->st]);
 
 		sch->ssd_info.valid = 1;
 		sch->ssd_info.type = ssd_area->st;
@@ -232,7 +233,7 @@ s390_subchannel_remove_chpid(struct devi
 	mask = 0x80 >> j;
 	spin_lock(&sch->lock);
 
-	stsch(sch->irq, &schib);
+	stsch(sch->schid, &schib);
 	if (!schib.pmcw.dnv)
 		goto out_unreg;
 	memcpy(&sch->schib, &schib, sizeof(struct schib));
@@ -284,7 +285,7 @@ out_unlock:
 out_unreg:
 	spin_unlock(&sch->lock);
 	sch->lpm = 0;
-	if (css_enqueue_subchannel_slow(sch->irq)) {
+	if (css_enqueue_subchannel_slow(sch->schid)) {
 		css_clear_subchannel_slow_list();
 		need_rescan = 1;
 	}
@@ -337,7 +338,7 @@ s390_process_res_acc_sch(u8 chpid, __u16
 	 * new path information and eventually check for logically
 	 * offline chpids.
 	 */
-	ccode = stsch(sch->irq, &sch->schib);
+	ccode = stsch(sch->schid, &sch->schib);
 	if (ccode > 0)
 		return 0;
 
@@ -348,7 +349,8 @@ static int
 s390_process_res_acc (u8 chpid, __u16 fla, u32 fla_mask)
 {
 	struct subchannel *sch;
-	int irq, rc;
+	int rc;
+	struct subchannel_id schid;
 	char dbf_txt[15];
 
 	sprintf(dbf_txt, "accpr%x", chpid);
@@ -370,10 +372,11 @@ s390_process_res_acc (u8 chpid, __u16 fl
 		return 0; /* no need to do the rest */
 
 	rc = 0;
-	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
+	init_subchannel_id(&schid);
+	do {
 		int chp_mask, old_lpm;
 
-		sch = get_subchannel_by_schid(irq);
+		sch = get_subchannel_by_schid(schid);
 		if (!sch) {
 			struct schib schib;
 			int ret;
@@ -385,7 +388,7 @@ s390_process_res_acc (u8 chpid, __u16 fl
 			 * that beast may be on we'll have to do a stsch
 			 * on all devices, grr...
 			 */
-			if (stsch(irq, &schib)) {
+			if (stsch(schid, &schib)) {
 				/* We're through */
 				if (need_rescan)
 					rc = -EAGAIN;
@@ -396,7 +399,7 @@ s390_process_res_acc (u8 chpid, __u16 fl
 				continue;
 			}
 			/* Put it on the slow path. */
-			ret = css_enqueue_subchannel_slow(irq);
+			ret = css_enqueue_subchannel_slow(schid);
 			if (ret) {
 				css_clear_subchannel_slow_list();
 				need_rescan = 1;
@@ -428,7 +431,7 @@ s390_process_res_acc (u8 chpid, __u16 fl
 		put_device(&sch->dev);
 		if (fla_mask == 0xffff)
 			break;
-	}
+	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
 	return rc;
 }
 
@@ -608,7 +611,8 @@ static int
 chp_add(int chpid)
 {
 	struct subchannel *sch;
-	int irq, ret, rc;
+	int ret, rc;
+	struct subchannel_id schid;
 	char dbf_txt[15];
 
 	if (!get_chp_status(chpid))
@@ -618,14 +622,15 @@ chp_add(int chpid)
 	CIO_TRACE_EVENT(2, dbf_txt);
 
 	rc = 0;
-	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
+	init_subchannel_id(&schid);
+	do {
 		int i;
 
-		sch = get_subchannel_by_schid(irq);
+		sch = get_subchannel_by_schid(schid);
 		if (!sch) {
 			struct schib schib;
 
-			if (stsch(irq, &schib)) {
+			if (stsch(schid, &schib)) {
 				/* We're through */
 				if (need_rescan)
 					rc = -EAGAIN;
@@ -636,7 +641,7 @@ chp_add(int chpid)
 				continue;
 			}
 			/* Put it on the slow path. */
-			ret = css_enqueue_subchannel_slow(irq);
+			ret = css_enqueue_subchannel_slow(schid);
 			if (ret) {
 				css_clear_subchannel_slow_list();
 				need_rescan = 1;
@@ -648,7 +653,7 @@ chp_add(int chpid)
 		spin_lock(&sch->lock);
 		for (i=0; i<8; i++)
 			if (sch->schib.pmcw.chpid[i] == chpid) {
-				if (stsch(sch->irq, &sch->schib) != 0) {
+				if (stsch(sch->schid, &sch->schib) != 0) {
 					/* Endgame. */
 					spin_unlock(&sch->lock);
 					return rc;
@@ -669,7 +674,7 @@ chp_add(int chpid)
 
 		spin_unlock(&sch->lock);
 		put_device(&sch->dev);
-	}
+	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
 	return rc;
 }
 
@@ -702,7 +707,7 @@ __check_for_io_and_kill(struct subchanne
 	if (!device_is_online(sch))
 		/* cio could be doing I/O. */
 		return 0;
-	cc = stsch(sch->irq, &sch->schib);
+	cc = stsch(sch->schid, &sch->schib);
 	if (cc)
 		return 0;
 	if (sch->schib.scsw.actl && sch->schib.pmcw.lpum == (0x80 >> index)) {
@@ -743,7 +748,7 @@ __s390_subchannel_vary_chpid(struct subc
 			 * just varied off path. Then kill it.
 			 */
 			if (!__check_for_io_and_kill(sch, chp) && !sch->lpm) {
-				if (css_enqueue_subchannel_slow(sch->irq)) {
+				if (css_enqueue_subchannel_slow(sch->schid)) {
 					css_clear_subchannel_slow_list();
 					need_rescan = 1;
 				}
@@ -789,7 +794,8 @@ static int
 s390_vary_chpid( __u8 chpid, int on)
 {
 	char dbf_text[15];
-	int status, irq, ret;
+	int status, ret;
+	struct subchannel_id schid;
 	struct subchannel *sch;
 
 	sprintf(dbf_text, on?"varyon%x":"varyoff%x", chpid);
@@ -818,26 +824,27 @@ s390_vary_chpid( __u8 chpid, int on)
 	if (!on)
 		goto out;
 	/* Scan for new devices on varied on path. */
-	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
+	init_subchannel_id(&schid);
+	do {
 		struct schib schib;
 
 		if (need_rescan)
 			break;
-		sch = get_subchannel_by_schid(irq);
+		sch = get_subchannel_by_schid(schid);
 		if (sch) {
 			put_device(&sch->dev);
 			continue;
 		}
-		if (stsch(irq, &schib))
+		if (stsch(schid, &schib))
 			/* We're through */
 			break;
 		/* Put it on the slow path. */
-		ret = css_enqueue_subchannel_slow(irq);
+		ret = css_enqueue_subchannel_slow(schid);
 		if (ret) {
 			css_clear_subchannel_slow_list();
 			need_rescan = 1;
 		}
-	}
+	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
 out:
 	if (need_rescan || css_slow_subchannels_exist())
 		queue_work(slow_path_wq, &slow_path_work);
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2005-12-09 14:25:54.000000000 +0100
@@ -135,7 +135,7 @@ cio_tpi(void)
 		return 0;
 	irb = (struct irb *) __LC_IRB;
 	/* Store interrupt response block to lowcore. */
-	if (tsch (tpi_info->irq, irb) != 0)
+	if (tsch (tpi_info->schid, irb) != 0)
 		/* Not status pending or not operational. */
 		return 1;
 	sch = (struct subchannel *)(unsigned long)tpi_info->intparm;
@@ -163,10 +163,10 @@ cio_start_handle_notoper(struct subchann
 	else
 		sch->lpm = 0;
 
-	stsch (sch->irq, &sch->schib);
+	stsch (sch->schid, &sch->schib);
 
 	CIO_MSG_EVENT(0, "cio_start: 'not oper' status for "
-		      "subchannel %04x!\n", sch->irq);
+		      "subchannel %04x!\n", sch->schid.sch_no);
 	sprintf(dbf_text, "no%s", sch->dev.bus_id);
 	CIO_TRACE_EVENT(0, dbf_text);
 	CIO_HEX_EVENT(0, &sch->schib, sizeof (struct schib));
@@ -204,7 +204,7 @@ cio_start_key (struct subchannel *sch,	/
 	sch->orb.key = key >> 4;
 	/* issue "Start Subchannel" */
 	sch->orb.cpa = (__u32) __pa (cpa);
-	ccode = ssch (sch->irq, &sch->orb);
+	ccode = ssch (sch->schid, &sch->orb);
 
 	/* process condition code */
 	sprintf (dbf_txt, "ccode:%d", ccode);
@@ -243,7 +243,7 @@ cio_resume (struct subchannel *sch)
 	CIO_TRACE_EVENT (4, "resIO");
 	CIO_TRACE_EVENT (4, sch->dev.bus_id);
 
-	ccode = rsch (sch->irq);
+	ccode = rsch (sch->schid);
 
 	sprintf (dbf_txt, "ccode:%d", ccode);
 	CIO_TRACE_EVENT (4, dbf_txt);
@@ -283,7 +283,7 @@ cio_halt(struct subchannel *sch)
 	/*
 	 * Issue "Halt subchannel" and process condition code
 	 */
-	ccode = hsch (sch->irq);
+	ccode = hsch (sch->schid);
 
 	sprintf (dbf_txt, "ccode:%d", ccode);
 	CIO_TRACE_EVENT (2, dbf_txt);
@@ -318,7 +318,7 @@ cio_clear(struct subchannel *sch)
 	/*
 	 * Issue "Clear subchannel" and process condition code
 	 */
-	ccode = csch (sch->irq);
+	ccode = csch (sch->schid);
 
 	sprintf (dbf_txt, "ccode:%d", ccode);
 	CIO_TRACE_EVENT (2, dbf_txt);
@@ -351,7 +351,7 @@ cio_cancel (struct subchannel *sch)
 	CIO_TRACE_EVENT (2, "cancelIO");
 	CIO_TRACE_EVENT (2, sch->dev.bus_id);
 
-	ccode = xsch (sch->irq);
+	ccode = xsch (sch->schid);
 
 	sprintf (dbf_txt, "ccode:%d", ccode);
 	CIO_TRACE_EVENT (2, dbf_txt);
@@ -359,7 +359,7 @@ cio_cancel (struct subchannel *sch)
 	switch (ccode) {
 	case 0:		/* success */
 		/* Update information in scsw. */
-		stsch (sch->irq, &sch->schib);
+		stsch (sch->schid, &sch->schib);
 		return 0;
 	case 1:		/* status pending */
 		return -EBUSY;
@@ -381,7 +381,7 @@ cio_modify (struct subchannel *sch)
 
 	ret = 0;
 	for (retry = 0; retry < 5; retry++) {
-		ccode = msch_err (sch->irq, &sch->schib);
+		ccode = msch_err (sch->schid, &sch->schib);
 		if (ccode < 0)	/* -EIO if msch gets a program check. */
 			return ccode;
 		switch (ccode) {
@@ -414,7 +414,7 @@ cio_enable_subchannel (struct subchannel
 	CIO_TRACE_EVENT (2, "ensch");
 	CIO_TRACE_EVENT (2, sch->dev.bus_id);
 
-	ccode = stsch (sch->irq, &sch->schib);
+	ccode = stsch (sch->schid, &sch->schib);
 	if (ccode)
 		return -ENODEV;
 
@@ -432,13 +432,13 @@ cio_enable_subchannel (struct subchannel
 			 */
 			sch->schib.pmcw.csense = 0;
 		if (ret == 0) {
-			stsch (sch->irq, &sch->schib);
+			stsch (sch->schid, &sch->schib);
 			if (sch->schib.pmcw.ena)
 				break;
 		}
 		if (ret == -EBUSY) {
 			struct irb irb;
-			if (tsch(sch->irq, &irb) != 0)
+			if (tsch(sch->schid, &irb) != 0)
 				break;
 		}
 	}
@@ -461,7 +461,7 @@ cio_disable_subchannel (struct subchanne
 	CIO_TRACE_EVENT (2, "dissch");
 	CIO_TRACE_EVENT (2, sch->dev.bus_id);
 
-	ccode = stsch (sch->irq, &sch->schib);
+	ccode = stsch (sch->schid, &sch->schib);
 	if (ccode == 3)		/* Not operational. */
 		return -ENODEV;
 
@@ -485,7 +485,7 @@ cio_disable_subchannel (struct subchanne
 			 */
 			break;
 		if (ret == 0) {
-			stsch (sch->irq, &sch->schib);
+			stsch (sch->schid, &sch->schib);
 			if (!sch->schib.pmcw.ena)
 				break;
 		}
@@ -508,12 +508,12 @@ cio_disable_subchannel (struct subchanne
  *   -ENODEV for subchannels with invalid device number or blacklisted devices
  */
 int
-cio_validate_subchannel (struct subchannel *sch, unsigned int irq)
+cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
 {
 	char dbf_txt[15];
 	int ccode;
 
-	sprintf (dbf_txt, "valsch%x", irq);
+	sprintf (dbf_txt, "valsch%x", schid.sch_no);
 	CIO_TRACE_EVENT (4, dbf_txt);
 
 	/* Nuke all fields. */
@@ -522,17 +522,17 @@ cio_validate_subchannel (struct subchann
 	spin_lock_init(&sch->lock);
 
 	/* Set a name for the subchannel */
-	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.0.%04x", irq);
+	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.0.%04x", schid.sch_no);
 
 	/*
 	 * The first subchannel that is not-operational (ccode==3)
 	 *  indicates that there aren't any more devices available.
 	 */
-	sch->irq = irq;
-	ccode = stsch (irq, &sch->schib);
+	ccode = stsch (schid, &sch->schib);
 	if (ccode)
 		return -ENXIO;
 
+	sch->schid = schid;
 	/* Copy subchannel type from path management control word. */
 	sch->st = sch->schib.pmcw.st;
 
@@ -543,7 +543,7 @@ cio_validate_subchannel (struct subchann
 		CIO_DEBUG(KERN_INFO, 0,
 			  "Subchannel %04X reports "
 			  "non-I/O subchannel type %04X\n",
-			  sch->irq, sch->st);
+			  sch->schid.sch_no, sch->st);
 		/* We stop here for non-io subchannels. */
 		return sch->st;
 	}
@@ -573,7 +573,7 @@ cio_validate_subchannel (struct subchann
 	CIO_DEBUG(KERN_INFO, 0,
 		  "Detected device %04X on subchannel %04X"
 		  " - PIM = %02X, PAM = %02X, POM = %02X\n",
-		  sch->schib.pmcw.dev, sch->irq, sch->schib.pmcw.pim,
+		  sch->schib.pmcw.dev, sch->schid.sch_no, sch->schib.pmcw.pim,
 		  sch->schib.pmcw.pam, sch->schib.pmcw.pom);
 
 	/*
@@ -632,7 +632,7 @@ do_IRQ (struct pt_regs *regs)
 		if (sch)
 			spin_lock(&sch->lock);
 		/* Store interrupt response block to lowcore. */
-		if (tsch (tpi_info->irq, irb) == 0 && sch) {
+		if (tsch (tpi_info->schid, irb) == 0 && sch) {
 			/* Keep subchannel information word up to date. */
 			memcpy (&sch->schib.scsw, &irb->scsw,
 				sizeof (irb->scsw));
@@ -693,26 +693,28 @@ wait_cons_dev (void)
 static int
 cio_console_irq(void)
 {
-	int irq;
+	struct subchannel_id schid;
 	
+	init_subchannel_id(&schid);
 	if (console_irq != -1) {
 		/* VM provided us with the irq number of the console. */
-		if (stsch(console_irq, &console_subchannel.schib) != 0 ||
+		schid.sch_no = console_irq;
+		if (stsch(schid, &console_subchannel.schib) != 0 ||
 		    !console_subchannel.schib.pmcw.dnv)
 			return -1;
 		console_devno = console_subchannel.schib.pmcw.dev;
 	} else if (console_devno != -1) {
 		/* At least the console device number is known. */
-		for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
-			if (stsch(irq, &console_subchannel.schib) != 0)
+		do {
+			if (stsch(schid, &console_subchannel.schib) != 0)
 				break;
 			if (console_subchannel.schib.pmcw.dnv &&
 			    console_subchannel.schib.pmcw.dev ==
 			    console_devno) {
-				console_irq = irq;
+				console_irq = schid.sch_no;
 				break;
 			}
-		}
+		} while (schid.sch_no++ < __MAX_SUBCHANNEL);
 		if (console_irq == -1)
 			return -1;
 	} else {
@@ -729,6 +731,7 @@ struct subchannel *
 cio_probe_console(void)
 {
 	int irq, ret;
+	struct subchannel_id schid;
 
 	if (xchg(&console_subchannel_in_use, 1) != 0)
 		return ERR_PTR(-EBUSY);
@@ -738,7 +741,9 @@ cio_probe_console(void)
 		return ERR_PTR(-ENODEV);
 	}
 	memset(&console_subchannel, 0, sizeof(struct subchannel));
-	ret = cio_validate_subchannel(&console_subchannel, irq);
+	init_subchannel_id(&schid);
+	schid.sch_no = irq;
+	ret = cio_validate_subchannel(&console_subchannel, schid);
 	if (ret) {
 		console_subchannel_in_use = 0;
 		return ERR_PTR(-ENODEV);
@@ -770,11 +775,11 @@ cio_release_console(void)
 
 /* Bah... hack to catch console special sausages. */
 int
-cio_is_console(int irq)
+cio_is_console(struct subchannel_id schid)
 {
 	if (!console_subchannel_in_use)
 		return 0;
-	return (irq == console_subchannel.irq);
+	return schid_equal(&schid, &console_subchannel.schid);
 }
 
 struct subchannel *
@@ -787,7 +792,7 @@ cio_get_console_subchannel(void)
 
 #endif
 static inline int
-__disable_subchannel_easy(unsigned int schid, struct schib *schib)
+__disable_subchannel_easy(struct subchannel_id schid, struct schib *schib)
 {
 	int retry, cc;
 
@@ -805,7 +810,7 @@ __disable_subchannel_easy(unsigned int s
 }
 
 static inline int
-__clear_subchannel_easy(unsigned int schid)
+__clear_subchannel_easy(struct subchannel_id schid)
 {
 	int retry;
 
@@ -815,8 +820,8 @@ __clear_subchannel_easy(unsigned int sch
 		struct tpi_info ti;
 
 		if (tpi(&ti)) {
-			tsch(ti.irq, (struct irb *)__LC_IRB);
-			if (ti.irq == schid)
+			tsch(ti.schid, (struct irb *)__LC_IRB);
+			if (schid_equal(&ti.schid, &schid))
 				return 0;
 		}
 		udelay(100);
@@ -830,10 +835,11 @@ extern void do_reipl(unsigned long devno
 void
 clear_all_subchannels(void)
 {
-	unsigned int schid;
+	struct subchannel_id schid;
 
 	local_irq_disable();
-	for (schid=0;schid<=highest_subchannel;schid++) {
+	init_subchannel_id(&schid);
+	do {
 		struct schib schib;
 		if (stsch(schid, &schib))
 			break; /* break out of the loop */
@@ -849,7 +855,7 @@ clear_all_subchannels(void)
 			stsch(schid, &schib);
 			__disable_subchannel_easy(schid, &schib);
 		}
-	}
+	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
 }
 
 /* Make sure all subchannels are quiet before we re-ipl an lpar. */
diff -urpN linux-2.6/drivers/s390/cio/cio.h linux-2.6-patched/drivers/s390/cio/cio.h
--- linux-2.6/drivers/s390/cio/cio.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.h	2005-12-09 14:25:54.000000000 +0100
@@ -1,6 +1,8 @@
 #ifndef S390_CIO_H
 #define S390_CIO_H
 
+#include "schid.h"
+
 /*
  * where we put the ssd info
  */
@@ -83,7 +85,7 @@ struct orb {
 
 /* subchannel data structure used by I/O subroutines */
 struct subchannel {
-	unsigned int irq;	/* aka. subchannel number */
+	struct subchannel_id schid;
 	spinlock_t lock;	/* subchannel lock */
 
 	enum {
@@ -114,7 +116,7 @@ struct subchannel {
 
 #define to_subchannel(n) container_of(n, struct subchannel, dev)
 
-extern int cio_validate_subchannel (struct subchannel *, unsigned int);
+extern int cio_validate_subchannel (struct subchannel *, struct subchannel_id);
 extern int cio_enable_subchannel (struct subchannel *, unsigned int);
 extern int cio_disable_subchannel (struct subchannel *);
 extern int cio_cancel (struct subchannel *);
@@ -127,14 +129,15 @@ extern int cio_cancel (struct subchannel
 extern int cio_set_options (struct subchannel *, int);
 extern int cio_get_options (struct subchannel *);
 extern int cio_modify (struct subchannel *);
+
 /* Use with care. */
 #ifdef CONFIG_CCW_CONSOLE
 extern struct subchannel *cio_probe_console(void);
 extern void cio_release_console(void);
-extern int cio_is_console(int irq);
+extern int cio_is_console(struct subchannel_id);
 extern struct subchannel *cio_get_console_subchannel(void);
 #else
-#define cio_is_console(irq) 0
+#define cio_is_console(schid) 0
 #define cio_get_console_subchannel() NULL
 #endif
 
diff -urpN linux-2.6/drivers/s390/cio/cmf.c linux-2.6-patched/drivers/s390/cio/cmf.c
--- linux-2.6/drivers/s390/cio/cmf.c	2005-12-09 14:21:46.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cmf.c	2005-12-09 14:25:54.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/cio/cmf.c ($Revision: 1.16 $)
+ * linux/drivers/s390/cio/cmf.c ($Revision: 1.19 $)
  *
  * Linux on zSeries Channel Measurement Facility support
  *
@@ -178,7 +178,7 @@ set_schib(struct ccw_device *cdev, u32 m
 	/* msch can silently fail, so do it again if necessary */
 	for (retry = 0; retry < 3; retry++) {
 		/* prepare schib */
-		stsch(sch->irq, schib);
+		stsch(sch->schid, schib);
 		schib->pmcw.mme  = mme;
 		schib->pmcw.mbfc = mbfc;
 		/* address can be either a block address or a block index */
@@ -188,7 +188,7 @@ set_schib(struct ccw_device *cdev, u32 m
 			schib->pmcw.mbi = address;
 
 		/* try to submit it */
-		switch(ret = msch_err(sch->irq, schib)) {
+		switch(ret = msch_err(sch->schid, schib)) {
 			case 0:
 				break;
 			case 1:
@@ -202,7 +202,7 @@ set_schib(struct ccw_device *cdev, u32 m
 				ret = -EINVAL;
 				break;
 		}
-		stsch(sch->irq, schib); /* restore the schib */
+		stsch(sch->schid, schib); /* restore the schib */
 
 		if (ret)
 			break;
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2005-12-09 14:24:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2005-12-09 14:25:54.000000000 +0100
@@ -33,7 +33,7 @@ struct device css_bus_device = {
 };
 
 static struct subchannel *
-css_alloc_subchannel(int irq)
+css_alloc_subchannel(struct subchannel_id schid)
 {
 	struct subchannel *sch;
 	int ret;
@@ -41,13 +41,11 @@ css_alloc_subchannel(int irq)
 	sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);
 	if (sch == NULL)
 		return ERR_PTR(-ENOMEM);
-	ret = cio_validate_subchannel (sch, irq);
+	ret = cio_validate_subchannel (sch, schid);
 	if (ret < 0) {
 		kfree(sch);
 		return ERR_PTR(ret);
 	}
-	if (irq > highest_subchannel)
-		highest_subchannel = irq;
 
 	if (sch->st != SUBCHANNEL_TYPE_IO) {
 		/* For now we ignore all non-io subchannels. */
@@ -87,7 +85,7 @@ css_subchannel_release(struct device *de
 	struct subchannel *sch;
 
 	sch = to_subchannel(dev);
-	if (!cio_is_console(sch->irq))
+	if (!cio_is_console(sch->schid))
 		kfree(sch);
 }
 
@@ -114,12 +112,12 @@ css_register_subchannel(struct subchanne
 }
 
 int
-css_probe_device(int irq)
+css_probe_device(struct subchannel_id schid)
 {
 	int ret;
 	struct subchannel *sch;
 
-	sch = css_alloc_subchannel(irq);
+	sch = css_alloc_subchannel(schid);
 	if (IS_ERR(sch))
 		return PTR_ERR(sch);
 	ret = css_register_subchannel(sch);
@@ -132,26 +130,26 @@ static int
 check_subchannel(struct device * dev, void * data)
 {
 	struct subchannel *sch;
-	int irq = (unsigned long)data;
+	struct subchannel_id *schid = data;
 
 	sch = to_subchannel(dev);
-	return (sch->irq == irq);
+	return schid_equal(&sch->schid, schid);
 }
 
 struct subchannel *
-get_subchannel_by_schid(int irq)
+get_subchannel_by_schid(struct subchannel_id schid)
 {
 	struct device *dev;
 
 	dev = bus_find_device(&css_bus_type, NULL,
-			      (void *)(unsigned long)irq, check_subchannel);
+			      (void *)&schid, check_subchannel);
 
 	return dev ? to_subchannel(dev) : NULL;
 }
 
 
 static inline int
-css_get_subchannel_status(struct subchannel *sch, int schid)
+css_get_subchannel_status(struct subchannel *sch, struct subchannel_id schid)
 {
 	struct schib schib;
 	int cc;
@@ -170,13 +168,13 @@ css_get_subchannel_status(struct subchan
 }
 	
 static int
-css_evaluate_subchannel(int irq, int slow)
+css_evaluate_subchannel(struct subchannel_id schid, int slow)
 {
 	int event, ret, disc;
 	struct subchannel *sch;
 	unsigned long flags;
 
-	sch = get_subchannel_by_schid(irq);
+	sch = get_subchannel_by_schid(schid);
 	disc = sch ? device_is_disconnected(sch) : 0;
 	if (disc && slow) {
 		if (sch)
@@ -194,9 +192,10 @@ css_evaluate_subchannel(int irq, int slo
 			put_device(&sch->dev);
 		return -EAGAIN; /* Will be done on the slow path. */
 	}
-	event = css_get_subchannel_status(sch, irq);
+	event = css_get_subchannel_status(sch, schid);
 	CIO_MSG_EVENT(4, "Evaluating schid %04x, event %d, %s, %s path.\n",
-		      irq, event, sch?(disc?"disconnected":"normal"):"unknown",
+		      schid.sch_no, event,
+		      sch?(disc?"disconnected":"normal"):"unknown",
 		      slow?"slow":"fast");
 	switch (event) {
 	case CIO_NO_PATH:
@@ -253,7 +252,7 @@ css_evaluate_subchannel(int irq, int slo
 			sch->schib.pmcw.intparm = 0;
 			cio_modify(sch);
 			put_device(&sch->dev);
-			ret = css_probe_device(irq);
+			ret = css_probe_device(schid);
 		} else {
 			/*
 			 * We can't immediately deregister the disconnected
@@ -272,7 +271,7 @@ css_evaluate_subchannel(int irq, int slo
 			device_trigger_reprobe(sch);
 			spin_unlock_irqrestore(&sch->lock, flags);
 		}
-		ret = sch ? 0 : css_probe_device(irq);
+		ret = sch ? 0 : css_probe_device(schid);
 		break;
 	default:
 		BUG();
@@ -284,10 +283,12 @@ css_evaluate_subchannel(int irq, int slo
 static void
 css_rescan_devices(void)
 {
-	int irq, ret;
+	int ret;
+	struct subchannel_id schid;
 
-	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
-		ret = css_evaluate_subchannel(irq, 1);
+	init_subchannel_id(&schid);
+	do {
+		ret = css_evaluate_subchannel(schid, 1);
 		/* No more memory. It doesn't make sense to continue. No
 		 * panic because this can happen in midflight and just
 		 * because we can't use a new device is no reason to crash
@@ -297,12 +298,12 @@ css_rescan_devices(void)
 		/* -ENXIO indicates that there are no more subchannels. */
 		if (ret == -ENXIO)
 			break;
-	}
+	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
 }
 
 struct slow_subchannel {
 	struct list_head slow_list;
-	unsigned long schid;
+	struct subchannel_id schid;
 };
 
 static LIST_HEAD(slow_subchannels_head);
@@ -357,20 +358,24 @@ int
 css_process_crw(int irq)
 {
 	int ret;
+	struct subchannel_id mchk_schid;
 
 	CIO_CRW_EVENT(2, "source is subchannel %04X\n", irq);
 
 	if (need_rescan)
 		/* We need to iterate all subchannels anyway. */
 		return -EAGAIN;
+
+	init_subchannel_id(&mchk_schid);
+	mchk_schid.sch_no = irq;
 	/* 
 	 * Since we are always presented with IPI in the CRW, we have to
 	 * use stsch() to find out if the subchannel in question has come
 	 * or gone.
 	 */
-	ret = css_evaluate_subchannel(irq, 0);
+	ret = css_evaluate_subchannel(mchk_schid, 0);
 	if (ret == -EAGAIN) {
-		if (css_enqueue_subchannel_slow(irq)) {
+		if (css_enqueue_subchannel_slow(mchk_schid)) {
 			css_clear_subchannel_slow_list();
 			need_rescan = 1;
 		}
@@ -404,7 +409,8 @@ css_generate_pgid(void)
 static int __init
 init_channel_subsystem (void)
 {
-	int ret, irq;
+	int ret;
+	struct subchannel_id schid;
 
 	if (chsc_determine_css_characteristics() == 0)
 		css_characteristics_avail = 1;
@@ -420,13 +426,14 @@ init_channel_subsystem (void)
 
 	ctl_set_bit(6, 28);
 
-	for (irq = 0; irq < __MAX_SUBCHANNELS; irq++) {
+	init_subchannel_id(&schid);
+	do {
 		struct subchannel *sch;
 
-		if (cio_is_console(irq))
+		if (cio_is_console(schid))
 			sch = cio_get_console_subchannel();
 		else {
-			sch = css_alloc_subchannel(irq);
+			sch = css_alloc_subchannel(schid);
 			if (IS_ERR(sch))
 				ret = PTR_ERR(sch);
 			else
@@ -448,7 +455,7 @@ init_channel_subsystem (void)
 		 * console subchannel.
 		 */
 		css_register_subchannel(sch);
-	}
+	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
 	return 0;
 
 out_bus:
@@ -482,7 +489,7 @@ struct bus_type css_bus_type = {
 subsys_initcall(init_channel_subsystem);
 
 int
-css_enqueue_subchannel_slow(unsigned long schid)
+css_enqueue_subchannel_slow(struct subchannel_id schid)
 {
 	struct slow_subchannel *new_slow_sch;
 	unsigned long flags;
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.h	2005-12-09 14:25:54.000000000 +0100
@@ -6,6 +6,8 @@
 
 #include <asm/cio.h>
 
+#include "schid.h"
+
 /*
  * path grouping stuff
  */
@@ -68,7 +70,7 @@ struct ccw_device_private {
 	atomic_t onoff;
 	unsigned long registered;
 	__u16 devno;		/* device number */
-	__u16 irq;		/* subchannel number */
+	__u16 sch_no;		/* subchannel number */
 	__u8 imask;		/* lpm mask for SNID/SID/SPGID */
 	int iretry;		/* retry counter SNID/SID/SPGID */
 	struct {
@@ -121,12 +123,11 @@ struct css_driver {
 extern struct bus_type css_bus_type;
 extern struct css_driver io_subchannel_driver;
 
-int css_probe_device(int irq);
-extern struct subchannel * get_subchannel_by_schid(int irq);
-extern unsigned int highest_subchannel;
+extern int css_probe_device(struct subchannel_id);
+extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
 
-#define __MAX_SUBCHANNELS 65536
+#define __MAX_SUBCHANNEL 65535
 
 extern struct bus_type css_bus_type;
 extern struct device css_bus_device;
@@ -144,7 +145,7 @@ void device_set_waiting(struct subchanne
 void device_kill_pending_timer(struct subchannel *);
 
 /* Helper functions to build lists for the slow path. */
-int css_enqueue_subchannel_slow(unsigned long schid);
+extern int css_enqueue_subchannel_slow(struct subchannel_id schid);
 void css_walk_subchannel_slow_list(void (*fn)(unsigned long));
 void css_clear_subchannel_slow_list(void);
 int css_slow_subchannels_exist(void);
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2005-12-09 14:24:15.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2005-12-09 14:25:54.000000000 +0100
@@ -622,7 +622,7 @@ ccw_device_do_unreg_rereg(void *data)
 
 			other_sch = to_subchannel(other_cdev->dev.parent);
 			if (get_device(&other_sch->dev)) {
-				stsch(other_sch->irq, &other_sch->schib);
+				stsch(other_sch->schid, &other_sch->schib);
 				if (other_sch->schib.pmcw.dnv) {
 					other_sch->schib.pmcw.intparm = 0;
 					cio_modify(other_sch);
@@ -772,7 +772,7 @@ io_subchannel_recog(struct ccw_device *c
 	/* Init private data. */
 	priv = cdev->private;
 	priv->devno = sch->schib.pmcw.dev;
-	priv->irq = sch->irq;
+	priv->sch_no = sch->schid.sch_no;
 	priv->state = DEV_STATE_NOT_OPER;
 	INIT_LIST_HEAD(&priv->cmb_list);
 	init_waitqueue_head(&priv->wait_q);
@@ -951,7 +951,7 @@ io_subchannel_shutdown(struct device *de
 	sch = to_subchannel(dev);
 	cdev = dev->driver_data;
 
-	if (cio_is_console(sch->irq))
+	if (cio_is_console(sch->schid))
 		return;
 	if (!sch->schib.pmcw.ena)
 		/* Nothing to do. */
@@ -1146,6 +1146,16 @@ ccw_driver_unregister (struct ccw_driver
 	driver_unregister(&cdriver->driver);
 }
 
+/* Helper func for qdio. */
+struct subchannel_id
+ccw_device_get_subchannel_id(struct ccw_device *cdev)
+{
+	struct subchannel *sch;
+
+	sch = to_subchannel(cdev->dev.parent);
+	return sch->schid;
+}
+
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_online);
 EXPORT_SYMBOL(ccw_device_set_offline);
@@ -1155,3 +1165,4 @@ EXPORT_SYMBOL(get_ccwdev_by_busid);
 EXPORT_SYMBOL(ccw_bus_type);
 EXPORT_SYMBOL(ccw_device_work);
 EXPORT_SYMBOL(ccw_device_notify_work);
+EXPORT_SYMBOL_GPL(ccw_device_get_subchannel_id);
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2005-12-09 14:21:46.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2005-12-09 14:25:54.000000000 +0100
@@ -133,7 +133,7 @@ ccw_device_cancel_halt_clear(struct ccw_
 	int ret;
 
 	sch = to_subchannel(cdev->dev.parent);
-	ret = stsch(sch->irq, &sch->schib);
+	ret = stsch(sch->schid, &sch->schib);
 	if (ret || !sch->schib.pmcw.dnv)
 		return -ENODEV; 
 	if (!sch->schib.pmcw.ena || sch->schib.scsw.actl == 0)
@@ -231,7 +231,7 @@ ccw_device_recog_done(struct ccw_device 
 	 * through ssch() and the path information is up to date.
 	 */
 	old_lpm = sch->lpm;
-	stsch(sch->irq, &sch->schib);
+	stsch(sch->schid, &sch->schib);
 	sch->lpm = sch->schib.pmcw.pim &
 		sch->schib.pmcw.pam &
 		sch->schib.pmcw.pom &
@@ -258,7 +258,7 @@ ccw_device_recog_done(struct ccw_device 
 	case DEV_STATE_NOT_OPER:
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : unknown device %04x on subchannel %04x\n",
-			  cdev->private->devno, sch->irq);
+			  cdev->private->devno, sch->schid.sch_no);
 		break;
 	case DEV_STATE_OFFLINE:
 		if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID) {
@@ -291,7 +291,7 @@ ccw_device_recog_done(struct ccw_device 
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "SenseID : boxed device %04x on subchannel %04x\n",
-			  cdev->private->devno, sch->irq);
+			  cdev->private->devno, sch->schid.sch_no);
 		break;
 	}
 	cdev->private->state = state;
@@ -359,7 +359,7 @@ ccw_device_done(struct ccw_device *cdev,
 	if (state == DEV_STATE_BOXED)
 		CIO_DEBUG(KERN_WARNING, 2,
 			  "Boxed device %04x on subchannel %04x\n",
-			  cdev->private->devno, sch->irq);
+			  cdev->private->devno, sch->schid.sch_no);
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
@@ -592,7 +592,7 @@ ccw_device_offline(struct ccw_device *cd
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	if (stsch(sch->irq, &sch->schib) || !sch->schib.pmcw.dnv)
+	if (stsch(sch->schid, &sch->schib) || !sch->schib.pmcw.dnv)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE) {
 		if (sch->schib.scsw.actl != 0)
@@ -711,7 +711,7 @@ ccw_device_online_verify(struct ccw_devi
 	 * Since we might not just be coming from an interrupt from the
 	 * subchannel we have to update the schib.
 	 */
-	stsch(sch->irq, &sch->schib);
+	stsch(sch->schid, &sch->schib);
 
 	if (sch->schib.scsw.actl != 0 ||
 	    (cdev->private->irb.scsw.stctl & SCSW_STCTL_STATUS_PEND)) {
@@ -923,7 +923,7 @@ ccw_device_wait4io_irq(struct ccw_device
 
 	/* Iff device is idle, reset timeout. */
 	sch = to_subchannel(cdev->dev.parent);
-	if (!stsch(sch->irq, &sch->schib))
+	if (!stsch(sch->schid, &sch->schib))
 		if (sch->schib.scsw.actl == 0)
 			ccw_device_set_timeout(cdev, 0);
 	/* Call the handler. */
@@ -1035,7 +1035,7 @@ device_trigger_reprobe(struct subchannel
 		return;
 
 	/* Update some values. */
-	if (stsch(sch->irq, &sch->schib))
+	if (stsch(sch->schid, &sch->schib))
 		return;
 
 	/*
diff -urpN linux-2.6/drivers/s390/cio/device.h linux-2.6-patched/drivers/s390/cio/device.h
--- linux-2.6/drivers/s390/cio/device.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device.h	2005-12-09 14:25:54.000000000 +0100
@@ -110,6 +110,7 @@ int ccw_device_stlck(struct ccw_device *
 
 /* qdio needs this. */
 void ccw_device_set_timeout(struct ccw_device *, int);
+extern struct subchannel_id ccw_device_get_subchannel_id(struct ccw_device *);
 
 void retry_set_schib(struct ccw_device *cdev);
 #endif
diff -urpN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-patched/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_id.c	2005-12-09 14:25:54.000000000 +0100
@@ -258,7 +258,7 @@ ccw_device_check_sense_id(struct ccw_dev
 		 */
 		CIO_MSG_EVENT(2, "SenseID : device %04x on Subchannel %04x "
 			      "reports cmd reject\n",
-			      cdev->private->devno, sch->irq);
+			      cdev->private->devno, sch->schid.sch_no);
 		return -EOPNOTSUPP;
 	}
 	if (irb->esw.esw0.erw.cons) {
@@ -280,13 +280,13 @@ ccw_device_check_sense_id(struct ccw_dev
 			CIO_MSG_EVENT(2, "SenseID : path %02X for device %04x on"
 				      " subchannel %04x is 'not operational'\n",
 				      sch->orb.lpm, cdev->private->devno,
-				      sch->irq);
+				      sch->schid.sch_no);
 		return -EACCES;
 	}
 	/* Hmm, whatever happened, try again. */
 	CIO_MSG_EVENT(2, "SenseID : start_IO() for device %04x on "
 		      "subchannel %04x returns status %02X%02X\n",
-		      cdev->private->devno, sch->irq,
+		      cdev->private->devno, sch->schid.sch_no,
 		      irb->scsw.dstat, irb->scsw.cstat);
 	return -EAGAIN;
 }
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2005-12-09 14:21:46.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2005-12-09 14:25:54.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device_ops.c
  *
- *   $Revision: 1.57 $
+ *   $Revision: 1.58 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -570,7 +570,7 @@ ccw_device_get_chp_desc(struct ccw_devic
 int
 _ccw_device_get_subchannel_number(struct ccw_device *cdev)
 {
-	return cdev->private->irq;
+	return cdev->private->sch_no;
 }
 
 int
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2005-12-09 14:24:22.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2005-12-09 14:25:54.000000000 +0100
@@ -59,7 +59,7 @@ __ccw_device_sense_pgid_start(struct ccw
 			CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel "
 				      "%04x, lpm %02X, became 'not "
 				      "operational'\n",
-				      cdev->private->devno, sch->irq,
+				      cdev->private->devno, sch->schid.sch_no,
 				      cdev->private->imask);
 
 		}
@@ -121,13 +121,14 @@ __ccw_device_check_sense_pgid(struct ccw
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel "
 			      "%04x, lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->irq, sch->orb.lpm);
+			      cdev->private->devno, sch->schid.sch_no,
+			      sch->orb.lpm);
 		return -EACCES;
 	}
 	if (cdev->private->pgid.inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
 		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel %04x "
 			      "is reserved by someone else\n",
-			      cdev->private->devno, sch->irq);
+			      cdev->private->devno, sch->schid.sch_no);
 		return -EUSERS;
 	}
 	return 0;
@@ -237,7 +238,7 @@ __ccw_device_do_pgid(struct ccw_device *
 	sch->vpm &= ~cdev->private->imask;
 	CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel "
 		      "%04x, lpm %02X, became 'not operational'\n",
-		      cdev->private->devno, sch->irq, cdev->private->imask);
+		      cdev->private->devno, sch->schid.sch_no, cdev->private->imask);
 	return ret;
 }
 
@@ -271,7 +272,7 @@ __ccw_device_check_pgid(struct ccw_devic
 	if (irb->scsw.cc == 3) {
 		CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel "
 			      "%04x, lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->irq,
+			      cdev->private->devno, sch->schid.sch_no,
 			      cdev->private->imask);
 		return -EACCES;
 	}
@@ -373,7 +374,7 @@ ccw_device_verify_start(struct ccw_devic
 	 * Update sch->lpm with current values to catch paths becoming
 	 * available again.
 	 */
-	if (stsch(sch->irq, &sch->schib)) {
+	if (stsch(sch->schid, &sch->schib)) {
 		ccw_device_verify_done(cdev, -ENODEV);
 		return;
 	}
diff -urpN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-patched/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_status.c	2005-12-09 14:25:54.000000000 +0100
@@ -38,13 +38,13 @@ ccw_device_msg_control_check(struct ccw_
 		      "received"
 		      " ... device %04X on subchannel %04X, dev_stat "
 		      ": %02X sch_stat : %02X\n",
-		      cdev->private->devno, cdev->private->irq,
+		      cdev->private->devno, cdev->private->sch_no,
 		      irb->scsw.dstat, irb->scsw.cstat);
 
 	if (irb->scsw.cc != 3) {
 		char dbf_text[15];
 
-		sprintf(dbf_text, "chk%x", cdev->private->irq);
+		sprintf(dbf_text, "chk%x", cdev->private->sch_no);
 		CIO_TRACE_EVENT(0, dbf_text);
 		CIO_HEX_EVENT(0, irb, sizeof (struct irb));
 	}
@@ -59,10 +59,10 @@ ccw_device_path_notoper(struct ccw_devic
 	struct subchannel *sch;
 
 	sch = to_subchannel(cdev->dev.parent);
-	stsch (sch->irq, &sch->schib);
+	stsch (sch->schid, &sch->schib);
 
 	CIO_MSG_EVENT(0, "%s(%04x) - path(s) %02x are "
-		      "not operational \n", __FUNCTION__, sch->irq,
+		      "not operational \n", __FUNCTION__, sch->schid.sch_no,
 		      sch->schib.pmcw.pnom);
 
 	sch->lpm &= ~sch->schib.pmcw.pnom;
diff -urpN linux-2.6/drivers/s390/cio/ioasm.h linux-2.6-patched/drivers/s390/cio/ioasm.h
--- linux-2.6/drivers/s390/cio/ioasm.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/ioasm.h	2005-12-09 14:25:54.000000000 +0100
@@ -1,12 +1,13 @@
 #ifndef S390_CIO_IOASM_H
 #define S390_CIO_IOASM_H
 
+#include "schid.h"
+
 /*
  * TPI info structure
  */
 struct tpi_info {
-	__u32 reserved1	 : 16;	 /* reserved 0x00000001 */
-	__u32 irq	 : 16;	 /* aka. subchannel number */
+	struct subchannel_id schid;
 	__u32 intparm;		 /* interruption parameter */
 	__u32 adapter_IO : 1;
 	__u32 reserved2	 : 1;
@@ -21,7 +22,8 @@ struct tpi_info {
  * Some S390 specific IO instructions as inline
  */
 
-static inline int stsch(int irq, volatile struct schib *addr)
+static inline int stsch(struct subchannel_id schid,
+			    volatile struct schib *addr)
 {
 	int ccode;
 
@@ -31,12 +33,13 @@ static inline int stsch(int irq, volatil
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "d" (irq | 0x10000), "a" (addr)
+		: "d" (schid), "a" (addr), "m" (*addr)
 		: "cc", "1" );
 	return ccode;
 }
 
-static inline int msch(int irq, volatile struct schib *addr)
+static inline int msch(struct subchannel_id schid,
+			   volatile struct schib *addr)
 {
 	int ccode;
 
@@ -46,12 +49,13 @@ static inline int msch(int irq, volatile
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "d" (irq | 0x10000L), "a" (addr)
+		: "d" (schid), "a" (addr), "m" (*addr)
 		: "cc", "1" );
 	return ccode;
 }
 
-static inline int msch_err(int irq, volatile struct schib *addr)
+static inline int msch_err(struct subchannel_id schid,
+			       volatile struct schib *addr)
 {
 	int ccode;
 
@@ -74,12 +78,13 @@ static inline int msch_err(int irq, vola
 		".previous"
 #endif
 		: "=&d" (ccode)
-		: "d" (irq | 0x10000L), "a" (addr), "K" (-EIO)
+		: "d" (schid), "a" (addr), "K" (-EIO), "m" (*addr)
 		: "cc", "1" );
 	return ccode;
 }
 
-static inline int tsch(int irq, volatile struct irb *addr)
+static inline int tsch(struct subchannel_id schid,
+			   volatile struct irb *addr)
 {
 	int ccode;
 
@@ -89,7 +94,7 @@ static inline int tsch(int irq, volatile
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "d" (irq | 0x10000L), "a" (addr)
+		: "d" (schid), "a" (addr), "m" (*addr)
 		: "cc", "1" );
 	return ccode;
 }
@@ -103,12 +108,13 @@ static inline int tpi( volatile struct t
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "a" (addr)
+		: "a" (addr), "m" (*addr)
 		: "cc", "1" );
 	return ccode;
 }
 
-static inline int ssch(int irq, volatile struct orb *addr)
+static inline int ssch(struct subchannel_id schid,
+			   volatile struct orb *addr)
 {
 	int ccode;
 
@@ -118,12 +124,12 @@ static inline int ssch(int irq, volatile
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "d" (irq | 0x10000L), "a" (addr)
+		: "d" (schid), "a" (addr), "m" (*addr)
 		: "cc", "1" );
 	return ccode;
 }
 
-static inline int rsch(int irq)
+static inline int rsch(struct subchannel_id schid)
 {
 	int ccode;
 
@@ -133,12 +139,12 @@ static inline int rsch(int irq)
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "d" (irq | 0x10000L)
+		: "d" (schid)
 		: "cc", "1" );
 	return ccode;
 }
 
-static inline int csch(int irq)
+static inline int csch(struct subchannel_id schid)
 {
 	int ccode;
 
@@ -148,12 +154,12 @@ static inline int csch(int irq)
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "d" (irq | 0x10000L)
+		: "d" (schid)
 		: "cc", "1" );
 	return ccode;
 }
 
-static inline int hsch(int irq)
+static inline int hsch(struct subchannel_id schid)
 {
 	int ccode;
 
@@ -163,12 +169,12 @@ static inline int hsch(int irq)
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "d" (irq | 0x10000L)
+		: "d" (schid)
 		: "cc", "1" );
 	return ccode;
 }
 
-static inline int xsch(int irq)
+static inline int xsch(struct subchannel_id schid)
 {
 	int ccode;
 
@@ -178,21 +184,22 @@ static inline int xsch(int irq)
 		"   ipm	  %0\n"
 		"   srl	  %0,28"
 		: "=d" (ccode)
-		: "d" (irq | 0x10000L)
+		: "d" (schid)
 		: "cc", "1" );
 	return ccode;
 }
 
 static inline int chsc(void *chsc_area)
 {
+	typedef struct { char _[4096]; } addr_type;
 	int cc;
 
 	__asm__ __volatile__ (
-		".insn	rre,0xb25f0000,%1,0	\n\t"
+		".insn	rre,0xb25f0000,%2,0	\n\t"
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
-		: "=d" (cc)
-		: "d" (chsc_area)
+		: "=d" (cc), "=m" (*(addr_type *) chsc_area)
+		: "d" (chsc_area), "m" (*(addr_type *) chsc_area)
 		: "cc" );
 
 	return cc;
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2005-12-09 14:25:54.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2005-12-09 14:25:54.000000000 +0100
@@ -270,7 +270,7 @@ qdio_siga_sync(struct qdio_q *q, unsigne
 	perf_stats.siga_syncs++;
 #endif /* QDIO_PERFORMANCE_STATS */
 
-	cc = do_siga_sync(0x10000|q->irq, gpr2, gpr3);
+	cc = do_siga_sync(q->schid, gpr2, gpr3);
 	if (cc)
 		QDIO_DBF_HEX3(0,trace,&cc,sizeof(int*));
 
@@ -290,12 +290,16 @@ __do_siga_output(struct qdio_q *q, unsig
 {
        struct qdio_irq *irq;
        unsigned int fc = 0;
+       unsigned long schid;
 
        irq = (struct qdio_irq *) q->irq_ptr;
        if (!irq->is_qebsm)
-               return do_siga_output(0x10000|q->irq, q->mask, busy_bit, fc);
-       fc |= 0x80;
-       return do_siga_output(irq->sch_token, q->mask, busy_bit, fc);
+	       schid = *((u32 *)&q->schid);
+       else {
+	       schid = irq->sch_token;
+	       fc |= 0x80;
+       }
+       return do_siga_output(schid, q->mask, busy_bit, fc);
 }
 
 /* 
@@ -349,7 +353,7 @@ qdio_siga_input(struct qdio_q *q)
 	perf_stats.siga_ins++;
 #endif /* QDIO_PERFORMANCE_STATS */
 
-	cc = do_siga_input(0x10000|q->irq, q->mask);
+	cc = do_siga_input(q->schid, q->mask);
 	
 	if (cc)
 		QDIO_DBF_HEX3(0,trace,&cc,sizeof(int*));
@@ -855,7 +859,7 @@ qdio_kick_outbound_q(struct qdio_q *q)
 		/* went smooth this time, reset timestamp */
 #ifdef CONFIG_QDIO_DEBUG
 		QDIO_DBF_TEXT3(0,trace,"cc2reslv");
-		sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
+		sprintf(dbf_text,"%4x%2x%2x",q->schid.sch_no,q->q_no,
 			atomic_read(&q->busy_siga_counter));
 		QDIO_DBF_TEXT3(0,trace,dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
@@ -878,7 +882,7 @@ qdio_kick_outbound_q(struct qdio_q *q)
 		}
 		QDIO_DBF_TEXT2(0,trace,"cc2REPRT");
 #ifdef CONFIG_QDIO_DEBUG
-		sprintf(dbf_text,"%4x%2x%2x",q->irq,q->q_no,
+		sprintf(dbf_text,"%4x%2x%2x",q->schid.sch_no,q->q_no,
 			atomic_read(&q->busy_siga_counter));
 		QDIO_DBF_TEXT3(0,trace,dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
@@ -1733,7 +1737,7 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 	void *ptr;
 	int available;
 
-	sprintf(dbf_text,"qfqs%4x",cdev->private->irq);
+	sprintf(dbf_text,"qfqs%4x",cdev->private->sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	for (i=0;i<no_input_qs;i++) {
 		q=irq_ptr->input_qs[i];
@@ -1753,7 +1757,7 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 
                 q->queue_type=q_format;
 		q->int_parm=int_parm;
-		q->irq=irq_ptr->irq;
+		q->schid = irq_ptr->schid;
 		q->irq_ptr = irq_ptr;
 		q->cdev = cdev;
 		q->mask=1<<(31-i);
@@ -1826,7 +1830,7 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
                 q->queue_type=q_format;
 		q->int_parm=int_parm;
 		q->is_input_q=0;
-		q->irq=irq_ptr->irq;
+		q->schid = irq_ptr->schid;
 		q->cdev = cdev;
 		q->irq_ptr = irq_ptr;
 		q->mask=1<<(31-i);
@@ -1933,7 +1937,7 @@ qdio_set_state(struct qdio_irq *irq_ptr,
 	char dbf_text[15];
 
 	QDIO_DBF_TEXT5(0,trace,"newstate");
-	sprintf(dbf_text,"%4x%4x",irq_ptr->irq,state);
+	sprintf(dbf_text,"%4x%4x",irq_ptr->schid.sch_no,state);
 	QDIO_DBF_TEXT5(0,trace,dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
 
@@ -1946,12 +1950,12 @@ qdio_set_state(struct qdio_irq *irq_ptr,
 }
 
 static inline void
-qdio_irq_check_sense(int irq, struct irb *irb)
+qdio_irq_check_sense(struct subchannel_id schid, struct irb *irb)
 {
 	char dbf_text[15];
 
 	if (irb->esw.esw0.erw.cons) {
-		sprintf(dbf_text,"sens%4x",irq);
+		sprintf(dbf_text,"sens%4x",schid.sch_no);
 		QDIO_DBF_TEXT2(1,trace,dbf_text);
 		QDIO_DBF_HEX0(0,sense,irb,QDIO_DBF_SENSE_LEN);
 
@@ -2063,20 +2067,20 @@ qdio_timeout_handler(struct ccw_device *
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_INACTIVE:
 		QDIO_PRINT_ERR("establish queues on irq %04x: timed out\n",
-			       irq_ptr->irq);
+			       irq_ptr->schid.sch_no);
 		QDIO_DBF_TEXT2(1,setup,"eq:timeo");
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		break;
 	case QDIO_IRQ_STATE_CLEANUP:
 		QDIO_PRINT_INFO("Did not get interrupt on cleanup, irq=0x%x.\n",
-				irq_ptr->irq);
+				irq_ptr->schid.sch_no);
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		break;
 	case QDIO_IRQ_STATE_ESTABLISHED:
 	case QDIO_IRQ_STATE_ACTIVE:
 		/* I/O has been terminated by common I/O layer. */
 		QDIO_PRINT_INFO("Queues on irq %04x killed by cio.\n",
-				irq_ptr->irq);
+				irq_ptr->schid.sch_no);
 		QDIO_DBF_TEXT2(1, trace, "cio:term");
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
 		if (get_device(&cdev->dev)) {
@@ -2139,7 +2143,7 @@ qdio_handler(struct ccw_device *cdev, un
 		}
 	}
 
-	qdio_irq_check_sense(irq_ptr->irq, irb);
+	qdio_irq_check_sense(irq_ptr->schid, irb);
 
 #ifdef CONFIG_QDIO_DEBUG
 	sprintf(dbf_text, "state:%d", irq_ptr->state);
@@ -2195,7 +2199,7 @@ qdio_synchronize(struct ccw_device *cdev
 		return -ENODEV;
 
 #ifdef CONFIG_QDIO_DEBUG
-	*((int*)(&dbf_text[4])) = irq_ptr->irq;
+	*((int*)(&dbf_text[4])) = irq_ptr->schid.sch_no;
 	QDIO_DBF_HEX4(0,trace,dbf_text,QDIO_DBF_TRACE_LEN);
 	*((int*)(&dbf_text[0]))=flags;
 	*((int*)(&dbf_text[4]))=queue_number;
@@ -2207,13 +2211,13 @@ qdio_synchronize(struct ccw_device *cdev
 		if (!q)
 			return -EINVAL;
 		if (!(irq_ptr->is_qebsm))
-			cc = do_siga_sync(0x10000|q->irq, 0, q->mask);
+			cc = do_siga_sync(q->schid, 0, q->mask);
 	} else if (flags&QDIO_FLAG_SYNC_OUTPUT) {
 		q=irq_ptr->output_qs[queue_number];
 		if (!q)
 			return -EINVAL;
 		if (!(irq_ptr->is_qebsm))
-			cc = do_siga_sync(0x10000|q->irq, q->mask, 0);
+			cc = do_siga_sync(q->schid, q->mask, 0);
 	} else 
 		return -EINVAL;
 
@@ -2298,7 +2302,7 @@ qdio_get_ssqd_information(struct qdio_ir
 	ssqd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!ssqd_area) {
 	        QDIO_PRINT_WARN("Could not get memory for chsc. Using all " \
-				"SIGAs for sch x%x.\n", irq_ptr->irq);
+				"SIGAs for sch x%x.\n", irq_ptr->schid.sch_no);
 		irq_ptr->qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY ||
 				  CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
 				  CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
@@ -2312,14 +2316,14 @@ qdio_get_ssqd_information(struct qdio_ir
 		.length = 0x0010,
 		.code   = 0x0024,
 	};
-	ssqd_area->first_sch = irq_ptr->irq;
-	ssqd_area->last_sch = irq_ptr->irq;
+	ssqd_area->first_sch = irq_ptr->schid.sch_no;
+	ssqd_area->last_sch = irq_ptr->schid.sch_no;
 	result = chsc(ssqd_area);
 
 	if (result) {
 		QDIO_PRINT_WARN("CHSC returned cc %i. Using all " \
 				"SIGAs for sch x%x.\n",
-				result, irq_ptr->irq);
+				result, irq_ptr->schid.sch_no);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
@@ -2330,7 +2334,7 @@ qdio_get_ssqd_information(struct qdio_ir
 	if (ssqd_area->response.code != QDIO_CHSC_RESPONSE_CODE_OK) {
 		QDIO_PRINT_WARN("response upon checking SIGA needs " \
 				"is 0x%x. Using all SIGAs for sch x%x.\n",
-				ssqd_area->response.code, irq_ptr->irq);
+				ssqd_area->response.code, irq_ptr->schid.sch_no);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
@@ -2339,9 +2343,9 @@ qdio_get_ssqd_information(struct qdio_ir
 	}
 	if (!(ssqd_area->flags & CHSC_FLAG_QDIO_CAPABILITY) ||
 	    !(ssqd_area->flags & CHSC_FLAG_VALIDITY) ||
-	    (ssqd_area->sch != irq_ptr->irq)) {
+	    (ssqd_area->sch != irq_ptr->schid.sch_no)) {
 		QDIO_PRINT_WARN("huh? problems checking out sch x%x... " \
-				"using all SIGAs.\n",irq_ptr->irq);
+				"using all SIGAs.\n",irq_ptr->schid.sch_no);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY |
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY |
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* worst case */
@@ -2427,7 +2431,7 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 		/* set to 0x10000000 to enable
 		 * time delay disablement facility */
 		u32 reserved5;
-		u32 subsystem_id;
+		struct subchannel_id schid;
 		u32 reserved6[1004];
 		struct chsc_header response;
 		u32 reserved7;
@@ -2449,7 +2453,7 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 	scssc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scssc_area) {
 		QDIO_PRINT_WARN("No memory for setting indicators on " \
-				"subchannel x%x.\n", irq_ptr->irq);
+				"subchannel x%x.\n", irq_ptr->schid.sch_no);
 		return -ENOMEM;
 	}
 	scssc_area->request = (struct chsc_header) {
@@ -2463,7 +2467,7 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 	scssc_area->ks = QDIO_STORAGE_KEY;
 	scssc_area->kc = QDIO_STORAGE_KEY;
 	scssc_area->isc = TIQDIO_THININT_ISC;
-	scssc_area->subsystem_id = (1<<16) + irq_ptr->irq;
+	scssc_area->schid = irq_ptr->schid;
 	/* enables the time delay disablement facility. Don't care
 	 * whether it is really there (i.e. we haven't checked for
 	 * it) */
@@ -2473,12 +2477,10 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 		QDIO_PRINT_WARN("Time delay disablement facility " \
 				"not available\n");
 
-
-
 	result = chsc(scssc_area);
 	if (result) {
 		QDIO_PRINT_WARN("could not set indicators on irq x%x, " \
-				"cc=%i.\n",irq_ptr->irq,result);
+				"cc=%i.\n",irq_ptr->schid.sch_no,result);
 		result = -EIO;
 		goto out;
 	}
@@ -2534,7 +2536,7 @@ tiqdio_set_delay_target(struct qdio_irq 
 	scsscf_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scsscf_area) {
 		QDIO_PRINT_WARN("No memory for setting delay target on " \
-				"subchannel x%x.\n", irq_ptr->irq);
+				"subchannel x%x.\n", irq_ptr->schid.sch_no);
 		return -ENOMEM;
 	}
 	scsscf_area->request = (struct chsc_header) {
@@ -2547,7 +2549,8 @@ tiqdio_set_delay_target(struct qdio_irq 
 	result=chsc(scsscf_area);
 	if (result) {
 		QDIO_PRINT_WARN("could not set delay target on irq x%x, " \
-				"cc=%i. Continuing.\n",irq_ptr->irq,result);
+				"cc=%i. Continuing.\n",irq_ptr->schid.sch_no,
+				result);
 		result = -EIO;
 		goto out;
 	}
@@ -2581,7 +2584,7 @@ qdio_cleanup(struct ccw_device *cdev, in
 	if (!irq_ptr)
 		return -ENODEV;
 
-	sprintf(dbf_text,"qcln%4x",irq_ptr->irq);
+	sprintf(dbf_text,"qcln%4x",irq_ptr->schid.sch_no);
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
@@ -2608,7 +2611,7 @@ qdio_shutdown(struct ccw_device *cdev, i
 
 	down(&irq_ptr->setting_up_sema);
 
-	sprintf(dbf_text,"qsqs%4x",irq_ptr->irq);
+	sprintf(dbf_text,"qsqs%4x",irq_ptr->schid.sch_no);
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
@@ -2714,7 +2717,7 @@ qdio_free(struct ccw_device *cdev)
 
 	down(&irq_ptr->setting_up_sema);
 
-	sprintf(dbf_text,"qfqs%4x",irq_ptr->irq);
+	sprintf(dbf_text,"qfqs%4x",irq_ptr->schid.sch_no);
 	QDIO_DBF_TEXT1(0,trace,dbf_text);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 
@@ -2862,13 +2865,13 @@ qdio_establish_irq_check_for_errors(stru
 	irq_ptr = cdev->private->qdio_data;
 
 	if (cstat || (dstat & ~(DEV_STAT_CHN_END|DEV_STAT_DEV_END))) {
-		sprintf(dbf_text,"ick1%4x",irq_ptr->irq);
+		sprintf(dbf_text,"ick1%4x",irq_ptr->schid.sch_no);
 		QDIO_DBF_TEXT2(1,trace,dbf_text);
 		QDIO_DBF_HEX2(0,trace,&dstat,sizeof(int));
 		QDIO_DBF_HEX2(0,trace,&cstat,sizeof(int));
 		QDIO_PRINT_ERR("received check condition on establish " \
 			       "queues on irq 0x%x (cs=x%x, ds=x%x).\n",
-			       irq_ptr->irq,cstat,dstat);
+			       irq_ptr->schid.sch_no,cstat,dstat);
 		qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ERR);
 	}
 	
@@ -2878,7 +2881,7 @@ qdio_establish_irq_check_for_errors(stru
 		QDIO_DBF_HEX2(0,setup,&cstat, sizeof(cstat));
 		QDIO_PRINT_ERR("establish queues on irq %04x: didn't get "
 			       "device end: dstat=%02x, cstat=%02x\n",
-			       irq_ptr->irq, dstat, cstat);
+			       irq_ptr->schid.sch_no, dstat, cstat);
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		return 1;
 	}
@@ -2890,7 +2893,7 @@ qdio_establish_irq_check_for_errors(stru
 		QDIO_PRINT_ERR("establish queues on irq %04x: got "
 			       "the following devstat: dstat=%02x, "
 			       "cstat=%02x\n",
-			       irq_ptr->irq, dstat, cstat);
+			       irq_ptr->schid.sch_no, dstat, cstat);
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		return 1;
 	}
@@ -2905,7 +2908,7 @@ qdio_establish_handle_irq(struct ccw_dev
 
 	irq_ptr = cdev->private->qdio_data;
 
-	sprintf(dbf_text,"qehi%4x",cdev->private->irq);
+	sprintf(dbf_text,"qehi%4x",cdev->private->sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
@@ -2924,7 +2927,7 @@ qdio_initialize(struct qdio_initialize *
 	int rc;
 	char dbf_text[15];
 
-	sprintf(dbf_text,"qini%4x",init_data->cdev->private->irq);
+	sprintf(dbf_text,"qini%4x",init_data->cdev->private->sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
@@ -2945,7 +2948,7 @@ qdio_allocate(struct qdio_initialize *in
 	struct qdio_irq *irq_ptr;
 	char dbf_text[15];
 
-	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->irq);
+	sprintf(dbf_text,"qalc%4x",init_data->cdev->private->sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 	if ( (init_data->no_input_qs>QDIO_MAX_QUEUES_PER_IRQ) ||
@@ -3018,7 +3021,7 @@ int qdio_fill_irq(struct qdio_initialize
 
 	irq_ptr->int_parm=init_data->int_parm;
 
-	irq_ptr->irq = init_data->cdev->private->irq;
+	irq_ptr->schid = ccw_device_get_subchannel_id(init_data->cdev);
 	irq_ptr->no_input_qs=init_data->no_input_qs;
 	irq_ptr->no_output_qs=init_data->no_output_qs;
 
@@ -3038,7 +3041,7 @@ int qdio_fill_irq(struct qdio_initialize
 		QDIO_DBF_HEX1(0,setup,&irq_ptr->dev_st_chg_ind,sizeof(void*));
 		if (!irq_ptr->dev_st_chg_ind) {
 			QDIO_PRINT_WARN("no indicator location available " \
-					"for irq 0x%x\n",irq_ptr->irq);
+					"for irq 0x%x\n",irq_ptr->schid.sch_no);
 			qdio_release_irq_memory(irq_ptr);
 			return -ENOBUFS;
 		}
@@ -3169,7 +3172,7 @@ qdio_establish(struct qdio_initialize *i
 		tiqdio_set_delay_target(irq_ptr,TIQDIO_DELAY_TARGET);
 	}
 
-	sprintf(dbf_text,"qest%4x",cdev->private->irq);
+	sprintf(dbf_text,"qest%4x",cdev->private->sch_no);
 	QDIO_DBF_TEXT0(0,setup,dbf_text);
 	QDIO_DBF_TEXT0(0,trace,dbf_text);
 
@@ -3197,7 +3200,7 @@ qdio_establish(struct qdio_initialize *i
 		}
 		QDIO_PRINT_WARN("establish queues on irq %04x: do_IO " \
                            "returned %i, next try returned %i\n",
-                           irq_ptr->irq,result,result2);
+                           irq_ptr->schid.sch_no,result,result2);
 		result=result2;
 		if (result)
 			ccw_device_set_timeout(cdev, 0);
@@ -3270,7 +3273,7 @@ qdio_activate(struct ccw_device *cdev, i
 		goto out;
 	}
 
-	sprintf(dbf_text,"qact%4x", irq_ptr->irq);
+	sprintf(dbf_text,"qact%4x", irq_ptr->schid.sch_no);
 	QDIO_DBF_TEXT2(0,setup,dbf_text);
 	QDIO_DBF_TEXT2(0,trace,dbf_text);
 
@@ -3297,7 +3300,7 @@ qdio_activate(struct ccw_device *cdev, i
 		}
 		QDIO_PRINT_WARN("activate queues on irq %04x: do_IO " \
                            "returned %i, next try returned %i\n",
-                           irq_ptr->irq,result,result2);
+                           irq_ptr->schid.sch_no,result,result2);
 		result=result2;
 	}
 
@@ -3509,7 +3512,7 @@ do_QDIO(struct ccw_device *cdev,unsigned
 #ifdef CONFIG_QDIO_DEBUG
 	char dbf_text[20];
 
-	sprintf(dbf_text,"doQD%04x",cdev->private->irq);
+	sprintf(dbf_text,"doQD%04x",cdev->private->sch_no);
  	QDIO_DBF_TEXT3(0,trace,dbf_text);
 #endif /* CONFIG_QDIO_DEBUG */
 
diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2005-12-09 14:25:54.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2005-12-09 14:25:54.000000000 +0100
@@ -3,7 +3,9 @@
 
 #include <asm/page.h>
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.37 $"
+#include "schid.h"
+
+#define VERSION_CIO_QDIO_H "$Revision: 1.40 $"
 
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_VERBOSE_LEVEL 9
@@ -317,7 +319,7 @@ do_eqbs(unsigned long sch, unsigned char
 
 
 static inline int
-do_siga_sync(unsigned int irq, unsigned int mask1, unsigned int mask2)
+do_siga_sync(struct subchannel_id schid, unsigned int mask1, unsigned int mask2)
 {
 	int cc;
 
@@ -331,7 +333,7 @@ do_siga_sync(unsigned int irq, unsigned 
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc)
-		: "d" (irq), "d" (mask1), "d" (mask2)
+		: "d" (schid), "d" (mask1), "d" (mask2)
 		: "cc", "0", "1", "2", "3"
 		);
 #else /* CONFIG_ARCH_S390X */
@@ -344,7 +346,7 @@ do_siga_sync(unsigned int irq, unsigned 
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc)
-		: "d" (irq), "d" (mask1), "d" (mask2)
+		: "d" (schid), "d" (mask1), "d" (mask2)
 		: "cc", "0", "1", "2", "3"
 		);
 #endif /* CONFIG_ARCH_S390X */
@@ -352,7 +354,7 @@ do_siga_sync(unsigned int irq, unsigned 
 }
 
 static inline int
-do_siga_input(unsigned int irq, unsigned int mask)
+do_siga_input(struct subchannel_id schid, unsigned int mask)
 {
 	int cc;
 
@@ -365,7 +367,7 @@ do_siga_input(unsigned int irq, unsigned
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc)
-		: "d" (irq), "d" (mask)
+		: "d" (schid), "d" (mask)
 		: "cc", "0", "1", "2", "memory"
 		);
 #else /* CONFIG_ARCH_S390X */
@@ -377,7 +379,7 @@ do_siga_input(unsigned int irq, unsigned
 		"ipm	%0	\n\t"
 		"srl	%0,28	\n\t"
 		: "=d" (cc)
-		: "d" (irq), "d" (mask)
+		: "d" (schid), "d" (mask)
 		: "cc", "0", "1", "2", "memory"
 		);
 #endif /* CONFIG_ARCH_S390X */
@@ -386,7 +388,7 @@ do_siga_input(unsigned int irq, unsigned
 }
 
 static inline int
-do_siga_output(unsigned long irq, unsigned long mask, __u32 *bb,
+do_siga_output(unsigned long schid, unsigned long mask, __u32 *bb,
 	       unsigned int fc)
 {
 	int cc;
@@ -418,7 +420,7 @@ do_siga_output(unsigned long irq, unsign
 		".long	0b,2b	\n\t"
 		".previous	\n\t"
 		: "=d" (cc), "=d" (busy_bit)
-		: "d" (irq), "d" (mask),
+		: "d" (schid), "d" (mask),
 		"i" (QDIO_SIGA_ERROR_ACCESS_EXCEPTION)
 		: "cc", "0", "1", "2", "memory"
 		);
@@ -443,7 +445,7 @@ do_siga_output(unsigned long irq, unsign
 		".quad	0b,1b	\n\t"
 		".previous	\n\t"
 		: "=d" (cc), "=d" (busy_bit)
-		: "d" (irq), "d" (mask),
+		: "d" (schid), "d" (mask),
 		"i" (QDIO_SIGA_ERROR_ACCESS_EXCEPTION), "d" (fc)
 		: "cc", "0", "1", "2", "memory"
 		);
@@ -554,7 +556,7 @@ struct qdio_q {
 	__u32 * dev_st_chg_ind;
 
 	int is_input_q;
-	int irq;
+	struct subchannel_id schid;
 	struct ccw_device *cdev;
 
 	unsigned int is_iqdio_q;
@@ -649,7 +651,7 @@ struct qdio_irq {
 	__u32 * volatile dev_st_chg_ind;
 
 	unsigned long int_parm;
-	int irq;
+	struct subchannel_id schid;
 
 	unsigned int is_iqdio_irq;
 	unsigned int is_thinint_irq;
diff -urpN linux-2.6/drivers/s390/cio/schid.h linux-2.6-patched/drivers/s390/cio/schid.h
--- linux-2.6/drivers/s390/cio/schid.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/schid.h	2005-12-09 14:25:54.000000000 +0100
@@ -0,0 +1,25 @@
+#ifndef S390_SCHID_H
+#define S390_SCHID_H
+
+struct subchannel_id {
+	__u32 reserved:15;
+	__u32 one:1;
+	__u32 sch_no:16;
+} __attribute__ ((packed,aligned(4)));
+
+
+/* Helper function for sane state of pre-allocated subchannel_id. */
+static inline void
+init_subchannel_id(struct subchannel_id *schid)
+{
+	memset(schid, 0, sizeof(struct subchannel_id));
+	schid->one = 1;
+}
+
+static inline int
+schid_equal(struct subchannel_id *schid1, struct subchannel_id *schid2)
+{
+	return !memcmp(schid1, schid2, sizeof(struct subchannel_id));
+}
+
+#endif /* S390_SCHID_H */
