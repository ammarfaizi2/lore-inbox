Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311735AbSCNS5V>; Thu, 14 Mar 2002 13:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311734AbSCNS5M>; Thu, 14 Mar 2002 13:57:12 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:1410 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S311732AbSCNS4z>; Thu, 14 Mar 2002 13:56:55 -0500
Date: Thu, 14 Mar 2002 11:56:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dave Jones <davej@suse.de>, Martin Dalecki <martin@dalecki.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Actually hide x86 IDE chipsets on !CONFIG_X86
Message-ID: <20020314185616.GI706@opus.bloom.county>
In-Reply-To: <20020314165018.GE706@opus.bloom.county> <20020314181106.J19636@suse.de> <20020314172402.GG706@opus.bloom.county> <20020314194101.B15318@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314194101.B15318@ucw.cz>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 07:41:01PM +0100, Vojtech Pavlik wrote:
> On Thu, Mar 14, 2002 at 10:24:02AM -0700, Tom Rini wrote:
> > On Thu, Mar 14, 2002 at 06:11:06PM +0100, Dave Jones wrote:
> > > On Thu, Mar 14, 2002 at 09:50:18AM -0700, Tom Rini wrote:
> > >  > Hello.  The following actually hides x86-specific drivers on
> > >  > !CONFIG_X86.  The problem is that dep_bool '...' CONFIG_FOO $CONFIG_BAR
> > >  > doesn't have the desired effect if CONFIG_BAR isn't set.
> > >  > 
> > >  > +   if [ "$CONFIG_X86" = "y" ]; then
> > >  > +      bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640
> > >  > +      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
> > >  > +   fi
> > > 
> > >  I've a PCI card with one of these. It could in theory work on any arch
> > >  with a PCI slot.
> > 
> > A 640 and not a 646?
> 
> Yes, exactly. I have one on a card as well.

Okay.  I've attached a new version which removes the bogus dependancy.
This is almost more explicit about setting CONFIG_BLK_DEV_HD, since
config-language.txt doesn't mention how define_bool should act if not
given a value.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/ide/Config.in 1.11 vs edited =====
--- 1.11/drivers/ide/Config.in	Wed Mar 13 06:36:45 2002
+++ edited/drivers/ide/Config.in	Thu Mar 14 11:53:35 2002
@@ -9,8 +9,12 @@
 dep_tristate 'Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support' CONFIG_BLK_DEV_IDE $CONFIG_IDE
 comment 'Please see Documentation/ide.txt for help/info on IDE drives'
 if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-   dep_bool '  Use old disk-only driver on primary interface' CONFIG_BLK_DEV_HD_IDE $CONFIG_X86
-   define_bool CONFIG_BLK_DEV_HD $CONFIG_BLK_DEV_HD_IDE
+   if [ "$CONFIG_X86" = "y" ]; then
+      bool '  Use old disk-only driver on primary interface' CONFIG_BLK_DEV_HD_IDE
+      define_bool CONFIG_BLK_DEV_HD $CONFIG_BLK_DEV_HD_IDE
+   else
+      define_bool CONFIG_BLK_DEV_HD n
+   fi
 
    dep_tristate '  Include IDE/ATA-2 DISK support' CONFIG_BLK_DEV_IDEDISK $CONFIG_BLK_DEV_IDE
    dep_mbool '    Use multi-mode by default' CONFIG_IDEDISK_MULTI_MODE $CONFIG_BLK_DEV_IDEDISK
@@ -34,11 +38,13 @@
    dep_tristate '  SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
 
    comment 'IDE chipset support'
-   dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
+   bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640
    dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
    dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
    if [ "$CONFIG_PCI" = "y" ]; then
-      dep_bool '  RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
+      if [ "$CONFIG_X86" = "y" ]; then
+	 bool '  RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000
+      fi
       bool '  Generic PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
       if [ "$CONFIG_BLK_DEV_IDEPCI" = "y" ]; then
 	 bool '    Boot off-board chipsets first support' CONFIG_BLK_DEV_OFFBOARD
@@ -75,9 +81,11 @@
 	 dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
 	 dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
-	 dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
-	 dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
-	 dep_bool '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
+	 if [ "$CONFIG_X86" = "y" ]; then
+	    dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_bool '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 fi
 	 dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI
 	 dep_bool '    VIA82CXXX chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
       fi
