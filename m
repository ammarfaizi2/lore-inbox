Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422939AbWHZRmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422939AbWHZRmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWHZRmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:19 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:62332 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964802AbWHZRmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=l8VlWuzjxEJ1UkyTk0BH15TR2w/V0rLVLfkNtMioYYPu8tlV43jrIJxDQM79di+n/mt23WvAF1MrxNkXKabCQ/3h0CuKABUnhOnZbR1CGUKv9pHeyK4D/UQFNHumrJuLSyA/8lWWLu34RO4QqIsnqJl3eoekCvTfS+9Oxp/ifjY=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 01/13] RFP: new bitmask_trans in <linux/bitops.h>
Date: Sat, 26 Aug 2006 19:42:09 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174209.14790.97420.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Generalize _calc_vm_trans macro for subsequent use in remap_file_pages
protection support.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/linux/bitops.h |   10 ++++++++++
 include/linux/mman.h   |   25 ++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 5d1eabc..f25aa43 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -3,6 +3,16 @@ #define _LINUX_BITOPS_H
 #include <asm/types.h>
 
 /*
+ * Optimisation macro.  It is equivalent to:
+ *      (x & bit1) ? bit2 : 0
+ * but this version is faster.
+ * ("bit1" and "bit2" must be single bits)
+ */
+#define bitmask_trans(x, bit1, bit2) \
+  ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
+   : ((x) & (bit1)) / ((bit1) / (bit2)))
+
+/*
  * Include this here because some architectures need generic_ffs/fls in
  * scope
  */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 87920a0..6ac90be 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -14,6 +14,7 @@ #ifdef __KERNEL__
 #include <linux/mm.h>
 
 #include <asm/atomic.h>
+#include <linux/bitops.h>
 
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
@@ -34,24 +35,14 @@ static inline void vm_unacct_memory(long
 }
 
 /*
- * Optimisation macro.  It is equivalent to:
- *      (x & bit1) ? bit2 : 0
- * but this version is faster.
- * ("bit1" and "bit2" must be single bits)
- */
-#define _calc_vm_trans(x, bit1, bit2) \
-  ((bit1) <= (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
-   : ((x) & (bit1)) / ((bit1) / (bit2)))
-
-/*
  * Combine the mmap "prot" argument into "vm_flags" used internally.
  */
 static inline unsigned long
 calc_vm_prot_bits(unsigned long prot)
 {
-	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
-	       _calc_vm_trans(prot, PROT_WRITE, VM_WRITE) |
-	       _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC );
+	return bitmask_trans(prot, PROT_READ,  VM_READ ) |
+	       bitmask_trans(prot, PROT_WRITE, VM_WRITE) |
+	       bitmask_trans(prot, PROT_EXEC,  VM_EXEC );
 }
 
 /*
@@ -60,10 +51,10 @@ calc_vm_prot_bits(unsigned long prot)
 static inline unsigned long
 calc_vm_flag_bits(unsigned long flags)
 {
-	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
-	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
-	       _calc_vm_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE) |
-	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
+	return bitmask_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
+	       bitmask_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
+	       bitmask_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE) |
+	       bitmask_trans(flags, MAP_LOCKED,     VM_LOCKED    );
 }
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMAN_H */
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
