Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267464AbUHPGrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267464AbUHPGrq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUHPGrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:47:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64461 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267464AbUHPGrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:47:39 -0400
Date: Sun, 15 Aug 2004 23:45:28 -0700
From: "David S. Miller" <davem@redhat.com>
To: Daniel Fraga <fraga@abusar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.6.8.1 QoS and routing conflict (bug)
Message-Id: <20040815234528.66eba1c4.davem@redhat.com>
In-Reply-To: <XFMail.20040816033530.fraga@abusar.org>
References: <XFMail.20040816033530.fraga@abusar.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix already posted, included below for your convenience:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 19:33:16-07:00 kaber@trash.net 
#   [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
# net/sched/sch_api.c
#   2004/08/15 19:32:59-07:00 kaber@trash.net +13 -8
#   [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
#   Signed-off-by: David S. Miller <davem@redhat.com>
# 
diff -Nru a/net/sched/sch_api.c b/net/sched/sch_api.c
--- a/net/sched/sch_api.c	2004-08-15 23:32:37 -07:00
+++ b/net/sched/sch_api.c	2004-08-15 23:32:37 -07:00
@@ -389,7 +389,8 @@
 {
 	int err;
 	struct rtattr *kind = tca[TCA_KIND-1];
-	struct Qdisc *sch = NULL;
+	void *p = NULL;
+	struct Qdisc *sch;
 	struct Qdisc_ops *ops;
 	int size;
 
@@ -407,12 +408,18 @@
 	if (ops == NULL)
 		goto err_out;
 
-	size = sizeof(*sch) + ops->priv_size;
+	/* ensure that the Qdisc and the private data are 32-byte aligned */
+	size = ((sizeof(*sch) + QDISC_ALIGN_CONST) & ~QDISC_ALIGN_CONST);
+	size += ops->priv_size + QDISC_ALIGN_CONST;
 
-	sch = kmalloc(size, GFP_KERNEL);
+	p = kmalloc(size, GFP_KERNEL);
 	err = -ENOBUFS;
-	if (!sch)
+	if (!p)
 		goto err_out;
+	memset(p, 0, size);
+	sch = (struct Qdisc *)(((unsigned long)p + QDISC_ALIGN_CONST)
+	                       & ~QDISC_ALIGN_CONST);
+	sch->padded = (char *)sch - (char *)p;
 
 	/* Grrr... Resolve race condition with module unload */
 
@@ -420,8 +427,6 @@
 	if (ops != qdisc_lookup_ops(kind))
 		goto err_out;
 
-	memset(sch, 0, size);
-
 	INIT_LIST_HEAD(&sch->list);
 	skb_queue_head_init(&sch->q);
 
@@ -470,8 +475,8 @@
 
 err_out:
 	*errp = err;
-	if (sch)
-		kfree(sch);
+	if (p)
+		kfree(p);
 	return NULL;
 }
 
