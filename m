Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVHAOD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVHAOD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVHAOD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:03:56 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:32963 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262033AbVHAODz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:03:55 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show 
In-reply-to: Your message of "Mon, 01 Aug 2005 22:14:05 +1000."
             <8551.1122898445@ocs3.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Aug 2005 00:03:37 +1000
Message-ID: <10600.1122905017@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another (different) manifestation of use after free in sysfs.  It broke
on module_put(owner) in sysfs_release().  FWIW this ia64 build is
uni-processor, so there is a lot more context switching than normally
occurs on udev.

fill_kobj_path: path = '/class/vc/vcs2'
kobject_hotplug: /sbin/hotplug vc seq=1809 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcs2 SUBSYSTEM=vc
kobject vcsa2: registering. parent: vc, set: class_obj
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa2'
kobject_hotplug: /sbin/hotplug vc seq=1810 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add DEVPATH=/class/vc/vcsa2 SUBSYSTEM=vc
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs1'
kobject_hotplug: /sbin/hotplug vc seq=1811 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs1 SUBSYSTEM=vc
kobject vcs1: cleaning up
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa1'
kobject_hotplug: /sbin/hotplug vc seq=1812 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa1 SUBSYSTEM=vc
kobject vcsa1: cleaning up
kobject vcs16: cleaning up
Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b6cf3
udev[24414]: Oops 8821862825984 [1]
Modules linked in: md5 ipv6 usbcore raid0 md_mod nls_iso8859_1 nls_cp437 dm_mod sg st osst

Pid: 24414, CPU 0, comm:                 udev
psr : 00001010081a6018 ifs : 8000000000000308 ip  : [<a00000010025c010>]    Not tainted
ip is at sysfs_release+0xf0/0x1c0
unat: 0000000000000000 pfs : 0000000000000308 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000000000158659
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8270033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010025bff0 b6  : a00000010000e8c0 b7  : a00000010057ff00
f6  : 1003e6b6b6b6b6b6b6b6b f7  : 0ffe58bbeff7b80000000
f8  : 1003e0000000000000578 f9  : 1003e0000000000000005
f10 : 100019ffffffff803b6e3 f11 : 1003e0000000000000005
r1  : a000000100ddf690 r2  : 0000000000000001 r3  : e00000b078360da0
r8  : 0000000000000000 r9  : a000000100be0a40 r10 : 00000000000000f4
r11 : 0000000000000001 r12 : e00000b078367e30 r13 : e00000b078360000
r14 : 6b6b6b6b6b6b6cf3 r15 : 0000000000000001 r16 : e00000b078360da0
r17 : 0000000000000000 r18 : 00000000054cd124 r19 : a0007fff62138000
r20 : a0007fff8c7a0000 r21 : 0000000000000010 r22 : 0000000000004000
r23 : 6b6b6b6b6b6b6b6b r24 : 0000000000000000 r25 : e00000347bff0758
r26 : 0000000000000090 r27 : e0000030752f0728 r28 : e0000030752f0720
r29 : e0000030752f0738 r30 : 0000000000000000 r31 : 0000000000000001

kdb> r s
 r32: e00000b476b32df0  r33: e00000b472417380  r34: 6b6b6b6b6b6b6b6b 
 r35: a00000010019a060  r36: 0000000000000610  r37: 0000000000000610 
 r38: a00000010025bff0  r39: 0000000000000308 

kdb> bt
Stack traceback for pid 24414
0xe00000b078360000    24414    24400  1    0   R  0xe00000b078360300 *udev
0xa00000010025c010 sysfs_release+0xf0
        args (0xe00000b476b32df0, 0xe00000b472417380, 0x6b6b6b6b6b6b6b6b, 0xa00000010019a060, 0x610)
0xa00000010019a060 __fput+0x3c0
        args (0xe00000301eeae8d0, 0xe00000301eeae8f0, 0xe00000b476b32df0, 0xe00000301eeae8e0, 0xe00000347bc91200)
0xa00000010019a0c0 fput+0x40
        args (0xe00000301eeae8d0, 0xa000000100191d60, 0x308, 0xe00000b476b32df0)
0xa000000100191d60 filp_close+0xc0
        args (0xe00000301eeae8d0, 0xe00000b4720d5230, 0x0, 0xa0000001001920d0, 0x919)
0xa0000001001920d0 sys_close+0x2f0
        args (0x6, 0x6000000000058210, 0x4000, 0x280, 0x0)
0xa00000010000b520 ia64_ret_from_syscall
        args (0x6, 0x6000000000058210, 0x4000)
0xa000000000010640 __kernel_syscall_via_break
        args (0x6, 0x6000000000058210, 0x4000)

kdb> inode 0xe00000b476b32df0
struct inode at  0xe00000b476b32df0
 i_ino = 34192 i_count = 1 i_size 16384
 i_mode = 0100444  i_nlink = 0  i_rdev = 0x0
 i_hash.nxt = 0x0000000000000000 i_hash.pprev = 0x0000000000000000
 i_list.nxt = 0xe00000b472084d40 i_list.prv = 0xe00000b476b31c98
 i_dentry.nxt = 0xe00000301d1712a0 i_dentry.prv = 0xe00000301d1712a0
 i_sb = 0xe000003003e5ad58 i_op = 0xa000000100a61488 i_data = 0xe00000b476b32f98 nrpages = 0
 i_fop= 0xa000000100a615c8 i_flock = 0x0000000000000000 i_mapping = 0xe00000b476b32f98
 i_flags 0x0 i_state 0x0 []  fs specific info @ 0xe00000b476b33148

kdb> dentry 0xe00000301d1712a0
Dentry at 0xe00000301d1712a0
 d_name.len = 3 d_name.name = 0xe00000301d171384 <dev>
 d_count = 1 d_flags = 0x18 d_inode = 0xe00000b476b32df0
 d_parent = 0xe00000301d171a80
 d_hash.nxt = 0x0000000000000000 d_hash.prv = 0x0000000000200200
 d_lru.nxt = 0xe00000301d1712f8 d_lru.prv = 0xe00000301d1712f8
 d_child.nxt = 0xe00000301d171af8 d_child.prv = 0xe00000301d171af8
 d_subdirs.nxt = 0xe00000301d171318 d_subdirs.prv = 0xe00000301d171318
 d_alias.nxt = 0xe00000b476b32e20 d_alias.prv = 0xe00000b476b32e20
 d_op = 0xa000000100a61870 d_sb = 0xe000003003e5ad58

