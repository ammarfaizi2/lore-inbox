Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUHIIqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUHIIqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266359AbUHIIpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:45:50 -0400
Received: from holomorphy.com ([207.189.100.168]:61149 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266357AbUHIIno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:43:44 -0400
Date: Mon, 9 Aug 2004 01:43:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040809084338.GL11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040808152936.1ce2eab8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808152936.1ce2eab8.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 03:29:36PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc3/2.6.8-rc3-mm2/
> - Added a little patch to the CPU scheduler which disables its array
>   switching.
[...]

PAE is artificially limited in terms of swapspace to the same bitsplit
as ordinary i386, a 5/24 split (32 swapfiles, 64GB max swapfile size),
when a 5/27 split (32 swapfiles, 512GB max swapfile size) is feasible.
This patch transparently removes that limitation by using more of the
space available in PAE's wider ptes for swap ptes.

While this is obviously not likely to be used directly, it is important
from the standpoint of strict non-overcommit, where the swapspace must
be potentially usable in order to be reserved for non-overcommit. There
are workloads with Committed_AS of over 256GB on ia32 PAE wanting
strict non-overcommit to prevent being OOM killed.


Index: premm2-2.6.8-rc3/include/asm-i386/pgtable.h
===================================================================
--- premm2-2.6.8-rc3.orig/include/asm-i386/pgtable.h	2004-08-05 06:09:56.000000000 -0700
+++ premm2-2.6.8-rc3/include/asm-i386/pgtable.h	2004-08-07 03:22:42.794425352 -0700
@@ -398,13 +398,6 @@
 		}							  \
 	} while (0)
 
-/* Encode and de-code a swap entry */
-#define __swp_type(x)			(((x).val >> 1) & 0x1f)
-#define __swp_offset(x)			((x).val >> 8)
-#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
-#define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
-#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
-
 #endif /* !__ASSEMBLY__ */
 
 #ifndef CONFIG_DISCONTIGMEM
Index: premm2-2.6.8-rc3/include/asm-i386/pgtable-3level.h
===================================================================
--- premm2-2.6.8-rc3.orig/include/asm-i386/pgtable-3level.h	2004-08-05 06:09:56.000000000 -0700
+++ premm2-2.6.8-rc3/include/asm-i386/pgtable-3level.h	2004-08-07 03:22:42.791425808 -0700
@@ -134,4 +134,11 @@
 #define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
 #define PTE_FILE_MAX_BITS       32
 
+/* Encode and de-code a swap entry */
+#define __swp_type(x)			(((x).val) & 0x1f)
+#define __swp_offset(x)			((x).val >> 5)
+#define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << 5})
+#define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
+#define __swp_entry_to_pte(x)		((pte_t){ 0, (x).val })
+
 #endif /* _I386_PGTABLE_3LEVEL_H */
Index: premm2-2.6.8-rc3/include/asm-i386/pgtable-2level.h
===================================================================
--- premm2-2.6.8-rc3.orig/include/asm-i386/pgtable-2level.h	2004-08-05 06:09:56.000000000 -0700
+++ premm2-2.6.8-rc3/include/asm-i386/pgtable-2level.h	2004-08-07 03:22:42.788426264 -0700
@@ -75,4 +75,11 @@
 #define pgoff_to_pte(off) \
 	((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })
 
+/* Encode and de-code a swap entry */
+#define __swp_type(x)			(((x).val >> 1) & 0x1f)
+#define __swp_offset(x)			((x).val >> 8)
+#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
+#define __swp_entry_to_pte(x)		((pte_t) { (x).val })
+
 #endif /* _I386_PGTABLE_2LEVEL_H */
