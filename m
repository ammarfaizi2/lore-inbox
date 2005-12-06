Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVLFFPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVLFFPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 00:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVLFFPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 00:15:33 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40856 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932425AbVLFFPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 00:15:32 -0500
Date: Tue, 6 Dec 2005 10:47:11 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, prasanna@in.ibm.com, anil.s.keshavamurthy@intel.com
Subject: [PATCH] kprobes: fix race in aggregate kprobe registration
Message-ID: <20051206051711.GA3206@in.ibm.com>
Reply-To: ananth@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

When registering multiple kprobes at the same address, we leave a small
window where the kprobe hlist will not contain a reference to the
registered kprobe, leading to potentially, a system crash if the
breakpoint is hit on another processor.

Patch below changes the order of hlist updation to make sure that there
is always a reference to the kprobe at the location.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Acked-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Acked-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---


 kernel/kprobes.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15-rc5/kernel/kprobes.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/kprobes.c
+++ linux-2.6.15-rc5/kernel/kprobes.c
@@ -400,9 +400,9 @@ static inline void add_aggr_kprobe(struc
 	list_add_rcu(&p->list, &ap->list);
 
 	INIT_HLIST_NODE(&ap->hlist);
-	hlist_del_rcu(&p->hlist);
 	hlist_add_head_rcu(&ap->hlist,
 		&kprobe_table[hash_ptr(ap->addr, KPROBE_HASH_BITS)]);
+	hlist_del_rcu(&p->hlist);
 }
 
 /*
