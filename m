Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVDANEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVDANEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVDANEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:04:36 -0500
Received: from indonesia.procaptura.com ([193.214.130.21]:10393 "EHLO
	indonesia.procaptura.com") by vger.kernel.org with ESMTP
	id S262738AbVDANDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 08:03:01 -0500
Message-ID: <424D467F.3090700@procaptura.com>
Date: Fri, 01 Apr 2005 15:02:55 +0200
From: Toralf Lund <toralf@procaptura.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel load issues (insmod segfault)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I thought I might try this one again (with updated code and more compete 
info):

I have a special hardware driver module that leads to unexpected trouble 
at load-time; insmod simply segfaults. That's unexpected not because I 
can guarantee that the module is good, but because the problem still 
occurs if I reduce the code to the point were virtually all the actual 
driver code is gone. The below commands & output should fully illustrate 
the problem (/var/log/debug is set up via /etc/syslog.conf to receive 
KERN_DEBUG.)

Any help would be appreciated.


# make itifg8tst.o
gcc -pipe -Wall -O2  -DLinux -mcpu=i686 -I../../include -fno-common 
-fno-strict-aliasing -fomit-frame-pointer -nostdinc -I. 
-I/lib/modules/2.6.11.4-0.EL.toralf/build/include 
-I/usr/lib/gcc/i386-redhat-linux/3.4.3/include -D__KERNEL__ -DMODULE 
-I/lib/modules/2.6.11.4-0.EL.toralf/build/include/asm-i386/mach-default 
-o itifg8tst.o -c itifg8tst.c

# /lib/modules/2.6.11.4-0.EL.toralf/build/scripts/mod/modpost -i 
/lib/modules/2.6.11.4-0.EL.toralf/build/Module.symvers -m itifg8tst.o

# sed -e /KBUILD_MODNAME/s//itifg8tst/ itifg8tst.mod.c > sabel

# mv sabel itifg8tst.mod.c

# make itifg8tst.mod.o
gcc -pipe -Wall -O2  -DLinux -mcpu=i686 -I../../include -fno-common 
-fno-strict-aliasing -fomit-frame-pointer -nostdinc -I. 
-I/lib/modules/2.6.11.4-0.EL.toralf/build/include 
-I/usr/lib/gcc/i386-redhat-linux/3.4.3/include -D__KERNEL__ -DMODULE 
-I/lib/modules/2.6.11.4-0.EL.toralf/build/include/asm-i386/mach-default 
-o itifg8tst.mod.o -c itifg8tst.mod.c

# ld -r -o itifg8tst.ko itifg8tst.o itifg8tst.mod.o

# insmod itifg8tst.ko
Segmentation fault

# tail -25 /var/log/messages
Apr  1 14:27:18 hai ntpd[2668]: kernel time sync disabled 0041
Apr  1 14:31:30 hai ntpd[2668]: kernel time sync enabled 0001
Apr  1 14:39:56 hai kernel: Unable to handle kernel paging request at 
virtual address 533e3762
Apr  1 14:39:56 hai kernel:  printing eip:
Apr  1 14:39:56 hai kernel: c01d9302
Apr  1 14:39:56 hai kernel: *pde = 00000000
Apr  1 14:39:56 hai kernel: Oops: 0000 [#1]
Apr  1 14:39:56 hai kernel: Modules linked in: itifg8tst nfsd exportfs 
lp nfs lockd sunrpc video button battery ac md5 ipv6 uhci_hcd parport_pc 
parport via686a
i2c_sensor i2c_core 3c59x mii floppy dm_snapshot dm_zero dm_mirror ext3 
jbd dm_mod aic7xxx sd_mod scsi_mod
Apr  1 14:39:56 hai kernel: CPU:    0
Apr  1 14:39:56 hai kernel: EIP:    0060:[<c01d9302>]    Not tainted VLI
Apr  1 14:39:56 hai kernel: EFLAGS: 00010293   (2.6.11.4-0.EL.toralf)
Apr  1 14:39:56 hai kernel: EIP is at pci_get_subsys+0x100/0x1b7
Apr  1 14:39:56 hai kernel: eax: 00000000   ebx: 533e373c   ecx: 
ffffffff   edx: 533e373c
Apr  1 14:39:56 hai kernel: esi: e0912001   edi: ffffffff   ebp: 
d21ddf9c   esp: d21ddf74
Apr  1 14:39:56 hai kernel: ds: 007b   es: 007b   ss: 0068
Apr  1 14:39:56 hai kernel: Process insmod (pid: 4835, 
threadinfo=d21dc000 task=df74adf0)
Apr  1 14:39:56 hai kernel: Stack: ffffffff 00000000 00000000 0045f378 
d21dc000
c01d93c4 ffffffff e0912001
Apr  1 14:39:56 hai kernel:        e095c049 ffffffff ffffffff 00000000 
00000000
e0912400 00000000 e0912400
Apr  1 14:39:56 hai kernel:        c013687d 0804a018 00000000 c0103281 
0804a018
00000ae7 0804a008 00000000
Apr  1 14:39:57 hai kernel: Call Trace:
Apr  1 14:39:57 hai kernel:  [<c01d93c4>] pci_get_device+0xb/0xe
Apr  1 14:39:57 hai kernel:  [<e095c049>] mod_init+0x49/0x56 [itifg8tst]
Apr  1 14:39:57 hai kernel:  [<c013687d>] sys_init_module+0x1dd/0x2b6
Apr  1 14:39:57 hai kernel:  [<c0103281>] sysenter_past_esp+0x52/0x75
Apr  1 14:39:57 hai kernel: Code: 04 8b 16 eb 4e 8b 15 e8 f2 35 c0 eb 46 
81 fa e8 f2 35 c0 74 42 83 3c 24 ff 89 d3 74 09 0f b7 42 24 3b 04 24 75 
2b 83 fd ff 74
08 <0f> b7 43 26 39 e8 75 1e 83 ff ff 74 08 0f b7 43 28 39 f8 75 11

# tail /var/log/debug
Apr  1 14:22:59 hai xinetd[2652]: removing telnet
Apr  1 14:22:59 hai xinetd[2652]: removing kshell
Apr  1 14:22:59 hai xinetd[2652]: removing rsync
Apr  1 14:22:59 hai xinetd[2652]: removing time
Apr  1 14:22:59 hai xinetd[2652]: removing time
Apr  1 14:23:00 hai kernel: parport_pc: VIA 686A/8231 detected
Apr  1 14:23:00 hai kernel: parport_pc: probing current configuration
Apr  1 14:23:00 hai kernel: parport_pc: Current parallel port base: 0x378
Apr  1 14:23:09 hai kernel: eth0: no IPv6 routers present
Apr  1 14:39:56 hai kernel: Scanning all devices...

# cat itifg8tst.c
#include <linux/pci.h>
#include <linux/module.h>
 
MODULE_LICENSE("GPL");
 
 
static void __exit mod_exit(void)
{
}
 
static __init int mod_init(void)
{
        struct pci_dev *dev;
 
        printk(KERN_DEBUG "Scanning all devices...\n");
 
        dev = NULL;
        while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev))) {
                printk(KERN_DEBUG "Device %04hx:%04hx\n",
                        dev->vendor, dev->device);
        }
        return 0;
}
 
module_init(mod_init);
module_exit(mod_exit);

