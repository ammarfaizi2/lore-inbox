Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSK3KTD>; Sat, 30 Nov 2002 05:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267230AbSK3KTD>; Sat, 30 Nov 2002 05:19:03 -0500
Received: from bagu.org ([207.139.193.3]:50705 "EHLO smog.poemfone.org")
	by vger.kernel.org with ESMTP id <S262813AbSK3KTC>;
	Sat, 30 Nov 2002 05:19:02 -0500
Date: Sat, 30 Nov 2002 05:41:53 -0500
From: "benny k." <ben@bagu.org>
To: linux-kernel@vger.kernel.org
Subject: small prob. with pcmcia Makefile in 2.4.20
Message-ID: <20021130104153.GA21939@bagu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have found a small problem with the pcmcia Makefile in 2.4.20. It seems that
drivers/net/pcmcia/smc91c92_cs.c has a dependency on drivers/net/mii.c. I played
with the Makefile and came up with the following two solutions:

1. -make the following sym. link:

ln -s drivers/net/mii.c drivers/net/pcmcia/mii.c

-apply the following patch:

--- drivers/net/pcmcia/Makefile.orig    2002-11-30 18:43:02.000000000 -0500
+++ drivers/net/pcmcia/Makefile 2002-11-30 18:49:01.000000000 -0500
@@ -12,7 +12,7 @@
 obj-           :=
 
 # Things that need to export symbols
-export-objs    := ray_cs.o
+export-objs    := ray_cs.o mii.o
 
 # 16-bit client drivers
 obj-$(CONFIG_PCMCIA_3C589)     += 3c589_cs.o
@@ -20,7 +20,7 @@
 obj-$(CONFIG_PCMCIA_FMVJ18X)   += fmvj18x_cs.o
 obj-$(CONFIG_PCMCIA_NMCLAN)    += nmclan_cs.o
 obj-$(CONFIG_PCMCIA_PCNET)     += pcnet_cs.o
-obj-$(CONFIG_PCMCIA_SMC91C92)  += smc91c92_cs.o
+obj-$(CONFIG_PCMCIA_SMC91C92)  += smc91c92_cs.o mii.o
 obj-$(CONFIG_PCMCIA_XIRC2PS)   += xirc2ps_cs.o
 obj-$(CONFIG_ARCNET_COM20020_CS)+= com20020_cs.o
 obj-$(CONFIG_PCMCIA_AXNET)     += axnet_cs.o




2. -apply the following patch:

--- drivers/net/pcmcia/Makefile.orig    2002-11-30 18:43:02.000000000 -0500
+++ drivers/net/pcmcia/Makefile 2002-11-30 18:44:46.000000000 -0500
@@ -12,7 +12,7 @@
 obj-           :=
 
 # Things that need to export symbols
-export-objs    := ray_cs.o
+export-objs    := ray_cs.o ../mii.o
 
 # 16-bit client drivers
 obj-$(CONFIG_PCMCIA_3C589)     += 3c589_cs.o
@@ -20,7 +20,7 @@
 obj-$(CONFIG_PCMCIA_FMVJ18X)   += fmvj18x_cs.o
 obj-$(CONFIG_PCMCIA_NMCLAN)    += nmclan_cs.o
 obj-$(CONFIG_PCMCIA_PCNET)     += pcnet_cs.o
-obj-$(CONFIG_PCMCIA_SMC91C92)  += smc91c92_cs.o
+obj-$(CONFIG_PCMCIA_SMC91C92)  += smc91c92_cs.o mii.o
 obj-$(CONFIG_PCMCIA_XIRC2PS)   += xirc2ps_cs.o
 obj-$(CONFIG_ARCNET_COM20020_CS)+= com20020_cs.o
 obj-$(CONFIG_PCMCIA_AXNET)     += axnet_cs.o


 
The problem with these solutions is that if a PCI card that uses mii.c
is selected along with smc91c92_cs.c than two copies of mii.o will be
built. I don't know what will happen if the driver is built into the
kernel. I can't seem to find a solution that fixes this problem. It
seems to me that this problem exists because mii.c is in a different
directory. 

Does anyone have any suggestions on how to fix this?

Please cc me as I'm not on the list. 

Ben
