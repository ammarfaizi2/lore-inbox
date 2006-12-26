Return-Path: <linux-kernel-owner+w=401wt.eu-S932744AbWLZSAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbWLZSAJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 13:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWLZSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 13:00:09 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:41508 "EHLO
	liaag2af.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932744AbWLZSAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 13:00:07 -0500
Date: Tue, 26 Dec 2006 12:54:22 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] ebtables: don't compute gap before checking struct
  type
To: Bart De Schuymer <bart.de.schuymer@pandora.be>
Cc: Al Viro <viro@ftp.linux.org.uk>, Patrick McHardy <kaber@trash.net>,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       netdev@vger.kernel.org
Message-ID: <200612261256_MC3-1-D669-14A1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot compute the gap until we know we have a 'struct ebt_entry'
and not 'struct ebt_entries'.  Failure to check can cause crash.

Tested by Santiago Garcia Mantinan <manty@manty.net>

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---
Can we get this upstream quickly?  The bug's also in 2.6.19.1 and
2.6.18.6.

--- 2.6.20-rc1-32smp.orig/net/bridge/netfilter/ebtables.c
+++ 2.6.20-rc1-32smp/net/bridge/netfilter/ebtables.c
@@ -610,7 +610,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	struct ebt_entry_target *t;
 	struct ebt_target *target;
 	unsigned int i, j, hook = 0, hookmask = 0;
-	size_t gap = e->next_offset - e->target_offset;
+	size_t gap;
 	int ret;
 
 	/* don't mess with the struct ebt_entries */
@@ -660,6 +660,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	if (ret != 0)
 		goto cleanup_watchers;
 	t = (struct ebt_entry_target *)(((char *)e) + e->target_offset);
+	gap = e->next_offset - e->target_offset;
 	target = find_target_lock(t->u.name, &ret, &ebt_mutex);
 	if (!target)
 		goto cleanup_watchers;
-- 
MBTI: IXTP
