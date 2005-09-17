Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVIQG55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVIQG55 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 02:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVIQG55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 02:57:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:29639 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750980AbVIQG54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 02:57:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: Re: [patch 08/11] spufs: make mem files mmappable
Date: Sat, 17 Sep 2005 08:58:41 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
       Hiroyuki Machida <machida@sm.sony.co.jp>
References: <20050916121646.387617000@localhost> <20050916123314.366475000@localhost>
In-Reply-To: <20050916123314.366475000@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509170858.41724.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 16 September 2005 14:16, Arnd Bergmann wrote:
> This should get better as soon as extreme sparsemem gets merged.
> 
Actually, it first got worse.

The initialization for the SPU page structures broke
with the inclusion of extreme sparsemem in current
kernels. This patch works around that problem by further
moving code around.

I still need to find a way to do this in a cleaner way,
but for now, it restores the basic functionality.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

Index: linux-cg/include/asm-ppc64/spu.h
===================================================================
--- linux-cg.orig/include/asm-ppc64/spu.h
+++ linux-cg/include/asm-ppc64/spu.h
@@ -167,6 +167,13 @@ static inline void unregister_spu_syscal
 }
 #endif /* MODULE */
 
+#if defined(CONFIG_SPARSEMEM) && defined(CONFIG_PPC_BPA)
+void __init bpa_spumem_init(int early);
+#else
+static inline void bpa_spumem_init(int early)
+{
+}
+#endif
 
 /*
  * This defines the Local Store, Problem Area and Privlege Area of an SPU.
Index: linux-cg/arch/ppc64/kernel/bpa_setup.c
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/bpa_setup.c
+++ linux-cg/arch/ppc64/kernel/bpa_setup.c
@@ -122,7 +122,7 @@ static void __init bpa_spuprop_present(s
 	}
 }
 
-static void __init bpa_spumem_init(int early)
+void __init bpa_spumem_init(int early)
 {
 	struct device_node *node;
 	for (node = of_find_node_by_type(NULL, "spe");
@@ -133,10 +133,6 @@ static void __init bpa_spumem_init(int e
 		bpa_spuprop_present(node, "priv2", early);
 	}
 }
-#else
-static void __init bpa_spumem_init(int early)
-{
-}
 #endif
 
 static void bpa_progress(char *s, unsigned short hex)
@@ -187,8 +183,6 @@ static void __init bpa_init_early(void)
 
 	ppc64_interrupt_controller = IC_BPA_IIC;
 
-	bpa_spumem_init(1);
-
 	DBG(" <- bpa_init_early()\n");
 }
 
Index: linux-cg/arch/ppc64/kernel/setup.c
===================================================================
--- linux-cg.orig/arch/ppc64/kernel/setup.c
+++ linux-cg/arch/ppc64/kernel/setup.c
@@ -58,6 +58,7 @@
 #include <asm/mmu.h>
 #include <asm/lmb.h>
 #include <asm/iSeries/ItLpNaca.h>
+#include <asm/spu.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -1042,6 +1043,8 @@ void __init setup_arch(char **cmdline_p)
 
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
+	bpa_spumem_init(1);
+
 	sparse_init();
 
 	/* initialize the syscall map in systemcfg */
