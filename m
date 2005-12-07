Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVLGR0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVLGR0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVLGR0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:26:11 -0500
Received: from fmr24.intel.com ([143.183.121.16]:30876 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751239AbVLGR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:26:10 -0500
Date: Wed, 7 Dec 2005 09:25:54 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, prasanna@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: [PATCH] kprobes: fix race in aggregate kprobe registration
Message-ID: <20051207092554.A19162@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20051206051711.GA3206@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051206051711.GA3206@in.ibm.com>; from ananth@in.ibm.com on Tue, Dec 06, 2005 at 10:47:11AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When registering multiple kprobes at the same address, we leave a small
window where the kprobe hlist will not contain a reference to the
registered kprobe, leading to potentially, a system crash if the
breakpoint is hit on another processor.

Patch below now automically relpace the old kprobe with the new
kprobe from the hash list.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Acked-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

 kernel/kprobes.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.15-rc5-mm1/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/kprobes.c
+++ linux-2.6.15-rc5-mm1/kernel/kprobes.c
@@ -399,10 +399,7 @@ static inline void add_aggr_kprobe(struc
 	INIT_LIST_HEAD(&ap->list);
 	list_add_rcu(&p->list, &ap->list);
 
-	INIT_HLIST_NODE(&ap->hlist);
-	hlist_del_rcu(&p->hlist);
-	hlist_add_head_rcu(&ap->hlist,
-		&kprobe_table[hash_ptr(ap->addr, KPROBE_HASH_BITS)]);
+	hlist_replace_rcu(&p->hlist, &ap->hlist);
 }
 
 /*
