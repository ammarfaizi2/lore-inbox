Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWELVwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWELVwF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWELVwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:52:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:524 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932250AbWELVwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:52:03 -0400
Date: Fri, 12 May 2006 22:51:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512215151.GG17120@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
	axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@suse.de>
References: <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org> <1147456038.3769.39.camel@mulgrave.il.steeleye.com> <1147460325.3769.46.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org> <20060512205804.GD17120@flint.arm.linux.org.uk> <Pine.LNX.4.64.0605121409250.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605121409250.3866@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 02:27:19PM -0700, Linus Torvalds wrote:
> [remove all the inflamatory stuff]

Anyway, you asked for the original oopsen, and here they are.  Enjoy.

From: Todd Blumer <todd@sdgsystems.com>
On a PXA27x handheld (iPAQ hx4700), when we eject a mounted SD memory
card, we get a kernel panic (kernel trying to clean up non-existent
device). One hack patch to avoid the panic is:

--- fs/partitions/check.c       10 Apr 2006 22:57:27 -0000      1.15
+++ fs/partitions/check.c       4 May 2006 20:30:15 -0000
@@ -491,6 +491,7 @@
                        kfree(disk_name);
                }
                put_device(disk->driverfs_dev);
+               disk->driverfs_dev = 0; /* HACK - what's the right
solution? */
        }
        kobject_uevent(&disk->kobj, KOBJ_REMOVE);
        kobject_del(&disk->kobj);

...
root@ipaq-pxa270:~# Unable to handle kernel NULL pointer dereference at
virtual2pgd = c218c000
[00000002] *pgd=a20ec031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: nls_iso8859_1 nls_cp437 snd_pcm_oss snd_mixer_oss
snd_hx4700rCPU: 0
PC is at strlen+0xc/0x30
LR is at kobject_get_path+0x2c/0xc0
pc : [<c00ee56c>]    lr : [<c00eb724>]    Not tainted
sp : c21bfde4  ip : c21bfdf4  fp : c21bfdf0
r10: c21bfe28  r9 : 000007a5  r8 : c21bfe2c
r7 : c3554074  r6 : 000000d0  r5 : 00000001  r4 : c3554074
r3 : 00000002  r2 : c01fa88f  r1 : 00000002  r0 : 00000002
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 397F  Table: A218C000  DAC: 00000015
Process umount (pid: 2384, stack limit = 0xc21be198)
Stack: (0xc21bfde4 to 0xc21c0000)
fde0:          c21bfe14 c21bfdf4 c00eb724 c00ee56c c34876c0 c355400c
c3542b78
fe00: 0000001a c21bfe2c c21bfe58 c21bfe18 c00e2edc c00eb704 000007a5
c21bfe28
fe20: c01fa888 000000fe 00000012 00000002 c3c9585b c0226e04 c32ff7a8
c3542b60
fe40: c3c9583f c01fab8c c0226db0 c21bfeb0 c21bfe5c c00ec130 c00e2dcc
c3c9585b
fe60: 000007a5 c3c95800 c0226dc4 c3e15b20 00000001 00000001 00000000
00000000
fe80: ffffffff bee45e28 c0331040 c3554200 c3554200 00000000 00000000
c21bff28
fea0: c21bff20 c21bfec0 c21bfeb4 c0084d6c c00ebf1c c21bfed8 c21bfec4
c0084f04
fec0: c0084d48 c3554200 c0225d84 c21bfef0 c21bfedc c0083d90 c0084ef0
c3554200
fee0: c032bd20 c21bff08 c21bfef4 c009b804 c0083d30 c21bff28 c21be000
c21bff1c
ff00: c21bff0c c008baec c009b79c 00000000 c21bff94 c21bff20 c009c0ec
c008bad8
ff20: c21bff20 c21bff20 c20e73a0 c032bd20 c21bff3c c0024db0 c00ee388
00000001
ff40: 00000001 00000000 00000000 ffffffff bee45e28 00000000 00000000
c21bffb0
ff60: 00000000 00091050 c21bff9c bee44db8 000923c8 bee44db8 00000016
c001cf64
ff80: c21be000 00091050 c21bffa4 c21bff98 c009c114 c009beec 00000000
c21bffa8
ffa0: c001cdc0 c009c10c bee44db8 000923c8 bee44db8 bee44dba 000923ca
0000006d
ffc0: bee44db8 000923c8 bee44db8 00000000 00090710 00000000 00091050
00000000
ffe0: 40160e70 bee44d9c 00063fc4 40160e74 60000010 bee44db8 401bd7d8
400dad9c
Backtrace:
[<c00ee560>] (strlen+0x0/0x30) from [<c00eb724>]
(kobject_get_path+0x2c/0xc0)
[<c00eb6f8>] (kobject_get_path+0x0/0xc0) from [<c00e2edc>]
(block_uevent+0x11c/) r8 = C21BFE2C  r7 = 0000001A  r6 = C3542B78  r5 =
C355400C
 r4 = C34876C0
[<c00e2dc0>] (block_uevent+0x0/0x1f4) from [<c00ec130>]
(kobject_uevent+0x220/0)[<c00ebf10>] (kobject_uevent+0x0/0x478) from
[<c0084d6c>] (bdev_uevent+0x30/0x3)[<c0084d3c>] (bdev_uevent+0x0/0x34)
from [<c0084f04>] (kill_block_super+0x20/0x)[<c0084ee4>]
(kill_block_super+0x0/0x3c) from [<c0083d90>] (deactivate_super+0x) r5 =
C0225D84  r4 = C3554200
[<c0083d24>] (deactivate_super+0x0/0x84) from [<c009b804>]
(mntput_no_expire+0x) r5 = C032BD20  r4 = C3554200
[<c009b790>] (mntput_no_expire+0x0/0xc0) from [<c008baec>]
(path_release_on_umo) r5 = C21BE000  r4 = C21BFF28
[<c008bacc>] (path_release_on_umount+0x0/0x24) from [<c009c0ec>]
(sys_umount+0x) r4 = 00000000
[<c009bee0>] (sys_umount+0x0/0x220) from [<c009c114>]
(sys_oldumount+0x14/0x18)
[<c009c100>] (sys_oldumount+0x0/0x18) from [<c001cdc0>]

(ret_fast_syscall+0x0/0)Code: e89da800 e1a0c00d e92dd800 e24cb004 (e5d03000)

and:

From: Mikkel Erup <mikkelerup () yahoo ! com>

 BUG: unable to handle kernel NULL pointer dereference
 at virtual address 00000002
  printing eip:
 c021570d
 *pde = 00000000
 Oops: 0000 [#1]
 PREEMPT
 Modules linked in: nls_iso8859_1 nls_cp437 vfat fat
 speedstep_lib i915 drm mmc_block nvram pcmcia
 yenta_socket rsrc_nonstatic sdhci pcmcia_core e1000
 mmc_core evdev
 CPU:    0
 EIP:    0060:[<c021570d>]    Not tainted VLI
 EFLAGS: 00010202   (2.6.16-git20 #3)
 EIP is at kobject_get_path+0x2d/0xe0
 eax: 00000000   ebx: 00000001   ecx: ffffffff   edx:
 00000000
 esi: e35e9e74   edi: 00000002   ebp: 000007a5   esp:
 dcea1e5c
 ds: 007b   es: 007b   ss: 0068
 Process umount (pid: 3407, threadinfo=dcea0000
 task=dd334a30)
 Stack: <0>c038cad3 dcea1ea0 00000008 dcea1e9c e2765200
 e35e9e0c df304158 000007a5
        c020bb5d e35e9e74 000000d0 dcea1ea0 de9ad85b
 000007a5 dcea1ea4 c038cacb
        000000fe 00000002 00000012 c020ba50 c03c8860
 0000001a de9ad800 c0215d1e
 Call Trace:
  <c020bb5d> block_uevent+0x10d/0x210   <c020ba50>
 block_uevent+0x0/0x210
  <c0215d1e> kobject_uevent+0x1fe/0x520   <c0166860>
 bdev_uevent+0x20/0x40
  <c0166cc1> kill_block_super+0x21/0x50   <c0166f80>
 deactivate_super+0x70/0xa0
  <c017fecb> sys_umount+0x4b/0x280   <c010306f>
 sysenter_past_esp+0x54/0x75
 Code: d2 57 56 53 bb 01 00 00 00 83 ec 10 8b 74 24 24
 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 8b 3e 85 ff
 74 1d b9 ff ff ff ff 89 d0 <f2> ae f7 d1 49 8b 76 24 8d
 2c 19 8d 5d 01 85 f6 75 e1 85 db 75

Now, can I have your permission not to do anything more tonight?  Is
that okay with you, or are you going to rant about that as well?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
