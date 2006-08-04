Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161571AbWHDWzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161571AbWHDWzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161572AbWHDWzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:55:11 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:62897 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1161571AbWHDWzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:55:10 -0400
Message-ID: <44D3D04B.5060603@dgreaves.com>
Date: Fri, 04 Aug 2006 23:55:07 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: LVM general discussion and development <linux-lvm@redhat.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Oops and BUG in dm-snapshot
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel: 2.6.17.6 (with xfs patch)

Activity:
created a simple raid0 with 2 300G drives and built an lvm2 vg on top
created a lv using about 90% of the vg
made and mounted an xfs fs
started an rsync to populate the fs

Then:
modprobe dm-snapshot
lvcreate --size 100m --snapshot --name snap /dev/everything/everything
lvdisplay /dev/everything/snap
lvdisplay /dev/everything/everything
lvremove /dev/everything/snap

The lvremove caused this:


BUG: unable to handle kernel paging request at virtual address 65747845
 printing eip:
e0143043
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: dm_snapshot dm_mod raid0 nfs nfsd lockd sunrpc snd_emu10k1
snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc
snd_util_mem snd_hwdep piix tg3 raid5 xor md_mod rtc ide_disk ide_cd cdrom
ide_core unix
CPU:    0
EIP:    0060:[<e0143043>]    Not tainted VLI
EFLAGS: 00010293   (2.6.17.6xfs #2)
EIP is at exit_exception_table+0x36/0x5f [dm_snapshot]
eax: 65747845   ebx: 65747845   ecx: c14f9bc0   edx: c14f9bc0
esi: d9e34d7c   edi: e016b818   ebp: 00000818   esp: de085d8c
ds: 007b   es: 007b   ss: 0068
Process lvremove (pid: 10794, threadinfo=de084000 task=cbe7aa90)
Stack: c14f9bc0 d3bff4e0 c14f9bc0 00000103 00000400 d9e34d40 cdc54c20 e0146800
       e014a080 e014341a c287e940 ca993a80 e014a080 00000000 00000000 e014e9eb
       e014a080 d22b18c0 ca993a80 00000004 de085e1c e014d2b2 ca993a80 ca993a80
Call Trace:
 <e014341a> snapshot_dtr+0x9c/0xd3 [dm_snapshot]  <e014e9eb>
dm_table_put+0x4b/0xae [dm_mod]
 <e014d2b2> dm_put+0x43/0xa4 [dm_mod]  <e0150e9e> __hash_remove+0x76/0x80 [dm_mod]
 <e0150ef7> dev_remove+0x4f/0x6b [dm_mod]  <e0150150> ctl_ioctl+0x201/0x241 [dm_mod]
 <e0150ea8> dev_remove+0x0/0x6b [dm_mod]  <c014da89> do_ioctl+0x3d/0x4e
 <c014dc84> vfs_ioctl+0x1ea/0x1fb  <c014dcc0> sys_ioctl+0x2b/0x47
 <c010294f> syscall_call+0x7/0xb
Code: 24 8b 00 40 89 44 24 08 c7 44 24 04 00 00 00 00 31 ed eb 26 8b 7e 04 01 ef
8b 07 8b 18 eb 10 50 ff 74 24 04 e8 9f a4 ff df 89 d8 <8b> 1b 5a 59 39 f8 75 ec
ff 44 24 04 83 c5 08 8b 44 24 08 39 44
EIP: [<e0143043>] exit_exception_table+0x36/0x5f [dm_snapshot] SS:ESP 0068:de085d8c
 <0>------------[ cut here ]------------
kernel BUG at mm/rmap.c:560!
invalid opcode: 0000 [#2]
Modules linked in: dm_snapshot dm_mod raid0 nfs nfsd lockd sunrpc snd_emu10k1
snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc
snd_util_mem snd_hwdep piix tg3 raid5 xor md_mod rtc ide_disk ide_cd cdrom
ide_core unix
CPU:    0
EIP:    0060:[<c01375d4>]    Not tainted VLI
EFLAGS: 00010286   (2.6.17.6xfs #2)
EIP is at page_remove_rmap+0x15/0x29
eax: ffffffff   ebx: c12b74a0   ecx: c036dc04   edx: c12b74a0
esi: b44f4000   edi: cdec63d0   ebp: 15ba5067   esp: c787be08
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 9956, threadinfo=c787a000 task=cce190b0)
Stack: c013291f c12b74a0 00178000 00000000 00000001 b4800000 d471bb44 d471bb44
       d471bb44 00000000 ffffff0b c036dc04 de586c80 b59fd000 00000000 c787be74
       deb880cc de586c80 c787bec4 c013504c c787be74 d747e4ec 00000000 ffffffff
Call Trace:
 <c013291f> unmap_vmas+0x256/0x41c  <c013504c> exit_mmap+0x4f/0xb6
 <c01131ee> mmput+0x1c/0x60  <c0115a61> exit_mm+0xba/0xbf
 <c011656e> do_exit+0x166/0x5c0  <c0116a21> sys_exit_group+0x0/0x11
 <c011d602> get_signal_to_deliver+0x2e3/0x2f3  <c0102351>
do_notify_resume+0x70/0x563
 <c02a441b> schedule+0x454/0x4b7  <c01208aa> __rcu_process_callbacks+0xcb/0x123
 <c01029de> work_notifysig+0x13/0x19
Code: e8 0c 39 c6 75 08 8b 44 24 1c 89 08 eb 02 31 d2 89 d0 5b 5e 5f c3 8b 54 24
04 83 42 08 ff 0f 98 c0 84 c0 74 19 8b 42 08 40 79 08 <0f> 0b 30 02 d9 9c 2b c0
6a ff 6a 10 e8 fb 4f ff ff 58 5a c3 8b
EIP: [<c01375d4>] page_remove_rmap+0x15/0x29 SS:ESP 0068:c787be08
 <1>Fixing recursive fault but reboot is needed!


David

-- 

