Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUHSOyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUHSOyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266378AbUHSOvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:51:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37780 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266347AbUHSOsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:48:31 -0400
Date: Thu, 19 Aug 2004 07:45:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: Laurent CARON <lcaron@apartia.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash using Kernel 2.8.1 and HTB
Message-Id: <20040819074504.4bbbde71.davem@redhat.com>
In-Reply-To: <41249570.20208@apartia.fr>
References: <41249570.20208@apartia.fr>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004 13:56:32 +0200
Laurent CARON <lcaron@apartia.fr> wrote:

> I'm experiencing a strange behavior with the HTB part of the 2.8.1 kernel.
> 
> My computer boots fine, but when I enable HTB (via Fiaif) the computer 
> hangs.
> 
> Did anyone get the same problem?

Yes, the fix has been posted a bunch of times to the lists.
Included below:

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
--- a/net/sched/sch_api.c	2004-08-19 07:33:10 -07:00
+++ b/net/sched/sch_api.c	2004-08-19 07:33:10 -07:00
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
 
