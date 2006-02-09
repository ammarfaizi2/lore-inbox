Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWBIMxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWBIMxQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 07:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBIMxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 07:53:16 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:27626 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750993AbWBIMxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 07:53:15 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Keith Owens'" <kaos@sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
References: <20060208035112.GM3524@stusta.de>
	<200602080552.k185q9g07813@unix-os.sc.intel.com>
	<20060208115946.GN3524@stusta.de> <yq0d5hym0lq.fsf@jaguar.mkp.net>
	<20060208213825.GQ3524@stusta.de>
From: Jes Sorensen <jes@sgi.com>
Date: 09 Feb 2006 07:53:11 -0500
In-Reply-To: <20060208213825.GQ3524@stusta.de>
Message-ID: <yq0zml0lmmg.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:

Adrian> On Wed, Feb 08, 2006 at 08:38:57AM -0500, Jes Sorensen wrote:
>> Not really, it helps a bit by selecting some things we know we need
>> for all GENERIC builds. True we can't make it bullet proof, but
>> whats there is better than removing it.

Adrian> Like the bug of allowing the illegal configuration NUMA=y,
Adrian> FLATMEM=y?

Adrian,

There's other reasons why this is a moot exercise anyway, allyesconfig
doesn't link on ia64 due to the size of the object exceeding the reach
of the relative link relocs. Not much you can do about that.

Here's a patch that will make it all build until it tries to link. It
includes a simplified version of Ken's patch. Now can we please
dismiss this issue once and for all and go back to getting real work
done?

Tony, would you apply at least the part of this touching
arch/ia64/Kconfig if you do not fancy taking it all, please.

Thanks,
Jes

Various fixes to help allyesconfig on ia64:
- ARCH_FLATMEM_ENABLE is incompatible with NUMA
- atm code tries to include kernel headers to decide upon byteorder
  without allowing for said header file to include other files
- HP100 driver cannot be compiled on systems without ISA support in it's
  current state.
- Add check_signature() to include/asm-ia64/io.h
- Include vmalloc.h in mixart_hwdep.c which uses vmalloc

Signed-off-by: Jes Sorensen <jes@sgi.com>

----

 arch/ia64/Kconfig               |    1 +
 drivers/atm/Makefile            |    2 +-
 drivers/net/Kconfig             |    2 +-
 include/asm-ia64/io.h           |   15 +++++++++++++++
 sound/pci/mixart/mixart_hwdep.c |    1 +
 5 files changed, 19 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig
+++ linux-2.6/arch/ia64/Kconfig
@@ -297,6 +297,7 @@
  	  See <file:Documentation/vm/numa> for more.
 
 config ARCH_FLATMEM_ENABLE
+	depends on !NUMA
 	def_bool y
 
 config ARCH_SPARSEMEM_ENABLE
Index: linux-2.6/drivers/atm/Makefile
===================================================================
--- linux-2.6.orig/drivers/atm/Makefile
+++ linux-2.6/drivers/atm/Makefile
@@ -41,7 +41,7 @@
   # guess the target endianess to choose the right PCA-200E firmware image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
     byteorder.h			:= include$(if $(patsubst $(srctree),,$(objtree)),2)/asm/byteorder.h
-    CONFIG_ATM_FORE200E_PCA_FW	:= $(obj)/pca200e$(if $(shell $(CC) -E -dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
+    CONFIG_ATM_FORE200E_PCA_FW	:= $(obj)/pca200e$(if $(shell $(CC) -I$(srctree)/include -E -dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
   endif
 endif
 
Index: linux-2.6/drivers/net/Kconfig
===================================================================
--- linux-2.6.orig/drivers/net/Kconfig
+++ linux-2.6/drivers/net/Kconfig
@@ -946,7 +946,7 @@
 
 config HP100
 	tristate "HP 10/100VG PCLAN (ISA, EISA, PCI) support"
-	depends on NET_ETHERNET && (ISA || EISA || PCI)
+	depends on NET_ETHERNET && ISA || EISA
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
Index: linux-2.6/include/asm-ia64/io.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/io.h
+++ linux-2.6/include/asm-ia64/io.h
@@ -435,6 +435,21 @@
 
 #define ioremap_nocache(o,s)	ioremap(o,s)
 
+static inline int
+check_signature(void __iomem *io_addr, const unsigned char *signature,
+		int length)
+{
+	int retval = 0;
+	do {
+		if (readb(io_addr) != *signature++)
+			goto out;
+		io_addr++;
+	} while (--length);
+	retval = 1;
+ out:
+	return retval;
+}
+
 # ifdef __KERNEL__
 
 /*
Index: linux-2.6/sound/pci/mixart/mixart_hwdep.c
===================================================================
--- linux-2.6.orig/sound/pci/mixart/mixart_hwdep.c
+++ linux-2.6/sound/pci/mixart/mixart_hwdep.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/firmware.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 #include <sound/core.h>
 #include "mixart.h"
