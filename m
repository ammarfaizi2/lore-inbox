Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUAYXtt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUAYXtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:49:49 -0500
Received: from colin2.muc.de ([193.149.48.15]:35855 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265316AbUAYXtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:49:45 -0500
Date: 26 Jan 2004 00:47:56 +0100
Date: Mon, 26 Jan 2004 00:47:56 +0100
From: Andi Kleen <ak@muc.de>
To: John Stoffel <stoffel@lucent.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andi Kleen <ak@muc.de>,
       Valdis.Kletnieks@vt.edu, Fabio Coatti <cova@ferrara.linux.it>,
       Andrew Morton <akpm@osdl.org>, Eric <eric@cisu.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-ID: <20040125234756.GF28576@colin2.muc.de>
References: <200401251811.27890.cova@ferrara.linux.it> <20040125173048.GL513@fs.tum.de> <20040125174837.GB16962@colin2.muc.de> <200401251800.i0PI0SmV001246@turing-police.cc.vt.edu> <20040125191232.GC16962@colin2.muc.de> <16404.9520.764788.21497@gargle.gargle.HOWL> <20040125202557.GD16962@colin2.muc.de> <16404.10496.50601.268391@gargle.gargle.HOWL> <20040125214920.GP513@fs.tum.de> <16404.20183.783477.596431@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16404.20183.783477.596431@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 06:18:47PM -0500, John Stoffel wrote:
> 
> Adrian> On Sun, Jan 25, 2004 at 03:37:20PM -0500, John Stoffel wrote:
> 
> >> More confirmation as I get it.
> 
> Adrian> I'd say that's a different issue: The gcc 3.3 in debian
> Adrian> unstable doesn't know about -funit-at-a-time, and it should
> Adrian> therefore not be affected by this problem.
> 
> It certainly didn't seem to make a difference, after doing a make
> mrproper and then putting my .config back in place, it still doesn't
> boot.  I'm not doing anything funky in grub, here's my boot options:

Can you apply the appended patch and boot with earlyprintk=serial 
(+ serial console with 38400 baud on ttyS0 and a terminal program
that does logging on the other side). If you don't have a serial
console you can also use earlyprintk=vga , but that would require
writing down what's on the screen.

What does it say? 

-Andi


diff -u linux-2.6.2rc1mm3/arch/i386/Kconfig-o linux-2.6.2rc1mm3/arch/i386/Kconfig
--- linux-2.6.2rc1mm3/arch/i386/Kconfig-o	2004-01-25 22:40:18.000000000 +0100
+++ linux-2.6.2rc1mm3/arch/i386/Kconfig	2004-01-25 23:23:17.282866816 +0100
@@ -1247,6 +1247,10 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config EARLY_PRINTK
+       bool
+       default y 
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
diff -u linux-2.6.2rc1mm3/arch/i386/kernel/setup.c-o linux-2.6.2rc1mm3/arch/i386/kernel/setup.c
--- linux-2.6.2rc1mm3/arch/i386/kernel/setup.c-o	2004-01-25 22:40:18.000000000 +0100
+++ linux-2.6.2rc1mm3/arch/i386/kernel/setup.c	2004-01-25 23:59:43.123568520 +0100
@@ -1118,6 +1118,18 @@
 #endif
 	paging_init();
 
+#ifdef CONFIG_EARLY_PRINTK
+	{
+	char *s = strstr(*cmdline_p, "earlyprintk="); 
+	if (s) { 
+	     extern void setup_early_printk(char *);
+	     setup_early_printk(s+12); 
+             printk("early console should work ....\n");
+	}
+	}
+#endif
+
+
 	dmi_scan_machine();
 
 #ifdef CONFIG_X86_GENERICARCH
diff -u linux-2.6.2rc1mm3/arch/i386/kernel/Makefile-o linux-2.6.2rc1mm3/arch/i386/kernel/Makefile
--- linux-2.6.2rc1mm3/arch/i386/kernel/Makefile-o	2004-01-25 22:40:18.000000000 +0100
+++ linux-2.6.2rc1mm3/arch/i386/kernel/Makefile	2004-01-25 23:23:19.082593216 +0100
@@ -32,6 +32,9 @@
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
+obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+
+early_printk-y := ../../x86_64/kernel/early_printk.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -u linux-2.6.2rc1mm3/arch/x86_64/kernel/early_printk.c-o linux-2.6.2rc1mm3/arch/x86_64/kernel/early_printk.c
--- linux-2.6.2rc1mm3/arch/x86_64/kernel/early_printk.c-o	2003-05-27 03:00:44.000000000 +0200
+++ linux-2.6.2rc1mm3/arch/x86_64/kernel/early_printk.c	2004-01-25 23:25:25.978302136 +0100
@@ -7,7 +7,11 @@
 
 /* Simple VGA output */
 
+#ifdef __i386__
+#define VGABASE		(__PAGE_OFFSET + 0xb8000UL)
+#else
 #define VGABASE		0xffffffff800b8000UL
+#endif
 
 #define MAX_YPOS	25
 #define MAX_XPOS	80
