Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVC1LCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVC1LCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 06:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVC1LCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 06:02:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:527 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261516AbVC1LCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 06:02:13 -0500
Date: Mon, 28 Mar 2005 12:02:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3
Message-ID: <20050328120200.C9847@flint.arm.linux.org.uk>
Mail-Followup-To: Reuben Farrelly <reuben-lkml@reub.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <fa.h3qui0k.n6uf30@ifi.uio.no> <4247DCBE.7020900@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4247DCBE.7020900@reub.net>; from reuben-lkml@reub.net on Mon, Mar 28, 2005 at 10:30:22PM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 10:30:22PM +1200, Reuben Farrelly wrote:
> Unable to handle kernel paging request at virtual address f3a6ce68
>   printing eip:
> c0244109
> *pde = 00000000
> Oops: 0000 [#1]
> SMP DEBUG_PAGEALLOC
> Modules linked in: hidp hci_usb sermouse nfsd exportfs md5 ipv6 lp 
> autofs4 eeprom lm85 i2c_sensor rfcomm l2cap bluetooth nfs lock
> d sunrpc usb_storage pwc videodev dm_mod video button battery ac 
> ohci1394 ieee1394 uhci_hcd ehci_hcd parport_serial parport_pc parp
> ort hw_random i2c_i801 i2c_core emu10k1_gp gameport e100 mii floppy ext3 
> jbd ata_piix libata sd_mod scsi_mod
> CPU:    0
> EIP:    0060:[<c0244109>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.12-rc1-mm3)
> EIP is at serport_ldisc_write_wakeup+0x9/0x20
> eax: f3a6cdf8   ebx: f73d7000   ecx: c038e374   edx: c0244100
> esi: f73d700c   edi: f73d7000   ebp: c049e900   esp: f7568dc0
> ds: 007b   es: 007b   ss: 0068
> Process inputattach (pid: 2932, threadinfo=f7568000 task=f6993ac0)
> Stack: c021bb08 00000286 f6c31000 c0245e4a f6c31018 f73d7000 f67c1e88 
> cbff5c
>         00000000 c021ceaa 00000000 00000000 00000000 c1e46000 c1e46000 
> 00000000
>         00000000 c011b739 00000046 c1e46000 00000001 f2c00000 f2c00000 
> c011b8b4
> Call Trace:
> ^M [<c021bb08>] tty_wakeup+0x48/0x70
> ^M [<c0245e4a>] uart_close+0xca/0x1e0

Looks like something in the input layer went bang.  The code in
serport_ldisc_write_wakeup is:

   0:   8b 80 a8 09 00 00       mov    0x9a8(%eax),%eax
   6:   8b 40 14                mov    0x14(%eax),%eax
   9:   8b 50 70                mov    0x70(%eax),%edx <====
   c:   85 d2                   test   %edx,%edx
   e:   74 09                   je     0x19

and the marked line exploded on you.  The above instructions correspond
with:

0:	struct serport *sp = (struct serport *) tty->disc_data;
6:	serio_drv_write_wakeup(sp->serio);
9:	if (serio->drv

So, "serio" was this strange 0xf3a6cdf8 value.  But why?  One for the
input people I think.

> ^M [<c021ceaa>] release_dev+0x14a/0x750
> ^M [<c011b739>] change_page_attr+0x29/0x60
> ^M [<c011b8b4>] kernel_map_pages+0x84/0xa0
> ^M [<c014cbca>] store_stackinfo+0x5a/0x90
> ^M [<c01664c8>] __fput+0x108/0x180
> ^M [<c018b59b>] inotify_inode_queue_event+0x2b/0x40
> ^M [<c021d97f>] tty_release+0xf/0x20
> ^M [<c016644a>] __fput+0x8a/0x180
> ^M [<c0164d7b>] filp_close+0x4b/0x70
> ^M [<c0125254>] put_files_struct+0x74/0x100
> ^M [<c012610c>] do_exit+0x11c/0x420
> ^M [<c012647d>] do_group_exit+0x2d/0xa0
> ^M [<c012f74c>] get_signal_to_deliver+0x20c/0x310
> ^M [<c0103deb>] do_signal+0x5b/0x140
> ^M [<c011ea89>] __wake_up+0x29/0x40
> ^M [<c021b60c>] tty_ldisc_deref+0x3c/0x70
> ^M [<c021c267>] tty_read+0xc7/0x130
> ^M [<c0243fb0>] serport_ldisc_read+0x0/0x100
> ^M [<c016ecd3>] sys_fstat64+0x23/0x30
> ^M [<c021c1a0>] tty_read+0x0/0x130
> ^M [<c0165547>] vfs_read+0x97/0x140
> ^M [<c016585c>] sys_read+0x3c/0x70
> ^M [<c0103efa>] do_notify_resume+0x2a/0x40
> ^M [<c01040be>] work_notifysig+0x13/0x25
> ^MCode: e8 0f b6 c5 88 4b 4b 31 d2 c1 e9 10 88 43 4a 88 4b 49 89 d0 5b 
> c3 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 80 a8 09 00 00 8b
> 40 14 <8b> 50 70 85 d2 74 09 8b 52 10 85 d2 74 02 ff d2 c3 90 90 90 90
> ^M BUG: atomic counter underflow at:
> ^M [<c0126386>] do_exit+0x396/0x420
> ^M [<c01059f6>] die+0x166/0x170
> ^M [<c011a7a3>] do_page_fault+0x1f3/0x6a1
> ^M [<c0244109>] serport_ldisc_write_wakeup+0x9/0x20
> ^M [<c011b36c>] __change_page_attr+0x4c/0x3f0
> ^M [<c011a5b0>] do_page_fault+0x0/0x6a1
> ^M [<c010522f>] error_code+0x4f/0x60
> ^M [<c0244100>] serport_ldisc_write_wakeup+0x0/0x20
> ^M [<c0244109>] serport_ldisc_write_wakeup+0x9/0x20
> ^M [<c021bb08>] tty_wakeup+0x48/0x70
> ^M [<c0245e4a>] uart_close+0xca/0x1e0
> ^M [<c021ceaa>] release_dev+0x14a/0x750
> ^M [<c011b739>] change_page_attr+0x29/0x60
> ^M [<c011b8b4>] kernel_map_pages+0x84/0xa0
> ^M [<c014cbca>] store_stackinfo+0x5a/0x90
> ^M [<c01664c8>] __fput+0x108/0x180
> ^M [<c018b59b>] inotify_inode_queue_event+0x2b/0x40
> ^M [<c021d97f>] tty_release+0xf/0x20
> ^M [<c016644a>] __fput+0x8a/0x180
> ^M [<c0164d7b>] filp_close+0x4b/0x70
> ^M [<c0125254>] put_files_struct+0x74/0x100
> ^M [<c012610c>] do_exit+0x11c/0x420
> ^M [<c012647d>] do_group_exit+0x2d/0xa0
> ^M [<c012f74c>] get_signal_to_deliver+0x20c/0x310
> ^M [<c0103deb>] do_signal+0x5b/0x140
> ^M [<c011ea89>] __wake_up+0x29/0x40
> ^M [<c021b60c>] tty_ldisc_deref+0x3c/0x70
> ^M [<c021c267>] tty_read+0xc7/0x130
> ^M [<c0243fb0>] serport_ldisc_read+0x0/0x100
> ^M [<c016ecd3>] sys_fstat64+0x23/0x30
> ^M [<c021c1a0>] tty_read+0x0/0x130
> ^M [<c0165547>] vfs_read+0x97/0x140
> ^M [<c016585c>] sys_read+0x3c/0x70
> ^M [<c0103efa>] do_notify_resume+0x2a/0x40
> ^M [<c01040be>] work_notifysig+0x13/0x25

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
