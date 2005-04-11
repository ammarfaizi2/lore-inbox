Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVDKO4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVDKO4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVDKO43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:56:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41147 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261795AbVDKO40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:56:26 -0400
Date: Mon, 11 Apr 2005 20:27:19 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
Cc: systemtap@sources.redhat.com
Subject: [PATCH] Kprobes: Oops! in unregister_kprobe()
Message-ID: <20050411145719.GA18812@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find the patch below to fix Oops! in unregister_kprobe().
Please let me know if you any issues.

Thanks
Prasanna


kernel oops! when unregister_kprobe() is called on a non-registered
kprobe. This patch fixes the above problem by checking if the probe exists
before unregistering.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.12-rc2-prasanna/kernel/kprobes.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN kernel/kprobes.c~kprobes-unregister-oops-fix kernel/kprobes.c
--- linux-2.6.12-rc2/kernel/kprobes.c~kprobes-unregister-oops-fix	2005-04-11 17:23:34.000000000 +0530
+++ linux-2.6.12-rc2-prasanna/kernel/kprobes.c	2005-04-11 17:32:50.000000000 +0530
@@ -110,13 +110,17 @@ rm_kprobe:
 void unregister_kprobe(struct kprobe *p)
 {
 	unsigned long flags;
-	arch_remove_kprobe(p);
 	spin_lock_irqsave(&kprobe_lock, flags);
+	if (!get_kprobe(p->addr)) {
+		spin_unlock_irqrestore(&kprobe_lock, flags);
+		return;
+	}
 	*p->addr = p->opcode;
 	hlist_del(&p->hlist);
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 	spin_unlock_irqrestore(&kprobe_lock, flags);
+	arch_remove_kprobe(p);
 }
 
 

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
