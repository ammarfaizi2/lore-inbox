Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTGFKs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 06:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTGFKs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 06:48:56 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:39947 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261876AbTGFKsy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 06:48:54 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "=?iso-8859-2?q?Rafa=B3=20'rmrmg'=20Roszak?=" <rmrmg@wp.pl>
Subject: Re: [PATCH 2.4.21-bk1] isdn_ppp compile warning fix
Date: Sun, 6 Jul 2003 12:42:19 +0200
User-Agent: KMail/1.5.2
References: <200307052058.55539.fsdeveloper@yahoo.de> <20030706113047.10a59491.rmrmg@wp.pl>
In-Reply-To: <20030706113047.10a59491.rmrmg@wp.pl>
Cc: kai.germaschewski@gmx.de, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307061242.28691.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 06 July 2003 11:30, Rafa³ 'rmrmg' Roszak wrote:
> begin  Michael Buesch <fsdeveloper@yahoo.de> quote:
> >fixes these warnings:
> >isdn_ppp.c: In function `isdn_ppp_free':
> >isdn_ppp.c:114: Warnung: concatenation of string literals with
>
> [root@slack:/usr/src/linux-2.4.21-bk1#] make bzImage
> [...]
>
> ld -m elf_i386 -T /usr/src/linux-2.4.21-bk1/arch/i386/vmlinux.lds -e
> stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o init/do_mounts.o \	--start-group \
> 	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o
> fs/fs.o ipc/ipc.o \	 drivers/char/char.o drivers/block/block.o
> drivers/misc/misc.o drivers/net/net.o drivers/char/drm/drm.o
> drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o
> drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o
> drivers/media/media.o drivers/isdn/vmlinux-obj.o \	net/network.o \
> 	/usr/src/linux-2.4.21-bk1/arch/i386/lib/lib.a
> /usr/src/linux-2.4.21-bk1/lib/lib.a
> /usr/src/linux-2.4.21-bk1/arch/i386/lib/lib.a \	--end-group \
> 	-o vmlinux
>
> arch/i386/kernel/kernel.o(.text+0x6f7d): In function `sys_ipc':
> : undefined reference to `sys_semtimedop'
>
> make: *** [vmlinux] B³±d 1
>
> System: Slackware 9.0 with gcc-3.2.3
> config in attachment

This has nothing to do with my patch, but I've seen this
error on my system, too.
I've looked a long time over the code, but I couldn't find a
solution.
Seems, that sys_semtimedop() is never defined. (I haven't found
a definition). This error was introduced in bk1 by these changes:

- --- /usr/src/linux/arch/i386/kernel/sys_i386.c  2001-03-19 21:35:09.000000000 +0100
+++ /home/mb/linuxtest/linux-2.4.21/arch/i386/kernel/sys_i386.c 2003-07-05 20:25:55.000000000 +0200
@@ -139,7 +139,10 @@
 
        switch (call) {
        case SEMOP:
- -               return sys_semop (first, (struct sembuf *)ptr, second);
+               return sys_semtimedop (first, (struct sembuf *)ptr, second, NULL);
+       case SEMTIMEDOP:
+               return sys_semtimedop (first, (struct sembuf *)ptr, second, 
+                                      (const struct timespec *)fifth);
        case SEMGET:
                return sys_semget (first, second, third);
        case SEMCTL: {
@@ -200,7 +203,7 @@
                return sys_shmctl (first, second,
                                   (struct shmid_ds *) ptr);
        default:
- -               return -EINVAL;
+               return -ENOSYS;
        }
 }

Who made these changes?

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 12:37:41 up 47 min,  1 user,  load average: 1.04, 1.08, 1.01

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/B/0UoxoigfggmSgRAlsoAJ9xKY0RZsFABzHDFDs2Egtu4VfvZwCfQ4HD
nGvT7CGmV/reSTyRJ2Qk/WQ=
=Ex3R
-----END PGP SIGNATURE-----

