Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVACNb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVACNb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 08:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVACNb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 08:31:56 -0500
Received: from main.gmane.org ([80.91.229.2]:7082 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261444AbVACNbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 08:31:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Vincent Pelletier <subdino2004@yahoo.fr>
Subject: 2.6.10 : fs/openpromfs/inode.c : small mistakes makes module oops
 when writing
Date: Mon, 03 Jan 2005 14:08:36 +0100
Message-ID: <crbg4j$vbr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adijon-152-1-53-216.w83-194.abo.wanadoo.fr
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I'm using kernel 2.6.10 from kernel.org, on an U10 sun ultrasparcIIi.

I'm playing a bit with openprom settings using openpromfs, and I wasn't
able to change the oem-logo. Here is the command and the oops message :

# cat /some/logo/file > /proc/opemprom/options/oem-logo
(same if openpromfs is mounted in /mnt/openprom for example)

Jan  3 12:54:06 usparc kernel: cat(2323): Oops [#1]
Jan  3 12:54:06 usparc kernel: TSTATE: 0000004411009600 TPC: 00000000020520c4 TNPC: 00000000020520c8 Y: 00000000    Tainted: P
Jan  3 12:54:06 usparc kernel: TPC: <property_read+0x4/0xaa0 [openpromfs]>
Jan  3 12:54:06 usparc kernel: g0: 0000000000000000 g1: fffff800076b41e0 g2: 0000000000fffffe g3: 0000000000000000
Jan  3 12:54:06 usparc kernel: g4: fffff800075cd6e0 g5: fffff800076b41e0 g6: fffff80006978000 g7: 0000000070015638
Jan  3 12:54:06 usparc kernel: o0: 00000000000248a0 o1: 0000000000002000 o2: 00000000effff920 o3: 0000000000000000
Jan  3 12:54:06 usparc kernel: o4: 0000000000000c00 o5: 0000000000000c00 sp: fffff8000697b2e1 ret_pc: 0000000000011654
Jan  3 12:54:06 usparc kernel: RPC: <0x11654>
Jan  3 12:54:06 usparc kernel: l0: 0000000000000001 l1: 0000000000000010 l2: 000000002e300047 l3: 0000000000470000
Jan  3 12:54:06 usparc kernel: l4: 000042435f322e30 l5: 0000000000000001 l6: 0000000000000000 l7: 0000000000023800
Jan  3 12:54:06 usparc kernel: i0: fffff800076b41e0 i1: 0000000000000000 i2: 0000000000000000 i3: 0000000000000000
Jan  3 12:54:06 usparc kernel: i4: 0000000000474c49 i5: 0000000000000047 i6: fffff8000697b411 i7: 000000000205340c
Jan  3 12:54:06 usparc kernel: I7: <property_write+0x8ac/0x8e0 [openpromfs]>
Jan  3 12:54:06 usparc kernel: Caller[000000000205340c]: property_write+0x8ac/0x8e0 [openpromfs]
Jan  3 12:54:06 usparc kernel: Caller[000000000048c548]: vfs_write+0xa8/0x100
Jan  3 12:54:06 usparc kernel: Caller[000000000048c62c]: sys_write+0x2c/0x60
Jan  3 12:54:06 usparc kernel: Caller[0000000000411174]: linux_sparc_syscall32+0x34/0x40
Jan  3 12:54:06 usparc kernel: Caller[0000000000012860]: 0x12860
Jan  3 12:54:06 usparc kernel: Instruction DUMP: 01000000  01000000  9de3bed0 <ca5ec000> 03003fff  84102000  821063fe  c65e2010  a8100018

The problem is here in the source file:
Line numbers may not be accurate as I tried some changes.
(line 86)
static ssize_t property_read(struct file *filp, char __user *buf,
			     size_t count, loff_t *ppos)
{
[...]
	if (*ppos >= 0xffffff || count >= 0xffffff)
		return -EINVAL;

(line 321)
static ssize_t property_write(struct file *filp, const char __user *buf,
			      size_t count, loff_t *ppos)
{
[...]
	if (!filp->private_data) {
		i = property_read (filp, NULL, 0, NULL);

So property_read tries to dereference ppos which is set to NULL when
called from property_write. If property_write is called with NULL args
it may oops too, as it uses args the same way.

I think I can write a patch, just tell me if it has chances to be committed in
the kernel (I'm not a kernel dev). If so, where could I find patch
submission guidelines ?

Vincent Pelletier
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2UPUibN+MXHkAogRAqsSAKCKrF5Q/kdgWZrPF++wEnSupzKw7gCfb10s
dWO0Cf6lahwkS6V8p74n3NM=
=EF1b
-----END PGP SIGNATURE-----

