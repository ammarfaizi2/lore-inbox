Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVEZI15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVEZI15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 04:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVEZI14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 04:27:56 -0400
Received: from aun.it.uu.se ([130.238.12.36]:62899 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261276AbVEZI0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 04:26:52 -0400
Date: Thu, 26 May 2005 10:26:43 +0200 (MEST)
Message-Id: <200505260826.j4Q8QhkR011637@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc5-mm1 1/4] perfctr: seqlocks for mmap:ed state: common
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This set of patches changes perfctr's low-level drivers to indicate
changes to the mmap:ed counter state via a unified seqlock mechanism.
This cleans up user-space, enables user-space fast sampling in some
previously impossible cases (x86 w/o TSC), and eliminates a highly
unlikely but not impossible failure case on x86 SMP.

This is a rewrite of a patch originally from David Gibson.

perfctr seqlocks 1/4: common changes
- define write_perfseq_begin/end in <linux/perfctr.h>
- bump version and sync it with current user-space package

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/version.h |    2 +-
 include/linux/perfctr.h   |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff -rupN linux-2.6.12-rc5-mm1/drivers/perfctr/version.h linux-2.6.12-rc5-mm1.perfctr-seqlock-common/drivers/perfctr/version.h
--- linux-2.6.12-rc5-mm1/drivers/perfctr/version.h	2005-05-26 00:24:22.000000000 +0200
+++ linux-2.6.12-rc5-mm1.perfctr-seqlock-common/drivers/perfctr/version.h	2005-05-26 02:54:26.000000000 +0200
@@ -1 +1 @@
-#define VERSION "2.7.15"
+#define VERSION "2.7.17"
diff -rupN linux-2.6.12-rc5-mm1/include/linux/perfctr.h linux-2.6.12-rc5-mm1.perfctr-seqlock-common/include/linux/perfctr.h
--- linux-2.6.12-rc5-mm1/include/linux/perfctr.h	2005-05-26 00:24:32.000000000 +0200
+++ linux-2.6.12-rc5-mm1.perfctr-seqlock-common/include/linux/perfctr.h	2005-05-26 02:54:26.000000000 +0200
@@ -154,6 +154,23 @@ static inline void perfctr_set_cpus_allo
 
 #endif	/* CONFIG_PERFCTR_VIRTUAL */
 
+/* These routines are identical to write_seqcount_begin() and
+ * write_seqcount_end(), except they take an explicit __u32 rather
+ * than a seqcount_t.  That's because this sequence lock is user from
+ * userspace, so we have to pin down the counter's type explicitly to
+ * have a clear ABI.  They also omit the SMP write barriers since we
+ * only support mmap() based sampling for self-monitoring tasks.
+ */
+static inline void write_perfseq_begin(__u32 *seq)
+{
+	++*seq;
+}
+
+static inline void write_perfseq_end(__u32 *seq)
+{
+	++*seq; 
+}
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_PERFCTR_H */
