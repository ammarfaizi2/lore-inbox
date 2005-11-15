Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVKOHV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVKOHV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 02:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVKOHV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 02:21:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:10373 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751348AbVKOHVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 02:21:55 -0500
Subject: [PATCH] ppc: Fix boot with yaboot with ARCH=ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 18:21:45 +1100
Message-Id: <1132039305.5646.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The merge of machine types broke boot with yaboot & ARCH=ppc due to the
old code still retreiving the old-syle machine type passed in by yaboot.
This patch fixes it by translating those old numbers. Since that whole
mecanism is deprecated, this is a temporary fix until ARCH=ppc uses the
new prom_init that the merged architecture now uses for both ppc32 and
ppc64 (after 2.6.15)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/setup.c	2005-11-15 18:15:23.000000000 +1100
+++ linux-work/arch/ppc/kernel/setup.c	2005-11-15 18:18:37.000000000 +1100
@@ -602,7 +602,19 @@
 #endif /* CONFIG_BLK_DEV_INITRD */
 #ifdef CONFIG_PPC_MULTIPLATFORM
 		case BI_MACHTYPE:
-			_machine = data[0];
+			/* Machine types changed with the merge. Since the
+			 * bootinfo are now deprecated, we can just hard code
+			 * the appropriate conversion here for when we are
+			 * called with yaboot which passes us a machine type
+			 * this way.
+			 */
+			switch(data[0]) {
+			case 1: _machine = _MACH_prep; break;
+			case 2: _machine = _MACH_Pmac; break;
+			case 4: _machine = _MACH_chrp; break;
+			default:
+				_machine = data[0];
+			}
 			break;
 #endif
 		case BI_MEMSIZE:


