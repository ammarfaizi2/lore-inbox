Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbTADQOe>; Sat, 4 Jan 2003 11:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbTADQOe>; Sat, 4 Jan 2003 11:14:34 -0500
Received: from mail-8.tiscali.it ([195.130.225.154]:18294 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S266969AbTADQOT>;
	Sat, 4 Jan 2003 11:14:19 -0500
Date: Sat, 4 Jan 2003 17:21:53 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>
Subject: Re: [RFC] Migrating net/sched to new module interface
Message-ID: <20030104162153.GA501@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <1041583024.8648.11.camel@rth.ninka.net> <20030104062027.90D922C37B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030104062027.90D922C37B@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Jan 04, 2003 at 05:09:41PM +1100, Rusty Russell ha scritto: 
> Then the patch to mark the "owner" should be straightforward.

Yes, it seems so :)

This is the patch:

diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/cls_api.c linux-2.5/net/sched/cls_api.c
--- linux-2.5.orig/net/sched/cls_api.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/cls_api.c	Fri Jan  3 17:19:07 2003
@@ -216,6 +216,13 @@
 			kfree(tp);
 			goto errout;
 		}
+
+		if (try_module_get(tp_ops->owner) == 0) {
+			err = -ENOSYS;
+			kfree(tp);
+			goto errout;
+		}
+		
 		memset(tp, 0, sizeof(*tp));
 		tp->ops = tp_ops;
 		tp->protocol = protocol;
@@ -225,6 +232,7 @@
 		tp->classid = parent;
 		err = tp_ops->init(tp);
 		if (err) {
+			module_put(tp_ops->owner);
 			kfree(tp);
 			goto errout;
 		}
@@ -248,6 +256,7 @@
 			write_unlock(&qdisc_tree_lock);
 
 			tp->ops->destroy(tp);
+			module_put(tp->ops->owner);
 			kfree(tp);
 			err = 0;
 			goto errout;
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/cls_fw.c linux-2.5/net/sched/cls_fw.c
--- linux-2.5.orig/net/sched/cls_fw.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/cls_fw.c	Sat Jan  4 16:49:11 2003
@@ -117,7 +117,6 @@
 
 static int fw_init(struct tcf_proto *tp)
 {
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -128,7 +127,6 @@
 	int h;
 
 	if (head == NULL) {
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 
@@ -146,7 +144,6 @@
 		}
 	}
 	kfree(head);
-	MOD_DEC_USE_COUNT;
 }
 
 static int fw_delete(struct tcf_proto *tp, unsigned long arg)
@@ -351,18 +348,21 @@
 }
 
 struct tcf_proto_ops cls_fw_ops = {
-	NULL,
-	"fw",
-	fw_classify,
-	fw_init,
-	fw_destroy,
-
-	fw_get,
-	fw_put,
-	fw_change,
-	fw_delete,
-	fw_walk,
-	fw_dump
+	.next		= NULL,
+	.kind		= "fw",
+	.classify	= fw_classify,
+	.init		= fw_init,
+	.destroy	= fw_destroy,
+
+	.get		= fw_get,
+	.put		= fw_put,
+	.change		= fw_change,
+	.delete		= fw_delete,
+	.walk		= fw_walk,
+
+	.dump 		= fw_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/cls_route.c linux-2.5/net/sched/cls_route.c
--- linux-2.5.orig/net/sched/cls_route.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/cls_route.c	Sat Jan  4 16:47:29 2003
@@ -272,7 +272,6 @@
 
 static int route4_init(struct tcf_proto *tp)
 {
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -282,7 +281,6 @@
 	int h1, h2;
 
 	if (head == NULL) {
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 
@@ -309,7 +307,6 @@
 		}
 	}
 	kfree(head);
-	MOD_DEC_USE_COUNT;
 }
 
 static int route4_delete(struct tcf_proto *tp, unsigned long arg)
@@ -607,18 +604,21 @@
 }
 
 struct tcf_proto_ops cls_route4_ops = {
-	NULL,
-	"route",
-	route4_classify,
-	route4_init,
-	route4_destroy,
-
-	route4_get,
-	route4_put,
-	route4_change,
-	route4_delete,
-	route4_walk,
-	route4_dump
+	.next		= NULL,
+	.kind		= "route",
+	.classify	= route4_classify,
+	.init		= route4_init,
+	.destroy	= route4_destroy,
+
+	.get		= route4_get,
+	.put		= route4_put,
+	.change		= route4_change,
+	.delete		= route4_delete,
+	.walk		= route4_walk,
+
+	.dump		= route4_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/cls_rsvp.h linux-2.5/net/sched/cls_rsvp.h
--- linux-2.5.orig/net/sched/cls_rsvp.h	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/cls_rsvp.h	Sat Jan  4 16:49:56 2003
@@ -247,14 +247,12 @@
 {
 	struct rsvp_head *data;
 
-	MOD_INC_USE_COUNT;
 	data = kmalloc(sizeof(struct rsvp_head), GFP_KERNEL);
 	if (data) {
 		memset(data, 0, sizeof(struct rsvp_head));
 		tp->root = data;
 		return 0;
 	}
-	MOD_DEC_USE_COUNT;
 	return -ENOBUFS;
 }
 
@@ -294,7 +292,6 @@
 		}
 	}
 	kfree(data);
-	MOD_DEC_USE_COUNT;
 }
 
 static int rsvp_delete(struct tcf_proto *tp, unsigned long arg)
@@ -673,18 +670,21 @@
 }
 
 struct tcf_proto_ops RSVP_OPS = {
-	NULL,
-	RSVP_ID,
-	rsvp_classify,
-	rsvp_init,
-	rsvp_destroy,
-
-	rsvp_get,
-	rsvp_put,
-	rsvp_change,
-	rsvp_delete,
-	rsvp_walk,
-	rsvp_dump
+	.next		= NULL,
+	.kind		= RSVP_ID,
+	.classify	= rsvp_classify,
+	.init		= rsvp_init,
+	.destroy	= rsvp_destroy,
+
+	.get		= rsvp_get,
+	.put		= rsvp_put,
+	.change		= rsvp_change,
+	.delete		= rsvp_delete,
+	.walk		= rsvp_walk,
+
+	.dump		= rsvp_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/cls_tcindex.c linux-2.5/net/sched/cls_tcindex.c
--- linux-2.5.orig/net/sched/cls_tcindex.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/cls_tcindex.c	Sat Jan  4 16:50:21 2003
@@ -144,10 +144,8 @@
 	struct tcindex_data *p;
 
 	DPRINTK("tcindex_init(tp %p)\n",tp);
-	MOD_INC_USE_COUNT;
 	p = kmalloc(sizeof(struct tcindex_data),GFP_KERNEL);
 	if (!p) {
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 	tp->root = p;
@@ -417,7 +415,6 @@
 		kfree(p->h);
 	kfree(p);
 	tp->root = NULL;
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -480,20 +477,22 @@
 }
 
 struct tcf_proto_ops cls_tcindex_ops = {
-	NULL,
-	"tcindex",
-	tcindex_classify,
-	tcindex_init,
-	tcindex_destroy,
-
-	tcindex_get,
-	tcindex_put,
-	tcindex_change,
-	tcindex_delete,
-	tcindex_walk,
-	tcindex_dump
-};
+	.next		= NULL,
+	.kind		= "tcindex",
+	.classify	= tcindex_classify,
+	.init		= tcindex_init,
+	.destroy	= tcindex_destroy,
+
+	.get		= tcindex_get,
+	.put		= tcindex_put,
+	.change		= tcindex_change,
+	.delete		= tcindex_delete,
+	.walk		= tcindex_walk,
+
+	.dump		= tcindex_dump,
 
+	.owner		= THIS_MODULE,
+};
 
 #ifdef MODULE
 int init_module(void)
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/cls_u32.c linux-2.5/net/sched/cls_u32.c
--- linux-2.5.orig/net/sched/cls_u32.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/cls_u32.c	Sat Jan  4 16:50:39 2003
@@ -262,15 +262,12 @@
 	struct tc_u_hnode *root_ht;
 	struct tc_u_common *tp_c;
 
-	MOD_INC_USE_COUNT;
-
 	for (tp_c = u32_list; tp_c; tp_c = tp_c->next)
 		if (tp_c->q == tp->q)
 			break;
 
 	root_ht = kmalloc(sizeof(*root_ht), GFP_KERNEL);
 	if (root_ht == NULL) {
-		MOD_DEC_USE_COUNT;
 		return -ENOBUFS;
 	}
 	memset(root_ht, 0, sizeof(*root_ht));
@@ -282,7 +279,6 @@
 		tp_c = kmalloc(sizeof(*tp_c), GFP_KERNEL);
 		if (tp_c == NULL) {
 			kfree(root_ht);
-			MOD_DEC_USE_COUNT;
 			return -ENOBUFS;
 		}
 		memset(tp_c, 0, sizeof(*tp_c));
@@ -407,7 +403,6 @@
 		kfree(tp_c);
 	}
 
-	MOD_DEC_USE_COUNT;
 	tp->data = NULL;
 }
 
@@ -695,18 +690,21 @@
 }
 
 struct tcf_proto_ops cls_u32_ops = {
-	NULL,
-	"u32",
-	u32_classify,
-	u32_init,
-	u32_destroy,
-
-	u32_get,
-	u32_put,
-	u32_change,
-	u32_delete,
-	u32_walk,
-	u32_dump
+	.next		= NULL,
+	.kind		= "u32",
+	.classify	= u32_classify,
+	.init		= u32_init,
+	.destroy 	= u32_destroy,
+
+	.get		= u32_get,
+	.put		= u32_put,
+	.change		= u32_change,
+	.delete		= u32_delete,
+	.walk		= u32_walk,
+
+	.dump		= u32_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_api.c linux-2.5/net/sched/sch_api.c
--- linux-2.5.orig/net/sched/sch_api.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/sch_api.c	Sat Jan  4 16:53:23 2003
@@ -409,6 +409,10 @@
 	if (ops == NULL)
 		goto err_out;
 
+	err = -ENOSYS;
+	if (try_module_get(ops->owner) == 0)
+		goto err_module;
+
 	size = sizeof(*sch) + ops->priv_size;
 
 	sch = kmalloc(size, GFP_KERNEL);
@@ -416,12 +420,6 @@
 	if (!sch)
 		goto err_out;
 
-	/* Grrr... Resolve race condition with module unload */
-
-	err = -EINVAL;
-	if (ops != qdisc_lookup_ops(kind))
-		goto err_out;
-
 	memset(sch, 0, size);
 
 	skb_queue_head_init(&sch->q);
@@ -460,6 +458,8 @@
 	}
 
 err_out:
+	module_put(ops->owner);
+err_module:
 	*errp = err;
 	if (sch)
 		kfree(sch);
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_atm.c linux-2.5/net/sched/sch_atm.c
--- linux-2.5.orig/net/sched/sch_atm.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/sch_atm.c	Sat Jan  4 16:51:24 2003
@@ -575,7 +575,6 @@
 	p->link.ref = 1;
 	p->link.next = NULL;
 	tasklet_init(&p->task,sch_atm_dequeue,(unsigned long) sch);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -612,7 +611,6 @@
 		}
 	}
 	tasklet_kill(&p->task);
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -697,9 +695,10 @@
 	.destroy	= atm_tc_destroy,
 	.change		= NULL,
 
-	.dump		= atm_tc_dump
-};
+	.dump		= atm_tc_dump,
 
+	.owner		= THIS_MODULE,
+};
 
 #ifdef MODULE
 int init_module(void)
@@ -707,9 +706,10 @@
 	return register_qdisc(&atm_qdisc_ops);
 }
 
-
 void cleanup_module(void) 
 {
 	unregister_qdisc(&atm_qdisc_ops);
 }
 #endif
+
+MODULE_LICENSE("GPL");
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_cbq.c linux-2.5/net/sched/sch_cbq.c
--- linux-2.5.orig/net/sched/sch_cbq.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/sch_cbq.c	Sat Jan  4 16:51:30 2003
@@ -1411,9 +1411,7 @@
 
 	r = RTA_DATA(tb[TCA_CBQ_RATE-1]);
 
-	MOD_INC_USE_COUNT;
 	if ((q->link.R_tab = qdisc_get_rtab(r, tb[TCA_CBQ_RTAB-1])) == NULL) {
-		MOD_DEC_USE_COUNT;
 		return -EINVAL;
 	}
 
@@ -1749,7 +1747,6 @@
 	}
 
 	qdisc_put_rtab(q->link.R_tab);
-	MOD_DEC_USE_COUNT;
 }
 
 static void cbq_put(struct Qdisc *sch, unsigned long arg)
@@ -2099,6 +2096,8 @@
 	.change		= NULL,
 
 	.dump		= cbq_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_csz.c linux-2.5/net/sched/sch_csz.c
--- linux-2.5.orig/net/sched/sch_csz.c	Sat Jan  4 16:38:50 2003
+++ linux-2.5/net/sched/sch_csz.c	Sat Jan  4 16:53:35 2003
@@ -749,7 +749,7 @@
 static void
 csz_destroy(struct Qdisc* sch)
 {
-	MOD_DEC_USE_COUNT;
+	/* nop */
 }
 
 static int csz_init(struct Qdisc *sch, struct rtattr *opt)
@@ -791,7 +791,6 @@
 	q->wd_timer.data = (unsigned long)sch;
 	q->wd_timer.function = csz_watchdog;
 #endif
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -1046,8 +1045,9 @@
 	.change		= NULL,
 
 	.dump		= csz_dump,
-};
 
+	.owner		= THIS_MODULE,
+};
 
 #ifdef MODULE
 int init_module(void)
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_dsmark.c linux-2.5/net/sched/sch_dsmark.c
--- linux-2.5.orig/net/sched/sch_dsmark.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_dsmark.c	Sat Jan  4 16:51:43 2003
@@ -352,7 +352,6 @@
 	if (!(p->q = qdisc_create_dflt(sch->dev, &pfifo_qdisc_ops)))
 		p->q = &noop_qdisc;
 	DPRINTK("dsmark_init: qdisc %p\n",&p->q);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -381,7 +380,6 @@
 	qdisc_destroy(p->q);
 	p->q = &noop_qdisc;
 	kfree(p->mask);
-	MOD_DEC_USE_COUNT;
 }
 
 
@@ -466,7 +464,9 @@
 	.destroy	= dsmark_destroy,
 	.change		= NULL,
 
-	.dump		= dsmark_dump
+	.dump		= dsmark_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
@@ -474,7 +474,6 @@
 {
 	return register_qdisc(&dsmark_qdisc_ops);
 }
-
 
 void cleanup_module(void) 
 {
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_fifo.c linux-2.5/net/sched/sch_fifo.c
--- linux-2.5.orig/net/sched/sch_fifo.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_fifo.c	Sat Jan  4 16:14:50 2003
@@ -206,4 +206,6 @@
 	.change		= fifo_init,
 
 	.dump		= fifo_dump,
+
+	.owner		= THIS_MODULE,
 };
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_generic.c linux-2.5/net/sched/sch_generic.c
--- linux-2.5.orig/net/sched/sch_generic.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_generic.c	Sat Jan  4 16:54:10 2003
@@ -29,6 +29,7 @@
 #include <linux/skbuff.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
 
@@ -253,6 +254,8 @@
 	.enqueue	= noop_enqueue,
 	.dequeue	= noop_dequeue,
 	.requeue	= noop_requeue,
+
+	.owner		= THIS_MODULE,
 };
 
 struct Qdisc noqueue_qdisc =
@@ -356,6 +359,8 @@
 
 	.init		= pfifo_fast_init,
 	.reset		= pfifo_fast_reset,
+	
+	.owner		= THIS_MODULE,
 };
 
 struct Qdisc * qdisc_create_dflt(struct net_device *dev, struct Qdisc_ops *ops)
@@ -422,6 +427,7 @@
 		ops->reset(qdisc);
 	if (ops->destroy)
 		ops->destroy(qdisc);
+	module_put(ops->owner);
 	if (!(qdisc->flags&TCQ_F_BUILTIN))
 		kfree(qdisc);
 }
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_gred.c linux-2.5/net/sched/sch_gred.c
--- linux-2.5.orig/net/sched/sch_gred.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_gred.c	Sat Jan  4 16:51:58 2003
@@ -348,7 +348,6 @@
 		table->grio=sopt->grio; 
 		table->initd=0;
 		/* probably need to clear all the table DP entries as well */
-		MOD_INC_USE_COUNT;
 		return 0;
 	    }
 
@@ -490,7 +489,6 @@
 		table->def=sopt->def_DP; 
 		table->grio=sopt->grio; 
 		table->initd=0;
-		MOD_INC_USE_COUNT;
 		return 0;
 	}
 
@@ -602,7 +600,6 @@
 		if (table->tab[i])
 			kfree(table->tab[i]);
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 struct Qdisc_ops gred_qdisc_ops =
@@ -623,8 +620,9 @@
 	.change		= gred_change,
 
 	.dump		= gred_dump,
+	
+	.owner		= THIS_MODULE,
 };
-
 
 #ifdef MODULE
 int init_module(void)
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_htb.c linux-2.5/net/sched/sch_htb.c
--- linux-2.5.orig/net/sched/sch_htb.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_htb.c	Sat Jan  4 16:55:04 2003
@@ -1181,7 +1181,6 @@
 		q->rate2quantum = 1;
 	q->defcls = gopt->defcls;
 
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -1366,7 +1365,6 @@
 
 	htb_destroy_filters(&q->filter_list);
 	__skb_queue_purge(&q->direct_queue);
-	MOD_DEC_USE_COUNT;
 }
 
 static int htb_delete(struct Qdisc *sch, unsigned long arg)
@@ -1600,39 +1598,41 @@
 
 static struct Qdisc_class_ops htb_class_ops =
 {
-    htb_graft,
-    htb_leaf,
-    htb_get,
-    htb_put,
-    htb_change_class,
-    htb_delete,
-    htb_walk,
-
-    htb_find_tcf,
-    htb_bind_filter,
-    htb_unbind_filter,
+	.graft		= htb_graft,
+	.leaf		= htb_leaf,
+	.get		= htb_get,
+	.put		= htb_put,
+	.change		= htb_change_class,
+	.delete		= htb_delete,
+	.walk		= htb_walk,
+
+	.tcf_chain	= htb_find_tcf,
+	.bind_tcf	= htb_bind_filter,
+	.unbind_tcf	= htb_unbind_filter,
 
-    htb_dump_class,
+	.dump		= htb_dump_class,
 };
 
 struct Qdisc_ops htb_qdisc_ops =
 {
-    NULL,
-    &htb_class_ops,
-    "htb",
-    sizeof(struct htb_sched),
-
-    htb_enqueue,
-    htb_dequeue,
-    htb_requeue,
-    htb_drop,
-
-    htb_init,
-    htb_reset,
-    htb_destroy,
-    NULL /* htb_change */,
+	.next 		= NULL,
+	.cl_ops 	= &htb_class_ops,
+	.id		= "htb",
+	.priv_size	= sizeof(struct htb_sched),
+
+	.enqueue	= htb_enqueue,
+	.dequeue	= htb_dequeue,
+	.requeue	= htb_requeue,
+	.drop		= htb_drop,
+
+	.init		= htb_init,
+	.reset		= htb_reset,
+	.destroy	= htb_destroy,
+	.change		= NULL,
 
-    htb_dump,
+	.dump		= htb_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_ingress.c linux-2.5/net/sched/sch_ingress.c
--- linux-2.5.orig/net/sched/sch_ingress.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_ingress.c	Sat Jan  4 16:52:49 2003
@@ -257,7 +257,6 @@
 	memset(p, 0, sizeof(*p));
 	p->filter_list = NULL;
 	p->q = &noop_qdisc;
-	MOD_INC_USE_COUNT;
 	return 0;
 error:
 	return -EINVAL;
@@ -304,8 +303,6 @@
 	qdisc_destroy(p->q);
 #endif
  
-	MOD_DEC_USE_COUNT;
-
 }
 
 
@@ -359,22 +356,20 @@
 	.change		= NULL,
 
 	.dump		= ingress_dump,
-};
 
+	.owner		= THIS_MODULE,
+};
 
 #ifdef MODULE
 int init_module(void)
 {
 	int ret = 0;
 
-	if ((ret = register_qdisc(&ingress_qdisc_ops)) < 0) {
-		printk("Unable to register Ingress qdisc\n");
-		return ret;
-	}
+	if ((ret = register_qdisc(&ingress_qdisc_ops)) < 0)
+		printk(KERN_ERR "Unable to register Ingress qdisc\n");
 
 	return ret;
 }
-
 
 void cleanup_module(void) 
 {
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_prio.c linux-2.5/net/sched/sch_prio.c
--- linux-2.5.orig/net/sched/sch_prio.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_prio.c	Sat Jan  4 16:52:53 2003
@@ -163,7 +163,6 @@
 		qdisc_destroy(q->queues[prio]);
 		q->queues[prio] = &noop_qdisc;
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 static int prio_tune(struct Qdisc *sch, struct rtattr *opt)
@@ -227,7 +226,6 @@
 		if ((err= prio_tune(sch, opt)) != 0)
 			return err;
 	}
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -399,10 +397,11 @@
 	.change		= prio_tune,
 
 	.dump		= prio_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
-
 int init_module(void)
 {
 	return register_qdisc(&prio_qdisc_ops);
@@ -412,6 +411,5 @@
 {
 	unregister_qdisc(&prio_qdisc_ops);
 }
-
 #endif
 MODULE_LICENSE("GPL");
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_red.c linux-2.5/net/sched/sch_red.c
--- linux-2.5.orig/net/sched/sch_red.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_red.c	Sat Jan  4 16:52:57 2003
@@ -407,14 +407,7 @@
 
 static int red_init(struct Qdisc* sch, struct rtattr *opt)
 {
-	int err;
-
-	MOD_INC_USE_COUNT;
-
-	if ((err = red_change(sch, opt)) != 0) {
-		MOD_DEC_USE_COUNT;
-	}
-	return err;
+	return red_change(sch, opt);
 }
 
 
@@ -458,7 +451,7 @@
 
 static void red_destroy(struct Qdisc *sch)
 {
-	MOD_DEC_USE_COUNT;
+	/* nop */
 }
 
 struct Qdisc_ops red_qdisc_ops =
@@ -479,8 +472,9 @@
 	.change		= red_change,
 
 	.dump		= red_dump,
-};
 
+	.owner		= THIS_MODULE,
+};
 
 #ifdef MODULE
 int init_module(void)
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_sfq.c linux-2.5/net/sched/sch_sfq.c
--- linux-2.5.orig/net/sched/sch_sfq.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_sfq.c	Sat Jan  4 16:53:02 2003
@@ -435,7 +435,6 @@
 	}
 	for (i=0; i<SFQ_DEPTH; i++)
 		sfq_link(q, i);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -443,7 +442,6 @@
 {
 	struct sfq_sched_data *q = (struct sfq_sched_data *)sch->data;
 	del_timer(&q->perturb_timer);
-	MOD_DEC_USE_COUNT;
 }
 
 static int sfq_dump(struct Qdisc *sch, struct sk_buff *skb)
@@ -486,6 +484,8 @@
 	.change		= NULL,
 
 	.dump		= sfq_dump,
+
+	.owner		= THIS_MODULE,
 };
 
 #ifdef MODULE
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_tbf.c linux-2.5/net/sched/sch_tbf.c
--- linux-2.5.orig/net/sched/sch_tbf.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_tbf.c	Sat Jan  4 16:53:06 2003
@@ -330,23 +330,17 @@
 
 static int tbf_init(struct Qdisc* sch, struct rtattr *opt)
 {
-	int err;
 	struct tbf_sched_data *q = (struct tbf_sched_data *)sch->data;
 	
 	if (opt == NULL)
 		return -EINVAL;
 	
-	MOD_INC_USE_COUNT;
-	
 	PSCHED_GET_TIME(q->t_c);
 	init_timer(&q->wd_timer);
 	q->wd_timer.function = tbf_watchdog;
 	q->wd_timer.data = (unsigned long)sch;
 	
-	if ((err = tbf_change(sch, opt)) != 0) {
-		MOD_DEC_USE_COUNT;
-	}
-	return err;
+	return tbf_change(sch, opt); 
 }
 
 static void tbf_destroy(struct Qdisc *sch)
@@ -359,8 +353,6 @@
 		qdisc_put_rtab(q->P_tab);
 	if (q->R_tab)
 		qdisc_put_rtab(q->R_tab);
-
-	MOD_DEC_USE_COUNT;
 }
 
 static int tbf_dump(struct Qdisc *sch, struct sk_buff *skb)
@@ -409,8 +401,9 @@
 	.change		= tbf_change,
 
 	.dump		= tbf_dump,
-};
 
+	.owner		= THIS_MODULE,
+};
 
 #ifdef MODULE
 int init_module(void)
diff --exclude-from=diff.exclude -ru linux-2.5.orig/net/sched/sch_teql.c linux-2.5/net/sched/sch_teql.c
--- linux-2.5.orig/net/sched/sch_teql.c	Sat Jan  4 16:38:51 2003
+++ linux-2.5/net/sched/sch_teql.c	Sat Jan  4 16:34:52 2003
@@ -178,7 +178,6 @@
 		} while ((prev = q) != master->slaves);
 	}
 
-	MOD_DEC_USE_COUNT;
 }
 
 static int teql_qdisc_init(struct Qdisc *sch, struct rtattr *opt)
@@ -223,7 +222,6 @@
 		m->dev.flags = (m->dev.flags&~FMASK)|(dev->flags&FMASK);
 	}
 	
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -454,8 +452,9 @@
 	.reset		= teql_reset,
 	.destroy	= teql_destroy,
 	.dump		= NULL,
-},};
 
+	.owner		= THIS_MODULE,
+},};
 
 #ifdef MODULE
 int init_module(void)
diff --exclude-from=diff.exclude -ru linux-2.5.orig/include/net/pkt_cls.h linux-2.5/include/net/pkt_cls.h
--- linux-2.5.orig/include/net/pkt_cls.h	Sat Jan  4 16:38:51 2003
+++ linux-2.5/include/net/pkt_cls.h	Fri Jan  3 17:20:03 2003
@@ -3,6 +3,7 @@
 
 
 #include <linux/pkt_cls.h>
+#include <linux/module.h>
 
 struct rtattr;
 struct tcmsg;
@@ -56,6 +57,8 @@
 
 	/* rtnetlink specific */
 	int			(*dump)(struct tcf_proto*, unsigned long, struct sk_buff *skb, struct tcmsg*);
+
+	struct module		*owner;
 };
 
 /* Main classifier routine: scans classifier chain attached
diff --exclude-from=diff.exclude -ru linux-2.5.orig/include/net/pkt_sched.h linux-2.5/include/net/pkt_sched.h
--- linux-2.5.orig/include/net/pkt_sched.h	Sat Jan  4 16:38:51 2003
+++ linux-2.5/include/net/pkt_sched.h	Thu Jan  2 22:50:57 2003
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/pkt_sched.h>
+#include <linux/module.h>
 #include <net/pkt_cls.h>
 
 #ifdef CONFIG_X86_TSC
@@ -67,6 +68,8 @@
 	int			(*change)(struct Qdisc *, struct rtattr *arg);
 
 	int			(*dump)(struct Qdisc *, struct sk_buff *);
+	/* Protects callbacks */
+	struct module 		*owner;
 };
 
 extern rwlock_t qdisc_tree_lock;


I've  tested  it   a  bit  and  seems  to  work   ok. TEQL  queue  still
uses   MOD_{INC,DEC}_USE_COUNT  because   it  register   a  device   and
register_netdevice doesn't use the new interface yet.

ciao,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
The trouble with computers is that they do what you tell them, 
not what you want.
D. Cohen
