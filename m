Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVHCSgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVHCSgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVHCSfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:35:51 -0400
Received: from [62.206.217.67] ([62.206.217.67]:36841 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262416AbVHCSe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:34:57 -0400
Message-ID: <42F10E51.9000605@trash.net>
Date: Wed, 03 Aug 2005 20:34:57 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mattia Dongili <malattia@gmail.com>
CC: Harald Welte <laforge@netfilter.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: BUG: atomic counter underflow at ip_conntrack_event_cache_init+0x91/0xb0
 (with patch)
References: <20050801141327.GA3909@inferi.kami.home> <42EE3169.6070604@trash.net> <20050801160537.GA3850@inferi.kami.home> <42EE5721.1090509@trash.net> <42EEC2BB.3020105@trash.net> <20050802132922.GA3834@inferi.kami.home>
In-Reply-To: <20050802132922.GA3834@inferi.kami.home>
Content-Type: multipart/mixed;
 boundary="------------040705080805000509030305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705080805000509030305
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Mattia Dongili wrote:
> On Tue, Aug 02, 2005 at 02:47:55AM +0200, Patrick McHardy wrote:
> 
>>This should be a fist step towards fixing it. It's probably incomplete
>>(I'm too tired to check it now), but it should fix the problem you're
>>seeing. Could you give it a spin?
> 
> Done, also this patch fixes the uderflow problem.

Thanks. I've attached the final patch.


--------------040705080805000509030305
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: Fix multiple problems with the conntrack event cache

refcnt underflow: the reference count is decremented when a conntrack
entry is removed from the hash but it is not incremented when entering
new entries.

missing protection of process context against softirq context: all
cache operations need to locally disable softirqs to avoid races.
Additionally the event cache can't be initialized when a packet enteres
the conntrack code but needs to be initialized whenever we cache an event
and the stored conntrack entry doesn't match the current one.

incorrect flushing of the event cache in ip_ct_iterate_cleanup: without
real locking we can't flush the cache for different CPUs without incurring
races. The cache for different CPUs can only be flushed when no packets
are going through the code. ip_ct_iterate_cleanup doesn't need to drop
all references, so flushing is moved to the cleanup path.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit d20d18715b8425060334e879ebb4835202457b3e
tree 3279243f59162c14f8ac145473e1c3f4c586b2fa
parent df2e0392536ecdd6385f4319f746045fd6fae38f
author Patrick McHardy <kaber@trash.net> Wed, 03 Aug 2005 20:33:25 +0200
committer Patrick McHardy <kaber@trash.net> Wed, 03 Aug 2005 20:33:25 +0200

 include/linux/netfilter_ipv4/ip_conntrack.h      |   29 +++---
 include/linux/netfilter_ipv4/ip_conntrack_core.h |   14 +--
 net/ipv4/netfilter/ip_conntrack_core.c           |  107 ++++++++--------------
 net/ipv4/netfilter/ip_conntrack_standalone.c     |    3 -
 4 files changed, 58 insertions(+), 95 deletions(-)

diff --git a/include/linux/netfilter_ipv4/ip_conntrack.h b/include/linux/netfilter_ipv4/ip_conntrack.h
--- a/include/linux/netfilter_ipv4/ip_conntrack.h
+++ b/include/linux/netfilter_ipv4/ip_conntrack.h
@@ -411,6 +411,7 @@ struct ip_conntrack_stat
 
 #ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
 #include <linux/notifier.h>
+#include <linux/interrupt.h>
 
 struct ip_conntrack_ecache {
 	struct ip_conntrack *ct;
@@ -445,26 +446,24 @@ ip_conntrack_expect_unregister_notifier(
 	return notifier_chain_unregister(&ip_conntrack_expect_chain, nb);
 }
 
+extern void ip_ct_deliver_cached_events(const struct ip_conntrack *ct);
+extern void __ip_ct_event_cache_init(struct ip_conntrack *ct);
+
 static inline void 
 ip_conntrack_event_cache(enum ip_conntrack_events event,
 			 const struct sk_buff *skb)
 {
-	struct ip_conntrack_ecache *ecache = 
-					&__get_cpu_var(ip_conntrack_ecache);
-
-	if (unlikely((struct ip_conntrack *) skb->nfct != ecache->ct)) {
-		if (net_ratelimit()) {
-			printk(KERN_ERR "ctevent: skb->ct != ecache->ct !!!\n");
-			dump_stack();
-		}
-	}
+	struct ip_conntrack *ct = (struct ip_conntrack *)skb->nfct;
+	struct ip_conntrack_ecache *ecache;
+	
+	local_bh_disable();
+	ecache = &__get_cpu_var(ip_conntrack_ecache);
+	if (ct != ecache->ct)
+		__ip_ct_event_cache_init(ct);
 	ecache->events |= event;
+	local_bh_enable();
 }
 
-extern void 
-ip_conntrack_deliver_cached_events_for(const struct ip_conntrack *ct);
-extern void ip_conntrack_event_cache_init(const struct sk_buff *skb);
-
 static inline void ip_conntrack_event(enum ip_conntrack_events event,
 				      struct ip_conntrack *ct)
 {
@@ -483,9 +482,7 @@ static inline void ip_conntrack_event_ca
 					    const struct sk_buff *skb) {}
 static inline void ip_conntrack_event(enum ip_conntrack_events event, 
 				      struct ip_conntrack *ct) {}
-static inline void ip_conntrack_deliver_cached_events_for(
-						struct ip_conntrack *ct) {}
-static inline void ip_conntrack_event_cache_init(const struct sk_buff *skb) {}
+static inline void ip_ct_deliver_cached_events(const struct ip_conntrack *ct) {}
 static inline void 
 ip_conntrack_expect_event(enum ip_conntrack_expect_events event, 
 			  struct ip_conntrack_expect *exp) {}
diff --git a/include/linux/netfilter_ipv4/ip_conntrack_core.h b/include/linux/netfilter_ipv4/ip_conntrack_core.h
--- a/include/linux/netfilter_ipv4/ip_conntrack_core.h
+++ b/include/linux/netfilter_ipv4/ip_conntrack_core.h
@@ -44,18 +44,14 @@ static inline int ip_conntrack_confirm(s
 	struct ip_conntrack *ct = (struct ip_conntrack *)(*pskb)->nfct;
 	int ret = NF_ACCEPT;
 
-	if (ct && !is_confirmed(ct))
-		ret = __ip_conntrack_confirm(pskb);
-	ip_conntrack_deliver_cached_events_for(ct);
-
+	if (ct) {
+		if (!is_confirmed(ct))
+			ret = __ip_conntrack_confirm(pskb);
+		ip_ct_deliver_cached_events(ct);
+	}
 	return ret;
 }
 
-#ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
-struct ip_conntrack_ecache;
-extern void __ip_ct_deliver_cached_events(struct ip_conntrack_ecache *ec);
-#endif
-
 extern void __ip_ct_expect_unlink_destroy(struct ip_conntrack_expect *exp);
 
 extern struct list_head *ip_conntrack_hash;
diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -85,73 +85,62 @@ struct notifier_block *ip_conntrack_expe
 
 DEFINE_PER_CPU(struct ip_conntrack_ecache, ip_conntrack_ecache);
 
-static inline void __deliver_cached_events(struct ip_conntrack_ecache *ecache)
+/* deliver cached events and clear cache entry - must be called with locally
+ * disabled softirqs */
+static inline void
+__ip_ct_deliver_cached_events(struct ip_conntrack_ecache *ecache)
 {
+	DEBUGP("ecache: delivering events for %p\n", ecache->ct);
 	if (is_confirmed(ecache->ct) && !is_dying(ecache->ct) && ecache->events)
 		notifier_call_chain(&ip_conntrack_chain, ecache->events,
 				    ecache->ct);
 	ecache->events = 0;
-}
-
-void __ip_ct_deliver_cached_events(struct ip_conntrack_ecache *ecache)
-{
-	__deliver_cached_events(ecache);
+	ip_conntrack_put(ecache->ct);
+	ecache->ct = NULL;
 }
 
 /* Deliver all cached events for a particular conntrack. This is called
  * by code prior to async packet handling or freeing the skb */
-void 
-ip_conntrack_deliver_cached_events_for(const struct ip_conntrack *ct)
+void ip_ct_deliver_cached_events(const struct ip_conntrack *ct)
 {
-	struct ip_conntrack_ecache *ecache = 
-					&__get_cpu_var(ip_conntrack_ecache);
-
-	if (!ct)
-		return;
-
-	if (ecache->ct == ct) {
-		DEBUGP("ecache: delivering event for %p\n", ct);
-		__deliver_cached_events(ecache);
-	} else {
-		if (net_ratelimit())
-			printk(KERN_WARNING "ecache: want to deliver for %p, "
-				"but cache has %p\n", ct, ecache->ct);
-	}
-
-	/* signalize that events have already been delivered */
-	ecache->ct = NULL;
+	struct ip_conntrack_ecache *ecache;
+	
+	local_bh_disable();
+	ecache = &__get_cpu_var(ip_conntrack_ecache);
+	if (ecache->ct == ct)
+		__ip_ct_deliver_cached_events(ecache);
+	local_bh_enable();
 }
 
-/* Deliver cached events for old pending events, if current conntrack != old */
-void ip_conntrack_event_cache_init(const struct sk_buff *skb)
+void __ip_ct_event_cache_init(struct ip_conntrack *ct)
 {
-	struct ip_conntrack *ct = (struct ip_conntrack *) skb->nfct;
-	struct ip_conntrack_ecache *ecache = 
-					&__get_cpu_var(ip_conntrack_ecache);
+	struct ip_conntrack_ecache *ecache;
 
 	/* take care of delivering potentially old events */
-	if (ecache->ct != ct) {
-		enum ip_conntrack_info ctinfo;
-		/* we have to check, since at startup the cache is NULL */
-		if (likely(ecache->ct)) {
-			DEBUGP("ecache: entered for different conntrack: "
-			       "ecache->ct=%p, skb->nfct=%p. delivering "
-			       "events\n", ecache->ct, ct);
-			__deliver_cached_events(ecache);
+	ecache = &__get_cpu_var(ip_conntrack_ecache);
+	BUG_ON(ecache->ct == ct);
+	if (ecache->ct)
+		__ip_ct_deliver_cached_events(ecache);
+	/* initialize for this conntrack/packet */
+	ecache->ct = ct;
+	nf_conntrack_get(&ct->ct_general);
+}
+
+/* flush the event cache - touches other CPU's data and must not be called while
+ * packets are still passing through the code */
+static void ip_ct_event_cache_flush(void)
+{
+	struct ip_conntrack_ecache *ecache;
+	int cpu;
+
+	for_each_cpu(cpu) {
+		ecache = &per_cpu(ip_conntrack_ecache, cpu);
+		if (ecache->ct)
 			ip_conntrack_put(ecache->ct);
-		} else {
-			DEBUGP("ecache: entered for conntrack %p, "
-				"cache was clean before\n", ct);
-		}
-
-		/* initialize for this conntrack/packet */
-		ecache->ct = ip_conntrack_get(skb, &ctinfo);
-		/* ecache->events cleared by __deliver_cached_devents() */
-	} else {
-		DEBUGP("ecache: re-entered for conntrack %p.\n", ct);
 	}
 }
-
+#else
+static inline void ip_ct_event_cache_flush(void) {}
 #endif /* CONFIG_IP_NF_CONNTRACK_EVENTS */
 
 DEFINE_PER_CPU(struct ip_conntrack_stat, ip_conntrack_stat);
@@ -873,8 +862,6 @@ unsigned int ip_conntrack_in(unsigned in
 
 	IP_NF_ASSERT((*pskb)->nfct);
 
-	ip_conntrack_event_cache_init(*pskb);
-
 	ret = proto->packet(ct, *pskb, ctinfo);
 	if (ret < 0) {
 		/* Invalid: inverse of the return code tells
@@ -1273,23 +1260,6 @@ ip_ct_iterate_cleanup(int (*iter)(struct
 
 		ip_conntrack_put(ct);
 	}
-
-#ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
-	{
-		/* we need to deliver all cached events in order to drop
-		 * the reference counts */
-		int cpu;
-		for_each_cpu(cpu) {
-			struct ip_conntrack_ecache *ecache = 
-					&per_cpu(ip_conntrack_ecache, cpu);
-			if (ecache->ct) {
-				__ip_ct_deliver_cached_events(ecache);
-				ip_conntrack_put(ecache->ct);
-				ecache->ct = NULL;
-			}
-		}
-	}
-#endif
 }
 
 /* Fast function for those who don't want to parse /proc (and I don't
@@ -1376,6 +1346,7 @@ void ip_conntrack_flush()
            delete... */
 	synchronize_net();
 
+	ip_ct_event_cache_flush();
  i_see_dead_people:
 	ip_ct_iterate_cleanup(kill_all, NULL);
 	if (atomic_read(&ip_conntrack_count) != 0) {
diff --git a/net/ipv4/netfilter/ip_conntrack_standalone.c b/net/ipv4/netfilter/ip_conntrack_standalone.c
--- a/net/ipv4/netfilter/ip_conntrack_standalone.c
+++ b/net/ipv4/netfilter/ip_conntrack_standalone.c
@@ -401,7 +401,6 @@ static unsigned int ip_confirm(unsigned 
 			       const struct net_device *out,
 			       int (*okfn)(struct sk_buff *))
 {
-	ip_conntrack_event_cache_init(*pskb);
 	/* We've seen it coming out the other side: confirm it */
 	return ip_conntrack_confirm(pskb);
 }
@@ -419,7 +418,6 @@ static unsigned int ip_conntrack_help(un
 	ct = ip_conntrack_get(*pskb, &ctinfo);
 	if (ct && ct->helper) {
 		unsigned int ret;
-		ip_conntrack_event_cache_init(*pskb);
 		ret = ct->helper->help(pskb, ct, ctinfo);
 		if (ret != NF_ACCEPT)
 			return ret;
@@ -978,6 +976,7 @@ EXPORT_SYMBOL_GPL(ip_conntrack_chain);
 EXPORT_SYMBOL_GPL(ip_conntrack_expect_chain);
 EXPORT_SYMBOL_GPL(ip_conntrack_register_notifier);
 EXPORT_SYMBOL_GPL(ip_conntrack_unregister_notifier);
+EXPORT_SYMBOL_GPL(__ip_ct_event_cache_init);
 EXPORT_PER_CPU_SYMBOL_GPL(ip_conntrack_ecache);
 #endif
 EXPORT_SYMBOL(ip_conntrack_protocol_register);

--------------040705080805000509030305--
