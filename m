Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269111AbUIXXov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269111AbUIXXov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 19:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUIXXoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 19:44:03 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:14076 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP id S269092AbUIXXlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 19:41:35 -0400
Message-ID: <4154B0A1.1070305@watson.ibm.com>
Date: Fri, 24 Sep 2004 19:41:21 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ckrm-tech <ckrm-tech@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][1/1] Per-priority statistics for CFQ w/iopriorities 2.6.8.1
Content-Type: multipart/mixed;
 boundary="------------040605070409040604050300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040605070409040604050300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch applies over the port of I/O priorities to CFQ for 2.6.8.1
posted earlier.

It adds useful statistics like requests and sectors received/served
and number of dynamic queue addition/deletions for each priority level 
(0 through 20) created by the earlier patch.

The patch is not required for correct functioning of the I/O priority 
port.

-- Shailabh






--------------040605070409040604050300
Content-Type: text/plain;
 name="cfq-priostats.2681.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cfq-priostats.2681.patch"

diff -Nru a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
--- a/drivers/block/cfq-iosched.c	Fri Sep 24 19:16:53 2004
+++ b/drivers/block/cfq-iosched.c	Fri Sep 24 19:16:53 2004
@@ -91,6 +91,15 @@
 	int busy_queues;
 	int busy_rq;
 	unsigned long busy_sectors;
+	
+	/* requests, sectors and queues 
+         * added(in),dispatched/deleted(out) 
+	 * at this priority level. 
+	 */
+	atomic_t cum_rq_in,cum_rq_out;              
+	atomic_t cum_sectors_in,cum_sectors_out;    
+	atomic_t cum_queues_in,cum_queues_out;
+
 	struct list_head prio_list;
 	int last_rq;
 	int last_sectors;
@@ -240,7 +249,9 @@
 			cfqd->cid[crq->ioprio].busy_rq--;
 			cfqd->cid[crq->ioprio].busy_sectors -= crq->nr_sectors;
 		}
-
+		atomic_inc(&(cfqd->cid[crq->ioprio].cum_rq_out));
+		atomic_add(crq->nr_sectors,
+			   &(cfqd->cid[crq->ioprio].cum_sectors_out));
 		cfqq->queued[rq_data_dir(crq->request)]--;
 		rb_erase(&crq->rb_node, &cfqq->sort_list);
 	}
@@ -283,6 +294,9 @@
 		cfqd->cid[crq->ioprio].busy_rq++;
 		cfqd->cid[crq->ioprio].busy_sectors += crq->nr_sectors;
 	}
+	atomic_inc(&(cfqd->cid[crq->ioprio].cum_rq_in));
+	atomic_add(crq->nr_sectors,
+		   &(cfqd->cid[crq->ioprio].cum_sectors_in));
 retry:
 	__alias = __cfq_add_crq_rb(cfqq, crq);
 	if (!__alias) {
@@ -399,6 +413,7 @@
 {
 	struct cfq_data *cfqd = q->elevator.elevator_data;
 	struct cfq_rq *crq = RQ_ELV_DATA(req);
+	int tmp;
 
 	cfq_del_crq_hash(crq);
 	cfq_add_crq_hash(cfqd, crq);
@@ -410,9 +425,11 @@
 		cfq_add_crq_rb(cfqd, cfqq, crq);
 	}
 
-	cfqd->busy_sectors += req->hard_nr_sectors - crq->nr_sectors;
-	cfqd->cid[crq->ioprio].busy_sectors += 
-		req->hard_nr_sectors - crq->nr_sectors;
+	tmp = req->hard_nr_sectors - crq->nr_sectors;
+	cfqd->busy_sectors += tmp;
+	cfqd->cid[crq->ioprio].busy_sectors += tmp;
+	atomic_add(tmp,&(cfqd->cid[crq->ioprio].cum_sectors_in));
+
 	crq->nr_sectors = req->hard_nr_sectors;
 
 	q->last_merge = req;
@@ -683,6 +700,7 @@
 
 	cfqd->cid[cfqq->ioprio].busy_queues--;
 	WARN_ON(cfqd->cid[cfqq->ioprio].busy_queues < 0);
+	atomic_inc(&(cfqd->cid[cfqq->ioprio].cum_queues_out));
 
 	list_del(&cfqq->cfq_list);
 	hlist_del(&cfqq->cfq_hash);
@@ -756,7 +774,9 @@
 			if (!list_empty(&cfqq->cfq_list)) {
 				cfqd->cid[cfqq->ioprio].busy_queues--;
 				WARN_ON(cfqd->cid[cfqq->ioprio].busy_queues<0);
+				atomic_inc(&(cfqd->cid[cfqq->ioprio].cum_queues_out));
 				cfqd->cid[prio].busy_queues++;
+				atomic_inc(&(cfqd->cid[prio].cum_queues_in));
 				list_move_tail(&cfqq->cfq_list, 
 					       &cfqd->cid[prio].rr_list);
 			}
@@ -769,6 +789,7 @@
 			list_add_tail(&cfqq->cfq_list, 
 				      &cfqd->cid[prio].rr_list);
 			cfqd->cid[prio].busy_queues++;
+			atomic_inc(&(cfqd->cid[prio].cum_queues_in));
 			cfqd->busy_queues++;
 		}
 
@@ -1052,6 +1073,13 @@
 		INIT_LIST_HEAD(&cid->prio_list);
 		cid->last_rq = -1;
 		cid->last_sectors = -1;
+
+		atomic_set(&cid->cum_rq_in,0);		
+		atomic_set(&cid->cum_rq_out,0);
+		atomic_set(&cid->cum_sectors_in,0);
+		atomic_set(&cid->cum_sectors_out,0);		
+		atomic_set(&cid->cum_queues_in,0);
+		atomic_set(&cid->cum_queues_out,0);
 	}
 
 	cfqd->crq_hash = kmalloc(sizeof(struct hlist_head) * CFQ_MHASH_ENTRIES,
@@ -1179,6 +1207,100 @@
 STORE_FUNCTION(cfq_grace_idle_store, &cfqd->cfq_grace_idle, 0, INT_MAX);
 #undef STORE_FUNCTION
 
+
+/* Additional entries to get priority level data */
+static ssize_t
+cfq_prio_show(struct cfq_data *cfqd, char *page, unsigned int priolvl)
+{
+	int r1,r2,s1,s2,q1,q2;
+
+	if (!(priolvl >= IOPRIO_IDLE && priolvl <= IOPRIO_RT)) 
+		return 0;
+	
+	r1 = (int)atomic_read(&(cfqd->cid[priolvl].cum_rq_in));
+	r2 = (int)atomic_read(&(cfqd->cid[priolvl].cum_rq_out));
+	s1 = (int)atomic_read(&(cfqd->cid[priolvl].cum_sectors_in));
+	s2 = (int)atomic_read(&(cfqd->cid[priolvl].cum_sectors_out));
+	q1 = (int)atomic_read(&(cfqd->cid[priolvl].cum_queues_in)); 
+	q2 = (int)atomic_read(&(cfqd->cid[priolvl].cum_queues_out));
+	
+	return sprintf(page,"rq (%d,%d) sec (%d,%d) q (%d,%d)\n",
+		      r1,r2,
+		      s1,s2,
+		      q1,q2);
+}
+
+#define SHOW_PRIO_DATA(__PRIOLVL)                                               \
+static ssize_t cfq_prio_##__PRIOLVL##_show(struct cfq_data *cfqd, char *page)	\
+{									        \
+	return cfq_prio_show(cfqd,page,__PRIOLVL);				\
+}
+SHOW_PRIO_DATA(0);
+SHOW_PRIO_DATA(1);
+SHOW_PRIO_DATA(2);
+SHOW_PRIO_DATA(3);
+SHOW_PRIO_DATA(4);
+SHOW_PRIO_DATA(5);
+SHOW_PRIO_DATA(6);
+SHOW_PRIO_DATA(7);
+SHOW_PRIO_DATA(8);
+SHOW_PRIO_DATA(9);
+SHOW_PRIO_DATA(10);
+SHOW_PRIO_DATA(11);
+SHOW_PRIO_DATA(12);
+SHOW_PRIO_DATA(13);
+SHOW_PRIO_DATA(14);
+SHOW_PRIO_DATA(15);
+SHOW_PRIO_DATA(16);
+SHOW_PRIO_DATA(17);
+SHOW_PRIO_DATA(18);
+SHOW_PRIO_DATA(19);
+SHOW_PRIO_DATA(20);
+#undef SHOW_PRIO_DATA
+
+
+static ssize_t cfq_prio_store(struct cfq_data *cfqd, const char *page, size_t count, int priolvl)
+{	
+	atomic_set(&(cfqd->cid[priolvl].cum_rq_in),0);
+	atomic_set(&(cfqd->cid[priolvl].cum_rq_out),0);
+	atomic_set(&(cfqd->cid[priolvl].cum_sectors_in),0);
+	atomic_set(&(cfqd->cid[priolvl].cum_sectors_out),0);
+	atomic_set(&(cfqd->cid[priolvl].cum_queues_in),0);
+	atomic_set(&(cfqd->cid[priolvl].cum_queues_out),0);
+
+	return count;
+}
+
+
+#define STORE_PRIO_DATA(__PRIOLVL)				                                   \
+static ssize_t cfq_prio_##__PRIOLVL##_store(struct cfq_data *cfqd, const char *page, size_t count) \
+{									                           \
+        return cfq_prio_store(cfqd,page,count,__PRIOLVL);                                          \
+}                  
+STORE_PRIO_DATA(0);     
+STORE_PRIO_DATA(1);
+STORE_PRIO_DATA(2);
+STORE_PRIO_DATA(3);
+STORE_PRIO_DATA(4);
+STORE_PRIO_DATA(5);
+STORE_PRIO_DATA(6);
+STORE_PRIO_DATA(7);
+STORE_PRIO_DATA(8);
+STORE_PRIO_DATA(9);
+STORE_PRIO_DATA(10);
+STORE_PRIO_DATA(11);
+STORE_PRIO_DATA(12);
+STORE_PRIO_DATA(13);
+STORE_PRIO_DATA(14);
+STORE_PRIO_DATA(15);
+STORE_PRIO_DATA(16);
+STORE_PRIO_DATA(17);
+STORE_PRIO_DATA(18);
+STORE_PRIO_DATA(19);
+STORE_PRIO_DATA(20);
+#undef STORE_PRIO_DATA
+
+
 static struct cfq_fs_entry cfq_quantum_entry = {
 	.attr = {.name = "quantum", .mode = S_IRUGO | S_IWUSR },
 	.show = cfq_quantum_show,
@@ -1215,6 +1337,58 @@
 	.store = cfq_grace_idle_store,
 };
 
+#define P_0_STR   "p0"
+#define P_1_STR   "p1"
+#define P_2_STR   "p2"
+#define P_3_STR   "p3"
+#define P_4_STR   "p4"
+#define P_5_STR   "p5"
+#define P_6_STR   "p6"
+#define P_7_STR   "p7"
+#define P_8_STR   "p8"
+#define P_9_STR   "p9"
+#define P_10_STR  "p10"
+#define P_11_STR  "p11"
+#define P_12_STR  "p12"
+#define P_13_STR  "p13"
+#define P_14_STR  "p14"
+#define P_15_STR  "p15"
+#define P_16_STR  "p16"
+#define P_17_STR  "p17"
+#define P_18_STR  "p18"
+#define P_19_STR  "p19"
+#define P_20_STR  "p20"
+
+
+#define CFQ_PRIO_SYSFS_ENTRY(__PRIOLVL)				           \
+static struct cfq_fs_entry cfq_prio_##__PRIOLVL##_entry = {                \
+	.attr = {.name = P_##__PRIOLVL##_STR, .mode = S_IRUGO | S_IWUSR }, \
+	.show = cfq_prio_##__PRIOLVL##_show,                               \
+	.store = cfq_prio_##__PRIOLVL##_store,                             \
+};
+CFQ_PRIO_SYSFS_ENTRY(0);
+CFQ_PRIO_SYSFS_ENTRY(1);
+CFQ_PRIO_SYSFS_ENTRY(2);
+CFQ_PRIO_SYSFS_ENTRY(3);
+CFQ_PRIO_SYSFS_ENTRY(4);
+CFQ_PRIO_SYSFS_ENTRY(5);
+CFQ_PRIO_SYSFS_ENTRY(6);
+CFQ_PRIO_SYSFS_ENTRY(7);
+CFQ_PRIO_SYSFS_ENTRY(8);
+CFQ_PRIO_SYSFS_ENTRY(9);
+CFQ_PRIO_SYSFS_ENTRY(10);
+CFQ_PRIO_SYSFS_ENTRY(11);
+CFQ_PRIO_SYSFS_ENTRY(12);
+CFQ_PRIO_SYSFS_ENTRY(13);
+CFQ_PRIO_SYSFS_ENTRY(14);
+CFQ_PRIO_SYSFS_ENTRY(15);
+CFQ_PRIO_SYSFS_ENTRY(16);
+CFQ_PRIO_SYSFS_ENTRY(17);
+CFQ_PRIO_SYSFS_ENTRY(18);
+CFQ_PRIO_SYSFS_ENTRY(19);
+CFQ_PRIO_SYSFS_ENTRY(20);
+#undef CFQ_PRIO_SYSFS_ENTRY
+
 static struct attribute *default_attrs[] = {
 	&cfq_quantum_entry.attr,
 	&cfq_quantum_io_entry.attr,
@@ -1223,6 +1397,27 @@
 	&cfq_queued_entry.attr,
 	&cfq_grace_rt_entry.attr,
 	&cfq_grace_idle_entry.attr,
+	&cfq_prio_0_entry.attr,
+	&cfq_prio_1_entry.attr,
+	&cfq_prio_2_entry.attr,
+	&cfq_prio_3_entry.attr,
+	&cfq_prio_4_entry.attr,
+	&cfq_prio_5_entry.attr,
+	&cfq_prio_6_entry.attr,
+	&cfq_prio_7_entry.attr,
+	&cfq_prio_8_entry.attr,
+	&cfq_prio_9_entry.attr,
+	&cfq_prio_10_entry.attr,
+	&cfq_prio_11_entry.attr,
+	&cfq_prio_12_entry.attr,
+	&cfq_prio_13_entry.attr,
+	&cfq_prio_14_entry.attr,
+	&cfq_prio_15_entry.attr,
+	&cfq_prio_16_entry.attr,
+	&cfq_prio_17_entry.attr,
+	&cfq_prio_18_entry.attr,
+	&cfq_prio_19_entry.attr,
+	&cfq_prio_20_entry.attr,
 	NULL,
 };
 

--------------040605070409040604050300--
