Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266397AbUHWSZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUHWSZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUHWSYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:24:45 -0400
Received: from legaleagle.de ([217.160.128.82]:13959 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S266397AbUHWSSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:18:53 -0400
Message-ID: <412A350B.4020607@trash.net>
Date: Mon, 23 Aug 2004 20:18:51 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Wohlstadter <rwohlsta@watson.wustl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8 + token buffer filter queue discipline causes kernel panic
References: <412A29D1.80909@watson.wustl.edu>
In-Reply-To: <412A29D1.80909@watson.wustl.edu>
Content-Type: multipart/mixed;
 boundary="------------010003040500000408060309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003040500000408060309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Richard Wohlstadter wrote:

> Hello,
>
> I have 2.6.8 running on my firewall which uses basic NAT masquerading 
> iptables rules.  I recently added a token buffer filter to limit my 
> outgoing bandwidth.  As soon as I add the tbf with the tc utility it 
> causes a kernel panic.  I backed down to the 2.6.7 kernel(latest 
> debian compiled) and the kernel panic does not occur.  Is this a known 
> issue with 2.6.8 or should I run the oops through ksymoops and further 
> debug the issue.  Thanks.


Already fixed, should be in -bk soon.

Regards
Patrick


--------------010003040500000408060309
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

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
--- a/net/sched/sch_api.c	2004-08-23 19:06:53 +02:00
+++ b/net/sched/sch_api.c	2004-08-23 19:06:53 +02:00
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
 

--------------010003040500000408060309--
