Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTADLup>; Sat, 4 Jan 2003 06:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbTADLup>; Sat, 4 Jan 2003 06:50:45 -0500
Received: from f87.sea2.hotmail.com ([207.68.165.87]:8723 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266886AbTADLun>;
	Sat, 4 Jan 2003 06:50:43 -0500
X-Originating-IP: [218.75.193.47]
From: "fretre lewis" <fretre3618@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: please help me understand a line code about pci
Date: Sat, 04 Jan 2003 11:59:11 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F870TlKn4ZHkRQq5xVz0000f680@hotmail.com>
X-OriginalArrivalTime: 04 Jan 2003 11:59:11.0609 (UTC) FILETIME=[B1C57E90:01C2B3E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi,all

  I am reading code about pci, and I can't understand some lines in
pci_check_direct(), in arch/i386/kernel/pci-pc.c

the PCI spec v2.0 say: ( page32)

"Anytime a host bridge sees a full DWORD I/O write from the host to
CONFIG_ADDRESS, the bridge must latch the data into its CONFIG_ADDRESS
register. On full DWORD I/O reads to CONFIG_ADDRESS,the bridge must return 
the
data in CONFIG_ADDRESS. Any other types of accesses to this 
address(non-DWORD)
have no effect on CONFIG_ADDRESS and are excuted as normal I/O transaction 
on PCI bus......"

CONFIG_ADDRESS = 0xcf8
CONFIG_data = 0xcfc

so , I wonder why need "outb (0x01, 0xCFB);" if check configuration type 1 ? 
and why "outb (0x00, 0xCFB);" if check configuration type 2?

  please help me, thanks a lot.


406 static struct pci_ops * __devinit pci_check_direct(void)
407 {
408         unsigned int tmp;
409         unsigned long flags;
410
411         __save_flags(flags); __cli();
412
413         /*
414          * Check if configuration type 1 works.
415          */
416         if (pci_probe & PCI_PROBE_CONF1) {
417                 outb (0x01, 0xCFB);  <<<=========
418                 tmp = inl (0xCF8);
419                 outl (0x80000000, 0xCF8);
420                 if (inl (0xCF8) == 0x80000000 &&
421                     pci_sanity_check(&pci_direct_conf1)) {
422                         outl (tmp, 0xCF8);
423                         __restore_flags(flags);
424                         printk(KERN_INFO "PCI: Using configuration type 
1\n");
425                         request_region(0xCF8, 8, "PCI conf1");
426                         return &pci_direct_conf1;
427                 }
428                 outl (tmp, 0xCF8);
429         }
430
431         /*
432          * Check if configuration type 2 works.
433          */
434         if (pci_probe & PCI_PROBE_CONF2) {
435                 outb (0x00, 0xCFB);   <<<=========
436                 outb (0x00, 0xCF8);
437                 outb (0x00, 0xCFA);
438                 if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
439                     pci_sanity_check(&pci_direct_conf2)) {
440                         __restore_flags(flags);
441                         printk(KERN_INFO "PCI: Using configuration type 
2\n");
442                         request_region(0xCF8, 4, "PCI conf2");
443                         return &pci_direct_conf2;
444                 }
445         }
446
447         __restore_flags(flags);
448         return NULL;
449 }
450
451 #endif





_________________________________________________________________
Help STOP SPAM: Try the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail

