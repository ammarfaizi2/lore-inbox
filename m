Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965264AbWGJWLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbWGJWLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWGJWK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:10:57 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:273 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965254AbWGJWKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:10:52 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 08/10] Keep the __init functions after initialization
Date: Mon, 10 Jul 2006 23:10:50 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060710221049.5191.9776.stgit@localhost.localdomain>
In-Reply-To: <20060710220901.5191.66488.stgit@localhost.localdomain>
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the CONFIG_DEBUG_KEEP_INIT option which preserves the
.init.text section after initialization. Memory leaks happening during this
phase can be more easily tracked.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 include/linux/init.h |    4 ++++
 lib/Kconfig.debug    |   10 ++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 6667785..1590e9a 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -40,7 +40,11 @@ #include <linux/compiler.h>
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
+#ifdef CONFIG_DEBUG_KEEP_INIT
+#define __init
+#else
 #define __init		__attribute__ ((__section__ (".init.text")))
+#endif
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6c56be2..5013375 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -171,6 +171,16 @@ config DEBUG_MEMLEAK_ORPHAN_FREEING
 	  information displayed allow an easier identification of
 	  false positives.
 
+config DEBUG_KEEP_INIT
+	bool "Do not free the __init functions"
+	default n
+	depends on DEBUG_MEMLEAK
+	help
+	  This option moves the __init functions out of the .init.text
+	  section and therefore they are no longer freed after the
+	  kernel initialization. It is useful for identifying memory
+	  leaks happening during the kernel or modules initialization.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
