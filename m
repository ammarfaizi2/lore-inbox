Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbTCZMeR>; Wed, 26 Mar 2003 07:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbTCZMeR>; Wed, 26 Mar 2003 07:34:17 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1474 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261651AbTCZMeQ>; Wed, 26 Mar 2003 07:34:16 -0500
Date: Wed, 26 Mar 2003 13:45:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@sgi.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Corey Minyard <minyard@mvista.com>
Subject: [2.5 patch] fix ipmi_devintf.c compilation
Message-ID: <20030326124523.GO24744@fs.tum.de>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 03:26:47PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.65 to v2.5.66
> ============================================
>...
> Christoph Hellwig <hch@sgi.com>:
>...
>   o misc devfs_register cleanups
>...


This patch broke the compilation of drivers/char/ipmi/ipmi_devintf.c:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/char/ipmi/.ipmi_devintf.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default 
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=ipmi_devintf 
-DKBUILD_MODNAME=ipmi_devintf -c -o drivers/char/ipmi/ipmi_devintf.o 
drivers/char/ipmi/ipmi_devintf.c
drivers/char/ipmi/ipmi_devintf.c: In function `ipmi_new_smi':
drivers/char/ipmi/ipmi_devintf.c:452: warning: implicit declaration of 
function `snprinf'
...
... -o .tmp_vmlinux1
...
drivers/built-in.o(.text+0x142824): In function `ipmi_new_smi':
: undefined reference to `snprinf'
...
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Trivial fix:


--- linux-2.5.66-notfull/drivers/char/ipmi/ipmi_devintf.c.old	2003-03-26 13:34:17.000000000 +0100
+++ linux-2.5.66-notfull/drivers/char/ipmi/ipmi_devintf.c	2003-03-26 13:34:34.000000000 +0100
@@ -449,7 +449,7 @@
 	if (if_num > MAX_DEVICES)
 		return;
 
-	snprinf(name, sizeof(name), "ipmidev/%d", if_num);
+	snprintf(name, sizeof(name), "ipmidev/%d", if_num);
 
 	handles[if_num] = devfs_register(NULL, name, DEVFS_FL_NONE,
 					 ipmi_major, if_num,



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

