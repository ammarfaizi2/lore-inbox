Return-Path: <linux-kernel-owner+w=401wt.eu-S965002AbWLOBf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWLOBf5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWLOBfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:35:24 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46159 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964929AbWLOBfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:35:14 -0500
Message-Id: <20061215013532.501879000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:42 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Al Viro <viro@zeniv.linux.org.uk>
Subject: [patch 05/24] EBTABLES: Prevent wraparounds in checks for entry components sizes.
Content-Disposition: inline; filename=ebtables-prevent-wraparounds-in-checks-for-entry-components-sizes.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Al Viro <viro@zeniv.linux.org.uk>

---
 net/bridge/netfilter/ebtables.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- linux-2.6.18.5.orig/net/bridge/netfilter/ebtables.c
+++ linux-2.6.18.5/net/bridge/netfilter/ebtables.c
@@ -360,10 +360,11 @@ ebt_check_match(struct ebt_entry_match *
    const char *name, unsigned int hookmask, unsigned int *cnt)
 {
 	struct ebt_match *match;
+	size_t left = ((char *)e + e->watchers_offset) - (char *)m;
 	int ret;
 
-	if (((char *)m) + m->match_size + sizeof(struct ebt_entry_match) >
-	   ((char *)e) + e->watchers_offset)
+	if (left < sizeof(struct ebt_entry_match) ||
+	    left - sizeof(struct ebt_entry_match) < m->match_size)
 		return -EINVAL;
 	match = find_match_lock(m->u.name, &ret, &ebt_mutex);
 	if (!match)
@@ -389,10 +390,11 @@ ebt_check_watcher(struct ebt_entry_watch
    const char *name, unsigned int hookmask, unsigned int *cnt)
 {
 	struct ebt_watcher *watcher;
+	size_t left = ((char *)e + e->target_offset) - (char *)w;
 	int ret;
 
-	if (((char *)w) + w->watcher_size + sizeof(struct ebt_entry_watcher) >
-	   ((char *)e) + e->target_offset)
+	if (left < sizeof(struct ebt_entry_watcher) ||
+	   left - sizeof(struct ebt_entry_watcher) < w->watcher_size)
 		return -EINVAL;
 	watcher = find_watcher_lock(w->u.name, &ret, &ebt_mutex);
 	if (!watcher)
@@ -595,6 +597,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	struct ebt_entry_target *t;
 	struct ebt_target *target;
 	unsigned int i, j, hook = 0, hookmask = 0;
+	size_t gap = e->next_offset - e->target_offset;
 	int ret;
 
 	/* don't mess with the struct ebt_entries */
@@ -656,8 +659,7 @@ ebt_check_entry(struct ebt_entry *e, str
 
 	t->u.target = target;
 	if (t->u.target == &ebt_standard_target) {
-		if (e->target_offset + sizeof(struct ebt_standard_target) >
-		   e->next_offset) {
+		if (gap < sizeof(struct ebt_standard_target)) {
 			BUGPRINT("Standard target size too big\n");
 			ret = -EFAULT;
 			goto cleanup_watchers;
@@ -668,8 +670,7 @@ ebt_check_entry(struct ebt_entry *e, str
 			ret = -EFAULT;
 			goto cleanup_watchers;
 		}
-	} else if ((e->target_offset + t->target_size +
-	   sizeof(struct ebt_entry_target) > e->next_offset) ||
+	} else if (t->target_size > gap - sizeof(struct ebt_entry_target) ||
 	   (t->u.target->check &&
 	   t->u.target->check(name, hookmask, e, t->data, t->target_size) != 0)){
 		module_put(t->u.target->me);

--
