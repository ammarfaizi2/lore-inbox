Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281558AbRKMJek>; Tue, 13 Nov 2001 04:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281560AbRKMJe3>; Tue, 13 Nov 2001 04:34:29 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:49924 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S281558AbRKMJeP>; Tue, 13 Nov 2001 04:34:15 -0500
Date: Tue, 13 Nov 2001 10:34:06 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.15-pre4 full build for i386, warnings
In-Reply-To: <13136.1005634661@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0111131018010.31786-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Keith Owens wrote:

> depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/char/isicom.o
> depmod:		xquad_portio
> depmod: *** Unresolved symbols in /var/tmp/lib/modules/2.4.15-pre4/kernel/drivers/isdn/hysdn/hysdn.o
> depmod:		xquad_portio
> [...]

That's supposedly because xquad_portio (ifdef CONFIG_MULTIQUAD) is not 
exported, thus causing all modules using I/O instructions to fail.

I also see a static definition of xquad_portio in 
arch/i386/boot/compressed/misc.c, for which I don't understand why it's 
needed at all.

Trivial patch appended.

--Kai


diff -ur linux-2.4.15-pre4/arch/i386/kernel/i386_ksyms.c linux-2.4.15-pre4.work/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.15-pre4/arch/i386/kernel/i386_ksyms.c	Tue Nov 13 10:15:23 2001
+++ linux-2.4.15-pre4.work/arch/i386/kernel/i386_ksyms.c	Tue Nov 13 10:28:39 2001
@@ -177,3 +177,7 @@
 
 extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
+
+#ifdef CONFIG_MULTIQUAD
+EXPORT_SYMBOL(xquad_portio);
+#endif
diff -ur linux-2.4.15-pre4/arch/i386/kernel/smpboot.c linux-2.4.15-pre4.work/arch/i386/kernel/smpboot.c
--- linux-2.4.15-pre4/arch/i386/kernel/smpboot.c	Fri Oct  5 03:42:54 2001
+++ linux-2.4.15-pre4.work/arch/i386/kernel/smpboot.c	Tue Nov 13 10:26:50 2001
@@ -969,7 +969,7 @@
 
 static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
-void *xquad_portio = NULL;
+void *xquad_portio;
 
 void __init smp_boot_cpus(void)
 {

