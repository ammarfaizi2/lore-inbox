Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314621AbSEDQZr>; Sat, 4 May 2002 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314625AbSEDQZq>; Sat, 4 May 2002 12:25:46 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:40968 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S314621AbSEDQZo> convert rfc822-to-8bit;
	Sat, 4 May 2002 12:25:44 -0400
Date: Sat, 4 May 2002 18:25:18 +0200
From: Florian Lohoff <flo@rfc822.org>
To: ivan@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64 cleanup cyclades.c
Message-ID: <20020504162518.GA7785@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
attached a patch which cleanup the parts needed for sparc64. I am using
the driver currently. I can't verify if it breaks i386 or alpha which
seem to be the platforms now.

It changes the definition in cyclades.h to use the kernel fixed bit
defines therefor removes the need for the ifdef __alpha__. It then fixes
the irq beeing unsigned long not unsigned char also the error path
in the cyclom Y init. Need to free resources when aborting.

Against 2.4.18

diff -Nur linux/drivers/char/cyclades.c linux.flo/drivers/char/cyclades.c
--- linux/drivers/char/cyclades.c	Sat May  4 17:31:17 2002
+++ linux.flo/drivers/char/cyclades.c	Sat May  4 17:53:21 2002
@@ -4895,7 +4895,7 @@
                 }
 
                 /* allocate IRQ */
-                if(request_irq(cy_isa_irq, cyy_interrupt,
+                if(request_irq(cy_isa_irq, &cyy_interrupt,
 				   SA_INTERRUPT, "Cyclom-Y", &cy_card[j]))
                 {
                         printk("Cyclom-Y/ISA found at 0x%lx ",
@@ -4956,14 +4956,14 @@
 
   struct pci_dev	*pdev = NULL;
   unsigned char		cyy_rev_id;
-  unsigned char         cy_pci_irq = 0;
-  uclong		cy_pci_phys0, cy_pci_phys1, cy_pci_phys2;
-  uclong		cy_pci_addr0, cy_pci_addr2;
+  unsigned long		cy_pci_irq = 0;
+  unsigned long		cy_pci_phys0, cy_pci_phys1, cy_pci_phys2;
+  unsigned long		cy_pci_addr0, cy_pci_addr2;
   unsigned short        i,j,cy_pci_nchan, plx_ver;
   unsigned short        device_id,dev_index = 0;
-  uclong		mailbox;
-  uclong		Ze_addr0[NR_CARDS], Ze_addr2[NR_CARDS], ZeIndex = 0;
-  uclong		Ze_phys0[NR_CARDS], Ze_phys2[NR_CARDS];
+  unsigned long		mailbox;
+  unsigned long		Ze_addr0[NR_CARDS], Ze_addr2[NR_CARDS], ZeIndex = 0;
+  unsigned long		Ze_phys0[NR_CARDS], Ze_phys2[NR_CARDS];
   unsigned char         Ze_irq[NR_CARDS];
   struct resource *resource;
   unsigned long res_start, res_len;
@@ -5033,6 +5033,7 @@
 		        (ulong)cy_pci_phys2, (ulong)cy_pci_phys0);
 	            printk("Cyclom-Y/PCI not supported for low addresses in "
                            "Alpha systems.\n");
+		    release_region(res_start, res_len);
 		    i--;
 	            continue;
                 }
@@ -5050,6 +5051,7 @@
                         printk("Cyclom-Y PCI host card with ");
                         printk("no Serial-Modules at 0x%lx.\n",
 			    (ulong) cy_pci_phys2);
+			release_region(res_start, res_len);
                         i--;
                         continue;
                 }
@@ -5058,6 +5060,7 @@
 			    (ulong) cy_pci_phys2);
                         printk("but no channels are available.\n");
                         printk("Change NR_PORTS in cyclades.c and recompile kernel.\n");
+			release_region(res_start, res_len);
                         return(i);
                 }
                 /* fill the next cy_card structure available */
@@ -5069,17 +5072,19 @@
 			    (ulong) cy_pci_phys2);
                         printk("but no more cards can be used.\n");
                         printk("Change NR_CARDS in cyclades.c and recompile kernel.\n");
+			release_region(res_start, res_len);
                         return(i);
                 }
 
                 /* allocate IRQ */
-                if(request_irq(cy_pci_irq, cyy_interrupt,
+                if(request_irq(cy_pci_irq, &cyy_interrupt,
 		        SA_SHIRQ, "Cyclom-Y", &cy_card[j]))
                 {
                         printk("Cyclom-Y/PCI found at 0x%lx ",
 			    (ulong) cy_pci_phys2);
-                        printk("but could not allocate IRQ%d.\n",
+                        printk("but could not allocate IRQ%ld.\n",
 			    cy_pci_irq);
+			release_region(res_start, res_len);
                         return(i);
                 }
 
diff -Nur linux/include/linux/cyclades.h linux.flo/include/linux/cyclades.h
--- linux/include/linux/cyclades.h	Sat May  4 17:31:26 2002
+++ linux.flo/include/linux/cyclades.h	Sat May  4 17:50:18 2002
@@ -145,14 +145,9 @@
  *	architectures and compilers.
  */
 
-#if defined(__alpha__)
-typedef unsigned long	ucdouble;	/* 64 bits, unsigned */
-typedef unsigned int	uclong;		/* 32 bits, unsigned */
-#else
-typedef unsigned long	uclong;		/* 32 bits, unsigned */
-#endif
-typedef unsigned short	ucshort;	/* 16 bits, unsigned */
-typedef unsigned char	ucchar;		/* 8 bits, unsigned */
+typedef __u32		uclong;		/* 32 bits, unsigned */
+typedef __u16		ucshort;	/* 16 bits, unsigned */
+typedef __u8		ucchar;		/* 8 bits, unsigned */
 
 /*
  *	Memory Window Sizes




Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.
