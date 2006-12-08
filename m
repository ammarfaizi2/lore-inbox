Return-Path: <linux-kernel-owner+w=401wt.eu-S1947529AbWLHX6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947529AbWLHX6v (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947522AbWLHX6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:58:50 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37354 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947526AbWLHX6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:58:11 -0500
Message-Id: <20061209000020.689976000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:04 -0800
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
Subject: [patch 13/32] NETFILTER: Fix iptables compat hook validation
Content-Disposition: inline; filename=netfilter-fix-iptables-compat-hook-validation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Dmitry Mishin <dim@openvz.org>

In compat mode, matches and targets valid hooks checks always successful due
to not initialized e->comefrom field yet. This patch separates this checks from
translation code and moves them after mark_source_chains() call, where these
marks are initialized.

Signed-off-by: Dmitry Mishin <dim@openvz.org>
Signed-off-by; Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
commit 14f5487cb9bd34cd59360d2cac7dccac9b27e8ce
tree fab7cabcdb7fe450ff47bf42918f845ff3da1b86
parent 756c508367e95d6f963502e4feecb8c76aeee332
author Dmitry Mishin <dim@openvz.org> Mon, 04 Dec 2006 12:19:35 +0100
committer Patrick McHardy <kaber@trash.net> Mon, 04 Dec 2006 12:19:35 +0100

 net/ipv4/netfilter/ip_tables.c |   78 ++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 27 deletions(-)

--- linux-2.6.19.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.19/net/ipv4/netfilter/ip_tables.c
@@ -1516,25 +1516,8 @@ static inline int compat_copy_match_from
 	void **dstptr, compat_uint_t *size, const char *name,
 	const struct ipt_ip *ip, unsigned int hookmask)
 {
-	struct ipt_entry_match *dm;
-	struct ipt_match *match;
-	int ret;
-
-	dm = (struct ipt_entry_match *)*dstptr;
-	match = m->u.kernel.match;
 	xt_compat_match_from_user(m, dstptr, size);
-
-	ret = xt_check_match(match, AF_INET, dm->u.match_size - sizeof(*dm),
-			     name, hookmask, ip->proto,
-			     ip->invflags & IPT_INV_PROTO);
-	if (!ret && m->u.kernel.match->checkentry
-	    && !m->u.kernel.match->checkentry(name, ip, match, dm->data,
-					      hookmask)) {
-		duprintf("ip_tables: check failed for `%s'.\n",
-			 m->u.kernel.match->name);
-		ret = -EINVAL;
-	}
-	return ret;
+	return 0;
 }
 
 static int compat_copy_entry_from_user(struct ipt_entry *e, void **dstptr,
@@ -1556,7 +1539,7 @@ static int compat_copy_entry_from_user(s
 	ret = IPT_MATCH_ITERATE(e, compat_copy_match_from_user, dstptr, size,
 			name, &de->ip, de->comefrom);
 	if (ret)
-		goto err;
+		return ret;
 	de->target_offset = e->target_offset - (origsize - *size);
 	t = ipt_get_target(e);
 	target = t->u.kernel.target;
@@ -1569,26 +1552,62 @@ static int compat_copy_entry_from_user(s
 		if ((unsigned char *)de - base < newinfo->underflow[h])
 			newinfo->underflow[h] -= origsize - *size;
 	}
+	return ret;
+}
+
+static inline int compat_check_match(struct ipt_entry_match *m, const char *name,
+				const struct ipt_ip *ip, unsigned int hookmask)
+{
+	struct ipt_match *match;
+	int ret;
 
-	t = ipt_get_target(de);
+	match = m->u.kernel.match;
+	ret = xt_check_match(match, AF_INET, m->u.match_size - sizeof(*m),
+			     name, hookmask, ip->proto,
+			     ip->invflags & IPT_INV_PROTO);
+	if (!ret && m->u.kernel.match->checkentry
+	    && !m->u.kernel.match->checkentry(name, ip, match, m->data,
+					      hookmask)) {
+		duprintf("ip_tables: compat: check failed for `%s'.\n",
+			 m->u.kernel.match->name);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static inline int compat_check_target(struct ipt_entry *e, const char *name)
+{
+ 	struct ipt_entry_target *t;
+ 	struct ipt_target *target;
+ 	int ret;
+
+	t = ipt_get_target(e);
 	target = t->u.kernel.target;
 	ret = xt_check_target(target, AF_INET, t->u.target_size - sizeof(*t),
 			      name, e->comefrom, e->ip.proto,
 			      e->ip.invflags & IPT_INV_PROTO);
-	if (ret)
-		goto err;
-
-	if (t->u.kernel.target->checkentry
-		   && !t->u.kernel.target->checkentry(name, de, target,
-						      t->data, de->comefrom)) {
+	if (!ret && t->u.kernel.target->checkentry
+		   && !t->u.kernel.target->checkentry(name, e, target,
+						      t->data, e->comefrom)) {
 		duprintf("ip_tables: compat: check failed for `%s'.\n",
 			 t->u.kernel.target->name);
 		ret = -EINVAL;
 	}
-err:
 	return ret;
 }
 
+static inline int compat_check_entry(struct ipt_entry *e, const char *name)
+{
+	int ret;
+
+	ret = IPT_MATCH_ITERATE(e, compat_check_match, name, &e->ip,
+								e->comefrom);
+	if (ret)
+		return ret;
+
+	return compat_check_target(e, name);
+}
+
 static int
 translate_compat_table(const char *name,
 		unsigned int valid_hooks,
@@ -1677,6 +1696,11 @@ translate_compat_table(const char *name,
 	if (!mark_source_chains(newinfo, valid_hooks, entry1))
 		goto free_newinfo;
 
+	ret = IPT_ENTRY_ITERATE(entry1, newinfo->size, compat_check_entry,
+									name);
+	if (ret)
+		goto free_newinfo;
+
 	/* And one copy for every other CPU */
 	for_each_possible_cpu(i)
 		if (newinfo->entries[i] && newinfo->entries[i] != entry1)

--
