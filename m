Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTFUA6N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 20:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTFUA6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 20:58:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10490 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265062AbTFUA6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 20:58:11 -0400
Date: Sat, 21 Jun 2003 03:12:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Fabio Bracci <fabio@hoendiep.ath.cx>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: 2.5: wrong CONFIG_SND_SEQUENCER logic in several drivers
Message-ID: <20030621011210.GS29247@fs.tum.de>
References: <Pine.LNX.4.53.0305302318530.31546@hoendiep.ath.cx> <20030530222701.GC2536@fs.tum.de> <1056143086.6808.12.camel@bolidino.hoendiep.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056143086.6808.12.camel@bolidino.hoendiep.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 11:04:47PM +0200, Fabio Bracci wrote:

> Hi
> 	Hereby I have attached the requested .conf file ("config.2.5.70").
> I tried again to compile a kernel, but now using the 2.5.72 one. But
> again something went wrong while compiling the sound subsystem. That's
> why I attacched also the new .conf file ("config.2.5.70").
> I now got the following messages:
> ...
>...
>   LD      vmlinux
> sound/built-in.o(.text+0x1b6ea): In function `snd_rawmidi_dev_register':
> : undefined reference to `snd_seq_device_new'
> sound/built-in.o(.text+0x22fb8): In function `snd_card_emu10k1_probe':
> : undefined reference to `snd_seq_device_new'
> make: *** [vmlinux] Error 1
> 
> 
> Hopefully this will help.

Yup, thanks a lot!

> Greetings,
> 	Fabio ...
>...
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=y
> CONFIG_SND_SEQUENCER=m
> CONFIG_SND_SEQ_DUMMY=m
> # CONFIG_SND_OSSEMUL is not set
> CONFIG_SND_RTCTIMER=m
> CONFIG_SND_VERBOSE_PRINTK=y
> # CONFIG_SND_DEBUG is not set
>...
> CONFIG_SND_EMU10K1=y
>...


This is a bug in several ALSA drivers.

@Fabio:
As a workaround, compile "Sequencer support" statically (non-modular).

@Jaroslav:
Several drivers have a wrong logic for CONFIG_SND_SEQUENCER. The correct 
solution is something like the following:

--- sound/pci/emu10k1/emu10k1.c.old	2003-06-21 03:02:04.000000000 +0200
+++ sound/pci/emu10k1/emu10k1.c	2003-06-21 03:02:31.000000000 +0200
@@ -35,7 +35,7 @@
 MODULE_DEVICES("{{Creative Labs,SB Live!/PCI512/E-mu APS},"
 	       "{Creative Labs,SB Audigy}}");
 
-#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+#if defined(CONFIG_SND_SEQUENCER) || (defined (MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
 #define ENABLE_SYNTH
 #include <sound/emu10k1_synth.h>
 #endif

If you comfirm this is correct I'll send a fix for all affected drivers.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

