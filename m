Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbTCNKfe>; Fri, 14 Mar 2003 05:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbTCNKfe>; Fri, 14 Mar 2003 05:35:34 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:43399 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S261438AbTCNKfc>;
	Fri, 14 Mar 2003 05:35:32 -0500
Date: Fri, 14 Mar 2003 11:46:08 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, nemesis-lists@icequake.net,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Re: matroxfb_maven not being built in 2.4.21-pre5
Message-ID: <20030314104608.GA16975@vana.vc.cvut.cz>
References: <20030314095807.C3CD5757B5@mail.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314095807.C3CD5757B5@mail.icequake.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2003 at 09:58:06AM +0000, Ryan Underwood wrote:
> 
> Hello,
> 
> I compiled a fresh 2.4.21-pre5 yesterday after using make oldconfig
> on my old .config.  Everything went smoothly for the most part,
> except the matroxfb_maven.o and matroxfb_crtc2.o were not built.
> 
> Also, there does not seem to be a menuconfig entry for CONFIG_FB_MATROX_PROC.
> Should there be?

Both Config.in and Makefile are out of sync with current matroxfb code. Config.in
is fixed in Alan's kernels, but Makefile is wrong in both (my mistake, only 2.5.50
has correct). Please apply this.
								Petr Vandrovec
								vandrove@vc.cvut.cz

diff -urN a/drivers/video/Config.in b/drivers/video/Config.in
--- a/drivers/video/Config.in	2002-11-29 00:53:15.000000000 +0100
+++ b/drivers/video/Config.in	2003-02-13 04:01:50.000000000 +0100
@@ -124,14 +124,20 @@
 	 if [ "$CONFIG_FB_MATROX" != "n" ]; then
 	    bool '    Millennium I/II support' CONFIG_FB_MATROX_MILLENIUM
 	    bool '    Mystique support' CONFIG_FB_MATROX_MYSTIQUE
-	    bool '    G100/G200/G400/G450/G550 support' CONFIG_FB_MATROX_G100
+ 	    bool '    G100/G200/G400/G450/G550 support' CONFIG_FB_MATROX_G450
+ 	    if [ "$CONFIG_FB_MATROX_G450" = "n" ]; then
+ 	       bool '    G100/G200/G400 support' CONFIG_FB_MATROX_G100A
+ 	    fi
+ 	    if [ "$CONFIG_FB_MATROX_G450" = "y" -o "$CONFIG_FB_MATROX_G100A" = "y" ]; then
+ 	       define_bool CONFIG_FB_MATROX_G100 y
+ 	    fi
             if [ "$CONFIG_I2C" != "n" ]; then
 	       dep_tristate '      Matrox I2C support' CONFIG_FB_MATROX_I2C $CONFIG_FB_MATROX $CONFIG_I2C_ALGOBIT
 	       if [ "$CONFIG_FB_MATROX_G100" = "y" ]; then
 	          dep_tristate '      G400 second head support' CONFIG_FB_MATROX_MAVEN $CONFIG_FB_MATROX_I2C
 	       fi
             fi
-            dep_tristate '      G450/G550 second head support (mandatory for G550)' CONFIG_FB_MATROX_G450 $CONFIG_FB_MATROX_G100
+            dep_tristate '    Matrox /proc interface' CONFIG_FB_MATROX_PROC $CONFIG_FB_MATROX
 	    bool '    Multihead support' CONFIG_FB_MATROX_MULTIHEAD
 	 fi
 	 tristate '  ATI Mach64 display support (EXPERIMENTAL)' CONFIG_FB_ATY
diff -urN a/drivers/video/matrox/Makefile b/drivers/video/matrox/Makefile
--- a/drivers/video/matrox/Makefile	2003-02-13 03:57:39.000000000 +0100
+++ b/drivers/video/matrox/Makefile	2003-03-14 11:39:46.000000000 +0100
@@ -12,15 +12,11 @@
 # Each configuration option enables a list of files.
 
 my-obj-$(CONFIG_FB_MATROX_G100)	  := g450_pll.o
+my-obj-$(CONFIG_FB_MATROX_G450)   += matroxfb_g450.o matroxfb_crtc2.o
 
 obj-$(CONFIG_FB_MATROX)           += matroxfb_base.o matroxfb_accel.o matroxfb_DAC1064.o matroxfb_Ti3026.o matroxfb_misc.o $(my-obj-y)
 obj-$(CONFIG_FB_MATROX_I2C)       += i2c-matroxfb.o
-ifeq ($(CONFIG_FB_MATROX_MAVEN),y)
-  obj-$(CONFIG_FB_MATROX)     += matroxfb_maven.o matroxfb_crtc2.o
-endif
-ifeq ($(CONFIG_FB_MATROX_G450),y)
-  obj-$(CONFIG_FB_MATROX)	  += matroxfb_g450.o matroxfb_crtc2.o
-endif
+obj-$(CONFIG_FB_MATROX_MAVEN)     += matroxfb_maven.o matroxfb_crtc2.o
 obj-$(CONFIG_FB_MATROX_PROC)	  += matroxfb_proc.o
 
 include $(TOPDIR)/Rules.make
