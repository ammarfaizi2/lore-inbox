Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265343AbUFHVhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbUFHVhc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUFHVhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:37:12 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51938 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S265341AbUFHVZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:25:09 -0400
Date: Wed, 9 Jun 2004 00:25:08 +0300
From: Pekka J Enberg <penberg@cs.helsinki.fi>
Message-Id: <200406082125.i58LP8rC016229@melkki.cs.helsinki.fi>
Subject: [PATCH] ALSA: Remove subsystem-specific malloc (7/8)
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic allocator in remaining places with kcalloc() and kfree().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

 drivers/usb/class/usb-midi.c            |    2 +-
 sound/arm/sa11xx-uda1341.c              |    3 ++-
 sound/pcmcia/pdaudiocf/pdaudiocf.c      |    4 ++--
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c |    2 +-
 sound/pcmcia/vx/vx_entry.c              |    4 ++--
 sound/ppc/pmac.c                        |    4 ++--
 sound/sparc/amd7930.c                   |    4 ++--
 sound/sparc/cs4231.c                    |    8 ++++----
 sound/synth/emux/emux.c                 |    6 +++---
 sound/synth/emux/emux_effect.c          |    2 +-
 sound/synth/emux/emux_seq.c             |   10 +++++-----
 sound/synth/emux/soundfont.c            |    8 ++++----
 sound/synth/util_mem.c                  |    2 +-
 sound/usb/usbaudio.c                    |   10 +++++-----
 sound/usb/usbmidi.c                     |   16 ++++++++--------
 sound/usb/usbmixer.c                    |   24 ++++++++++++------------
 16 files changed, 55 insertions(+), 54 deletions(-)

--- linux-2.6.6/drivers/usb/class/usb-midi.c	2004-06-08 23:56:16.446067336 +0300
+++ alsa-2.6.6/drivers/usb/class/usb-midi.c	2004-06-05 20:27:48.000000000 +0300
@@ -2154,7 +2154,7 @@ int snd_usbmidi_create( snd_card_t * car
 	};
 
 	*rchip = NULL;
-	chip = snd_magic_kcalloc( usbmidi_t, 0, GFP_KERNEL );
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if ( chip == NULL )
 		return -ENOMEM;
 }
--- linux-2.6.6/sound/ppc/pmac.c	2004-06-08 23:57:25.530564896 +0300
+++ alsa-2.6.6/sound/ppc/pmac.c	2004-06-06 22:20:23.000000000 +0300
@@ -801,7 +801,7 @@ static int snd_pmac_free(pmac_t *chip)
 				release_OF_resource(chip->node, i);
 		}
 	}
-	snd_magic_kfree(chip);
+	free(chip);
 	return 0;
 }
 
@@ -1061,7 +1061,7 @@ int __init snd_pmac_new(snd_card_t *card
 	snd_runtime_check(chip_return, return -EINVAL);
 	*chip_return = NULL;
 
-	chip = snd_magic_kcalloc(pmac_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->card = card;
--- linux-2.6.6/sound/sparc/amd7930.c	2004-06-08 23:57:25.577557752 +0300
+++ alsa-2.6.6/sound/sparc/amd7930.c	2004-06-06 22:19:49.000000000 +0300
@@ -946,7 +946,7 @@ static int snd_amd7930_free(amd7930_t *a
 	if (amd->regs)
 		sbus_iounmap(amd->regs, amd->regs_size);
 
-	snd_magic_kfree(amd);
+	kfree(amd);
 
 	return 0;
 }
@@ -975,7 +975,7 @@ static int __init snd_amd7930_create(snd
 	int err;
 
 	*ramd = NULL;
-	amd = snd_magic_kcalloc(amd7930_t, 0, GFP_KERNEL);
+	amd = kcalloc(sizeof(*amd), 0, GFP_KERNEL);
 	if (amd == NULL)
 		return -ENOMEM;
 
--- linux-2.6.6/sound/sparc/cs4231.c	2004-06-08 23:57:25.569558968 +0300
+++ alsa-2.6.6/sound/sparc/cs4231.c	2004-06-06 22:19:40.000000000 +0300
@@ -1949,7 +1949,7 @@ static int snd_cs4231_sbus_free(cs4231_t
 	if (chip->timer)
 		snd_device_free(chip->card, chip->timer);
 
-	snd_magic_kfree(chip);
+	free(chip);
 
 	return 0;
 }
@@ -1974,7 +1974,7 @@ static int __init snd_cs4231_sbus_create
 	int err;
 
 	*rchip = NULL;
-	chip = snd_magic_kcalloc(cs4231_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
@@ -2063,7 +2063,7 @@ static int snd_cs4231_ebus_free(cs4231_t
 	if (chip->timer)
 		snd_device_free(chip->card, chip->timer);
 
-	snd_magic_kfree(chip);
+	kfree(chip);
 
 	return 0;
 }
@@ -2088,7 +2088,7 @@ static int __init snd_cs4231_ebus_create
 	int err;
 
 	*rchip = NULL;
-	chip = snd_magic_kcalloc(cs4231_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 
--- linux-2.6.6/sound/synth/emux/emux.c	2004-06-08 23:57:25.331595144 +0300
+++ alsa-2.6.6/sound/synth/emux/emux.c	2004-06-06 22:19:24.000000000 +0300
@@ -39,7 +39,7 @@ int snd_emux_new(snd_emux_t **remu)
 	snd_emux_t *emu;
 
 	*remu = NULL;
-	emu = snd_magic_kcalloc(snd_emux_t, 0, GFP_KERNEL);
+	emu = kcalloc(sizeof(*emu), GFP_KERNEL);
 	if (emu == NULL)
 		return -ENOMEM;
 
@@ -77,7 +77,7 @@ int snd_emux_register(snd_emux_t *emu, s
 
 	emu->card = card;
 	emu->name = snd_kmalloc_strdup(name, GFP_KERNEL);
-	emu->voices = snd_kcalloc(sizeof(snd_emux_voice_t) * emu->max_voices, GFP_KERNEL);
+	emu->voices = kcalloc(sizeof(snd_emux_voice_t) * emu->max_voices, GFP_KERNEL);
 	if (emu->voices == NULL)
 		return -ENOMEM;
 
@@ -143,7 +143,7 @@ int snd_emux_free(snd_emux_t *emu)
 	if (emu->name)
 		kfree(emu->name);
 
-	snd_magic_kfree(emu);
+	kfree(emu);
 	return 0;
 }
 
--- linux-2.6.6/sound/synth/emux/emux_effect.c	2004-06-08 23:57:25.310598336 +0300
+++ alsa-2.6.6/sound/synth/emux/emux_effect.c	2004-06-06 22:19:00.000000000 +0300
@@ -278,7 +278,7 @@ void
 snd_emux_create_effect(snd_emux_port_t *p)
 {
 	int i;
-	p->effect = snd_kcalloc(sizeof(snd_emux_effect_table_t) * p->chset.max_channels, GFP_KERNEL);
+	p->effect = kcalloc(sizeof(snd_emux_effect_table_t) * p->chset.max_channels, GFP_KERNEL);
 	if (p->effect) {
 		for (i = 0; i < p->chset.max_channels; i++)
 			p->chset.channels[i].private = p->effect + i;
--- linux-2.6.6/sound/synth/emux/emux_seq.c	2004-06-08 23:57:25.311598184 +0300
+++ alsa-2.6.6/sound/synth/emux/emux_seq.c	2004-06-06 22:17:10.000000000 +0300
@@ -146,14 +146,14 @@ snd_emux_create_port(snd_emux_t *emu, ch
 	int i, type, cap;
 
 	/* Allocate structures for this channel */
-	if ((p = snd_magic_kcalloc(snd_emux_port_t, 0, GFP_KERNEL)) == NULL) {
+	if ((p = kcalloc(sizeof(*p), GFP_KERNEL)) == NULL) {
 		snd_printk("no memory\n");
 		return NULL;
 	}
-	p->chset.channels = snd_kcalloc(max_channels * sizeof(snd_midi_channel_t), GFP_KERNEL);
+	p->chset.channels = kcalloc(max_channels * sizeof(snd_midi_channel_t), GFP_KERNEL);
 	if (p->chset.channels == NULL) {
 		snd_printk("no memory\n");
-		snd_magic_kfree(p);
+		kfree(p);
 		return NULL;
 	}
 	for (i = 0; i < max_channels; i++)
@@ -199,7 +199,7 @@ free_port(void *private_data)
 #endif
 		if (p->chset.channels)
 			kfree(p->chset.channels);
-		snd_magic_kfree(p);
+		kfree(p);
 	}
 }
 
@@ -383,7 +383,7 @@ int snd_emux_init_virmidi(snd_emux_t *em
 	if (emu->midi_ports <= 0)
 		return 0;
 
-	emu->vmidi = snd_kcalloc(sizeof(snd_rawmidi_t*) * emu->midi_ports, GFP_KERNEL);
+	emu->vmidi = kcalloc(sizeof(snd_rawmidi_t*) * emu->midi_ports, GFP_KERNEL);
 	if (emu->vmidi == NULL)
 		return -ENOMEM;
 
--- linux-2.6.6/sound/synth/emux/soundfont.c	2004-06-08 23:57:25.332594992 +0300
+++ alsa-2.6.6/sound/synth/emux/soundfont.c	2004-06-05 20:46:49.000000000 +0300
@@ -261,7 +261,7 @@ newsf(snd_sf_list_t *sflist, int type, c
 	}
 
 	/* not found -- create a new one */
-	sf = (snd_soundfont_t*)snd_kcalloc(sizeof(*sf), GFP_KERNEL);
+	sf = kcalloc(sizeof(*sf), GFP_KERNEL);
 	if (sf == NULL)
 		return NULL;
 	sf->id = sflist->fonts_size;
@@ -337,7 +337,7 @@ sf_zone_new(snd_sf_list_t *sflist, snd_s
 {
 	snd_sf_zone_t *zp;
 
-	if ((zp = snd_kcalloc(sizeof(*zp), GFP_KERNEL)) == NULL)
+	if ((zp = kcalloc(sizeof(*zp), GFP_KERNEL)) == NULL)
 		return NULL;
 	zp->next = sf->zones;
 	sf->zones = zp;
@@ -368,7 +368,7 @@ sf_sample_new(snd_sf_list_t *sflist, snd
 {
 	snd_sf_sample_t *sp;
 
-	if ((sp = snd_kcalloc(sizeof(*sp), GFP_KERNEL)) == NULL)
+	if ((sp = kcalloc(sizeof(*sp), GFP_KERNEL)) == NULL)
 		return NULL;
 
 	sp->next = sf->samples;
@@ -1347,7 +1347,7 @@ snd_sf_new(snd_sf_callback_t *callback, 
 {
 	snd_sf_list_t *sflist;
 
-	if ((sflist = snd_kcalloc(sizeof(snd_sf_list_t), GFP_KERNEL)) == NULL)
+	if ((sflist = kcalloc(sizeof(*sflist), GFP_KERNEL)) == NULL)
 		return NULL;
 
 	init_MUTEX(&sflist->presets_mutex);
--- linux-2.6.6/sound/synth/util_mem.c	2004-06-08 23:57:25.361590584 +0300
+++ alsa-2.6.6/sound/synth/util_mem.c	2004-06-06 22:15:55.000000000 +0300
@@ -38,7 +38,7 @@ snd_util_memhdr_new(int memsize)
 {
 	snd_util_memhdr_t *hdr;
 
-	hdr = snd_kcalloc(sizeof(*hdr), GFP_KERNEL);
+	hdr = kcalloc(sizeof(*hdr), GFP_KERNEL);
 	if (hdr == NULL)
 		return NULL;
 	hdr->size = memsize;
--- linux-2.6.6/sound/usb/usbaudio.c	2004-06-08 23:57:25.886510784 +0300
+++ alsa-2.6.6/sound/usb/usbaudio.c	2004-06-08 21:49:36.000000000 +0300
@@ -2062,7 +2062,7 @@ static void snd_usb_audio_stream_free(sn
 	free_substream(&stream->substream[0]);
 	free_substream(&stream->substream[1]);
 	list_del(&stream->list);
-	snd_magic_kfree(stream);
+	kfree(stream);
 }
 
 static void snd_usb_audio_pcm_free(snd_pcm_t *pcm)
@@ -2119,7 +2119,7 @@ static int add_audio_endpoint(snd_usb_au
 	}
 
 	/* create a new pcm */
-	as = snd_magic_kmalloc(snd_usb_stream_t, 0, GFP_KERNEL);
+	as = kmalloc(sizeof(*as), GFP_KERNEL);
 	if (! as)
 		return -ENOMEM;
 	memset(as, 0, sizeof(*as));
@@ -2131,7 +2131,7 @@ static int add_audio_endpoint(snd_usb_au
 			  stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1,
 			  &pcm);
 	if (err < 0) {
-		snd_magic_kfree(as);
+		kfree(as);
 		return err;
 	}
 	as->pcm = pcm;
@@ -2829,7 +2829,7 @@ static void snd_usb_audio_create_proc(sn
 
 static int snd_usb_audio_free(snd_usb_audio_t *chip)
 {
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -2869,7 +2869,7 @@ static int snd_usb_audio_create(struct u
 		return -ENOMEM;
 	}
 
-	chip = snd_magic_kcalloc(snd_usb_audio_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (! chip) {
 		snd_card_free(card);
 		return -ENOMEM;
--- linux-2.6.6/sound/usb/usbmidi.c	2004-06-08 23:57:25.901508504 +0300
+++ alsa-2.6.6/sound/usb/usbmidi.c	2004-06-06 22:26:14.000000000 +0300
@@ -503,7 +503,7 @@ static void snd_usbmidi_in_endpoint_dele
 			kfree(ep->urb->transfer_buffer);
 		usb_free_urb(ep->urb);
 	}
-	snd_magic_kfree(ep);
+	kfree(ep);
 }
 
 /*
@@ -571,7 +571,7 @@ static int snd_usbmidi_in_endpoint_creat
 	int length;
 
 	rep->in = NULL;
-	ep = snd_magic_kcalloc(snd_usb_midi_in_endpoint_t, 0, GFP_KERNEL);
+	ep = kcalloc(sizeof(*ep), GFP_KERNEL);
 	if (!ep)
 		return -ENOMEM;
 	ep->umidi = umidi;
@@ -631,7 +631,7 @@ static void snd_usbmidi_out_endpoint_del
 			kfree(ep->urb->transfer_buffer);
 		usb_free_urb(ep->urb);
 	}
-	snd_magic_kfree(ep);
+	kfree(ep);
 }
 
 /*
@@ -647,7 +647,7 @@ static int snd_usbmidi_out_endpoint_crea
 	void* buffer;
 
 	rep->out = NULL;
-	ep = snd_magic_kcalloc(snd_usb_midi_out_endpoint_t, 0, GFP_KERNEL);
+	ep = kcalloc(sizeof(*ep), GFP_KERNEL);
 	if (!ep)
 		return -ENOMEM;
 	ep->umidi = umidi;
@@ -695,7 +695,7 @@ static void snd_usbmidi_free(snd_usb_mid
 		if (ep->in)
 			snd_usbmidi_in_endpoint_delete(ep->in);
 	}
-	snd_magic_kfree(umidi);
+	kfree(umidi);
 }
 
 /*
@@ -1156,7 +1156,7 @@ int snd_usb_create_midi_interface(snd_us
 	int out_ports, in_ports;
 	int i, err;
 
-	umidi = snd_magic_kcalloc(snd_usb_midi_t, 0, GFP_KERNEL);
+	umidi = kcalloc(sizeof(*umidi), GFP_KERNEL);
 	if (!umidi)
 		return -ENOMEM;
 	umidi->chip = chip;
@@ -1189,7 +1189,7 @@ int snd_usb_create_midi_interface(snd_us
 		}
 	}
 	if (err < 0) {
-		snd_magic_kfree(umidi);
+		kfree(umidi);
 		return err;
 	}
 
@@ -1202,7 +1202,7 @@ int snd_usb_create_midi_interface(snd_us
 	}
 	err = snd_usbmidi_create_rawmidi(umidi, out_ports, in_ports);
 	if (err < 0) {
-		snd_magic_kfree(umidi);
+		kfree(umidi);
 		return err;
 	}
 
--- linux-2.6.6/sound/usb/usbmixer.c	2004-06-08 23:57:25.720536016 +0300
+++ alsa-2.6.6/sound/usb/usbmixer.c	2004-06-06 22:14:38.000000000 +0300
@@ -573,7 +573,7 @@ static struct usb_feature_control_info a
 static void usb_mixer_elem_free(snd_kcontrol_t *kctl)
 {
 	if (kctl->private_data) {
-		snd_magic_kfree((void *)kctl->private_data);
+		kfree((void *)kctl->private_data);
 		kctl->private_data = 0;
 	}
 }
@@ -774,7 +774,7 @@ static void build_feature_ctl(mixer_buil
 	if (check_ignored_ctl(state, unitid, control))
 		return;
 
-	cval = snd_magic_kcalloc(usb_mixer_elem_info_t, 0, GFP_KERNEL);
+	cval = kcalloc(sizeof(*cval), GFP_KERNEL);
 	if (! cval) {
 		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
 		return;
@@ -801,7 +801,7 @@ static void build_feature_ctl(mixer_buil
 	kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
 	if (! kctl) {
 		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
-		snd_magic_kfree(cval);
+		kfree(cval);
 		return;
 	}
 	kctl->private_free = usb_mixer_elem_free;
@@ -943,7 +943,7 @@ static void build_mixer_unit_ctl(mixer_b
 	if (check_ignored_ctl(state, unitid, 0))
 		return;
 
-	cval = snd_magic_kcalloc(usb_mixer_elem_info_t, 0, GFP_KERNEL);
+	cval = kcalloc(sizeof(*cval), GFP_KERNEL);
 	if (! cval)
 		return;
 
@@ -968,7 +968,7 @@ static void build_mixer_unit_ctl(mixer_b
 	kctl = snd_ctl_new1(&usb_feature_unit_ctl, cval);
 	if (! kctl) {
 		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
-		snd_magic_kfree(cval);
+		kfree(cval);
 		return;
 	}
 	kctl->private_free = usb_mixer_elem_free;
@@ -1170,7 +1170,7 @@ static int build_audio_procunit(mixer_bu
 			continue;
 		if (check_ignored_ctl(state, unitid, valinfo->control))
 			continue;
-		cval = snd_magic_kcalloc(usb_mixer_elem_info_t, 0, GFP_KERNEL);
+		cval = kcalloc(sizeof(*cval), GFP_KERNEL);
 		if (! cval) {
 			snd_printk(KERN_ERR "cannot malloc kcontrol\n");
 			return -ENOMEM;
@@ -1195,7 +1195,7 @@ static int build_audio_procunit(mixer_bu
 		kctl = snd_ctl_new1(&mixer_procunit_ctl, cval);
 		if (! kctl) {
 			snd_printk(KERN_ERR "cannot malloc kcontrol\n");
-			snd_magic_kfree(cval);
+			kfree(cval);
 			return -ENOMEM;
 		}
 		kctl->private_free = usb_mixer_elem_free;
@@ -1317,7 +1317,7 @@ static void usb_mixer_selector_elem_free
 	if (kctl->private_data) {
 		usb_mixer_elem_info_t *cval = snd_magic_cast(usb_mixer_elem_info_t, kctl->private_data,);
 		num_ins = cval->max;
-		snd_magic_kfree(cval);
+		kfree(cval);
 		kctl->private_data = 0;
 	}
 	if (kctl->private_value) {
@@ -1357,7 +1357,7 @@ static int parse_audio_selector_unit(mix
 	if (check_ignored_ctl(state, unitid, 0))
 		return 0;
 
-	cval = snd_magic_kcalloc(usb_mixer_elem_info_t, 0, GFP_KERNEL);
+	cval = kcalloc(sizeof(*cval), GFP_KERNEL);
 	if (! cval) {
 		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
 		return -ENOMEM;
@@ -1375,7 +1375,7 @@ static int parse_audio_selector_unit(mix
 	namelist = kmalloc(sizeof(char *) * num_ins, GFP_KERNEL);
 	if (! namelist) {
 		snd_printk(KERN_ERR "cannot malloc\n");
-		snd_magic_kfree(cval);
+		kfree(cval);
 		return -ENOMEM;
 	}
 #define MAX_ITEM_NAME_LEN	64
@@ -1388,7 +1388,7 @@ static int parse_audio_selector_unit(mix
 			while (--i > 0)
 				kfree(namelist[i]);
 			kfree(namelist);
-			snd_magic_kfree(cval);
+			kfree(cval);
 			return -ENOMEM;
 		}
 		if (check_input_term(state, desc[5 + i], &iterm) >= 0)
@@ -1400,7 +1400,7 @@ static int parse_audio_selector_unit(mix
 	kctl = snd_ctl_new1(&mixer_selectunit_ctl, cval);
 	if (! kctl) {
 		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
-		snd_magic_kfree(cval);
+		kfree(cval);
 		return -ENOMEM;
 	}
 	kctl->private_value = (unsigned long)namelist;
--- linux-2.6.6/sound/arm/sa11xx-uda1341.c	2004-06-08 23:57:25.623550760 +0300
+++ alsa-2.6.6/sound/arm/sa11xx-uda1341.c	2004-06-05 20:30:06.000000000 +0300
@@ -964,7 +964,7 @@ static int __init sa11xx_uda1341_init(vo
 	if (card == NULL)
 		return -ENOMEM;
 
-	sa11xx_uda1341 = snd_magic_kcalloc(sa11xx_uda1341_t, 0, GFP_KERNEL);
+	sa11xx_uda1341 = kcalloc(sizeof(*sa11xx_uda1341), GFP_KERNEL);
 	if (sa11xx_uda1341 == NULL)
 		return -ENOMEM;	
 	spin_lock_init(&chip->s[0].dma_lock);
@@ -1010,6 +1010,7 @@ static int __init sa11xx_uda1341_init(vo
 static void __exit sa11xx_uda1341_exit(void)
 {
 	snd_card_free(sa11xx_uda1341->card);
+	kfree(sa11xx_uda1341);
 }
 
 module_init(sa11xx_uda1341_init);
--- linux-2.6.6/sound/pcmcia/pdaudiocf/pdaudiocf.c	2004-06-08 23:57:19.294512920 +0300
+++ alsa-2.6.6/sound/pcmcia/pdaudiocf/pdaudiocf.c	2004-06-05 21:24:01.000000000 +0300
@@ -101,7 +101,7 @@ static int snd_pdacf_free(pdacf_t *pdacf
 	card_list[pdacf->index] = NULL;
 	pdacf->card = NULL;
 
-	snd_magic_kfree(pdacf);
+	kfree(pdacf);
 	return 0;
 }
 
@@ -150,7 +150,7 @@ static dev_link_t *snd_pdacf_attach(void
 		return NULL;
 
 	if (snd_device_new(card, SNDRV_DEV_LOWLEVEL, pdacf, &ops) < 0) {
-		snd_magic_kfree(pdacf);
+		kfree(pdacf);
 		snd_card_free(card);
 		return NULL;
 	}
--- linux-2.6.6/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2004-06-08 23:57:19.363502432 +0300
+++ alsa-2.6.6/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2004-06-06 22:20:37.000000000 +0300
@@ -151,7 +151,7 @@ pdacf_t *snd_pdacf_create(snd_card_t *ca
 {
 	pdacf_t *chip;
 
-	chip = snd_magic_kcalloc(pdacf_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return NULL;
 	chip->card = card;
--- linux-2.6.6/sound/pcmcia/vx/vx_entry.c	2004-06-08 23:57:19.218524472 +0300
+++ alsa-2.6.6/sound/pcmcia/vx/vx_entry.c	2004-06-08 23:49:01.565179280 +0300
@@ -69,7 +69,7 @@ static int snd_vxpocket_free(vx_core_t *
 		hw->card_list[vxp->index] = NULL;
 	chip->card = NULL;
 
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -121,7 +121,7 @@ dev_link_t *snd_vxpocket_attach(struct s
 		return NULL;
 
 	if (snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops) < 0) {
-		snd_magic_kfree(chip);
+		kfree(chip);
 		snd_card_free(card);
 		return NULL;
 	}
