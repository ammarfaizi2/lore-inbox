Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUERTwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUERTwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 15:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUERTwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 15:52:55 -0400
Received: from waste.org ([209.173.204.2]:2986 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263159AbUERTuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 15:50:46 -0400
Date: Tue, 18 May 2004 14:50:26 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Buesch <mbuesch@freenet.de>, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6] bootmem.c cleanup
Message-ID: <20040518195026.GS5414@waste.org>
References: <200405142205.27214.mbuesch@freenet.de> <20040514133353.236acf3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514133353.236acf3a.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 01:33:53PM -0700, Andrew Morton wrote:
> Michael Buesch <mbuesch@freenet.de> wrote:
> >
> >  -		if (!test_and_clear_bit(i, bdata->node_bootmem_map))
> >  -			BUG();
> >  +		BUG_ON(!test_and_clear_bit(i, bdata->node_bootmem_map));
> 
> Please don't put expressions whihc actually change state inside BUG_ON(). 
> Someone may decide to make BUG_ON() a no-op to save space.

I've done it and it's fine, we just need to evaluate the condition and
let the compiler optimize it away if it has no side effects.

configurable no-op of BUG and WARN


 tiny-mpm/include/asm-i386/bug.h |    7 +++++++
 tiny-mpm/init/Kconfig           |   11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

Index: tiny/include/asm-i386/bug.h
===================================================================
--- tiny.orig/include/asm-i386/bug.h	2004-04-19 14:42:45.000000000 -0500
+++ tiny/include/asm-i386/bug.h	2004-04-19 14:46:19.000000000 -0500
@@ -9,6 +9,12 @@
  * undefined" opcode for parsing in the trap handler.
  */
 
+#ifndef CONFIG_BUG
+#define BUG()
+#define WARN_ON(condition) do { if (condition) ; } while(0)
+#define BUG_ON(condition) do { if (condition) ; } while(0)
+#define PAGE_BUG(page)
+#else
 #ifdef CONFIG_FULL_BUG
 #define BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
@@ -40,3 +46,4 @@
 } while (0)
 
 #endif
+#endif
Index: tiny/init/Kconfig
===================================================================
--- tiny.orig/init/Kconfig	2004-04-19 14:42:49.000000000 -0500
+++ tiny/init/Kconfig	2004-04-19 14:46:19.000000000 -0500
@@ -274,8 +274,17 @@
           very difficult to diagnose system problems, saying N here on
           non-embedded systems is strongly discouraged.
 
+config BUG
+ 	depends X86
+ 	default y
+	bool "Enable BUG and WARN code" if EMBEDDED
+	help
+	  Disabling this completely removes BUG and WARN checking
+          code. Warning: this may result in data loss if a bug goes
+          undetected.
+
 config FULL_BUG
-	depends X86
+	depends X86 && BUG
 	default y
 	bool "Full BUG reporting code" if EMBEDDED
 	help

> 
> I'm not aware of anyone actually trying that, but it's a good objective.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
