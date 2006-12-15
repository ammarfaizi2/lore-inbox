Return-Path: <linux-kernel-owner+w=401wt.eu-S964985AbWLOBly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWLOBly (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWLOBfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:35:17 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46154 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964992AbWLOBfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:35:12 -0500
Message-Id: <20061215013511.555351000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:40 -0800
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
Subject: [patch 03/24] EBTABLES: Verify that ebt_entries have zero ->distinguisher.
Content-Disposition: inline; filename=ebtables-verify-that-ebt_entries-have-zero-distinguisher.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Al Viro <viro@zeniv.linux.org.uk>

We need that for iterator to work; existing check had been too weak.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/bridge/netfilter/ebtables.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.18.5.orig/net/bridge/netfilter/ebtables.c
+++ linux-2.6.18.5/net/bridge/netfilter/ebtables.c
@@ -439,7 +439,7 @@ ebt_check_entry_size_and_hooks(struct eb
 	/* beginning of a new chain
 	   if i == NF_BR_NUMHOOKS it must be a user defined chain */
 	if (i != NF_BR_NUMHOOKS || !(e->bitmask & EBT_ENTRY_OR_ENTRIES)) {
-		if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) != 0) {
+		if (e->bitmask != 0) {
 			/* we make userspace set this right,
 			   so there is no misunderstanding */
 			BUGPRINT("EBT_ENTRY_OR_ENTRIES shouldn't be set "
@@ -522,7 +522,7 @@ ebt_get_udc_positions(struct ebt_entry *
 	int i;
 
 	/* we're only interested in chain starts */
-	if (e->bitmask & EBT_ENTRY_OR_ENTRIES)
+	if (e->bitmask)
 		return 0;
 	for (i = 0; i < NF_BR_NUMHOOKS; i++) {
 		if ((valid_hooks & (1 << i)) == 0)
@@ -572,7 +572,7 @@ ebt_cleanup_entry(struct ebt_entry *e, u
 {
 	struct ebt_entry_target *t;
 
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 	/* we're done */
 	if (cnt && (*cnt)-- == 0)
@@ -598,7 +598,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	int ret;
 
 	/* don't mess with the struct ebt_entries */
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 
 	if (e->bitmask & ~EBT_F_MASK) {
@@ -1316,7 +1316,7 @@ static inline int ebt_make_names(struct 
 	char *hlp;
 	struct ebt_entry_target *t;
 
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 
 	hlp = ubase - base + (char *)e + e->target_offset;

--
