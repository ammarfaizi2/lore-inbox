Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVHHNwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVHHNwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVHHNwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:52:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:43725 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750828AbVHHNwY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:52:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: EXPORT_SYMBOL generates "is deprecated" noise
Date: Mon, 8 Aug 2005 15:46:22 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <251790000.1123438079@[10.10.2.4]> <253710000.1123439204@[10.10.2.4]>
In-Reply-To: <253710000.1123439204@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508081546.23125.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sünndag 07 August 2005 20:26, Martin J. Bligh wrote:
> Oh, I'm being an idiot and looking at the wrong tree. It's __deprecated,
> but I still can't think of a clean way to locally undefine that for
> just EXPORT_SYMBOL.

We could in theory create a new EXPORT_SYMBOL variant that does not
reference the symbol directly. This does a little less compile-time
checks but helps reduce the noise. The big advantage of this
would be that we could once again build kernels with -Werror on
developer machines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -182,21 +182,26 @@ void *__symbol_get_gpl(const char *symbo
 #endif
 
 /* For every exported symbol, place a struct in the __ksymtab section */
-#define __EXPORT_SYMBOL(sym, sec)				\
-	__CRC_SYMBOL(sym, sec)					\
-	static const char __kstrtab_##sym[]			\
+#define __EXPORT_SYMBOL(name, sym, sec)				\
+	__CRC_SYMBOL(name, sec)					\
+	static const char __kstrtab_##name[]			\
 	__attribute__((section("__ksymtab_strings")))		\
-	= MODULE_SYMBOL_PREFIX #sym;                    	\
-	static const struct kernel_symbol __ksymtab_##sym	\
+	= MODULE_SYMBOL_PREFIX #name;                    	\
+	static const struct kernel_symbol __ksymtab_##name	\
 	__attribute_used__					\
 	__attribute__((section("__ksymtab" sec), unused))	\
-	= { (unsigned long)&sym, __kstrtab_##sym }
+	= { (unsigned long)&sym, __kstrtab_##name }
 
 #define EXPORT_SYMBOL(sym)					\
-	__EXPORT_SYMBOL(sym, "")
+	__EXPORT_SYMBOL(sym, sym, "")
 
 #define EXPORT_SYMBOL_GPL(sym)					\
-	__EXPORT_SYMBOL(sym, "_gpl")
+	__EXPORT_SYMBOL(sym, sym, "_gpl")
+
+#define EXPORT_DEPRECATED_SYMBOL(sym)				\
+	extern void __deprecated_ ## sym 			\
+			__attribute__((alias(#sym)));		\
+	__EXPORT_SYMBOL(sym, __deprecated_ ## sym, "_gpl")
 
 #endif
 
