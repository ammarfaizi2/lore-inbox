Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUDAJIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbUDAJII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:08:08 -0500
Received: from gprs213-219.eurotel.cz ([160.218.213.219]:3713 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262810AbUDAJFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:05:20 -0500
Date: Thu, 1 Apr 2004 11:04:52 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, Tjeerd.Mulder@fujitsu-siemens.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: via82xx cmd line parsing is evil [was Re: Sound on newer arima notebook...]
Message-ID: <20040401090452.GF224@elf.ucw.cz>
References: <20040331145206.GA384@elf.ucw.cz> <s5h7jx1xdel.wl@alsa2.suse.de> <20040401080954.GA464@elf.ucw.cz> <s5hr7v8w1gr.wl@alsa2.suse.de> <20040401082905.GE224@elf.ucw.cz> <s5hptasw0t8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hptasw0t8.wl@alsa2.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > snd-via82xx=enable:1 syntax is ugly, too, and we have better syntax
> > already. via82xx.enable=1 via82xx.ac97_quirk=2 should be possible with
> > new param handling code.
> 
> oh that's good to know.

And here's a patch. It compiles.

--- tmp/linux/sound/pci/via82xx.c	2004-02-20 12:30:04.000000000 +0100
+++ linux/sound/pci/via82xx.c	2004-04-01 10:55:54.000000000 +0200
@@ -51,6 +51,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/gameport.h>
+#include <linux/moduleparam.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -60,9 +61,7 @@
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 
-#if 0
-#define POINTER_DEBUG
-#endif
+#undef POINTER_DEBUG
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("VIA VT82xx audio");
@@ -82,33 +81,36 @@
 static int joystick[SNDRV_CARDS];
 #endif
 static int ac97_clock[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 48000};
-static int ac97_quirk[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = AC97_TUNE_DEFAULT};
-static int dxs_support[SNDRV_CARDS];
+static int ac97_quirk[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
+static int dxs_support[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};
 
-MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+int index_num, mpu_port_num, enable_num, joystick_num, ac97_clock_num, ac97_quirk_num, dxs_support_num;
+
+module_param_array(index, int, index_num, 0666);
 MODULE_PARM_DESC(index, "Index value for VIA 82xx bridge.");
 MODULE_PARM_SYNTAX(index, SNDRV_INDEX_DESC);
 MODULE_PARM(id, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
 MODULE_PARM_DESC(id, "ID string for VIA 82xx bridge.");
 MODULE_PARM_SYNTAX(id, SNDRV_ID_DESC);
-MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+module_param_array(enable, int, enable_num, 0666);
 MODULE_PARM_DESC(enable, "Enable audio part of VIA 82xx bridge.");
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
-MODULE_PARM(mpu_port, "1-" __MODULE_STRING(SNDRV_CARDS) "l");
+module_param_array(mpu_port, long, mpu_port_num, 0666);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port. (VT82C686x only)");
 MODULE_PARM_SYNTAX(mpu_port, SNDRV_PORT_DESC);
 #ifdef SUPPORT_JOYSTICK
+module_param_array(joystick, int, joystick_num, 0666);
 MODULE_PARM(joystick, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(joystick, "Enable joystick. (VT82C686x only)");
 MODULE_PARM_SYNTAX(joystick, SNDRV_ENABLE_DESC "," SNDRV_BOOLEAN_FALSE_DESC);
 #endif
-MODULE_PARM(ac97_clock, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+module_param_array(ac97_clock, int, ac97_clock_num, 0666);
 MODULE_PARM_DESC(ac97_clock, "AC'97 codec clock (default 48000Hz).");
 MODULE_PARM_SYNTAX(ac97_clock, SNDRV_ENABLED ",default:48000");
-MODULE_PARM(ac97_quirk, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+module_param_array(ac97_quirk, int, ac97_quirk_num, 0666);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
 MODULE_PARM_SYNTAX(ac97_quirk, SNDRV_ENABLED ",allows:{{-1,3}},dialog:list,default:-1");
-MODULE_PARM(dxs_support, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+module_param_array(dxs_support, int, dxs_support_num, 0666);
 MODULE_PARM_DESC(dxs_support, "Support for DXS channels (0 = auto, 1 = enable, 2 = disable, 3 = 48k only, 4 = no VRA)");
 MODULE_PARM_SYNTAX(dxs_support, SNDRV_ENABLED ",allows:{{0,4}},dialog:list");
 
@@ -2169,33 +2171,3 @@
 
 module_init(alsa_card_via82xx_init)
 module_exit(alsa_card_via82xx_exit)
-
-#ifndef MODULE
-
-/* format is: snd-via82xx=enable,index,id,
-			  mpu_port,joystick,
-			  ac97_quirk,ac97_clock,dxs_support */
-
-static int __init alsa_card_via82xx_setup(char *str)
-{
-	static unsigned __initdata nr_dev = 0;
-
-	if (nr_dev >= SNDRV_CARDS)
-		return 0;
-	(void)(get_option(&str,&enable[nr_dev]) == 2 &&
-	       get_option(&str,&index[nr_dev]) == 2 &&
-	       get_id(&str,&id[nr_dev]) == 2 &&
-	       get_option_long(&str,&mpu_port[nr_dev]) == 2 &&
-#ifdef SUPPORT_JOYSTICK
-	       get_option(&str,&joystick[nr_dev]) == 2 &&
-#endif
-	       get_option(&str,&ac97_quirk[nr_dev]) == 2 &&
-	       get_option(&str,&ac97_clock[nr_dev]) == 2 &&
-	       get_option(&str,&dxs_support[nr_dev]) == 2);
-	nr_dev++;
-	return 1;
-}
-
-__setup("snd-via82xx=", alsa_card_via82xx_setup);
-
-#endif /* ifndef MODULE */


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
