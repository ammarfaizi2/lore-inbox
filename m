Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261579AbSJIMJ1>; Wed, 9 Oct 2002 08:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSJIMJ1>; Wed, 9 Oct 2002 08:09:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60890 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261579AbSJIMJX>; Wed, 9 Oct 2002 08:09:23 -0400
Date: Wed, 9 Oct 2002 14:15:02 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Rob Landley <landley@trommello.org>, <linux-scsi@vger.kernel.org>
cc: Matt Porter <porter@cox.net>, <linux-kernel@vger.kernel.org>
Subject: [patch] show Fusion MPT dialog only when CONFIG_BLK_DEV_SD is set
In-Reply-To: <Pine.NEB.4.44.0210091335450.8340-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.NEB.4.44.0210091354300.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Adrian Bunk wrote:

> On Tue, 8 Oct 2002, Rob Landley wrote:
>
> >...
> > Go into make menuconfig in 2.4.19.  Switch off "scsi support".  Back to the
> > main menu, try to descend into "fusion mpt device support".  The menu still
> > shows up (at the top level, I might add), but you can't go into it.
> >
> > That's been broken for over a year now.  It's in the top level of menuconfig.
> >  I first reported it back around 2.4.6 or so.  It just doesn't get in
> > anybody's way, and that area of code is a mess, and not fixing it isn't
> > embarassing anybody specific.
> >...
>
> I assume the patch below fixes this for i386 (similar patches are needed
> for at most four other architectures)?
>...

Thinking about it the following is perhaps a better solution since the
fix is now in the arch-independent part.

This patch includes the following changes:
- offer the menu only when CONFIG_SCSI and CONFIG_BLK_DEV_SD are set
- remove an obsolete comment (the force to module or nothing was already
  implemented)
- remove a workaround for pre-linux-2.2.15 kernels
- indentation

It applys against 2.4.20-pre9 and 2.5.41.

Tested with "make menuconfig" and "make xconfig" in 2.4.20-pre9.

cu
Adrian


--- linux-2.4.19/drivers/message/fusion/Config.in.old	2002-10-09 13:52:33.000000000 +0200
+++ linux-2.4.19/drivers/message/fusion/Config.in	2002-10-09 14:09:28.000000000 +0200
@@ -1,37 +1,37 @@
-mainmenu_option next_comment
-comment 'Fusion MPT device support'
+if [ "$CONFIG_SCSI" != "n" ]; then
+   if [ "$CONFIG_BLK_DEV_SD" != "n" ]; then
+      mainmenu_option next_comment
+      comment 'Fusion MPT device support'
+
+      dep_tristate "Fusion MPT (base + ScsiHost) drivers" CONFIG_FUSION $CONFIG_SCSI $CONFIG_BLK_DEV_SD
+
+      if [ "$CONFIG_FUSION" = "y" -o "$CONFIG_FUSION" = "m" ]; then
+
+        if [ "$CONFIG_BLK_DEV_SD" = "y" -a "$CONFIG_FUSION" = "y" ]; then
+          define_bool CONFIG_FUSION_BOOT y
+        else
+          define_bool CONFIG_FUSION_BOOT n
+        fi
+
+        if [ "$CONFIG_MODULES" = "y" ]; then
+          dep_tristate "  Enhanced SCSI error reporting" CONFIG_FUSION_ISENSE $CONFIG_FUSION m
+          dep_tristate "  Fusion MPT misc device (ioctl) driver" CONFIG_FUSION_CTL $CONFIG_FUSION m
+        fi
+
+        dep_tristate "  Fusion MPT LAN driver" CONFIG_FUSION_LAN $CONFIG_FUSION $CONFIG_NET
+        if [ "$CONFIG_FUSION_LAN" != "n" ]; then
+          define_bool CONFIG_NET_FC y
+        fi
+
+      else
+
+        define_bool CONFIG_FUSION_BOOT n
+        define_tristate CONFIG_FUSION_ISENSE n
+        define_tristate CONFIG_FUSION_CTL n
+        define_tristate CONFIG_FUSION_LAN n

-dep_tristate "Fusion MPT (base + ScsiHost) drivers" CONFIG_FUSION $CONFIG_SCSI $CONFIG_BLK_DEV_SD
-
-if [ "$CONFIG_FUSION" = "y" -o "$CONFIG_FUSION" = "m" ]; then
-
-  if [ "$CONFIG_BLK_DEV_SD" = "y" -a "$CONFIG_FUSION" = "y" ]; then
-    define_bool CONFIG_FUSION_BOOT y
-  else
-    define_bool CONFIG_FUSION_BOOT n
-  fi
-
-  if [ "$CONFIG_MODULES" = "y" ]; then
-    #  How can we force these options to module or nothing?
-    dep_tristate "  Enhanced SCSI error reporting" CONFIG_FUSION_ISENSE $CONFIG_FUSION m
-    dep_tristate "  Fusion MPT misc device (ioctl) driver" CONFIG_FUSION_CTL $CONFIG_FUSION m
-  fi
-
-  dep_tristate "  Fusion MPT LAN driver" CONFIG_FUSION_LAN $CONFIG_FUSION $CONFIG_NET
-  if [ "$CONFIG_FUSION_LAN" != "n" ]; then
-    define_bool CONFIG_NET_FC y
-  fi
-
-else
-
-  define_bool CONFIG_FUSION_BOOT n
-  # These <should> be define_tristate, but we leave them define_bool
-  # for backward compatibility with pre-linux-2.2.15 kernels.
-  # (Bugzilla:fibrebugs, #384)
-  define_bool CONFIG_FUSION_ISENSE n
-  define_bool CONFIG_FUSION_CTL n
-  define_bool CONFIG_FUSION_LAN n
+      fi

+      endmenu
+   fi
 fi
-
-endmenu

