Return-Path: <linux-kernel-owner+w=401wt.eu-S1750873AbWLLCiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWLLCiZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 21:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWLLCiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 21:38:24 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:38830 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbWLLCiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 21:38:23 -0500
Date: Mon, 11 Dec 2006 21:38:05 -0500
From: Kyle McMartin <kyle@ubuntu.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Whinge in paging_init if noexec is on with a non-PAE kernel
Message-ID: <20061212023805.GE4044@athena.road.mcmartin.ca>
References: <20061212000359.GB4044@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212000359.GB4044@athena.road.mcmartin.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On second thought, this is probably better since most people will
presumably be booting non-PAE kernels, generating this message when
they've not tried to force the issue seems silly.

This way, the user will only see a warning if they actually go
out and specify "noexec=on" on the command line.

Sucks to have to do #ifdef #else though, I wonder if there's a
better way to initialize that.

Cheers,
	Kyle

diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
index 84697df..ff389f1 100644
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -422,7 +422,15 @@ void zap_low_mappings (void)
 	flush_tlb_all();
 }
 
+/* disable_nx = 0 will generate unwanted warnings if it is
+ * the default case for non-PAE kernels, but we probably want
+ * NX by default on kernels built with PAE.
+ */
+#ifdef CONFIG_X86_PAE
 static int disable_nx __initdata = 0;
+#else
+static int disable_nx __initdata = 1;
+#endif
 u64 __supported_pte_mask __read_mostly = ~_PAGE_NX;
 
 /*
@@ -512,6 +520,9 @@ void __init paging_init(void)
 	set_nx();
 	if (nx_enabled)
 		printk("NX (Execute Disable) protection: active\n");
+#else
+	if (!disable_nx)
+		printk("NX (Execute Disable) only supported with CONFIG_HIGHMEM64G\n");
 #endif
 
 	pagetable_init();
