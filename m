Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316211AbSEKLtU>; Sat, 11 May 2002 07:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316212AbSEKLtT>; Sat, 11 May 2002 07:49:19 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:17577 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S316211AbSEKLtT>;
	Sat, 11 May 2002 07:49:19 -0400
Date: Sat, 11 May 2002 13:47:57 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205111147.NAA07199@harpo.it.uu.se>
To: hch@infradead.org
Subject: 2.4.19-pre7+ I/O-APIC inconsistency
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19-pre7 changed the behaviour of CONFIG_X86_UP_IOAPIC due
to the following patch

--- linux-2.4.19-pre6/arch/i386/kernel/io_apic.c	Mon Apr 15 21:53:25 2002
+++ linux-2.4.19-pre7/arch/i386/kernel/io_apic.c	Mon Apr 15 21:54:19 2002
@@ -191,15 +191,27 @@
 #define MAX_PIRQS 8
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
-int skip_ioapic_setup;
+#ifdef CONFIG_X86_UP_APIC
+int skip_ioapic_setup=1;
+#else
+int skip_ioapic_setup=0;
+#endif
 
which patch-2.4.19.log seems to attribute to <hch@infradead.org>.

This causes CONFIG_X86_UP_IOAPIC to no longer attempt to use the
I/O-APIC like it used to: now you also have to append an "apic"
command-line option to the kernel. Not only is this a break from
previous behaviour and the documentation (Configure.help), but
it's also inconsistent with SMP, since an SMP kernel _will_ try
to use the I/O-APIC without any additional hackery needed.

(I just helped some high-speed Linux routing colleagues over here
debug a problem with their new dual P4 Xeon E7500 chipset boxes.
SMP kernels worked, but they couldn't figure out why UP_IOAPIC
kernels wouldn't detect and use the I/O-APIC. The patch above was
the culprit.)

Unless this change is absolutely necessary (note that the "noapic"
command line option is still functional for those that need it), I
suggest applying the patch below to restore the previous behaviour.

/Mikael

--- linux-2.4.19-pre8/arch/i386/kernel/io_apic.c.~1~	Sat May 11 12:30:26 2002
+++ linux-2.4.19-pre8/arch/i386/kernel/io_apic.c	Sat May 11 12:37:06 2002
@@ -191,11 +191,7 @@
 #define MAX_PIRQS 8
 int pirq_entries [MAX_PIRQS];
 int pirqs_enabled;
-#ifdef CONFIG_X86_UP_APIC
-int skip_ioapic_setup=1;
-#else
-int skip_ioapic_setup=0;
-#endif
+int skip_ioapic_setup;
 
 static int __init noioapic_setup(char *str)
 {
