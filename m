Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVLFVSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVLFVSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVLFVSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:18:38 -0500
Received: from fmr21.intel.com ([143.183.121.13]:54713 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030248AbVLFVSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:18:37 -0500
Date: Tue, 6 Dec 2005 13:18:24 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, prasanna@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH] kprobes: fix race in aggregate kprobe registration
Message-ID: <20051206131823.A8726@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20051206051711.GA3206@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051206051711.GA3206@in.ibm.com>; from ananth@in.ibm.com on Tue, Dec 06, 2005 at 10:47:11AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 10:47:11AM +0530, Ananth N Mavinakayanahalli wrote:
> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> When registering multiple kprobes at the same address, we leave a small
> window where the kprobe hlist will not contain a reference to the
> registered kprobe, leading to potentially, a system crash if the
> breakpoint is hit on another processor.
> 
> Patch below changes the order of hlist updation to make sure that there
> is always a reference to the kprobe at the location.

Hi Ananth,
	How do you like this patch? Here the old entry
will be replace with the new entry automically. 

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

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
