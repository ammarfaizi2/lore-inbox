Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbTBUPR1>; Fri, 21 Feb 2003 10:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267489AbTBUPR1>; Fri, 21 Feb 2003 10:17:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30147 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267485AbTBUPRY>; Fri, 21 Feb 2003 10:17:24 -0500
Date: Fri, 21 Feb 2003 16:27:25 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>, James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.62-ac1: fix the compilation of aty128fb.c
Message-ID: <20030221152725.GQ531@fs.tum.de>
References: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302202233.h1KMX8408821@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 05:33:08PM -0500, Alan Cox wrote:

>...
> Linux 2.5.62-ac1
>...
> o	FBdev updates					(James Simmons)
>...

gcc 2.95 doesn't like variable declarations in the middle of a function:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/video/.aty128fb.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=aty128fb -DKBUILD_MODNAME=aty128fb -c -o drivers
/video/aty128fb.o drivers/video/aty128fb.c
drivers/video/aty128fb.c: In function `aty128_map_ROM':
drivers/video/aty128fb.c:1811: parse error before `unsigned'
drivers/video/aty128fb.c:1814: `addr' undeclared (first use in this function)
drivers/video/aty128fb.c:1814: (Each undeclared identifier is reported only once
drivers/video/aty128fb.c:1814: for each function it appears in.)
drivers/video/aty128fb.c: In function `aty128_unmap_ROM':
drivers/video/aty128fb.c:1827: parse error before `struct'
drivers/video/aty128fb.c:1828: `r' undeclared (first use in this function)
make[2]: *** [drivers/video/aty128fb.o] Error 1

<--  snip  -->


The following patch fixes the compilation:


--- linux-2.5.62-ac/drivers/video/aty128fb.c.old	2003-02-21 16:14:58.000000000 +0100
+++ linux-2.5.62-ac/drivers/video/aty128fb.c	2003-02-21 16:21:02.000000000 +0100
@@ -1793,6 +1793,8 @@
 #if !defined(CONFIG_PPC) && !defined(__sparc__)
 static void * __init aty128_map_ROM(struct pci_dev *dev)
 {
+	unsigned char *addr;
+
 	// If this is a primary card, there is a shadow copy of the
 	// ROM somewhere in the first meg. We will just ignore the copy
 	// and use the ROM directly.
@@ -1808,7 +1810,7 @@
 	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE))
 		pci_write_config_dword(dev, dev->rom_base_reg, r->start | PCI_ROM_ADDRESS_ENABLE);
 	
-	unsigned char *addr = ioremap(r->start, r->end - r->start + 1);
+	addr = ioremap(r->start, r->end - r->start + 1);
 	
 	// Very simple test to make sure it appeared
 	if (addr && (*addr != 0x55)) {
@@ -1821,10 +1823,12 @@
 
 static void __init aty128_unmap_ROM(struct pci_dev *dev, void * rom)
 {
+	struct resource *r;
+
 	iounmap(rom);
 	
 	// leave it disabled and unassigned
-	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+	r = &dev->resource[PCI_ROM_RESOURCE];
 	r->flags &= !PCI_ROM_ADDRESS_ENABLE;
 	r->end -= r->start;
 	r->start = 0;



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

