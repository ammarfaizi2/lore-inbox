Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271826AbTG2OKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271816AbTG2OJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:09:59 -0400
Received: from camus.xss.co.at ([194.152.162.19]:42507 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S271815AbTG2OIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:08:46 -0400
Message-ID: <3F267FD7.4040400@xss.co.at>
Date: Tue, 29 Jul 2003 16:08:23 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
Subject: 2.4.22-pre4: devfs on initrd stays busy after pivot_root
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Marcelo Tosatti wrote:
> Hi,
>
> Here goes -pre4. It contains a lot of updates and fixes.
>
> We decided to include this new code quota code which allows usage of
> quotas with 32bit UID/GIDs.
>
> Most Toshibas should work now due to an important ACPI fix.
>
> Please help and test.
>
Beginning with 2.4.22-pre4 I can't unmount devfs on my
initial ramdisk anymore because of EBUSY

I use initrd and let the kernel mount devfs on /dev on boot.
I then set up all the drivers needed to mount the real root
device, do a "pivot_root" and continue with /sbin/init,
just like it is described in Documentation/initrd.txt

When the boot process is finished, filesystems are mounted as
follows:

root@install:~ {520} $ mount
rootfs on / type rootfs (rw)
/dev/root on /initrd type romfs (ro)
none on /initrd/dev type devfs (rw)
/dev/ide/host0/bus0/target0/lun0/part3 on / type ext2 (rw)
devfs on /dev type devfs (rw)
proc on /proc type proc (rw)

I then want to get rid of everything mounted under /initrd

root@install:~ {521} $ umount /initrd/dev
umount: /initrd/dev: device is busy

This used to work just fine with 2.4.21 and 2.4.22-pre[123]

It does not work with 2.4.22-pre4 and 2.4.22-pre8
Also, with linux-2.4.21-ac4 unmounting /initrd/dev
does not work.

I made a diff between pre3 and pre4 and some changes in
fs/exec.c, fs/binfmt_elf.c and kernel/fork.c (around new
function "unshare_files()") look suspicious to me. I find
these changes in both 2.4.21-ac4 and 2.4.22-pre4 patchset
(but I'm not a kernel hacker, so I might be wrong)

Any idea anyone?

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/Jn/MxJmyeGcXPhERApunAKCIUOiZh8kSaeJEXHwj06yBlvMnhQCfe9M3
hfmnS3VtpDx5sCMq5nlJLmU=
=1Tnh
-----END PGP SIGNATURE-----

