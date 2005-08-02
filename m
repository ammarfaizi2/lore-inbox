Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVHBAsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVHBAsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVHBAsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:48:02 -0400
Received: from [62.206.217.67] ([62.206.217.67]:34274 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261352AbVHBAr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:47:56 -0400
Message-ID: <42EEC2BB.3020105@trash.net>
Date: Tue, 02 Aug 2005 02:47:55 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mattia Dongili <malattia@gmail.com>
CC: Harald Welte <laforge@netfilter.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: atomic counter underflow at ip_conntrack_event_cache_init+0x91/0xb0
 (with patch)
References: <20050801141327.GA3909@inferi.kami.home>	<42EE3169.6070604@trash.net>	<20050801160537.GA3850@inferi.kami.home> <42EE5721.1090509@trash.net>
In-Reply-To: <42EE5721.1090509@trash.net>
Content-Type: multipart/mixed;
 boundary="------------020904090806070801020008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020904090806070801020008
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patrick McHardy wrote:
> Mattia Dongili wrote:
> 
>>On Mon, Aug 01, 2005 at 04:27:53PM +0200, Patrick McHardy wrote:
>>
>>
>>>>--- include/linux/netfilter_ipv4/ip_conntrack.h.clean	2005-08-01 15:09:49.000000000 +0200
>>>>+++ include/linux/netfilter_ipv4/ip_conntrack.h	2005-08-01 15:08:52.000000000 +0200
>>>>@@ -298,6 +298,7 @@ static inline struct ip_conntrack *
>>>>ip_conntrack_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
>>>>{
>>>>	*ctinfo = skb->nfctinfo;
>>>>+	nf_conntrack_get(skb->nfct);
>>>>	return (struct ip_conntrack *)skb->nfct;
>>>>}
>>>
>>>This creates lots of refcnt leaks, which is probably why it makes the
>>>underflow go away :) Please try this patch instead.
>>
>>
>>this doesn't fix it actually, see dmesg below:
> 
> 
> It looks like ip_ct_iterate_cleanup and ip_conntrack_event_cache_init
> race against each other with assigning pointers and grabbing/putting the
> refcounts if called from different contexts.

This should be a fist step towards fixing it. It's probably incomplete
(I'm too tired to check it now), but it should fix the problem you're
seeing. Could you give it a spin?

BTW, ip_ct_iterate_cleanup can only be called from ipt_MASQUERADE when
a device goes down. It seems a bit odd that this is happending on boot,
is there anything special about your setup?

Regards
Patrick

--------------020904090806070801020008
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/include/linux/netfilter_ipv4/ip_conntrack.h b/include/linux/netfilter_ipv4/ip_conntrack.h
--- a/include/linux/netfilter_ipv4/ip_conntrack.h
+++ b/include/linux/netfilter_ipv4/ip_conntrack.h
@@ -411,6 +411,7 @@ struct ip_conntrack_stat
 
 #ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
 #include <linux/notifier.h>
+#include <linux/interrupt.h>
 
 struct ip_conntrack_ecache {
 	struct ip_conntrack *ct;
@@ -445,26 +446,25 @@ ip_conntrack_expect_unregister_notifier(
 	return notifier_chain_unregister(&ip_conntrack_expect_chain, nb);
 }
 
+extern void ip_conntrack_event_cache_init(struct ip_conntrack *ct);
+extern void 
+ip_conntrack_deliver_cached_events_for(const struct ip_conntrack *ct);
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
+	if (unlikely(ct != ecache->ct))
+		ip_conntrack_event_cache_init(ct);
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
diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -100,56 +100,45 @@ void __ip_ct_deliver_cached_events(struc
 
 /* Deliver all cached events for a particular conntrack. This is called
  * by code prior to async packet handling or freeing the skb */
-void 
-ip_conntrack_deliver_cached_events_for(const struct ip_conntrack *ct)
+void ip_conntrack_deliver_cached_events_for(const struct ip_conntrack *ct)
 {
-	struct ip_conntrack_ecache *ecache = 
-					&__get_cpu_var(ip_conntrack_ecache);
-
-	if (!ct)
-		return;
-
+	struct ip_conntrack_ecache *ecache;
+	
+	local_bh_disable();
+	ecache = &__get_cpu_var(ip_conntrack_ecache);
 	if (ecache->ct == ct) {
 		DEBUGP("ecache: delivering event for %p\n", ct);
 		__deliver_cached_events(ecache);
 	} else {
-		if (net_ratelimit())
-			printk(KERN_WARNING "ecache: want to deliver for %p, "
-				"but cache has %p\n", ct, ecache->ct);
+		DEBUGP("ecache: already delivered for %p, cache %p",
+		       ct, ecache->ct);
 	}
-
 	/* signalize that events have already been delivered */
 	ecache->ct = NULL;
+	local_bh_enable();
 }
 
 /* Deliver cached events for old pending events, if current conntrack != old */
-void ip_conntrack_event_cache_init(const struct sk_buff *skb)
+void ip_conntrack_event_cache_init(struct ip_conntrack *ct)
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
-			ip_conntrack_put(ecache->ct);
-		} else {
-			DEBUGP("ecache: entered for conntrack %p, "
-				"cache was clean before\n", ct);
-		}
-
-		/* initialize for this conntrack/packet */
-		ecache->ct = ip_conntrack_get(skb, &ctinfo);
-		/* ecache->events cleared by __deliver_cached_devents() */
+	ecache = &__get_cpu_var(ip_conntrack_ecache);
+	BUG_ON(ecache->ct == ct);
+	if (ecache->ct) {
+		DEBUGP("ecache: entered for different conntrack: "
+		       "ecache->ct=%p, skb->nfct=%p. delivering "
+		       "events\n", ecache->ct, ct);
+		__deliver_cached_events(ecache);
+		ip_conntrack_put(ecache->ct);
 	} else {
-		DEBUGP("ecache: re-entered for conntrack %p.\n", ct);
+		DEBUGP("ecache: entered for conntrack %p, "
+			"cache was clean before\n", ct);
 	}
+	/* initialize for this conntrack/packet */
+	ecache->ct = ct;
+	nf_conntrack_get(&ct->ct_general);
 }
 
 #endif /* CONFIG_IP_NF_CONNTRACK_EVENTS */
@@ -873,8 +862,6 @@ unsigned int ip_conntrack_in(unsigned in
 
 	IP_NF_ASSERT((*pskb)->nfct);
 
-	ip_conntrack_event_cache_init(*pskb);
-
 	ret = proto->packet(ct, *pskb, ctinfo);
 	if (ret < 0) {
 		/* Invalid: inverse of the return code tells
@@ -1279,15 +1266,18 @@ ip_ct_iterate_cleanup(int (*iter)(struct
 		/* we need to deliver all cached events in order to drop
 		 * the reference counts */
 		int cpu;
+
+		local_bh_disable();
 		for_each_cpu(cpu) {
 			struct ip_conntrack_ecache *ecache = 
 					&per_cpu(ip_conntrack_ecache, cpu);
 			if (ecache->ct) {
-				__ip_ct_deliver_cached_events(ecache);
+				__deliver_cached_events(ecache);
 				ip_conntrack_put(ecache->ct);
 				ecache->ct = NULL;
 			}
 		}
+		local_bh_enable();
 	}
 #endif
 }
diff --git a/net/ipv4/netfilter/ip_conntrack_standalone.c b/net/ipv4/netfilter/ip_conntrack_standalone.c
--- a/net/ipv4/netfilter/ip_conntrack_standalone.c
+++ b/net/ipv4/netfilter/ip_conntrack_standalone.c
@@ -401,9 +401,13 @@ static unsigned int ip_confirm(unsigned 
 			       const struct net_device *out,
 			       int (*okfn)(struct sk_buff *))
 {
-	ip_conntrack_event_cache_init(*pskb);
 	/* We've seen it coming out the other side: confirm it */
-	return ip_conntrack_confirm(pskb);
+	struct ip_conntrack *ct = (struct ip_conntrack *)(*pskb)->nfct;
+	unsigned int ret;
+	
+	ret = ip_conntrack_confirm(pskb);
+	ip_conntrack_deliver_cached_events_for(ct);
+	return ret;
 }
 
 static unsigned int ip_conntrack_help(unsigned int hooknum,
@@ -419,7 +423,7 @@ static unsigned int ip_conntrack_help(un
 	ct = ip_conntrack_get(*pskb, &ctinfo);
 	if (ct && ct->helper) {
 		unsigned int ret;
-		ip_conntrack_event_cache_init(*pskb);
+		ip_conntrack_event_cache_init(ct);
 		ret = ct->helper->help(pskb, ct, ctinfo);
 		if (ret != NF_ACCEPT)
 			return ret;

--------------020904090806070801020008--
