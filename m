Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWHHWPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWHHWPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWHHWPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:15:32 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:5822 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030321AbWHHWPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:15:31 -0400
Date: Wed, 9 Aug 2006 00:15:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>
Subject: Re: Still get build warnings - gcc-3.4.6 - 2.6.17.8
Message-ID: <20060808221509.GB8378@mars.ravnborg.org>
References: <200608082148.11433.nick@linicks.net> <20060808141246.25ee5db7.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060808141246.25ee5db7.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 02:12:46PM -0700, Randy.Dunlap wrote:
 
> It's not a gcc (nor ggc) problem.  Those functions are just deprecated.
> Current 2.6.18-rc4 and 2.6.18-rc3-mm2 still have those same warnings.
> 
> fwiw, I don't seem to have any patches to fix/remove them.
I have saved following patch from Arnd for ages.
First I was worried about the use of weak - but we do that in other
places. And then I just forgot it until now.

Should be easy to adopt to current kernel - but too late for me today.

	Sam

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: EXPORT_SYMBOL generates "is deprecated" noise
Date:	Mon, 8 Aug 2005 15:46:22 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <200508081546.23125.arnd@arndb.de>

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
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

