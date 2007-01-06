Return-Path: <linux-kernel-owner+w=401wt.eu-S1751127AbXAFCcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbXAFCcn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXAFCcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:32:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36822 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbXAFCcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:32:11 -0500
Message-Id: <20070106023624.684400000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:35 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Chuck Ebbert <76306.1226@compuserve.com>,
       Patrick McHardy <kaber@trash.net>, Al Viro <viro@zeniv.linux.org.uk>
Subject: [patch 42/50] ebtables: dont compute gap before checking struct type
Content-Disposition: inline; filename=ebtables-don-t-compute-gap-before-checking-struct-type.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Chuck Ebbert <76306.1226@compuserve.com>

We cannot compute the gap until we know we have a 'struct ebt_entry'
and not 'struct ebt_entries'.  Failure to check can cause crash.

Tested-by: Santiago Garcia Mantinan <manty@manty.net>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/bridge/netfilter/ebtables.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.19.1.orig/net/bridge/netfilter/ebtables.c
+++ linux-2.6.19.1/net/bridge/netfilter/ebtables.c
@@ -575,7 +575,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	struct ebt_entry_target *t;
 	struct ebt_target *target;
 	unsigned int i, j, hook = 0, hookmask = 0;
-	size_t gap = e->next_offset - e->target_offset;
+	size_t gap;
 	int ret;
 
 	/* don't mess with the struct ebt_entries */
@@ -625,6 +625,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	if (ret != 0)
 		goto cleanup_watchers;
 	t = (struct ebt_entry_target *)(((char *)e) + e->target_offset);
+	gap = e->next_offset - e->target_offset;
 	target = find_target_lock(t->u.name, &ret, &ebt_mutex);
 	if (!target)
 		goto cleanup_watchers;

--
