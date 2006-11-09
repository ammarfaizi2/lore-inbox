Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424097AbWKIQLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424097AbWKIQLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424099AbWKIQLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:11:08 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:12709 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1424097AbWKIQLE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:11:04 -0500
To: =?iso-8859-1?q?Fernando_Luis_V=E1zquez_Cao?= 
	<fernando@oss.ntt.co.jp>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Robin Holt <holt@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 0/1] mspec driver: compile error
References: <1162881017.13700.105.camel@sebastian.intellilink.co.jp>
	<4550609A.7010908@sgi.com> <20061107133512.a49b11e0.akpm@osdl.org>
	<1162977589.7805.77.camel@sebastian.intellilink.co.jp>
	<4551A66A.2070506@sgi.com>
	<1162979130.7805.80.camel@sebastian.intellilink.co.jp>
	<20061108015618.571242fb.akpm@osdl.org> <4551B1ED.2000405@sgi.com>
	<1162983174.3054.43.camel@sebastian.intellilink.co.jp>
From: Jes Sorensen <jes@sgi.com>
Date: 09 Nov 2006 11:10:55 -0500
In-Reply-To: <1162983174.3054.43.camel@sebastian.intellilink.co.jp>
Message-ID: <yq01woc61o0.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=latin-iso8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Fernando" == Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> writes:

Fernando> Perhaps the right fix would be modifying allmodconfig so
Fernando> that it takes into account dependecies (i.e. "depends on",
Fernando> "select", etc).

Thats probably it.

In the mean time I thought about this and I think the best solution
until the allxxxconfig is fixed, is to move the MSPEC option to
arch/ia64/Kconfig.

Andrew will you be ok with this version ?

Cheers,
Jes

Fix MSPEC driver to build for non SN2 enabled configs as the driver
should work in cached and uncached modes (no fetchop) on these systems.
In addition make MSPEC select IA64_UNCACHED_ALLOCATOR, which is required
for it and move it to arch/ia64/Kconfig to avoid warnings on non ia64
architectures running allmodconfig. Once the Kconfig code is fixed, we
can move it back.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 arch/ia64/Kconfig           |    9 +++++++++
 drivers/char/Kconfig        |    8 --------
 drivers/char/mspec.c        |    8 +++++++-
 include/asm-ia64/sn/addrs.h |    6 +++++-
 4 files changed, 21 insertions(+), 10 deletions(-)

Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig
+++ linux-2.6/arch/ia64/Kconfig
@@ -484,6 +484,15 @@ source "net/Kconfig"
 
 source "drivers/Kconfig"
 
+config MSPEC
+	tristate "Memory special operations driver"
+	depends on IA64
+	select IA64_UNCACHED_ALLOCATOR
+	help
+	  If you have an ia64 and you want to enable memory special
+	  operations support (formerly known as fetchop), say Y here,
+	  otherwise say N.
+
 source "fs/Kconfig"
 
 source "lib/Kconfig"
Index: linux-2.6/drivers/char/Kconfig
===================================================================
--- linux-2.6.orig/drivers/char/Kconfig
+++ linux-2.6/drivers/char/Kconfig
@@ -409,14 +409,6 @@ config SGI_MBCS
          If you have an SGI Altix with an attached SABrick
          say Y or M here, otherwise say N.
 
-config MSPEC
-	tristate "Memory special operations driver"
-	depends on IA64
-	help
-	  If you have an ia64 and you want to enable memory special
-	  operations support (formerly known as fetchop), say Y here,
-	  otherwise say N.
-
 source "drivers/serial/Kconfig"
 
 config UNIX98_PTYS
Index: linux-2.6/drivers/char/mspec.c
===================================================================
--- linux-2.6.orig/drivers/char/mspec.c
+++ linux-2.6/drivers/char/mspec.c
@@ -72,7 +72,11 @@ enum {
 	MSPEC_UNCACHED
 };
 
+#ifdef CONFIG_SGI_SN
 static int is_sn2;
+#else
+#define is_sn2		0
+#endif
 
 /*
  * One of these structures is allocated when an mspec region is mmaped. The
@@ -211,7 +215,7 @@ mspec_nopfn(struct vm_area_struct *vma, 
 	if (vdata->type == MSPEC_FETCHOP)
 		paddr = TO_AMO(maddr);
 	else
-		paddr = __pa(TO_CAC(maddr));
+		paddr = maddr & ~__IA64_UNCACHED_OFFSET;
 
 	pfn = paddr >> PAGE_SHIFT;
 
@@ -335,6 +339,7 @@ mspec_init(void)
 	 * The fetchop device only works on SN2 hardware, uncached and cached
 	 * memory drivers should both be valid on all ia64 hardware
 	 */
+#ifdef CONFIG_SGI_SN
 	if (ia64_platform_is("sn2")) {
 		is_sn2 = 1;
 		if (is_shub2()) {
@@ -363,6 +368,7 @@ mspec_init(void)
 			goto free_scratch_pages;
 		}
 	}
+#endif
 	ret = misc_register(&cached_miscdev);
 	if (ret) {
 		printk(KERN_ERR "%s: failed to register device %i\n",
Index: linux-2.6/include/asm-ia64/sn/addrs.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/sn/addrs.h
+++ linux-2.6/include/asm-ia64/sn/addrs.h
@@ -136,9 +136,13 @@
  */
 #define TO_PHYS(x)		(TO_PHYS_MASK & (x))
 #define TO_CAC(x)		(CAC_BASE     | TO_PHYS(x))
+#ifdef CONFIG_SGI_SN
 #define TO_AMO(x)		(AMO_BASE     | TO_PHYS(x))
 #define TO_GET(x)		(GET_BASE     | TO_PHYS(x))
-
+#else
+#define TO_AMO(x)		({ BUG(); x; })
+#define TO_GET(x)		({ BUG(); x; })
+#endif
 
 /*
  * Covert from processor physical address to II/TIO physical address:
