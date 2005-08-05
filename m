Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVHEPmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVHEPmj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVHEPjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:39:37 -0400
Received: from smtp6.clb.oleane.net ([213.56.31.26]:23234 "EHLO
	smtp6.clb.oleane.net") by vger.kernel.org with ESMTP
	id S263056AbVHEPgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:36:47 -0400
Date: Fri, 5 Aug 2005 17:36:32 +0200
From: Christophe Lucas <clucas@rotomalug.org>
To: akpm@osdl.org, kernel-janitors@lists.osdl.org
Cc: domen@coderock.org, linux-kernel@vger.kernel.org
Message-ID: <20050805153632.GH5233@rhum.iomeda.fr>
Mime-Version: 1.0
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux / 2.6.13-rc3-kj (i686)
X-Homepage: http://odie.mcom.fr/~clucas/
X-Crypto: GnuPG/1.2.4 http://www.gnupg.org
X-GPG-Key: http://odie.mcom.fr/~clucas/downloads/clucas-public-key.txt
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Mail-From: clucas@rotomalug.org
Subject: [PATCH] sh64 (mm/fault.c): procfs_failure && create_proc*
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 3.1 (built mer oct 29 11:46:13 CET 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

description:
audit return code of create_proc_* function is a entry in janitors
TODO list. Audit this return and printk() when it fails, can spam a lot
system without compiled proc support. So this patch can audit return
code by means of procfs_failure().

Signed-off-by: Christophe Lucas <clucas@rotomalug.org>

diff -urpNX dontdiff linux-2.6.13-rc4-mm1.orig/arch/sh64/mm/fault.c linux-2.6.13-rc4-mm1/arch/sh64/mm/fault.c
--- linux-2.6.13-rc4-mm1.orig/arch/sh64/mm/fault.c	2005-07-29 00:44:44.000000000 +0200
+++ linux-2.6.13-rc4-mm1/arch/sh64/mm/fault.c	2005-08-03 12:35:19.000000000 +0200
@@ -592,8 +592,11 @@ tlb_proc_info(char *buf, char **start, o
 
 static int __init register_proc_tlb(void)
 {
-  create_proc_read_entry("tlb", 0, NULL, tlb_proc_info, NULL);
-  return 0;
+	struct proc_dir_entry* ent;
+	ent = create_proc_read_entry("tlb", 0, NULL, tlb_proc_info, NULL);
+	if (!ent)
+		procfs_failure("fault.c: Unable to create tlb /proc entry.\n");
+	return 0;
 }
 
 __initcall(register_proc_tlb);
