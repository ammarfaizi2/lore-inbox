Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTJUAPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbTJUAPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:15:22 -0400
Received: from h80ad26ab.async.vt.edu ([128.173.38.171]:12160 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263144AbTJUAPD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:15:03 -0400
Message-Id: <200310210014.h9L0EZFP003073@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test8-mm1 
In-Reply-To: Your message of "Tue, 21 Oct 2003 00:01:01 +0200."
             <200310210001.08761.schlicht@uni-mannheim.de> 
From: Valdis.Kletnieks@vt.edu
References: <20031020020558.16d2a776.akpm@osdl.org> <200310201811.18310.schlicht@uni-mannheim.de> <20031020144836.331c4062.akpm@osdl.org>
            <200310210001.08761.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-251779630P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Oct 2003 20:14:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-251779630P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Oct 2003 00:01:01 +0200, Thomas Schlichter said:

> No, I'm not... I use the vesafb driver. Do you think disabling this could cure
> the Oops?
> 
> Btw. a similar Oops at the same place occours when the uhci-hcd module is
> unloaded...
> 
> The attached patch prevents the kernel from Oopsing, so it seems some inode
> lists are corrupted (NULL terminated!). Don't know how the FB driver could be
> the reason...

I was seeing similar issues where the system would fail to find /sbin/init because
things were dying while still on the initrd, and put Thomas' patch on (although I added a
WARN_ON(1) so we'd get a stack trace in addition to the printk).  And then things
got *really* bizarre...

While at work, in its docking station, it would complain while running things
from /linuxrc off the initrd (it complained while firing up SELinux):

SELinux: initialized (dev , type rootfs), uses genfs_contexts
SELinux: initialized (dev , type sysfs), uses genfs_contexts
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c015ec37
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c015ec37>]    Not tainted VLI
EFLAGS: 00010246
EIP is at __iget+0x25/0x6e
eax: 00000000   ebx: 00000000   ecx: cfddc088   edx: cfddc080
esi: cfddc080   edi: c1303308   ebp: cff95dbc   esp: cff95db8
ds: 007b   es: 007b   ss: 0068
Process load_policy (pid: 16, threadinfo=cff94000 task=cff97940)
Stack: cfddc080 cff95dcc c015f5a7 cfddc080 cff94000 cff95df0 c01d7377 cfddc080 
       c1303300 00000000 cffd2bc0 cffd0c40 cffd0c00 cff94000 cff95e10 c01db157 
       cffd0c00 cffd2bc0 cffd2bc8 cff95e20 c0386170 c04c7ca0 cff95f54 c01e026d 
Call Trace:
 [<c015f5a7>] igrab+0x20/0x42
 [<c01d7377>] superblock_doinit+0x227/0x28b
 [<c01db157>] selinux_complete_init+0x96/0xe5
 [<c01e026d>] security_load_policy+0xaf/0x25c
 [<c013e88e>] handle_mm_fault+0x6d/0x10c
 [<c0118a15>] do_page_fault+0x153/0x4a1
 [<c01358a2>] __rmqueue+0xc3/0x123
 [<c0135935>] rmqueue_bulk+0x33/0x78
 [<c0145128>] map_area_pmd+0x50/0x7b
 [<c01188c2>] do_page_fault+0x0/0x4a1
 [<c0367b93>] error_code+0x2f/0x38
 [<c01e915a>] __copy_from_user_ll+0x3c/0x5a
 [<c01db6a7>] sel_write_load+0xd0/0xec
 [<c0149d2d>] vfs_write+0xae/0xdc
 [<c0149dce>] sys_write+0x2c/0x47
 [<c0367187>] syscall_call+0x7/0xb

Code: b6 fe ff ff 5d c3 55 89 e5 53 8b 55 08 8b 42 1c 85 c0 74 05 ff 42 1c eb 58
 ff 42 1c f6 82 34 01 00 00 0f 75 46 8d 4a 08 8b 59 04 <39> 0b 74 08 0f 0b 94 00
 13 5f 38 c0 8b 42 08 39 48 04 74 08 0f 

 <6>note: load_policy[16] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011a0df>] schedule+0x3c/0x4b7
 [<c013d302>] unmap_vmas+0x13c/0x1be
 [<c0140832>] exit_mmap+0x60/0x14b
 [<c011bcb2>] mmput+0x7d/0xbd
 [<c011f33b>] do_exit+0x163/0x351
 [<c010c68a>] do_divide_error+0x0/0xad
 [<c0118c10>] do_page_fault+0x34e/0x4a1
 [<c01240a2>] update_wall_time+0xd/0x37
 [<c01243c0>] do_timer+0x4e/0xc6
 [<c0110f0f>] timer_interrupt+0x5a/0x118
 [<c01208f6>] do_softirq+0x4a/0x91
 [<c010d6de>] do_IRQ+0x121/0x138
 [<c01188c2>] do_page_fault+0x0/0x4a1
 [<c0367b93>] error_code+0x2f/0x38
 [<c01d007b>] udf_UTF8toCS0+0xf2/0x178
 [<c015ec37>] __iget+0x25/0x6e
 [<c015f5a7>] igrab+0x20/0x42
 [<c01d7377>] superblock_doinit+0x227/0x28b
 [<c01db157>] selinux_complete_init+0x96/0xe5
 [<c01e026d>] security_load_policy+0xaf/0x25c
 [<c013e88e>] handle_mm_fault+0x6d/0x10c
 [<c0118a15>] do_page_fault+0x153/0x4a1
 [<c01358a2>] __rmqueue+0xc3/0x123
 [<c0135935>] rmqueue_bulk+0x33/0x78
 [<c0145128>] map_area_pmd+0x50/0x7b
 [<c01188c2>] do_page_fault+0x0/0x4a1
 [<c0367b93>] error_code+0x2f/0x38
 [<c01e915a>] __copy_from_user_ll+0x3c/0x5a
 [<c01db6a7>] sel_write_load+0xd0/0xec
 [<c0149d2d>] vfs_write+0xae/0xdc
 [<c0149dce>] sys_write+0x2c/0x47
 [<c0367187>] syscall_call+0x7/0xb

Badness in invalidate_list() !
Badness in invalidate_list at fs/inode.c:299
Call Trace:
 [<c015ee28>] invalidate_list+0x54/0x104
 [<c015ef24>] invalidate_inodes+0x4c/0xb9
 [<c014ed0c>] generic_shutdown_super+0x7f/0x18d
 [<c014f6c2>] kill_anon_super+0x10/0x40
 [<c014eb6b>] deactivate_super+0x6f/0xb7
 [<c0161c77>] sys_umount+0x5f/0x67
 [<c0149d4f>] vfs_write+0xd0/0xdc
 [<c0149dce>] sys_write+0x2c/0x47
 [<c0161c8c>] sys_oldumount+0xd/0xf
 [<c0367187>] syscall_call+0x7/0xb


Badness in invalidate_list() !
Badness in invalidate_list at fs/inode.c:299
Call Trace:
 [<c015ee28>] invalidate_list+0x54/0x104
 [<c015ef24>] invalidate_inodes+0x4c/0xb9
 [<c014ed2f>] generic_shutdown_super+0xa2/0x18d
 [<c014f6c2>] kill_anon_super+0x10/0x40
 [<c014eb6b>] deactivate_super+0x6f/0xb7
 [<c0161c77>] sys_umount+0x5f/0x67
 [<c0149d4f>] vfs_write+0xd0/0xdc
 [<c0149dce>] sys_write+0x2c/0x47
 [<c0161c8c>] sys_oldumount+0xd/0xf
 [<c0367187>] syscall_call+0x7/0xb

If trying to boot to 'single' or initlevel 3 or 5, it would then wedge up trying to mount
the local filesystems.  I got the above by using init=/bin/bash and doing a dmesg onto
a writeable filesystem I hand-mounted.  So obviously things were very ill, and the patch
merely let the system live long enough for me to get a dmesg to run.

Now for the *really* weird part - at the office, the early dmesg has:

Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured

I came home, and rebooted the laptop - same kernel, same everything except it
wasn't docked, and it crashed... *partial* oops follows, my pen was dying so
I got what seemed most important:

Console: switching to colour frame buffer device 160x64
Unable to handle kernel NULL pointer dereference at virtual address 00000068
...
EIP is at create_dir+0x1f/0x8f
....
	sysfs_create_dir+0x5a/0x70
	create_dir+0x15/0x39
	kobject_add+0xb2/0x107
	cdev_add+0xe/0x4c
	tty_register_driver+0x112/0x213
	pty_init+0x2db/0x40b
	do_initcalls_0x35/0x87
	init+0x32/0x10e
	init+0x0/0x10e
	kernel_thread_helper+0x5/0xb

Never got as far as saying 256 ptys.

(reproducible, from a power-off it did it same way 3 times in a row).  So
whatever was giving it indigestion was (a) *very* early on and (b) different
when my laptop was docked and undocked.  I'm guessing something ACPI-related,
because when undocked I'm shy an Ethernet controller that's in the dock.
However, the only new patches in -mm1 that seem to go near acpi are the EFI and
MSI patches - and I checked, neither is config'ed into the kernel.

This ring any bells?  What you want tested? etc etc....




--==_Exmh_-251779630P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/lHpqcC3lWbTT17ARAjzdAJoDPzcN43h9razExx6nVV2bFZBZGgCaAhf1
8YpWcW771DPOYcMyDFprWuw=
=Ohpm
-----END PGP SIGNATURE-----

--==_Exmh_-251779630P--
