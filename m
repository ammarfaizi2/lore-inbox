Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbULMDDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbULMDDK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 22:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbULMDDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 22:03:10 -0500
Received: from ozlabs.org ([203.10.76.45]:16860 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262197AbULMDDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 22:03:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16829.1730.440135.994385@cargo.ozlabs.ibm.com>
Date: Mon, 13 Dec 2004 14:04:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: willschm@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 Make sure lppaca doesn't cross page boundary
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Will Schmidt <willschm@us.ibm.com>, with some extra
comments from me.

On iSeries and on POWER5 machines, there is a data structure which is
used for communication between the hypervisor and the kernel, called
the `lppaca'.  The kernel tells the hypervisor where it is, and the
hypervisor requires that it doesn't cross a page boundary.  With other
changes in the last few months we have ended up with a situation where
it could cross a page boundary.  This patch increases the alignment
requirement for the struct to make sure that it can't cross a page
boundary.

This is a bug fix and should go into 2.6.10.

Signed-off-by:  Will Schmidt  <willschm@us.ibm.com>
Signed-off-by:  Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/include/asm-ppc64/paca.h test/include/asm-ppc64/paca.h
--- linux-2.5/include/asm-ppc64/paca.h	2004-09-09 09:59:50.000000000 +1000
+++ test/include/asm-ppc64/paca.h	2004-12-13 13:56:00.350040112 +1100
@@ -99,11 +99,17 @@
 	u64 exdsi[8];		/* used for linear mapping hash table misses */
 
 	/*
-	 * iSeries structues which the hypervisor knows about - Not
-	 * sure if these particularly need to be cacheline aligned.
+	 * iSeries structure which the hypervisor knows about -
+	 * this structure should not cross a page boundary.
+	 * The vpa_init/register_vpa call is now known to fail if the
+	 * lppaca structure crosses a page boundary.
 	 * The lppaca is also used on POWER5 pSeries boxes.
+	 * The lppaca is 640 bytes long, and cannot readily change
+	 * since the hypervisor knows its layout, so a 1kB
+	 * alignment will suffice to ensure that it doesn't
+	 * cross a page boundary.
 	 */
-	struct ItLpPaca lppaca __attribute__((aligned(0x80)));
+	struct ItLpPaca lppaca __attribute__((__aligned__(0x400)));
 #ifdef CONFIG_PPC_ISERIES
 	struct ItLpRegSave reg_save;
 #endif
