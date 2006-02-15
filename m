Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWBOS7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWBOS7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWBOS7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:59:25 -0500
Received: from master.altlinux.org ([62.118.250.235]:36869 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750835AbWBOS7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:59:24 -0500
Date: Wed, 15 Feb 2006 21:58:55 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-abi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix module refcount leak in __set_personality()
Message-ID: <20060215185855.GE8670@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the change of personality does not lead to change of exec domain,
__set_personality() returned without releasing the module reference
acquired by lookup_exec_domain().

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

---

diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
index 867d6db..c01cead 100644
--- a/kernel/exec_domain.c
+++ b/kernel/exec_domain.c
@@ -140,6 +140,7 @@ __set_personality(u_long personality)
 	ep = lookup_exec_domain(personality);
 	if (ep == current_thread_info()->exec_domain) {
 		current->personality = personality;
+		module_put(ep->module);
 		return 0;
 	}
 
