Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTKVXxf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 18:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTKVXxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 18:53:35 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:4871 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262940AbTKVXxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 18:53:32 -0500
Date: Sun, 23 Nov 2003 10:53:23 +1100
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I810_AUDIO] 8/x: Remove divides on playback
Message-ID: <20031122235323.GA9326@gondor.apana.org.au>
References: <20031122070931.GA27231@gondor.apana.org.au> <20031122071345.GA27303@gondor.apana.org.au> <20031122071935.GA27371@gondor.apana.org.au> <20031122082227.GA27692@gondor.apana.org.au> <20031122082635.GA27752@gondor.apana.org.au> <20031122083912.GA27884@gondor.apana.org.au> <20031122235101.GA9276@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20031122235101.GA9276@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch removes a couple of divides on the playback path.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p8

Index: kernel-source-2.4/drivers/sound/i810_audio.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/sound/i810_audio.c,v
retrieving revision 1.15
diff -u -r1.15 i810_audio.c
--- kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 23:51:09 -0000	1.15
+++ kernel-source-2.4/drivers/sound/i810_audio.c	22 Nov 2003 23:51:29 -0000
@@ -100,6 +100,7 @@
 #include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/wrapper.h>
+#include <linux/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
 
@@ -990,6 +991,7 @@
 	dmabuf->numfrag = SG_LEN;
 	dmabuf->fragsize = dmabuf->dmasize/dmabuf->numfrag;
 	dmabuf->fragsamples = dmabuf->fragsize >> 1;
+	dmabuf->fragshift = ffs(dmabuf->fragsize) - 1;
 	dmabuf->userfragsize = dmabuf->ossfragsize;
 	dmabuf->userfrags = dmabuf->dmasize/dmabuf->ossfragsize;
 
@@ -997,16 +999,12 @@
 
 	if(dmabuf->ossmaxfrags == 4) {
 		fragint = 8;
-		dmabuf->fragshift = 2;
 	} else if (dmabuf->ossmaxfrags == 8) {
 		fragint = 4;
-		dmabuf->fragshift = 3;
 	} else if (dmabuf->ossmaxfrags == 16) {
 		fragint = 2;
-		dmabuf->fragshift = 4;
 	} else {
 		fragint = 1;
-		dmabuf->fragshift = 5;
 	}
 	/*
 	 *	Now set up the ring 
@@ -1103,7 +1101,7 @@
 
 	/* MASKP2(swptr, fragsize) - 1 is the tail of our transfer */
 	x = MODULOP2(MASKP2(dmabuf->swptr, fragsize) - 1, dmabuf->dmasize);
-	x /= fragsize;
+	x >>= dmabuf->fragshift;
 	outb(x, port + OFF_LVI);
 }
 
@@ -1697,7 +1695,7 @@
 			goto ret;
 		}
 
-		swptr = (swptr + cnt) % dmabuf->dmasize;
+		swptr = MODULOP2(swptr + cnt, dmabuf->dmasize);
 
 		spin_lock_irqsave(&state->card->lock, flags);
                 if (PM_SUSPENDED(card)) {

--C7zPtVaVf+AK4Oqc--
