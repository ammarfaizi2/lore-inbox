Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSLJUqg>; Tue, 10 Dec 2002 15:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSLJUqg>; Tue, 10 Dec 2002 15:46:36 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:21764 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264936AbSLJUqe>;
	Tue, 10 Dec 2002 15:46:34 -0500
Date: Tue, 10 Dec 2002 21:53:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: John Bradford <john@grabjohn.com>, Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: 2.5.51 breaks ALSA AWE32
Message-ID: <20021210205321.GA2321@mars.ravnborg.org>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Jaroslav Kysela <perex@suse.cz>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <200212101158.gBABwSnr003646@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212101158.gBABwSnr003646@darkstar.example.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 11:58:28AM +0000, John Bradford wrote:
> make -f scripts/Makefile.build obj=sound/synth/emux
>    ld -m elf_i386  -r -o sound/synth/built-in.o sound/synth/emux/built-in.o
> ld: cannot open sound/synth/emux/built-in.o: No such file or directory
> make[2]: *** [sound/synth/built-in.o] Error 1
> make[1]: *** [sound/synth] Error 2
> make: *** [sound] Error 2

kbuild in 2.5.51 requires that there exist one variable named obj-*
before built-in.o is generated.
In the Makefile for sound/synth/emux the variables obj-* is only set if
CONFIG_SND_SEQUENCER is set to y or m.

The best approach may be a derived bool defined in Kconfig, but
an alterneative solution is to rearrange the Makefile a bit.

Try the following (untested) patch.

	Sam

===== Makefile 1.4 vs edited =====
--- 1.4/sound/synth/emux/Makefile	Tue Jun 18 11:16:20 2002
+++ edited/Makefile	Tue Dec 10 21:49:49 2002
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
+sequencer-$(CONFIG_SND_SEQUENCER) += snd-emux-synth.o
+obj-$(CONFIG_SND_SBAWE)   := $(sequencer-y) $(sequencer-m)
+obj-$(CONFIG_SND_EMU10K1) += $(sequencer-y) $(sequencer-m)
 
-include $(TOPDIR)/Rules.make
