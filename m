Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTEUWyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTEUWyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:54:08 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:42383 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S262336AbTEUWyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:54:06 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: kernel BUG at include/linux/dcache.h:271! 
Date: Wed, 21 May 2003 19:11:51 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305211911.51467.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Kernel is 2.5.69 bitkeeper as of May 21.
The following occurs when removing the rd module from the kernel.
I get a segmentation fault, and lsmod freezes. Kernel log says:

agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
ACPI: No IRQ known for interrupt pin C of device 00:11.5
PCI: Setting latency timer of device 00:11.5 to 64
devfs_mk_dir(rd): could not append to dir: dffcd8c0 ""
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:271!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0186dec>]    Tainted: PF 
EFLAGS: 00010246
EIP is at sysfs_remove_dir+0x1c/0x152
eax: 00000000   ebx: e09e18c4   ecx: c034eba0   edx: 00000000
esi: d5acee40   edi: d58a8980   ebp: e09e1840   esp: d5a2bed8
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1302, threadinfo=d5a2a000 task=d5e30640)
Stack: 00000000 00000000 dfdf4b40 00000000 e09e18c4 00000001 d58a8980 e09e1840 
       c01e3a03 e09e18c4 c034eba0 e09e18c4 e09e18c4 c01e3a53 e09e18c4 d58a88c0 
       c022b45d e09e18c4 d58a88c0 c022f3c3 d58a88c0 d58a88c0 d58a88c0 c01858f8 
Call Trace:
 [<e09e18c4>] rd_queue+0x44/0x148 [rd]
 [<e09e1840>] rd_bdev+0x0/0x40 [rd]
 [<c01e3a03>] kobject_del+0x43/0x80
 [<e09e18c4>] rd_queue+0x44/0x148 [rd]
 [<e09e18c4>] rd_queue+0x44/0x148 [rd]
 [<e09e18c4>] rd_queue+0x44/0x148 [rd]
 [<c01e3a53>] kobject_unregister+0x13/0x30
 [<e09e18c4>] rd_queue+0x44/0x148 [rd]
 [<c022b45d>] elv_unregister_queue+0x1d/0x40
 [<e09e18c4>] rd_queue+0x44/0x148 [rd]
 [<c022f3c3>] unlink_gendisk+0x13/0x40
 [<c01858f8>] del_gendisk+0x58/0xe0
 [<e09e1800>] +0x0/0x40 [rd]
 [<e09e063e>] +0x4e/0x88 [rd]
 [<c0145370>] unmap_vma+0x40/0x80
 [<e09e15c0>] +0x0/0x140 [rd]
 [<c01311f9>] sys_delete_module+0x109/0x140
 [<e09e15c0>] +0x0/0x140 [rd]
 [<c0145854>] sys_munmap+0x44/0x70
 [<c01090e5>] sysenter_past_esp+0x52/0x71

Code: 0f 0b 0f 01 7b c9 2d c0 ff 06 85 f6 0f 84 1c 01 00 00 8b 6e 

2) ALSA:
(Using snd-via82xx, no oss, testing with xmms and libALSA.so) 
I notice the following on 2.5 only. (I use 2.4 ALSA too and it works fine).

When playing an mp3 file and either:

	- attempting to stop the music, or restart it, or play another one, or skip 
in the middle causes the music to keep looping in place until killed.

Testing with mplayer:
	- skipping forward works fine, pause causes loop.

Since the problem does not occur in 2.4 (2.4.21-rc2, alsa 0.9.2 from 
alsa-project.org) I thought it to be a kernel bug.

3) Could someone clarify some module issues for me.
I doubt those are bugs, but I have limited understanding of modules, and I'd 
appreciate some help. Perhaps email off the list?

 - rmmod -a has no effect for me on either 2.4 or 2.5.
On 2.4 modules marked autoclean and unused are not removed by that command.
I need to specify the name of the module to get it removed. Why so? 

- I need to manually insmod snd-via82xx for ALSA to work.
The following line is present in modules.conf/modprobe.conf:
alias snd-card-0 snd-via82xx. Why isn't the module autoloaded when I attempt 
to use xmms to play audio.

- what is the significance of modules.devfs in 2.5 - is it still necessary.
Does the script generate_modprobe.conf take modules.devfs into account?
What will happen to devfs in the future? 

 Thank you for your help.



