Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWBVPzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWBVPzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWBVPzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:55:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:58323 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751356AbWBVPzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:55:41 -0500
Date: Wed, 22 Feb 2006 09:46:02 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       <linuxppc-dev@ozlabs.org>, Randy Vinson <rvinson@mvista.com>
Subject: [PATCH] powerpc: Enable coherency for all pages on 83xx to fix PCI
 data corruption
Message-ID: <Pine.LNX.4.44.0602220944460.14215-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the 83xx platform to ensure the PCI inbound memory is handled properly we
have to turn on coherency for all pages in the MMU.  Otherwise we see
corruption if inbound "prefetching/streaming" is enabled on the PCI controller.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---

(For 2.6.16 if we can get it in)

commit 4b2f4b1585f15d1c30cd2eda6d5f9a2ca7dcf998
tree 7aebf508d10127831cf92fb7ce919230924ad85d
parent 7cfb7344aae902edfd5d51dd5f734cbf2585649c
author Kumar Gala <galak@kernel.crashing.org> Wed, 22 Feb 2006 09:53:34 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 22 Feb 2006 09:53:34 -0600

 include/asm-powerpc/cputable.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 6421054..90d005b 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -159,9 +159,11 @@ extern void do_cpu_ftr_fixups(unsigned l
 #endif
 
 /* We need to mark all pages as being coherent if we're SMP or we
- * have a 74[45]x and an MPC107 host bridge.
+ * have a 74[45]x and an MPC107 host bridge. Also 83xx requires
+ * it for PCI "streaming/prefetch" to work properly.
  */
-#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
+#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE) \
+	|| defined(CONFIG_PPC_83xx)
 #define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
 #else
 #define CPU_FTR_COMMON                  0
@@ -277,7 +279,8 @@ enum {
 	CPU_FTRS_G2_LE = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
 	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
 	CPU_FTRS_E300 = CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE |
-	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
+	    CPU_FTR_USE_TB | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_HAS_HIGH_BATS |
+	    CPU_FTR_COMMON,
 	CPU_FTRS_CLASSIC32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |
 	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	CPU_FTRS_POWER3_32 = CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE |

