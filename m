Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267345AbTABWmr>; Thu, 2 Jan 2003 17:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTABWmr>; Thu, 2 Jan 2003 17:42:47 -0500
Received: from mail-5.tiscali.it ([195.130.225.151]:42351 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S267345AbTABWmo>;
	Thu, 2 Jan 2003 17:42:44 -0500
Date: Thu, 2 Jan 2003 23:50:10 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru, rusty@rustcorp.com.au
Subject: [RFC] Migrating net/sched to new module interface
Message-ID: <20030102225010.GA1197@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm  working on  net/sched to  convert it  to new  module interface. I'm
going to add a new field  'owner' to struct Qdisc_ops. The init function
of  each module  registers the  callback  functions and  a reference  to
the  module  itself. When a  qdisc  is  created (qdisc_create)  I  check
try_module_get() to see  if I can use the  registered callback functions
and if I can't I return  -ENOSYS. When a qdisc is delete (qdisc_destroy)
I use module_put() to decrement  the refcount. The attacched patch shows
this preliminar work on sch_api.c sch_generic.c.

The   next   step  is   to   update   the  other   schedulers   removing
MOD_{INC,DEC}_USE_COUNT and adding the new 'owner' field.

This work  is based on my  (maybe poor) understanding on  the new module
system, so I'm waiting some feedback before going on.

diff --exclude=diff.exclude -ru linux-2.5.orig/include/net/pkt_sched.h linux-2.5/include/net/pkt_sched.h
--- linux-2.5.orig/include/net/pkt_sched.h	Sun Aug 11 22:07:18 2002
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
diff --exclude=diff.exclude -ru linux-2.5.orig/net/sched/sch_api.c linux-2.5/net/sched/sch_api.c
--- linux-2.5.orig/net/sched/sch_api.c	Thu Jan  2 21:55:40 2003
+++ linux-2.5/net/sched/sch_api.c	Thu Jan  2 22:59:26 2003
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
diff --exclude=diff.exclude -ru linux-2.5.orig/net/sched/sch_generic.c linux-2.5/net/sched/sch_generic.c
--- linux-2.5.orig/net/sched/sch_generic.c	Thu Jan  2 22:41:24 2003
+++ linux-2.5/net/sched/sch_generic.c	Thu Jan  2 23:07:55 2003
@@ -29,6 +29,7 @@
 #include <linux/skbuff.h>
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
 
@@ -356,6 +357,8 @@
 
 	.init		= pfifo_fast_init,
 	.reset		= pfifo_fast_reset,
+	
+	.owner		= THIS_MODULE,
 };
 
 struct Qdisc * qdisc_create_dflt(struct net_device *dev, struct Qdisc_ops *ops)
@@ -422,6 +425,7 @@
 		ops->reset(qdisc);
 	if (ops->destroy)
 		ops->destroy(qdisc);
+	module_put(ops->owner);
 	if (!(qdisc->flags&TCQ_F_BUILTIN))
 		kfree(qdisc);
 }


ciao,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Chi parla in tono cortese, ma continua a prepararsi, potra` andare avanti;
 chi parla in tono bellicoso e avanza rapidamente dovra` ritirarsi" 
Sun Tzu -- L'arte della guerra
