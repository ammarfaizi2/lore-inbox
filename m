Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268032AbTCFTqE>; Thu, 6 Mar 2003 14:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268276AbTCFTqE>; Thu, 6 Mar 2003 14:46:04 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42200 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268032AbTCFTqB>; Thu, 6 Mar 2003 14:46:01 -0500
Date: Thu, 6 Mar 2003 20:56:28 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.64-ac1: fix apic.c compile
Message-ID: <20030306195628.GC17691@fs.tum.de>
References: <200303061915.h26JFAP06033@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303061915.h26JFAP06033@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The -ac patch adds a second definition of enable_NMI_through_LVT0 to 
apic.c resulting in the following compile error:

<--  snip  -->

...
  gcc -Wp,-MD,arch/i386/kernel/.apic.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=apic -DKBUILD_MODNAME=apic -c -o 
arch/i386/kernel/apic.o arch/i386/kernel/apic.c
arch/i386/kernel/apic.c:72: redefinition of `enable_NMI_through_LVT0'
arch/i386/kernel/apic.c:60: `enable_NMI_through_LVT0' previously defined here
{standard input}: Assembler messages:
{standard input}:126: Error: symbol `enable_NMI_through_LVT0' is already defined
make[1]: *** [arch/i386/kernel/apic.o] Error 1

<--  snip  -->


Please remove the following part of the -ac patch:


--- linux-2.5.64/arch/i386/kernel/apic.c	2003-03-06 17:04:22.000000000 +0000
+++ linux-2.5.64-ac1/arch/i386/kernel/apic.c	2003-03-06 17:08:59.000000000 +0000
@@ -66,6 +68,18 @@
 	apic_write_around(APIC_LVT0, v);
 }
 
+void enable_NMI_through_LVT0 (void * dummy)
+{
+	unsigned int v, ver;
+
+	ver = apic_read(APIC_LVR);
+	ver = GET_APIC_VERSION(ver);
+	v = APIC_DM_NMI;			/* unmask and set to NMI */
+	if (!APIC_INTEGRATED(ver))		/* 82489DX */
+		v |= APIC_LVT_LEVEL_TRIGGER;
+	apic_write_around(APIC_LVT0, v);
+}
+
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

