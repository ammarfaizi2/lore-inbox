Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbUKPQwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbUKPQwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUKPQvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:51:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262042AbUKPQsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:48:20 -0500
Date: Tue, 16 Nov 2004 11:48:10 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>
Subject: Re: 2.6.10-rc2-mm1 - SELinux atomic_dec_and_test() bug
In-Reply-To: <20041116014213.2128aca9.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0411161136080.26462-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atomic underflow debugging in this kernel exposed a bug in the AVC RCU
code, fix below.  The effect of this bug would be delayed node
reclamation.

Signed-off-by: James Morris <jmorris@redhat.com>

---

diff -purN -X dontdiff linux-2.6.10-rc2-mm1.o/security/selinux/avc.c linux-2.6.10-rc2-mm1.w/security/selinux/avc.c
--- linux-2.6.10-rc2-mm1.o/security/selinux/avc.c	2004-11-16 10:57:16.000000000 -0500
+++ linux-2.6.10-rc2-mm1.w/security/selinux/avc.c	2004-11-16 11:27:19.000000000 -0500
@@ -269,7 +269,7 @@ static inline int avc_reclaim_node(void)
 			continue;
 
 		list_for_each_entry(node, &avc_cache.slots[hvalue], list) {
-			if (!atomic_dec_and_test(&node->ae.used)) {
+			if (atomic_dec_and_test(&node->ae.used)) {
 				/* Recently Unused */
 				avc_node_delete(node);
 				avc_cache_stats_incr(reclaims);

