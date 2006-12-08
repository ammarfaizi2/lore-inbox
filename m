Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947543AbWLIAGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947543AbWLIAGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947533AbWLHX7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:59:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37490 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947540AbWLHX7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:59:23 -0500
Message-Id: <20061208235850.726185000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:57:54 -0800
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
Subject: [patch 03/32] EBTABLES: Fix wraparounds in ebt_entries verification.
Content-Disposition: inline; filename=ebtables-fix-wraparounds-in-ebt_entries-verification.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Al Viro <viro@zeniv.linux.org.uk>

We need to verify that
	a) we are not too close to the end of buffer to dereference
	b) next entry we'll be checking won't be _before_ our

While we are at it, don't subtract unrelated pointers...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/bridge/netfilter/ebtables.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- linux-2.6.19.orig/net/bridge/netfilter/ebtables.c
+++ linux-2.6.19/net/bridge/netfilter/ebtables.c
@@ -401,13 +401,17 @@ ebt_check_entry_size_and_hooks(struct eb
    struct ebt_entries **hook_entries, unsigned int *n, unsigned int *cnt,
    unsigned int *totalcnt, unsigned int *udc_cnt, unsigned int valid_hooks)
 {
+	unsigned int offset = (char *)e - newinfo->entries;
+	size_t left = (limit - base) - offset;
 	int i;
 
+	if (left < sizeof(unsigned int))
+		goto Esmall;
+
 	for (i = 0; i < NF_BR_NUMHOOKS; i++) {
 		if ((valid_hooks & (1 << i)) == 0)
 			continue;
-		if ( (char *)hook_entries[i] - base ==
-		   (char *)e - newinfo->entries)
+		if ((char *)hook_entries[i] == base + offset)
 			break;
 	}
 	/* beginning of a new chain
@@ -428,11 +432,8 @@ ebt_check_entry_size_and_hooks(struct eb
 			return -EINVAL;
 		}
 		/* before we look at the struct, be sure it is not too big */
-		if ((char *)hook_entries[i] + sizeof(struct ebt_entries)
-		   > limit) {
-			BUGPRINT("entries_size too small\n");
-			return -EINVAL;
-		}
+		if (left < sizeof(struct ebt_entries))
+			goto Esmall;
 		if (((struct ebt_entries *)e)->policy != EBT_DROP &&
 		   ((struct ebt_entries *)e)->policy != EBT_ACCEPT) {
 			/* only RETURN from udc */
@@ -455,6 +456,8 @@ ebt_check_entry_size_and_hooks(struct eb
 		return 0;
 	}
 	/* a plain old entry, heh */
+	if (left < sizeof(struct ebt_entry))
+		goto Esmall;
 	if (sizeof(struct ebt_entry) > e->watchers_offset ||
 	   e->watchers_offset > e->target_offset ||
 	   e->target_offset >= e->next_offset) {
@@ -466,10 +469,16 @@ ebt_check_entry_size_and_hooks(struct eb
 		BUGPRINT("target size too small\n");
 		return -EINVAL;
 	}
+	if (left < e->next_offset)
+		goto Esmall;
 
 	(*cnt)++;
 	(*totalcnt)++;
 	return 0;
+
+Esmall:
+	BUGPRINT("entries_size too small\n");
+	return -EINVAL;
 }
 
 struct ebt_cl_stack

--
