Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWHDBoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWHDBoy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 21:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWHDBoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 21:44:54 -0400
Received: from mga07.intel.com ([143.182.124.22]:13654 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030279AbWHDBox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 21:44:53 -0400
X-IronPort-AV: i="4.07,209,1151910000"; 
   d="scan'208"; a="97244695:sNHT7938411677"
Date: Thu, 3 Aug 2006 18:33:35 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] fix potential stack overflow in mm/slab.c
Message-ID: <20060803183334.A27141@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On High end systems (1024 or so cpus) this can potentially cause stack
overflow. Fix the stack usage.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.18-rc3/mm/slab.c~	2006-08-03 15:00:40.634997600 -0700
+++ linux-2.6.18-rc3/mm/slab.c	2006-08-03 16:22:41.799866824 -0700
@@ -3603,22 +3603,27 @@ static void do_ccupdate_local(void *info
 static int do_tune_cpucache(struct kmem_cache *cachep, int limit,
 				int batchcount, int shared)
 {
-	struct ccupdate_struct new;
+	struct ccupdate_struct *new;
 	int i, err;
 
-	memset(&new.new, 0, sizeof(new.new));
+	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	memset(&new->new, 0, sizeof(new->new));
 	for_each_online_cpu(i) {
-		new.new[i] = alloc_arraycache(cpu_to_node(i), limit,
+		new->new[i] = alloc_arraycache(cpu_to_node(i), limit,
 						batchcount);
-		if (!new.new[i]) {
+		if (!new->new[i]) {
 			for (i--; i >= 0; i--)
-				kfree(new.new[i]);
+				kfree(new->new[i]);
+			kfree(new);
 			return -ENOMEM;
 		}
 	}
-	new.cachep = cachep;
+	new->cachep = cachep;
 
-	on_each_cpu(do_ccupdate_local, (void *)&new, 1, 1);
+	on_each_cpu(do_ccupdate_local, (void *)new, 1, 1);
 
 	check_irq_on();
 	cachep->batchcount = batchcount;
@@ -3626,7 +3631,7 @@ static int do_tune_cpucache(struct kmem_
 	cachep->shared = shared;
 
 	for_each_online_cpu(i) {
-		struct array_cache *ccold = new.new[i];
+		struct array_cache *ccold = new->new[i];
 		if (!ccold)
 			continue;
 		spin_lock_irq(&cachep->nodelists[cpu_to_node(i)]->list_lock);
@@ -3641,6 +3646,8 @@ static int do_tune_cpucache(struct kmem_
 		       cachep->name, -err);
 		BUG();
 	}
+
+	kfree(new);
 	return 0;
 }
 
