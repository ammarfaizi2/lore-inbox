Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVLIPaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVLIPaG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVLIP34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:29:56 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:61824 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964781AbVLIP3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:29:30 -0500
Date: Fri, 9 Dec 2005 16:29:28 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 16/17] s390: multiple subchannel sets support.
Message-ID: <20051209152928.GQ6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

[patch 16/17] s390: multiple subchannel sets support.

Add support for multiple subchannel sets. Works with arbitrary devices
in subchannel set 1 and is transparent to device drivers. Although
currently only two subchannel sets are available, this will work
with the architectured maximum number of subchannel sets as well.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/blacklist.c     |   86 ++++++++++++++++++++++-----------------
 drivers/s390/cio/blacklist.h     |    2 
 drivers/s390/cio/chsc.c          |   68 +++++++++++++++++++++++++++---
 drivers/s390/cio/chsc.h          |    4 +
 drivers/s390/cio/cio.c           |   35 +++++++++------
 drivers/s390/cio/css.c           |   44 ++++++++++++++-----
 drivers/s390/cio/css.h           |    2 
 drivers/s390/cio/device.c        |   22 ++++++---
 drivers/s390/cio/device_fsm.c    |   15 ++++--
 drivers/s390/cio/device_id.c     |   22 +++++----
 drivers/s390/cio/device_pgid.c   |   40 +++++++++---------
 drivers/s390/cio/device_status.c |   10 ++--
 drivers/s390/cio/ioasm.h         |   29 +++++++++++++
 drivers/s390/cio/qdio.c          |   81 +++++++++++++++++++++---------------
 drivers/s390/cio/schid.h         |    3 -
 drivers/s390/s390mach.c          |   56 +++++++++++++++++++------
 16 files changed, 354 insertions(+), 165 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2005-12-09 14:26:06.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2005-12-09 14:26:06.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.35 $
+ *   $Revision: 1.39 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -35,10 +35,10 @@
  * These can be single devices or ranges of devices
  */
 
-/* 65536 bits to indicate if a devno is blacklisted or not */
+/* 65536 bits for each set to indicate if a devno is blacklisted or not */
 #define __BL_DEV_WORDS ((__MAX_SUBCHANNEL + (8*sizeof(long) - 1)) / \
 			 (8*sizeof(long)))
-static unsigned long bl_dev[__BL_DEV_WORDS];
+static unsigned long bl_dev[__MAX_SSID + 1][__BL_DEV_WORDS];
 typedef enum {add, free} range_action;
 
 /*
@@ -46,21 +46,23 @@ typedef enum {add, free} range_action;
  * (Un-)blacklist the devices from-to
  */
 static inline void
-blacklist_range (range_action action, unsigned int from, unsigned int to)
+blacklist_range (range_action action, unsigned int from, unsigned int to,
+		 unsigned int ssid)
 {
 	if (!to)
 		to = from;
 
-	if (from > to || to > __MAX_SUBCHANNEL) {
+	if (from > to || to > __MAX_SUBCHANNEL || ssid > __MAX_SSID) {
 		printk (KERN_WARNING "Invalid blacklist range "
-			"0x%04x to 0x%04x, skipping\n", from, to);
+			"0.%x.%04x to 0.%x.%04x, skipping\n",
+			ssid, from, ssid, to);
 		return;
 	}
 	for (; from <= to; from++) {
 		if (action == add)
-			set_bit (from, bl_dev);
+			set_bit (from, bl_dev[ssid]);
 		else
-			clear_bit (from, bl_dev);
+			clear_bit (from, bl_dev[ssid]);
 	}
 }
 
@@ -70,7 +72,7 @@ blacklist_range (range_action action, un
  * Shamelessly grabbed from dasd_devmap.c.
  */
 static inline int
-blacklist_busid(char **str, int *id0, int *id1, int *devno)
+blacklist_busid(char **str, int *id0, int *ssid, int *devno)
 {
 	int val, old_style;
 	char *sav;
@@ -87,7 +89,7 @@ blacklist_busid(char **str, int *id0, in
 		goto confused;
 	val = simple_strtoul(*str, str, 16);
 	if (old_style || (*str)[0] != '.') {
-		*id0 = *id1 = 0;
+		*id0 = *ssid = 0;
 		if (val < 0 || val > 0xffff)
 			goto confused;
 		*devno = val;
@@ -106,7 +108,7 @@ blacklist_busid(char **str, int *id0, in
 	val = simple_strtoul(*str, str, 16);
 	if (val < 0 || val > 0xff || (*str)++[0] != '.')
 		goto confused;
-	*id1 = val;
+	*ssid = val;
 	if (!isxdigit((*str)[0]))	/* We require at least one hex digit */
 		goto confused;
 	val = simple_strtoul(*str, str, 16);
@@ -126,7 +128,7 @@ confused:
 static inline int
 blacklist_parse_parameters (char *str, range_action action)
 {
-	unsigned int from, to, from_id0, to_id0, from_id1, to_id1;
+	unsigned int from, to, from_id0, to_id0, from_ssid, to_ssid;
 
 	while (*str != 0 && *str != '\n') {
 		range_action ra = action;
@@ -143,23 +145,25 @@ blacklist_parse_parameters (char *str, r
 		 */
 		if (strncmp(str,"all,",4) == 0 || strcmp(str,"all") == 0 ||
 		    strncmp(str,"all\n",4) == 0 || strncmp(str,"all ",4) == 0) {
-			from = 0;
-			to = __MAX_SUBCHANNEL;
+			int j;
+
 			str += 3;
+			for (j=0; j <= __MAX_SSID; j++)
+				blacklist_range(ra, 0, __MAX_SUBCHANNEL, j);
 		} else {
 			int rc;
 
 			rc = blacklist_busid(&str, &from_id0,
-					     &from_id1, &from);
+					     &from_ssid, &from);
 			if (rc)
 				continue;
 			to = from;
 			to_id0 = from_id0;
-			to_id1 = from_id1;
+			to_ssid = from_ssid;
 			if (*str == '-') {
 				str++;
 				rc = blacklist_busid(&str, &to_id0,
-						     &to_id1, &to);
+						     &to_ssid, &to);
 				if (rc)
 					continue;
 			}
@@ -169,18 +173,19 @@ blacklist_parse_parameters (char *str, r
 					strsep(&str, ",\n"));
 				continue;
 			}
-			if ((from_id0 != to_id0) || (from_id1 != to_id1)) {
+			if ((from_id0 != to_id0) ||
+			    (from_ssid != to_ssid)) {
 				printk(KERN_WARNING "invalid cio_ignore range "
 					"%x.%x.%04x-%x.%x.%04x\n",
-					from_id0, from_id1, from,
-					to_id0, to_id1, to);
+					from_id0, from_ssid, from,
+					to_id0, to_ssid, to);
 				continue;
 			}
+			pr_debug("blacklist_setup: adding range "
+				 "from %x.%x.%04x to %x.%x.%04x\n",
+				 from_id0, from_ssid, from, to_id0, to_ssid, to);
+			blacklist_range (ra, from, to, to_ssid);
 		}
-		/* FIXME: ignoring id0 and id1 here. */
-		pr_debug("blacklist_setup: adding range "
-			 "from 0.0.%04x to 0.0.%04x\n", from, to);
-		blacklist_range (ra, from, to);
 	}
 	return 1;
 }
@@ -214,9 +219,9 @@ __setup ("cio_ignore=", blacklist_setup)
  * Used by validate_subchannel()
  */
 int
-is_blacklisted (int devno)
+is_blacklisted (int ssid, int devno)
 {
-	return test_bit (devno, bl_dev);
+	return test_bit (devno, bl_dev[ssid]);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -283,6 +288,7 @@ blacklist_parse_proc_parameters (char *b
 /* Iterator struct for all devices. */
 struct ccwdev_iter {
 	int devno;
+	int ssid;
 	int in_range;
 };
 
@@ -291,13 +297,14 @@ cio_ignore_proc_seq_start(struct seq_fil
 {
 	struct ccwdev_iter *iter;
 
-	if (*offset > __MAX_SUBCHANNEL)
+	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
 		return NULL;
 	iter = kmalloc(sizeof(struct ccwdev_iter), GFP_KERNEL);
 	if (!iter)
 		return ERR_PTR(-ENOMEM);
 	memset(iter, 0, sizeof(struct ccwdev_iter));
-	iter->devno = *offset;
+	iter->ssid = *offset / (__MAX_SUBCHANNEL + 1);
+	iter->devno = *offset % (__MAX_SUBCHANNEL + 1);
 	return iter;
 }
 
@@ -313,10 +320,16 @@ cio_ignore_proc_seq_next(struct seq_file
 {
 	struct ccwdev_iter *iter;
 
-	if (*offset > __MAX_SUBCHANNEL)
+	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
 		return NULL;
 	iter = (struct ccwdev_iter *)it;
-	iter->devno++;
+	if (iter->devno == __MAX_SUBCHANNEL) {
+		iter->devno = 0;
+		iter->ssid++;
+		if (iter->ssid > __MAX_SSID)
+			return NULL;
+	} else
+		iter->devno++;
 	(*offset)++;
 	return iter;
 }
@@ -327,23 +340,24 @@ cio_ignore_proc_seq_show(struct seq_file
 	struct ccwdev_iter *iter;
 
 	iter = (struct ccwdev_iter *)it;
-	if (!is_blacklisted(iter->devno))
+	if (!is_blacklisted(iter->ssid, iter->devno))
 		/* Not blacklisted, nothing to output. */
 		return 0;
 	if (!iter->in_range) {
 		/* First device in range. */
 		if ((iter->devno == __MAX_SUBCHANNEL) ||
-		    !is_blacklisted(iter->devno + 1))
+		    !is_blacklisted(iter->ssid, iter->devno + 1))
 			/* Singular device. */
-			return seq_printf(s, "0.0.%04x\n", iter->devno);
+			return seq_printf(s, "0.%x.%04x\n",
+					  iter->ssid, iter->devno);
 		iter->in_range = 1;
-		return seq_printf(s, "0.0.%04x-", iter->devno);
+		return seq_printf(s, "0.%x.%04x-", iter->ssid, iter->devno);
 	}
 	if ((iter->devno == __MAX_SUBCHANNEL) ||
-	    !is_blacklisted(iter->devno + 1)) {
+	    !is_blacklisted(iter->ssid, iter->devno + 1)) {
 		/* Last device in range. */
 		iter->in_range = 0;
-		return seq_printf(s, "0.0.%04x\n", iter->devno);
+		return seq_printf(s, "0.%x.%04x\n", iter->ssid, iter->devno);
 	}
 	return 0;
 }
diff -urpN linux-2.6/drivers/s390/cio/blacklist.h linux-2.6-patched/drivers/s390/cio/blacklist.h
--- linux-2.6/drivers/s390/cio/blacklist.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/blacklist.h	2005-12-09 14:26:06.000000000 +0100
@@ -1,6 +1,6 @@
 #ifndef S390_BLACKLIST_H
 #define S390_BLACKLIST_H
 
-extern int is_blacklisted (int devno);
+extern int is_blacklisted (int ssid, int devno);
 
 #endif
diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2005-12-09 14:26:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2005-12-09 14:26:06.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/chsc.c
  *   S/390 common I/O routines -- channel subsystem call
- *   $Revision: 1.120 $
+ *   $Revision: 1.126 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -75,7 +75,9 @@ chsc_get_sch_desc_irq(struct subchannel 
 
 	struct {
 		struct chsc_header request;
-		u16 reserved1;
+		u16 reserved1a:10;
+		u16 ssid:2;
+		u16 reserved1b:4;
 		u16 f_sch;	  /* first subchannel */
 		u16 reserved2;
 		u16 l_sch;	  /* last subchannel */
@@ -102,6 +104,7 @@ chsc_get_sch_desc_irq(struct subchannel 
 		.code   = 0x0004,
 	};
 
+	ssd_area->ssid = sch->schid.ssid;
 	ssd_area->f_sch = sch->schid.sch_no;
 	ssd_area->l_sch = sch->schid.sch_no;
 
@@ -145,8 +148,8 @@ chsc_get_sch_desc_irq(struct subchannel 
 	 */
 	if (ssd_area->st > 3) { /* uhm, that looks strange... */
 		CIO_CRW_EVENT(0, "Strange subchannel type %d"
-			      " for sch %04x\n", ssd_area->st,
-			      sch->schid.sch_no);
+			      " for sch 0.%x.%04x\n", ssd_area->st,
+			      sch->schid.ssid, sch->schid.sch_no);
 		/*
 		 * There may have been a new subchannel type defined in the
 		 * time since this code was written; since we don't know which
@@ -155,8 +158,9 @@ chsc_get_sch_desc_irq(struct subchannel 
 		return 0;
 	} else {
 		const char *type[4] = {"I/O", "chsc", "message", "ADM"};
-		CIO_CRW_EVENT(6, "ssd: sch %04x is %s subchannel\n",
-			      sch->schid.sch_no, type[ssd_area->st]);
+		CIO_CRW_EVENT(6, "ssd: sch 0.%x.%04x is %s subchannel\n",
+			      sch->schid.ssid, sch->schid.sch_no,
+			      type[ssd_area->st]);
 
 		sch->ssd_info.valid = 1;
 		sch->ssd_info.type = ssd_area->st;
@@ -364,7 +368,7 @@ s390_process_res_acc_new_sch(struct subc
 	 * that beast may be on we'll have to do a stsch
 	 * on all devices, grr...
 	 */
-	if (stsch(schid, &schib))
+	if (stsch_err(schid, &schib))
 		/* We're through */
 		return need_rescan ? -EAGAIN : -ENXIO;
 
@@ -818,7 +822,7 @@ __s390_vary_chpid_on(struct subchannel_i
 		put_device(&sch->dev);
 		return 0;
 	}
-	if (stsch(schid, &schib))
+	if (stsch_err(schid, &schib))
 		/* We're through */
 		return -ENXIO;
 	/* Put it on the slow path. */
@@ -1078,6 +1082,54 @@ chsc_alloc_sei_area(void)
 	return (sei_page ? 0 : -ENOMEM);
 }
 
+int __init
+chsc_enable_facility(int operation_code)
+{
+	int ret;
+	struct {
+		struct chsc_header request;
+		u8 reserved1:4;
+		u8 format:4;
+		u8 reserved2;
+		u16 operation_code;
+		u32 reserved3;
+		u32 reserved4;
+		u32 operation_data_area[252];
+		struct chsc_header response;
+		u32 reserved5:4;
+		u32 format2:4;
+		u32 reserved6:24;
+	} *sda_area;
+
+	sda_area = (void *)get_zeroed_page(GFP_KERNEL|GFP_DMA);
+	if (!sda_area)
+		return -ENOMEM;
+	sda_area->request = (struct chsc_header) {
+		.length = 0x0400,
+		.code = 0x0031,
+	};
+	sda_area->operation_code = operation_code;
+
+	ret = chsc(sda_area);
+	if (ret > 0) {
+		ret = (ret == 3) ? -ENODEV : -EBUSY;
+		goto out;
+	}
+	switch (sda_area->response.code) {
+	case 0x0003: /* invalid request block */
+	case 0x0007:
+		ret = -EINVAL;
+		break;
+	case 0x0004: /* command not provided */
+	case 0x0101: /* facility not provided */
+		ret = -EOPNOTSUPP;
+		break;
+	}
+ out:
+	free_page((unsigned long)sda_area);
+	return ret;
+}
+
 subsys_initcall(chsc_alloc_sei_area);
 
 struct css_general_char css_general_characteristics;
diff -urpN linux-2.6/drivers/s390/cio/chsc.h linux-2.6-patched/drivers/s390/cio/chsc.h
--- linux-2.6/drivers/s390/cio/chsc.h	2005-12-09 14:26:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.h	2005-12-09 14:26:06.000000000 +0100
@@ -5,6 +5,8 @@
 #define CHSC_SEI_ACC_LINKADDR     2
 #define CHSC_SEI_ACC_FULLLINKADDR 3
 
+#define CHSC_SDA_OC_MSS   0x2
+
 struct chsc_header {
 	u16 length;
 	u16 code;
@@ -64,6 +66,8 @@ extern int css_characteristics_avail;
 
 extern void *chsc_get_chp_desc(struct subchannel*, int);
 
+extern int chsc_enable_facility(int);
+
 #define to_channelpath(dev) container_of(dev, struct channel_path, dev)
 
 #endif
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2005-12-09 14:26:02.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2005-12-09 14:26:06.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.135 $
+ *   $Revision: 1.138 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -166,7 +166,8 @@ cio_start_handle_notoper(struct subchann
 	stsch (sch->schid, &sch->schib);
 
 	CIO_MSG_EVENT(0, "cio_start: 'not oper' status for "
-		      "subchannel %04x!\n", sch->schid.sch_no);
+		      "subchannel 0.%x.%04x!\n", sch->schid.ssid,
+		      sch->schid.sch_no);
 	sprintf(dbf_text, "no%s", sch->dev.bus_id);
 	CIO_TRACE_EVENT(0, dbf_text);
 	CIO_HEX_EVENT(0, &sch->schib, sizeof (struct schib));
@@ -522,15 +523,18 @@ cio_validate_subchannel (struct subchann
 	spin_lock_init(&sch->lock);
 
 	/* Set a name for the subchannel */
-	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.0.%04x", schid.sch_no);
+	snprintf (sch->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x", schid.ssid,
+		  schid.sch_no);
 
 	/*
 	 * The first subchannel that is not-operational (ccode==3)
 	 *  indicates that there aren't any more devices available.
+	 * If stsch gets an exception, it means the current subchannel set
+	 *  is not valid.
 	 */
-	ccode = stsch (schid, &sch->schib);
+	ccode = stsch_err (schid, &sch->schib);
 	if (ccode)
-		return -ENXIO;
+		return (ccode == 3) ? -ENXIO : ccode;
 
 	sch->schid = schid;
 	/* Copy subchannel type from path management control word. */
@@ -541,9 +545,9 @@ cio_validate_subchannel (struct subchann
 	 */
 	if (sch->st != 0) {
 		CIO_DEBUG(KERN_INFO, 0,
-			  "Subchannel %04X reports "
+			  "Subchannel 0.%x.%04x reports "
 			  "non-I/O subchannel type %04X\n",
-			  sch->schid.sch_no, sch->st);
+			  sch->schid.ssid, sch->schid.sch_no, sch->st);
 		/* We stop here for non-io subchannels. */
 		return sch->st;
 	}
@@ -554,26 +558,29 @@ cio_validate_subchannel (struct subchann
 		return -ENODEV;
 
 	/* Devno is valid. */
-	if (is_blacklisted (sch->schib.pmcw.dev)) {
+	if (is_blacklisted (sch->schid.ssid, sch->schib.pmcw.dev)) {
 		/*
 		 * This device must not be known to Linux. So we simply
 		 * say that there is no device and return ENODEV.
 		 */
 		CIO_MSG_EVENT(0, "Blacklisted device detected "
-			      "at devno %04X\n", sch->schib.pmcw.dev);
+			      "at devno %04X, subchannel set %x\n",
+			      sch->schib.pmcw.dev, sch->schid.ssid);
 		return -ENODEV;
 	}
 	sch->opm = 0xff;
-	chsc_validate_chpids(sch);
+	if (!cio_is_console(sch->schid))
+		chsc_validate_chpids(sch);
 	sch->lpm = sch->schib.pmcw.pim &
 		sch->schib.pmcw.pam &
 		sch->schib.pmcw.pom &
 		sch->opm;
 
 	CIO_DEBUG(KERN_INFO, 0,
-		  "Detected device %04X on subchannel %04X"
+		  "Detected device %04x on subchannel 0.%x.%04X"
 		  " - PIM = %02X, PAM = %02X, POM = %02X\n",
-		  sch->schib.pmcw.dev, sch->schid.sch_no, sch->schib.pmcw.pim,
+		  sch->schib.pmcw.dev, sch->schid.ssid,
+		  sch->schid.sch_no, sch->schib.pmcw.pim,
 		  sch->schib.pmcw.pam, sch->schib.pmcw.pom);
 
 	/*
@@ -693,7 +700,7 @@ wait_cons_dev (void)
 static int
 cio_test_for_console(struct subchannel_id schid, void *data)
 {
-	if (stsch(schid, &console_subchannel.schib) != 0)
+	if (stsch_err(schid, &console_subchannel.schib) != 0)
 		return -ENXIO;
 	if (console_subchannel.schib.pmcw.dnv &&
 	    console_subchannel.schib.pmcw.dev ==
@@ -841,7 +848,7 @@ __shutdown_subchannel_easy(struct subcha
 {
 	struct schib schib;
 
-	if (stsch(schid, &schib))
+	if (stsch_err(schid, &schib))
 		return -ENXIO;
 	if (!schib.pmcw.ena)
 		return 0;
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2005-12-09 14:26:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2005-12-09 14:26:06.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.85 $
+ *   $Revision: 1.93 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -23,6 +23,7 @@
 
 int need_rescan = 0;
 int css_init_done = 0;
+static int max_ssid = 0;
 
 struct channel_subsystem *css[__MAX_CSSID + 1];
 
@@ -37,10 +38,13 @@ for_each_subchannel(int(*fn)(struct subc
 	init_subchannel_id(&schid);
 	ret = -ENODEV;
 	do {
-		ret = fn(schid, data);
-		if (ret)
-			break;
-	} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+		do {
+			ret = fn(schid, data);
+			if (ret)
+				break;
+		} while (schid.sch_no++ < __MAX_SUBCHANNEL);
+		schid.sch_no = 0;
+	} while (schid.ssid++ < max_ssid);
 	return ret;
 }
 
@@ -205,8 +209,8 @@ css_evaluate_subchannel(struct subchanne
 		return -EAGAIN; /* Will be done on the slow path. */
 	}
 	event = css_get_subchannel_status(sch, schid);
-	CIO_MSG_EVENT(4, "Evaluating schid %04x, event %d, %s, %s path.\n",
-		      schid.sch_no, event,
+	CIO_MSG_EVENT(4, "Evaluating schid 0.%x.%04x, event %d, %s, %s path.\n",
+		      schid.ssid, schid.sch_no, event,
 		      sch?(disc?"disconnected":"normal"):"unknown",
 		      slow?"slow":"fast");
 	switch (event) {
@@ -352,19 +356,23 @@ css_reiterate_subchannels(void)
  * Called from the machine check handler for subchannel report words.
  */
 int
-css_process_crw(int irq)
+css_process_crw(int rsid1, int rsid2)
 {
 	int ret;
 	struct subchannel_id mchk_schid;
 
-	CIO_CRW_EVENT(2, "source is subchannel %04X\n", irq);
+	CIO_CRW_EVENT(2, "source is subchannel %04X, subsystem id %x\n",
+		      rsid1, rsid2);
 
 	if (need_rescan)
 		/* We need to iterate all subchannels anyway. */
 		return -EAGAIN;
 
 	init_subchannel_id(&mchk_schid);
-	mchk_schid.sch_no = irq;
+	mchk_schid.sch_no = rsid1;
+	if (rsid2 != 0)
+		mchk_schid.ssid = (rsid2 >> 8) & 3;
+
 	/* 
 	 * Since we are always presented with IPI in the CRW, we have to
 	 * use stsch() to find out if the subchannel in question has come
@@ -465,12 +473,23 @@ init_channel_subsystem (void)
 	if ((ret = bus_register(&css_bus_type)))
 		goto out;
 
+	/* Try to enable MSS. */
+	ret = chsc_enable_facility(CHSC_SDA_OC_MSS);
+	switch (ret) {
+	case 0: /* Success. */
+		max_ssid = __MAX_SSID;
+		break;
+	case -ENOMEM:
+		goto out_bus;
+	default:
+		max_ssid = 0;
+	}
 	/* Setup css structure. */
 	for (i = 0; i <= __MAX_CSSID; i++) {
 		css[i] = kmalloc(sizeof(struct channel_subsystem), GFP_KERNEL);
 		if (!css[i]) {
 			ret = -ENOMEM;
-			goto out_bus;
+			goto out_unregister;
 		}
 		setup_css(i);
 		ret = device_register(&css[i]->device);
@@ -485,11 +504,12 @@ init_channel_subsystem (void)
 	return 0;
 out_free:
 	kfree(css[i]);
-out_bus:
+out_unregister:
 	while (i > 0) {
 		i--;
 		device_unregister(&css[i]->device);
 	}
+out_bus:
 	bus_unregister(&css_bus_type);
 out:
 	return ret;
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2005-12-09 14:26:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2005-12-09 14:26:06.000000000 +0100
@@ -77,6 +77,7 @@ struct ccw_device_private {
 	unsigned long registered;
 	__u16 devno;		/* device number */
 	__u16 sch_no;		/* subchannel number */
+	__u8 ssid;              /* subchannel set id */
 	__u8 imask;		/* lpm mask for SNID/SID/SPGID */
 	int iretry;		/* retry counter SNID/SID/SPGID */
 	struct {
@@ -135,6 +136,7 @@ extern int css_init_done;
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
 
 #define __MAX_SUBCHANNEL 65535
+#define __MAX_SSID 3
 #define __MAX_CHPID 255
 #define __MAX_CSSID 0
 
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2005-12-09 14:26:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2005-12-09 14:26:06.000000000 +0100
@@ -535,7 +535,8 @@ ccw_device_register(struct ccw_device *c
 }
 
 struct match_data {
-	unsigned int  devno;
+	unsigned int devno;
+	unsigned int ssid;
 	struct ccw_device * sibling;
 };
 
@@ -548,6 +549,7 @@ match_devno(struct device * dev, void * 
 	cdev = to_ccwdev(dev);
 	if ((cdev->private->state == DEV_STATE_DISCONNECTED) &&
 	    (cdev->private->devno == d->devno) &&
+	    (cdev->private->ssid == d->ssid) &&
 	    (cdev != d->sibling)) {
 		cdev->private->state = DEV_STATE_NOT_OPER;
 		return 1;
@@ -556,11 +558,13 @@ match_devno(struct device * dev, void * 
 }
 
 static struct ccw_device *
-get_disc_ccwdev_by_devno(unsigned int devno, struct ccw_device *sibling)
+get_disc_ccwdev_by_devno(unsigned int devno, unsigned int ssid,
+			 struct ccw_device *sibling)
 {
 	struct device *dev;
 	struct match_data data = {
-		.devno  = devno,
+		.devno   = devno,
+		.ssid    = ssid,
 		.sibling = sibling,
 	};
 
@@ -616,7 +620,7 @@ ccw_device_do_unreg_rereg(void *data)
 
 		need_rename = 1;
 		other_cdev = get_disc_ccwdev_by_devno(sch->schib.pmcw.dev,
-						      cdev);
+						      sch->schid.ssid, cdev);
 		if (other_cdev) {
 			struct subchannel *other_sch;
 
@@ -639,8 +643,8 @@ ccw_device_do_unreg_rereg(void *data)
 	if (test_and_clear_bit(1, &cdev->private->registered))
 		device_del(&cdev->dev);
 	if (need_rename)
-		snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.0.%04x",
-			  sch->schib.pmcw.dev);
+		snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x",
+			  sch->schid.ssid, sch->schib.pmcw.dev);
 	PREPARE_WORK(&cdev->private->kick_work,
 		     ccw_device_add_changed, (void *)cdev);
 	queue_work(ccw_device_work, &cdev->private->kick_work);
@@ -769,9 +773,11 @@ io_subchannel_recog(struct ccw_device *c
 	sch->dev.driver_data = cdev;
 	sch->driver = &io_subchannel_driver;
 	cdev->ccwlock = &sch->lock;
+
 	/* Init private data. */
 	priv = cdev->private;
 	priv->devno = sch->schib.pmcw.dev;
+	priv->ssid = sch->schid.ssid;
 	priv->sch_no = sch->schid.sch_no;
 	priv->state = DEV_STATE_NOT_OPER;
 	INIT_LIST_HEAD(&priv->cmb_list);
@@ -779,8 +785,8 @@ io_subchannel_recog(struct ccw_device *c
 	init_timer(&priv->timer);
 
 	/* Set an initial name for the device. */
-	snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.0.%04x",
-		  sch->schib.pmcw.dev);
+	snprintf (cdev->dev.bus_id, BUS_ID_SIZE, "0.%x.%04x",
+		  sch->schid.ssid, sch->schib.pmcw.dev);
 
 	/* Increase counter of devices currently in recognition. */
 	atomic_inc(&ccw_device_init_count);
diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2005-12-09 14:26:06.000000000 +0100
@@ -257,8 +257,9 @@ ccw_device_recog_done(struct ccw_device 
 	switch (state) {
 	case DEV_STATE_NOT_OPER:
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "SenseID : unknown device %04x on subchannel %04x\n",
-			  cdev->private->devno, sch->schid.sch_no);
+			  "SenseID : unknown device %04x on subchannel "
+			  "0.%x.%04x\n", cdev->private->devno,
+			  sch->schid.ssid, sch->schid.sch_no);
 		break;
 	case DEV_STATE_OFFLINE:
 		if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID) {
@@ -282,16 +283,18 @@ ccw_device_recog_done(struct ccw_device 
 			return;
 		}
 		/* Issue device info message. */
-		CIO_DEBUG(KERN_INFO, 2, "SenseID : device %04x reports: "
+		CIO_DEBUG(KERN_INFO, 2, "SenseID : device 0.%x.%04x reports: "
 			  "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
-			  "%04X/%02X\n", cdev->private->devno,
+			  "%04X/%02X\n",
+			  cdev->private->ssid, cdev->private->devno,
 			  cdev->id.cu_type, cdev->id.cu_model,
 			  cdev->id.dev_type, cdev->id.dev_model);
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "SenseID : boxed device %04x on subchannel %04x\n",
-			  cdev->private->devno, sch->schid.sch_no);
+			  "SenseID : boxed device %04x on subchannel "
+			  "0.%x.%04x\n", cdev->private->devno,
+			  sch->schid.ssid, sch->schid.sch_no);
 		break;
 	}
 	cdev->private->state = state;
diff -urpN linux-2.6/drivers/s390/cio/device_id.c linux-2.6-patched/drivers/s390/cio/device_id.c
--- linux-2.6/drivers/s390/cio/device_id.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_id.c	2005-12-09 14:26:06.000000000 +0100
@@ -256,16 +256,17 @@ ccw_device_check_sense_id(struct ccw_dev
 		 *     sense id information. So, for intervention required,
 		 *     we use the "whack it until it talks" strategy...
 		 */
-		CIO_MSG_EVENT(2, "SenseID : device %04x on Subchannel %04x "
-			      "reports cmd reject\n",
-			      cdev->private->devno, sch->schid.sch_no);
+		CIO_MSG_EVENT(2, "SenseID : device %04x on Subchannel "
+			      "0.%x.%04x reports cmd reject\n",
+			      cdev->private->devno, sch->schid.ssid,
+			      sch->schid.sch_no);
 		return -EOPNOTSUPP;
 	}
 	if (irb->esw.esw0.erw.cons) {
-		CIO_MSG_EVENT(2, "SenseID : UC on dev %04x, "
+		CIO_MSG_EVENT(2, "SenseID : UC on dev 0.%x.%04x, "
 			      "lpum %02X, cnt %02d, sns :"
 			      " %02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->devno,
+			      cdev->private->ssid, cdev->private->devno,
 			      irb->esw.esw0.sublog.lpum,
 			      irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
@@ -277,16 +278,17 @@ ccw_device_check_sense_id(struct ccw_dev
 	if (irb->scsw.cc == 3) {
 		if ((sch->orb.lpm &
 		     sch->schib.pmcw.pim & sch->schib.pmcw.pam) != 0)
-			CIO_MSG_EVENT(2, "SenseID : path %02X for device %04x on"
-				      " subchannel %04x is 'not operational'\n",
-				      sch->orb.lpm, cdev->private->devno,
+			CIO_MSG_EVENT(2, "SenseID : path %02X for device %04x "
+				      "on subchannel 0.%x.%04x is "
+				      "'not operational'\n", sch->orb.lpm,
+				      cdev->private->devno, sch->schid.ssid,
 				      sch->schid.sch_no);
 		return -EACCES;
 	}
 	/* Hmm, whatever happened, try again. */
 	CIO_MSG_EVENT(2, "SenseID : start_IO() for device %04x on "
-		      "subchannel %04x returns status %02X%02X\n",
-		      cdev->private->devno, sch->schid.sch_no,
+		      "subchannel 0.%x.%04x returns status %02X%02X\n",
+		      cdev->private->devno, sch->schid.ssid, sch->schid.sch_no,
 		      irb->scsw.dstat, irb->scsw.cstat);
 	return -EAGAIN;
 }
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2005-12-09 14:26:04.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2005-12-09 14:26:06.000000000 +0100
@@ -57,10 +57,10 @@ __ccw_device_sense_pgid_start(struct ccw
 			if (ret != -EACCES)
 				return ret;
 			CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel "
-				      "%04x, lpm %02X, became 'not "
+				      "0.%x.%04x, lpm %02X, became 'not "
 				      "operational'\n",
-				      cdev->private->devno, sch->schid.sch_no,
-				      cdev->private->imask);
+				      cdev->private->devno, sch->schid.ssid,
+				      sch->schid.sch_no, cdev->private->imask);
 
 		}
 		cdev->private->imask >>= 1;
@@ -106,10 +106,10 @@ __ccw_device_check_sense_pgid(struct ccw
 		return -EOPNOTSUPP;
 	}
 	if (irb->esw.esw0.erw.cons) {
-		CIO_MSG_EVENT(2, "SNID - device %04x, unit check, "
+		CIO_MSG_EVENT(2, "SNID - device 0.%x.%04x, unit check, "
 			      "lpum %02X, cnt %02d, sns : "
 			      "%02X%02X%02X%02X %02X%02X%02X%02X ...\n",
-			      cdev->private->devno,
+			      cdev->private->ssid, cdev->private->devno,
 			      irb->esw.esw0.sublog.lpum,
 			      irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
@@ -119,16 +119,17 @@ __ccw_device_check_sense_pgid(struct ccw
 		return -EAGAIN;
 	}
 	if (irb->scsw.cc == 3) {
-		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel "
-			      "%04x, lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->schid.sch_no,
-			      sch->orb.lpm);
+		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x,"
+			      " lpm %02X, became 'not operational'\n",
+			      cdev->private->devno, sch->schid.ssid,
+			      sch->schid.sch_no, sch->orb.lpm);
 		return -EACCES;
 	}
 	if (cdev->private->pgid.inf.ps.state2 == SNID_STATE2_RESVD_ELSE) {
-		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel %04x "
+		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x "
 			      "is reserved by someone else\n",
-			      cdev->private->devno, sch->schid.sch_no);
+			      cdev->private->devno, sch->schid.ssid,
+			      sch->schid.sch_no);
 		return -EUSERS;
 	}
 	return 0;
@@ -237,8 +238,9 @@ __ccw_device_do_pgid(struct ccw_device *
 	sch->lpm &= ~cdev->private->imask;
 	sch->vpm &= ~cdev->private->imask;
 	CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel "
-		      "%04x, lpm %02X, became 'not operational'\n",
-		      cdev->private->devno, sch->schid.sch_no, cdev->private->imask);
+		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
+		      cdev->private->devno, sch->schid.ssid,
+		      sch->schid.sch_no, cdev->private->imask);
 	return ret;
 }
 
@@ -260,8 +262,10 @@ __ccw_device_check_pgid(struct ccw_devic
 		if (irb->ecw[0] & SNS0_CMD_REJECT)
 			return -EOPNOTSUPP;
 		/* Hmm, whatever happened, try again. */
-		CIO_MSG_EVENT(2, "SPID - device %04x, unit check, cnt %02d, "
+		CIO_MSG_EVENT(2, "SPID - device 0.%x.%04x, unit check, "
+			      "cnt %02d, "
 			      "sns : %02X%02X%02X%02X %02X%02X%02X%02X ...\n",
+			      cdev->private->ssid,
 			      cdev->private->devno, irb->esw.esw0.erw.scnt,
 			      irb->ecw[0], irb->ecw[1],
 			      irb->ecw[2], irb->ecw[3],
@@ -270,10 +274,10 @@ __ccw_device_check_pgid(struct ccw_devic
 		return -EAGAIN;
 	}
 	if (irb->scsw.cc == 3) {
-		CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel "
-			      "%04x, lpm %02X, became 'not operational'\n",
-			      cdev->private->devno, sch->schid.sch_no,
-			      cdev->private->imask);
+		CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel 0.%x.%04x,"
+			      " lpm %02X, became 'not operational'\n",
+			      cdev->private->devno, sch->schid.ssid,
+			      sch->schid.sch_no, cdev->private->imask);
 		return -EACCES;
 	}
 	return 0;
diff -urpN linux-2.6/drivers/s390/cio/device_status.c linux-2.6-patched/drivers/s390/cio/device_status.c
--- linux-2.6/drivers/s390/cio/device_status.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_status.c	2005-12-09 14:26:06.000000000 +0100
@@ -36,9 +36,10 @@ ccw_device_msg_control_check(struct ccw_
 		
 	CIO_MSG_EVENT(0, "Channel-Check or Interface-Control-Check "
 		      "received"
-		      " ... device %04X on subchannel %04X, dev_stat "
+		      " ... device %04x on subchannel 0.%x.%04x, dev_stat "
 		      ": %02X sch_stat : %02X\n",
-		      cdev->private->devno, cdev->private->sch_no,
+		      cdev->private->devno, cdev->private->ssid,
+		      cdev->private->sch_no,
 		      irb->scsw.dstat, irb->scsw.cstat);
 
 	if (irb->scsw.cc != 3) {
@@ -61,8 +62,9 @@ ccw_device_path_notoper(struct ccw_devic
 	sch = to_subchannel(cdev->dev.parent);
 	stsch (sch->schid, &sch->schib);
 
-	CIO_MSG_EVENT(0, "%s(%04x) - path(s) %02x are "
-		      "not operational \n", __FUNCTION__, sch->schid.sch_no,
+	CIO_MSG_EVENT(0, "%s(0.%x.%04x) - path(s) %02x are "
+		      "not operational \n", __FUNCTION__,
+		      sch->schid.ssid, sch->schid.sch_no,
 		      sch->schib.pmcw.pnom);
 
 	sch->lpm &= ~sch->schib.pmcw.pnom;
diff -urpN linux-2.6/drivers/s390/cio/ioasm.h linux-2.6-patched/drivers/s390/cio/ioasm.h
--- linux-2.6/drivers/s390/cio/ioasm.h	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/ioasm.h	2005-12-09 14:26:06.000000000 +0100
@@ -38,6 +38,35 @@ static inline int stsch(struct subchanne
 	return ccode;
 }
 
+static inline int stsch_err(struct subchannel_id schid,
+				volatile struct schib *addr)
+{
+	int ccode;
+
+	__asm__ __volatile__(
+		"    lhi  %0,%3\n"
+		"    lr	  1,%1\n"
+		"    stsch 0(%2)\n"
+		"0:  ipm  %0\n"
+		"    srl  %0,28\n"
+		"1:\n"
+#ifdef CONFIG_ARCH_S390X
+		".section __ex_table,\"a\"\n"
+		"   .align 8\n"
+		"   .quad 0b,1b\n"
+		".previous"
+#else
+		".section __ex_table,\"a\"\n"
+		"   .align 4\n"
+		"   .long 0b,1b\n"
+		".previous"
+#endif
+		: "=&d" (ccode)
+		: "d" (schid), "a" (addr), "K" (-EIO), "m" (*addr)
+		: "cc", "1" );
+	return ccode;
+}
+
 static inline int msch(struct subchannel_id schid,
 			   volatile struct schib *addr)
 {
diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2005-12-09 14:26:06.000000000 +0100
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.113 $"
+#define VERSION_QDIO_C "$Revision: 1.114 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -2066,21 +2066,22 @@ qdio_timeout_handler(struct ccw_device *
 
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_INACTIVE:
-		QDIO_PRINT_ERR("establish queues on irq %04x: timed out\n",
-			       irq_ptr->schid.sch_no);
+		QDIO_PRINT_ERR("establish queues on irq 0.%x.%04x: timed out\n",
+			       irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 		QDIO_DBF_TEXT2(1,setup,"eq:timeo");
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		break;
 	case QDIO_IRQ_STATE_CLEANUP:
-		QDIO_PRINT_INFO("Did not get interrupt on cleanup, irq=0x%x.\n",
-				irq_ptr->schid.sch_no);
+		QDIO_PRINT_INFO("Did not get interrupt on cleanup, "
+				"irq=0.%x.%x.\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		break;
 	case QDIO_IRQ_STATE_ESTABLISHED:
 	case QDIO_IRQ_STATE_ACTIVE:
 		/* I/O has been terminated by common I/O layer. */
-		QDIO_PRINT_INFO("Queues on irq %04x killed by cio.\n",
-				irq_ptr->schid.sch_no);
+		QDIO_PRINT_INFO("Queues on irq 0.%x.%04x killed by cio.\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 		QDIO_DBF_TEXT2(1, trace, "cio:term");
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
 		if (get_device(&cdev->dev)) {
@@ -2273,7 +2274,9 @@ qdio_get_ssqd_information(struct qdio_ir
 	unsigned char qdioac;
 	struct {
 		struct chsc_header request;
-		u16 reserved1;
+		u16 reserved1:10;
+		u16 ssid:2;
+		u16 fmt:4;
 		u16 first_sch;
 		u16 reserved2;
 		u16 last_sch;
@@ -2318,12 +2321,13 @@ qdio_get_ssqd_information(struct qdio_ir
 	};
 	ssqd_area->first_sch = irq_ptr->schid.sch_no;
 	ssqd_area->last_sch = irq_ptr->schid.sch_no;
+	ssqd_area->ssid = irq_ptr->schid.ssid;
 	result = chsc(ssqd_area);
 
 	if (result) {
 		QDIO_PRINT_WARN("CHSC returned cc %i. Using all " \
-				"SIGAs for sch x%x.\n",
-				result, irq_ptr->schid.sch_no);
+				"SIGAs for sch 0.%x.%x.\n", result,
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
@@ -2333,8 +2337,9 @@ qdio_get_ssqd_information(struct qdio_ir
 
 	if (ssqd_area->response.code != QDIO_CHSC_RESPONSE_CODE_OK) {
 		QDIO_PRINT_WARN("response upon checking SIGA needs " \
-				"is 0x%x. Using all SIGAs for sch x%x.\n",
-				ssqd_area->response.code, irq_ptr->schid.sch_no);
+				"is 0x%x. Using all SIGAs for sch 0.%x.%x.\n",
+				ssqd_area->response.code,
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY ||
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* all flags set */
@@ -2344,8 +2349,9 @@ qdio_get_ssqd_information(struct qdio_ir
 	if (!(ssqd_area->flags & CHSC_FLAG_QDIO_CAPABILITY) ||
 	    !(ssqd_area->flags & CHSC_FLAG_VALIDITY) ||
 	    (ssqd_area->sch != irq_ptr->schid.sch_no)) {
-		QDIO_PRINT_WARN("huh? problems checking out sch x%x... " \
-				"using all SIGAs.\n",irq_ptr->schid.sch_no);
+		QDIO_PRINT_WARN("huh? problems checking out sch 0.%x.%x... " \
+				"using all SIGAs.\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 		qdioac = CHSC_FLAG_SIGA_INPUT_NECESSARY |
 			CHSC_FLAG_SIGA_OUTPUT_NECESSARY |
 			CHSC_FLAG_SIGA_SYNC_NECESSARY; /* worst case */
@@ -2453,7 +2459,8 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 	scssc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scssc_area) {
 		QDIO_PRINT_WARN("No memory for setting indicators on " \
-				"subchannel x%x.\n", irq_ptr->schid.sch_no);
+				"subchannel 0.%x.%x.\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 		return -ENOMEM;
 	}
 	scssc_area->request = (struct chsc_header) {
@@ -2479,8 +2486,9 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 
 	result = chsc(scssc_area);
 	if (result) {
-		QDIO_PRINT_WARN("could not set indicators on irq x%x, " \
-				"cc=%i.\n",irq_ptr->schid.sch_no,result);
+		QDIO_PRINT_WARN("could not set indicators on irq 0.%x.%x, " \
+				"cc=%i.\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no,result);
 		result = -EIO;
 		goto out;
 	}
@@ -2536,7 +2544,8 @@ tiqdio_set_delay_target(struct qdio_irq 
 	scsscf_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scsscf_area) {
 		QDIO_PRINT_WARN("No memory for setting delay target on " \
-				"subchannel x%x.\n", irq_ptr->schid.sch_no);
+				"subchannel 0.%x.%x.\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 		return -ENOMEM;
 	}
 	scsscf_area->request = (struct chsc_header) {
@@ -2548,8 +2557,9 @@ tiqdio_set_delay_target(struct qdio_irq 
 
 	result=chsc(scsscf_area);
 	if (result) {
-		QDIO_PRINT_WARN("could not set delay target on irq x%x, " \
-				"cc=%i. Continuing.\n",irq_ptr->schid.sch_no,
+		QDIO_PRINT_WARN("could not set delay target on irq 0.%x.%x, " \
+				"cc=%i. Continuing.\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no,
 				result);
 		result = -EIO;
 		goto out;
@@ -2870,8 +2880,9 @@ qdio_establish_irq_check_for_errors(stru
 		QDIO_DBF_HEX2(0,trace,&dstat,sizeof(int));
 		QDIO_DBF_HEX2(0,trace,&cstat,sizeof(int));
 		QDIO_PRINT_ERR("received check condition on establish " \
-			       "queues on irq 0x%x (cs=x%x, ds=x%x).\n",
-			       irq_ptr->schid.sch_no,cstat,dstat);
+			       "queues on irq 0.%x.%x (cs=x%x, ds=x%x).\n",
+			       irq_ptr->schid.ssid, irq_ptr->schid.sch_no,
+			       cstat,dstat);
 		qdio_set_state(irq_ptr,QDIO_IRQ_STATE_ERR);
 	}
 	
@@ -2879,9 +2890,10 @@ qdio_establish_irq_check_for_errors(stru
 		QDIO_DBF_TEXT2(1,setup,"eq:no de");
 		QDIO_DBF_HEX2(0,setup,&dstat, sizeof(dstat));
 		QDIO_DBF_HEX2(0,setup,&cstat, sizeof(cstat));
-		QDIO_PRINT_ERR("establish queues on irq %04x: didn't get "
+		QDIO_PRINT_ERR("establish queues on irq 0.%x.%04x: didn't get "
 			       "device end: dstat=%02x, cstat=%02x\n",
-			       irq_ptr->schid.sch_no, dstat, cstat);
+			       irq_ptr->schid.ssid, irq_ptr->schid.sch_no,
+			       dstat, cstat);
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		return 1;
 	}
@@ -2890,9 +2902,9 @@ qdio_establish_irq_check_for_errors(stru
 		QDIO_DBF_TEXT2(1,setup,"eq:badio");
 		QDIO_DBF_HEX2(0,setup,&dstat, sizeof(dstat));
 		QDIO_DBF_HEX2(0,setup,&cstat, sizeof(cstat));
-		QDIO_PRINT_ERR("establish queues on irq %04x: got "
+		QDIO_PRINT_ERR("establish queues on irq 0.%x.%04x: got "
 			       "the following devstat: dstat=%02x, "
-			       "cstat=%02x\n",
+			       "cstat=%02x\n", irq_ptr->schid.ssid,
 			       irq_ptr->schid.sch_no, dstat, cstat);
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
 		return 1;
@@ -3041,7 +3053,8 @@ int qdio_fill_irq(struct qdio_initialize
 		QDIO_DBF_HEX1(0,setup,&irq_ptr->dev_st_chg_ind,sizeof(void*));
 		if (!irq_ptr->dev_st_chg_ind) {
 			QDIO_PRINT_WARN("no indicator location available " \
-					"for irq 0x%x\n",irq_ptr->schid.sch_no);
+					"for irq 0.%x.%x\n",
+					irq_ptr->schid.ssid, irq_ptr->schid.sch_no);
 			qdio_release_irq_memory(irq_ptr);
 			return -ENOBUFS;
 		}
@@ -3198,9 +3211,10 @@ qdio_establish(struct qdio_initialize *i
 			sprintf(dbf_text,"eq:io%4x",result);
 			QDIO_DBF_TEXT2(1,setup,dbf_text);
 		}
-		QDIO_PRINT_WARN("establish queues on irq %04x: do_IO " \
-                           "returned %i, next try returned %i\n",
-                           irq_ptr->schid.sch_no,result,result2);
+		QDIO_PRINT_WARN("establish queues on irq 0.%x.%04x: do_IO " \
+				"returned %i, next try returned %i\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no,
+				result, result2);
 		result=result2;
 		if (result)
 			ccw_device_set_timeout(cdev, 0);
@@ -3298,9 +3312,10 @@ qdio_activate(struct ccw_device *cdev, i
 			sprintf(dbf_text,"aq:io%4x",result);
 			QDIO_DBF_TEXT2(1,setup,dbf_text);
 		}
-		QDIO_PRINT_WARN("activate queues on irq %04x: do_IO " \
-                           "returned %i, next try returned %i\n",
-                           irq_ptr->schid.sch_no,result,result2);
+		QDIO_PRINT_WARN("activate queues on irq 0.%x.%04x: do_IO " \
+				"returned %i, next try returned %i\n",
+				irq_ptr->schid.ssid, irq_ptr->schid.sch_no,
+				result, result2);
 		result=result2;
 	}
 
diff -urpN linux-2.6/drivers/s390/cio/schid.h linux-2.6-patched/drivers/s390/cio/schid.h
--- linux-2.6/drivers/s390/cio/schid.h	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/schid.h	2005-12-09 14:26:06.000000000 +0100
@@ -2,7 +2,8 @@
 #define S390_SCHID_H
 
 struct subchannel_id {
-	__u32 reserved:15;
+	__u32 reserved:13;
+	__u32 ssid:2;
 	__u32 one:1;
 	__u32 sch_no:16;
 } __attribute__ ((packed,aligned(4)));
diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/s390mach.c	2005-12-09 14:26:06.000000000 +0100
@@ -23,7 +23,7 @@
 
 static struct semaphore m_sem;
 
-extern int css_process_crw(int);
+extern int css_process_crw(int, int);
 extern int chsc_process_crw(void);
 extern int chp_process_crw(int, int);
 extern void css_reiterate_subchannels(void);
@@ -49,9 +49,10 @@ s390_handle_damage(char *msg)
 static int
 s390_collect_crw_info(void *param)
 {
-	struct crw crw;
+	struct crw crw[2];
 	int ccode, ret, slow;
 	struct semaphore *sem;
+	unsigned int chain;
 
 	sem = (struct semaphore *)param;
 	/* Set a nice name. */
@@ -59,25 +60,50 @@ s390_collect_crw_info(void *param)
 repeat:
 	down_interruptible(sem);
 	slow = 0;
+	chain = 0;
 	while (1) {
-		ccode = stcrw(&crw);
+		if (unlikely(chain > 1)) {
+			struct crw tmp_crw;
+
+			printk(KERN_WARNING"%s: Code does not support more "
+			       "than two chained crws; please report to "
+			       "linux390@de.ibm.com!\n", __FUNCTION__);
+			ccode = stcrw(&tmp_crw);
+			printk(KERN_WARNING"%s: crw reports slct=%d, oflw=%d, "
+			       "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
+			       __FUNCTION__, tmp_crw.slct, tmp_crw.oflw,
+			       tmp_crw.chn, tmp_crw.rsc, tmp_crw.anc,
+			       tmp_crw.erc, tmp_crw.rsid);
+			printk(KERN_WARNING"%s: This was crw number %x in the "
+			       "chain\n", __FUNCTION__, chain);
+			if (ccode != 0)
+				break;
+			chain = tmp_crw.chn ? chain + 1 : 0;
+			continue;
+		}
+		ccode = stcrw(&crw[chain]);
 		if (ccode != 0)
 			break;
 		DBG(KERN_DEBUG "crw_info : CRW reports slct=%d, oflw=%d, "
 		    "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
-		    crw.slct, crw.oflw, crw.chn, crw.rsc, crw.anc,
-		    crw.erc, crw.rsid);
+		    crw[chain].slct, crw[chain].oflw, crw[chain].chn,
+		    crw[chain].rsc, crw[chain].anc, crw[chain].erc,
+		    crw[chain].rsid);
 		/* Check for overflows. */
-		if (crw.oflw) {
+		if (crw[chain].oflw) {
 			pr_debug("%s: crw overflow detected!\n", __FUNCTION__);
 			css_reiterate_subchannels();
+			chain = 0;
 			slow = 1;
 			continue;
 		}
-		switch (crw.rsc) {
+		switch (crw[chain].rsc) {
 		case CRW_RSC_SCH:
-			pr_debug("source is subchannel %04X\n", crw.rsid);
-			ret = css_process_crw (crw.rsid);
+			if (crw[0].chn && !chain)
+				break;
+			pr_debug("source is subchannel %04X\n", crw[0].rsid);
+			ret = css_process_crw (crw[0].rsid,
+					       chain ? crw[1].rsid : 0);
 			if (ret == -EAGAIN)
 				slow = 1;
 			break;
@@ -85,18 +111,18 @@ repeat:
 			pr_debug("source is monitoring facility\n");
 			break;
 		case CRW_RSC_CPATH:
-			pr_debug("source is channel path %02X\n", crw.rsid);
-			switch (crw.erc) {
+			pr_debug("source is channel path %02X\n", crw[0].rsid);
+			switch (crw[0].erc) {
 			case CRW_ERC_IPARM: /* Path has come. */
-				ret = chp_process_crw(crw.rsid, 1);
+				ret = chp_process_crw(crw[0].rsid, 1);
 				break;
 			case CRW_ERC_PERRI: /* Path has gone. */
 			case CRW_ERC_PERRN:
-				ret = chp_process_crw(crw.rsid, 0);
+				ret = chp_process_crw(crw[0].rsid, 0);
 				break;
 			default:
 				pr_debug("Don't know how to handle erc=%x\n",
-					 crw.erc);
+					 crw[0].erc);
 				ret = 0;
 			}
 			if (ret == -EAGAIN)
@@ -115,6 +141,8 @@ repeat:
 			pr_debug("unknown source\n");
 			break;
 		}
+		/* chain is always 0 or 1 here. */
+		chain = crw[chain].chn ? chain + 1 : 0;
 	}
 	if (slow)
 		queue_work(slow_path_wq, &slow_path_work);
