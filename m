Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSK1Mx5>; Thu, 28 Nov 2002 07:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSK1Mx5>; Thu, 28 Nov 2002 07:53:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25577 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265457AbSK1Mx4>; Thu, 28 Nov 2002 07:53:56 -0500
Date: Thu, 28 Nov 2002 14:01:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-rc4-ac1
Message-ID: <20021128130112.GB6981@fs.tum.de>
References: <200211261901.gAQJ13T11036@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211261901.gAQJ13T11036@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__
-I/home/bunk/linux/kernel-2.4/linux-2.4.19-full-ac/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=pci_pc  -c -o pci-pc.o pci-pc.c
pci-pc.c:178: warning: `PCI_CONF1_ADDRESS' redefined
pci-pc.c:56: warning: this is the location of the previous definition
pci-pc.c: In function `pci_check_direct':
pci-pc.c:481: `CLUSTERED_APIC_NUMAQ' undeclared (first use in this function)
pci-pc.c:481: (Each undeclared identifier is reported only once
pci-pc.c:481: for each function it appears in.)
...
make[1]: *** [pci-pc.o] Error 1
make[1]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-full-ac/arch/i386/kernel'

<--  snip  -->


Martin, could you please review whether the patch below which does the
following is correct?

- kill the last occurence of CLUSTERED_APIC_NUMAQ
- only one definition of PCI_CONF1_ADDRESS is needed
  (#ifndef CONFIG_MULTIQUAD the BUS2LOCAL() has no effect)
- fix an #endif comment


TIA
Adrian


--- linux-2.4.19-full-ac/arch/i386/kernel/pci-pc.c.old	2002-11-28 12:51:01.000000000 +0100
+++ linux-2.4.19-full-ac/arch/i386/kernel/pci-pc.c	2002-11-28 13:49:50.000000000 +0100
@@ -51,10 +51,10 @@
 
 #ifdef CONFIG_PCI_DIRECT
 
-#ifdef CONFIG_MULTIQUAD
 #define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
+#ifdef CONFIG_MULTIQUAD
 static int pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value) /* CONFIG_MULTIQUAD */
 {
 	unsigned long flags;
@@ -173,9 +173,7 @@
 	pci_conf1_write_mq_config_dword
 };
 
-#endif /* !CONFIG_MULTIQUAD */
-#define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+#endif /* CONFIG_MULTIQUAD */
 
 static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value) /* !CONFIG_MULTIQUAD */
 {
@@ -478,7 +476,7 @@
 
 #ifdef CONFIG_MULTIQUAD			
 			/* Multi-Quad has an extended PCI Conf1 */
-			if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
+			if(clustered_apic_logical)
 				return &pci_direct_mq_conf1;
 #endif				
 			return &pci_direct_conf1;
