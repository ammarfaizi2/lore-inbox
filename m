Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281248AbRKPIr5>; Fri, 16 Nov 2001 03:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281250AbRKPIrs>; Fri, 16 Nov 2001 03:47:48 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:43716 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S281248AbRKPIrd>; Fri, 16 Nov 2001 03:47:33 -0500
Date: Fri, 16 Nov 2001 09:47:29 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Sukanta Kumar Hazra <skhazra@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel compilation failed 2.4.14
In-Reply-To: <Pine.LNX.4.33L2.0111161555010.24812-200000@sukunx.localdomain>
Message-ID: <Pine.NEB.4.40.0111160947060.10846-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Sukanta Kumar Hazra wrote:

> Hi!
>
> Compiling kernel 2.4.14 on a Mandrake 8.1 failed at the linking stage. The
> output is
>
> ---------------------------------------
> ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
> mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o
> drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
> drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/ide/idedriver.o
> drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o
> drivers/video/video.o \
>         net/network.o \
>         /usr/src/linux-2.4.14/arch/i386/lib/lib.a
> /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a
> \
>         --end-group \
>         -o vmlinux
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0x9069): undefined reference to
> `deactivate_page'
> drivers/block/block.o(.text+0x9102): undefined reference to
> `deactivate_page'
> make: *** [vmlinux] Error 1
>...


This is a known bug.

The following patch fixes it:

--- linux-2.4.14-broken/drivers/block/loop.c	Thu Oct 25 13:58:34 2001
+++ linux-2.4.14/drivers/block/loop.c	Mon Nov  5 17:06:08 2001
@@ -207,7 +207,6 @@
 		index++;
 		pos += size;
 		UnlockPage(page);
-		deactivate_page(page);
 		page_cache_release(page);
 	}
 	return 0;
@@ -218,7 +217,6 @@
 	kunmap(page);
 unlock:
 	UnlockPage(page);
-	deactivate_page(page);
 	page_cache_release(page);
 fail:
 	return -1;


> Regards,
> Sukanta

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

