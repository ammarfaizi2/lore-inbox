Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271618AbRHZXBG>; Sun, 26 Aug 2001 19:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271609AbRHZXAr>; Sun, 26 Aug 2001 19:00:47 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:27145 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S271573AbRHZXAn>; Sun, 26 Aug 2001 19:00:43 -0400
Date: Mon, 27 Aug 2001 01:00:53 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: VCool - cool your Athlon/Duron during idle
Message-ID: <20010827010053.A9149@gondor.com>
In-Reply-To: <20010826181315Z271401-760+6195@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010826181315Z271401-760+6195@vger.kernel.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2001 at 08:09:34PM +0200, Dieter Nützel wrote:
> Have you read something about this Athlon/Duron cooling problem?
> Can this code included into your (and/or the official) tree?

I haven't yet measured if this really saves a significant amount of
power, but I made a kernel patch closely based on the vcool patch
from http://www.naggelgames.de/vcool/

This patch is extremely experimental, but it didn't crash my 
machine, yet ;-) Some things could probably be more elegant.

Feel free to comment or use this patch as you like.
It does only use stpclk if you boot with idle=stpclk

Jan


diff -ur linux-2.4.8-ac7-orig/arch/i386/kernel/pci-i386.h linux-2.4.8-ac7/arch/i386/kernel/pci-i386.h
--- linux-2.4.8-ac7-orig/arch/i386/kernel/pci-i386.h	Fri Jul 13 19:26:14 2001
+++ linux-2.4.8-ac7/arch/i386/kernel/pci-i386.h	Sun Aug 26 21:05:37 2001
@@ -70,3 +70,6 @@
 void pcibios_irq_init(void);
 void pcibios_fixup_irqs(void);
 void pcibios_enable_irq(struct pci_dev *dev);
+
+extern int use_stpclk;
+void idle_setup_stpclk(void);
diff -ur linux-2.4.8-ac7-orig/arch/i386/kernel/pci-pc.c linux-2.4.8-ac7/arch/i386/kernel/pci-pc.c
--- linux-2.4.8-ac7-orig/arch/i386/kernel/pci-pc.c	Sun Aug 19 20:19:49 2001
+++ linux-2.4.8-ac7/arch/i386/kernel/pci-pc.c	Sun Aug 26 21:03:57 2001
@@ -1053,6 +1053,8 @@
 	if ((pci_probe & PCI_BIOS_SORT) && !(pci_probe & PCI_NO_SORT))
 		pcibios_sort();
 #endif
+	if(use_stpclk)
+		idle_setup_stpclk();
 }
 
 char * __init pcibios_setup(char *str)
diff -ur linux-2.4.8-ac7-orig/arch/i386/kernel/process.c linux-2.4.8-ac7/arch/i386/kernel/process.c
--- linux-2.4.8-ac7-orig/arch/i386/kernel/process.c	Sun Aug 19 20:19:49 2001
+++ linux-2.4.8-ac7/arch/i386/kernel/process.c	Sun Aug 26 21:56:32 2001
@@ -33,6 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
+#include <linux/pci.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -48,10 +49,13 @@
 #endif
 
 #include <linux/irq.h>
+#include "pci-i386.h"
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 int hlt_counter;
+int use_stpclk;
+u16 Reg_PL2;
 
 /*
  * Powermanagement idle function, if any..
@@ -88,6 +92,17 @@
 	}
 }
 
+static void stpclk_idle(void)
+{
+	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
+		__cli();
+		if (!current->need_resched) 
+			inb(Reg_PL2);
+		else
+			__sti();
+	}
+}
+
 /*
  * On SMP it's slightly faster (but much more power-consuming!)
  * to poll the ->need_resched flag instead of waiting for the
@@ -138,11 +153,56 @@
 	}
 }
 
+void __init idle_setup_stpclk (void) {
+	struct pci_dev *nb, *sb;
+	u8 res;
+	u16 io_base;
+	u32 res32;
+	printk("using stpclk# instead of hlt\n");
+	nb=pci_find_subsys(PCI_VENDOR_ID_VIA,PCI_DEVICE_ID_VIA_8363_0,PCI_ANY_ID,PCI_ANY_ID,NULL);
+	if(!nb) 
+		nb=pci_find_subsys(PCI_VENDOR_ID_VIA,PCI_DEVICE_ID_VIA_8371_0,PCI_ANY_ID,PCI_ANY_ID,NULL);
+	if(!nb) {
+		printk("via northbridge not found - falling back to default idle task\n");
+		return;
+	}
+	sb=pci_find_subsys(PCI_VENDOR_ID_VIA,PCI_DEVICE_ID_VIA_82C686_4,PCI_ANY_ID,PCI_ANY_ID,NULL);
+	if(!sb) {
+		printk("via southbridge not found - falling back to default idle task\n");
+		return;
+	}
+	pci_read_config_byte(sb,0x41,&res);
+	if ((res &0x8000)==0)
+	{
+		printk("ACPI I/O space disabled - enabling\n");
+		res|=0x8000;
+		pci_write_config_byte(sb,0x41,res);
+	}
+	pci_read_config_word(sb,0x48,&io_base);
+	Reg_PL2=(io_base&0xff80)+0x14;
+	
+
+	pci_read_config_dword(nb,0x90,&res32);
+	if ((res32&0x00800000)==0) {
+		printk("bus disconnect disabled - enabling\n");
+		res32|=0x00800000;
+		pci_write_config_dword(nb,0x90,res32);
+		return;
+	}
+
+	
+	pm_idle = stpclk_idle;
+	return;
+}
+
 static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
 		pm_idle = poll_idle;
+	}
+	if (!strncmp(str, "stpclk",6)) {
+		use_stpclk=1;
 	}
 
 	return 1;

