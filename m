Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261977AbSI3JZD>; Mon, 30 Sep 2002 05:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261982AbSI3JZD>; Mon, 30 Sep 2002 05:25:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32975 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261977AbSI3JZC>; Mon, 30 Sep 2002 05:25:02 -0400
Date: Mon, 30 Sep 2002 11:30:23 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [-dj patch] fix compilation with CONFIG_IKCONFIG
Message-ID: <Pine.NEB.4.44.0209301121400.12605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

compilation of CONFIG_IKCONFIG is broken in 2.5.39-dj2:

<--  snip  -->

...
  gcc -Wp,-MD,./.suspend.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6
-I/home/bunk/linux/kernel-2.5/linux-2.5.39-full/arch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=suspend   -c -o
suspend.o suspend.c
suspend.c:293: warning: #warning This might be broken. We need to somehow
wait for data to reach the disk
suspend.c: In function `bdev_write_page':
suspend.c:1040: warning: control reaches end of non-void function
make[1]: *** No rule to make target `configs.o', needed by `built-in.o'.
Stop.
make[1]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.39-full/kernel'

<--  snip  -->


It seems the following part of 2.5.30-dj1 got lost (it applies with a few
lines offset):


--- linux-2.5.30/kernel/Makefile	2002-08-01 22:16:13.000000000 +0100
+++ linux-2.5/kernel/Makefile	2002-08-02 15:51:08.000000000 +0100
@@ -34,3 +36,14 @@ CFLAGS_sched.o := $(PROFILING) -fno-omit
 endif

 include $(TOPDIR)/Rules.make
+
+configs.o: $(TOPDIR)/scripts/mkconfigs configs.c
+	echo obj-y == $(obj-y)
+	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DEXPORT_SYMTAB -c -o configs.o configs.c
+
+$(TOPDIR)/scripts/mkconfigs: $(TOPDIR)/scripts/mkconfigs.c
+	$(HOSTCC) $(HOSTCFLAGS) -o $(TOPDIR)/scripts/mkconfigs $(TOPDIR)/scripts/mkconfigs.c
+
+configs.c: $(TOPDIR)/.config $(TOPDIR)/scripts/mkconfigs
+	$(TOPDIR)/scripts/mkconfigs $(TOPDIR)/.config configs.c
+


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




