Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280042AbRKRUSa>; Sun, 18 Nov 2001 15:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRKRUSV>; Sun, 18 Nov 2001 15:18:21 -0500
Received: from fwppp26.fastwave.net ([209.77.31.185]:41600 "EHLO
	p2.alex.fastwave.net") by vger.kernel.org with ESMTP
	id <S280042AbRKRUSK>; Sun, 18 Nov 2001 15:18:10 -0500
Subject: [PATCH] more than four ES1371 cards
To: linux-kernel@vger.kernel.org
Date: Sun, 18 Nov 2001 12:18:05 -0800 (PST)
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E165YOD-0001Hn-00@p2.alex.fastwave.net>
From: Alex Perry <alex.perry@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The standard es1371 card consumes two DSP devices per card,
so that you cannot use more than four of them in a single PC chassis.
This patch adds a configuration option to disable the second DSP output
so that the OSS maximum of eight cards can be installed and used together.

diff -C3 drivers/sound-orig/Config.in drivers/sound/Config.in
*** drivers/sound-orig/Config.in	Fri Nov  2 22:27:34 2001
--- drivers/sound/Config.in	Fri Nov  2 22:30:33 2001
***************
*** 36,41 ****
--- 36,42 ----
  dep_tristate '  Crystal Sound CS4281' CONFIG_SOUND_CS4281 $CONFIG_SOUND
  dep_tristate '  Ensoniq AudioPCI (ES1370)' CONFIG_SOUND_ES1370 $CONFIG_SOUND $CONFIG_PCI
  dep_tristate '  Creative Ensoniq AudioPCI 97 (ES1371)' CONFIG_SOUND_ES1371 $CONFIG_SOUND $CONFIG_PCI
+ dep_mbool    '    Disable second audio output of ES1371' CONFIG_SOUND_ES1371_NODAC $CONFIG_SOUND_ES1371
  dep_tristate '  ESS Technology Solo1' CONFIG_SOUND_ESSSOLO1 $CONFIG_SOUND
  dep_tristate '  ESS Maestro, Maestro2, Maestro2E driver' CONFIG_SOUND_MAESTRO $CONFIG_SOUND
  dep_tristate '  ESS Maestro3/Allegro driver (EXPERIMENTAL)' CONFIG_SOUND_MAESTRO3 $CONFIG_SOUND $CONFIG_PCI $CONFIG_EXPERIMENTAL
Common subdirectories: drivers/sound-orig/cs4281 and drivers/sound/cs4281
Common subdirectories: drivers/sound-orig/dmasound and drivers/sound/dmasound
Common subdirectories: drivers/sound-orig/emu10k1 and drivers/sound/emu10k1
diff -C3 drivers/sound-orig/es1371.c drivers/sound/es1371.c
*** drivers/sound-orig/es1371.c	Fri Nov  2 22:27:34 2001
--- drivers/sound/es1371.c	Fri Nov  2 22:56:56 2001
***************
*** 2858,2865 ****
  		goto err_dev1;
  	if ((res=(s->codec.dev_mixer = register_sound_mixer(&es1371_mixer_fops, -1)) < 0))
  		goto err_dev2;
! 	if ((res=(s->dev_dac = register_sound_dsp(&es1371_dac_fops, -1)) < 0))
! 		goto err_dev3;
  	if ((res=(s->dev_midi = register_sound_midi(&es1371_midi_fops, -1))<0 ))
  		goto err_dev4;
  #ifdef ES1371_DEBUG
--- 2858,2869 ----
  		goto err_dev1;
  	if ((res=(s->codec.dev_mixer = register_sound_mixer(&es1371_mixer_fops, -1)) < 0))
  		goto err_dev2;
! #ifdef CONFIG_SOUND_ES1371_NODAC
!         s->dev_dac = -1;
! #else /* NODAC */
!         if ((res=(s->dev_dac = register_sound_dsp(&es1371_dac_fops, -1)) < 0))
!                 goto err_dev3;
! #endif /* NODAC */
  	if ((res=(s->dev_midi = register_sound_midi(&es1371_midi_fops, -1))<0 ))
  		goto err_dev4;
  #ifdef ES1371_DEBUG
***************
*** 2985,2990 ****
--- 2989,2997 ----
  	if (s->gameport.io)
  		release_region(s->gameport.io, JOY_EXTENT);
   err_dev4:
+ #ifdef CONFIG_SOUND_ES1371_NODAC
+         if ( s->dev_dac != -1 )
+ #endif /* NODAC */
  	unregister_sound_dsp(s->dev_dac);
   err_dev3:
  	unregister_sound_mixer(s->codec.dev_mixer);
***************
*** 3022,3027 ****
--- 3029,3037 ----
  	release_region(s->io, ES1371_EXTENT);
  	unregister_sound_dsp(s->dev_audio);
  	unregister_sound_mixer(s->codec.dev_mixer);
+ #ifdef CONFIG_SOUND_ES1371_NODAC
+         if ( s->dev_dac != -1 )
+ #endif /* NODAC */
  	unregister_sound_dsp(s->dev_dac);
  	unregister_sound_midi(s->dev_midi);
  	kfree(s);
