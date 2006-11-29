Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758231AbWK2WCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231AbWK2WCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758252AbWK2WBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:01:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:44721 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758231AbWK2WBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:01:35 -0500
Message-Id: <20061129220339.207771000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:16 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       dim@openvz.org, dev@openvz.org, davem@davemloft.net
Subject: [patch 05/23] NETFILTER: Missed and reordered checks in {arp,ip,ip6}_tables
Content-Disposition: inline; filename=netfilter-missed-and-reordered-checks-in-arp-ip-ip6-_tables.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

Backport fix for missing ruleset validation in {arp,ip,ip6}_tables
and a fix on top which fixes a regression in the first patch.

There is a number of issues in parsing user-provided table in
translate_table(). Malicious user with CAP_NET_ADMIN may crash system by
passing special-crafted table to the *_tables.

The first issue is that mark_source_chains() function is called before entry
content checks. In case of standard target, mark_source_chains() function
uses t->verdict field in order to determine new position. But the check, that
this field leads no further, than the table end, is in check_entry(), which
is called later, than mark_source_chains().

The second issue, that there is no check that target_offset points inside
entry. If so, *_ITERATE_MATCH macro will follow further, than the entry
ends. As a result, we'll have oops or memory disclosure.

And the third issue, that there is no check that the target is completely
inside entry. Results are the same, as in previous issue.

Upstream commit 590bdf7fd2292b47c428111cb1360e312eff207e introduced a
regression in match/target hook validation. mark_source_chains builds
a bitmask for each rule representing the hooks it can be reached from,
which is then used by the matches and targets to make sure they are
only called from valid hooks. The patch moved the match/target specific
validation before the mark_source_chains call, at which point the mask
is always zero.

This patch returns back to the old order and moves the standard checks
to mark_source_chains. This allows to get rid of a special case for
standard targets as a nice side-effect.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
commit 1cfcb663c5a6d8b4b1172ff481af1b597bc8b54e
tree 61c5b135ee292681f38945a3549cb9005aec1d7c
parent b2ab160e1a3a1eb3fcc80132d8d7db5687a7a113
author Patrick McHardy <kaber@trash.net> Tue, 21 Nov 2006 11:17:03 +0100
committer Patrick McHardy <kaber@trash.net> Tue, 21 Nov 2006 11:24:51 +0100

 net/ipv4/netfilter/arp_tables.c |   37 +++++++++++++---------
 net/ipv4/netfilter/ip_tables.c  |   65 +++++++++++++++++++---------------------
 net/ipv6/netfilter/ip6_tables.c |   53 ++++++++++++++------------------
 3 files changed, 77 insertions(+), 78 deletions(-)

--- linux-2.6.18.4.orig/net/ipv4/netfilter/arp_tables.c
+++ linux-2.6.18.4/net/ipv4/netfilter/arp_tables.c
@@ -380,6 +380,13 @@ static int mark_source_chains(struct xt_
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
@@ -409,6 +416,14 @@ static int mark_source_chains(struct xt_
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
@@ -431,8 +446,6 @@ static int mark_source_chains(struct xt_
 static inline int standard_check(const struct arpt_entry_target *t,
 				 unsigned int max_offset)
 {
-	struct arpt_standard_target *targ = (void *)t;
-
 	/* Check standard info. */
 	if (t->u.target_size
 	    != ARPT_ALIGN(sizeof(struct arpt_standard_target))) {
@@ -442,18 +455,6 @@ static inline int standard_check(const s
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
 
@@ -471,7 +472,13 @@ static inline int check_entry(struct arp
 		return -EINVAL;
 	}
 
+	if (e->target_offset + sizeof(struct arpt_entry_target) > e->next_offset)
+		return -EINVAL;
+
 	t = arpt_get_target(e);
+	if (e->target_offset + t->u.target_size > e->next_offset)
+		return -EINVAL;
+
 	target = try_then_request_module(xt_find_target(NF_ARP, t->u.user.name,
 							t->u.user.revision),
 					 "arpt_%s", t->u.user.name);
@@ -641,7 +648,7 @@ static int translate_table(const char *n
 
 	if (ret != 0) {
 		ARPT_ENTRY_ITERATE(entry0, newinfo->size,
-				   cleanup_entry, &i);
+				cleanup_entry, &i);
 		return ret;
 	}
 
--- linux-2.6.18.4.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.18.4/net/ipv4/netfilter/ip_tables.c
@@ -404,6 +404,13 @@ mark_source_chains(struct xt_table_info 
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
@@ -441,6 +448,13 @@ mark_source_chains(struct xt_table_info 
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
@@ -474,27 +488,6 @@ cleanup_match(struct ipt_entry_match *m,
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
@@ -552,12 +545,18 @@ check_entry(struct ipt_entry *e, const c
 		return -EINVAL;
 	}
 
+	if (e->target_offset + sizeof(struct ipt_entry_target) > e->next_offset)
+		return -EINVAL;
+
 	j = 0;
 	ret = IPT_MATCH_ITERATE(e, check_match, name, &e->ip, e->comefrom, &j);
 	if (ret != 0)
 		goto cleanup_matches;
 
 	t = ipt_get_target(e);
+	ret = -EINVAL;
+	if (e->target_offset + t->u.target_size > e->next_offset)
+			goto cleanup_matches;
 	target = try_then_request_module(xt_find_target(AF_INET,
 						     t->u.user.name,
 						     t->u.user.revision),
@@ -575,12 +574,7 @@ check_entry(struct ipt_entry *e, const c
 	if (ret)
 		goto err;
 
-	if (t->u.kernel.target == &ipt_standard_target) {
-		if (!standard_check(t, size)) {
-			ret = -EINVAL;
-			goto cleanup_matches;
-		}
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, e, target, t->data,
 						      t->u.target_size
 						      - sizeof(*t),
@@ -730,7 +724,7 @@ translate_table(const char *name,
 
 	if (ret != 0) {
 		IPT_ENTRY_ITERATE(entry0, newinfo->size,
-				  cleanup_entry, &i);
+				cleanup_entry, &i);
 		return ret;
 	}
 
@@ -1531,6 +1525,10 @@ check_compat_entry_size_and_hooks(struct
 		return -EINVAL;
 	}
 
+	if (e->target_offset + sizeof(struct compat_xt_entry_target) >
+								e->next_offset)
+		return -EINVAL;
+
 	off = 0;
 	entry_offset = (void *)e - (void *)base;
 	j = 0;
@@ -1540,6 +1538,9 @@ check_compat_entry_size_and_hooks(struct
 		goto cleanup_matches;
 
 	t = ipt_get_target(e);
+	ret = -EINVAL;
+	if (e->target_offset + t->u.target_size > e->next_offset)
+			goto cleanup_matches;
 	target = try_then_request_module(xt_find_target(AF_INET,
 						     t->u.user.name,
 						     t->u.user.revision),
@@ -1656,19 +1657,15 @@ static int compat_copy_entry_from_user(s
 	if (ret)
 		goto err;
 
-	ret = -EINVAL;
-	if (t->u.kernel.target == &ipt_standard_target) {
-		if (!standard_check(t, *size))
-			goto err;
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, de, target,
 				t->data, t->u.target_size - sizeof(*t),
 				de->comefrom)) {
 		duprintf("ip_tables: compat: check failed for `%s'.\n",
 			 t->u.kernel.target->name);
+		ret = -EINVAL;
 		goto err;
 	}
-	ret = 0;
  err:
 	return ret;
 }
--- linux-2.6.18.4.orig/net/ipv6/netfilter/ip6_tables.c
+++ linux-2.6.18.4/net/ipv6/netfilter/ip6_tables.c
@@ -444,6 +444,13 @@ mark_source_chains(struct xt_table_info 
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
@@ -481,6 +488,13 @@ mark_source_chains(struct xt_table_info 
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
@@ -514,27 +528,6 @@ cleanup_match(struct ip6t_entry_match *m
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
@@ -592,12 +585,19 @@ check_entry(struct ip6t_entry *e, const 
 		return -EINVAL;
 	}
 
+	if (e->target_offset + sizeof(struct ip6t_entry_target) >
+								e->next_offset)
+		return -EINVAL;
+
 	j = 0;
 	ret = IP6T_MATCH_ITERATE(e, check_match, name, &e->ipv6, e->comefrom, &j);
 	if (ret != 0)
 		goto cleanup_matches;
 
 	t = ip6t_get_target(e);
+	ret = -EINVAL;
+	if (e->target_offset + t->u.target_size > e->next_offset)
+			goto cleanup_matches;
 	target = try_then_request_module(xt_find_target(AF_INET6,
 							t->u.user.name,
 							t->u.user.revision),
@@ -615,12 +615,7 @@ check_entry(struct ip6t_entry *e, const 
 	if (ret)
 		goto err;
 
-	if (t->u.kernel.target == &ip6t_standard_target) {
-		if (!standard_check(t, size)) {
-			ret = -EINVAL;
-			goto cleanup_matches;
-		}
-	} else if (t->u.kernel.target->checkentry
+	if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, e, target, t->data,
 						      t->u.target_size
 						      - sizeof(*t),
@@ -770,7 +765,7 @@ translate_table(const char *name,
 
 	if (ret != 0) {
 		IP6T_ENTRY_ITERATE(entry0, newinfo->size,
-				  cleanup_entry, &i);
+				   cleanup_entry, &i);
 		return ret;
 	}
 
@@ -780,7 +775,7 @@ translate_table(const char *name,
 			memcpy(newinfo->entries[i], entry0, newinfo->size);
 	}
 
-	return ret;
+	return 0;
 }
 
 /* Gets counters. */

--
