Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRKFFrv>; Tue, 6 Nov 2001 00:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277094AbRKFFrk>; Tue, 6 Nov 2001 00:47:40 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:753 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S277012AbRKFFrc>; Tue, 6 Nov 2001 00:47:32 -0500
Message-ID: <3BE7796C.7DB78BC@polymtl.ca>
Date: Tue, 06 Nov 2001 00:47:24 -0500
From: Christian Robert <christian.robert@polymtl.ca>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: fr-CA, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Christian Robert <christian.robert@polymtl.ca>
Subject: unable to compile kernel 2.4.14, error missing `deactivate_page' in 
 final link
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o memcpy.o memcpy.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.14/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o strstr.o strstr.c
rm -f lib.a
ar  rcs lib.a checksum.o old-checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o
make[2]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux-2.4.14/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux-2.4.14/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o drivers/usb/usbdrv.o drivers/i2c/i2c.o drivers/md/mddev.o \
        net/network.o \
        /usr/src/linux-2.4.14/arch/i386/lib/lib.a /usr/src/linux-2.4.14/lib/lib.a /usr/src/linux-2.4.14/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/block/block.o: In function `lo_send':
drivers/block/block.o(.text+0xa35f): undefined reference to `deactivate_page'
drivers/block/block.o(.text+0xa3a9): undefined reference to `deactivate_page'
make: *** [vmlinux] Error 1
[root@X-home:/usr/src/linux] # 

----------------------------------------------------------------------------------------------------------

from the ftp://ftp.kernel.org/pub/linux/kernel/v2.4/patch-2.4.14.gz

----------------------------------------------------------------------------------------------------------
[...]
diff -u --recursive --new-file v2.4.13/linux/include/linux/swap.h linux/include/linux/swap.h
--- v2.4.13/linux/include/linux/swap.h  Tue Oct 23 22:48:53 2001
+++ linux/include/linux/swap.h  Mon Nov  5 12:42:13 2001
@@ -79,6 +79,10 @@
 };
 
 extern int nr_swap_pages;
+
+/* Swap 50% full? Release swapcache more aggressively.. */
+#define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
+
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);
 extern int nr_active_pages;
@@ -101,7 +105,6 @@
 extern void FASTCALL(__lru_cache_del(struct page *));
 extern void FASTCALL(lru_cache_del(struct page *));
 
-extern void FASTCALL(deactivate_page(struct page *));
 extern void FASTCALL(activate_page(struct page *));
 
 extern void swap_setup(void);
@@ -129,8 +132,7 @@
 extern struct page * read_swap_cache_async(swp_entry_t);
 
 /* linux/mm/oom_kill.c */
-extern int out_of_memory(void);
-extern void oom_kill(void);
+extern void out_of_memory(void);
 
 /* linux/mm/swapfile.c */
[...]
----------------------------------------------------------------------------------------------------------

but drivers/block/loop.c still has references to "deactivate_page()"

Xtian.
