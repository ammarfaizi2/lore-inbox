Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273034AbTGaNQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273038AbTGaNQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:16:35 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:13917 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S273034AbTGaNQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:16:29 -0400
Date: Thu, 31 Jul 2003 15:16:08 +0200
From: christophe varoqui <christophe.varoqui@free.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test* report on shuttle SS40 w/ scsi
Message-Id: <20030731151608.11eaf43c.christophe.varoqui@free.fr>
Reply-To: christophe.varoqui@free.fr
Organization: devoteam
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some problems I ran into with 2.6.0-test1-ac2 on a SS40 shuttle :

Context :
root@zezette../root$ cat /proc/ikconfig/built_with
Kernel:    Linux 2.4.21-pre2 #4 sam jan 4 11:41:25 CET 2003 i686
Compiler:  gcc version 2.96 20000731 (Mandrake Linux 9.1 2.96-0.82mdk)
Version_in_Makefile: 2.6.0-test1-ac1 /* Alan forgot incrementing to ac2 */

... on a shuttle SS40,
all with or without "acpi=no" bootparm
fully reproduced with 2.6.0-test1-ac1 and 2.6.0-test2

* when compiled with gcc-3.3.1, boot stops with a message "can't exec rc.sysinit", so the rest of the bug report concerns a kernell compiled with gcc-2.96

* No radeon 8500LE DRI, but I guess it is already known :

root@zezette../root$ glxinfo 
name of display: :0.0
Loading required GL library /usr/X11R6/lib/libGL.so.1.2
display: :0  screen: 0
direct rendering: No                                                               ... 

via-agp.ko _is_ loaded
<from dmesg>
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Detected VIA KM266/PM266 chipset
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xe8000000
<and when starting X>
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 2003 using kernel context 0                    

* 8139too.ko doesn't like the Shuttle SS40 onboard Realtek chip :
<from dmesg, when loading the driver>
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 Fast Ethernet at 0xd0936000, 00:30:1b:ab:ed:12, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.           
ifconfig works as expected,
I can ping locally ... but,

<then, from dmesg, when pinging another host>
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000. 
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 00002000. (queue head)
eth0:  Tx descriptor 1 is 00002000.
eth0:  Tx descriptor 2 is 00002000.
eth0:  Tx descriptor 3 is 00002000.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.

I tried compiling the driver with and without 8129 support,
and with and without bad media correction.
I didn't try PIO mode, nor old Rx reset ... but this same config works in 2.4 and worked with 2.5.7[23]

I also noted that mii-tool doesn't work :
root@zezette../root$ mii-tool
SIOCGMIIPHY on 'eth0' failed: Operation not supported
no MII interfaces found
I don't have ethtool on this system.

* sym53c8xx.ko doesn't like my symbios 53c875 :

** the "_2" driver lunch a bunch of different resets then dies (no log taken, but I can on demand)

** the older driver oops gently with :
Jul 23 23:15:42 zezette kernel: sym53c8xx: at PCI bus 0, device 10, function 0
Jul 23 23:15:42 zezette kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Jul 23 23:15:42 zezette kernel: sym53c8xx: 53c875 detected with Symbios NVRAM
Jul 23 23:15:42 zezette kernel: sym53c875-0: rev 0x4 on pci bus 0 device 10 function 0 irq 15
Jul 23 23:15:42 zezette kernel: ERROR: SCSI host `sym53c8xx' has no error handling
Jul 23 23:15:42 zezette kernel: ERROR: This is not a safe way to run your SCSI host
Jul 23 23:15:42 zezette kernel: ERROR: The error handling must be added to this driver
Jul 23 23:15:42 zezette kernel: Call Trace:
Jul 23 23:15:42 zezette kernel:  [__crc_xfrm_policy_list+2614174/3637581] scsi_host_alloc+0x87/0x230 [scsi_mod]
Jul 23 23:15:42 zezette kernel:  [<d0838ec7>] scsi_host_alloc+0x87/0x230 [scsi_mod]
Jul 23 23:15:42 zezette kernel:  [printk+73/272] call_console_drivers+0xe9/0xf0
Jul 23 23:15:42 zezette kernel:  [<c011afc9>] call_console_drivers+0xe9/0xf0
Jul 23 23:15:42 zezette kernel:  [__crc_xfrm_policy_list+2614615/3637581] scsi_register+0x10/0x60 [scsi_mod]
Jul 23 23:15:42 zezette kernel:  [<d0839080>] scsi_register+0x10/0x60 [scsi_mod]
Jul 23 23:15:42 zezette kernel:  [__crc_xfrm_policy_list+2732590/3637581] ncr_attach+0x57/0x8e0 [sym53c8xx]
Jul 23 23:15:42 zezette kernel:  [<d0855d57>] ncr_attach+0x57/0x8e0 [sym53c8xx]
Jul 23 23:15:42 zezette kernel:  [__delete_from_swap_cache+40/80] remove_vm_area+0x38/0x50
Jul 23 23:15:42 zezette kernel:  [<c0145b18>] remove_vm_area+0x38/0x50
Jul 23 23:15:42 zezette kernel:  [__crc_xfrm_policy_list+2737721/3637581] sym53c8xx_detect+0x292/0x350 [sym53c8xx]
Jul 23 23:15:42 zezette kernel:  [<d0857162>] sym53c8xx_detect+0x292/0x350 [sym53c8xx]
Jul 23 23:15:42 zezette kernel:  [rcu_check_callbacks+32/96] rcu_check_quiescent_state+0x60/0x70
Jul 23 23:15:42 zezette kernel:  [<c0127f00>] rcu_check_quiescent_state+0x60/0x70
Jul 23 23:15:42 zezette kernel:  [__crc_xfrm_policy_list+2741689/3637581] init_this_scsi_driver+0x52/0xdd [sym53c8xx
]
Jul 23 23:15:42 zezette kernel:  [<d08580e2>] init_this_scsi_driver+0x52/0xdd [sym53c8xx]
Jul 23 23:15:42 zezette kernel:  [.text.lock.module+163/191] sys_init_module+0xf4/0x1d0
Jul 23 23:15:42 zezette kernel:  [<c012d824>] sys_init_module+0xf4/0x1d0
Jul 23 23:15:42 zezette kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jul 23 23:15:42 zezette kernel: c010a61b>] syscall_call+0x7/0xb
Jul 23 23:15:42 zezette kernel:
Jul 23 23:15:42 zezette kernel: sym53c875-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
Jul 23 23:15:42 zezette kernel: sym53c875-0: on-chip RAM at 0xec110000
Jul 23 23:15:42 zezette kernel: sym53c875-0: restart (scsi reset).
Jul 23 23:15:42 zezette kernel: sym53c875-0: Downloading SCSI SCRIPTS.
Jul 23 23:15:42 zezette kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Jul 23 23:15:42 zezette kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
Jul 23 23:15:42 zezette kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 1 lun 0
Jul 23 23:15:42 zezette kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 2 lun 0
Jul 23 23:15:42 zezette kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 3 lun 0
Jul 23 23:15:42 zezette kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 4 lun 0
Jul 23 23:15:42 zezette kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 5 lun 0
Jul 23 23:15:42 zezette kernel: scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 6 lun 0

the associated modprobe stays stuck in D-state.


* the ps2 keyboard works normally at the console, but needs a cable deplug-replug to unfreeze after starting X.
For information, the mouse is usb, so the other serio port should be empty, but kmesg log shows :
Jul 23 23:15:42 zezette kernel: mice: PS/2 mouse device common for all mice
Jul 23 23:15:42 zezette kernel: input: PS/2 Generic Mouse on isa0060/serio1
Jul 23 23:15:42 zezette kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Jul 23 23:15:42 zezette kernel: input: AT Set 2 keyboard on isa0060/serio0
Jul 23 23:15:42 zezette kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
... confusing.


Otherwise, everything feels smooth and rock-solid, even under heavy IO and CPU load.

Hope, this report is useful,
regards,
cvaroqui


