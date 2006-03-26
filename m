Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWCZQdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWCZQdc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWCZQdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:33:32 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:24758 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751459AbWCZQdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:33:31 -0500
Date: Sun, 26 Mar 2006 18:30:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt21, BUG at net/ipv4/netfilter/ip_conntrack_core.c:124
Message-ID: <20060326163056.GC15667@elte.hu>
References: <1143339628.5527.3.camel@cmn2.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143339628.5527.3.camel@cmn2.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Hi Ingo... I'm seeing a few freezes with 2.6.15-rt21, they seem to be 
> few and far between and most of the time they don't leave traces 
> behind in the logs (and the reset button is the only way out). Here's 
> one that apparently did leave something behind:
> 
> Mar 23 15:22:48 host kernel: BUG at
> net/ipv4/netfilter/ip_conntrack_core.c:124!

does the patch below help?

	Ingo

Index: linux/include/linux/netfilter_ipv4/ip_conntrack.h
===================================================================
--- linux.orig/include/linux/netfilter_ipv4/ip_conntrack.h
+++ linux/include/linux/netfilter_ipv4/ip_conntrack.h
@@ -336,7 +336,8 @@ ip_conntrack_expect_unregister_notifier(
 }
 
 extern void ip_ct_deliver_cached_events(const struct ip_conntrack *ct);
-extern void __ip_ct_event_cache_init(struct ip_conntrack *ct);
+extern void __ip_ct_event_cache_init(struct ip_conntrack_ecache *ecache,
+				     struct ip_conntrack *ct);
 
 static inline void 
 ip_conntrack_event_cache(enum ip_conntrack_events event,
@@ -349,7 +350,7 @@ ip_conntrack_event_cache(enum ip_conntra
 	local_bh_disable();
 	ecache = &get_cpu_var_locked(ip_conntrack_ecache, &cpu);
 	if (ct != ecache->ct)
-		__ip_ct_event_cache_init(ct);
+		__ip_ct_event_cache_init(ecache, ct);
 	ecache->events |= event;
 	put_cpu_var_locked(ip_conntrack_ecache, cpu);
 	local_bh_enable();
Index: linux/net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
--- linux.orig/net/ipv4/netfilter/ip_conntrack_core.c
+++ linux/net/ipv4/netfilter/ip_conntrack_core.c
@@ -114,13 +114,10 @@ void ip_ct_deliver_cached_events(const s
 	local_bh_enable();
 }
 
-void __ip_ct_event_cache_init(struct ip_conntrack *ct)
+void __ip_ct_event_cache_init(struct ip_conntrack_ecache *ecache,
+			      struct ip_conntrack *ct)
 {
-	struct ip_conntrack_ecache *ecache;
-	int cpu = raw_smp_processor_id();
-
 	/* take care of delivering potentially old events */
-	ecache = &__get_cpu_var_locked(ip_conntrack_ecache, cpu);
 	BUG_ON(ecache->ct == ct);
 	if (ecache->ct)
 		__ip_ct_deliver_cached_events(ecache);
