Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVCPFkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVCPFkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVCPFkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:40:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:55444 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262526AbVCPFjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:39:48 -0500
Date: Wed, 16 Mar 2005 11:12:01 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: [PATCH] kprobes: incorrect spin_unlock_irqrestore() call in register_kprobe()
Message-ID: <20050316054201.GD10456@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

register_kprobe() routine was calling spin_unlock_irqrestore() 
wrongly. 
This patch removes unwanted spin_unlock_irqrestore() call in 
register_kprobe() routine.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

---



---

 linux-2.6.11-prasanna/kernel/kprobes.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN kernel/kprobes.c~kprobes-incorrect-returnval kernel/kprobes.c
--- linux-2.6.11/kernel/kprobes.c~kprobes-incorrect-returnval	2005-03-16 11:03:42.000000000 +0530
+++ linux-2.6.11-prasanna/kernel/kprobes.c	2005-03-16 11:03:42.000000000 +0530
@@ -79,7 +79,7 @@ int register_kprobe(struct kprobe *p)
 	unsigned long flags = 0;
 
 	if ((ret = arch_prepare_kprobe(p)) != 0) {
-		goto out;
+		goto rm_kprobe;
 	}
 	spin_lock_irqsave(&kprobe_lock, flags);
 	INIT_HLIST_NODE(&p->hlist);
@@ -96,8 +96,9 @@ int register_kprobe(struct kprobe *p)
 	*p->addr = BREAKPOINT_INSTRUCTION;
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
-      out:
+out:
 	spin_unlock_irqrestore(&kprobe_lock, flags);
+rm_kprobe:
 	if (ret == -EEXIST)
 		arch_remove_kprobe(p);
 	return ret;

_

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
