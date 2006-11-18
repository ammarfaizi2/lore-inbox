Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753973AbWKRF6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753973AbWKRF6Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 00:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbWKRF6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 00:58:24 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:55285 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1753973AbWKRF6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 00:58:23 -0500
Date: Fri, 17 Nov 2006 21:52:40 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ak@suse.de, akpm <akpm@osdl.org>
Subject: [PATCH -mm] handle BUG=n
Message-Id: <20061117215240.cd49870d.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Handle BUG=n, GENERIC_BUG=n to prevent build errors:

arch/x86_64/kernel/built-in.o: In function `die':
(.text+0x3b3c): undefined reference to `report_bug'
arch/x86_64/kernel/built-in.o: In function `module_arch_cleanup':
(.text+0x10b60): undefined reference to `module_bug_cleanup'
arch/x86_64/kernel/built-in.o: In function `module_finalize':
(.text+0x10c98): undefined reference to `module_bug_finalize'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/linux/bug.h |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

--- linux-2619-rc5mm2.orig/include/linux/bug.h
+++ linux-2619-rc5mm2/include/linux/bug.h
@@ -3,6 +3,12 @@
 
 #include <asm/bug.h>
 
+enum bug_trap_type {
+	BUG_TRAP_TYPE_NONE = 0,
+	BUG_TRAP_TYPE_WARN = 1,
+	BUG_TRAP_TYPE_BUG = 2,
+};
+
 #ifdef CONFIG_GENERIC_BUG
 #include <linux/module.h>
 #include <asm-generic/bug.h>
@@ -12,12 +18,6 @@ static inline int is_warning_bug(const s
 	return bug->flags & BUGFLAG_WARNING;
 }
 
-enum bug_trap_type {
-	BUG_TRAP_TYPE_NONE = 0,
-	BUG_TRAP_TYPE_WARN = 1,
-	BUG_TRAP_TYPE_BUG = 2,
-};
-
 const struct bug_entry *find_bug(unsigned long bugaddr);
 
 enum bug_trap_type report_bug(unsigned long bug_addr);
@@ -29,5 +29,19 @@ void module_bug_cleanup(struct module *)
 /* These are defined by the architecture */
 int is_valid_bugaddr(unsigned long addr);
 
+#else	/* !CONFIG_GENERIC_BUG */
+
+static inline enum bug_trap_type report_bug(unsigned long bug_addr)
+{
+	return BUG_TRAP_TYPE_BUG;
+}
+static inline int  module_bug_finalize(const Elf_Ehdr *hdr,
+					const Elf_Shdr *sechdrs,
+					struct module *mod)
+{
+	return 0;
+}
+static inline void module_bug_cleanup(struct module *mod) {}
+
 #endif	/* CONFIG_GENERIC_BUG */
 #endif	/* _LINUX_BUG_H */


---
