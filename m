Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVDFCLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVDFCLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 22:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVDFCLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 22:11:47 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:40654 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262077AbVDFCLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 22:11:02 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 6 Apr 2005 11:44:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16979.16146.433143.743902@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
In-Reply-To: message from Andrew Morton on Tuesday April 5
References: <20050405000524.592fc125.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday April 5, akpm@osdl.org wrote:
> 
> - Nobody said anything about the PM resume and DRI behaviour in
>   2.6.12-rc1-mm4.  So it's all perfect now?

Well, Seeing you asked...

PM resume certainly seems to be improving.
My main problem in rc1-mm3 is with PCMCIA.
If I stop cardmgr before suspend-to-RAM, and then try to
restart it after resume, I cannot.  Some message about the socket
being in use, and am I sure there is no other cardmgr running (there
isn't). 

I can stop and restart happily before suspending, but not after.
If I leave it running during a suspend/resume cycle it keeps working
but if I then stop and restart, it fails.

(and if I do leave it running, my PCMCIA wireless gets started before
my tg3 wired, so eth0 and eth1 get swapped).

I just tried rc2-mm1 and... decided to go back to rc1-mm3.

It seemed to boot mostly OK.  I tried suspend-to-RAM and it seems to
suspend.  But when I turned it back on again it rebooted rather than
resumed.

During boot I got:

Apr  6 10:18:46 localhost kernel: cs: memory probe 0xf6000000-0xfbffffff:iounmap: bad address f8828000
Apr  6 10:18:46 localhost kernel:  [set_cis_map+150/256] set_cis_map+0x96/0x100
Apr  6 10:18:46 localhost kernel:  [remove_vm_area+60/80] remove_vm_area+0x3c/0x50
Apr  6 10:18:46 localhost kernel:  [pcmcia_read_cis_mem+412/560] pcmcia_read_cis_mem+0x19c/0x230
Apr  6 10:18:46 localhost kernel:  [set_cis_map+150/256] set_cis_map+0x96/0x100
Apr  6 10:18:46 localhost kernel:  [read_cis_cache+358/400] read_cis_cache+0x166/0x190
Apr  6 10:18:46 localhost kernel:  [follow_link+141/544] follow_link+0x8d/0x220
Apr  6 10:18:46 localhost kernel:  [pccard_get_next_tuple+688/784] pccard_get_next_tuple+0x2b0/0x310
Apr  6 10:18:46 localhost kernel:  [pccard_get_first_tuple+144/336] pccard_get_first_tuple+0x90/0x150
Apr  6 10:18:46 localhost kernel:  [pccard_validate_cis+151/592] pccard_validate_cis+0x97/0x250
Apr  6 10:18:46 localhost kernel:  [readable+90/160] readable+0x5a/0xa0
Apr  6 10:18:46 localhost kernel:  [cis_readable+129/224] cis_readable+0x81/0xe0
Apr  6 10:18:46 localhost kernel:  [do_mem_probe+469/496] do_mem_probe+0x1d5/0x1f0
Apr  6 10:18:46 localhost kernel:  [inv_probe+159/176] inv_probe+0x9f/0xb0
Apr  6 10:18:46 localhost kernel:  [validate_mem+271/304] validate_mem+0x10f/0x130
Apr  6 10:18:46 localhost kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Apr  6 10:18:46 localhost kernel:  [pcmcia_nonstatic_validate_mem+120/128] pcmcia_nonstatic_validate_mem+0x78/0x80
Apr  6 10:18:46 localhost kernel:  [pcmcia_validate_mem+26/32] pcmcia_validate_mem+0x1a/0x20
Apr  6 10:18:46 localhost kernel:  [pcmcia_card_add+42/208] pcmcia_card_add+0x2a/0xd0
....

Then it hung in some device discovery.  Not sure which device, maybe
firewire.
Alt-Sysrq-T showed

Apr  6 10:19:45 localhost kernel: khpsbpkt      S C04643E0     0  1956      1          1973   915 (L-TLB)
Apr  6 10:19:45 localhost kernel: f6cf3f94 00000046 f68dd070 c04643e0 f7c0f030 c0464410 00000000 f7c0f030 
Apr  6 10:19:45 localhost kernel:        f6cf3f8c 00000000 00000000 00000000 f68dd070 f68dd198 f8af2444 f6cf2000 
Apr  6 10:19:45 localhost kernel:        00000246 f68dd070 c031ce5d f8af244c 00000000 00000001 f68dd070 c0114a70 
Apr  6 10:19:45 localhost kernel: Call Trace:
Apr  6 10:19:45 localhost kernel:  [__down_interruptible+157/300] __down_interruptible+0x9d/0x12c
Apr  6 10:19:45 localhost kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Apr  6 10:19:45 localhost kernel:  [__down_failed_interruptible+7/12] __down_failed_interruptible+0x7/0xc
Apr  6 10:19:45 localhost kernel:  [pg0+945105653/1067918336] .text.lock.ieee1394_core+0x1b/0x26 [ieee1394]
Apr  6 10:19:45 localhost kernel:  [pg0+945105424/1067918336] hpsbpkt_thread+0x0/0xb0 [ieee1394]
Apr  6 10:19:45 localhost kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Apr  6 10:19:45 localhost kernel: knodemgrd_0   S C04643E0     0  1973      1          2023  1956 (L-TLB)
Apr  6 10:19:45 localhost kernel: f7e75f7c 00000046 f7c0f030 c04643e0 0000a1ff 00000000 c018a7cc f648e62c 
Apr  6 10:19:45 localhost kernel:        f6ec8380 00000000 00000000 00000000 f7c0f030 f7c0f158 f6f6b670 f7e74000 
Apr  6 10:19:45 localhost kernel:        00000246 f7c0f030 c031ce5d f6f6b678 00000000 00000001 f7c0f030 c0114a70 
Apr  6 10:19:45 localhost kernel: Call Trace:
Apr  6 10:19:45 localhost kernel:  [sysfs_make_dirent+44/160] sysfs_make_dirent+0x2c/0xa0
Apr  6 10:19:45 localhost kernel:  [__down_interruptible+157/300] __down_interruptible+0x9d/0x12c
Apr  6 10:19:45 localhost kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Apr  6 10:19:45 localhost kernel:  [__down_failed_interruptible+7/12] __down_failed_interruptible+0x7/0xc
Apr  6 10:19:45 localhost kernel:  [pg0+945133083/1067918336] .text.lock.nodemgr+0x112/0x1a7 [ieee1394]
Apr  6 10:19:45 localhost kernel:  [pg0+945131536/1067918336] nodemgr_host_thread+0x0/0x190 [ieee1394]
Apr  6 10:19:45 localhost kernel:  [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18


Apr  6 10:19:45 localhost kernel: grep          D C04643E0     0  2023      1          2036  1973 (NOTLB)
Apr  6 10:19:45 localhost kernel: f640beec 00000086 f6c6da50 c04643e0 00000000 f640bec4 f710ca50 f640bec4 
Apr  6 10:19:45 localhost kernel:        f640bec4 00000000 00000000 00000000 f6c6da50 f6c6db78 f7291424 f6c6da50 
Apr  6 10:19:45 localhost kernel:        00000282 f729142c c031cd4b 00000001 f6c6da50 c0114a70 f729142c f729142c 
Apr  6 10:19:45 localhost kernel: Call Trace:
Apr  6 10:19:45 localhost kernel:  [__down+123/240] __down+0x7b/0xf0
Apr  6 10:19:45 localhost kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Apr  6 10:19:45 localhost kernel:  [__down_failed+7/12] __down_failed+0x7/0xc
Apr  6 10:19:45 localhost kernel:  [.text.lock.usb+22/186] .text.lock.usb+0x16/0xba
Apr  6 10:19:45 localhost kernel:  [usb_device_read+186/288] usb_device_read+0xba/0x120
Apr  6 10:19:45 localhost kernel:  [usb_device_read+0/288] usb_device_read+0x0/0x120
Apr  6 10:19:45 localhost kernel:  [vfs_read+182/368] vfs_read+0xb6/0x170
Apr  6 10:19:45 localhost kernel:  [sys_read+81/128] sys_read+0x51/0x80
Apr  6 10:19:45 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


I think those are the interesting processes, but I can get the full
list if it is useful.

I managed to proceed into the boot with alt-sysrq-E (tErm) but when it
came up enough bits had been killed that I decided to cut my losses
and go back to a previous working kernel...

This in on a Dell Lattitude D800

NeilBrown
