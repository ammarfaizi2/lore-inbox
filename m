Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSLLTpX>; Thu, 12 Dec 2002 14:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSLLTpX>; Thu, 12 Dec 2002 14:45:23 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25875 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264683AbSLLTpW>;
	Thu, 12 Dec 2002 14:45:22 -0500
Date: Thu, 12 Dec 2002 20:52:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Bradford <john@grabjohn.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, perex@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 breaks ALSA AWE32
Message-ID: <20021212195258.GA12691@mars.ravnborg.org>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Sam Ravnborg <sam@ravnborg.org>, perex@suse.cz,
	linux-kernel@vger.kernel.org
References: <20021210205321.GA2321@mars.ravnborg.org> <200212111347.gBBDl0Pd007751@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212111347.gBBDl0Pd007751@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ons, dec 11, 2002 at 01:47:00 +0000, John Bradford wrote:
> > kbuild in 2.5.51 requires that there exist one variable named obj-*
> > before built-in.o is generated.
> > In the Makefile for sound/synth/emux the variables obj-* is only set if
> > CONFIG_SND_SEQUENCER is set to y or m.
> > 
> > The best approach may be a derived bool defined in Kconfig, but
> > an alterneative solution is to rearrange the Makefile a bit.
> > 
> > Try the following (untested) patch.
> 
> Same error I'm afraid :-/

Yep, sorry.
kbuild check if any obj-* value has been assigned a value,
so an empty assignment does not help.

I have made a patch that works this time.

Kai, any ideas how to do this in a better way?
- I have considered a derived symbol in sound/isa/Kconfig,
something like:
bool SND_EMUX_SYNTH
depends on SND && SND_SEQUENCER && SND_SBAWE

and then in the Makefile:
obj-$(CONFIG_SND_EMUX_SYNTH) := snd-emux-synth.o

That would make the Makefile trivial, but sound/ did not use any derived
symbols in the Kconfig file, so I did not test this approach.

I'm prepared to clean up all sound/ makefiles if this approach is
considered better than what is used today.

	Sam

===== sound/synth/emux/Makefile 1.4 vs edited =====
--- 1.4/sound/synth/emux/Makefile	Tue Jun 18 11:16:20 2002
+++ edited/sound/synth/emux/Makefile	Thu Dec 12 20:38:42 2002
@@ -5,16 +5,13 @@
 
 export-objs  := emux.o
 
+snd-emux-synth-objs-$(CONFIG_SND_SEQUENCER_OSS) := emux_oss.o
 snd-emux-synth-objs := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
-		       emux_effect.o emux_proc.o soundfont.o
-ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
-  snd-emux-synth-objs += emux_oss.o
-endif
+		       emux_effect.o emux_proc.o soundfont.o \
+		       $(snd-emux-synth-objs-y)
 
 # Toplevel Module Dependency
-ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
-  obj-$(CONFIG_SND_SBAWE) += snd-emux-synth.o
-  obj-$(CONFIG_SND_EMU10K1) += snd-emux-synth.o
-endif
+seq := $(filter m y,$(CONFIG_SND_SEQUENCER))
+obj-$(if $(seq),$(CONFIG_SND_SBAWE))   += snd-emux-synth.o
+obj-$(if $(seq),$(CONFIG_SND_EMU10K1)) += snd-emux-synth.o
 
-include $(TOPDIR)/Rules.make
