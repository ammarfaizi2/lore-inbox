Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbSLLUSt>; Thu, 12 Dec 2002 15:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbSLLUSt>; Thu, 12 Dec 2002 15:18:49 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:57834 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267394AbSLLUSq>; Thu, 12 Dec 2002 15:18:46 -0500
Date: Thu, 12 Dec 2002 14:26:26 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: John Bradford <john@grabjohn.com>, <perex@suse.cz>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.51 breaks ALSA AWE32
In-Reply-To: <20021212195258.GA12691@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0212121421320.17517-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Sam Ravnborg wrote:

> kbuild check if any obj-* value has been assigned a value,
> so an empty assignment does not help.
> 
> I have made a patch that works this time.
> 
> Kai, any ideas how to do this in a better way?

The minimal fix I can think of would be

===== sound/synth/Makefile 1.8 vs edited =====
--- 1.8/sound/synth/Makefile	Mon Jun 10 19:49:43 2002
+++ edited/sound/synth/Makefile	Thu Dec 12 14:16:02 2002
@@ -14,6 +14,6 @@
   obj-$(CONFIG_SND_SBAWE) += snd-util-mem.o
 endif
 
-obj-$(CONFIG_SND) += emux/
+obj-$(CONFIG_SND_SEQUENCER) += emux/
 
 include $(TOPDIR)/Rules.make


While we're at it, a bit of cleaning up shouldn't hurt, though, so the 
complete suggested patch would be

===== sound/synth/Makefile 1.8 vs edited =====
--- 1.8/sound/synth/Makefile	Mon Jun 10 19:49:43 2002
+++ edited/sound/synth/Makefile	Thu Dec 12 14:20:47 2002
@@ -10,10 +10,10 @@
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_EMU10K1) += snd-util-mem.o
 obj-$(CONFIG_SND_TRIDENT) += snd-util-mem.o
-ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
+ifdef CONFIG_SND_SEQUENCER
   obj-$(CONFIG_SND_SBAWE) += snd-util-mem.o
 endif
 
-obj-$(CONFIG_SND) += emux/
+obj-$(CONFIG_SND_SEQUENCER) += emux/
 
 include $(TOPDIR)/Rules.make
===== sound/synth/emux/Makefile 1.4 vs edited =====
--- 1.4/sound/synth/emux/Makefile	Tue Jun 18 04:16:20 2002
+++ edited/sound/synth/emux/Makefile	Thu Dec 12 14:20:08 2002
@@ -5,16 +5,11 @@
 
 export-objs  := emux.o
 
-snd-emux-synth-objs := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
-		       emux_effect.o emux_proc.o soundfont.o
-ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
-  snd-emux-synth-objs += emux_oss.o
-endif
+snd-emux-synth-y := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
+		    emux_effect.o emux_proc.o soundfont.o
+snd-emux-synth-$(CONFIG_SND_SEQUENCER_OSS) += emux_oss.o
 
-# Toplevel Module Dependency
-ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
-  obj-$(CONFIG_SND_SBAWE) += snd-emux-synth.o
-  obj-$(CONFIG_SND_EMU10K1) += snd-emux-synth.o
-endif
+obj-$(CONFIG_SND_SBAWE) += snd-emux-synth.o
+obj-$(CONFIG_SND_EMU10K1) += snd-emux-synth.o
 
 include $(TOPDIR)/Rules.make

However, synth/Makefile still has the ugly ifdef in there, which wouldn't
be necessary if we entered synth/ just when CONFIG_SND_SEQUENCER is set.
It looks like more generic routines are in synth/ (util-mem), though,
which IMO shouldn't be there, but rather in some lib/ or whatever dir. So
there's the opportunity for further cleanup, but I'll leave that to the
ALSA people. Anybody care for testing the second patch above?

--Kai


