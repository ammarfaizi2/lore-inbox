Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264948AbUF1N0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbUF1N0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 09:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUF1N0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 09:26:20 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:12441 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S264948AbUF1N0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 09:26:07 -0400
Date: Mon, 28 Jun 2004 16:25:59 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] Add selective delay to sch_dealy (aka sch_ooo)
Message-ID: <Pine.LNX.4.60.0406281123310.10087@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

David, please apply.
I tested it and works as expected.
Seems Stephen doesn't have time to look over.
Thank you very much.

Signed-off-by: Catalin(ux aka Dino) BOIE <catab at umbrella dot ro>

--- linux-2.6.7-bk5.orig/net/sched/sch_delay.c	2004-06-23 12:18:00.000000000 
+0300
+++ linux-2.6.7-bk5/net/sched/sch_delay.c	2004-06-24 10:41:02.000000000 
+0300
@@ -7,6 +7,7 @@
   * 		2 of the License, or (at your option) any later version.
   *
   * Authors:	Stephen Hemminger <shemminger@osdl.org>
+		Catalin(ux aka Dino) BOIE <catab at umbrella dot ro>
   */

  #include <linux/config.h>
@@ -33,7 +34,7 @@
  #include <net/pkt_sched.h>

  /*	Network delay simulator
-	This scheduler adds a fixed delay to all packets.
+	This scheduler adds a fixed delay to all/some packets.
  	Similar to NISTnet and BSD Dummynet.

  	It uses byte fifo underneath similar to TBF */
@@ -41,8 +42,12 @@ struct dly_sched_data {
  	u32	latency;
  	u32	limit;
  	u32	loss;
+	u32	gap;	/* gap between packets: 0=all pkts are processed */
  	struct timer_list timer;
  	struct Qdisc *qdisc;
+	struct sk_buff_head qooo;
+	u32	send_from_qooo;
+	u32	counter;
  };

  /* Time stamp put into socket buffer control block */
@@ -59,6 +64,8 @@ static int dly_enqueue(struct sk_buff *s
  	struct dly_skb_cb *cb = (struct dly_skb_cb *)skb->cb;
  	int ret;

+	pr_debug("enqueue:\n");
+
  	/* Random packet drop 0 => none, ~0 => all */
  	if (q->loss >= net_random()) {
  		sch->stats.drops++;
@@ -104,6 +111,26 @@ static unsigned int dly_drop(struct Qdis
  	return len;
  }

+static void dly_mod_timer(struct dly_sched_data *q, struct sk_buff *skb)
+{
+	struct dly_skb_cb	*cb;
+	psched_time_t		now;
+	long			diff, delay;
+
+	if (timer_pending(&q->timer))
+		return;
+
+	cb = (struct dly_skb_cb *)skb->cb;
+	PSCHED_GET_TIME(now);
+	diff = q->latency - PSCHED_TDIFF(now, cb->queuetime);
+	delay = PSCHED_US2JIFFIE(diff);
+	if (delay <= 0)
+		delay = 1;
+	mod_timer(&q->timer, jiffies + delay);
+
+	pr_debug("mod_timer: Set new timer to %ld\n", jiffies + delay);
+}
+
  /* Dequeue packet.
   * If packet needs to be held up, then stop the
   * queue and set timer to wakeup later.
@@ -111,37 +138,54 @@ static unsigned int dly_drop(struct Qdis
  static struct sk_buff *dly_dequeue(struct Qdisc *sch)
  {
  	struct dly_sched_data *q = (struct dly_sched_data *)sch->data;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *skb2;

- retry:
-	skb = q->qdisc->dequeue(q->qdisc);
-	if (skb) {
-		struct dly_skb_cb *cb = (struct dly_skb_cb *)skb->cb;
-		psched_time_t now;
-		long diff, delay;
-
-		PSCHED_GET_TIME(now);
-		diff = q->latency - PSCHED_TDIFF(now, cb->queuetime);
-
-		if (diff <= 0) {
-			sch->q.qlen--;
-			sch->flags &= ~TCQ_F_THROTTLED;
-			return skb;
+	/* test if we must dequeue from qooo */
+	if (q->send_from_qooo == 1) {
+		q->send_from_qooo = 0;
+
+		skb = __skb_dequeue(&q->qooo);
+		if (skb == NULL) {
+			pr_debug("dequeue: BUG! send_from_qooo == 1 and queue 
empty!\n");
+			return NULL;
  		}

-		if (q->qdisc->ops->requeue(skb, q->qdisc) != NET_XMIT_SUCCESS) 
{
-			sch->q.qlen--;
-			sch->stats.drops++;
-			goto retry;
+		pr_debug("dequeue: from qooo queue [%p]\n", skb);
+		sch->q.qlen--;
+
+		/* set timer to next event */
+		skb2 = __skb_dequeue(&q->qooo);
+		if (skb2) {
+			dly_mod_timer(q, skb2);
+			__skb_queue_head(&q->qooo, skb2);
  		}

-		delay = PSCHED_US2JIFFIE(diff);
-		if (delay <= 0)
-		  delay = 1;
-		mod_timer(&q->timer, jiffies+delay);
+		return skb;
+	}
+
+	skb = q->qdisc->dequeue(q->qdisc);
+	if (skb == NULL)
+		return NULL;
+
+	if (q->counter < q->gap) {
+		pr_debug("dequeue: don't touch this packet\n");
+		q->counter++;

-		sch->flags |= TCQ_F_THROTTLED;
+		sch->q.qlen--;
+		sch->flags &= ~TCQ_F_THROTTLED;
+		return skb;
  	}
+
+	/* we must delay this packet */
+	pr_debug("dequeue: mv head pkt from main to qooo and mod timer\n");
+	q->send_from_qooo = 0;
+	dly_mod_timer(q, skb);
+	__skb_queue_tail(&q->qooo, skb);
+	sch->flags |= TCQ_F_THROTTLED;
+
+	/* reset counter */
+	q->counter = 0;
+
  	return NULL;
  }

@@ -153,11 +197,16 @@ static void dly_reset(struct Qdisc *sch)
  	sch->q.qlen = 0;
  	sch->flags &= ~TCQ_F_THROTTLED;
  	del_timer(&q->timer);
+	skb_queue_purge(&q->qooo);
  }

  static void dly_timer(unsigned long arg)
  {
  	struct Qdisc *sch = (struct Qdisc *)arg;
+	struct dly_sched_data *q = (struct dly_sched_data *)sch->data;
+
+	pr_debug("timer: Permit sending from qooo\n");
+	q->send_from_qooo = 1;

  	sch->flags &= ~TCQ_F_THROTTLED;
  	netif_schedule(sch->dev);
@@ -205,6 +254,10 @@ static int dly_change(struct Qdisc *sch,
  		q->latency = qopt->latency;
  		q->limit = qopt->limit;
  		q->loss = qopt->loss;
+		q->gap = qopt->gap;
+
+		q->counter = 0;
+		q->send_from_qooo = 0;
  	}
  	return err;
  }
@@ -221,6 +274,8 @@ static int dly_init(struct Qdisc *sch, s
  	q->timer.data = (unsigned long) sch;
  	q->qdisc = &noop_qdisc;

+	skb_queue_head_init(&q->qooo);
+
  	return dly_change(sch, opt);
  }

@@ -231,6 +286,7 @@ static void dly_destroy(struct Qdisc *sc
  	del_timer(&q->timer);
  	qdisc_destroy(q->qdisc);
  	q->qdisc = &noop_qdisc;
+	skb_queue_purge(&q->qooo);
  }

  static int dly_dump(struct Qdisc *sch, struct sk_buff *skb)
@@ -242,6 +298,7 @@ static int dly_dump(struct Qdisc *sch, s
  	qopt.latency = q->latency;
  	qopt.limit = q->limit;
  	qopt.loss = q->loss;
+	qopt.gap = q->gap;

  	RTA_PUT(skb, TCA_OPTIONS, sizeof(qopt), &qopt);

--- linux-2.6.7-bk5.orig/include/linux/pkt_sched.h	2004-06-23 
12:17:59.000000000 +0300
+++ linux-2.6.7-bk5/include/linux/pkt_sched.h	2004-06-23 14:40:16.000000000 
+0300
@@ -438,5 +438,6 @@ struct tc_dly_qopt
  	__u32	latency;
  	__u32   limit;
  	__u32	loss;
+	__u32	gap;
  };
  #endif

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
