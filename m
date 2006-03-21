Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWCUQdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWCUQdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWCUQa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30476 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030308AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Luke Yang <luke.adi@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 36/46] kbuild: Fix bug in crc symbol generating of kernel and modules
In-Reply-To: <11429580571656-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <11429580571509-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scripts/genksyms/genksyms.c uses hardcoded "__crc_" prefix for
crc symbols in kernel and modules. The prefix should be replaced by
"MODULE_SYMBOL_PREFIX##__crc_" otherwise there will be warnings when
MODULE_SYMBOL_PREFIX is not NULL.

I am sorry my last patch for this issue is actually wrong. I revert
it in this patch.

Signed-off-by: Luke Yang <luke.adi@gmail.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/genksyms/genksyms.c |    4 ++--
 scripts/mod/modpost.c       |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

f7b05e64bdb2fcc4b2dc94a4bd9426adc70c9599
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 416a694..ef8822e 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -32,7 +32,7 @@
 #endif /* __GNU_LIBRARY__ */
 
 #include "genksyms.h"
-
+#include "../mod/elfconfig.h"
 /*----------------------------------------------------------------------*/
 
 #define HASH_BUCKETS  4096
@@ -458,7 +458,7 @@ export_symbol(const char *name)
 	fputs(">\n", debugfile);
 
       /* Used as a linker script. */
-      printf("__crc_%s = 0x%08lx ;\n", name, crc);
+      printf("%s__crc_%s = 0x%08lx ;\n", MODULE_SYMBOL_PREFIX, name, crc);
     }
 }
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e2bf4c9..30f3ac8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -346,8 +346,8 @@ static void parse_elf_finish(struct elf_
 	release_file(info->hdr, info->size);
 }
 
-#define CRC_PFX     "__crc_"
-#define KSYMTAB_PFX "__ksymtab_"
+#define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
+#define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
 
 static void handle_modversions(struct module *mod, struct elf_info *info,
 			       Elf_Sym *sym, const char *symname)
-- 
1.0.GIT


