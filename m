Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbSJ1MAd>; Mon, 28 Oct 2002 07:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262291AbSJ1MAd>; Mon, 28 Oct 2002 07:00:33 -0500
Received: from 80-25-137-228.uc.nombres.ttd.es ([80.25.137.228]:10448 "EHLO
	cexter.suinsa") by vger.kernel.org with ESMTP id <S262187AbSJ1MAc>;
	Mon, 28 Oct 2002 07:00:32 -0500
Subject: RAM root file system
From: juanba <juanba@suinsa.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 28 Oct 2002 13:06:15 +0100
Message-Id: <1035806806.28963.133.camel@tau>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to build a boot image which contains itself the kernel and
the root file system. In a first approach i will use lilo as loader
cause i am using my latop as test-host. I am not planning to pass
parametters to the kernel, the stuff will be deeply embbeded in the
future. So all the parameters setup should be pre-made with rdev an so
on.

Which approaches could be taken?
Should i use the initrd stuff? Is it mandatory?

I am following the Linux Bootdisk but i can not find my attached crfs
image. I have seen  i have printked in the rd.c module the values of my.
This is the proccess that i have followed

- compressed-kernel-image 
[root@tau root-fs]# ls -s bzImage-rt3.1-nodiskbzImage-rt3.1 
 996 bzImage-rt3.1
- i will left 50 free blocks so the file will have the crfs at the block
1046
- to build the crfs i think that a raw 8Mbytes file is enough 
[root@tau root-fs]# dd if=/dev/zero of=e2rfs_test.img bs=1k count=8192
[root@tau root-fs]# mke2fs e2rfs_test.img
[root@tau root-fs]# mount -o loop e2rfs_test.img mount/

And fill the file structure /sbin, /bin, ans so forth 

[root@tau root-fs]# ummount /mount
[root@tau root-fs]# gzip -v9 e2rfs_test.img

- Kernel/Image configuration
The magic number for redev 17430 = 1046 + 2^14
[root@tau root-fs]# rdev -r bzImage-rt3.1-nodisk 17430
[root@tau root-fs]# rdev bzImage-rt3.1-nodisk /dev/ram0

- Join Kernel/customized crfs
[root@tau root-fs]# cp bzImage-rt3.1-nodisk boot-rt3.1-nodisk.img
[root@tau root-fs]# dd if=e2rfs_test.img.gz of=boot-rt3.1-nodisk.img
bs=1k seek=1046

- So boot-rt3.1-nodisk.img have all the stuff
- The Lilo stuff
/etc/lilo.conf extract 

image=/boot/boot-rt3.1-nodisk.img
        label=linux-rt3.1-nodisk
        append=" devfs=mount"
        read-only

[root@tau root-fs]# cp boot-rt3.1-nodisk.img /boot
[root@tau root-fs]# lilo

and all seems ok, lilo downloads the info to my master boot record
reboot and ..

cramfs:wrong magic
Kernel Panic: VFS: Unable to mount root fs on 01:00

which corresponds with /dev/ram0

Any Hints??


