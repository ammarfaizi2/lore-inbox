Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRB1WYt>; Wed, 28 Feb 2001 17:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRB1WYn>; Wed, 28 Feb 2001 17:24:43 -0500
Received: from pille1.addcom.de ([62.96.128.35]:51470 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S129309AbRB1WY0>;
	Wed, 28 Feb 2001 17:24:26 -0500
Date: Wed, 28 Feb 2001 23:26:27 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: <linux-kernel@vger.kernel.org>
cc: <linux-kbuild@torque.net>, <werner.almesberger@epfl.ch>, <lizzi@cnam.fr>,
        <faith@acm.org>, <raxel@goldbach.in-berlin.de>, <dwmw2@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <dhinds@zen.stanford.edu>,
        <tom@lpsg.demon.co.uk>, <davem@redhat.com>,
        <linux-scsi@vger.kernel.org>, <dag@brattli.net>
Subject: [PATCH] Makefile fixes
Message-ID: <Pine.LNX.4.30.0102282323060.30937-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could people (particularly the affected maintainers) please look over the 
appended patch, which I'm planning to submit to Linus at an appropriate 
time.

It contains a couple of small Makefile fixes, particularly

o $(list-multi) is supposed to list composite modules, i.e. modules
  which are made out of multiple source files.
  Make sure that $(list-multi) is only defined where applicable, and
  that it really lists all composite objects. Some Makefiles forget
  this or use e.g. $(multi-objs) which is wrong. The variable
  $(list-multi) is used in Rules.make, currently only for dependencies,
  that's why most people haven't seen any problems yet.

o For all foo.o listed in $(list-multi) there needs to be a $(foo-objs) 
  which lists the actual parts of the composite module. Currently,
  there also needs to be a link rule for each of the composite objects,
  which looks like

	foo.o: $(foo-objs)
		$(LD) -r -o $@ $(foo-objs)

  The patch corrects places where this was done incorrectly.

o some cleanup

The reason behind this is that I'm planning to remove the need for the
list-multi and the link rule, and this needs to be done in preparation.
(But it's needed for correctness anyway).

Patch is against 2.4.2-pre3 but still applies cleanly against 2.4.2-final.

--Kai

diff -ur linux-2.4.2-pre3/drivers/atm/Makefile linux-2.4.2-pre3.makefixes/drivers/atm/Makefile
--- linux-2.4.2-pre3/drivers/atm/Makefile	Sun Jan 21 01:27:44 2001
+++ linux-2.4.2-pre3.makefixes/drivers/atm/Makefile	Fri Feb 16 22:02:02 2001
@@ -50,6 +50,9 @@
 
 EXTRA_CFLAGS=-g
 
+list-multi	:= fore_200e
+fore_200e-objs	:= fore200e.o $(FORE200E_FW_OBJS)
+
 include $(TOPDIR)/Rules.make
 
 
@@ -82,9 +85,8 @@
 	objcopy -Iihex $< -Obinary $@.gz
 	gzip -df $@.gz
 
-# module build
-fore_200e.o: fore200e.o $(FORE200E_FW_OBJS)
-	$(LD) -r -o $@ $< $(FORE200E_FW_OBJS)
+fore_200e.o: $(fore_200e-objs)
+	$(LD) -r -o $@ $(fore_200e-objs)
 
 # firmware dependency stuff taken from drivers/sound/Makefile
 FORE200E_FW_UP_TO_DATE :=
diff -ur linux-2.4.2-pre3/drivers/char/Makefile linux-2.4.2-pre3.makefixes/drivers/char/Makefile
--- linux-2.4.2-pre3/drivers/char/Makefile	Thu Jan  4 22:00:55 2001
+++ linux-2.4.2-pre3.makefixes/drivers/char/Makefile	Fri Feb 16 21:54:28 2001
@@ -27,8 +27,6 @@
 
 mod-subdirs	:=	joystick ftape drm pcmcia
 
-list-multi	:=	
-
 KEYMAP   =defkeymap.o
 KEYBD    =pc_keyb.o
 CONSOLE  =console.o
diff -ur linux-2.4.2-pre3/drivers/char/agp/Makefile linux-2.4.2-pre3.makefixes/drivers/char/agp/Makefile
--- linux-2.4.2-pre3/drivers/char/agp/Makefile	Fri Dec 29 23:07:21 2000
+++ linux-2.4.2-pre3.makefixes/drivers/char/agp/Makefile	Fri Feb 16 21:54:28 2001
@@ -7,7 +7,7 @@
 
 export-objs := agpgart_be.o
 
-multi-objs := agpgart.o
+list-multi := agpgart.o
 agpgart-objs := agpgart_fe.o agpgart_be.o
 
 obj-$(CONFIG_AGP) += agpgart.o
diff -ur linux-2.4.2-pre3/drivers/char/drm/Makefile linux-2.4.2-pre3.makefixes/drivers/char/drm/Makefile
--- linux-2.4.2-pre3/drivers/char/drm/Makefile	Fri Feb 16 21:51:13 2001
+++ linux-2.4.2-pre3.makefixes/drivers/char/drm/Makefile	Fri Feb 16 21:56:32 2001
@@ -3,12 +3,10 @@
 # the Direct Rendering Infrastructure (DRI) in XFree86 4.x.
 #
 
-# drm.o is a fake target -- it is never built
-# The real targets are in the module-list
 O_TARGET	:= drm.o
 
-module-list     := gamma.o tdfx.o r128.o ffb.o mga.o i810.o
-export-objs     := $(patsubst %.o,%_drv.o,$(module-list))
+export-objs     := gamma_drv.o tdfx_drv.o r128_drv.o ffb_drv.o mga_drv.o \
+		   i810_drv.o
 
 # lib-objs are included in every module so that radical changes to the
 # architecture of the DRM support library can be made at a later time.
@@ -42,6 +40,7 @@
  endif
 endif
 
+list-multi  := gamma.o tdfx.o r128.o ffb.o mga.o i810.o
 gamma-objs  := gamma_drv.o  gamma_dma.o
 tdfx-objs   := tdfx_drv.o                 tdfx_context.o
 r128-objs   := r128_drv.o   r128_cce.o    r128_context.o r128_bufs.o r128_state.o
diff -ur linux-2.4.2-pre3/drivers/fc4/Makefile linux-2.4.2-pre3.makefixes/drivers/fc4/Makefile
--- linux-2.4.2-pre3/drivers/fc4/Makefile	Fri Dec 29 23:07:21 2000
+++ linux-2.4.2-pre3.makefixes/drivers/fc4/Makefile	Fri Feb 16 21:54:28 2001
@@ -14,7 +14,7 @@
 obj-$(CONFIG_FC4_SOC) += soc.o
 obj-$(CONFIG_FC4_SOCAL) += socal.o
 
+include $(TOPDIR)/Rules.make
+
 fc4.o: $(fc4-objs)
 	$(LD) -r -o $@ $(fc4-objs)
-
-include $(TOPDIR)/Rules.make
diff -ur linux-2.4.2-pre3/drivers/media/radio/Makefile linux-2.4.2-pre3.makefixes/drivers/media/radio/Makefile
--- linux-2.4.2-pre3/drivers/media/radio/Makefile	Fri Dec 29 23:07:22 2000
+++ linux-2.4.2-pre3.makefixes/drivers/media/radio/Makefile	Fri Feb 16 21:54:28 2001
@@ -9,21 +9,12 @@
 # parent makes..
 #
 
-# Object file lists.
-
-obj-y		:=
-obj-m		:=
-obj-n		:=
-obj-		:=
-
 O_TARGET := radio.o
 
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
 export-objs     :=	
-
-list-multi	:=	
 
 obj-$(CONFIG_RADIO_AZTECH) += radio-aztech.o
 obj-$(CONFIG_RADIO_RTRACK2) += radio-rtrack2.o
diff -ur linux-2.4.2-pre3/drivers/media/video/Makefile linux-2.4.2-pre3.makefixes/drivers/media/video/Makefile
--- linux-2.4.2-pre3/drivers/media/video/Makefile	Fri Dec 29 23:07:22 2000
+++ linux-2.4.2-pre3.makefixes/drivers/media/video/Makefile	Fri Feb 16 21:54:28 2001
@@ -9,17 +9,6 @@
 # parent makes..
 #
 
-# Object file lists.
-
-obj-y		:=
-obj-m		:=
-obj-n		:=
-obj-		:=
-
-SUB_DIRS     := 
-MOD_SUB_DIRS := $(SUB_DIRS)
-ALL_SUB_DIRS := $(SUB_DIRS)
-
 O_TARGET := video.o
 
 # All of the (potential) objects that export symbols.
@@ -54,29 +43,10 @@
 obj-$(CONFIG_VIDEO_CPIA_USB) += cpia_usb.o
 obj-$(CONFIG_TUNER_3036) += tuner-3036.o
 
-# Extract lists of the multi-part drivers.
-# The 'int-*' lists are the intermediate files used to build the multi's.
-
-multi-y         := $(filter $(list-multi), $(obj-y))
-multi-m         := $(filter $(list-multi), $(obj-m))
-int-y           := $(sort $(foreach m, $(multi-y), $($(basename $(m))-objs)))
-int-m           := $(sort $(foreach m, $(multi-m), $($(basename $(m))-objs)))
-
-# Files that are both resident and modular: remove from modular.
-
-obj-m           := $(filter-out $(obj-y), $(obj-m))
-int-m           := $(filter-out $(int-y), $(int-m))
-
-# Take multi-part drivers out of obj-y and put components in.
-
-obj-y           := $(filter-out $(list-multi), $(obj-y)) $(int-y)
-
 include $(TOPDIR)/Rules.make
 
-fastdep:
-
-zoran.o: zr36120.o zr36120_i2c.o zr36120_mem.o
-	$(LD) $(LD_RFLAG) -r -o $@ zr36120.o zr36120_i2c.o zr36120_mem.o
+zoran.o: $(zoran-objs)
+	$(LD) $(LD_RFLAG) -r -o $@ $(zoran-objs)
 
 bttv.o: $(bttv-objs)
 	$(LD) $(LD_RFLAG) -r -o $@ $(bttv-objs)
diff -ur linux-2.4.2-pre3/drivers/mtd/Makefile linux-2.4.2-pre3.makefixes/drivers/mtd/Makefile
--- linux-2.4.2-pre3/drivers/mtd/Makefile	Fri Dec 29 23:07:22 2000
+++ linux-2.4.2-pre3.makefixes/drivers/mtd/Makefile	Fri Feb 16 21:54:28 2001
@@ -12,18 +12,9 @@
 
 # Object file lists.
 
-obj-y           :=
-obj-m           :=
-obj-n           :=
-obj-            :=
+O_TARGET			:= mtdlink.o
 
-O_TARGET	:= mtdlink.o
-SUB_DIRS	:=
-ALL_SUB_DIRS 	:=
-MOD_SUB_DIRS	:=
-
-export-objs	:=	mtdcore.o mtdpart.o jedec.o
-list-multi	:=
+export-objs			:= mtdcore.o mtdpart.o jedec.o
 
 # MTD devices
 obj-$(CONFIG_MTD)		+= mtdcore.o
diff -ur linux-2.4.2-pre3/drivers/net/Makefile linux-2.4.2-pre3.makefixes/drivers/net/Makefile
--- linux-2.4.2-pre3/drivers/net/Makefile	Sun Jan  7 04:45:14 2001
+++ linux-2.4.2-pre3.makefixes/drivers/net/Makefile	Fri Feb 16 21:54:28 2001
@@ -15,8 +15,10 @@
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs     :=	8390.o arlan.o aironet4500_core.o aironet4500_card.o ppp_async.o \
-			ppp_generic.o slhc.o pppox.o auto_irq.o
+export-objs     := 8390.o arlan.o aironet4500_core.o aironet4500_card.o \
+		   ppp_async.o ppp_generic.o slhc.o pppox.o auto_irq.o
+list-multi	:= rcpci.o
+rcpci-objs 	:= rcpci45.o rclanmtl.o
 
 ifeq ($(CONFIG_TULIP),y)
   obj-y += tulip/tulip.o
@@ -213,6 +215,6 @@
 clean:
 	rm -f core *.o *.a *.s
 
-rcpci.o: rcpci45.o rclanmtl.o
-	$(LD) -r -o rcpci.o rcpci45.o rclanmtl.o
+rcpci.o: $(rcpci-objs)
+	$(LD) -r -o $@ $(rcpci-objs)
 
diff -ur linux-2.4.2-pre3/drivers/net/pcmcia/Makefile linux-2.4.2-pre3.makefixes/drivers/net/pcmcia/Makefile
--- linux-2.4.2-pre3/drivers/net/pcmcia/Makefile	Fri Dec 29 23:07:22 2000
+++ linux-2.4.2-pre3.makefixes/drivers/net/pcmcia/Makefile	Fri Feb 16 21:54:28 2001
@@ -4,12 +4,7 @@
 # Makefile for the Linux PCMCIA network device drivers.
 #
 
-O_TARGET := pcmcia_net.o
-
-obj-y		:=
-obj-m		:=
-obj-n		:=
-obj-		:=
+O_TARGET 	:= pcmcia_net.o
 
 # Things that need to export symbols
 export-objs	:= ray_cs.o
diff -ur linux-2.4.2-pre3/drivers/pcmcia/Makefile linux-2.4.2-pre3.makefixes/drivers/pcmcia/Makefile
--- linux-2.4.2-pre3/drivers/pcmcia/Makefile	Fri Dec 29 23:07:22 2000
+++ linux-2.4.2-pre3.makefixes/drivers/pcmcia/Makefile	Fri Feb 16 21:54:28 2001
@@ -12,7 +12,7 @@
 
 export-objs := ds.o cs.o cb_enabler.o yenta.o pci_socket.o
 
-multi-list = pcmcia_core.o yenta_socket.o
+list-multi := pcmcia_core.o yenta_socket.o
 
 yenta_socket-objs := pci_socket.o yenta.o
 pcmcia_core-objs := cistpl.o rsrc_mgr.o bulkmem.o cs.o
diff -ur linux-2.4.2-pre3/drivers/pnp/Makefile linux-2.4.2-pre3.makefixes/drivers/pnp/Makefile
--- linux-2.4.2-pre3/drivers/pnp/Makefile	Fri Dec 29 23:07:22 2000
+++ linux-2.4.2-pre3.makefixes/drivers/pnp/Makefile	Fri Feb 16 21:54:28 2001
@@ -11,7 +11,7 @@
 O_TARGET := pnp.o
 
 export-objs := isapnp.o
-multi-objs := isa-pnp.o
+list-multi := isa-pnp.o
 
 proc-$(CONFIG_PROC_FS) = isapnp_proc.o
 isa-pnp-objs := isapnp.o quirks.o $(proc-y)
diff -ur linux-2.4.2-pre3/drivers/sbus/char/Makefile linux-2.4.2-pre3.makefixes/drivers/sbus/char/Makefile
--- linux-2.4.2-pre3/drivers/sbus/char/Makefile	Mon Jan 22 22:30:20 2001
+++ linux-2.4.2-pre3.makefixes/drivers/sbus/char/Makefile	Fri Feb 16 21:54:28 2001
@@ -7,14 +7,16 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-O_TARGET := sunchar.o
+O_TARGET 	:= sunchar.o
 
-export-objs := su.o
-obj-y := sunkbd.o sunkbdmap.o sunmouse.o sunserial.o zs.o
+export-objs 	:= su.o
 
-vfc-objs := vfc_dev.o vfc_i2c.o
+list-multi	:= vfc.o
+vfc-objs 	:= vfc_dev.o vfc_i2c.o
 
-obj-$(CONFIG_PCI) += su.o pcikbd.o
+obj-y 		:= sunkbd.o sunkbdmap.o sunmouse.o sunserial.o zs.o
+
+obj-$(CONFIG_PCI) 			+= su.o pcikbd.o
 
 obj-$(CONFIG_SAB82532)			+= sab82532.o
 obj-$(CONFIG_ENVCTRL)			+= envctrl.o
diff -ur linux-2.4.2-pre3/drivers/scsi/Makefile linux-2.4.2-pre3.makefixes/drivers/scsi/Makefile
--- linux-2.4.2-pre3/drivers/scsi/Makefile	Sat Dec 30 20:23:14 2000
+++ linux-2.4.2-pre3.makefixes/drivers/scsi/Makefile	Fri Feb 16 21:54:28 2001
@@ -24,7 +24,6 @@
 endif
 
 export-objs	:= scsi_syms.o
-list-multi	:= scsi_mod.o initio.o a100u2w.o
 
 CFLAGS_aha152x.o =   -DAHA152X_STAT -DAUTOCONF
 CFLAGS_gdth.o    = # -DDEBUG_GDTH=2 -D__SERIAL__ -D__COM2__ -DGDTH_STATISTICS
@@ -119,13 +118,14 @@
 obj-$(CONFIG_CHR_DEV_SG)	+= sg.o
 
 
+list-multi	:= scsi_mod.o sd_mod.o sr_mod.o initio.o a100u2w.o
 
 scsi_mod-objs	:= scsi.o hosts.o scsi_ioctl.o constants.o \
 			scsicam.o scsi_proc.o scsi_error.o \
 			scsi_obsolete.o scsi_queue.o scsi_lib.o \
 			scsi_merge.o scsi_dma.o scsi_scan.o \
 			scsi_syms.o
-			
+sd_mod-objs	:= sd.o
 sr_mod-objs	:= sr.o sr_ioctl.o sr_vendor.o
 initio-objs	:= ini9100u.o i91uscsi.o
 a100u2w-objs	:= inia100.o i60uscsi.o
@@ -136,8 +136,8 @@
 scsi_mod.o: $(scsi_mod-objs)
 	$(LD) -r -o $@ $(scsi_mod-objs)
 
-sd_mod.o: sd.o
-	$(LD) -r -o $@ sd.o
+sd_mod.o: $(sd_mod-objs)
+	$(LD) -r -o $@ $(sd_mod-objs)
 
 sr_mod.o: $(sr_mod-objs)
 	$(LD) -r -o $@ $(sr_mod-objs)
diff -ur linux-2.4.2-pre3/drivers/scsi/pcmcia/Makefile linux-2.4.2-pre3.makefixes/drivers/scsi/pcmcia/Makefile
--- linux-2.4.2-pre3/drivers/scsi/pcmcia/Makefile	Fri Dec 29 23:07:22 2000
+++ linux-2.4.2-pre3.makefixes/drivers/scsi/pcmcia/Makefile	Fri Feb 16 21:54:28 2001
@@ -25,21 +25,21 @@
 obj-$(CONFIG_PCMCIA_APA1480)	+= apa1480_cb.o
 
 list-multi	:= qlogic_cs.o fdomain_cs.o aha152x_cs.o apa1480_cb.o
-aha152x-objs	:= aha152x_stub.o aha152x.o
-apa1480-objs	:= apa1480_stub.o aic7xxx.o
-fdomain-objs	:= fdomain_stub.o fdomain.o
-qlogic-objs	:= qlogic_stub.o qlogicfas.o
+aha152x_cs-objs	:= aha152x_stub.o aha152x.o
+apa1480_cb-objs	:= apa1480_stub.o aic7xxx.o
+fdomain_cs-objs	:= fdomain_stub.o fdomain.o
+qlogic_cs-objs	:= qlogic_stub.o qlogicfas.o
 
 include $(TOPDIR)/Rules.make
 
-aha152x_cs.o: $(aha152x-objs)
-	$(LD) -r -o $@ $(aha152x-objs)
+aha152x_cs.o: $(aha152x_cs-objs)
+	$(LD) -r -o $@ $(aha152x_cs-objs)
 
-apa1480_cb.o: $(apa1480-objs)
-	$(LD) -r -o $@ $(apa1480-objs)
+apa1480_cb.o: $(apa1480_cb-objs)
+	$(LD) -r -o $@ $(apa1480_cb-objs)
 
-fdomain_cs.o: $(fdomain-objs)
-	$(LD) -r -o $@ $(fdomain-objs)
+fdomain_cs.o: $(fdomain_cs-objs)
+	$(LD) -r -o $@ $(fdomain_cs-objs)
 
-qlogic_cs.o: $(qlogic-objs)
-	$(LD) -r -o $@ $(qlogic-objs)
+qlogic_cs.o: $(qlogic_cs-objs)
+	$(LD) -r -o $@ $(qlogic_cs-objs)
diff -ur linux-2.4.2-pre3/net/atm/Makefile linux-2.4.2-pre3.makefixes/net/atm/Makefile
--- linux-2.4.2-pre3/net/atm/Makefile	Mon Jan  1 18:54:07 2001
+++ linux-2.4.2-pre3.makefixes/net/atm/Makefile	Fri Feb 16 22:05:43 2001
@@ -7,16 +7,14 @@
 #
 # Note 2! The CFLAGS definition is now in the main makefile...
 
-include ../../.config
+O_TARGET	:= atm.o
 
-O_TARGET= atm.o
+export-objs 	:= common.o atm_misc.o raw.o resources.o ipcommon.o proc.o
 
-export-objs = common.o atm_misc.o raw.o resources.o ipcommon.o proc.o
+list-multi	:= mpoa.o
+mpoa-objs	:= mpc.o mpoa_caches.o mpoa_proc.o
 
-multi-list = mpoa.o
-mpoa-objs = mpc.o mpoa_caches.o mpoa_proc.o
-
-obj-$(CONFIG_ATM) = addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
+obj-$(CONFIG_ATM) := addr.o pvc.o signaling.o svc.o common.o atm_misc.o raw.o resources.o
 
 ifeq ($(CONFIG_ATM_CLIP),y)
 obj-y += clip.o
diff -ur linux-2.4.2-pre3/net/ipv6/netfilter/Makefile linux-2.4.2-pre3.makefixes/net/ipv6/netfilter/Makefile
--- linux-2.4.2-pre3/net/ipv6/netfilter/Makefile	Mon Jan 22 22:30:21 2001
+++ linux-2.4.2-pre3.makefixes/net/ipv6/netfilter/Makefile	Fri Feb 16 21:54:28 2001
@@ -9,7 +9,6 @@
 
 O_TARGET := netfilter.o
 
-multi-objs :=
 export-objs :=
 
 # Link order matters here.
diff -ur linux-2.4.2-pre3/net/irda/ircomm/Makefile linux-2.4.2-pre3.makefixes/net/irda/ircomm/Makefile
--- linux-2.4.2-pre3/net/irda/ircomm/Makefile	Fri Dec 29 23:07:24 2000
+++ linux-2.4.2-pre3.makefixes/net/irda/ircomm/Makefile	Fri Feb 16 21:54:28 2001
@@ -9,7 +9,7 @@
 
 O_TARGET := ircomm_and_tty.o
 
-multi-objs := ircomm.o ircomm-tty.o
+list-multi := ircomm.o ircomm-tty.o
 ircomm-objs := ircomm_core.o ircomm_event.o ircomm_lmp.o ircomm_ttp.o
 ircomm-tty-objs := ircomm_tty.o ircomm_tty_attach.o ircomm_tty_ioctl.o ircomm_param.o
 


