Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbTIBPTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 11:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTIBPTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 11:19:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11978 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263856AbTIBPS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 11:18:27 -0400
Date: Tue, 2 Sep 2003 17:18:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Alan Cox <alan@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] 2.4.23-pre2: fix rocket.c compilation
Message-ID: <20030902151800.GJ23729@fs.tum.de>
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 12:48:22PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
> ============================================
>...
> Alan Cox:
>...
>   o fix a missing rocket card
>...

This patch accidentially also includes one line of the "Make tty->count
atomic" patch resulting in the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/include -W
all -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=rocket  -c -o rocket.o rocket.c
rocket.c: In function `rp_close':
rocket.c:1055: error: request for member `counter' in something not a 
structure or union
make[3]: *** [rocket.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/drivers/char'

<--  snip  -->


The following patch reverts this part of the patch:

--- linux-2.4.23-pre2-full/drivers/char/rocket.c.old	2003-09-02 17:14:43.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/char/rocket.c	2003-09-02 17:15:07.000000000 +0200
@@ -1052,7 +1052,7 @@
 		restore_flags(flags);
 		return;
 	}
-	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
+	if ((tty->count == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always



Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Sat, Aug 30, 2003 at 12:48:22PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.23-pre1 to v2.4.23-pre2
> ============================================
>...
> Alan Cox:
>...
>   o fix a missing rocket card
>...

This patch accidentially also includes one line of the "Make tty->count
atomic" patch resulting in the following compile error:

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/include -W
all -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=rocket  -c -o rocket.o rocket.c
rocket.c: In function `rp_close':
rocket.c:1055: error: request for member `counter' in something not a 
structure or union
make[3]: *** [rocket.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.23-pre2-full/drivers/char'

<--  snip  -->


The following patch reverts this part of the patch:

--- linux-2.4.23-pre2-full/drivers/char/rocket.c.old	2003-09-02 17:14:43.000000000 +0200
+++ linux-2.4.23-pre2-full/drivers/char/rocket.c	2003-09-02 17:15:07.000000000 +0200
@@ -1052,7 +1052,7 @@
 		restore_flags(flags);
 		return;
 	}
-	if ((atomic_read(&tty->count) == 1) && (info->count != 1)) {
+	if ((tty->count == 1) && (info->count != 1)) {
 		/*
 		 * Uh, oh.  tty->count is 1, which means that the tty
 		 * structure will be freed.  Info->count should always



Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

