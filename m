Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbRGLKnB>; Thu, 12 Jul 2001 06:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267470AbRGLKmv>; Thu, 12 Jul 2001 06:42:51 -0400
Received: from [193.81.166.111] ([193.81.166.111]:4091 "EHLO
	tcint1ntsrv.topcall.co.at") by vger.kernel.org with ESMTP
	id <S267468AbRGLKmd>; Thu, 12 Jul 2001 06:42:33 -0400
Message-ID: <41EA756DBC9FD0118CFC0020AFDB5C5A188E07@tcint1ntsrv>
From: Zehetbauer Thomas <TZ@link.topcall.co.at>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Cannot access PCI device
Date: Thu, 12 Jul 2001 12:42:32 +0200
X-Priority: 3
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1458.49)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I am trying to access a custom PCI device on a Walnut Rev. D system
running Hard Hat Linux Rev. 1.2 with Montavista kernel snapshot
01.04.12. The following code is beeing executed in the probe function of
a kernel module and works well on Linux 2.4.2/Intel but returns useless
values on PowerPC.

### begin code ###
        unsigned long linux_addr_start, linux_addr_end, val;
        u32 config_addr;

        pdev = pci_find_device(0x10ee, 0x4030, pdev);
        if (NULL == pdev)
                return(-1);
        if (pci_enable_device(pdev))
                return(-1);
        linux_addr_start = pci_resource_start(pdev, 0);
        linux_addr_end = pci_resource_end(pdev, 0);
        pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &config_addr);
        printk("Found %s\n", pdev->name);
        printk("pci_resource_start=%lx\n", linux_addr_start);
        printk("pci_resource_end=%lx\n", linux_addr_end);
        printk("PCI_BASE_ADDRESS_0=%lx\n", config_addr);
        IOAddress = ioremap(config_addr, 0xffff);
        if (IOAddress) {
                val = readl(IOAddress + 0xb000);
                printk("read %lx at remapped PCI_BASE_ADDRESS_0\n",
val);
                iounmap(IOAddress);
        }
        IOAddress = ioremap(linux_addr_start, 0xffff);
        if (IOAddress) {
                val = readl(IOAddress + 0xb000);
                printk("read %lx at remapped pci_resource_start\n",
val);
                iounmap(IOAddress);
        }
### end code ###

### begin i686 result ###
Found PCI device 10ee:4030 (Xilinx, Inc.)
pci_resource_start=e2000000
pci_resource_end=e200ffff
PCI_BASE_ADDRESS_0=e2000000
read fffffff0 at remapped PCI_BASE_ADDRESS_0
read fffffff0 at remapped pci_resource_start
### end i686 result ###

### begin ppc result ###
Found PCI device 10ee:4030 (Xilinx, Inc.)
pci_resource_start=10000000
pci_resource_end=0
PCI_BASE_ADDRESS_0=ffff0000
read 0 at remapped PCI_BASE_ADDRESS_0
Machine Check: PLB0        bear= 0x1000b000 acr=   0x00000000 besr=
0x0c000000
Machine Check: PLB0 to OPB bear= 0x80401000 besr0= 0x00000000 besr1=
0x00000000
Data Machine Check in kernel mode.
Oops: machine check, sig: 7
NIP: C3004160 XER: 20000000 LR: C3004148 SP: C1E69DA0 REGS: c1e69cf0
TRAP: 0200
MSR: 00009230 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1e68000[30] 'insmod' Last syscall: 128 
last math 00000000 last altivec 00000000
GPR00: C3011000 C1E69DA0 C1E68000 C3006000 00000000 00000F45 00000015
C013E000 
GPR08: 00000C30 C3016000 C3006000 C02F3000 C013EC30 1001F130 100ABCB0
00000000 
GPR16: 100A4C50 10010000 7FFFDF98 00000000 00009230 01E69E80 C1E69DE8
C1ECB2E0 
GPR24: 00000008 C1E69E4C 10022B38 0000004C FFFFFFEA 00000000 10000000
C3000000 
Call backtrace: 
C3004148 C30044E8 C0013B98 C00026B4 10010000 10003360 100039F4 
0FF055B8 00000000 
Bus error
### end ppc result ###

Any hints/suggestions?

Regards
Tom
