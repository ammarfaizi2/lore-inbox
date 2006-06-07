Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWFGWI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWFGWI0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWFGWI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:08:26 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:13444 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932434AbWFGWIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:08:25 -0400
Date: Thu, 8 Jun 2006 00:07:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060607220704.GA6287@elte.hu>
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060607232345.3fcad56e@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060607232345.3fcad56e@werewolf.auna.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* J.A. Magallón <jamagallon@ono.com> wrote:

> > - Many more lockdep updates
> 
> One missing ;)

ok, could you try the annotation patch below? ieee1394 uses skb-queues 
in a nontraditional way which collides with the customal skb-queue 
locking observed by the lock validator in the networking code. So i've 
split the affected ieee1394 skb-queue's lock type from the networking 
lock type. This way the validator will still fully validate the ieee1394 
locking rules, but separates them from the other skb-queue rules.

	Ingo

----------
Subject: lock validator: annotate ieee1394 skb-head locking
From: Ingo Molnar <mingo@elte.hu>

ieee1394 reuses the skb infrastructure of the networking code,
and uses two skb-head queues: ->pending_packet_queue and
hpsbpkt_queue. The latter is used in the usual fashion: processed
from a kernel thread. The other one, ->pending_packet_queue is also
processed from hardirq context (f.e. in hpsb_bus_reset()), which is
not what the networking code usually does (which completes from
softirq or process context). This locking assymetry can be totally
correct if done carefully, but it can also be dangerous if
networking helper functions are reused, which could assume
traditional networking use.

It would probably be more robust to push this completion into
a workqueue - but technically the code can be 100% correct, and
lockdep has to be taught about it. The solution is to split the
->pending_packet_queue skb-head->lock type from the networking
lock-type by using a private lock-validator key.

This way the validator will still fully validate the ieee1394 locking 
rules, but separates them from the other skb-queue rules.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/ieee1394/hosts.c |   11 ++++++++++-
 include/linux/skbuff.h   |    3 +++
 net/core/skbuff.c        |   13 +++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

Index: linux/drivers/ieee1394/hosts.c
===================================================================
--- linux.orig/drivers/ieee1394/hosts.c
+++ linux/drivers/ieee1394/hosts.c
@@ -108,6 +108,14 @@ static int alloc_hostnum_cb(struct hpsb_
  */
 static DEFINE_MUTEX(host_num_alloc);
 
+/*
+ * The pending_packet_queue is special in that it's processed
+ * from hardirq context too (such as hpsb_bus_reset()). Hence
+ * split the lock type from the usual networking skb-head
+ * lock type by using a separate key for it:
+ */
+static struct lockdep_type_key pending_packet_queue_key;
+
 struct hpsb_host *hpsb_alloc_host(struct hpsb_host_driver *drv, size_t extra,
 				  struct device *dev)
 {
@@ -128,7 +136,8 @@ struct hpsb_host *hpsb_alloc_host(struct
 	h->hostdata = h + 1;
 	h->driver = drv;
 
-	skb_queue_head_init(&h->pending_packet_queue);
+	skb_queue_head_init_key(&h->pending_packet_queue,
+				&pending_packet_queue_key);
 	INIT_LIST_HEAD(&h->addr_space);
 
 	for (i = 2; i < 16; i++)
Index: linux/include/linux/skbuff.h
===================================================================
--- linux.orig/include/linux/skbuff.h
+++ linux/include/linux/skbuff.h
@@ -18,6 +18,7 @@
 #include <linux/compiler.h>
 #include <linux/time.h>
 #include <linux/cache.h>
+#include <linux/lockdep.h>
 
 #include <asm/atomic.h>
 #include <asm/types.h>
@@ -589,6 +590,8 @@ static inline __u32 skb_queue_len(const 
 }
 
 extern void skb_queue_head_init(struct sk_buff_head *list);
+extern void skb_queue_head_init_key(struct sk_buff_head *list,
+				    struct lockdep_type_key *key);
 
 /*
  *	Insert an sk_buff at the start of a list.
Index: linux/net/core/skbuff.c
===================================================================
--- linux.orig/net/core/skbuff.c
+++ linux/net/core/skbuff.c
@@ -80,6 +80,19 @@ void skb_queue_head_init(struct sk_buff_
 EXPORT_SYMBOL(skb_queue_head_init);
 
 /*
+ * Use this to initialize your skb-heads if you have special locking
+ * rules for skb queues and process them from say hardirq contexts:
+ */
+void skb_queue_head_init_key(struct sk_buff_head *list,
+			     struct lockdep_type_key *key)
+{
+	spin_lock_init_key(&list->lock, key);
+	list->prev = list->next = (struct sk_buff *)list;
+	list->qlen = 0;
+}
+EXPORT_SYMBOL(skb_queue_head_init_key);
+
+/*
  *	Keep out-of-line to prevent kernel bloat.
  *	__builtin_return_address is not used because it is not always
  *	reliable.
