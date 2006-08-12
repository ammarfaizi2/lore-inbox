Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWHLWBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWHLWBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWHLWA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:00:57 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:50741 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932630AbWHLWAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:00:54 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc4 08/10] Keep the __init functions after initialization
Date: Sat, 12 Aug 2006 23:00:50 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060812220050.17709.53606.stgit@localhost.localdomain>
In-Reply-To: <20060812215857.17709.79502.stgit@localhost.localdomain>
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
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
 lib/Kconfig.debug    |   12 ++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

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
index 77ddb7d..c8ca3d6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -185,6 +185,18 @@ config DEBUG_MEMLEAK_REPORTS_NR
 	  reading the /sys/kernel/debug/memleak file could lead to
 	  some soft-locks.
 
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
+	  If unsure, say N.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
