Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268520AbTBWR5v>; Sun, 23 Feb 2003 12:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268521AbTBWR5v>; Sun, 23 Feb 2003 12:57:51 -0500
Received: from wall.ttu.ee ([193.40.254.238]:8207 "EHLO wall.ttu.ee")
	by vger.kernel.org with ESMTP id <S268520AbTBWR5t>;
	Sun, 23 Feb 2003 12:57:49 -0500
Date: Sun, 23 Feb 2003 20:07:59 +0200 (EET)
From: Siim Vahtre <siim@pld.ttu.ee>
To: <linux-fbdev-devel@lists.sourceforge.net>
cc: <linux-kernel@vger.kernel.org>
Subject: cat /dev/fb1 produces kernel bug
Message-ID: <Pine.SOL.4.31.0302231958260.28624-100000@pitsa.pld.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.5.62 kernel that is compiled without devfs and without module support.

/proc/devices shows: Character devices: 29 fb

ls -l /dev |grep fb shows:
crw-rw----    1 root     video     29,   0 Mar 14  2002 fb0
crw--w----    1 root     video     29,   1 Mar 14  2002 fb0autodetect
crw--w----    1 root     video     29,   0 Mar 14  2002 fb0current
crw--w----    1 root     video     29,  32 Mar 14  2002 fb1
crw--w----    1 root     video     29,  33 Mar 14  2002 fb1autodetect
crw--w----    1 root     video     29,  32 Mar 14  2002 fb1current

Relevant pieces of kernel configuration:
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FB=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RIVA=y
# CONFIG_FB_VIRTUAL is not set

When the thing boots up it says:

rivafb: nVidia device/chipset 10DE0110
rivafb: Detected CRTC controller 0 being used
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-M, 64MB @
0xE8000000)
Badness in kobject_register at lib/kobject.c:152
Call Trace:
 [<c020e678>] kobject_register+0x58/0x70
 [<c021a58b>] bus_add_driver+0x5b/0xe0
 [<c021a9df>] driver_register+0x2f/0x40
 [<c017a8e3>] create_proc_entry+0x83/0xd0
 [<c021170b>] pci_register_driver+0x4b/0x60
 [<c010507f>] init+0x3f/0x160
 [<c0105040>] init+0x0/0x160
 [<c010726d>] kernel_thread_helper+0x5/0x18

Console: switching to colour frame buffer device 80x30

...although that little error came along, everything is working very
well in general. However, when I do "cat /dev/fb1" (which is completely
sick, I have no fb1 !?), I get following:

 <1>Unable to handle kernel NULL pointer dereference at virtual address
0000016d printing eip:
c0288e1d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0288e1d>]    Not tainted
EFLAGS: 00010202
EIP is at fb_open+0x1d/0x50
eax: ffffffed   ebx: 00000000   ecx: 00000000   edx: 00000001
esi: c50a8a40   edi: c64ad114   ebp: ffffffe9   esp: c3a63f30
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 1342, threadinfo=c3a62000 task=c1ac1860)
Stack: 00000000 ffffffed c01558b6 c64ad114 c50a8a40 c50a8a40 c64ad114
c7fba560
       c014b7ee c64ad114 c50a8a40 00008000 00000000 c3a88000 c3a62000
c014b678
       c4b81e00 c7fba560 00008000 c3a63f80 c4b81e00 c7fba560 c3a88000
c57fd29c
Call Trace:
 [<c01558b6>] chrdev_open+0x66/0x80
 [<c014b7ee>] dentry_open+0x16e/0x180
 [<c014b678>] filp_open+0x68/0x70
 [<c014ba8b>] sys_open+0x5b/0x90
 [<c01095df>] syscall_call+0x7/0xb

Code: 8b 82 6c 01 00 00 83 78 04 00 75 07 89 c8 83 c4 08 c3 90 c7
 Segmentation fault.

