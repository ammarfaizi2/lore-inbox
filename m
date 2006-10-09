Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932702AbWJIMu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWJIMu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWJIMuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:50:18 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:11876 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932641AbWJIMtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:49:50 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19-rc1 08/10] Keep the __init functions after initialization
Date: Mon, 09 Oct 2006 13:49:46 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20061009124946.2695.11879.stgit@localhost.localdomain>
In-Reply-To: <20061009124813.2695.8123.stgit@localhost.localdomain>
References: <20061009124813.2695.8123.stgit@localhost.localdomain>
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

 include/linux/init.h |    5 +++++
 lib/Kconfig.debug    |   12 ++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index e92b145..5aedb34 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -40,8 +40,13 @@ #include <linux/compiler.h>
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
+#ifdef CONFIG_DEBUG_KEEP_INIT
+#define __init
+#define __initdata
+#else
 #define __init		__attribute__ ((__section__ (".init.text")))
 #define __initdata	__attribute__ ((__section__ (".init.data")))
+#endif
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 142a911..0d0bfab 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -208,6 +208,18 @@ config DEBUG_MEMLEAK_REPORTS_NR
 	  reading the /sys/kernel/debug/memleak file could lead to
 	  some soft-locks.
 
+config DEBUG_KEEP_INIT
+	bool "Do not free the __init code/data"
+	default n
+	depends on DEBUG_MEMLEAK
+	help
+	  This option moves the __init code/data out of the
+	  .init.text/.init.data sections. It is useful for identifying
+	  memory leaks happening during the kernel or modules
+	  initialization.
+
+	  If unsure, say N.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
