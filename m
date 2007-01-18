Return-Path: <linux-kernel-owner+w=401wt.eu-S1752076AbXARRlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXARRlK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 12:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbXARRlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 12:41:10 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:45658 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbXARRlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 12:41:09 -0500
X-Originating-Ip: 74.109.98.130
Date: Thu, 18 Jan 2007 12:35:18 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Roman Zippel <zippel@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] extend the set of "__attribute__" shortcut macros
Message-ID: <Pine.LNX.4.64.0701181222200.2750@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Extend the set of "__attribute__" shortcut macros, and remove
identical (and now superfluous) definitions from a couple of source
files.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  based on a page at robert love's blog:

	http://rlove.org/log/2005102601

extend the set of shortcut macros defined in compiler-gcc.h with the
following:

#define __packed                       __attribute__((packed))
#define __weak                         __attribute__((weak))
#define __naked                        __attribute__((naked))
#define __noreturn                     __attribute__((noreturn))
#define __pure                         __attribute__((pure))
#define __aligned(x)                   __attribute__((aligned(x)))
#define __printf(a,b)                  __attribute__((format(printf,a,b)))

  once these are in place, it's up to subsystem maintainers to decide
if they want to take advantage of them.  there is already a strong
precedent for using shortcuts like this in the source tree.

  the ones that might give people pause are "__aligned" and
"__printf", but shortcuts for both of those are already in use, and in
some ways very confusingly.  note the two very different definitions
for a macro named "ALIGNED":

  drivers/net/sgiseeq.c:#define ALIGNED(x) ((((unsigned long)(x)) + 0xf) & ~(0xf))
  drivers/scsi/ultrastor.c:#define ALIGNED(x) __attribute__((aligned(x)))

also:

  include/acpi/platform/acgcc.h:
    #define ACPI_PRINTF_LIKE(c) __attribute__ ((__format__ (__printf__, c, c+1)))

given the precedent, then, it seems logical to at least standardize on
a consistent set of these macros.


 arch/mips/mm/cache.c         |    2 --
 fs/hfs/hfs.h                 |    2 --
 fs/hfsplus/hfsplus_raw.h     |    2 --
 include/linux/compiler-gcc.h |    7 +++++++
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 1f954a2..31819c5 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -107,8 +107,6 @@ void __update_cache(struct vm_area_struct *vma, unsigned long address,
 	}
 }

-#define __weak __attribute__((weak))
-
 static char cache_panic[] __initdata = "Yeee, unsupported cache architecture.";

 void __init cpu_cache_init(void)
diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
index 88099ab..1445e3a 100644
--- a/fs/hfs/hfs.h
+++ b/fs/hfs/hfs.h
@@ -83,8 +83,6 @@

 /*======== HFS structures as they appear on the disk ========*/

-#define __packed __attribute__ ((packed))
-
 /* Pascal-style string of up to 31 characters */
 struct hfs_name {
 	u8 len;
diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
index 4920553..fe99fe8 100644
--- a/fs/hfsplus/hfsplus_raw.h
+++ b/fs/hfsplus/hfsplus_raw.h
@@ -15,8 +15,6 @@

 #include <linux/types.h>

-#define __packed __attribute__ ((packed))
-
 /* Some constants */
 #define HFSPLUS_SECTOR_SIZE        512
 #define HFSPLUS_SECTOR_SHIFT         9
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 6e1c44a..9008eab 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -27,6 +27,13 @@
 #define __inline__	__inline__	__attribute__((always_inline))
 #define __inline	__inline	__attribute__((always_inline))
 #define __deprecated			__attribute__((deprecated))
+#define __packed			__attribute__((packed))
+#define __weak				__attribute__((weak))
+#define __naked				__attribute__((naked))
+#define __noreturn			__attribute__((noreturn))
+#define __pure				__attribute__((pure))
+#define __aligned(x)			__attribute__((aligned(x)))
+#define __printf(a,b)			__attribute__((format(printf,a,b)))
 #define  noinline			__attribute__((noinline))
 #define __attribute_pure__		__attribute__((pure))
 #define __attribute_const__		__attribute__((__const__))
