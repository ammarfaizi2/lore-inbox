Return-Path: <linux-kernel-owner+w=401wt.eu-S1161081AbWLPPsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWLPPsL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWLPPrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:47:46 -0500
Received: from queue01-winn.ispmail.ntl.com ([81.103.221.55]:5281 "EHLO
	queue01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161080AbWLPPri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:38 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 08/10] Keep the __init functions after
	initialization
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:35:40 +0000
Message-ID: <20061216153540.18200.43872.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the CONFIG_DEBUG_KEEP_INIT option which preserves the
.init.text section after initialization. Memory leaks happening during this
phase can be more easily tracked.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 include/linux/init.h |    5 +++++
 lib/Kconfig.debug    |   12 ++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 5a593a1..eecdb17 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -40,8 +40,13 @@
 
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
index 42f60fb..9695af1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -251,6 +251,18 @@ config DEBUG_MEMLEAK_REPORTS_NR
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
