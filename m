Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTDURhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTDURhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:37:18 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:25549 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261789AbTDURhP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:37:15 -0400
Date: Mon, 21 Apr 2003 13:49:18 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
cc: hch@lst.de
Subject: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
Message-ID: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm experiencing reproducible oopses with 2.5.68-bk1 when a pseudoterminal
is unregistered (e.g. when ssh or mc exits):

Unable to handle kernel NULL pointer dereference at virtual address
0000001c
 printing eip:
c0195a9d
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0195a9d>]    Not tainted
EFLAGS: 00010282
EIP is at devfs_remove+0x15d/0x210
eax: 0000000c   ebx: 00000000   ecx: c02fd230   edx: 00006286
esi: c62b9d5c   edi: 00000001   ebp: c62b9da4   esp: c62b9d4c
ds: 007b   es: 007b   ss: 0068
Process sshd (pid: 697, threadinfo=c62b8000 task=c6271380)
Stack: c02bd04e 00000000 000006e8 c02adc3c 2f737470 c1190031 c62b9d94 c0172af4
       c62b9d78 c11a27e8 00000001 00000031 00000286 c6439924 00000001 c615f000
       c61f5d48 c6439924 c62b9da4 c0172c6f c615f000 c6439924 c62b9db8 c01e8b29
Call Trace:
 [<c0172af4>] get_node+0x64/0x80
 [<c0172c6f>] devpts_pty_kill+0x3f/0x56
 [<c01e8b29>] pty_close+0xe9/0x150
 [<c01e3cd0>] release_dev+0x750/0x790
 [<c025a2cd>] sock_destroy_inode+0x1d/0x30
 [<c025a2cd>] sock_destroy_inode+0x1d/0x30
 [<c015c036>] destroy_inode+0x36/0x60
 [<c015d016>] iput+0x56/0x80
 [<c01e40e1>] tty_release+0x11/0x20

It turns out that the "de" variable in devfs_remove() (file
fs/devfs/base.c) is NULL.

I have devfs mounted on /dev and devpts on /dev/pts:

# mount
/dev/hda2 on / type ext3 (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
devfs on /dev type devfs (rw)
/dev/hda1 on /boot type ext3 (rw)
none on /dev/pts type devpts (rw)
none on /sys type sysfs (rw)
none on /dev/shm type tmpfs (rw)

I don't understand why unregistering an entry on devpts results in calling
devfs_remove().  These are different filesystems after all.  This patch
helps, but it probably shouldn't be applied unless it turns out to be
correct.

============================
--- linux.orig/fs/devfs/base.c
+++ linux/fs/devfs/base.c
@@ -1757,6 +1757,8 @@ void devfs_remove(const char *fmt, ...)
 	if (n < 64 && buf[0]) {
 		devfs_handle_t de = _devfs_find_entry(NULL, buf, 0);

+		if (!de)
+			return;
 		write_lock(&de->parent->u.dir.lock);
 		_devfs_unregister(de->parent, de);
 		devfs_put(de);
============================

By the way, I wonder why devfs_put(de) is called twice in a row in
devfs_remove().

-- 
Regards,
Pavel Roskin
