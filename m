Return-Path: <linux-kernel-owner+w=401wt.eu-S1750747AbXAKPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXAKPp7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 10:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXAKPp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 10:45:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:37530 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbXAKPp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 10:45:57 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=V5+oSmczzsp31eyNk3KWBy72d+pkeYa5R7ZwJBz/OI1rXp4FIk4pr5Yh8iZczcqa2xNAD03pDcrvS3v3fb0jtHOV/LzBYplWDQxjGN2fNijAVuU/0LnIddfKGKVExxXaurBUm+bJDkfPR7NgbzH8IYxCalHJvo9zyfjhkQpGgCE=
Message-ID: <45A65C8A.9080601@gmail.com>
Date: Thu, 11 Jan 2007 16:49:30 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: add pci_get_legacy_ide_irq() (was: [2.6 patch] let
 BLK_DEV_AMD74XX depend on X86)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adrian Bunk wrote:
> 
> It's unlikely that this driver will ever be of any use on other
> architectures.

It is already used on PPC.

[ see arch/powerpc/platforms/maple/pci.c:maple_pci_get_legacy_ide_irq() ]


> This fixes the following compile error on ia64:
> 
> <--  snip  -->
> 
> ...
>  CC      drivers/ide/pci/amd74xx.o
> /home/bunk/linux/kernel-2.6/linux-2.6.20-rc3-mm1/drivers/ide/pci/amd74xx.c:
> In function 'init_hwif_amd74xx':
> /home/bunk/linux/kernel-2.6/linux-2.6.20-rc3-mm1/drivers/ide/pci/amd74xx.c:421:
> 
> warning: implicit declaration of function 'pci_get_legacy_ide_irq'
>  CC      drivers/ide/pci/cmd64x.o
> ...
>  LD      .tmp_vmlinux1
> drivers/built-in.o: In function `init_hwif_amd74xx':
> /home/bunk/linux/kernel-2.6/linux-2.6.20-rc3-mm1/drivers/ide/pci/amd74xx.c:421:
> 
> undefined reference to `pci_get_legacy_ide_irq'
> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->
> 
> 
> This fixes kernel Bugzilla #6644.

Does the following patch fix the problem?

[PATCH] ia64: add pci_get_legacy_ide_irq()

Add pci_get_legacy_ide_irq() identical to the one used by i386/x86_64.
Fixes amd74xx driver build on ia64 (bugzilla bug #6644).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 include/asm-ia64/pci.h |    6 ++++++
 1 file changed, 6 insertions(+)

Index: a/include/asm-ia64/pci.h
===================================================================
--- a.orig/include/asm-ia64/pci.h
+++ a/include/asm-ia64/pci.h
@@ -167,4 +167,10 @@ pcibios_select_root(struct pci_dev *pdev
 
 #define pcibios_scan_all_fns(a, b)	0
 
+#define HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	return channel ? 15 : 14;
+}
+
 #endif /* _ASM_IA64_PCI_H */



