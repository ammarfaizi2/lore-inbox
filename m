Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVBNLtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVBNLtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 06:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVBNLtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 06:49:13 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:64669 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261414AbVBNLtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 06:49:04 -0500
Subject: [BUG: UML 2.6.11-rc4-bk-latest] sleeping function called from
	invalid context and segmentation fault
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, lkml <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Mon, 14 Feb 2005 11:48:53 +0000
Message-Id: <1108381733.10703.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get a few Debug messages of the form from UML:

Debug: sleeping function called from invalid context at
include/asm/arch/semaphore.h:107
in_atomic():0, irqs_disabled():1
Call Trace:
087d77b0:  [<0809aaa5>] __might_sleep+0x135/0x180
087d77d8:  [<084d377f>] mcount+0xf/0x20
087d77e0:  [<0807cc13>] uml_console_write+0x33/0x80
087d7800:  [<080a2138>] __call_console_drivers+0x88/0xc0
087d7830:  [<080a2b9c>] release_console_sem+0x33c/0x5f0
087d7850:  [<080a3a69>] vprintk+0x309/0x5f0
087d7868:  [<084d377f>] mcount+0xf/0x20
087d78a0:  [<080a23f6>] printk+0x26/0x40
087d78b0:  [<081678a2>] d_splice_alias+0x2f2/0x3e0
087d78c0:  [<0807f272>] line_ioctl+0x102/0x120
087d78dc:  [<0807f170>] line_ioctl+0x0/0x120
087d78e0:  [<0807f17a>] line_ioctl+0xa/0x120
087d78f0:  [<0832b83d>] tty_ioctl+0x2bd/0x2a00
087d7930:  [<08073539>] get_signals+0x49/0xb0
087d7940:  [<08155fb1>] link_path_walk+0x1931/0x2580
087d7948:  [<081e3d00>] ext3_permission+0x0/0x30
087d7970:  [<0809115b>] os_window_size+0x2b/0x80
087d7990:  [<0807e5f2>] generic_window_size+0x32/0xb0
087d79c0:  [<0807d3cb>] chan_window_size+0x8b/0xa0
087d79e0:  [<080801b3>] line_open+0x93/0x240
087d7a10:  [<0807cb7c>] con_open+0x2c/0x40
087d7a30:  [<083293b2>] tty_open+0x332/0x750
087d7a58:  [<084d377f>] mcount+0xf/0x20
087d7a68:  [<08144e48>] exact_match+0x8/0x20
087d7a90:  [<08073218>] enable_mask+0x78/0xb0
087d7aa0:  [<0807331e>] set_signals+0xce/0x2a0
087d7ad0:  [<0815b49e>] do_ioctl+0x6e/0xe0
087d7b00:  [<0815b608>] vfs_ioctl+0xf8/0x960
087d7b40:  [<084d377f>] mcount+0xf/0x20
087d7b60:  [<0815becf>] sys_ioctl+0x5f/0xb0
087d7b74:  [<084d377f>] mcount+0xf/0x20
087d7b90:  [<0807b162>] execute_syscall_skas+0xc2/0xe0
087d7bb0:  [<0807b0ae>] execute_syscall_skas+0xe/0xe0
087d7be0:  [<0806fa1c>] syscall_trace+0xc/0x200
087d7c00:  [<084d377f>] mcount+0xf/0x20
087d7c20:  [<0807b1fb>] handle_syscall+0x5b/0xb0
087d7c30:  [<08093c52>] save_registers+0x42/0xb0
087d7c50:  [<0807a19d>] userspace+0x45d/0x6e0
087d7c78:  [<0807e000>] chan_interrupt+0x250/0x420
087d7cb0:  [<0809c8c1>] schedule_tail+0x21/0x100
087d7cc4:  [<08068250>] init+0x0/0x410
087d7cd0:  [<0807aed7>] new_thread_handler+0x117/0x190
087d7d20:  [<084c2358>] __restore+0x0/0x8
087d7d60:  [<084c2511>] kill+0x11/0x20

Most are coming via uml_console_write.  If interested you can get the
full UML console log (starting uml, logging in as root and shutting it
down again) here:

http://www-uxsup.csx.cam.ac.uk/~aia21/linux/uml/uml-console-log.txt

Also, once the UML has shutdown, the gnome-terminals (which I use
instead of xterm) do not disappear and I get the following segmentation
fault on the host:

vmlinux umid=uml0 mem=256m ubd0=ubd0 ubd1=/usr/src/ntfs_hdd10
eth0=tuntap,uml0,fe:fd:dd:f8:a6:4e ssl=none con=xterm
xterm=gnome-terminal,-t,-x root=/dev/ubda1
Set 'uml0' persistent and owned by uid 29847
Starting uml...
Checking for /proc/mm...found
Checking for the skas3 patch in the host...found
Checking PROT_EXEC mmap in /tmp...OK
 
/home/aia21/bin/my-start-uml: line 76:  9613 Segmentation
fault      /bin/bash -c "./$KERNEL $UML_ARGS $*"
Set 'uml0' nonpersistent

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

