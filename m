Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbULaAvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbULaAvG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbULaAvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:51:06 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:21078 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261801AbULaAu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:50:56 -0500
Message-ID: <41D4A2A6.3060607@tls.msk.ru>
Date: Fri, 31 Dec 2004 03:51:50 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: initramfs: is it supposed to work?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to play with initramfs (aka cpio "image") and 2.6.10
kernel, and have several questions, main of them is whenever
it is supposed to work at all at this stage.

By replacing "standard" initrd filesystem (be it romfs, cramfs,
or even ext2), when it works with /sbin/init started with pid=1
and does pivot_root() after mounting real root, with a cpio image
containing all the same files (plus /init which is just a link
to /sbin/init), I managed to get it to boot just fine (I used a
little shell script to generate the cpio archive, quite similar
to what usr/gen_init_cpio.c does -- fun excersise in shell
programming).  So far so good.

But now, the only problem left is that the kernel does not want
to do the last step: to umount the /initrd (which is initramfs
after pivot_root) after booting: kernel enters an endless loop
inside umount() syscall somewhere (system locks up completely
and starts "eating" cpu which is quite visible on a laptop:
the fans starts rotating after about half a minute after entering
the umount() call), not even responding to sysrq requests.

Maybe I did something wrong when creating the initramfs image
(it is normal cpio archive, and gen_init_cpio.c does the same
thing given the same set of files).  I tried both with and
without the root entry in the archive (gen_init_cpio.c does
not include the entry for /, and there's nothing in docs,
in early-userspace/buffer-format.txt, about this one) -- the
same effect, endless loop when trying to umount(/initrd).

After looking at this more closely (but still "outside" the
kernel), I noticied several more "issues" (or is it the same?).
Namely, /proc/mounts contains different things when using one
of the 3 different "boot methods":

o When booting the "old way", with root=real_root, and when
/linuxrc gets executed with pid != 1, /proc/mounts contains
just one entry for root, which is the right one:
  /dev/hda1 / ext3 rw 0 0

o When booting the "new way", whth root=/dev/ram0 and /sbin/init
from initrd running with pid = 1 and doing pivot_root and execing
real /sbin/init, there are 2 entries for root in /proc/mounts:
  rootfs / rootfs rw 0 0
  /dev/hda1 / ext3 rw 0 0
or, sometimes, it is like
  rootfs / rootfs rw 0 0
  /dev/root / ext3 rw 0 0
-- this one probably is due to devfs.  (on debian with their initrd
stuff it looks even worse, something like
  rootfs / rootfs rw 0 0
  /dev2/root2 / ext3 rw 0 0
).
o And finally, when booting the "right way", using initramfs where
/init gets executed with pid=1 and should do the same pivot_root
and things like that, before the umount loop mentioned above,
it looks almost right:
  rootfs /initrd rootfs ro 0 0
  /dev/hda1 / ext3 rw 0 0
(this is where eg umount from busybox chokes, also entering
endless loop.. but tha's a different story, it's an obvious
bug in busybox.. however in order to fix it properly one have
to know which cases like the 3 mentioned above are possible).

When the "rootfs" thing enters into the game?
In which cases which lines will be present in /proc/mounts?
And, is initramfs supposed to work now?

Thank you.

/mjt
