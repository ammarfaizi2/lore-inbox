Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbTGKSMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbTGKSMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:12:09 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12932
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264888AbTGKR6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:58:49 -0400
Date: Fri, 11 Jul 2003 19:12:36 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111812.h6BICa1X017320@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Switch the SB Live! to the new ac97 api
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/emu10k1/efxmgr.c linux-2.5.75-ac1/sound/oss/emu10k1/efxmgr.c
--- linux-2.5.75/sound/oss/emu10k1/efxmgr.c	2003-07-10 21:04:49.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/emu10k1/efxmgr.c	2003-07-11 16:27:04.000000000 +0100
@@ -101,10 +101,10 @@
 {
 	extern char volume_params[SOUND_MIXER_NRDEVICES];
 
-	card->ac97.mixer_state[oss_mixer] = (right << 8) | left;
+	card->ac97->mixer_state[oss_mixer] = (right << 8) | left;
 
 	if (!card->is_aps)
-		card->ac97.write_mixer(&card->ac97, oss_mixer, left, right);
+		card->ac97->write_mixer(card->ac97, oss_mixer, left, right);
 	
 	emu10k1_set_volume_gpr(card, card->mgr.ctrl_gpr[oss_mixer][0], left,
 			       volume_params[oss_mixer]);
@@ -125,7 +125,7 @@
 		right = (val >> 8) & 0xff;
 		val = 0;
 	} else {
-		val = card->ac97.mixer_state[oss_channel];
+		val = card->ac97->mixer_state[oss_channel];
 		left = 0;
 		right = 0;
 	}
@@ -138,8 +138,8 @@
 	int oss_channel = VOLCTRL_CHANNEL;
 	int left, right;
 
-	left = card->ac97.mixer_state[oss_channel] & 0xff;
-	right = (card->ac97.mixer_state[oss_channel] >> 8) & 0xff;
+	left = card->ac97->mixer_state[oss_channel] & 0xff;
+	right = (card->ac97->mixer_state[oss_channel] >> 8) & 0xff;
 
 	if ((left += VOLCTRL_STEP_SIZE) > 100)
 		left = 100;
@@ -155,8 +155,8 @@
 	int oss_channel = VOLCTRL_CHANNEL;
 	int left, right;
 
-	left = card->ac97.mixer_state[oss_channel] & 0xff;
-	right = (card->ac97.mixer_state[oss_channel] >> 8) & 0xff;
+	left = card->ac97->mixer_state[oss_channel] & 0xff;
+	right = (card->ac97->mixer_state[oss_channel] >> 8) & 0xff;
 
 	if ((left -= VOLCTRL_STEP_SIZE) < 0)
 		left = 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/emu10k1/hwaccess.h linux-2.5.75-ac1/sound/oss/emu10k1/hwaccess.h
--- linux-2.5.75/sound/oss/emu10k1/hwaccess.h	2003-07-10 21:08:10.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/emu10k1/hwaccess.h	2003-07-11 16:30:47.000000000 +0100
@@ -162,7 +162,7 @@
 	struct emu10k1_mididevice *seq_mididev;
 #endif
 
-	struct ac97_codec ac97;
+	struct ac97_codec *ac97;
 	int ac97_supported_mixers;
 	int ac97_stereo_mixers;
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/emu10k1/main.c linux-2.5.75-ac1/sound/oss/emu10k1/main.c
--- linux-2.5.75/sound/oss/emu10k1/main.c	2003-07-10 21:15:00.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/emu10k1/main.c	2003-07-11 16:30:47.000000000 +0100
@@ -223,21 +223,31 @@
 {
 	char s[32];
 
-	struct ac97_codec *codec = &card->ac97;
-	card->ac97.dev_mixer = register_sound_mixer(&emu10k1_mixer_fops, -1);
-	if (card->ac97.dev_mixer < 0) {
-		printk(KERN_ERR "emu10k1: cannot register mixer device\n");
+	struct ac97_codec *codec  = ac97_alloc_codec();
+	
+	if(codec == NULL)
+	{
+		printk(KERN_ERR "emu10k1: cannot allocate mixer\n");
 		return -EIO;
+	}
+	card->ac97 = codec;
+	
+#warning "Initialisation order race. Must register after usable"
+
+	card->ac97->dev_mixer = register_sound_mixer(&emu10k1_mixer_fops, -1);
+	if (card->ac97->dev_mixer < 0) {
+		printk(KERN_ERR "emu10k1: cannot register mixer device\n");
+		goto err_codec;
         }
 
-	card->ac97.private_data = card;
+	card->ac97->private_data = card;
 
 	if (!card->is_aps) {
-		card->ac97.id = 0;
-		card->ac97.codec_read = emu10k1_ac97_read;
-        	card->ac97.codec_write = emu10k1_ac97_write;
+		card->ac97->id = 0;
+		card->ac97->codec_read = emu10k1_ac97_read;
+        	card->ac97->codec_write = emu10k1_ac97_write;
 
-		if (ac97_probe_codec (&card->ac97) == 0) {
+		if (ac97_probe_codec (card->ac97) == 0) {
 			printk(KERN_ERR "emu10k1: unable to probe AC97 codec\n");
 			goto err_out;
 		}
@@ -249,7 +259,7 @@
 		}
 
 		// Force 5bit:		    
-		//card->ac97.bit_resolution=5;
+		//card->ac97->bit_resolution=5;
 
 		if (!proc_mkdir ("driver/emu10k1", 0)) {
 			printk(KERN_ERR "emu10k1: unable to create proc directory driver/emu10k1\n");
@@ -263,14 +273,14 @@
 		}
 	
 		sprintf(s, "driver/emu10k1/%s/ac97", card->pci_dev->slot_name);
-		if (!create_proc_read_entry (s, 0, 0, ac97_read_proc, &card->ac97)) {
+		if (!create_proc_read_entry (s, 0, 0, ac97_read_proc, card->ac97)) {
 			printk(KERN_ERR "emu10k1: unable to create proc entry %s\n", s);
 			goto err_ac97_proc;
 		}
 
 		/* these will store the original values and never be modified */
-		card->ac97_supported_mixers = card->ac97.supported_mixers;
-		card->ac97_stereo_mixers = card->ac97.stereo_mixers;
+		card->ac97_supported_mixers = card->ac97->supported_mixers;
+		card->ac97_stereo_mixers = card->ac97->stereo_mixers;
 	}
 
 	return 0;
@@ -282,7 +292,9 @@
  err_emu10k1_proc:
 	remove_proc_entry("driver/emu10k1", NULL);
  err_out:
-	unregister_sound_mixer (card->ac97.dev_mixer);
+	unregister_sound_mixer (card->ac97->dev_mixer);
+ err_codec:
+ 	ac97_release_codec(card->ac97);
 	return -EIO;
 }
 
@@ -300,7 +312,8 @@
 		remove_proc_entry("driver/emu10k1", NULL);
 	}
 
-	unregister_sound_mixer (card->ac97.dev_mixer);
+	unregister_sound_mixer (card->ac97->dev_mixer);
+	ac97_release_codec(card->ac97);
 }
 
 static int __devinit emu10k1_midi_init(struct emu10k1_card *card)
@@ -694,21 +707,21 @@
 	mgr->ctrl_gpr[SOUND_MIXER_VOLUME][0] = 8;
 	mgr->ctrl_gpr[SOUND_MIXER_VOLUME][1] = 9;
 
-	left = card->ac97.mixer_state[SOUND_MIXER_VOLUME] & 0xff;
-	right = (card->ac97.mixer_state[SOUND_MIXER_VOLUME] >> 8) & 0xff;
+	left = card->ac97->mixer_state[SOUND_MIXER_VOLUME] & 0xff;
+	right = (card->ac97->mixer_state[SOUND_MIXER_VOLUME] >> 8) & 0xff;
 
-	emu10k1_set_volume_gpr(card, 8, left, 1 << card->ac97.bit_resolution);
-	emu10k1_set_volume_gpr(card, 9, right, 1 << card->ac97.bit_resolution);
+	emu10k1_set_volume_gpr(card, 8, left, 1 << card->ac97->bit_resolution);
+	emu10k1_set_volume_gpr(card, 9, right, 1 << card->ac97->bit_resolution);
 
 	//Rear volume
 	mgr->ctrl_gpr[ SOUND_MIXER_OGAIN ][0] = 0x19;
 	mgr->ctrl_gpr[ SOUND_MIXER_OGAIN ][1] = 0x1a;
 
 	left = right = 67;
-	card->ac97.mixer_state[SOUND_MIXER_OGAIN] = (right << 8) | left;
+	card->ac97->mixer_state[SOUND_MIXER_OGAIN] = (right << 8) | left;
 
-	card->ac97.supported_mixers |= SOUND_MASK_OGAIN;
-	card->ac97.stereo_mixers |= SOUND_MASK_OGAIN;
+	card->ac97->supported_mixers |= SOUND_MASK_OGAIN;
+	card->ac97->stereo_mixers |= SOUND_MASK_OGAIN;
 
 	emu10k1_set_volume_gpr(card, 0x19, left, VOL_5BIT);
 	emu10k1_set_volume_gpr(card, 0x1a, right, VOL_5BIT);
@@ -717,8 +730,8 @@
 	mgr->ctrl_gpr[SOUND_MIXER_PCM][0] = 6;
 	mgr->ctrl_gpr[SOUND_MIXER_PCM][1] = 7;
 
-	left = card->ac97.mixer_state[SOUND_MIXER_PCM] & 0xff;
-	right = (card->ac97.mixer_state[SOUND_MIXER_PCM] >> 8) & 0xff;
+	left = card->ac97->mixer_state[SOUND_MIXER_PCM] & 0xff;
+	right = (card->ac97->mixer_state[SOUND_MIXER_PCM] >> 8) & 0xff;
 
 	emu10k1_set_volume_gpr(card, 6, left, VOL_5BIT);
 	emu10k1_set_volume_gpr(card, 7, right, VOL_5BIT);
@@ -728,22 +741,22 @@
 	mgr->ctrl_gpr[SOUND_MIXER_DIGITAL1][1] = 0xf;
 
 	left = right = 67;
-	card->ac97.mixer_state[SOUND_MIXER_DIGITAL1] = (right << 8) | left; 
+	card->ac97->mixer_state[SOUND_MIXER_DIGITAL1] = (right << 8) | left; 
 
-	card->ac97.supported_mixers |= SOUND_MASK_DIGITAL1;
-	card->ac97.stereo_mixers |= SOUND_MASK_DIGITAL1;
+	card->ac97->supported_mixers |= SOUND_MASK_DIGITAL1;
+	card->ac97->stereo_mixers |= SOUND_MASK_DIGITAL1;
 
 	emu10k1_set_volume_gpr(card, 0xd, left, VOL_5BIT);
 	emu10k1_set_volume_gpr(card, 0xf, right, VOL_5BIT);
 
 	//hard wire the ac97's pcm, we'll do that in dsp code instead.
-	emu10k1_ac97_write(&card->ac97, 0x18, 0x0);
+	emu10k1_ac97_write(card->ac97, 0x18, 0x0);
 	card->ac97_supported_mixers &= ~SOUND_MASK_PCM;
 	card->ac97_stereo_mixers &= ~SOUND_MASK_PCM;
 
 	//set Igain to 0dB by default, maybe consider hardwiring it here.
-	emu10k1_ac97_write(&card->ac97, AC97_RECORD_GAIN, 0x0000);
-	card->ac97.mixer_state[SOUND_MIXER_IGAIN] = 0x101; 
+	emu10k1_ac97_write(card->ac97, AC97_RECORD_GAIN, 0x0000);
+	card->ac97->mixer_state[SOUND_MIXER_IGAIN] = 0x101; 
 
 	return 0;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/emu10k1/mixer.c linux-2.5.75-ac1/sound/oss/emu10k1/mixer.c
--- linux-2.5.75/sound/oss/emu10k1/mixer.c	2003-07-10 21:12:25.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/emu10k1/mixer.c	2003-07-11 18:29:48.000000000 +0100
@@ -457,29 +457,29 @@
 				break;
 
 			if (addr >= 0) {
-				unsigned int state = card->ac97.mixer_state[id];
+				unsigned int state = card->ac97->mixer_state[id];
 
 				if (ch == 1) {
 					state >>= 8;
-					card->ac97.stereo_mixers |= (1 << id);
+					card->ac97->stereo_mixers |= (1 << id);
 				}
 
-				card->ac97.supported_mixers |= (1 << id);
+				card->ac97->supported_mixers |= (1 << id);
 
 				if (id == SOUND_MIXER_TREBLE) {
-					set_treble(card, card->ac97.mixer_state[id] & 0xff, (card->ac97.mixer_state[id] >> 8) & 0xff);
+					set_treble(card, card->ac97->mixer_state[id] & 0xff, (card->ac97->mixer_state[id] >> 8) & 0xff);
 				} else if (id == SOUND_MIXER_BASS) {
-					set_bass(card, card->ac97.mixer_state[id] & 0xff, (card->ac97.mixer_state[id] >> 8) & 0xff);
+					set_bass(card, card->ac97->mixer_state[id] & 0xff, (card->ac97->mixer_state[id] >> 8) & 0xff);
 				} else
 					emu10k1_set_volume_gpr(card, addr, state & 0xff,
 							       volume_params[id]);
 			} else {
-				card->ac97.stereo_mixers &= ~(1 << id);
-				card->ac97.stereo_mixers |= card->ac97_stereo_mixers;
+				card->ac97->stereo_mixers &= ~(1 << id);
+				card->ac97->stereo_mixers |= card->ac97_stereo_mixers;
 
 				if (ch == 0) {
-					card->ac97.supported_mixers &= ~(1 << id);
-					card->ac97.supported_mixers |= card->ac97_supported_mixers;
+					card->ac97->supported_mixers &= ~(1 << id);
+					card->ac97->supported_mixers |= card->ac97_supported_mixers;
 				}
 			}
 			break;
@@ -500,9 +500,9 @@
 
 		case CMD_AC97_BOOST:
 			if(ctl->val[0])
-				emu10k1_ac97_write(&card->ac97, 0x18, 0x0);	
+				emu10k1_ac97_write(card->ac97, 0x18, 0x0);	
 			else
-				emu10k1_ac97_write(&card->ac97, 0x18, 0x0808);
+				emu10k1_ac97_write(card->ac97, 0x18, 0x0808);
 			break;
 		default:
 			ret = -EINVAL;
@@ -577,7 +577,7 @@
 	int val;
 	int scale;
 
-	card->ac97.modcnt++;
+	card->ac97->modcnt++;
 
 	if (get_user(val, (int *)arg))
 		return -EFAULT;
@@ -589,7 +589,7 @@
 	if (right > 100) right = 100;
 	if (left > 100) left = 100;
 
-	card->ac97.mixer_state[oss_mixer] = (right << 8) | left;
+	card->ac97->mixer_state[oss_mixer] = (right << 8) | left;
 	if (oss_mixer == SOUND_MIXER_TREBLE) {
 		set_treble(card, left, right);
 		return 0;
@@ -599,7 +599,7 @@
 	}
 
 	if (oss_mixer == SOUND_MIXER_VOLUME)
-		scale = 1 << card->ac97.bit_resolution;
+		scale = 1 << card->ac97->bit_resolution;
 	else
 		scale = volume_params[oss_mixer];
 
@@ -607,7 +607,7 @@
 	emu10k1_set_volume_gpr(card, card->mgr.ctrl_gpr[oss_mixer][1], right, scale);
 
 	if (card->ac97_supported_mixers & (1 << oss_mixer))
-		card->ac97.write_mixer(&card->ac97, oss_mixer, left, right);
+		card->ac97->write_mixer(card->ac97, oss_mixer, left, right);
 
 	return 0;
 }
@@ -623,9 +623,9 @@
 		if (cmd == SOUND_MIXER_INFO) {
 			mixer_info info;
 
-			strlcpy(info.id, card->ac97.name, sizeof(info.id));
-			strlcpy(info.name, "Creative SBLive - Emu10k1", sizeof(info.name));
-			info.modify_counter = card->ac97.modcnt;
+			strncpy(info.id, card->ac97->name, sizeof(info.id));
+			strncpy(info.name, "Creative SBLive - Emu10k1", sizeof(info.name));
+			info.modify_counter = card->ac97->modcnt;
 
 			if (copy_to_user((void *)arg, &info, sizeof(info)))
 				return -EFAULT;
@@ -636,7 +636,7 @@
 		if ((_SIOC_DIR(cmd) == (_SIOC_WRITE|_SIOC_READ)) && oss_mixer <= SOUND_MIXER_NRDEVICES)
 			ret = emu10k1_dsp_mixer(card, oss_mixer, arg);
 		else
-			ret = card->ac97.mixer_ioctl(&card->ac97, cmd, arg);
+			ret = card->ac97->mixer_ioctl(card->ac97, cmd, arg);
 	}
 	
 	if (ret < 0)
@@ -656,7 +656,7 @@
 	list_for_each(entry, &emu10k1_devs) {
 		card = list_entry(entry, struct emu10k1_card, list);
 
-		if (card->ac97.dev_mixer == minor)
+		if (card->ac97->dev_mixer == minor)
 			goto match;
 	}
 
