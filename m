Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTJSMF1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 08:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJSMF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 08:05:27 -0400
Received: from yj160.neoplus.adsl.tpnet.pl ([80.54.129.160]:1796 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S262116AbTJSMFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 08:05:16 -0400
Date: Sun, 19 Oct 2003 14:08:52 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: [BUG] 2.6.0-test8: Oops on "rmmod es1371"
Message-ID: <20031019120851.GA3902@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: PLD Linux Distribution
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got an Oops on just "rmmod es1371".

kernel: es1371: unloading
kernel: Unable to handle kernel paging request at virtual address d88a3920
kernel: printing eip:
kernel: d88a3920
kernel: *pde = 17dca067
kernel: *pte = 00000000
kernel: Oops: 0000 [#1]
kernel: CPU:    0
kernel: EIP:    0060:[<d88a3920>]    Not tainted
kernel: EFLAGS: 00010282
kernel: EIP is at 0xd88a3920
kernel: eax: e891d840   ebx: d7f2b800   ecx: d7f2b854   edx: d88a3920
kernel: esi: e891d864   edi: 00000000   ebp: 00000880   esp: ce89ff00
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process rmmod (pid: 32505, threadinfo=ce89e000 task=d64a0cc0)
kernel: Stack: c01b884b d7f2b800 d7f2b854 c01d1d14 d7f2b854 d7f2b880 e891d8b0 e891d8b0
kernel: c01d1d40 d7f2b854 e891d864 c0288238 c01d1f6d e891d864 e891d864 c0288238
kernel: c01d2383 e891d864 e891d900 c01b89e2 e891d864 e891be8b e891d840 c012f709
kernel: Call Trace:
kernel: [<c01b884b>] pci_device_remove+0x3b/0x40
kernel: [<c01d1d14>] device_release_driver+0x64/0x70
kernel: [<c01d1d40>] driver_detach+0x20/0x30
kernel: [<c01d1f6d>] bus_remove_driver+0x3d/0x80
kernel: [<c01d2383>] driver_unregister+0x13/0x28
kernel: [<c01b89e2>] pci_unregister_driver+0x12/0x20
kernel: [<e891be8b>] cleanup_es1371+0x1b/0x1f [es1371]
kernel: [<c012f709>] sys_delete_module+0x119/0x190
kernel: [<c0143597>] do_munmap+0x147/0x190
kernel: [<c01091db>] syscall_call+0x7/0xb
kernel:
kernel: Code:  Bad EIP value.

Some investigation:

pci_device_remove():
     1c5:   89 1c 24                mov    %ebx,(%esp,1)
==>  1c8:   ff 50 14                call   *0x14(%eax)
     1cb:   eb df                   jmp    1ac <pci_device_remove+0x1c>

linux/drivers/pci/pci-driver.c:289-293
        if (drv) {
                if (drv->remove)
==>                     drv->remove(pci_dev);
                pci_dev->driver = NULL;
        }

It tries to call es1371_remove() (linux/sound/oss/es1371.c:3004), which is
marked as __devinit, thus (I think) inaccessible on rmmod.

Is just removing the "__devinit" word the proper way to fix this problem?
(it works for me)

BTW, I found the same (*_remove() functions marked as __devinit) in other
drivers in linux/sound/oss beside es1371.c (but I didn't have how to test
if they cause Oops on rmmod too - but I suppose that they do):
au1000.c
cs46xx.c
es1370.c
essolo1.c
ite8172.c
rme96xx.c
nec_vcr5477.c
nm256_audio.c
sonicvibes.c
cs4281/cs4281m.c


PS. please Cc replies to me

-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/
