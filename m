Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSB0DAi>; Tue, 26 Feb 2002 22:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSB0DA3>; Tue, 26 Feb 2002 22:00:29 -0500
Received: from mx1.fuse.net ([216.68.2.90]:38090 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S291766AbSB0DAQ>;
	Tue, 26 Feb 2002 22:00:16 -0500
Message-ID: <3C7C4BBF.2020505@fuse.net>
Date: Tue, 26 Feb 2002 22:00:15 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020203
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.5-dj2 compile failures
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First the good news - it built the ALSA modules correctly this time around.

And I suspect these are trivial fixes:
    USB storage fails by trying to reference "address" member of a 
scatterlist, which has a vdma_address (MIPS) or a dma_address (x86) 
(didn't check others).
        USB Mass Storage is modular, all sub drivers selected.

        This affects datafab.c and jumpshot.c.

gcc -D__KERNEL__ 
-I/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.5-dj2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.5-dj2/include/linux/modversions.h 
-I../../scsi/ -DKBUILD_BASENAME=datafab  -c -o datafab.o datafab.c
datafab.c: In function `datafab_read_data':
datafab.c:260: structure has no member named `address'
datafab.c:261: structure has no member named `address'
datafab.c:269: structure has no member named `address'
datafab.c:270: structure has no member named `address'
datafab.c: In function `datafab_write_data':
datafab.c:351: structure has no member named `address'
datafab.c:351: structure has no member named `address'
datafab.c:360: structure has no member named `address'
datafab.c:360: structure has no member named `address'
make[3]: *** [datafab.o] Error 1
make[3]: Leaving directory 
`/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.5-dj2/drivers/usb/storage'
make[2]: *** [_modsubdir_storage] Error 2
make[2]: Leaving directory 
`/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.5-dj2/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory 
`/home/expsoft/src/linux-kernel/linux-2.5/linux-2.5.5-dj2/drivers'
make: *** [_mod_drivers] Error 2

    Some FSs seem to have trouble with dparent_lock - fatfs.o, at least, 
caused depmod to say "undefined symbol."
        I believe the following patch fixes it.

--- dcache.c.old        Tue Feb 26 21:55:53 2002
+++ dcache.c    Tue Feb 26 21:56:59 2002
@@ -31,6 +31,7 @@

 spinlock_t dcache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 rwlock_t dparent_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
+EXPORT_SYMBOL(dparent_lock);

 /* Right now the dcache depends on the kernel lock */
 #define check_lock()   if (!kernel_locked()) BUG()



--Nathan


