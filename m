Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSH1RRJ>; Wed, 28 Aug 2002 13:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSH1RRI>; Wed, 28 Aug 2002 13:17:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16631 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316213AbSH1RRH>; Wed, 28 Aug 2002 13:17:07 -0400
Date: Wed, 28 Aug 2002 19:21:23 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, Eric Sandeen <sandeen@sgi.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.32
In-Reply-To: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0208281916350.2879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.31 to v2.5.32
> ============================================
>...
> Eric Sandeen <sandeen@sgi.com>:
>   o Remove unused var and unused func from ali-ircc IrDA driver
>...


This change removes the variable "ret" but not it's use:


<--  snip -->

...
  gcc -Wp,-MD,./.ali-ircc.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2
.5.32-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-poi
nter -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=
k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=ali_ircc   -c -o
ali-ircc
.o ali-ircc.c
ali-ircc.c: In function `ali_ircc_open':
ali-ircc.c:286: `ret' undeclared (first use in this function)
ali-ircc.c:286: (Each undeclared identifier is reported only once
ali-ircc.c:286: for each function it appears in.)
...
make[3]: *** [ali-ircc.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.32-full/drivers/net/irda'

<--  snip  -->


-dj contains the following to remove the use of ret:


--- drivers/net/irda/ali-ircc.c.old	2002-08-28 19:15:38.000000000 +0200
+++ drivers/net/irda/ali-ircc.c	2002-08-28 19:15:40.000000000 +0200
@@ -283,15 +283,13 @@
         self->io.fifo_size = 16;		/* SIR: 16, FIR: 32 Benjamin 2000/11/1 */

 	/* Reserve the ioports that we need */
-	ret = check_region(self->io.fir_base, self->io.fir_ext);
-	if (ret < 0) {
+	if (!request_region(self->io.fir_base, self->io.fir_ext, driver_name)) {
 		WARNING(__FUNCTION__ "(), can't get iobase of 0x%03x\n",
 			self->io.fir_base);
 		dev_self[i] = NULL;
 		kfree(self);
 		return -ENODEV;
 	}
-	request_region(self->io.fir_base, self->io.fir_ext, driver_name);

 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


