Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266104AbRGGLoV>; Sat, 7 Jul 2001 07:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRGGLoK>; Sat, 7 Jul 2001 07:44:10 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:50439 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266104AbRGGLoF>;
	Sat, 7 Jul 2001 07:44:05 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.62880.772230.734585@tango.paulus.ozlabs.org>
Date: Sat, 7 Jul 2001 21:42:24 +1000 (EST)
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, dhinds@zen.stanford.edu
Subject: Memory region check in drivers/pcmcia/rsrc_mgr.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/pcmcia/rsrc_mgr.c, there is code that check whether a given
range of PCI memory addresses are available for the pcmcia code to
use.  This code uses a macro, check_mem_resource(), to check whether a
particular region is available, defined like this:

#define check_mem_resource(b,n)	check_resource(&iomem_resource, (b), (n))

This code is now causing me problems on my powerbook because we now
register the regions mapped by each PCI host bridge in the
iomem_resource structure.  The basic problem is that check_resource
only checks at the top level of the iomem_resource tree.  I think that
we should be using check_mem_region instead, which will descend the
tree until it finds out whether the region is actually in use or not.

The patch below does this (and makes a similar correction for I/O
space).  With this patch applied, the pcmcia stuff works fine on my
powerbook, and I end up with something like this in /proc/iomem:

80000000-afffffff : /pci@f2000000
  80000000-8007ffff : Apple Computer Inc. KeyLargo Mac I/O
  90000000-9fffffff : PCI CardBus #02
  a0000000-a0000fff : Texas Instruments PCI1211
  a0001000-a0001fff : Apple Computer Inc. KeyLargo USB (#2)
    a0001000-a0001fff : usb-ohci
  a0002000-a0002fff : Apple Computer Inc. KeyLargo USB
    a0002000-a0002fff : usb-ohci
  a7000000-a7000fff : card services
b0000000-bfffffff : /pci@f0000000
  b0000000-b0003fff : ATI Technologies Inc Mobility M3 AGP 2x
    b0000000-b0003fff : aty128fb MMIO
  b4000000-b7ffffff : ATI Technologies Inc Mobility M3 AGP 2x
    b4000000-b7ffffff : aty128fb FB
f1000000-f1ffffff : /pci@f0000000
f3000000-f3ffffff : /pci@f2000000
  f3000000-f33fffff : PCI CardBus #02
f5000000-f5ffffff : /pci@f4000000
  f5000000-f5000fff : Apple Computer Inc. UniNorth FireWire
  f5200000-f53fffff : Apple Computer Inc. UniNorth GMAC

Linus, would you apply this patch to your tree?

Paul.

diff -urN linux/drivers/pcmcia/rsrc_mgr.c pmac/drivers/pcmcia/rsrc_mgr.c
--- linux/drivers/pcmcia/rsrc_mgr.c	Sat Mar 31 03:06:19 2001
+++ pmac/drivers/pcmcia/rsrc_mgr.c	Wed Jun 20 14:25:25 2001
@@ -104,8 +104,8 @@
 
 ======================================================================*/
 
-#define check_io_resource(b,n)	check_resource(&ioport_resource, (b), (n))
-#define check_mem_resource(b,n)	check_resource(&iomem_resource, (b), (n))
+#define check_io_resource(b,n)	check_region((b), (n))
+#define check_mem_resource(b,n)	check_mem_region((b), (n))
 
 /*======================================================================
 
