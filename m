Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757388AbWK2WB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbWK2WB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758210AbWK2WB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:01:29 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:39345 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1757388AbWK2WB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:01:28 -0500
Message-Id: <20061129220336.447826000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net, Dmitry Mishin <dim@openvz.org>,
       Vasily Averin <vvs@openvz.org>, Kirill Korotaev <dev@openvz.org>
Subject: [patch 04/23] NETFILTER: ip_tables: fix module refcount leaks in compat error paths
Content-Disposition: inline; filename=netfilter-ip_tables-fix-module-refcount-leaks-in-compat-error-paths.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

Based on patch by myself with additional fixes from Dmitry Mishin <dim@openvz.org>.

Signed-off-by: Dmitry Mishin <dim@openvz.org>
Acked-by: Vasily Averin <vvs@openvz.org>
Acked-by: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
commit 94a3d63f9ca6cb404f62ee4186d20fec3e8bdc97
tree 86873a5eff586598eceabdbe4c042c55f62d4fbc
parent efb1447a67abac93048ad7af0c59cd9b5a9177a6
author Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:23:20 +0100
committer Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:23:20 +0100

 net/ipv4/netfilter/ip_tables.c |   36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

--- linux-2.6.18.4.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.18.4/net/ipv4/netfilter/ip_tables.c
@@ -1537,7 +1537,7 @@ check_compat_entry_size_and_hooks(struct
 	ret = IPT_MATCH_ITERATE(e, compat_check_calc_match, name, &e->ip,
 			e->comefrom, &off, &j);
 	if (ret != 0)
-		goto out;
+		goto cleanup_matches;
 
 	t = ipt_get_target(e);
 	target = try_then_request_module(xt_find_target(AF_INET,
@@ -1547,7 +1547,7 @@ check_compat_entry_size_and_hooks(struct
 	if (IS_ERR(target) || !target) {
 		duprintf("check_entry: `%s' not found\n", t->u.user.name);
 		ret = target ? PTR_ERR(target) : -ENOENT;
-		goto out;
+		goto cleanup_matches;
 	}
 	t->u.kernel.target = target;
 
@@ -1574,7 +1574,10 @@ check_compat_entry_size_and_hooks(struct
 
 	(*i)++;
 	return 0;
+
 out:
+	module_put(t->u.kernel.target->me);
+cleanup_matches:
 	IPT_MATCH_ITERATE(e, cleanup_match, &j);
 	return ret;
 }
@@ -1597,18 +1600,16 @@ static inline int compat_copy_match_from
 	ret = xt_check_match(match, AF_INET, dm->u.match_size - sizeof(*dm),
 			     name, hookmask, ip->proto,
 			     ip->invflags & IPT_INV_PROTO);
-	if (ret)
-		return ret;
 
-	if (m->u.kernel.match->checkentry
+	if (!ret && m->u.kernel.match->checkentry
 	    && !m->u.kernel.match->checkentry(name, ip, match, dm->data,
 					      dm->u.match_size - sizeof(*dm),
 					      hookmask)) {
 		duprintf("ip_tables: check failed for `%s'.\n",
 			 m->u.kernel.match->name);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	return 0;
+	return ret;
 }
 
 static int compat_copy_entry_from_user(struct ipt_entry *e, void **dstptr,
@@ -1630,7 +1631,7 @@ static int compat_copy_entry_from_user(s
 	ret = IPT_MATCH_ITERATE(e, compat_copy_match_from_user, dstptr, size,
 			name, &de->ip, de->comefrom);
 	if (ret)
-		goto out;
+		goto err;
 	de->target_offset = e->target_offset - (origsize - *size);
 	t = ipt_get_target(e);
 	target = t->u.kernel.target;
@@ -1653,22 +1654,22 @@ static int compat_copy_entry_from_user(s
 			      name, e->comefrom, e->ip.proto,
 			      e->ip.invflags & IPT_INV_PROTO);
 	if (ret)
-		goto out;
+		goto err;
 
 	ret = -EINVAL;
 	if (t->u.kernel.target == &ipt_standard_target) {
 		if (!standard_check(t, *size))
-			goto out;
+			goto err;
 	} else if (t->u.kernel.target->checkentry
 		   && !t->u.kernel.target->checkentry(name, de, target,
 				t->data, t->u.target_size - sizeof(*t),
 				de->comefrom)) {
 		duprintf("ip_tables: compat: check failed for `%s'.\n",
 			 t->u.kernel.target->name);
-		goto out;
+		goto err;
 	}
 	ret = 0;
-out:
+ err:
 	return ret;
 }
 
@@ -1682,7 +1683,7 @@ translate_compat_table(const char *name,
 		unsigned int *hook_entries,
 		unsigned int *underflows)
 {
-	unsigned int i;
+	unsigned int i, j;
 	struct xt_table_info *newinfo, *info;
 	void *pos, *entry0, *entry1;
 	unsigned int size;
@@ -1700,21 +1701,21 @@ translate_compat_table(const char *name,
 	}
 
 	duprintf("translate_compat_table: size %u\n", info->size);
-	i = 0;
+	j = 0;
 	xt_compat_lock(AF_INET);
 	/* Walk through entries, checking offsets. */
 	ret = IPT_ENTRY_ITERATE(entry0, total_size,
 				check_compat_entry_size_and_hooks,
 				info, &size, entry0,
 				entry0 + total_size,
-				hook_entries, underflows, &i, name);
+				hook_entries, underflows, &j, name);
 	if (ret != 0)
 		goto out_unlock;
 
 	ret = -EINVAL;
-	if (i != number) {
+	if (j != number) {
 		duprintf("translate_compat_table: %u not %u entries\n",
-			 i, number);
+			 j, number);
 		goto out_unlock;
 	}
 
@@ -1773,6 +1774,7 @@ translate_compat_table(const char *name,
 free_newinfo:
 	xt_free_table_info(newinfo);
 out:
+	IPT_ENTRY_ITERATE(entry0, total_size, cleanup_entry, &j);
 	return ret;
 out_unlock:
 	compat_flush_offsets();

--
