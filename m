Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTAHQE1>; Wed, 8 Jan 2003 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267606AbTAHQE1>; Wed, 8 Jan 2003 11:04:27 -0500
Received: from f95.sea2.hotmail.com ([207.68.165.95]:10245 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267083AbTAHQEZ>;
	Wed, 8 Jan 2003 11:04:25 -0500
X-Originating-IP: [218.75.193.47]
From: "fretre lewis" <fretre3618@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: tenth post about PCI code, need help
Date: Wed, 08 Jan 2003 16:13:01 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F95f1vFE2TXdf1pjgBH00022baa@hotmail.com>
X-OriginalArrivalTime: 08 Jan 2003 16:13:01.0656 (UTC) FILETIME=[D13D3D80:01C2B730]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,
  first, I have to say sorry for my 10th posting the same question , I hope 
someone can answer it indeed, it seem too difficult for me.


  I am learning code pci_check_direct(), at arch/i386/kernel/pci-pc.c

the PCI spec v2.0 say: ( page32)

"Anytime a host bridge sees a full DWORD I/O write from the host to
CONFIG_ADDRESS, the bridge must latch the data into its CONFIG_ADDRESS
register. On full DWORD I/O reads to CONFIG_ADDRESS,the bridge must return
the
data in CONFIG_ADDRESS. Any other types of accesses to this
address(non-DWORD)
have no effect on CONFIG_ADDRESS and are excuted as normal I/O transaction
on PCI bus......"

CONFIG_ADDRESS = 0xCF8
CONFIG_DATA = 0xCFC

so I think "outb (0x01, 0xCFB);" just is a normal write operation to a 
device at port address 0xCFB not a configuration type operation(maybe 
wrong,fix me), then my questions are:

1. which device is at port address 0xCFB? (please note, NOT 0xCF8)

2. what is meaning of the writing operation "outb (0x01, 0xCFB);" for THIS
device?, it'seem that PCI spec v2.0 not say anything about it?

3. why need "outb (0x01, 0xCFB);" before configuration operation "outl
(0x80000000, 0xCF8);" if check configuration type 1? and why need "outb
(0x00, 0xCFB);" before "outb (0x00, 0xCF8);" if check configuration type 2?

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
MSN 8: advanced junk mail protection and 2 months FREE*. 
http://join.msn.com/?page=features/junkmail

