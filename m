Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVBXB7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVBXB7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 20:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVBXB7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 20:59:12 -0500
Received: from web40910.mail.yahoo.com ([66.218.78.207]:64368 "HELO
	web40910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261738AbVBXB7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 20:59:00 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=ylTBdvG/hgs6rn5DW0HV94KActtw3jWvLR1mBNEic2d3jvaSQs5VIU6cPAIUi6rwLZStj8uNLiAKpCTEQVV3/y/wy2QTopnO/xZz5MXdB1jUxGF+FYVF1zR5q1nA1aehxpcHMxtt0GfAXqCL4PjteaSgBEb0rcNBqj6HfbLJHtw=  ;
Message-ID: <20050224015859.55191.qmail@web40910.mail.yahoo.com>
Date: Wed, 23 Feb 2005 17:58:59 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: 2.6.11-rc4 libata-core (irq 30: nobody cared!)
To: linux-kernel@vger.kernel.org
Cc: =?ISO-8859-1?Q?=20=22Rog=E9rio=22?= Brito <rbrito@ime.usp.br>,
       jgarzik@pobox.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see this problem with the sata_sil.c driver and
SII3112 card.  Others have reported seeing a similar
problem:  http://lkml.org/lkml/2005/2/6/41

There seems to be a pending interrupt from the drive,
but the code has already set the NIEN bit, so the
ATA_IRQ_TRAP macro doesn't help (the ata_interrupt
handler never calls ata_host_intr in this case).

I've implemented a quick workaround hack, but others
should investigate a better fix (maybe acking pending
interrupts before setting NIEN bit in ata_tf_load??)

Regards,
Brian

--- libata-core.c.orig  2005-02-23 17:41:03.831836464
-0800
+++ libata-core.c       2005-02-23 17:31:07.930427248
-0800
@@ -3158,6 +3158,11 @@
                        if (qc && (!(qc->tf.ctl &
ATA_NIEN))) {
                                handled |=
ata_host_intr(ap, qc);
                        }
+                       else {
+                               /* bk - just ack
spurious interrupt here - temp workaround */
+                               ata_irq_ack(ap, 0);
+                               printk(KERN_WARNING
"ata%d: irq trap\n", ap->id);
+                       }
                }
        }


Linux version 2.6.11-rc4 (root@localhost.localdomain)
(gcc version 3.3.2) #27 Wed Feb 23 17:49:05 PST 2005
Built 1 zonelists
Kernel command line: root=/dev/ram rw ramdisk=36000
console=ttyS0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5,
131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
Memory: 120832k available (2136k kernel code, 916k
data, 108k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
checking if image is initramfs...it isn't (no cpio
magic); looks like an initrd
Freeing initrd memory: 5709k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Initializing Cryptographic API
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports,
IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 36000K
size 1024 blocksize
loop: loaded (max 8 devices)
mal0: Initialized, 1 tx channels, 1 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt
<benh@kernel.crashing.org>
eth0: IBM emac, MAC 08:00:3e:26:15:59
eth0: Found Generic MII PHY (0x06)
Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
ata1: SATA max UDMA/100 cmd 0xC9002E80 ctl 0xC9002E8A
bmdma 0xC9002E00 irq 30
ata2: SATA max UDMA/100 cmd 0xC9002EC0 ctl 0xC9002ECA
bmdma 0xC9002E08 irq 30
irq 30: nobody cared!
Call trace:
 [c0005630] dump_stack+0x18/0x28
 [c003ae0c] __report_bad_irq+0x34/0xac
 [c003af38] note_interrupt+0x98/0xd4
 [c003a92c] __do_IRQ+0x15c/0x160
 [c0003e54] do_IRQ+0x50/0x98
 [c0002f64] ret_from_except+0x0/0x18
 [c0003ed4] default_idle+0x38/0x5c
 [c0003f20] cpu_idle+0x28/0x38
 [c00023a4] rest_init+0x24/0x34
 [c02dc614] start_kernel+0x170/0x1a8
 [c00022a4] start_here+0x44/0xb0
handlers:
[<c015fc28>] (ata_interrupt+0x0/0x27c)
Disabling IRQ #30
ata1: dev 0 ATA, max UDMA7, 234493056 sectors: lba48
eth0: Link is Up
eth0: Speed: 100, Full duplex.





		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
