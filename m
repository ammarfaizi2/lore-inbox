Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbUCWVdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUCWVdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:33:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:61946 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262834AbUCWVdu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:33:50 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: VMware-workstation-4.5.1 on linux-2.6.4-x86_64 host fails on virtual ethernet setup
Date: Tue, 23 Mar 2004 22:33:46 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200403232233.46879.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing LKML in order to give other people, which may suffer from this 
 in the future something to google for ;-)]

Hi Petr,

I'm suffering from a strange problem here. I tried to reach you on
vmware.for-linux.experimental without success (got a trollish answer only).

Here it is:
I'm trying to get VMware-workstation-4.5.1-7568.i386.rpm working on SuSE 
9.1b1, based on linux-2.6.4-x86_64. Thanks to some googling, I found related 
hints from you and your vmware-any-any-update54, which got me around the 
compile issues in vmmon with this patch:

--- vmmon-only/linux/hostif.c.orig	2004-03-21 20:53:35.042565778 +0100
+++ vmmon-only/linux/hostif.c	2004-03-21 20:53:40.284442570 +0100
@@ -516,13 +516,13 @@
 ClearNXBit(VA vaddr)
 {
    pgd_t *pgd = pgd_offset_k(vaddr);
-   pmd_t *pmd = pmd_offset(pgd, vaddr);
+   pmd_t *pmd = pmd_offset_map(pgd, vaddr);
    pte_t *pte;
 
    if (pmd_val(*pmd) & _PAGE_PSE) {
       pte = (pte_t*)pmd;
    } else {
-      pte = pte_offset(pmd, vaddr);
+      pte = pte_offset_map(pmd, vaddr);
    }
    if (pte_val(*pte) & _PAGE_NX) {
       pte_val(*pte) &= ~_PAGE_NX;


vmware-config.pl and /etc/init.d/vmware both fail at the same point,
setting up virtual networking [the latter with VMWARE_DEBUG=yes]:

Starting VMware services:
   Virtual machine monitor                                             done
   Virtual ethernet                                                    done
   Bridged networking on /dev/vmnet0cd /usr/bin && /usr/bin/vmnet-bridge
-d /var/run/vmnet-bridge-0.pid /dev/vmnet0 eth0
eth0: Not a valid Ethernet interface
                                                                      failed


This triggers these syslog messages:

Mar 22 21:45:57 tyrex kernel: /dev/vmmon: Module vmmon: registered with major=10 minor=165
Mar 22 21:45:57 tyrex kernel: /dev/vmmon: Module vmmon: initialized
Mar 22 21:45:57 tyrex kernel: vmnet: module license 'unspecified' taints kernel.
Mar 22 21:45:57 tyrex kernel: /dev/vmnet: open called by PID 4871 (vmnet-bridge)
Mar 22 21:45:57 tyrex kernel: /dev/vmnet: hub 0 does not exist, allocating memory.
Mar 22 21:45:57 tyrex kernel: /dev/vmnet: port on hub 0 successfully opened
Mar 22 21:45:57 tyrex kernel: ioctl32(vmnet-bridge:4871): Unknown cmd fd(5) cmd(00008941){00} 
arg(ffffd268) on /dev/vmnet0

Replacing vmnet.tar with yours suffers from the same problem.

stracing vmnet-bridge command:
execve("/usr/bin/vmnet-bridge", ["vmnet-bridge", "-d", "/var/run/vmnet-bridge-0.pid", 
"/dev/vmnet0", "eth0"], [/* 72 vars */]) = 0
[ Process PID=4910 runs in 32 bit mode. ]
eth0: Not a valid Ethernet interface

syslog:
Mar 22 21:51:40 tyrex kernel: /dev/vmnet: open called by PID 4910
(vmnet-bridge)
Mar 22 21:51:40 tyrex kernel: /dev/vmnet: port on hub 0 successfully opened
Mar 22 21:51:40 tyrex kernel: ioctl32(vmnet-bridge:4910): Unknown cmd fd(5) cmd(00008941){00}
arg(ffffd288) on /dev/vmnet0

Surely, eth0 is up and running (I highly depend on a working lan here ;-)

Obviously it's some problem with i386 <-> x86_64 interfacing.

Any ideas, what to try next?

TIA,
Pete

