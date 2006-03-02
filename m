Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWCBKfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWCBKfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWCBKfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:35:33 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:1944 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751432AbWCBKfd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:35:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Asjorawjh51JhQLG8m0qraSnhrLCFI73p3cxky6xlnFEF2vImN6snQxoSeSw01AreRFUB8MkPHYtSExyA/hPKeZgswWVBq/WdXfpwh6tBJFG//4M38pR77Sw58fSJk1OYbyOqYGRrTGi9fbyg5b47eeMZYFGrlboEBC3DpZ5N8U=
Message-ID: <489ecd0c0603020235l45e70ec8s91a0504507394b8@mail.gmail.com>
Date: Thu, 2 Mar 2006 18:35:31 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix bug in crc symbol generating of kernel and modules
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   The scripts/genksyms/genksyms.c uses hardcoded "__crc_" prefix for
crc symbols in kernel and modules. The prefix should be replaced by 
"MODULE_SYMBOL_PREFIX##__crc_" otherwise there will be warnings when
MODULE_SYMBOL_PREFIX is not NULL.

   I am sorry my last patch for this issue is actually wrong. I revert
it in this patch.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 416a694..ef4ba91 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -32,6 +32,7 @@
 #endif /* __GNU_LIBRARY__ */

 #include "genksyms.h"
+#include "../mod/elfconfig.h"

 /*----------------------------------------------------------------------*/

@@ -458,7 +459,7 @@ export_symbol(const char *name)
        fputs(">\n", debugfile);

       /* Used as a linker script. */
-      printf("__crc_%s = 0x%08lx ;\n", name, crc);
+     printf("%s__crc_%s = 0x%08lx ;\n", MODULE_SYMBOL_PREFIX, name, crc);
     }
 }

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f70ff13..ac595ce 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -326,8 +326,8 @@ parse_elf_finish(struct elf_info *info)
        release_file(info->hdr, info->size);
 }

-#define CRC_PFX     "__crc_"
-#define KSYMTAB_PFX "__ksymtab_"
+#define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
+#define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"

 void
 handle_modversions(struct module *mod, struct elf_info *info,

--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
