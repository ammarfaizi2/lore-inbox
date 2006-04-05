Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWDEAHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWDEAHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWDEAAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:00:54 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:10128
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750960AbWDEAAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:00:48 -0400
Date: Tue, 4 Apr 2006 17:00:04 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       sfr@canb.auug.org.au, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 07/26] powerpc: make ISA floppies work again
Message-ID: <20060405000004.GH27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="powerpc-make-isa-floppies-work-again.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Stephen Rothwell <sfr@canb.auug.org.au>

We used to assume that a DMA mapping request with a NULL dev was for
ISA DMA.  This assumption was broken at some point.  Now we explicitly
pass the detected ISA PCI device in the floppy setup.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/powerpc/kernel/pci_64.c |    1 +
 include/asm-powerpc/floppy.h |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.16.1.orig/arch/powerpc/kernel/pci_64.c
+++ linux-2.6.16.1/arch/powerpc/kernel/pci_64.c
@@ -78,6 +78,7 @@ int global_phb_number;		/* Global phb co
 
 /* Cached ISA bridge dev. */
 struct pci_dev *ppc64_isabridge_dev = NULL;
+EXPORT_SYMBOL_GPL(ppc64_isabridge_dev);
 
 static void fixup_broken_pcnet32(struct pci_dev* dev)
 {
--- linux-2.6.16.1.orig/include/asm-powerpc/floppy.h
+++ linux-2.6.16.1/include/asm-powerpc/floppy.h
@@ -35,6 +35,7 @@
 #ifdef CONFIG_PCI
 
 #include <linux/pci.h>
+#include <asm/ppc-pci.h>	/* for ppc64_isabridge_dev */
 
 #define fd_dma_setup(addr,size,mode,io) powerpc_fd_dma_setup(addr,size,mode,io)
 
@@ -52,12 +53,12 @@ static __inline__ int powerpc_fd_dma_set
 	if (bus_addr 
 	    && (addr != prev_addr || size != prev_size || dir != prev_dir)) {
 		/* different from last time -- unmap prev */
-		pci_unmap_single(NULL, bus_addr, prev_size, prev_dir);
+		pci_unmap_single(ppc64_isabridge_dev, bus_addr, prev_size, prev_dir);
 		bus_addr = 0;
 	}
 
 	if (!bus_addr)	/* need to map it */
-		bus_addr = pci_map_single(NULL, addr, size, dir);
+		bus_addr = pci_map_single(ppc64_isabridge_dev, addr, size, dir);
 
 	/* remember this one as prev */
 	prev_addr = addr;

--
