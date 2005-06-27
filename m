Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVF0Or5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVF0Or5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVF0Or5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:47:57 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:29386 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262103AbVF0M2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:28:09 -0400
Date: Mon, 27 Jun 2005 15:27:50 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andi Kleen <ak@suse.de>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Mahoney <jeffm@suse.de>, penberg@gmail.com, reiser@namesys.com,
       flx@namesys.com, zam@namesys.com, vs@thebsh.namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       joern@wohnheim.fh-wedel.de
Subject: [PATCH] verbose BUG_ON reporting
In-Reply-To: <20050627082046.GC14251@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0506271525240.3200@sbz-30.cs.Helsinki.FI>
References: <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
 <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de>
 <20050623114318.5ae13514.akpm@osdl.org> <20050623193247.GC6814@suse.de>
 <1119717967.9392.2.camel@localhost> <20050627072449.GF19550@suse.de>
 <20050627072832.GA14251@wotan.suse.de> <Pine.LNX.4.58.0506271048310.26869@sbz-30.cs.Helsinki.FI>
 <20050627082046.GC14251@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Andi Kleen wrote:
> It won't work for me because it'll bloat the kernel .text
> considerable. There is a reason why BUG is implemented
> like it is. Compare it.

The assertion codes bloat the kernel all the same. So how about this 
instead?

This patch adds a CONFIG_DEBUG_BUG_ON_VERBOSE that makes BUG_ON report the
evaluated expression in human readable form when the assertion fails.

The size of vmlinux with allyesconfig increases about 100k when the config
option is enabled:

    text    data     bss      dec filename
19333351 6699691 1845604 27878646 vmlinux-2.6.12-git8
19434139 6699691 1845604 27979434 vmlinux-2.6.12-git8-verbose-bug_on

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/asm-generic/bug.h |   11 ++++++++++-
 lib/Kconfig.debug         |    7 +++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

Index: 2.6/include/asm-generic/bug.h
===================================================================
--- 2.6.orig/include/asm-generic/bug.h
+++ 2.6/include/asm-generic/bug.h
@@ -12,8 +12,17 @@
 } while (0)
 #endif
 
+#ifdef CONFIG_DEBUG_BUG_ON_VERBOSE
+#define FAIL_BUG_ON(expr_str) do { \
+	printk("BUG_ON(%s) failed.\n", expr_str); \
+	BUG(); \
+} while (0)
+#else
+#define FAIL_BUG_ON(expr_str) BUG()
+#endif
+
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+#define BUG_ON(condition) do { if (unlikely((condition)!=0)) FAIL_BUG_ON(#condition); } while(0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
Index: 2.6/lib/Kconfig.debug
===================================================================
--- 2.6.orig/lib/Kconfig.debug
+++ 2.6/lib/Kconfig.debug
@@ -116,6 +116,13 @@ config DEBUG_BUGVERBOSE
 	  of the BUG call as well as the EIP and oops trace.  This aids
 	  debugging but costs about 70-100K of memory.
 
+config DEBUG_BUG_ON_VERBOSE
+	bool "Verbose BUG_ON() reporting"
+	depends on DEBUG_KERNEL && BUG
+	default false
+	help
+	  Say Y here to make BUG_ON() panics output the evaluated expression.
+
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
 	depends on DEBUG_KERNEL
