Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWDCStp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWDCStp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 14:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWDCStp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 14:49:45 -0400
Received: from test-iport-2.cisco.com ([171.71.176.105]:41252 "EHLO
	test-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1750971AbWDCStp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 14:49:45 -0400
To: torvalds@osdl.org
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [git pull] InfiniBand: small post 2.6.17-rc1 fixes
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 03 Apr 2006 11:49:42 -0700
Message-ID: <adapsjyv6ih.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Apr 2006 18:49:44.0420 (UTC) FILETIME=[5F93EA40:01C6574F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

    master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

This tree is also available from kernel.org mirrors at:

    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git for-linus

The pull will get the following changes:

Michael S. Tsirkin:
      IB/mad: fix oops in cancel_mads

Roland Dreier:
      IPoIB: Always build debugging code unless CONFIG_EMBEDDED=y
      IB/mthca: Always build debugging code unless CONFIG_EMBEDDED=y
      IB/srp: Fix memory leak in options parsing

 drivers/infiniband/core/mad.c            |    2 +-
 drivers/infiniband/hw/mthca/Kconfig      |   11 ++++++-----
 drivers/infiniband/hw/mthca/Makefile     |    4 ----
 drivers/infiniband/hw/mthca/mthca_dev.h  |   17 +++++++++++++++--
 drivers/infiniband/hw/mthca/mthca_main.c |    8 ++++++++
 drivers/infiniband/ulp/ipoib/Kconfig     |    3 ++-
 drivers/infiniband/ulp/srp/ib_srp.c      |    1 +
 7 files changed, 33 insertions(+), 13 deletions(-)


diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index ba54c85..3a702da 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2311,6 +2311,7 @@ static void local_completions(void *data
 		local = list_entry(mad_agent_priv->local_list.next,
 				   struct ib_mad_local_private,
 				   completion_list);
+		list_del(&local->completion_list);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 		if (local->mad_priv) {
 			recv_mad_agent = local->recv_mad_agent;
@@ -2362,7 +2363,6 @@ local_send_completion:
 						   &mad_send_wc);
 
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-		list_del(&local->completion_list);
 		atomic_dec(&mad_agent_priv->refcount);
 		if (!recv)
 			kmem_cache_free(ib_mad_cache, local->mad_priv);
diff --git a/drivers/infiniband/hw/mthca/Kconfig b/drivers/infiniband/hw/mthca/Kconfig
index e88be85..9aa5a44 100644
--- a/drivers/infiniband/hw/mthca/Kconfig
+++ b/drivers/infiniband/hw/mthca/Kconfig
@@ -7,10 +7,11 @@ config INFINIBAND_MTHCA
 	  ("Tavor") and the MT25208 PCI Express HCA ("Arbel").
 
 config INFINIBAND_MTHCA_DEBUG
-	bool "Verbose debugging output"
+	bool "Verbose debugging output" if EMBEDDED
 	depends on INFINIBAND_MTHCA
-	default n
+	default y
 	---help---
-	  This option causes the mthca driver produce a bunch of debug
-	  messages.  Select this is you are developing the driver or
-	  trying to diagnose a problem.
+	  This option causes debugging code to be compiled into the
+	  mthca driver.  The output can be turned on via the
+	  debug_level module parameter (which can also be set after
+	  the driver is loaded through sysfs).
diff --git a/drivers/infiniband/hw/mthca/Makefile b/drivers/infiniband/hw/mthca/Makefile
index 47ec5a7..e388d95 100644
--- a/drivers/infiniband/hw/mthca/Makefile
+++ b/drivers/infiniband/hw/mthca/Makefile
@@ -1,7 +1,3 @@
-ifdef CONFIG_INFINIBAND_MTHCA_DEBUG
-EXTRA_CFLAGS += -DDEBUG
-endif
-
 obj-$(CONFIG_INFINIBAND_MTHCA) += ib_mthca.o
 
 ib_mthca-y :=	mthca_main.o mthca_cmd.o mthca_profile.o mthca_reset.o \
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index ad52edb..bb2a9d6 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -355,8 +355,21 @@ struct mthca_dev {
 	spinlock_t            sm_lock;
 };
 
-#define mthca_dbg(mdev, format, arg...) \
-	dev_dbg(&mdev->pdev->dev, format, ## arg)
+#ifdef CONFIG_INFINIBAND_MTHCA_DEBUG
+extern int mthca_debug_level;
+
+#define mthca_dbg(mdev, format, arg...)					\
+	do {								\
+		if (mthca_debug_level)					\
+			dev_printk(KERN_DEBUG, &mdev->pdev->dev, format, ## arg); \
+	} while (0)
+
+#else /* CONFIG_INFINIBAND_MTHCA_DEBUG */
+
+#define mthca_dbg(mdev, format, arg...) do { (void) mdev; } while (0)
+
+#endif /* CONFIG_INFINIBAND_MTHCA_DEBUG */
+
 #define mthca_err(mdev, format, arg...) \
 	dev_err(&mdev->pdev->dev, format, ## arg)
 #define mthca_info(mdev, format, arg...) \
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 266f347..597d7dc 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -52,6 +52,14 @@ MODULE_DESCRIPTION("Mellanox InfiniBand 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRV_VERSION);
 
+#ifdef CONFIG_INFINIBAND_MTHCA_DEBUG
+
+int mthca_debug_level = 0;
+module_param_named(debug_level, mthca_debug_level, int, 0644);
+MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0");
+
+#endif /* CONFIG_INFINIBAND_MTHCA_DEBUG */
+
 #ifdef CONFIG_PCI_MSI
 
 static int msi_x = 0;
diff --git a/drivers/infiniband/ulp/ipoib/Kconfig b/drivers/infiniband/ulp/ipoib/Kconfig
index 8d2e04c..13d6d01 100644
--- a/drivers/infiniband/ulp/ipoib/Kconfig
+++ b/drivers/infiniband/ulp/ipoib/Kconfig
@@ -10,8 +10,9 @@ config INFINIBAND_IPOIB
 	  group: <http://www.ietf.org/html.charters/ipoib-charter.html>.
 
 config INFINIBAND_IPOIB_DEBUG
-	bool "IP-over-InfiniBand debugging"
+	bool "IP-over-InfiniBand debugging" if EMBEDDED
 	depends on INFINIBAND_IPOIB
+	default y
 	---help---
 	  This option causes debugging code to be compiled into the
 	  IPoIB driver.  The output can be turned on via the
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index fd8a95a..5f2b3f6 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1434,6 +1434,7 @@ static int srp_parse_options(const char 
 			p = match_strdup(args);
 			if (strlen(p) != 32) {
 				printk(KERN_WARNING PFX "bad dest GID parameter '%s'\n", p);
+				kfree(p);
 				goto out;
 			}
 
