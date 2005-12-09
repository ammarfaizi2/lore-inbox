Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVLIP3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVLIP3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVLIP3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:29:04 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:33213 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964777AbVLIP2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:28:50 -0500
Date: Fri, 9 Dec 2005 16:28:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 14/17] s390: introduce struct channel_subsystem.
Message-ID: <20051209152846.GO6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

[patch 14/17] s390: introduce struct channel_subsystem.

struct channel_subsystem encapsulates several per channel subsystem
properties, like status of chpids or the global path group id.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/chsc.c        |   32 +++++++++++--------
 drivers/s390/cio/chsc.h        |    5 +--
 drivers/s390/cio/css.c         |   67 ++++++++++++++++++++++++++++-------------
 drivers/s390/cio/css.h         |   25 ++++++++++++---
 drivers/s390/cio/device.c      |    4 --
 drivers/s390/cio/device_pgid.c |    2 -
 6 files changed, 90 insertions(+), 45 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2005-12-09 14:26:02.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2005-12-09 14:26:02.000000000 +0100
@@ -24,8 +24,6 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-static struct channel_path *chps[NR_CHPIDS];
-
 static void *sei_page;
 
 static int new_channel_path(int chpid);
@@ -33,13 +31,13 @@ static int new_channel_path(int chpid);
 static inline void
 set_chp_logically_online(int chp, int onoff)
 {
-	chps[chp]->state = onoff;
+	css[0]->chps[chp]->state = onoff;
 }
 
 static int
 get_chp_status(int chp)
 {
-	return (chps[chp] ? chps[chp]->state : -ENODEV);
+	return (css[0]->chps[chp] ? css[0]->chps[chp]->state : -ENODEV);
 }
 
 void
@@ -219,13 +217,13 @@ s390_subchannel_remove_chpid(struct devi
 	int j;
 	int mask;
 	struct subchannel *sch;
-	__u8 *chpid;
+	struct channel_path *chpid;
 	struct schib schib;
 
 	sch = to_subchannel(dev);
 	chpid = data;
 	for (j = 0; j < 8; j++)
-		if (sch->schib.pmcw.chpid[j] == *chpid)
+		if (sch->schib.pmcw.chpid[j] == chpid->id)
 			break;
 	if (j >= 8)
 		return 0;
@@ -296,18 +294,20 @@ static inline void
 s390_set_chpid_offline( __u8 chpid)
 {
 	char dbf_txt[15];
+	struct device *dev;
 
 	sprintf(dbf_txt, "chpr%x", chpid);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
 	if (get_chp_status(chpid) <= 0)
 		return;
-
-	bus_for_each_dev(&css_bus_type, NULL, &chpid,
+	dev = get_device(&css[0]->chps[chpid]->dev);
+	bus_for_each_dev(&css_bus_type, NULL, to_channelpath(dev),
 			 s390_subchannel_remove_chpid);
 
 	if (need_rescan || css_slow_subchannels_exist())
 		queue_work(slow_path_wq, &slow_path_work);
+	put_device(dev);
 }
 
 struct res_acc_data {
@@ -511,6 +511,7 @@ chsc_process_crw(void)
 	ret = 0;
 	do {
 		int ccode, status;
+		struct device *dev;
 		memset(sei_area, 0, sizeof(*sei_area));
 		memset(&res_data, 0, sizeof(struct res_acc_data));
 		sei_area->request = (struct chsc_header) {
@@ -586,7 +587,8 @@ chsc_process_crw(void)
 				new_channel_path(sei_area->rsid);
 			else if (!status)
 				break;
-			res_data.chp = chps[sei_area->rsid];
+			dev = get_device(&css[0]->chps[sei_area->rsid]->dev);
+			res_data.chp = to_channelpath(dev);
 			pr_debug("chpid: %x", sei_area->rsid);
 			if ((sei_area->vf & 0xc0) != 0) {
 				res_data.fla = sei_area->fla;
@@ -602,6 +604,7 @@ chsc_process_crw(void)
 			}
 			ret = s390_process_res_acc(&res_data);
 			pr_debug("\n\n");
+			put_device(dev);
 			break;
 			
 		default: /* other stuff */
@@ -678,6 +681,7 @@ chp_add(int chpid)
 {
 	int rc;
 	char dbf_txt[15];
+	struct device *dev;
 
 	if (!get_chp_status(chpid))
 		return 0; /* no need to do the rest */
@@ -685,11 +689,13 @@ chp_add(int chpid)
 	sprintf(dbf_txt, "cadd%x", chpid);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
-	rc = for_each_subchannel(__chp_add, chps[chpid]);
+	dev = get_device(&css[0]->chps[chpid]->dev);
+	rc = for_each_subchannel(__chp_add, to_channelpath(dev));
 	if (css_slow_subchannels_exist())
 		rc = -EAGAIN;
 	if (rc != -EAGAIN)
 		rc = 0;
+	put_device(dev);
 	return rc;
 }
 
@@ -1016,7 +1022,7 @@ new_channel_path(int chpid)
 	chp->id = chpid;
 	chp->state = 1;
 	chp->dev = (struct device) {
-		.parent  = &css_bus_device,
+		.parent  = &css[0]->device,
 		.release = chp_release,
 	};
 	snprintf(chp->dev.bus_id, BUS_ID_SIZE, "chp0.%x", chpid);
@@ -1038,7 +1044,7 @@ new_channel_path(int chpid)
 		device_unregister(&chp->dev);
 		goto out_free;
 	} else
-		chps[chpid] = chp;
+		css[0]->chps[chpid] = chp;
 	return ret;
 out_free:
 	kfree(chp);
@@ -1051,7 +1057,7 @@ chsc_get_chp_desc(struct subchannel *sch
 	struct channel_path *chp;
 	struct channel_path_desc *desc;
 
-	chp = chps[sch->schib.pmcw.chpid[chp_no]];
+	chp = css[0]->chps[sch->schib.pmcw.chpid[chp_no]];
 	if (!chp)
 		return NULL;
 	desc = kmalloc(sizeof(struct channel_path_desc), GFP_KERNEL);
diff -urpN linux-2.6/drivers/s390/cio/chsc.h linux-2.6-patched/drivers/s390/cio/chsc.h
--- linux-2.6/drivers/s390/cio/chsc.h	2005-12-09 14:25:54.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.h	2005-12-09 14:26:02.000000000 +0100
@@ -1,8 +1,6 @@
 #ifndef S390_CHSC_H
 #define S390_CHSC_H
 
-#define NR_CHPIDS 256
-
 #define CHSC_SEI_ACC_CHPID        1
 #define CHSC_SEI_ACC_LINKADDR     2
 #define CHSC_SEI_ACC_FULLLINKADDR 3
@@ -65,4 +63,7 @@ extern int chsc_determine_css_characteri
 extern int css_characteristics_avail;
 
 extern void *chsc_get_chp_desc(struct subchannel*, int);
+
+#define to_channelpath(dev) container_of(dev, struct channel_path, dev)
+
 #endif
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2005-12-09 14:26:02.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2005-12-09 14:26:02.000000000 +0100
@@ -24,12 +24,9 @@
 int need_rescan = 0;
 int css_init_done = 0;
 
-struct pgid global_pgid;
-int css_characteristics_avail = 0;
+struct channel_subsystem *css[__MAX_CSSID + 1];
 
-struct device css_bus_device = {
-	.bus_id = "css0",
-};
+int css_characteristics_avail = 0;
 
 inline int
 for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *data)
@@ -112,7 +109,7 @@ css_register_subchannel(struct subchanne
 	int ret;
 
 	/* Initialize the subchannel structure */
-	sch->dev.parent = &css_bus_device;
+	sch->dev.parent = &css[0]->device;
 	sch->dev.bus = &css_bus_type;
 	sch->dev.release = &css_subchannel_release;
 	
@@ -421,21 +418,35 @@ __init_channel_subsystem(struct subchann
 }
 
 static void __init
-css_generate_pgid(void)
+css_generate_pgid(struct channel_subsystem *css, u32 tod_high)
 {
-	/* Let's build our path group ID here. */
-	if (css_characteristics_avail && css_general_characteristics.mcss)
-		global_pgid.cpu_addr = 0x8000;
-	else {
+	if (css_characteristics_avail && css_general_characteristics.mcss) {
+		css->global_pgid.pgid_high.ext_cssid.version = 0x80;
+		css->global_pgid.pgid_high.ext_cssid.cssid = css->cssid;
+	} else {
 #ifdef CONFIG_SMP
-		global_pgid.cpu_addr = hard_smp_processor_id();
+		css->global_pgid.pgid_high.cpu_addr = hard_smp_processor_id();
 #else
-		global_pgid.cpu_addr = 0;
+		css->global_pgid.pgid_high.cpu_addr = 0;
 #endif
 	}
-	global_pgid.cpu_id = ((cpuid_t *) __LC_CPUID)->ident;
-	global_pgid.cpu_model = ((cpuid_t *) __LC_CPUID)->machine;
-	global_pgid.tod_high = (__u32) (get_clock() >> 32);
+	css->global_pgid.cpu_id = ((cpuid_t *) __LC_CPUID)->ident;
+	css->global_pgid.cpu_model = ((cpuid_t *) __LC_CPUID)->machine;
+	css->global_pgid.tod_high = tod_high;
+
+}
+
+static inline void __init
+setup_css(int nr)
+{
+	u32 tod_high;
+
+	memset(css[nr], 0, sizeof(struct channel_subsystem));
+	css[nr]->valid = 1;
+	css[nr]->cssid = nr;
+	sprintf(css[nr]->device.bus_id, "css%x", nr);
+	tod_high = (u32) (get_clock() >> 32);
+	css_generate_pgid(css[nr], tod_high);
 }
 
 /*
@@ -446,25 +457,39 @@ css_generate_pgid(void)
 static int __init
 init_channel_subsystem (void)
 {
-	int ret;
+	int ret, i;
 
 	if (chsc_determine_css_characteristics() == 0)
 		css_characteristics_avail = 1;
 
-	css_generate_pgid();
-
 	if ((ret = bus_register(&css_bus_type)))
 		goto out;
-	if ((ret = device_register (&css_bus_device)))
-		goto out_bus;
 
+	/* Setup css structure. */
+	for (i = 0; i <= __MAX_CSSID; i++) {
+		css[i] = kmalloc(sizeof(struct channel_subsystem), GFP_KERNEL);
+		if (!css[i]) {
+			ret = -ENOMEM;
+			goto out_bus;
+		}
+		setup_css(i);
+		ret = device_register(&css[i]->device);
+		if (ret)
+			goto out_free;
+	}
 	css_init_done = 1;
 
 	ctl_set_bit(6, 28);
 
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
+out_free:
+	kfree(css[i]);
 out_bus:
+	while (i > 0) {
+		i--;
+		device_unregister(&css[i]->device);
+	}
 	bus_unregister(&css_bus_type);
 out:
 	return ret;
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2005-12-09 14:26:02.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2005-12-09 14:26:02.000000000 +0100
@@ -35,19 +35,25 @@ struct path_state {
 	__u8  resvd  : 3;	/* reserved */
 } __attribute__ ((packed));
 
+struct extended_cssid {
+	u8 version;
+	u8 cssid;
+} __attribute__ ((packed));
+
 struct pgid {
 	union {
 		__u8 fc;   	/* SPID function code */
 		struct path_state ps;	/* SNID path state */
 	} inf;
-	__u32 cpu_addr	: 16;	/* CPU address */
+	union {
+		__u32 cpu_addr	: 16;	/* CPU address */
+		struct extended_cssid ext_cssid;
+	} pgid_high;
 	__u32 cpu_id	: 24;	/* CPU identification */
 	__u32 cpu_model : 16;	/* CPU model */
 	__u32 tod_high;		/* high word TOD clock */
 } __attribute__ ((packed));
 
-extern struct pgid global_pgid;
-
 #define MAX_CIWS 8
 
 /*
@@ -129,9 +135,20 @@ extern int css_init_done;
 extern int for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *);
 
 #define __MAX_SUBCHANNEL 65535
+#define __MAX_CHPID 255
+#define __MAX_CSSID 0
+
+struct channel_subsystem {
+	u8 cssid;
+	int valid;
+	struct channel_path *chps[__MAX_CHPID];
+	struct device device;
+	struct pgid global_pgid;
+};
+#define to_css(dev) container_of(dev, struct channel_subsystem, device)
 
 extern struct bus_type css_bus_type;
-extern struct device css_bus_device;
+extern struct channel_subsystem *css[];
 
 /* Some helper functions for disconnected state. */
 int device_is_disconnected(struct subchannel *);
diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2005-12-09 14:26:02.000000000 +0100
@@ -986,10 +986,6 @@ ccw_device_console_enable (struct ccw_de
 	cdev->dev = (struct device) {
 		.parent = &sch->dev,
 	};
-	/* Initialize the subchannel structure */
-	sch->dev.parent = &css_bus_device;
-	sch->dev.bus = &css_bus_type;
-
 	rc = io_subchannel_recog(cdev, sch);
 	if (rc)
 		return rc;
diff -urpN linux-2.6/drivers/s390/cio/device_pgid.c linux-2.6-patched/drivers/s390/cio/device_pgid.c
--- linux-2.6/drivers/s390/cio/device_pgid.c	2005-12-09 14:25:56.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device_pgid.c	2005-12-09 14:26:02.000000000 +0100
@@ -164,7 +164,7 @@ ccw_device_sense_pgid_irq(struct ccw_dev
 	/* 0, -ETIME, -EOPNOTSUPP, -EAGAIN, -EACCES or -EUSERS */
 	case 0:			/* Sense Path Group ID successful. */
 		if (cdev->private->pgid.inf.ps.state1 == SNID_STATE1_RESET)
-			memcpy(&cdev->private->pgid, &global_pgid,
+			memcpy(&cdev->private->pgid, &css[0]->global_pgid,
 			       sizeof(struct pgid));
 		ccw_device_sense_pgid_done(cdev, 0);
 		break;
