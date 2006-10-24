Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbWJXVao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbWJXVao (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWJXVao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:30:44 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:35109 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S965209AbWJXVam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:30:42 -0400
Subject: [PATCH 1/1] Fabric7 VIOC: Ethtool
From: Sriram Chidambaram <schidambaram@fabric7.com>
Reply-To: driver-support@fabric7.com
To: Jeff Garzik <jeff@garzik.org>
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <netdev@vger.kernel.org>,
       Driver Support <driver-support@fabric7.com>
Content-Type: text/plain
Organization: Fabric7 Systems Inc
Message-Id: <1161725441.8112.11.camel@rh234.mv.fabric7.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Oct 2006 14:30:41 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2006 21:30:42.0097 (UTC) FILETIME=[A8457A10:01C6F7B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ethtool patch for Fabric7 VIOC Device Driver.

Signed-off-by: Fabric7 Driver-Support <driver-support@fabric7.com>
---
 Makefile.am    |    2 +-
 ethtool-util.h |    2 ++
 ethtool.c      |    1 +
 vioc.c         |   35 +++++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 97ad512..240979e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -7,7 +7,7 @@ sbin_PROGRAMS = ethtool
 ethtool_SOURCES = ethtool.c ethtool-copy.h ethtool-util.h	\
 		  amd8111e.c de2104x.c e100.c e1000.c		\
 		  fec_8xx.c ibm_emac.c ixgb.c natsemi.c		\
-		  pcnet32.c realtek.c tg3.c marvell.c
+		  pcnet32.c realtek.c tg3.c marvell.c vioc.c
 
 dist-hook:
 	cp $(top_srcdir)/ethtool.spec $(distdir)
diff --git a/ethtool-util.h b/ethtool-util.h
index 0909a5a..dcb0c1c 100644
--- a/ethtool-util.h
+++ b/ethtool-util.h
@@ -54,4 +54,6 @@ int skge_dump_regs(struct ethtool_drvinf
 /* SysKonnect Gigabit (Yukon2) */
 int sky2_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
 
+/* Fabric7 VIOC */
+int vioc_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
 #endif
diff --git a/ethtool.c b/ethtool.c
index b783248..6e68009 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -958,6 +958,7 @@ static struct {
 	{ "tg3", tg3_dump_regs },
 	{ "skge", skge_dump_regs },
 	{ "sky2", sky2_dump_regs },
+        { "vioc", vioc_dump_regs },
 };
 
 static int dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
diff --git a/vioc.c b/vioc.c
new file mode 100644
index 0000000..b58dd40
--- /dev/null
+++ b/vioc.c
@@ -0,0 +1,35 @@
+/* Copyright 2006 Fabric7 Systems, Inc */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include "ethtool-util.h"
+
+struct regs_line {
+		u32	addr;
+		u32	data;
+};
+
+#define VIOC_REGS_LINE_SIZE	sizeof(struct regs_line)
+
+int vioc_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
+{
+	unsigned int	i;
+	unsigned int	num_regs;
+	struct regs_line *reg_info = (struct regs_line *) regs->data;
+
+	printf("%s: Enter\n", __FUNCTION__);
+
+	printf("ethtool_regs\n"
+		"%-20s = %04x\n"
+		"%-20s = %04x\n",
+		"cmd", regs->cmd,
+		"version", regs->version);
+
+	num_regs = regs->len/VIOC_REGS_LINE_SIZE;
+
+	for (i = 0; i < num_regs; i++){
+		printf("%08x = %08x\n", reg_info[i].addr, reg_info[i].data);
+	}
+
+	return 0;
+}
-- 
1.4.3.GIT


