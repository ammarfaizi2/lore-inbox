Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbSIXQZD>; Tue, 24 Sep 2002 12:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbSIXQZC>; Tue, 24 Sep 2002 12:25:02 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:64902 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261699AbSIXQZB>; Tue, 24 Sep 2002 12:25:01 -0400
Date: Tue, 24 Sep 2002 11:30:06 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Bob_Tracy <rct@gherkin.frus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38: modular IDE broken
In-Reply-To: <m17tqRL-0005khC@gherkin.frus.com>
Message-ID: <Pine.LNX.4.44.0209241123370.19606-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Bob_Tracy wrote:

> Kai Germaschewski wrote:
> > ===== Makefile 1.5 vs edited =====
> > --- 1.5/drivers/ide/Makefile	Wed Sep 18 20:11:21 2002
> > +++ edited/Makefile	Mon Sep 23 17:50:05 2002
> > @@ -24,7 +24,7 @@
> >  obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
> >  obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
> >  
> > -ifeq ($(CONFIG_BLK_DEV_IDE),y)
> > +ifdef CONFIG_BLK_DEV_IDE
> >  obj-$(CONFIG_PROC_FS)			+= ide-proc.o
> >  endif
> 
> I neglected to mention that the above patch (exactly the same, as it
> turns out :-)) is how I forced the ide-proc.o build.  The brokenness
> extends deeper.
> 
> Specific example: proc_ide_read_geometry has the requisite EXPORT_SYMBOL()
> wrapper in ide-proc.c, yet, I still end up with proc_ide_read_geometry_R*
> unresolved at depmod time.  In case anyone is wondering, I *did* do a
> "make clean", manually cleaned out linux/include/modules to make *sure*
> there wasn't any old cruft lying about, then ran "make dep && make bzImage &&
> make modules && make modules_install".  The depmod output quoted below is
> the result of all that.

Well, fortunately enough, it turns out not to be a general problem in the
build nor modversions related at all, but rather a messed up
drivers/ide/Makefile.

The specific problem here is that you have CONFIG_IDE = CONFIG_BLK_DEV_IDE
= m, but end up with ide-proc.o in $(obj-y). So that asks for ide-proc.o
being linked into vmlinux. However, since the whole drivers/ide subdir is
marked as "m" (CONFIG_IDE), it does not end up in vmlinux. Anyway, that's
not really what you wanted in the first place, so never mind.

There are more problems than this, but the appended patch at least gets
rid of this issue, it needs a

	mv drivers/ide/ide.c drivers/ide/ide-main.c,

to work. There's still other unresolved symbols which need exporting.

Any of the IDE people interested in figuring this out properly?

--Kai

===== drivers/ide/Makefile 1.5 vs edited =====
--- 1.5/drivers/ide/Makefile	Wed Sep 18 20:11:21 2002
+++ edited/drivers/ide/Makefile	Tue Sep 24 10:21:51 2002
@@ -7,14 +7,22 @@
 # Note : at this point, these files are compiled on all systems.
 # In the future, some of these should be built conditionally.
 #
-export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-dma.o ide-lib.o setup-pci.o
+export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide-main.o \
+	       ide-probe.o ide-dma.o ide-lib.o setup-pci.o
 
 # First come modules that register themselves with the core
 obj-$(CONFIG_BLK_DEV_IDEPCI)		+= pci/
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o
+ide-y					+= ide-geometry.o \
+					   ide-iops.o ide-taskfile.o  \
+					   ide-main.o ide-lib.o
+ide-$(CONFIG_PROC_FS)			+= ide-proc.o
+ide-objs				:= $(ide-y)
+
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-probe.o ide.o
+
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
@@ -23,10 +31,6 @@
 obj-$(CONFIG_BLK_DEV_IDEPCI)		+= setup-pci.o
 obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
 obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
-
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
-endif
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= legacy/ ppc/ arm/
 
===== drivers/ide/ide-main.c 1.22 vs edited =====
--- 1.22/drivers/ide/ide-main.c	Tue Sep 24 10:20:32 2002
+++ edited/drivers/ide/ide-main.c	Tue Sep 24 09:40:30 2002
@@ -3553,7 +3553,9 @@
 	return 0;
 }
 
+#ifndef MODULE
 module_init(ide_init);
+#endif
 
 #ifdef MODULE
 char *options = NULL;

