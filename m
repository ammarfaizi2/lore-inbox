Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130184AbRB1OZb>; Wed, 28 Feb 2001 09:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbRB1OZV>; Wed, 28 Feb 2001 09:25:21 -0500
Received: from front1.grolier.fr ([194.158.96.51]:53928 "EHLO
	front1.grolier.fr") by vger.kernel.org with ESMTP
	id <S130184AbRB1OZJ>; Wed, 28 Feb 2001 09:25:09 -0500
Message-ID: <3A9D0A6B.2005DE8E@club-internet.fr>
Date: Wed, 28 Feb 2001 15:25:47 +0100
From: Jérôme Augé <jauge@club-internet.fr>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "Rob W. van Swol" <vanswol@nlr.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: opl3sa2 won't load in kernel 2.4.2
In-Reply-To: <3A9CEED6.C68D3FFD@nlr.nl>
Content-Type: multipart/mixed;
 boundary="------------793A1CEBA8153DAE8A054D1F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------793A1CEBA8153DAE8A054D1F
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

"Rob W. van Swol" wrote:
> 
> Hi,
> 
> I cannot find an answer to my problem. Sound was always working ok in
> 2.2.x and 2.4.1 kernels. But now the opl3sa2 module won't load anymore.
> First I got the messages:
> 
> opl3sa2: No cards found
> opl3sa2: 0 PnP card(s) found.
> 
> The I added isapnp=0 to the options line in /etc/modules.conf and then I
> get:
> 
> opl3sa2: Control I/O port 0x0 not free
>                           ^^^
> It seems that the io address is not correctly passed to the module?!
> 

I got the same problem and i think there is an error in opl3sa2.c ?
I thinnk the problem is in the init_opl3sa2() function, in this line :

if(!isapnp && io == -1 ) {

If you don't use/have IsaPNP then the cfg[card] struct is not/never
initialized ... ?

I made a quick patch that correct this test ... but I think we should
find a better way to choose between initializing the cfg[card] struct
using opl3sa2_isapnp_probe or using the user suplied module parameters
... no ?

-- 
Jérôme Augé
echo cdqgm@vnqb-hklmpkml.yp | tr khplmndvqyc nirtelacufj
--------------793A1CEBA8153DAE8A054D1F
Content-Type: text/plain; charset=us-ascii;
 name="opl3sa2-isapnp-io-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opl3sa2-isapnp-io-test.patch"

--- opl3sa2.c.orig	Wed Feb 28 14:44:03 2001
+++ opl3sa2.c	Wed Feb 28 14:48:07 2001
@@ -914,13 +914,8 @@
 #endif
 		/* If a user wants an I/O then assume they meant it */
 		
-		if(!isapnp && io == -1 ) {
-			if(io == -1 || irq == -1 || dma == -1 ||
-			   dma2 == -1 || mss_io == -1) {
-				printk(KERN_ERR
-				       "opl3sa2: io, mss_io, irq, dma, and dma2 must be set\n");
-				return -EINVAL;
-			}
+		if((io != -1) && (irq != -1) && (dma != -1) &&
+			(dma2 != -1) && (mss_io != -1) && (mpu_io !=-1)) {
 
 			/*
 			 * Our own config:
@@ -948,6 +943,9 @@
 			opl3sa2_clear_slots(&cfg[card]);
 			opl3sa2_clear_slots(&cfg_mss[card]);
 			opl3sa2_clear_slots(&cfg_mpu[card]);
+		} else {
+			printk(KERN_ERR "opl3sa2: io, mss_io, irq, dma, and dma2 must be set\n");
+			return -EINVAL;
 		}
 
 		if(!probe_opl3sa2(&cfg[card], card) ||

--------------793A1CEBA8153DAE8A054D1F--

