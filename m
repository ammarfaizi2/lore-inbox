Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUJBRCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUJBRCf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267408AbUJBRBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:01:25 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:47132
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S267410AbUJBRA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:00:28 -0400
Date: Sat, 2 Oct 2004 19:00:24 +0200
Message-Id: <200410021700.i92H0Ovo021173@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 490] M68k: don't emit empty stack program header in vmlinux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Recent versions of ld add an empty stack program header to the kernel
image, which makes it incompatible with current m68k bootstrap loaders.
Modify the linker script to make sure we see only the program headers that are
really needed. (from Roman Zippel)

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc3/arch/m68k/kernel/vmlinux-std.lds	2004-05-24 11:13:22.000000000 +0200
+++ linux-m68k-2.6.9-rc3/arch/m68k/kernel/vmlinux-std.lds	2004-08-30 21:26:50.000000000 +0200
@@ -15,7 +15,7 @@ SECTIONS
 	SCHED_TEXT
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x4e75
+	} :text = 0x4e75
 
   . = ALIGN(16);		/* Exception table */
   __start___ex_table = .;
@@ -34,7 +34,7 @@ SECTIONS
   .bss : { *(.bss) }		/* BSS */
 
   . = ALIGN(16);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) } :data
 
   _edata = .;			/* End of data section */
 
--- linux-2.6.9-rc3/arch/m68k/kernel/vmlinux.lds.S	2004-04-27 20:21:23.000000000 +0200
+++ linux-m68k-2.6.9-rc3/arch/m68k/kernel/vmlinux.lds.S	2004-08-30 21:26:50.000000000 +0200
@@ -1,5 +1,9 @@
 #include <linux/config.h>
-
+PHDRS
+{
+  text PT_LOAD FILEHDR PHDRS FLAGS (7);
+  data PT_LOAD FLAGS (7);
+}
 #ifdef CONFIG_SUN3
 #include "vmlinux-sun3.lds"
 #else

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
