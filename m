Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272212AbRISMgT>; Wed, 19 Sep 2001 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273968AbRISMgJ>; Wed, 19 Sep 2001 08:36:09 -0400
Received: from [24.254.60.15] ([24.254.60.15]:59591 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272212AbRISMgA>; Wed, 19 Sep 2001 08:36:00 -0400
Message-ID: <3BA8903D.2643D20D@didntduck.org>
Date: Wed, 19 Sep 2001 08:31:57 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Direct PCI access broken in 2.4.10-pre
In-Reply-To: <30185.1000900519@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------B8122056FB5B8AEA2B0FE8D5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B8122056FB5B8AEA2B0FE8D5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

David Woodhouse wrote:
> 
> 2.4.10-pre3 and later fail to boot on my Compaq XL box. It claims that PCI
> isn't supported. This board doesn't use the PCI BIOS because the entry
> point is in high memory.
> 
> 'cvs up -r v2_4_10-pre2 arch/i386/boot/pci-pc.c' fixes it.
> 
> A happy boot with the old pci-pc.c:
> PCI: BIOS32 entry (0xc00fa000) in high memory, cannot use.
> PCI: Using configuration type 2
> PCI: Probing PCI hardware
> 
> An unhappy boot with the new one:
> PCI: BIOS32 entry (0xc00fa000) in high memory, cannot use.
> PCI: System does not support PCI

Patch attached that fixes typecasting problems with PCI Type 2 accesses.

-- 

						Brian Gerst
--------------B8122056FB5B8AEA2B0FE8D5
Content-Type: text/plain; charset=us-ascii;
 name="diff-pcipc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-pcipc"

diff -urN linux-2.4.10-pre10/arch/i386/kernel/pci-pc.c linux/arch/i386/kernel/pci-pc.c
--- linux-2.4.10-pre10/arch/i386/kernel/pci-pc.c	Mon Sep 17 13:20:14 2001
+++ linux/arch/i386/kernel/pci-pc.c	Wed Sep 19 08:07:29 2001
@@ -261,18 +261,14 @@
 	u32 data;
 	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
 		PCI_FUNC(dev->devfn), where, 2, &data);
-	*value = (u8)data;
+	*value = (u16)data;
 	return result;
 }
 
 static int pci_conf2_read_config_dword(struct pci_dev *dev, int where, u32 *value)
 {
-	int result; 
-	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 4, &data);
-	*value = (u8)data;
-	return result;
+	return pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, 4, value);
 }
 
 static int pci_conf2_write_config_byte(struct pci_dev *dev, int where, u8 value)

--------------B8122056FB5B8AEA2B0FE8D5--

