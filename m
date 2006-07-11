Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWGKEj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWGKEj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWGKEj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:39:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31646 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751405AbWGKEj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:39:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Woodhouse <dwmw2@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd: Remove the last of the inter_module calls from mtd.
Date: Mon, 10 Jul 2006 22:38:08 -0600
Message-ID: <m1fyh8kb7z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David before you removed the intermodule code from mtd
I had worked up a similar but slightly more comprehensive patch.
Unfortunately I got distracted before I could push it out
of my tree.

I now have a spare minute and it looks like there
is still some value in the remainder of my patch.
It  makes the code some simpler and removes
the modular vs non-modular special case.

I have some concerns about the code size of symbol_request
as it is always expanded inline but someone else
can optimize that.  Using it is a clear win for code
simplicity.

The rules for using weak symbols.
- You must refer to the symbol by name.
- You must pair symbol_get/symbol_put or their equivalents
  to get the module counts right.  For mtd I used
  symbol_request and symbol_put_addr.
- When using symbol_request you don't care what
  module a symbol is in, as modprobe figures
  that out for you, by looking in modules.symbols.
- The symbol must be exported from the module
  or you can't see it.

So very simply: modified the module probe routines
to call symbol_request, and later symbol_put_addr.

I modified the modules to export their probe routines.

Everywhere the inter_module code was killed.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/mtd/chips/cfi_cmdset_0020.c |   12 +++----
 drivers/mtd/chips/gen_probe.c       |   62 +++++++++++------------------------
 include/linux/mtd/cfi.h             |    1 -
 3 files changed, 25 insertions(+), 50 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0020.c b/drivers/mtd/chips/cfi_cmdset_0020.c
index fae70a5..b04a3ba 100644
--- a/drivers/mtd/chips/cfi_cmdset_0020.c
+++ b/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -107,12 +107,12 @@ static void cfi_tell_features(struct cfi
 }
 #endif
 
-/* This routine is made available to other mtd code via
- * inter_module_register.  It must only be accessed through
- * inter_module_get which will bump the use count of this module.  The
- * addresses passed back in cfi are valid as long as the use count of
- * this module is non-zero, i.e. between inter_module_get and
- * inter_module_put.  Keith Owens <kaos@ocs.com.au> 29 Oct 2000.
+/* This routine is made available to other mtd as a weak symbol.
+ * It must only be accessed with symbol_get which will bump the
+ * use count of this module.  Once the probe function is complete
+ * it is safe to call symbol_put, as the probe function will have
+ * increased it's module count if successful.
+ * Eric Biederman <ebiederm@xmission.com> 11 April 2006.
  */
 struct mtd_info *cfi_cmdset_0020(struct map_info *map, int primary)
 {
diff --git a/drivers/mtd/chips/gen_probe.c b/drivers/mtd/chips/gen_probe.c
index cdb0f59..8b3b462 100644
--- a/drivers/mtd/chips/gen_probe.c
+++ b/drivers/mtd/chips/gen_probe.c
@@ -201,65 +201,41 @@ extern cfi_cmdset_fn_t cfi_cmdset_0001;
 extern cfi_cmdset_fn_t cfi_cmdset_0002;
 extern cfi_cmdset_fn_t cfi_cmdset_0020;
 
-static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map,
-						  int primary)
-{
-	struct cfi_private *cfi = map->fldrv_priv;
-	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
-#ifdef CONFIG_MODULES
-	char probename[16+sizeof(MODULE_SYMBOL_PREFIX)];
-	cfi_cmdset_fn_t *probe_function;
-
-	sprintf(probename, MODULE_SYMBOL_PREFIX "cfi_cmdset_%4.4X", type);
-
-	probe_function = __symbol_get(probename);
-	if (!probe_function) {
-		request_module(probename + sizeof(MODULE_SYMBOL_PREFIX) - 1);
-		probe_function = __symbol_get(probename);
-	}
-
-	if (probe_function) {
-		struct mtd_info *mtd;
-
-		mtd = (*probe_function)(map, primary);
-		/* If it was happy, it'll have increased its own use count */
-		symbol_put_addr(probe_function);
-		return mtd;
-	}
-#endif
-	printk(KERN_NOTICE "Support for command set %04X not present\n", type);
-
-	return NULL;
-}
-
 static struct mtd_info *check_cmd_set(struct map_info *map, int primary)
 {
 	struct cfi_private *cfi = map->fldrv_priv;
 	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
+	cfi_cmdset_fn_t *probe_function = NULL;
+	struct mtd_info *mtd = NULL;
 
 	if (type == P_ID_NONE || type == P_ID_RESERVED)
 		return NULL;
 
 	switch(type){
-		/* We need these for the !CONFIG_MODULES case,
-		   because symbol_get() doesn't work there */
-#ifdef CONFIG_MTD_CFI_INTELEXT
 	case 0x0001:
 	case 0x0003:
 	case 0x0200:
-		return cfi_cmdset_0001(map, primary);
-#endif
-#ifdef CONFIG_MTD_CFI_AMDSTD
+		probe_function = symbol_request(cfi_cmdset_0001);
+		break;
 	case 0x0002:
-		return cfi_cmdset_0002(map, primary);
-#endif
-#ifdef CONFIG_MTD_CFI_STAA
+		probe_function = symbol_request(cfi_cmdset_0002);
+		break;
         case 0x0020:
-		return cfi_cmdset_0020(map, primary);
-#endif
+		probe_function = symbol_request(cfi_cmdset_0020);
+		break;
 	default:
-		return cfi_cmdset_unknown(map, primary);
+		printk(KERN_NOTICE "Support for command set %04X not implemented\n",
+			type);
+		break;
 	}
+	if (probe_function) {
+		mtd = (*probe_function)(map, primary);
+
+		/* If it was happy, it will have increased its own use count */
+		symbol_put_addr(probe_function);
+	}
+
+	return mtd;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index 09bfae6..a372b06 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -242,7 +242,6 @@ struct cfi_private {
 	int mfr, id;
 	int numchips;
 	unsigned long chipshift; /* Because they're of the same type */
-	const char *im_name;	 /* inter_module name for cmdset_setup */
 	struct flchip chips[0];  /* per-chip data structure for each chip */
 };
 
-- 
1.4.1.gac83a

