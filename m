Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275201AbTHAIer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 04:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275202AbTHAIeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 04:34:46 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:35223
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S275201AbTHAIej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 04:34:39 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH][Trivial] Config bugfix - Move MPT fusion into SCSi menu
Date: Fri, 1 Aug 2003 04:36:56 -0400
User-Agent: KMail/1.5
Cc: davem@redhat.com, rth@twiddle.net
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308010314.19568.rob@landley.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MPT fusion is a SCSI driver.  If you go into the SCSI menu and disable SCSI
support, you can't descend into this driver's menu (and there's no easy way
to find out why).  A random SCSI driver more than 90% of the people out
there don't have doesn't belong at the top level anyway.

Unfortunately, since this IS at the top level, every architecture in the
world imports this from their arch/blah/Kconfig (in two cases guarded by
CONFIG_PCI), so the patch is unnecessarily big removing it from a lot of
places and adding it to the one it goes in.  Hopefully, it's still in the
"trivial" range anyway, so I'm copying Rusty.

I bugged the two architecture maintainers who used the PCI guard when I
first submitted this patch back under 2.4, and I have a vague memory that
they said moving it to the SCSI menu provided its own PCI guard, but my
memory's been wrong before, so I'm copying Dave Miller (sparc64) and
Richard Henderson (alpha) in case they'd like to bite my head off...

It's quite possible that it should go in the "SCSI low level device
drivers" menu instead of the SCSI menu, but nothing else in the SCSI
devices menu has its own gratuitous sub-menu, and that cleanup is real
easy to do on top of this one anyway.

Rob

Patch against -test2.

diff -ru linux-old/arch/alpha/Kconfig linux-2.6.0-test2/arch/alpha/Kconfig
--- linux-old/arch/alpha/Kconfig	2003-07-27 13:06:59.000000000 -0400
+++ linux-2.6.0-test2/arch/alpha/Kconfig	2003-08-01 02:44:13.000000000 -0400
@@ -656,10 +656,6 @@
 
 source "drivers/scsi/Kconfig"
 
-if PCI
-source "drivers/message/fusion/Kconfig"
-endif
-
 source "drivers/ieee1394/Kconfig"
 
 source "net/Kconfig"
diff -ru linux-old/arch/i386/Kconfig linux-2.6.0-test2/arch/i386/Kconfig
--- linux-old/arch/i386/Kconfig	2003-07-27 12:57:48.000000000 -0400
+++ linux-2.6.0-test2/arch/i386/Kconfig	2003-08-01 02:47:08.000000000 -0400
@@ -1212,8 +1212,6 @@
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff -ru linux-old/arch/ia64/Kconfig linux-2.6.0-test2/arch/ia64/Kconfig
--- linux-old/arch/ia64/Kconfig	2003-07-27 13:09:44.000000000 -0400
+++ linux-2.6.0-test2/arch/ia64/Kconfig	2003-08-01 02:32:58.000000000 -0400
@@ -552,8 +552,6 @@
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 endif
 
 
diff -ru linux-old/arch/m68knommu/Kconfig linux-2.6.0-test2/arch/m68knommu/Kconfig
--- linux-old/arch/m68knommu/Kconfig	2003-07-27 13:05:16.000000000 -0400
+++ linux-2.6.0-test2/arch/m68knommu/Kconfig	2003-08-01 02:32:22.000000000 -0400
@@ -530,8 +530,6 @@
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff -ru linux-old/arch/parisc/Kconfig linux-2.6.0-test2/arch/parisc/Kconfig
--- linux-old/arch/parisc/Kconfig	2003-07-27 13:03:51.000000000 -0400
+++ linux-2.6.0-test2/arch/parisc/Kconfig	2003-08-01 02:35:21.000000000 -0400
@@ -186,8 +186,6 @@
 
 source "drivers/md/Kconfig"
 
-#source drivers/message/fusion/Kconfig
-
 #source drivers/ieee1394/Kconfig
 
 #source drivers/message/i2o/Kconfig
diff -ru linux-old/arch/ppc/Kconfig linux-2.6.0-test2/arch/ppc/Kconfig
--- linux-old/arch/ppc/Kconfig	2003-07-27 13:11:02.000000000 -0400
+++ linux-2.6.0-test2/arch/ppc/Kconfig	2003-08-01 02:32:37.000000000 -0400
@@ -1176,8 +1176,6 @@
 
 source "drivers/scsi/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff -ru linux-old/arch/ppc64/Kconfig linux-2.6.0-test2/arch/ppc64/Kconfig
--- linux-old/arch/ppc64/Kconfig	2003-07-27 13:03:03.000000000 -0400
+++ linux-2.6.0-test2/arch/ppc64/Kconfig	2003-08-01 02:33:35.000000000 -0400
@@ -257,8 +257,6 @@
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff -ru linux-old/arch/sparc64/Kconfig linux-2.6.0-test2/arch/sparc64/Kconfig
--- linux-old/arch/sparc64/Kconfig	2003-07-27 13:08:17.000000000 -0400
+++ linux-2.6.0-test2/arch/sparc64/Kconfig	2003-08-01 02:43:58.000000000 -0400
@@ -676,10 +676,6 @@
 
 source "drivers/fc4/Kconfig"
 
-if PCI
-source "drivers/message/fusion/Kconfig"
-endif
-
 source "drivers/ieee1394/Kconfig"
 
 source "net/Kconfig"
diff -ru linux-old/arch/v850/Kconfig linux-2.6.0-test2/arch/v850/Kconfig
--- linux-old/arch/v850/Kconfig	2003-07-27 13:01:25.000000000 -0400
+++ linux-2.6.0-test2/arch/v850/Kconfig	2003-08-01 02:35:49.000000000 -0400
@@ -301,8 +301,6 @@
 
 source "drivers/md/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
diff -ru linux-old/arch/x86_64/Kconfig linux-2.6.0-test2/arch/x86_64/Kconfig
--- linux-old/arch/x86_64/Kconfig	2003-07-27 13:07:11.000000000 -0400
+++ linux-2.6.0-test2/arch/x86_64/Kconfig	2003-08-01 02:35:35.000000000 -0400
@@ -413,8 +413,6 @@
 
 source "drivers/telephony/Kconfig"
 
-source "drivers/message/fusion/Kconfig"
-
 source "drivers/ieee1394/Kconfig"
 
 #Currently not 64-bit safe
diff -ru linux-old/drivers/scsi/Kconfig linux-2.6.0-test2/drivers/scsi/Kconfig
--- linux-old/drivers/scsi/Kconfig	2003-07-27 13:09:04.000000000 -0400
+++ linux-2.6.0-test2/drivers/scsi/Kconfig	2003-08-01 02:31:31.000000000 -0400
@@ -1836,6 +1836,7 @@
 #      bool 'GVP Turbo 040/060 SCSI support (EXPERIMENTAL)' CONFIG_GVP_TURBO_SCSI
 endmenu
 
+source "drivers/message/fusion/Kconfig"
 source "drivers/scsi/pcmcia/Kconfig"
 
 endmenu

