Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264823AbSJVTxI>; Tue, 22 Oct 2002 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbSJVTxH>; Tue, 22 Oct 2002 15:53:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61431 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264813AbSJVTwe>; Tue, 22 Oct 2002 15:52:34 -0400
Date: Tue, 22 Oct 2002 21:58:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>, Krzysztof Halasa <khc@pm.waw.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac1
In-Reply-To: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0210222147230.1359-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002, Alan Cox wrote:

>...
> Linux 2.5.44-ac1
>...
> o	Clean up wan ioctl structures			(Krzysztof Halasa)
>...

This caused the following compile error:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/wan/.hdlc_x25.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=hdlc_x25   -c -o
drivers/net/wan/hdlc_x25.o drivers/net/wan/hdlc_x25.c
drivers/net/wan/hdlc_x25.c: In function `hdlc_x25_ioctl':
drivers/net/wan/hdlc_x25.c:187: invalid type argument of `->'
drivers/net/wan/hdlc_x25.c:189: invalid type argument of `->'
drivers/net/wan/hdlc_x25.c:190: warning: unreachable code at beginning of
switch statement
make[3]: *** [drivers/net/wan/hdlc_x25.o] Error 1

<--  snip  -->


The follwing patch seems to fix it:


--- linux-2.5.44-full-ac/drivers/net/wan/hdlc_x25.c.old	2002-10-22 21:38:32.000000000 +0200
+++ linux-2.5.44-full-ac/drivers/net/wan/hdlc_x25.c	2002-10-22 21:38:51.000000000 +0200
@@ -184,9 +184,9 @@
 	struct net_device *dev = hdlc_to_dev(hdlc);
 	int result;

-	switch (ifr->ifr_settings->type) {
+	switch (ifr->ifr_settings.type) {
 	case IF_GET_PROTO:
-		ifr->ifr_settings->type = IF_PROTO_X25;
+		ifr->ifr_settings.type = IF_PROTO_X25;
 		return 0; /* return protocol only, no settable parameters */

 	case IF_PROTO_X25:


The next compile error is in a file that seems to need a bit more work:


<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/wan/.pc300_drv.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6
-Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=pc300_drv   -c -o
drivers/net/wan/pc300_drv.o drivers/net/wan/pc300_drv.c
drivers/net/wan/pc300_drv.c: In function `cpc_ioctl':
drivers/net/wan/pc300_drv.c:2545: invalid type argument of `->'
drivers/net/wan/pc300_drv.c:2744: invalid type argument of `->'
drivers/net/wan/pc300_drv.c:2748: invalid type argument of `->'
drivers/net/wan/pc300_drv.c:2776: invalid type argument of `->'
drivers/net/wan/pc300_drv.c:2799: invalid type argument of `->'
drivers/net/wan/pc300_drv.c:2747: warning: unreachable code at beginning
of switch statement
make[3]: *** [drivers/net/wan/pc300_drv.o] Error 1

<--  snip  -->

cu
Adrian

-- 

               "Is there not promise of rain?" Ling Tan asked suddenly out
                of the darkness. There had been need of rain for many days.
               "Only a promise," Lao Er said.
                                               Pearl S. Buck - Dragon Seed


