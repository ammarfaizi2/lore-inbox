Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUAGRe6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUAGRe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:34:57 -0500
Received: from fmr01.intel.com ([192.55.52.18]:53390 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266243AbUAGReh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:34:37 -0500
Message-ID: <3FFC4324.8050201@intel.com>
Date: Wed, 07 Jan 2004 19:34:28 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
CC: linux-kernel@vger.kernel.org, Grege@kroah.com,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
References: <6B09584CC3D2124DB45C3B592414FA8308C8B6@bgsmsx402.gar.corp.intel.com>
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA8308C8B6@bgsmsx402.gar.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Durairaj, Sundarapandian wrote:

>Hi All,
>
>Thanks for your review comments. I am reposting the updated patch after
>incorporating the review comments.
>Please review this and send your comments.
>
>Thanks,
>Sundar
>
>------------------------------------------------
>
>  
>
<skip>

>diff -Naur linux-2.6.0/arch/i386/pci/direct.c
>linux_pciexpress/arch/i386/pci/direct.c
>--- linux-2.6.0/arch/i386/pci/direct.c	2003-12-18 08:28:28.000000000
>+0530
>+++ linux_pciexpress/arch/i386/pci/direct.c	2004-01-07
>18:16:57.000000000 +0530
>@@ -168,6 +168,124 @@
> 
> 
> /*
>+ *We map full Page size on each request. Incidently that's the size we
>+ *have for config space too.
>+ */
>+#ifdef CONFIG_PCI_EXP_ENHANCED
>+/* 
>+ *On PCI Express capable platform, at the time of kernel initialization
>+ *the os would have scanned for mcfg table and set this variable to 
>+ *appropriate value.
>+ *If PCI Express not supported the variable will have 0 value
>+ */
>+u64 mmcfg_base_address;
>  
>
I'd made this variable 'unsigned long'. Later, you compare/assign to and 
from u32 value.
Actually, it is bus address, which is unsigned long.

>+
>+/*
>+ *Variable used to store the base address of the last pciexpress device
>
>+ *accessed.
>+ */
>+u32 pcie_last_accessed_device;
>+
>+unsigned long pci_exp_set_dev_base (int bus, int dev, int fn)
>+{
>+	u32 dev_base = 
>+		mmcfg_base_address | (bus << 20) | ((PCI_DEVFN (dev,fn))
><<12);
>+	if (dev_base != pcie_last_accessed_device){
>+		pcie_last_accessed_device = dev_base;
>+		set_fixmap (FIX_PCIE_MCFG, dev_base);
>+	}
>+	return 0;
>+}
>  
>
I suggest to use single 'devfn' argument instead of separate 'dev' and 
'fn', like this:
unsigned long pci_exp_set_dev_base (int bus, int devfn)
and, correspondingly,

u32 dev_base = mmcfg_base_address | (bus << 20) | (devfn <<12);

>+
>+static int pci_express_conf_read(int seg, int bus, 
>+		int devfn, int reg, int len, u32 *value)
>+{
>+	unsigned long flags;
>+	char * virt_addr;
>  
>
Taking into account change above, you save some computation here:
... delete 'dev' and 'fn' calculations

>+	int dev = PCI_SLOT (devfn);
>+	int fn  = PCI_FUNC (devfn);
>+ 
>  
>
in this if() change

((u32)dev > 31) || ((u32)fn > 7)
to
((u32)devfn > 255)

>+	if (!value || ((u32)bus > 255) || ((u32)dev > 31) 
>+			|| ((u32)fn > 7) || ((u32)reg > 4095)){
>+		printk(KERN_ERR "pci_express_conf_read: Invalid
>Parameter\n");
>+  		return -EINVAL;
>+	}
>+
>+	/* Shoot misalligned transaction now */
>+	if (reg & (len-1)){
>+		printk(KERN_ERR "pci_express_conf_read: \
>+					misalligned transaction\n");
>+  		return -EINVAL;
>+	}
>+
>+	spin_lock_irqsave(&pci_config_lock, flags);
>  
>
and call

pci_exp_set_dev_base(bus, devfn);

>+	pci_exp_set_dev_base(bus, dev, fn);
>+	virt_addr = (char *) (fix_to_virt(FIX_PCIE_MCFG));
>  
>
virt_addr is constant, convert it to static variable and assign in 
pci_direct_init().
No need to recalculate.

>+ 	switch (len) {
>+        case 1:
>+		*value = (u8)readb((unsigned long) virt_addr+reg);
>+		break;
>+        case 2:
>+		*value = (u16)readw((unsigned long) virt_addr+reg);
>+		break;
>+        case 4:
>+		*value = (u32)readl((unsigned long) virt_addr+reg);
>+		break;
>+	}
>+	spin_unlock_irqrestore(&pci_config_lock, flags);
>+	return 0;
>+}
>+ 
>  
>
the same changes dev,fn -> devfn for _write

>+static int pci_express_conf_write(int seg, int bus, 
>+			int devfn, int reg, int len, u32 value)
>+{
>+	unsigned long flags;
>+	unsigned char * virt_addr;
>+	int dev = PCI_SLOT (devfn);
>+	int fn  = PCI_FUNC (devfn);
>+	
>+	if (!value || ((u32)bus > 255) || ((u32)dev > 31) || 
>+		((u32)fn > 7) || ((u32)reg > 4095)){
>+		printk(KERN_ERR "pci_express_conf_write: \
>+					Invalid Parameter\n");
>+		return -EINVAL;
>+	}
>+	
>+	/* Shoot misalligned transaction now */
>+	if (reg & (len-1)){
>+		printk(KERN_ERR "pci_express_conf_write: \
>+					misalligned transaction\n");
>+  		return -EINVAL;
>+	}
>+  
>+	spin_lock_irqsave(&pci_config_lock, flags);
>+	pci_exp_set_dev_base(bus, dev, fn);
>+	virt_addr = (char *) (fix_to_virt(FIX_PCIE_MCFG));
>  
>
See above - no need to recalculate virt_addr.

>+	
>+	switch (len) {
>+		case 1:
>+			writeb(value,(unsigned long)virt_addr+reg);
>+			break;
>+		case 2:
>+			writew(value,(unsigned long)virt_addr+reg);
>+			break;
>+	        case 4:
>+			writel(value,(unsigned long)virt_addr+reg);
>+	                break;
>+     	}
>+	/* Dummy read to flush PCI write */
>+	readl (virt_addr);
>+	spin_unlock_irqrestore(&pci_config_lock, flags);	 
>+	return 0;
>+}
>+
>  
>

