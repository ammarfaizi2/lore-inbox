Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWJMSFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWJMSFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWJMSFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:05:20 -0400
Received: from ext-103.mv.fabric7.com ([68.120.107.103]:51980 "EHLO
	corp.fabric7.com") by vger.kernel.org with ESMTP id S1751308AbWJMSFT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:05:19 -0400
From: Misha Tomushev <misha@fabric7.com>
Reply-To: misha@fabric7.com
Organization: Fabric7 Systems
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] VIOC: Ethtool
Date: Fri, 13 Oct 2006 10:56:28 -0700
User-Agent: KMail/1.5.1
Cc: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <netdev@vger.kernel.org>,
       "Sriram Chidambaram" <schidambaram@fabric7.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131056.28563.misha@fabric7.com>
X-OriginalArrivalTime: 13 Oct 2006 18:05:17.0874 (UTC) FILETIME=[23EB0920:01C6EEF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is the ethtool patch for  VIOC Device Driver.

Signed-off-by: Misha Tomushev  <misha@fabric7.com>

diff -uprN ethtool-5/Makefile.am ethtool-5.vioc/Makefile.am
--- ethtool-5/Makefile.am	2006-08-23 23:53:06.000000000 -0700
+++ ethtool-5.vioc/Makefile.am	2006-10-12 18:26:22.000000000 -0700
@@ -7,7 +7,7 @@ sbin_PROGRAMS = ethtool
 ethtool_SOURCES = ethtool.c ethtool-copy.h ethtool-util.h	\
 		  amd8111e.c de2104x.c e100.c e1000.c		\
 		  fec_8xx.c ibm_emac.c natsemi.c pcnet32.c	\
-		  realtek.c tg3.c skge.c
+		  realtek.c tg3.c skge.c vioc.c
 
 dist-hook:
 	cp $(top_srcdir)/ethtool.spec $(distdir)
diff -uprN ethtool-5/ethtool-util.h ethtool-5.vioc/ethtool-util.h
--- ethtool-5/ethtool-util.h	2006-08-23 23:53:06.000000000 -0700
+++ ethtool-5.vioc/ethtool-util.h	2006-10-12 18:27:23.000000000 -0700
@@ -48,4 +48,7 @@ int tg3_dump_regs(struct ethtool_drvinfo
 /* SysKonnect Gigabit (Genesis and Yukon) */
 int skge_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
 
+/* VIOC */
+int vioc_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
+
 #endif
diff -uprN ethtool-5/ethtool.c ethtool-5.vioc/ethtool.c
--- ethtool-5/ethtool.c	2006-08-23 23:53:16.000000000 -0700
+++ ethtool-5.vioc/ethtool.c	2006-10-12 18:28:06.000000000 -0700
@@ -945,6 +945,7 @@ static struct {
 	{ "ibm_emac", ibm_emac_dump_regs },
 	{ "tg3", tg3_dump_regs },
 	{ "skge", skge_dump_regs },
+	{ "vioc", vioc_dump_regs },
 };
 
 static int dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
diff -uprN ethtool-5/vioc.c ethtool-5.vioc/vioc.c
--- ethtool-5/vioc.c	1969-12-31 16:00:00.000000000 -0800
+++ ethtool-5.vioc/vioc.c	2006-10-12 18:41:58.000000000 -0700
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
Misha Tomushev
misha@fabric7.com


