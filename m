Return-Path: <linux-kernel-owner+w=401wt.eu-S1947525AbWLHX6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947525AbWLHX6G (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947527AbWLHX6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:58:05 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:60364 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947523AbWLHX5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:57:46 -0500
Message-Id: <20061209000017.750862000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net, Dmitry Mishin <dim@openvz.org>
Subject: [patch 12/32] NETFILTER: Fix {ip, ip6, arp}_tables hook validation
Content-Disposition: inline; filename=netfilter-fix-ip-ip6-arp-_tables-hook-validation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Dmitry Mishin <dim@openvz.org>

Commit 590bdf7fd2292b47c428111cb1360e312eff207e introduced a regression
in match/target hook validation. mark_source_chains builds a bitmask
for each rule representing the hooks it can be reached from, which is
then used by the matches and targets to make sure they are only called
from valid hooks. The patch moved the match/target specific validation
before the mark_source_chains call, at which point the mask is always zero.

This patch returns back to the old order and moves the standard checks
to mark_source_chains. This allows to get rid of a special case for
standard targets as a nice side-effect.

Signed-off-by: Dmitry Mishin <dim@openvz.org>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit 756c508367e95d6f963502e4feecb8c76aeee332
tree 2be0ffb477e890a713eb48f3993a2f425baf5683
parent 0215ffb08ce99e2bb59eca114a99499a4d06e704
author Dmitry Mishin <dim@openvz.org> Mon, 04 Dec 2006 12:19:27 +0100
committer Patrick McHardy <kaber@trash.net> Mon, 04 Dec 2006 12:19:27 +0100

 net/ipv4/netfilter/arp_tables.c |   48 ++++++++++++++--------------
 net/ipv4/netfilter/ip_tables.c  |   68 ++++++++++++++--------------------------
 net/ipv6/netfilter/ip6_tables.c |   59 +++++++++++++---------------------
 3 files changed, 72 insertions(+), 103 deletions(-)

--- linux-2.6.19.orig/net/ipv4/netfilter/arp_tables.c
+++ linux-2.6.19/net/ipv4/netfilter/arp_tables.c
@@ -375,6 +375,13 @@ static int mark_source_chains(struct xt_
 			    && unconditional(&e->arp)) {
 				unsigned int oldpos, size;
 
+				if (t->verdict < -NF_MAX_VERDICT - 1) {
+					duprintf("mark_source_chains: bad "
+						"negative verdict (%i)\n",
+								t->verdict);
+					return 0;
+				}
+
 				/* Return: backtrack through the last
 				 * big jump.
 				 */
@@ -404,6 +411,14 @@ static int mark_source_chains(struct xt_
 				if (strcmp(t->target.u.user.name,
 					   ARPT_STANDARD_TARGET) == 0
 				    && newpos >= 0) {
+					if (newpos > newinfo->size -
+						sizeof(struct arpt_entry)) {
+						duprintf("mark_source_chains: "
+							"bad verdict (%i)\n",
+								newpos);
+						return 0;
+					}
+
 					/* This a jump; chase it. */
 					duprintf("Jump rule %u -> %u\n",
 						 pos, newpos);
@@ -426,8 +441,6 @@ static int mark_source_chains(struct xt_
 static inline int standard_check(const struct arpt_entry_target *t,
 				 unsigned int max_offset)
 {
-	struct arpt_standard_target *targ = (void *)t;
-
 	/* Check standard info. */
 	if (t->u.target_size
 	    != ARPT_ALIGN(sizeof(struct arpt_standard_target))) {
@@ -437,18 +450,6 @@ static inline int standard_check(const s
 		return 0;
 	}
 
-	if (targ->verdict >= 0
-	    && targ->verdict > max_offset - sizeof(struct arpt_entry)) {
-		duprintf("arpt_standard_check: bad verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-
-	if (targ->verdict < -NF_MAX_VERDICT - 1) {
-		duprintf("arpt_standard_check: bad negative verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
 	return 1;
 }
 
@@ -627,18 +628,20 @@ static int translate_table(const char *n
 		}
 	}
 
+	if (!mark_source_chains(newinfo, valid_hooks, entry0)) {
+		duprintf("Looping hook\n");
+		return -ELOOP;
+	}
+
 	/* Finally, each sanity check must pass */
 	i = 0;
 	ret = ARPT_ENTRY_ITERATE(entry0, newinfo->size,
 				 check_entry, name, size, &i);
 
-	if (ret != 0)
-		goto cleanup;
-
-	ret = -ELOOP;
-	if (!mark_source_chains(newinfo, valid_hooks, entry0)) {
-		duprintf("Looping hook\n");
-		goto cleanup;
+	if (ret != 0) {
+		ARPT_ENTRY_ITERATE(entry0, newinfo->size,
+				cleanup_entry, &i);
+		return ret;
 	}
 
 	/* And one copy for every other CPU */
@@ -647,9 +650,6 @@ static int translate_table(const char *n
 			memcpy(newinfo->entries[i], entry0, newinfo->size);
 	}
 
-	return 0;
-cleanup:
-	ARPT_ENTRY_ITERATE(entry0, newinfo->size, cleanup_entry, &i);
 	return ret;
 }
 
--- linux-2.6.19.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.19/net/ipv4/netfilter/ip_tables.c
@@ -401,6 +401,13 @@ mark_source_chains(struct xt_table_info 
 			    && unconditional(&e->ip)) {
 				unsigned int oldpos, size;
 
+				if (t->verdict < -NF_MAX_VERDICT - 1) {
+					duprintf("mark_source_chains: bad "
+						"negative verdict (%i)\n",
+								t->verdict);
+					return 0;
+				}
+
 				/* Return: backtrack through the last
 				   big jump. */
 				do {
@@ -438,6 +445,13 @@ mark_source_chains(struct xt_table_info 
 				if (strcmp(t->target.u.user.name,
 					   IPT_STANDARD_TARGET) == 0
 				    && newpos >= 0) {
+					if (newpos > newinfo->size -
+						sizeof(struct ipt_entry)) {
+						duprintf("mark_source_chains: "
+							"bad verdict (%i)\n",
+								newpos);
+						return 0;
+					}
 					/* This a jump; chase it. */
 					duprintf("Jump rule %u -> %u\n",
 						 pos, newpos);
@@ -470,27 +484,6 @@ cleanup_match(struct ipt_entry_match *m,
 }
 
 static inline int
-standard_check(const struct ipt_entry_target *t,
-	       unsigned int max_offset)
-{
-	struct ipt_standard_target *targ = (void *)t;
-
-	/* Check standard info. */
-	if (targ->verdict >= 0
-	    && targ->verdict > max_offset - sizeof(struct ipt_entry)) {
-		duprintf("ipt_standard_check: bad verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-	if (targ->verdict < -NF_MAX_VERDICT - 1) {
-		duprintf("ipt_standard_check: bad negative verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-	return 1;
-}
-
-static inline int
 check_match(struct ipt_entry_match *m,
 	    const char *name,
 	    const struct ipt_ip *ip,
@@ -576,12 +569,7 @@ check_entry(struct ipt_entry *e, const c
 	if (ret)
 		goto err;
 
-	if (t->u.kernel.target == &ipt_standard_target) {
-		if (!standard_check(t, size)) {
-			ret = -EINVAL;
-			goto err;
-		}
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, e, target, t->data,
 						      e->comefrom)) {
 		duprintf("ip_tables: check failed for `%s'.\n",
@@ -718,17 +706,19 @@ translate_table(const char *name,
 		}
 	}
 
+	if (!mark_source_chains(newinfo, valid_hooks, entry0))
+		return -ELOOP;
+
 	/* Finally, each sanity check must pass */
 	i = 0;
 	ret = IPT_ENTRY_ITERATE(entry0, newinfo->size,
 				check_entry, name, size, &i);
 
-	if (ret != 0)
-		goto cleanup;
-
-	ret = -ELOOP;
-	if (!mark_source_chains(newinfo, valid_hooks, entry0))
-		goto cleanup;
+	if (ret != 0) {
+		IPT_ENTRY_ITERATE(entry0, newinfo->size,
+				cleanup_entry, &i);
+		return ret;
+	}
 
 	/* And one copy for every other CPU */
 	for_each_possible_cpu(i) {
@@ -736,9 +726,6 @@ translate_table(const char *name,
 			memcpy(newinfo->entries[i], entry0, newinfo->size);
 	}
 
-	return 0;
-cleanup:
-	IPT_ENTRY_ITERATE(entry0, newinfo->size, cleanup_entry, &i);
 	return ret;
 }
 
@@ -1591,18 +1578,13 @@ static int compat_copy_entry_from_user(s
 	if (ret)
 		goto err;
 
-	ret = -EINVAL;
-	if (t->u.kernel.target == &ipt_standard_target) {
-		if (!standard_check(t, *size))
-			goto err;
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, de, target,
 						      t->data, de->comefrom)) {
 		duprintf("ip_tables: compat: check failed for `%s'.\n",
 			 t->u.kernel.target->name);
-		goto err;
+		ret = -EINVAL;
 	}
-	ret = 0;
 err:
 	return ret;
 }
--- linux-2.6.19.orig/net/ipv6/netfilter/ip6_tables.c
+++ linux-2.6.19/net/ipv6/netfilter/ip6_tables.c
@@ -440,6 +440,13 @@ mark_source_chains(struct xt_table_info 
 			    && unconditional(&e->ipv6)) {
 				unsigned int oldpos, size;
 
+				if (t->verdict < -NF_MAX_VERDICT - 1) {
+					duprintf("mark_source_chains: bad "
+						"negative verdict (%i)\n",
+								t->verdict);
+					return 0;
+				}
+
 				/* Return: backtrack through the last
 				   big jump. */
 				do {
@@ -477,6 +484,13 @@ mark_source_chains(struct xt_table_info 
 				if (strcmp(t->target.u.user.name,
 					   IP6T_STANDARD_TARGET) == 0
 				    && newpos >= 0) {
+					if (newpos > newinfo->size -
+						sizeof(struct ip6t_entry)) {
+						duprintf("mark_source_chains: "
+							"bad verdict (%i)\n",
+								newpos);
+						return 0;
+					}
 					/* This a jump; chase it. */
 					duprintf("Jump rule %u -> %u\n",
 						 pos, newpos);
@@ -509,27 +523,6 @@ cleanup_match(struct ip6t_entry_match *m
 }
 
 static inline int
-standard_check(const struct ip6t_entry_target *t,
-	       unsigned int max_offset)
-{
-	struct ip6t_standard_target *targ = (void *)t;
-
-	/* Check standard info. */
-	if (targ->verdict >= 0
-	    && targ->verdict > max_offset - sizeof(struct ip6t_entry)) {
-		duprintf("ip6t_standard_check: bad verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-	if (targ->verdict < -NF_MAX_VERDICT - 1) {
-		duprintf("ip6t_standard_check: bad negative verdict (%i)\n",
-			 targ->verdict);
-		return 0;
-	}
-	return 1;
-}
-
-static inline int
 check_match(struct ip6t_entry_match *m,
 	    const char *name,
 	    const struct ip6t_ip6 *ipv6,
@@ -616,12 +609,7 @@ check_entry(struct ip6t_entry *e, const 
 	if (ret)
 		goto err;
 
-	if (t->u.kernel.target == &ip6t_standard_target) {
-		if (!standard_check(t, size)) {
-			ret = -EINVAL;
-			goto err;
-		}
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, e, target, t->data,
 						      e->comefrom)) {
 		duprintf("ip_tables: check failed for `%s'.\n",
@@ -758,17 +746,19 @@ translate_table(const char *name,
 		}
 	}
 
+	if (!mark_source_chains(newinfo, valid_hooks, entry0))
+		return -ELOOP;
+
 	/* Finally, each sanity check must pass */
 	i = 0;
 	ret = IP6T_ENTRY_ITERATE(entry0, newinfo->size,
 				check_entry, name, size, &i);
 
-	if (ret != 0)
-		goto cleanup;
-
-	ret = -ELOOP;
-	if (!mark_source_chains(newinfo, valid_hooks, entry0))
-		goto cleanup;
+	if (ret != 0) {
+		IP6T_ENTRY_ITERATE(entry0, newinfo->size,
+				   cleanup_entry, &i);
+		return ret;
+	}
 
 	/* And one copy for every other CPU */
 	for_each_possible_cpu(i) {
@@ -777,9 +767,6 @@ translate_table(const char *name,
 	}
 
 	return 0;
-cleanup:
-	IP6T_ENTRY_ITERATE(entry0, newinfo->size, cleanup_entry, &i);
-	return ret;
 }
 
 /* Gets counters. */

--
