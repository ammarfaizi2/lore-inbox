Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUHVMlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUHVMlD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUHVMkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:40:45 -0400
Received: from legaleagle.de ([217.160.128.82]:16840 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S266796AbUHVMkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:40:00 -0400
Message-ID: <4128941D.9030000@trash.net>
Date: Sun, 22 Aug 2004 14:39:57 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Nuno Silva <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org,
       master@sectorb.msk.ru, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
 to become free. Usage count = 1
References: <E1BynUy-0007t1-00@gondolin.me.apana.org.au>
In-Reply-To: <E1BynUy-0007t1-00@gondolin.me.apana.org.au>
Content-Type: multipart/mixed;
 boundary="------------040809050802040307090201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040809050802040307090201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Herbert Xu wrote:

>Nuno Silva <nuno.silva@vgertech.com> wrote:
>  
>
>>The problem is in the QoS code. If I start ppp whithout the 
>>    
>>
>
>OK, this appears to be due to the changeset titled
>
>[PKT_SCHED]: Refcount qdisc->dev for __qdisc_destroy rcu-callback
>
>It adds a reference to dev.
>
>I don't see any code that cleans up that reference when the dev goes
>down.  So someone needs to add that similar to the code in net/core/dst.c.
>
>Patrick, could you please have a look at this?
>  
>
The reference is dropped in __qdisc_destroy. The problem lies in the CBQ
qdisc, it doesn't destroy the root-class and leaks the inner qdisc. These
two patches for 2.4 and 2.6 fix the problem.

Regards
Patrick



--------------040809050802040307090201
Content-Type: text/x-patch;
 name="01-2.4-cbq-leaks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-2.4-cbq-leaks.diff"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/22 14:37:58+02:00 kaber@coreworks.de 
#   [PKT_SCHED]: Fix class leak in CBQ scheduler
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/sched/sch_cbq.c
#   2004/08/22 14:37:27+02:00 kaber@coreworks.de +8 -6
#   [PKT_SCHED]: Fix class leak in CBQ scheduler
# 
diff -Nru a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
--- a/net/sched/sch_cbq.c	2004-08-22 14:38:18 +02:00
+++ b/net/sched/sch_cbq.c	2004-08-22 14:38:18 +02:00
@@ -1712,15 +1712,18 @@
 	}
 }
 
-static void cbq_destroy_class(struct cbq_class *cl)
+static void cbq_destroy_class(struct Qdisc *sch, struct cbq_class *cl)
 {
+	struct cbq_sched_data *q = (struct cbq_sched_data *)sch->data;
+
 	cbq_destroy_filters(cl);
 	qdisc_destroy(cl->q);
 	qdisc_put_rtab(cl->R_tab);
 #ifdef CONFIG_NET_ESTIMATOR
 	qdisc_kill_estimator(&cl->stats);
 #endif
-	kfree(cl);
+	if (cl != &q->link)
+		kfree(cl);
 }
 
 static void
@@ -1743,8 +1746,7 @@
 
 		for (cl = q->classes[h]; cl; cl = next) {
 			next = cl->next;
-			if (cl != &q->link)
-				cbq_destroy_class(cl);
+			cbq_destroy_class(sch, cl);
 		}
 	}
 
@@ -1766,7 +1768,7 @@
 		spin_unlock_bh(&sch->dev->queue_lock);
 #endif
 
-		cbq_destroy_class(cl);
+		cbq_destroy_class(sch, cl);
 	}
 }
 
@@ -2000,7 +2002,7 @@
 	sch_tree_unlock(sch);
 
 	if (--cl->refcnt == 0)
-		cbq_destroy_class(cl);
+		cbq_destroy_class(sch, cl);
 
 	return 0;
 }

--------------040809050802040307090201
Content-Type: text/x-patch;
 name="01-2.6-cbq-leaks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-2.6-cbq-leaks.diff"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/22 14:30:32+02:00 kaber@coreworks.de 
#   [PKT_SCHED]: Fix class leak in CBQ scheduler
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/sched/sch_cbq.c
#   2004/08/22 14:30:13+02:00 kaber@coreworks.de +8 -6
#   [PKT_SCHED]: Fix class leak in CBQ scheduler
# 
diff -Nru a/net/sched/sch_cbq.c b/net/sched/sch_cbq.c
--- a/net/sched/sch_cbq.c	2004-08-22 14:33:59 +02:00
+++ b/net/sched/sch_cbq.c	2004-08-22 14:33:59 +02:00
@@ -1746,15 +1746,18 @@
 	}
 }
 
-static void cbq_destroy_class(struct cbq_class *cl)
+static void cbq_destroy_class(struct Qdisc *sch, struct cbq_class *cl)
 {
+	struct cbq_sched_data *q = qdisc_priv(sch);
+
 	cbq_destroy_filters(cl);
 	qdisc_destroy(cl->q);
 	qdisc_put_rtab(cl->R_tab);
 #ifdef CONFIG_NET_ESTIMATOR
 	qdisc_kill_estimator(&cl->stats);
 #endif
-	kfree(cl);
+	if (cl != &q->link)
+		kfree(cl);
 }
 
 static void
@@ -1777,8 +1780,7 @@
 
 		for (cl = q->classes[h]; cl; cl = next) {
 			next = cl->next;
-			if (cl != &q->link)
-				cbq_destroy_class(cl);
+			cbq_destroy_class(sch, cl);
 		}
 	}
 
@@ -1799,7 +1801,7 @@
 		spin_unlock_bh(&sch->dev->queue_lock);
 #endif
 
-		cbq_destroy_class(cl);
+		cbq_destroy_class(sch, cl);
 	}
 }
 
@@ -2035,7 +2037,7 @@
 	sch_tree_unlock(sch);
 
 	if (--cl->refcnt == 0)
-		cbq_destroy_class(cl);
+		cbq_destroy_class(sch, cl);
 
 	return 0;
 }

--------------040809050802040307090201--
