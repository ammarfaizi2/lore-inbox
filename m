Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWIVI6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWIVI6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWIVI6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:58:15 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:46219 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751085AbWIVI6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:58:14 -0400
Message-ID: <4513A591.9070906@t-online.de>
Date: Fri, 22 Sep 2006 10:57:53 +0200
From: Bernd Schmidt <bernds_cb1@t-online.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060827)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Greg Ungerer <gerg@snapgear.com>, David McCullough <davidm@snapgear.com>
Subject: [BFIN] Blackfin binfmt_flat patch
Content-Type: multipart/mixed;
 boundary="------------020602080302080507020301"
X-ID: r3TKtcZUYeYwfpEmnCOuX-l4u+b5pa7B70IKmSM3yq+doU33LZ7rE2
X-TOI-MSGID: 2334af2a-8884-4507-a1c4-e8adc15bbdd0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020602080302080507020301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This should be applied on top of Luke's Blackfin patches.  It's a small 
enhancement for binfmt_flat; we didn't have enough space in the flat 
format for each relocation to store enough data, so this adds a method 
to keep data around and use it in a later reloc.  This is the minimum 
patch to get binfmt_flat working for normal apps on the Blackfin.

Signed-off-by: Bernd Schmidt <bernd.schmidt@analog.com>


--------------020602080302080507020301
Content-Type: text/plain;
 name="bfin-binfmt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bfin-binfmt.diff"

 fs/binfmt_flat.c             |    7 +++++--
 include/asm-h8300/flat.h     |    3 ++-
 include/asm-m32r/flat.h      |    3 ++-
 include/asm-m68knommu/flat.h |    3 ++-
 include/asm-sh/flat.h        |    3 ++-
 include/asm-v850/flat.h      |    4 +++-
 6 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index a62fd40..c30565f 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -725,6 +725,7 @@ #endif
 	 * __start to address 4 so that is okay).
 	 */
 	if (rev > OLD_FLAT_VERSION) {
+		unsigned long persistent = 0;
 		for (i=0; i < relocs; i++) {
 			unsigned long addr, relval;
 
@@ -732,6 +733,8 @@ #endif
 			   relocated (of course, the address has to be
 			   relocated first).  */
 			relval = ntohl(reloc[i]);
+			if (flat_set_persistent (relval, &persistent))
+				continue;
 			addr = flat_get_relocate_addr(relval);
 			rp = (unsigned long *) calc_reloc(addr, libinfo, id, 1);
 			if (rp == (unsigned long *)RELOC_FAILED) {
@@ -740,8 +743,8 @@ #endif
 			}
 
 			/* Get the pointer's value.  */
-			addr = flat_get_addr_from_rp(rp, relval, flags);
-			if (addr != 0) {
+			addr = flat_get_addr_from_rp(rp, relval, flags, &persistent);
+			if (addr != 0) {
 				/*
 				 * Do the relocation.  PIC relocs in the data section are
 				 * already in target order
diff --git a/include/asm-h8300/flat.h b/include/asm-h8300/flat.h
index c20eee7..2a87350 100644
--- a/include/asm-h8300/flat.h
+++ b/include/asm-h8300/flat.h
@@ -9,6 +9,7 @@ #define	flat_stack_align(sp)			/* nothin
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		1
 #define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
+#define	flat_set_persistent(relval, p)		0
 
 /*
  * on the H8 a couple of the relocations have an instruction in the
@@ -18,7 +19,7 @@ #define	flat_reloc_valid(reloc, size)		(
  */
 
 #define	flat_get_relocate_addr(rel)		(rel)
-#define flat_get_addr_from_rp(rp, relval, flags) \
+#define flat_get_addr_from_rp(rp, relval, flags, persistent) \
         (get_unaligned(rp) & ((flags & FLAT_FLAG_GOTPIC) ? 0xffffffff: 0x00ffffff))
 #define flat_put_addr_at_rp(rp, addr, rel) \
 	put_unaligned (((*(char *)(rp)) << 24) | ((addr) & 0x00ffffff), rp)
diff --git a/include/asm-m32r/flat.h b/include/asm-m32r/flat.h
index 1b285f6..d851cf0 100644
--- a/include/asm-m32r/flat.h
+++ b/include/asm-m32r/flat.h
@@ -15,9 +15,10 @@ #define __ASM_M32R_FLAT_H
 #define	flat_stack_align(sp)		(*sp += (*sp & 3 ? (4 - (*sp & 3)): 0))
 #define	flat_argvp_envp_on_stack()		0
 #define	flat_old_ram_flag(flags)		(flags)
+#define	flat_set_persistent(relval, p)		0
 #define	flat_reloc_valid(reloc, size)		\
 	(((reloc) - textlen_for_m32r_lo16_data) <= (size))
-#define flat_get_addr_from_rp(rp, relval, flags) \
+#define flat_get_addr_from_rp(rp, relval, flags, persistent) \
 	m32r_flat_get_addr_from_rp(rp, relval, (text_len) )
 
 #define flat_put_addr_at_rp(rp, addr, relval) \
diff --git a/include/asm-m68knommu/flat.h b/include/asm-m68knommu/flat.h
index 2d836ed..814b517 100644
--- a/include/asm-m68knommu/flat.h
+++ b/include/asm-m68knommu/flat.h
@@ -9,8 +9,9 @@ #define	flat_stack_align(sp)			/* nothin
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		(flags)
 #define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
-#define	flat_get_addr_from_rp(rp, relval, flags)	get_unaligned(rp)
+#define	flat_get_addr_from_rp(rp, relval, flags, p)	get_unaligned(rp)
 #define	flat_put_addr_at_rp(rp, val, relval)	put_unaligned(val,rp)
 #define	flat_get_relocate_addr(rel)		(rel)
+#define	flat_set_persistent(relval, p)		0
 
 #endif /* __M68KNOMMU_FLAT_H__ */
diff --git a/include/asm-sh/flat.h b/include/asm-sh/flat.h
index f29072e..f3081bc 100644
--- a/include/asm-sh/flat.h
+++ b/include/asm-sh/flat.h
@@ -16,8 +16,9 @@ #define	flat_stack_align(sp)			/* nothin
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		(flags)
 #define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
-#define	flat_get_addr_from_rp(rp, relval, flags)	get_unaligned(rp)
+#define	flat_get_addr_from_rp(rp, relval, flags, p)	get_unaligned(rp)
 #define	flat_put_addr_at_rp(rp, val, relval)	put_unaligned(val,rp)
 #define	flat_get_relocate_addr(rel)		(rel)
+#define	flat_set_persistent(relval, p)		0
 
 #endif /* __ASM_SH_FLAT_H */
diff --git a/include/asm-v850/flat.h b/include/asm-v850/flat.h
index 3888f59..17f0ea5 100644
--- a/include/asm-v850/flat.h
+++ b/include/asm-v850/flat.h
@@ -25,6 +25,7 @@ #define	flat_reloc_valid(reloc, size)	((
 #define	flat_stack_align(sp)		/* nothing needed */
 #define	flat_argvp_envp_on_stack()	0
 #define	flat_old_ram_flag(flags)	(flags)
+#define	flat_set_persistent(relval, p)	0
 
 /* We store the type of relocation in the top 4 bits of the `relval.' */
 
@@ -46,7 +47,8 @@ #define FLAT_V850_R_HI16S_LO16	2 /* High
    For the v850, RP should always be half-word aligned.  */
 static inline unsigned long flat_get_addr_from_rp (unsigned long *rp,
 						   unsigned long relval,
-						   unsigned long flags)
+						   unsigned long flags,
+						   unsigned long *persistent)
 {
 	short *srp = (short *)rp;
 

--------------020602080302080507020301--
