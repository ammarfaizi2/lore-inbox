Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282873AbRLQVDG>; Mon, 17 Dec 2001 16:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282874AbRLQVCz>; Mon, 17 Dec 2001 16:02:55 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:21256 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S282873AbRLQVCm>; Mon, 17 Dec 2001 16:02:42 -0500
Date: Mon, 17 Dec 2001 22:02:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: compile problem: es1371+gamepad
Message-ID: <20011217220240.A21215@suse.cz>
In-Reply-To: <Pine.NEB.4.43.0112172057360.24574-100000@mimas.fachschaften.tu-muenchen.de> <Pine.NEB.4.43.0112172152410.24574-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.NEB.4.43.0112172152410.24574-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Mon, Dec 17, 2001 at 10:00:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 10:00:23PM +0100, Adrian Bunk wrote:
> 
> The patch below should hadle this problem better.
> 
> I've found another problem:
> When I do completely disable "Input core support" after it was compiled
> into the kernel and I go to the "Sound" menu the implicite change that
> CONFIG_INPUT_GAMEPORT is automatically turned off wasn't done. It seems I
> need to either go to the "Joysticks" menu or to quit "make menuconfig" to
> get the wanted effect in the "Sound" submenu. Is this a bug or a known
> limitation of "make menuconfig"?

It really can be solved sufficiently with CML2.  Other than that, there
are always combinations which are either causing compile errors or are
possible but not allowed by the menuconfig.

> --- drivers/sound/Config.in.old	Mon Dec 17 21:25:24 2001
> +++ drivers/sound/Config.in	Mon Dec 17 21:47:04 2001
> @@ -34,9 +34,21 @@
>  dep_mbool    '    Creative SBLive! MIDI' CONFIG_MIDI_EMU10K1 $CONFIG_SOUND_EMU10K1 $CONFIG_EXPERIMENTAL
>  dep_tristate '  Crystal SoundFusion (CS4280/461x)' CONFIG_SOUND_FUSION $CONFIG_SOUND
>  dep_tristate '  Crystal Sound CS4281' CONFIG_SOUND_CS4281 $CONFIG_SOUND
> -dep_tristate '  Ensoniq AudioPCI (ES1370)' CONFIG_SOUND_ES1370 $CONFIG_SOUND $CONFIG_PCI
> -dep_tristate '  Creative Ensoniq AudioPCI 97 (ES1371)' CONFIG_SOUND_ES1371 $CONFIG_SOUND $CONFIG_PCI
> -dep_tristate '  ESS Technology Solo1' CONFIG_SOUND_ESSSOLO1 $CONFIG_SOUND
> +if [ "$CONFIG_INPUT_GAMEPORT" = "y" ]; then
> +    dep_tristate '  Ensoniq AudioPCI (ES1370)' CONFIG_SOUND_ES1370 $CONFIG_SOUND $CONFIG_PCI
> +else
> +    comment '  Compiled-in Game port support needed for Ensoniq AudioPCI (ES1370)'
> +fi
> +if [ "$CONFIG_INPUT_GAMEPORT" = "y" ]; then
> +    dep_tristate '  Creative Ensoniq AudioPCI 97 (ES1371)' CONFIG_SOUND_ES1371 $CONFIG_SOUND $CONFIG_PCI
> +else
> +    comment '  Compiled-in Game port support needed for Creative Ensoniq AudioPCI 97 (ES1371)'
> +fi
> +if [ "$CONFIG_INPUT_GAMEPORT" = "y" ]; then
> +    dep_tristate '  ESS Technology Solo1' CONFIG_SOUND_ESSSOLO1 $CONFIG_SOUND
> +else
> +    comment '  Compiled-in Game port support needed for ESS Technology Solo1'
> +fi
>  dep_tristate '  ESS Maestro, Maestro2, Maestro2E driver' CONFIG_SOUND_MAESTRO $CONFIG_SOUND
>  dep_tristate '  ESS Maestro3/Allegro driver (EXPERIMENTAL)' CONFIG_SOUND_MAESTRO3 $CONFIG_SOUND $CONFIG_PCI $CONFIG_EXPERIMENTAL
>  dep_tristate '  Intel ICH (i8xx) audio support' CONFIG_SOUND_ICH $CONFIG_PCI
> @@ -44,7 +56,11 @@
>      dep_tristate '  IT8172G Sound' CONFIG_SOUND_IT8172 $CONFIG_SOUND
>  fi
>  dep_tristate '  RME Hammerfall (RME96XX) support' CONFIG_SOUND_RME96XX $CONFIG_SOUND $CONFIG_PCI $CONFIG_EXPERIMENTAL
> -dep_tristate '  S3 SonicVibes' CONFIG_SOUND_SONICVIBES $CONFIG_SOUND
> +if [ "$CONFIG_INPUT_GAMEPORT" = "y" ]; then
> +    dep_tristate '  S3 SonicVibes' CONFIG_SOUND_SONICVIBES $CONFIG_SOUND
> +else
> +    comment '  Compiled-in Game port support needed for S3 SonicVibes'
> +fi
>  if [ "$CONFIG_VISWS" = "y" ]; then
>      dep_tristate '  SGI Visual Workstation Sound' CONFIG_SOUND_VWSND $CONFIG_SOUND
>  fi
> @@ -204,13 +220,3 @@
>  fi
> 
>  dep_tristate '  TV card (bt848) mixer support' CONFIG_SOUND_TVMIXER $CONFIG_SOUND $CONFIG_I2C
> -
> -# A cross directory dependence. The sound modules will need gameport.o compiled in,
> -# but it resides in the drivers/char/joystick directory. This define_tristate takes
> -# care of that. --Vojtech
> -
> -if [ "$CONFIG_INPUT_GAMEPORT" != "n" ]; then
> -  if [ "$CONFIG_SOUND_ESSSOLO1" = "y" -o "$CONFIG_SOUND_ES1370" = "y" -o "$CONFIG_SOUND_ES1371" = "y" -o "$CONFIG_SOUND_SONICVIBES" = "y" ]; then
> -    define_tristate CONFIG_INPUT_GAMEPORT y
> -  fi
> -fi
> 
> cu
> Adrian
> 
> -- 
> 
> Get my GPG key: finger bunk@debian.org | gpg --import
> 
> Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

-- 
Vojtech Pavlik
SuSE Labs
