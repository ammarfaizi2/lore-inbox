Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266817AbUHOQMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266817AbUHOQMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 12:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUHOQMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 12:12:13 -0400
Received: from legaleagle.de ([217.160.128.82]:18628 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S266817AbUHOQMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 12:12:03 -0400
Message-ID: <411F8B50.2020402@trash.net>
Date: Sun, 15 Aug 2004 18:12:00 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: lkml@lazy.shacknet.nu
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [Panic] 2.6.8 and ingress scheduling
References: <20040814175233.GA3617@lazy.shacknet.nu> <20040815130635.GA3703@lazy.shacknet.nu>
In-Reply-To: <20040815130635.GA3703@lazy.shacknet.nu>
Content-Type: multipart/mixed;
 boundary="------------030503090501060902070806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503090501060902070806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

lkml@lazy.shacknet.nu wrote:

>hello again,
>
>  
>
>>the last line (filter add) in the "wondershaper" script does sth. to the
>>kernel, that lets it panic on receiving network packets.
>>    
>>
>
>actually, the last _two_ commands set up the kernel for panic. please
>see attached script; running should produce this console message:
>  
>
Fixed by this patch. qdisc_data was only aligned correctly in 
qdisc_create_dflt(),
not qdisc_create() which resulted in memory corruption.

Regards
Patrick

--------------030503090501060902070806
Content-Type: text/x-patch;
 name="qdisc-align.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qdisc-align.diff"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/15 18:08:13+02:00 kaber@coreworks.de 
#   [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/sched/sch_api.c
#   2004/08/15 18:04:27+02:00 kaber@coreworks.de +13 -8
#   [PKT_SCHED]: cacheline-align qdisc data in qdisc_create()
# 
diff -Nru a/net/sched/sch_api.c b/net/sched/sch_api.c
--- a/net/sched/sch_api.c	2004-08-15 18:09:36 +02:00
+++ b/net/sched/sch_api.c	2004-08-15 18:09:36 +02:00
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
 

--------------030503090501060902070806--
