Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVKGVuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVKGVuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVKGVuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:50:05 -0500
Received: from postel.suug.ch ([195.134.158.23]:32448 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S965121AbVKGVuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:50:02 -0500
Date: Mon, 7 Nov 2005 22:50:22 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Patrick McHardy <kaber@trash.net>
Cc: Brian Pomerantz <bapper@piratehaven.org>, netdev@vger.kernel.org,
       davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
Message-ID: <20051107215022.GH23537@postel.suug.ch>
References: <20051104184633.GA16256@skull.piratehaven.org> <436BFE08.6030906@trash.net> <20051105010740.GR23537@postel.suug.ch> <436C090D.5020201@trash.net> <436C34F8.3090903@trash.net> <20051105134636.GS23537@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105134636.GS23537@postel.suug.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Graf <tgraf@suug.ch> 2005-11-05 14:46
> Assuming this is a separate bug, I'm not sure if this is the right
> way to fix it. I think it would be better to rewrite the preferred
> source address of all related local routes and only perform a
> remove-and-add on the secondary address being promoted.

I tried it out and although it works it's not clean yet because
changing fib_info also changes pref_src for the routes to be
deleted which will lead to slightly incorrect notifications later
on. I now think that explicitely deleting and re-adding them
later on is better as well ;-)

Index: linux-2.6/net/ipv4/devinet.c
===================================================================
--- linux-2.6.orig/net/ipv4/devinet.c
+++ linux-2.6/net/ipv4/devinet.c
@@ -230,31 +230,38 @@ int inet_addr_onlink(struct in_device *i
 	return 0;
 }
 
+static inline int ifa_is_secondary(struct in_ifaddr *primary,
+				   struct in_ifaddr *candiate)
+{
+	return ((candiate->ifa_flags & IFA_F_SECONDARY) &&
+		primary->ifa_mask == candiate->ifa_mask &&
+		inet_ifa_match(primary->ifa_address, candiate));
+}
+
 static void inet_del_ifa(struct in_device *in_dev, struct in_ifaddr **ifap,
 			 int destroy)
 {
+	int do_promote;
 	struct in_ifaddr *promote = NULL;
-	struct in_ifaddr *ifa1 = *ifap;
+	struct in_ifaddr *ifa, *ifa1 = *ifap;
 
 	ASSERT_RTNL();
 
 	/* 1. Deleting primary ifaddr forces deletion all secondaries 
 	 * unless alias promotion is set
 	 **/
+	do_promote = IN_DEV_PROMOTE_SECONDARIES(in_dev);
 
 	if (!(ifa1->ifa_flags & IFA_F_SECONDARY)) {
-		struct in_ifaddr *ifa;
 		struct in_ifaddr **ifap1 = &ifa1->ifa_next;
 
 		while ((ifa = *ifap1) != NULL) {
-			if (!(ifa->ifa_flags & IFA_F_SECONDARY) ||
-			    ifa1->ifa_mask != ifa->ifa_mask ||
-			    !inet_ifa_match(ifa1->ifa_address, ifa)) {
+			if (!ifa_is_secondary(ifa1, ifa)) {
 				ifap1 = &ifa->ifa_next;
 				continue;
 			}
 
-			if (!IN_DEV_PROMOTE_SECONDARIES(in_dev)) {
+			if (!do_promote) {
 				*ifap1 = ifa->ifa_next;
 
 				rtmsg_ifa(RTM_DELADDR, ifa);
@@ -271,6 +278,10 @@ static void inet_del_ifa(struct in_devic
 
 	*ifap = ifa1->ifa_next;
 
+	for (ifa = promote; ifa != NULL; ifa = ifa->ifa_next)
+		if (ifa_is_secondary(ifa1, ifa))
+			fib_promote(ifa1->ifa_local, ifa->ifa_local);
+
 	/* 3. Announce address deletion */
 
 	/* Send message first, then call notifier.
@@ -290,7 +301,7 @@ static void inet_del_ifa(struct in_devic
 			inetdev_destroy(in_dev);
 	}
 
-	if (promote && IN_DEV_PROMOTE_SECONDARIES(in_dev)) {
+	if (promote) {
 		/* not sure if we should send a delete notify first? */
 		promote->ifa_flags &= ~IFA_F_SECONDARY;
 		rtmsg_ifa(RTM_NEWADDR, promote);
Index: linux-2.6/include/net/ip_fib.h
===================================================================
--- linux-2.6.orig/include/net/ip_fib.h
+++ linux-2.6/include/net/ip_fib.h
@@ -242,6 +242,7 @@ extern void fib_select_multipath(const s
 extern int ip_fib_check_default(u32 gw, struct net_device *dev);
 extern int fib_sync_down(u32 local, struct net_device *dev, int force);
 extern int fib_sync_up(struct net_device *dev);
+extern int fib_promote(u32 old, u32 new);
 extern int fib_convert_rtentry(int cmd, struct nlmsghdr *nl, struct rtmsg *rtm,
 			       struct kern_rta *rta, struct rtentry *r);
 extern u32  __fib_res_prefsrc(struct fib_result *res);
Index: linux-2.6/net/ipv4/fib_semantics.c
===================================================================
--- linux-2.6.orig/net/ipv4/fib_semantics.c
+++ linux-2.6/net/ipv4/fib_semantics.c
@@ -1338,3 +1338,24 @@ void fib_select_multipath(const struct f
 	spin_unlock_bh(&fib_multipath_lock);
 }
 #endif
+
+int fib_promote(u32 old, u32 new)
+{
+	int ret = 0;
+
+	if (old && fib_info_laddrhash) {
+		unsigned int hash = fib_laddr_hashfn(old);
+		struct hlist_head *head = &fib_info_laddrhash[hash];
+		struct hlist_node *node;
+		struct fib_info *fi;
+
+		hlist_for_each_entry(fi, node, head, fib_lhash) {
+			if (fi->fib_prefsrc == old) {
+				fi->fib_prefsrc = new;
+				ret++;
+			}
+		}
+	}
+
+	return ret;
+}
