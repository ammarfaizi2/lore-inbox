Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVHXPS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVHXPS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVHXPS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:18:59 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:47051 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751060AbVHXPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:18:58 -0400
Date: Wed, 24 Aug 2005 10:18:27 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, vbordug@ru.mvista.com
Subject: [PATCH] ppc32: ppc_sys system on chip identification additions
Message-ID: <Pine.LNX.4.61.0508241017480.23831@nylon.am.freescale.net>
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
commit 58d478e75ac5d6cb3a1f738a22555c3841445264
tree 999d1722d74eb8dc76f40c8f4c52966cea681cb4
parent eb5d5922d749a74f58416ca1a852651e7323449b
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:14:42 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:14:42 -0500

 arch/ppc/syslib/ppc_sys.c |   51 ++++++++++++++++++++++++++++++++++++++++++++-
 include/asm-ppc/ppc_sys.h |    1 +
 2 files changed, 51 insertions(+), 1 deletions(-)

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
@@ -35,8 +36,56 @@ void __init identify_ppc_sys_by_id(u32 i
 
 void __init identify_ppc_sys_by_name(char *name)
 {
-	/* TODO */
+	unsigned int i = 0;
+	while (ppc_sys_specs[i].ppc_sys_name[0])
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
@@ -50,6 +50,7 @@ extern struct ppc_sys_spec *cur_ppc_sys_
 /* determine which specific SOC we are */
 extern void identify_ppc_sys_by_id(u32 id) __init;
 extern void identify_ppc_sys_by_name(char *name) __init;
+extern void identify_ppc_sys_by_name_and_id(char *name, u32 id) __init;
 
 /* describes all devices that may exist in a given family of processors */
 extern struct platform_device ppc_sys_platform_devices[];
