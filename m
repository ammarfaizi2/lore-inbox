Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315944AbSEGTAS>; Tue, 7 May 2002 15:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315945AbSEGTAR>; Tue, 7 May 2002 15:00:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:37115 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315944AbSEGTAP>; Tue, 7 May 2002 15:00:15 -0400
Date: Tue, 7 May 2002 20:55:25 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [patch] #include <linux/pagemap.h> in fs/partitions/check.h
Message-ID: <Pine.NEB.4.44.0205072048460.9347-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

fs/partitions/check.h uses page_cache_release that is

  #define page_cache_release(x)   __free_page(x)

in linux/pagemap.h but check.h doesn't include this file. This resulted in
the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-modular/include -Wall
-Wstr
ict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mprefe
rred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.
4/include -DKBUILD_BASENAME=acorn  -c -o acorn.o acorn.c
In file included from acorn.c:21:
check.h: In function `put_dev_sector':
check.h:13: warning: implicit declaration of function `page_cache_release'
...
ld -m elf_i386 -T
/home/bunk/linux/kernel-2.4/linux-modular/arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/char/char.o drivers/block/block.o
drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
drivers/char/drm/drm.o drivers/net/fc/fc.o
drivers/net/appletalk/appletalk.o drivers/net/tokenring/tr.o
drivers/net/wan/wan.o drivers/atm/atm.o drivers/cdrom/driver.o
drivers/pci/driver.o drivers/net/pcmcia/pcmcia_net.o
drivers/net/wireless/wireless_net.o drivers/video/video.o
drivers/net/hamradio/hamradio.o drivers/md/mddev.o
drivers/isdn/vmlinux-obj.o arch/i386/math-emu/math.o \
        net/network.o \
        /home/bunk/linux/kernel-2.4/linux-modular/arch/i386/lib/lib.a
/home/bunk/linux/kernel-2.4/linux-modular/lib/lib.a
/home/bunk/linux/kernel-2.4/linux-modular/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `riscix_partition':
fs/fs.o(.text+0x2810b): undefined reference to `page_cache_release'
fs/fs.o: In function `linux_partition':
fs/fs.o(.text+0x281d0): undefined reference to `page_cache_release'
fs/fs.o: In function `adfspart_check_ADFS':
fs/fs.o(.text+0x28238): undefined reference to `page_cache_release'
fs/fs.o(.text+0x28281): undefined reference to `page_cache_release'
fs/fs.o: In function `adfspart_check_ICSLinux':
fs/fs.o(.text+0x28371): undefined reference to `page_cache_release'
fs/fs.o(.text+0x283e7): more undefined references to `page_cache_release'
follow
make: *** [vmlinux] Error 1
...

<--  snip  -->


The fix is simple:


--- fs/partitions/check.h.old	Tue May  7 20:46:21 2002
+++ fs/partitions/check.h	Tue May  7 20:47:01 2002
@@ -2,6 +2,9 @@
  * add_partition adds a partitions details to the devices partition
  * description.
  */
+
+#include <linux/pagemap.h>
+
 void add_gd_partition(struct gendisk *hd, int minor, int start, int size);

 typedef struct {struct page *v;} Sector;



cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

