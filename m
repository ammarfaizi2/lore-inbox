Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316477AbSFUIe7>; Fri, 21 Jun 2002 04:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316490AbSFUIe6>; Fri, 21 Jun 2002 04:34:58 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:30892 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316477AbSFUIe5>;
	Fri, 21 Jun 2002 04:34:57 -0400
Date: Fri, 21 Jun 2002 05:39:51 -0300
From: Werner Almesberger <wa@almesberger.net>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: [PATCH] policing for sch_prio (2.4,2.5)
Message-ID: <20020621053951.A2295@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've attached a little patch that adds support for policing to the
"prio" queuing discipline (all other classful queuing disciplines
already support policing - "prio" is the odd exception that
silently ignores policing).

This patch is for 2.4.19-pre8 (tested by simulation), but it also
works with 2.5.24 (tested in the real kernel), and it should work
with 2.4.19-pre10 (untested). I also ran it by Alexey a few weeks
ago and he didn't notice any obvious problems.

I'd recommend including this patch in 2.5. I don't know if it is
important enough to warrant application to 2.4 too, but it would
certainly be nice to have consistency.

- Werner

---------------------------------- cut here -----------------------------------

--- net/sched/sch_prio.c.orig	Sun May 26 05:24:29 2002
+++ net/sched/sch_prio.c	Sun May 26 05:58:38 2002
@@ -42,12 +42,14 @@
 {
 	int bands;
 	struct tcf_proto *filter_list;
+	struct Qdisc *last_dequeued; /* remember for prio_requeue */
 	u8  prio2band[TC_PRIO_MAX+1];
 	struct Qdisc *queues[TCQ_PRIO_BANDS];
 };
 
 
-static __inline__ unsigned prio_classify(struct sk_buff *skb, struct Qdisc *sch)
+static __inline__ struct Qdisc *prio_classify(struct sk_buff *skb,
+    struct Qdisc *sch)
 {
 	struct prio_sched_data *q = (struct prio_sched_data *)sch->data;
 	struct tcf_result res;
@@ -55,27 +57,34 @@
 
 	band = skb->priority;
 	if (TC_H_MAJ(skb->priority) != sch->handle) {
-		if (!q->filter_list || tc_classify(skb, q->filter_list, &res)) {
-			if (TC_H_MAJ(band))
-				band = 0;
-			return q->prio2band[band&TC_PRIO_MAX];
+		switch (q->filter_list ? tc_classify(skb, q->filter_list, &res)
+		    : TC_POLICE_UNSPEC) {
+			case TC_POLICE_SHOT:
+				kfree_skb(skb);
+				return NULL;
+			case TC_POLICE_OK:
+				break;
+			default:
+				if (TC_H_MAJ(band))
+					band = 0;
+				return q->queues[
+				    q->prio2band[band&TC_PRIO_MAX]];
 		}
 		band = res.classid;
 	}
 	band = TC_H_MIN(band) - 1;
-	return band < q->bands ? band : q->prio2band[0];
+	return q->queues[band < q->bands ? band : q->prio2band[0]];
 }
 
 static int
 prio_enqueue(struct sk_buff *skb, struct Qdisc* sch)
 {
-	struct prio_sched_data *q = (struct prio_sched_data *)sch->data;
 	struct Qdisc *qdisc;
-	int ret;
+	int ret = NET_XMIT_POLICED;
 
-	qdisc = q->queues[prio_classify(skb, sch)];
+	qdisc = prio_classify(skb, sch);
 
-	if ((ret = qdisc->enqueue(skb, qdisc)) == 0) {
+	if (qdisc && (ret = qdisc->enqueue(skb, qdisc)) == 0) {
 		sch->stats.bytes += skb->len;
 		sch->stats.packets++;
 		sch->q.qlen++;
@@ -93,7 +102,7 @@
 	struct Qdisc *qdisc;
 	int ret;
 
-	qdisc = q->queues[prio_classify(skb, sch)];
+	qdisc = q->last_dequeued;
 
 	if ((ret = qdisc->ops->requeue(skb, qdisc)) == 0) {
 		sch->q.qlen++;
@@ -116,6 +125,7 @@
 		qdisc = q->queues[prio];
 		skb = qdisc->dequeue(qdisc);
 		if (skb) {
+			q->last_dequeued = qdisc;
 			sch->q.qlen--;
 			return skb;
 		}

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
