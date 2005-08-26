Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVHZStt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVHZStt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbVHZStt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:49:49 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:9144 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030185AbVHZSts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:49:48 -0400
Date: Fri, 26 Aug 2005 13:49:13 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, vbordug@ru.mvista.com
Subject: [PATCH] ppc32: ppc_sys system on chip identification additions
 (updated)
Message-ID: <Pine.LNX.4.61.0508261348310.29914@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to identify an SOC by a name and id.  There are cases in
which the integer identifier is not sufficient to specify a specific SOC.
In these cases we can use a string to further qualify the match.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 57c213c1a2e50b06fe69b63bc596cf7cbef9105e
tree 194c870fad7f29e7a97d787b0a895c7ed59b2f10
parent 4005c652e0887d29554a73ff661a2365ebb7691a
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 26 Aug 2005 13:46:53 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 26 Aug 2005 13:46:53 -0500

 arch/ppc/syslib/ppc_sys.c |   52 ++++++++++++++++++++++++++++++++++++++++++++-
 include/asm-ppc/ppc_sys.h |    1 +
 2 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
--- a/arch/ppc/syslib/ppc_sys.c
+++ b/arch/ppc/syslib/ppc_sys.c
@@ -6,6 +6,7 @@
  * Maintainer: Kumar Gala <kumar.gala@freescale.com>
  *
  * Copyright 2005 Freescale Semiconductor Inc.
+ * Copyright 2005 MontaVista, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -35,8 +36,57 @@ void __init identify_ppc_sys_by_id(u32 i
 
 void __init identify_ppc_sys_by_name(char *name)
 {
-	/* TODO */
+	unsigned int i = 0;
+	while (ppc_sys_specs[i].ppc_sys_name[0])
+	{
+		if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
+			break;
+		i++;
+	}
+	cur_ppc_sys_spec = &ppc_sys_specs[i];
 	return;
+}
+
+static int __init count_sys_specs(void)
+{
+	int i = 0;
+	while (ppc_sys_specs[i].ppc_sys_name[0])
+		i++;
+	return i;
+}
+
+static int __init find_chip_by_name_and_id(char *name, u32 id)
+{
+	int ret = -1;
+	unsigned int i = 0;
+	unsigned int j = 0;
+	unsigned int dups = 0;
+
+	unsigned char matched[count_sys_specs()];
+
+	while (ppc_sys_specs[i].ppc_sys_name[0]) {
+		if (!strcmp(ppc_sys_specs[i].ppc_sys_name, name))
+			matched[j++] = i;
+		i++;
+	}
+	if (j != 0) {
+		for (i = 0; i < j; i++) {
+			if ((ppc_sys_specs[matched[i]].mask & id) ==
+			    ppc_sys_specs[matched[i]].value) {
+				ret = matched[i];
+				dups++;
+			}
+		}
+		ret = (dups == 1) ? ret : (-1 * dups);
+	}
+	return ret;
+}
+
+void __init identify_ppc_sys_by_name_and_id(char *name, u32 id)
+{
+	int i = find_chip_by_name_and_id(name, id);
+	BUG_ON(i < 0);
+	cur_ppc_sys_spec = &ppc_sys_specs[i];
 }
 
 /* Update all memory resources by paddr, call before platform_device_register */
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -52,6 +52,7 @@ extern struct ppc_sys_spec *cur_ppc_sys_
 /* determine which specific SOC we are */
 extern void identify_ppc_sys_by_id(u32 id) __init;
 extern void identify_ppc_sys_by_name(char *name) __init;
+extern void identify_ppc_sys_by_name_and_id(char *name, u32 id) __init;
 
 /* describes all devices that may exist in a given family of processors */
 extern struct platform_device ppc_sys_platform_devices[];
