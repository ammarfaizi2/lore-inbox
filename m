Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSLUXp2>; Sat, 21 Dec 2002 18:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSLUXp2>; Sat, 21 Dec 2002 18:45:28 -0500
Received: from services.cam.org ([198.73.180.252]:31038 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S265650AbSLUXp1>;
	Sat, 21 Dec 2002 18:45:27 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] compile error mtrr/if.c
Date: Sat, 21 Dec 2002 18:53:26 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212211853.26554.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this compiling from bk current (Dec 21):

make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mtrr
  gcc -Wp,-MD,arch/i386/kernel/cpu/mtrr/.if.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=if -DKBUILD_MODNAME=if   -c -o arch/i386/kernel/cpu/mtrr/if.o arch/i386/kernel/cpu/mtrr/if.c
arch/i386/kernel/cpu/mtrr/if.c:306: duplicate initializer
arch/i386/kernel/cpu/mtrr/if.c:306: (near initialization for `mtrr_fops.release')
make[4]: *** [arch/i386/kernel/cpu/mtrr/if.o] Error 1
make[3]: *** [arch/i386/kernel/cpu/mtrr] Error 2
make[2]: *** [arch/i386/kernel/cpu] Error 2
make[1]: *** [arch/i386/kernel] Error 2
make: *** [vmlinux] Error 2
oscar% vi arch/i386/kernel/cpu/mtrr/if.c

which is caused by:

static struct file_operations mtrr_fops = {
        .owner   = THIS_MODULE,
        .open    = mtrr_open,
        .read    = seq_read,
        .llseek  = seq_lseek,
        .release = single_release,
        .write   = mtrr_write,
        .ioctl   = mtrr_ioctl,
        .release = mtrr_close,
};

single_release is called in mtrr_close so I would guess that removing 
".release = single_release," is the way to go (it compiles).  Assuming
this is correct here is the patch.

----------
diff -Nru a/arch/i386/kernel/cpu/mtrr/if.c b/arch/i386/kernel/cpu/mtrr/if.c
--- a/arch/i386/kernel/cpu/mtrr/if.c    Sat Dec 21 18:52:05 2002
+++ b/arch/i386/kernel/cpu/mtrr/if.c    Sat Dec 21 18:52:05 2002
@@ -300,7 +300,6 @@
        .open    = mtrr_open,
        .read    = seq_read,
        .llseek  = seq_lseek,
-       .release = single_release,
        .write   = mtrr_write,
        .ioctl   = mtrr_ioctl,
        .release = mtrr_close,
----------

TIA,
Ed Tomlinson
