Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265316AbUFHV2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUFHV2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUFHV2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:28:14 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51938 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S265316AbUFHVY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:24:59 -0400
Date: Wed, 9 Jun 2004 00:24:58 +0300
From: Pekka J Enberg <penberg@cs.helsinki.fi>
Message-Id: <200406082124.i58LOwxa016174@melkki.cs.helsinki.fi>
Subject: [PATCH] ALSA: Remove subsystem-specific malloc (2/8)
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic allocator in linux/sound/core/ with kcalloc() and kfree().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

 control.c                |   17 +++++++----------
 device.c                 |    4 ++--
 hwdep.c                  |    4 ++--
 info.c                   |   26 ++++++++++++--------------
 init.c                   |    2 +-
 ioctl32/pcm32.c          |    4 ++--
 oss/mixer_oss.c          |   32 ++++++++++++++++----------------
 oss/pcm_oss.c            |    4 ++--
 oss/pcm_plugin.c         |    8 ++++----
 oss/pcm_plugin.h         |    2 +-
 oss/route.c              |    2 +-
 pcm.c                    |   12 ++++++------
 pcm_lib.c                |    2 +-
 pcm_native.c             |    6 +++---
 rawmidi.c                |   16 ++++++++--------
 seq/instr/ainstr_gf1.c   |    2 +-
 seq/instr/ainstr_iw.c    |    6 +++---
 seq/oss/seq_oss_init.c   |    2 +-
 seq/oss/seq_oss_midi.c   |    2 +-
 seq/oss/seq_oss_readq.c  |    4 ++--
 seq/oss/seq_oss_synth.c  |    8 +++++---
 seq/oss/seq_oss_timer.c  |    2 +-
 seq/oss/seq_oss_writeq.c |    2 +-
 seq/seq_clientmgr.c      |    2 +-
 seq/seq_device.c         |    4 ++--
 seq/seq_dummy.c          |    6 +++---
 seq/seq_fifo.c           |    2 +-
 seq/seq_instr.c          |    9 +++------
 seq/seq_memory.c         |    2 +-
 seq/seq_midi.c           |    4 ++--
 seq/seq_midi_event.c     |    2 +-
 seq/seq_ports.c          |    4 ++--
 seq/seq_prioq.c          |    2 +-
 seq/seq_queue.c          |    2 +-
 seq/seq_timer.c          |    2 +-
 seq/seq_virmidi.c        |   16 ++++++++--------
 timer.c                  |   14 +++++++-------
 37 files changed, 117 insertions(+), 123 deletions(-)

--- linux-2.6.6/sound/core/control.c	2004-06-08 23:57:22.835974536 +0300
+++ alsa-2.6.6/sound/core/control.c	2004-06-05 21:15:19.000000000 +0300
@@ -62,7 +62,7 @@ static int snd_ctl_open(struct inode *in
 		err = -EFAULT;
 		goto __error2;
 	}
-	ctl = snd_magic_kcalloc(snd_ctl_file_t, 0, GFP_KERNEL);
+	ctl = kcalloc(sizeof(*ctl), GFP_KERNEL);
 	if (ctl == NULL) {
 		err = -ENOMEM;
 		goto __error;
@@ -124,7 +124,7 @@ static int snd_ctl_release(struct inode 
 	}
 	up_write(&card->controls_rwsem);
 	snd_ctl_empty_read_queue(ctl);
-	snd_magic_kfree(ctl);
+	kfree(ctl);
 	module_put(card->module);
 	snd_card_file_remove(card, file);
 	return 0;
@@ -155,7 +155,7 @@ void snd_ctl_notify(snd_card_t *card, un
 				goto _found;
 			}
 		}
-		ev = snd_kcalloc(sizeof(*ev), GFP_ATOMIC);
+		ev = kcalloc(sizeof(*ev), GFP_ATOMIC);
 		if (ev) {
 			ev->id = *id;
 			ev->mask = mask;
@@ -188,9 +188,7 @@ snd_kcontrol_t *snd_ctl_new(snd_kcontrol
 	
 	snd_runtime_check(control != NULL, return NULL);
 	snd_runtime_check(control->count > 0, return NULL);
-	kctl = (snd_kcontrol_t *)snd_magic_kcalloc(snd_kcontrol_t,
-						   sizeof(snd_kcontrol_volatile_t) * control->count,
-						   GFP_KERNEL);
+	kctl = kcalloc(sizeof(*kctl) + sizeof(snd_kcontrol_volatile_t) * control->count, GFP_KERNEL);
 	if (kctl == NULL)
 		return NULL;
 	*kctl = *control;
@@ -249,7 +247,7 @@ void snd_ctl_free_one(snd_kcontrol_t * k
 	if (kcontrol) {
 		if (kcontrol->private_free)
 			kcontrol->private_free(kcontrol);
-		snd_magic_kfree(kcontrol);
+		kfree(kcontrol);
 	}
 }
 
@@ -927,7 +925,7 @@ static int snd_ctl_elem_add(snd_ctl_file
 	if (!(info.access & SNDRV_CTL_ELEM_ACCESS_DINDIRECT))
 		for (idx = 0; idx < 4 && info.dimen.d[idx]; idx++)
 			dimen_size += sizeof(unsigned short);
-	ue = snd_kcalloc(sizeof(struct user_element) + dimen_size + private_size + extra_size, GFP_KERNEL);
+	ue = kcalloc(sizeof(struct user_element) + dimen_size + private_size + extra_size, GFP_KERNEL);
 	if (ue == NULL)
 		return -ENOMEM;
 	ue->type = info.type;
@@ -1145,8 +1143,7 @@ int snd_ctl_register_ioctl(snd_kctl_ioct
 {
 	snd_kctl_ioctl_t *pn;
 
-	pn = (snd_kctl_ioctl_t *)
-		snd_kcalloc(sizeof(snd_kctl_ioctl_t), GFP_KERNEL);
+	pn = kcalloc(sizeof(snd_kctl_ioctl_t), GFP_KERNEL);
 	if (pn == NULL)
 		return -ENOMEM;
 	pn->fioctl = fcn;
--- linux-2.6.6/sound/core/oss/pcm_plugin.c	2004-06-08 23:57:22.501025456 +0300
+++ alsa-2.6.6/sound/core/oss/pcm_plugin.c	2004-06-05 20:55:08.000000000 +0300
@@ -172,7 +172,7 @@ int snd_pcm_plugin_build(snd_pcm_plug_t 
 	
 	snd_assert(plug != NULL, return -ENXIO);
 	snd_assert(src_format != NULL && dst_format != NULL, return -ENXIO);
-	plugin = (snd_pcm_plugin_t *)snd_kcalloc(sizeof(*plugin) + extra, GFP_KERNEL);
+	plugin = kcalloc(sizeof(*plugin) + extra, GFP_KERNEL);
 	if (plugin == NULL)
 		return -ENOMEM;
 	plugin->name = name;
@@ -189,7 +189,7 @@ int snd_pcm_plugin_build(snd_pcm_plug_t 
 		channels = src_format->channels;
 	else
 		channels = dst_format->channels;
-	plugin->buf_channels = snd_kcalloc(channels * sizeof(*plugin->buf_channels), GFP_KERNEL);
+	plugin->buf_channels = kcalloc(channels * sizeof(*plugin->buf_channels), GFP_KERNEL);
 	if (plugin->buf_channels == NULL) {
 		snd_pcm_plugin_free(plugin);
 		return -ENOMEM;
@@ -468,7 +468,7 @@ int snd_pcm_plug_format_plugins(snd_pcm_
 	if (srcformat.channels > dstformat.channels) {
 		int sv = srcformat.channels;
 		int dv = dstformat.channels;
-		route_ttable_entry_t *ttable = snd_kcalloc(dv*sv*sizeof(*ttable), GFP_KERNEL);
+		route_ttable_entry_t *ttable = kcalloc(dv*sv*sizeof(*ttable), GFP_KERNEL);
 		if (ttable == NULL)
 			return -ENOMEM;
 #if 1
@@ -531,7 +531,7 @@ int snd_pcm_plug_format_plugins(snd_pcm_
 	if (srcformat.channels < dstformat.channels) {
 		int sv = srcformat.channels;
 		int dv = dstformat.channels;
-		route_ttable_entry_t *ttable = snd_kcalloc(dv * sv * sizeof(*ttable), GFP_KERNEL);
+		route_ttable_entry_t *ttable = kcalloc(dv * sv * sizeof(*ttable), GFP_KERNEL);
 		if (ttable == NULL)
 			return -ENOMEM;
 #if 0
--- linux-2.6.6/sound/core/oss/pcm_plugin.h	2004-06-08 23:57:22.562016184 +0300
+++ alsa-2.6.6/sound/core/oss/pcm_plugin.h	2004-06-05 20:55:19.000000000 +0300
@@ -35,7 +35,7 @@ static inline size_t bitset_size(int nbi
 
 static inline bitset_t *bitset_alloc(int nbits)
 {
-	return snd_kcalloc(bitset_size(nbits) * sizeof(bitset_t), GFP_KERNEL);
+	return kcalloc(bitset_size(nbits) * sizeof(bitset_t), GFP_KERNEL);
 }
 	
 static inline void bitset_set(bitset_t *bitmap, unsigned int pos)
--- linux-2.6.6/sound/core/oss/route.c	2004-06-08 23:57:22.659001440 +0300
+++ alsa-2.6.6/sound/core/oss/route.c	2004-06-05 20:54:15.000000000 +0300
@@ -458,7 +458,7 @@ static int route_load_ttable(snd_pcm_plu
 			dptr->func = route_to_channel;
 		if (nsrcs > 0) {
                         int srcidx;
-			dptr->srcs = snd_kcalloc(nsrcs * sizeof(*srcs), GFP_KERNEL);
+			dptr->srcs = kcalloc(nsrcs * sizeof(*srcs), GFP_KERNEL);
                         for(srcidx = 0; srcidx < nsrcs; srcidx++)
 				dptr->srcs[srcidx] = srcs[srcidx];
 		} else
--- linux-2.6.6/sound/core/pcm.c	2004-06-08 23:57:23.321900664 +0300
+++ alsa-2.6.6/sound/core/pcm.c	2004-06-06 22:32:22.000000000 +0300
@@ -584,7 +584,7 @@ int snd_pcm_new_stream(snd_pcm_t *pcm, i
 	}
 	prev = NULL;
 	for (idx = 0, prev = NULL; idx < substream_count; idx++) {
-		substream = snd_magic_kcalloc(snd_pcm_substream_t, 0, GFP_KERNEL);
+		substream = kcalloc(sizeof(*substream), GFP_KERNEL);
 		if (substream == NULL)
 			return -ENOMEM;
 		substream->pcm = pcm;
@@ -599,7 +599,7 @@ int snd_pcm_new_stream(snd_pcm_t *pcm, i
 			prev->next = substream;
 		err = snd_pcm_substream_proc_init(substream);
 		if (err < 0) {
-			snd_magic_kfree(substream);
+			kfree(substream);
 			return err;
 		}
 		substream->group = &substream->self_group;
@@ -644,7 +644,7 @@ int snd_pcm_new(snd_card_t * card, char 
 	snd_assert(rpcm != NULL, return -EINVAL);
 	*rpcm = NULL;
 	snd_assert(card != NULL, return -ENXIO);
-	pcm = snd_magic_kcalloc(snd_pcm_t, 0, GFP_KERNEL);
+	pcm = kcalloc(sizeof(*pcm), GFP_KERNEL);
 	if (pcm == NULL)
 		return -ENOMEM;
 	pcm->card = card;
@@ -680,7 +680,7 @@ static void snd_pcm_free_stream(snd_pcm_
 	while (substream) {
 		substream_next = substream->next;
 		snd_pcm_substream_proc_done(substream);
-		snd_magic_kfree(substream);
+		kfree(substream);
 		substream = substream_next;
 	}
 	snd_pcm_stream_proc_done(pstr);
@@ -701,7 +701,7 @@ static int snd_pcm_free(snd_pcm_t *pcm)
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 	snd_pcm_free_stream(&pcm->streams[SNDRV_PCM_STREAM_PLAYBACK]);
 	snd_pcm_free_stream(&pcm->streams[SNDRV_PCM_STREAM_CAPTURE]);
-	snd_magic_kfree(pcm);
+	kfree(pcm);
 	return 0;
 }
 
@@ -782,7 +782,7 @@ int snd_pcm_open_substream(snd_pcm_t *pc
 	if (substream == NULL)
 		return -EAGAIN;
 
-	runtime = snd_kcalloc(sizeof(snd_pcm_runtime_t), GFP_KERNEL);
+	runtime = kcalloc(sizeof(*runtime), GFP_KERNEL);
 	if (runtime == NULL)
 		return -ENOMEM;
 
--- linux-2.6.6/sound/core/pcm_lib.c	2004-06-08 23:57:23.004948848 +0300
+++ alsa-2.6.6/sound/core/pcm_lib.c	2004-06-05 20:52:58.000000000 +0300
@@ -894,7 +894,7 @@ int snd_pcm_hw_rule_add(snd_pcm_runtime_
 			old = constrs->rules;
 			constrs->rules_all += 10;
 		}
-		constrs->rules = snd_kcalloc(constrs->rules_all * sizeof(*c),
+		constrs->rules = kcalloc(constrs->rules_all * sizeof(*c),
 					     GFP_KERNEL);
 		if (!constrs->rules)
 			return -ENOMEM;
--- linux-2.6.6/sound/core/pcm_native.c	2004-06-08 23:57:22.909963288 +0300
+++ alsa-2.6.6/sound/core/pcm_native.c	2004-06-05 21:13:50.000000000 +0300
@@ -1923,7 +1923,7 @@ static int snd_pcm_release_file(snd_pcm_
 	substream->ffile = NULL;
 	snd_pcm_remove_file(str, pcm_file);
 	snd_pcm_release_substream(substream);
-	snd_magic_kfree(pcm_file);
+	kfree(pcm_file);
 	return 0;
 }
 
@@ -1940,13 +1940,13 @@ static int snd_pcm_open_file(struct file
 	snd_assert(rpcm_file != NULL, return -EINVAL);
 	*rpcm_file = NULL;
 
-	pcm_file = snd_magic_kcalloc(snd_pcm_file_t, 0, GFP_KERNEL);
+	pcm_file = kcalloc(sizeof(*pcm_file), GFP_KERNEL);
 	if (pcm_file == NULL) {
 		return -ENOMEM;
 	}
 
 	if ((err = snd_pcm_open_substream(pcm, stream, &substream)) < 0) {
-		snd_magic_kfree(pcm_file);
+		kfree(pcm_file);
 		return err;
 	}
 
--- linux-2.6.6/sound/core/rawmidi.c	2004-06-08 23:57:22.745988216 +0300
+++ alsa-2.6.6/sound/core/rawmidi.c	2004-06-06 19:50:45.000000000 +0300
@@ -267,7 +267,7 @@ int snd_rawmidi_kernel_open(int cardnum,
 		list2 = list2->next;
 	}
 	if (mode & SNDRV_RAWMIDI_LFLG_INPUT) {
-		input = snd_kcalloc(sizeof(snd_rawmidi_runtime_t), GFP_KERNEL);
+		input = kcalloc(sizeof(*input), GFP_KERNEL);
 		if (input == NULL) {
 			err = -ENOMEM;
 			goto __error;
@@ -289,7 +289,7 @@ int snd_rawmidi_kernel_open(int cardnum,
 	if (mode & SNDRV_RAWMIDI_LFLG_OUTPUT) {
 		if (soutput->opened)
 			goto __skip_output;
-		output = snd_kcalloc(sizeof(snd_rawmidi_runtime_t), GFP_KERNEL);
+		output = kcalloc(sizeof(*output), GFP_KERNEL);
 		if (output == NULL) {
 			err = -ENOMEM;
 			goto __error;
@@ -396,7 +396,7 @@ static int snd_rawmidi_open(struct inode
 	if ((file->f_flags & O_APPEND) || maj != CONFIG_SND_MAJOR) /* OSS emul? */
 		fflags |= SNDRV_RAWMIDI_LFLG_APPEND;
 	fflags |= SNDRV_RAWMIDI_LFLG_NOOPENLOCK;
-	rawmidi_file = snd_magic_kmalloc(snd_rawmidi_file_t, 0, GFP_KERNEL);
+	rawmidi_file = kcalloc(sizeof(*rawmidi_file), GFP_KERNEL);
 	if (rawmidi_file == NULL) {
 		snd_card_file_remove(card, file);
 		return -ENOMEM;
@@ -445,7 +445,7 @@ static int snd_rawmidi_open(struct inode
 		file->private_data = rawmidi_file;
 	} else {
 		snd_card_file_remove(card, file);
-		snd_magic_kfree(rawmidi_file);
+		kfree(rawmidi_file);
 	}
 	up(&rmidi->open_mutex);
 	return err;
@@ -514,7 +514,7 @@ static int snd_rawmidi_release(struct in
 	err = snd_rawmidi_kernel_release(rfile);
 	rmidi = rfile->rmidi;
 	wake_up(&rmidi->open_wait);
-	snd_magic_kfree(rfile);
+	kfree(rfile);
 	snd_card_file_remove(rmidi->card, file);
 	return err;
 }
@@ -1349,7 +1349,7 @@ static int snd_rawmidi_alloc_substreams(
 
 	INIT_LIST_HEAD(&stream->substreams);
 	for (idx = 0; idx < count; idx++) {
-		substream = snd_kcalloc(sizeof(snd_rawmidi_substream_t), GFP_KERNEL);
+		substream = kcalloc(sizeof(*substream), GFP_KERNEL);
 		if (substream == NULL)
 			return -ENOMEM;
 		substream->stream = direction;
@@ -1392,7 +1392,7 @@ int snd_rawmidi_new(snd_card_t * card, c
 	snd_assert(rrawmidi != NULL, return -EINVAL);
 	*rrawmidi = NULL;
 	snd_assert(card != NULL, return -ENXIO);
-	rmidi = snd_magic_kcalloc(snd_rawmidi_t, 0, GFP_KERNEL);
+	rmidi = kcalloc(sizeof(*rmidi), GFP_KERNEL);
 	if (rmidi == NULL)
 		return -ENOMEM;
 	rmidi->card = card;
@@ -1435,7 +1435,7 @@ static int snd_rawmidi_free(snd_rawmidi_
 	snd_rawmidi_free_substreams(&rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT]);
 	if (rmidi->private_free)
 		rmidi->private_free(rmidi);
-	snd_magic_kfree(rmidi);
+	kfree(rmidi);
 	return 0;
 }
 
--- linux-2.6.6/sound/core/seq/instr/ainstr_gf1.c	2004-06-08 23:57:22.170075768 +0300
+++ alsa-2.6.6/sound/core/seq/instr/ainstr_gf1.c	2004-06-05 20:57:08.000000000 +0300
@@ -64,7 +64,7 @@ static int snd_seq_gf1_copy_wave_from_st
 		return -EFAULT;
 	*data += sizeof(xp);
 	*len -= sizeof(xp);
-	wp = (gf1_wave_t *)snd_kcalloc(sizeof(*wp), gfp_mask);
+	wp = kcalloc(sizeof(*wp), gfp_mask);
 	if (wp == NULL)
 		return -ENOMEM;
 	wp->share_id[0] = le32_to_cpu(xp.share_id[0]);
--- linux-2.6.6/sound/core/seq/instr/ainstr_iw.c	2004-06-08 23:57:22.169075920 +0300
+++ alsa-2.6.6/sound/core/seq/instr/ainstr_iw.c	2004-06-05 20:57:35.000000000 +0300
@@ -96,7 +96,7 @@ static int snd_seq_iwffff_copy_env_from_
 		points_size = (le16_to_cpu(rx.nattack) + le16_to_cpu(rx.nrelease)) * 2 * sizeof(__u16);
 		if (points_size > *len)
 			return -EINVAL;
-		rp = (iwffff_env_record_t *)snd_kcalloc(sizeof(*rp) + points_size, gfp_mask);
+		rp = kcalloc(sizeof(*rp) + points_size, gfp_mask);
 		if (rp == NULL)
 			return -ENOMEM;
 		rp->nattack = le16_to_cpu(rx.nattack);
@@ -142,7 +142,7 @@ static int snd_seq_iwffff_copy_wave_from
 		return -EFAULT;
 	*data += sizeof(xp);
 	*len -= sizeof(xp);
-	wp = (iwffff_wave_t *)snd_kcalloc(sizeof(*wp), gfp_mask);
+	wp = kcalloc(sizeof(*wp), gfp_mask);
 	if (wp == NULL)
 		return -ENOMEM;
 	wp->share_id[0] = le32_to_cpu(xp.share_id[0]);
@@ -274,7 +274,7 @@ static int snd_seq_iwffff_put(void *priv
 			snd_seq_iwffff_instr_free(ops, ip, atomic);
 			return -EINVAL;
 		}
-		lp = (iwffff_layer_t *)snd_kcalloc(sizeof(*lp), gfp_mask);
+		lp = kcalloc(sizeof(*lp), gfp_mask);
 		if (lp == NULL) {
 			snd_seq_iwffff_instr_free(ops, ip, atomic);
 			return -ENOMEM;
--- linux-2.6.6/sound/core/seq/oss/seq_oss_init.c	2004-06-08 23:57:21.985103888 +0300
+++ alsa-2.6.6/sound/core/seq/oss/seq_oss_init.c	2004-06-05 21:00:40.000000000 +0300
@@ -182,7 +182,7 @@ snd_seq_oss_open(struct file *file, int 
 	int i, rc;
 	seq_oss_devinfo_t *dp;
 
-	if ((dp = snd_kcalloc(sizeof(*dp), GFP_KERNEL)) == NULL) {
+	if ((dp = kcalloc(sizeof(*dp), GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc device info\n");
 		return -ENOMEM;
 	}
--- linux-2.6.6/sound/core/device.c	2004-06-08 23:57:23.021946264 +0300
+++ alsa-2.6.6/sound/core/device.c	2004-06-05 21:13:35.000000000 +0300
@@ -47,7 +47,7 @@ int snd_device_new(snd_card_t *card, snd
 	snd_device_t *dev;
 
 	snd_assert(card != NULL && device_data != NULL && ops != NULL, return -ENXIO);
-	dev = (snd_device_t *) snd_magic_kcalloc(snd_device_t, 0, GFP_KERNEL);
+	dev = kcalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL)
 		return -ENOMEM;
 	dev->card = card;
@@ -94,7 +94,7 @@ int snd_device_free(snd_card_t *card, vo
 					snd_printk(KERN_ERR "device free failure\n");
 			}
 		}
-		snd_magic_kfree(dev);
+		kfree(dev);
 		return 0;
 	}
 	snd_printd("device free %p (from %p), not found\n", device_data, __builtin_return_address(0));
--- linux-2.6.6/sound/core/seq/oss/seq_oss_midi.c	2004-06-08 23:57:21.845125168 +0300
+++ alsa-2.6.6/sound/core/seq/oss/seq_oss_midi.c	2004-06-06 22:45:55.000000000 +0300
@@ -171,7 +171,7 @@ snd_seq_oss_midi_check_new_port(snd_seq_
 	/*
 	 * allocate midi info record
 	 */
-	if ((mdev = snd_kcalloc(sizeof(*mdev), GFP_KERNEL)) == NULL) {
+	if ((mdev = kcalloc(sizeof(*mdev), GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc midi info\n");
 		return -ENOMEM;
 	}
--- linux-2.6.6/sound/core/seq/oss/seq_oss_readq.c	2004-06-08 23:57:22.012099784 +0300
+++ alsa-2.6.6/sound/core/seq/oss/seq_oss_readq.c	2004-06-05 21:00:26.000000000 +0300
@@ -45,12 +45,12 @@ snd_seq_oss_readq_new(seq_oss_devinfo_t 
 {
 	seq_oss_readq_t *q;
 
-	if ((q = snd_kcalloc(sizeof(*q), GFP_KERNEL)) == NULL) {
+	if ((q = kcalloc(sizeof(*q), GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc read queue\n");
 		return NULL;
 	}
 
-	if ((q->q = snd_kcalloc(sizeof(evrec_t) * maxlen, GFP_KERNEL)) == NULL) {
+	if ((q->q = kcalloc(sizeof(evrec_t) * maxlen, GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc read queue buffer\n");
 		kfree(q);
 		return NULL;
--- linux-2.6.6/sound/core/seq/oss/seq_oss_synth.c	2004-06-08 23:57:21.857123344 +0300
+++ alsa-2.6.6/sound/core/seq/oss/seq_oss_synth.c	2004-06-05 20:32:28.000000000 +0300
@@ -103,7 +103,7 @@ snd_seq_oss_synth_register(snd_seq_devic
 	snd_seq_oss_reg_t *reg = SNDRV_SEQ_DEVICE_ARGPTR(dev);
 	unsigned long flags;
 
-	if ((rec = snd_kcalloc(sizeof(*rec), GFP_KERNEL)) == NULL) {
+	if ((rec = kcalloc(sizeof(*rec), GFP_KERNEL)) == NULL) {
 		snd_printk(KERN_ERR "can't malloc synth info\n");
 		return -ENOMEM;
 	}
@@ -244,7 +244,9 @@ snd_seq_oss_synth_setup(seq_oss_devinfo_
 		}
 		info->nr_voices = rec->nr_voices;
 		if (info->nr_voices > 0) {
-			info->ch = snd_kcalloc(sizeof(seq_oss_chinfo_t) * info->nr_voices, GFP_KERNEL);
+			info->ch = kcalloc(sizeof(seq_oss_chinfo_t) * info->nr_voices, GFP_KERNEL);
+			if (!info->ch)
+				BUG();
 			reset_channels(info);
 		}
 		debug_printk(("synth %d assigned\n", i));
@@ -505,7 +507,7 @@ snd_seq_oss_synth_sysex(seq_oss_devinfo_
 
 	sysex = dp->synths[dev].sysex;
 	if (sysex == NULL) {
-		sysex = snd_kcalloc(sizeof(*sysex), GFP_KERNEL);
+		sysex = kcalloc(sizeof(*sysex), GFP_KERNEL);
 		if (sysex == NULL)
 			return -ENOMEM;
 		dp->synths[dev].sysex = sysex;
--- linux-2.6.6/sound/core/seq/oss/seq_oss_timer.c	2004-06-08 23:57:22.012099784 +0300
+++ alsa-2.6.6/sound/core/seq/oss/seq_oss_timer.c	2004-06-05 21:00:47.000000000 +0300
@@ -46,7 +46,7 @@ snd_seq_oss_timer_new(seq_oss_devinfo_t 
 {
 	seq_oss_timer_t *rec;
 
-	rec = snd_kcalloc(sizeof(*rec), GFP_KERNEL);
+	rec = kcalloc(sizeof(*rec), GFP_KERNEL);
 	if (rec == NULL)
 		return NULL;
 
--- linux-2.6.6/sound/core/seq/oss/seq_oss_writeq.c	2004-06-08 23:57:22.071090816 +0300
+++ alsa-2.6.6/sound/core/seq/oss/seq_oss_writeq.c	2004-06-05 21:00:17.000000000 +0300
@@ -37,7 +37,7 @@ snd_seq_oss_writeq_new(seq_oss_devinfo_t
 	seq_oss_writeq_t *q;
 	snd_seq_client_pool_t pool;
 
-	if ((q = snd_kcalloc(sizeof(*q), GFP_KERNEL)) == NULL)
+	if ((q = kcalloc(sizeof(*q), GFP_KERNEL)) == NULL)
 		return NULL;
 	q->dp = dp;
 	q->maxlen = maxlen;
--- linux-2.6.6/sound/core/seq/seq_clientmgr.c	2004-06-08 23:57:22.131081696 +0300
+++ alsa-2.6.6/sound/core/seq/seq_clientmgr.c	2004-06-05 20:59:12.000000000 +0300
@@ -202,7 +202,7 @@ static client_t *seq_create_client1(int 
 	client_t *client;
 
 	/* init client data */
-	client = snd_kcalloc(sizeof(client_t), GFP_KERNEL);
+	client = kcalloc(sizeof(*client), GFP_KERNEL);
 	if (client == NULL)
 		return NULL;
 	client->pool = snd_seq_pool_new(poolsize);
--- linux-2.6.6/sound/core/seq/seq_device.c	2004-06-08 23:57:22.132081544 +0300
+++ alsa-2.6.6/sound/core/seq/seq_device.c	2004-06-05 21:19:02.000000000 +0300
@@ -181,7 +181,7 @@ int snd_seq_device_new(snd_card_t *card,
 	if (ops == NULL)
 		return -ENOMEM;
 
-	dev = snd_magic_kcalloc(snd_seq_device_t, sizeof(*dev) + argsize, GFP_KERNEL);
+	dev = kcalloc(sizeof(*dev) + sizeof(*dev) + argsize, GFP_KERNEL);
 	if (dev == NULL) {
 		unlock_driver(ops);
 		return -ENOMEM;
@@ -235,7 +235,7 @@ static int snd_seq_device_free(snd_seq_d
 	free_device(dev, ops);
 	if (dev->private_free)
 		dev->private_free(dev);
-	snd_magic_kfree(dev);
+	kfree(dev);
 
 	unlock_driver(ops);
 
--- linux-2.6.6/sound/core/seq/seq_dummy.c	2004-06-08 23:57:22.195071968 +0300
+++ alsa-2.6.6/sound/core/seq/seq_dummy.c	2004-06-05 21:18:34.000000000 +0300
@@ -148,7 +148,7 @@ dummy_free(void *private_data)
 	snd_seq_dummy_port_t *p;
 
 	p = snd_magic_cast(snd_seq_dummy_port_t, private_data, return);
-	snd_magic_kfree(p);
+	kfree(p);
 }
 
 /*
@@ -161,7 +161,7 @@ create_port(int idx, int type)
 	snd_seq_port_callback_t pcb;
 	snd_seq_dummy_port_t *rec;
 
-	if ((rec = snd_magic_kcalloc(snd_seq_dummy_port_t, 0, GFP_KERNEL)) == NULL)
+	if ((rec = kcalloc(sizeof(*rec), GFP_KERNEL)) == NULL)
 		return NULL;
 
 	rec->client = my_client;
@@ -187,7 +187,7 @@ create_port(int idx, int type)
 	pcb.private_data = rec;
 	pinfo.kernel = &pcb;
 	if (snd_seq_kernel_client_ctl(my_client, SNDRV_SEQ_IOCTL_CREATE_PORT, &pinfo) < 0) {
-		snd_magic_kfree(rec);
+		kfree(rec);
 		return NULL;
 	}
 	rec->port = pinfo.addr.port;
--- linux-2.6.6/sound/core/seq/seq_fifo.c	2004-06-08 23:57:22.171075616 +0300
+++ alsa-2.6.6/sound/core/seq/seq_fifo.c	2004-06-05 20:56:54.000000000 +0300
@@ -33,7 +33,7 @@ fifo_t *snd_seq_fifo_new(int poolsize)
 {
 	fifo_t *f;
 
-	f = snd_kcalloc(sizeof(fifo_t), GFP_KERNEL);
+	f = kcalloc(sizeof(*f), GFP_KERNEL);
 	if (f == NULL) {
 		snd_printd("malloc failed for snd_seq_fifo_new() \n");
 		return NULL;
--- linux-2.6.6/sound/core/seq/seq_instr.c	2004-06-08 23:57:22.167076224 +0300
+++ alsa-2.6.6/sound/core/seq/seq_instr.c	2004-06-05 20:58:52.000000000 +0300
@@ -53,10 +53,7 @@ static void snd_instr_unlock_ops(snd_seq
 
 snd_seq_kcluster_t *snd_seq_cluster_new(int atomic)
 {
-	snd_seq_kcluster_t *cluster;
-	
-	cluster = (snd_seq_kcluster_t *) snd_kcalloc(sizeof(snd_seq_kcluster_t), atomic ? GFP_ATOMIC : GFP_KERNEL);
-	return cluster;
+	return kcalloc(sizeof(snd_seq_kcluster_t), atomic ? GFP_ATOMIC : GFP_KERNEL);
 }
 
 void snd_seq_cluster_free(snd_seq_kcluster_t *cluster, int atomic)
@@ -70,7 +67,7 @@ snd_seq_kinstr_t *snd_seq_instr_new(int 
 {
 	snd_seq_kinstr_t *instr;
 	
-	instr = (snd_seq_kinstr_t *) snd_kcalloc(sizeof(snd_seq_kinstr_t) + add_len, atomic ? GFP_ATOMIC : GFP_KERNEL);
+	instr = kcalloc(sizeof(snd_seq_kinstr_t) + add_len, atomic ? GFP_ATOMIC : GFP_KERNEL);
 	if (instr == NULL)
 		return NULL;
 	instr->add_len = add_len;
@@ -94,7 +91,7 @@ snd_seq_kinstr_list_t *snd_seq_instr_lis
 {
 	snd_seq_kinstr_list_t *list;
 
-	list = (snd_seq_kinstr_list_t *) snd_kcalloc(sizeof(snd_seq_kinstr_list_t), GFP_KERNEL);
+	list = kcalloc(sizeof(snd_seq_kinstr_list_t), GFP_KERNEL);
 	if (list == NULL)
 		return NULL;
 	spin_lock_init(&list->lock);
--- linux-2.6.6/sound/core/hwdep.c	2004-06-08 23:57:22.403040352 +0300
+++ alsa-2.6.6/sound/core/hwdep.c	2004-06-06 22:28:45.000000000 +0300
@@ -351,7 +351,7 @@ int snd_hwdep_new(snd_card_t * card, cha
 	snd_assert(rhwdep != NULL, return -EINVAL);
 	*rhwdep = NULL;
 	snd_assert(card != NULL, return -ENXIO);
-	hwdep = snd_magic_kcalloc(snd_hwdep_t, 0, GFP_KERNEL);
+	hwdep = kcalloc(sizeof(*hwdep), GFP_KERNEL);
 	if (hwdep == NULL)
 		return -ENOMEM;
 	hwdep->card = card;
@@ -377,7 +377,7 @@ static int snd_hwdep_free(snd_hwdep_t *h
 	snd_assert(hwdep != NULL, return -ENXIO);
 	if (hwdep->private_free)
 		hwdep->private_free(hwdep);
-	snd_magic_kfree(hwdep);
+	kfree(hwdep);
 	return 0;
 }
 
--- linux-2.6.6/sound/core/seq/seq_memory.c	2004-06-08 23:57:22.107085344 +0300
+++ alsa-2.6.6/sound/core/seq/seq_memory.c	2004-06-05 20:59:24.000000000 +0300
@@ -453,7 +453,7 @@ pool_t *snd_seq_pool_new(int poolsize)
 	pool_t *pool;
 
 	/* create pool block */
-	pool = snd_kcalloc(sizeof(pool_t), GFP_KERNEL);
+	pool = kcalloc(sizeof(*pool), GFP_KERNEL);
 	if (pool == NULL) {
 		snd_printd("seq: malloc failed for pool\n");
 		return NULL;
--- linux-2.6.6/sound/core/seq/seq_midi.c	2004-06-08 23:57:22.352048104 +0300
+++ alsa-2.6.6/sound/core/seq/seq_midi.c	2004-06-08 19:26:05.000000000 +0300
@@ -322,7 +322,7 @@ snd_seq_midisynth_register_port(snd_seq_
 	client = synths[card->number];
 	if (client == NULL) {
 		newclient = 1;
-		client = snd_kcalloc(sizeof(seq_midisynth_client_t), GFP_KERNEL);
+		client = kcalloc(sizeof(*client), GFP_KERNEL);
 		if (client == NULL) {
 			up(&register_mutex);
 			return -ENOMEM;
@@ -340,7 +340,7 @@ snd_seq_midisynth_register_port(snd_seq_
 	} else if (device == 0)
 		set_client_name(client, card, &info); /* use the first device's name */
 
-	msynth = snd_kcalloc(sizeof(seq_midisynth_t) * ports, GFP_KERNEL);
+	msynth = kcalloc(sizeof(seq_midisynth_t) * ports, GFP_KERNEL);
 	if (msynth == NULL)
 		goto __nomem;
 
--- linux-2.6.6/sound/core/seq/seq_midi_event.c	2004-06-08 23:57:22.072090664 +0300
+++ alsa-2.6.6/sound/core/seq/seq_midi_event.c	2004-06-05 21:00:05.000000000 +0300
@@ -118,7 +118,7 @@ int snd_midi_event_new(int bufsize, snd_
 	snd_midi_event_t *dev;
 
 	*rdev = NULL;
-	dev = (snd_midi_event_t *)snd_kcalloc(sizeof(snd_midi_event_t), GFP_KERNEL);
+	dev = kcalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL)
 		return -ENOMEM;
 	if (bufsize > 0) {
--- linux-2.6.6/sound/core/seq/seq_ports.c	2004-06-08 23:57:22.252063304 +0300
+++ alsa-2.6.6/sound/core/seq/seq_ports.c	2004-06-05 20:56:42.000000000 +0300
@@ -141,7 +141,7 @@ client_port_t *snd_seq_create_port(clien
 	}
 
 	/* create a new port */
-	new_port = snd_kcalloc(sizeof(client_port_t), GFP_KERNEL);
+	new_port = kcalloc(sizeof(*new_port), GFP_KERNEL);
 	if (! new_port) {
 		snd_printd("malloc failed for registering client port\n");
 		return NULL;	/* failure, out of memory */
@@ -488,7 +488,7 @@ int snd_seq_port_connect(client_t *conne
 	unsigned long flags;
 	int exclusive;
 
-	subs = snd_kcalloc(sizeof(*subs), GFP_KERNEL);
+	subs = kcalloc(sizeof(*subs), GFP_KERNEL);
 	if (! subs)
 		return -ENOMEM;
 
--- linux-2.6.6/sound/core/seq/seq_prioq.c	2004-06-08 23:57:22.097086864 +0300
+++ alsa-2.6.6/sound/core/seq/seq_prioq.c	2004-06-05 20:59:37.000000000 +0300
@@ -59,7 +59,7 @@ prioq_t *snd_seq_prioq_new(void)
 {
 	prioq_t *f;
 
-	f = snd_kcalloc(sizeof(prioq_t), GFP_KERNEL);
+	f = kcalloc(sizeof(*f), GFP_KERNEL);
 	if (f == NULL) {
 		snd_printd("oops: malloc failed for snd_seq_prioq_new()\n");
 		return NULL;
--- linux-2.6.6/sound/core/seq/seq_queue.c	2004-06-08 23:57:22.344049320 +0300
+++ alsa-2.6.6/sound/core/seq/seq_queue.c	2004-06-05 20:56:17.000000000 +0300
@@ -111,7 +111,7 @@ static queue_t *queue_new(int owner, int
 {
 	queue_t *q;
 
-	q = snd_kcalloc(sizeof(queue_t), GFP_KERNEL);
+	q = kcalloc(sizeof(*q), GFP_KERNEL);
 	if (q == NULL) {
 		snd_printd("malloc failed for snd_seq_queue_new()\n");
 		return NULL;
--- linux-2.6.6/sound/core/seq/seq_timer.c	2004-06-08 23:57:22.343049472 +0300
+++ alsa-2.6.6/sound/core/seq/seq_timer.c	2004-06-05 20:56:29.000000000 +0300
@@ -59,7 +59,7 @@ seq_timer_t *snd_seq_timer_new(void)
 {
 	seq_timer_t *tmr;
 	
-	tmr = snd_kcalloc(sizeof(seq_timer_t), GFP_KERNEL);
+	tmr = kcalloc(sizeof(*tmr), GFP_KERNEL);
 	if (tmr == NULL) {
 		snd_printd("malloc failed for snd_seq_timer_new() \n");
 		return NULL;
--- linux-2.6.6/sound/core/seq/seq_virmidi.c	2004-06-08 23:57:22.226067256 +0300
+++ alsa-2.6.6/sound/core/seq/seq_virmidi.c	2004-06-05 21:18:17.000000000 +0300
@@ -204,12 +204,12 @@ static int snd_virmidi_input_open(snd_ra
 	snd_virmidi_t *vmidi;
 	unsigned long flags;
 
-	vmidi = snd_magic_kcalloc(snd_virmidi_t, 0, GFP_KERNEL);
+	vmidi = kcalloc(sizeof(*vmidi), GFP_KERNEL);
 	if (vmidi == NULL)
 		return -ENOMEM;
 	vmidi->substream = substream;
 	if (snd_midi_event_new(0, &vmidi->parser) < 0) {
-		snd_magic_kfree(vmidi);
+		kfree(vmidi);
 		return -ENOMEM;
 	}
 	vmidi->seq_mode = rdev->seq_mode;
@@ -232,12 +232,12 @@ static int snd_virmidi_output_open(snd_r
 	snd_rawmidi_runtime_t *runtime = substream->runtime;
 	snd_virmidi_t *vmidi;
 
-	vmidi = snd_magic_kcalloc(snd_virmidi_t, 0, GFP_KERNEL);
+	vmidi = kcalloc(sizeof(*vmidi), GFP_KERNEL);
 	if (vmidi == NULL)
 		return -ENOMEM;
 	vmidi->substream = substream;
 	if (snd_midi_event_new(MAX_MIDI_EVENT_BUF, &vmidi->parser) < 0) {
-		snd_magic_kfree(vmidi);
+		kfree(vmidi);
 		return -ENOMEM;
 	}
 	vmidi->seq_mode = rdev->seq_mode;
@@ -258,7 +258,7 @@ static int snd_virmidi_input_close(snd_r
 	snd_midi_event_free(vmidi->parser);
 	list_del(&vmidi->list);
 	substream->runtime->private_data = NULL;
-	snd_magic_kfree(vmidi);
+	kfree(vmidi);
 	return 0;
 }
 
@@ -270,7 +270,7 @@ static int snd_virmidi_output_close(snd_
 	snd_virmidi_t *vmidi = snd_magic_cast(snd_virmidi_t, substream->runtime->private_data, return -EINVAL);
 	snd_midi_event_free(vmidi->parser);
 	substream->runtime->private_data = NULL;
-	snd_magic_kfree(vmidi);
+	kfree(vmidi);
 	return 0;
 }
 
@@ -472,7 +472,7 @@ static snd_rawmidi_global_ops_t snd_virm
 static void snd_virmidi_free(snd_rawmidi_t *rmidi)
 {
 	snd_virmidi_dev_t *rdev = snd_magic_cast(snd_virmidi_dev_t, rmidi->private_data, return);
-	snd_magic_kfree(rdev);
+	kfree(rdev);
 }
 
 /*
@@ -493,7 +493,7 @@ int snd_virmidi_new(snd_card_t *card, in
 				   &rmidi)) < 0)
 		return err;
 	strcpy(rmidi->name, rmidi->id);
-	rdev = snd_magic_kcalloc(snd_virmidi_dev_t, 0, GFP_KERNEL);
+	rdev = kcalloc(sizeof(*rdev), GFP_KERNEL);
 	if (rdev == NULL) {
 		snd_device_free(card, rmidi);
 		return -ENOMEM;
--- linux-2.6.6/sound/core/timer.c	2004-06-08 23:57:23.116931824 +0300
+++ alsa-2.6.6/sound/core/timer.c	2004-06-08 19:26:27.000000000 +0300
@@ -93,7 +93,7 @@ static void snd_timer_reschedule(snd_tim
 static snd_timer_instance_t *snd_timer_instance_new(char *owner, snd_timer_t *timer)
 {
 	snd_timer_instance_t *timeri;
-	timeri = snd_kcalloc(sizeof(snd_timer_instance_t), GFP_KERNEL);
+	timeri = kcalloc(sizeof(*timeri), GFP_KERNEL);
 	if (timeri == NULL)
 		return NULL;
 	timeri->owner = snd_kmalloc_strdup(owner, GFP_KERNEL);
@@ -760,7 +760,7 @@ int snd_timer_new(snd_card_t *card, char
 	snd_assert(tid != NULL, return -EINVAL);
 	snd_assert(rtimer != NULL, return -EINVAL);
 	*rtimer = NULL;
-	timer = snd_magic_kcalloc(snd_timer_t, 0, GFP_KERNEL);
+	timer = kcalloc(sizeof(*timer), GFP_KERNEL);
 	if (timer == NULL)
 		return -ENOMEM;
 	timer->tmr_class = tid->dev_class;
@@ -791,7 +791,7 @@ static int snd_timer_free(snd_timer_t *t
 	snd_assert(timer != NULL, return -ENXIO);
 	if (timer->private_free)
 		timer->private_free(timer);
-	snd_magic_kfree(timer);
+	kfree(timer);
 	return 0;
 }
 
@@ -1017,7 +1017,7 @@ static int snd_timer_register_system(voi
 		return err;
 	strcpy(timer->name, "system timer");
 	timer->hw = snd_timer_system;
-	priv = (struct snd_timer_system_private *) snd_kcalloc(sizeof(struct snd_timer_system_private), GFP_KERNEL);
+	priv = kcalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL) {
 		snd_timer_free(timer);
 		return -ENOMEM;
@@ -1199,7 +1199,7 @@ static int snd_timer_user_open(struct in
 {
 	snd_timer_user_t *tu;
 	
-	tu = snd_magic_kcalloc(snd_timer_user_t, 0, GFP_KERNEL);
+	tu = kcalloc(sizeof(*tu), GFP_KERNEL);
 	if (tu == NULL)
 		return -ENOMEM;
 	spin_lock_init(&tu->qlock);
@@ -1208,7 +1208,7 @@ static int snd_timer_user_open(struct in
 	tu->queue_size = 128;
 	tu->queue = (snd_timer_read_t *)kmalloc(tu->queue_size * sizeof(snd_timer_read_t), GFP_KERNEL);
 	if (tu->queue == NULL) {
-		snd_magic_kfree(tu);
+		kfree(tu);
 		return -ENOMEM;
 	}
 	file->private_data = tu;
@@ -1229,7 +1229,7 @@ static int snd_timer_user_release(struct
 			kfree(tu->queue);
 		if (tu->tqueue)
 			kfree(tu->tqueue);
-		snd_magic_kfree(tu);
+		kfree(tu);
 	}
 	return 0;
 }
--- linux-2.6.6/sound/core/info.c	2004-06-08 23:57:23.272908112 +0300
+++ alsa-2.6.6/sound/core/info.c	2004-06-05 21:12:56.000000000 +0300
@@ -284,7 +284,7 @@ static int snd_info_entry_open(struct in
 		    	goto __error;
 		}
 	}
-	data = snd_magic_kcalloc(snd_info_private_data_t, 0, GFP_KERNEL);
+	data = kcalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL) {
 		err = -ENOMEM;
 		goto __error;
@@ -293,10 +293,9 @@ static int snd_info_entry_open(struct in
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:
 		if (mode == O_RDONLY || mode == O_RDWR) {
-			buffer = (snd_info_buffer_t *)
-				 	snd_kcalloc(sizeof(snd_info_buffer_t), GFP_KERNEL);
+			buffer = kcalloc(sizeof(*buffer), GFP_KERNEL);
 			if (buffer == NULL) {
-				snd_magic_kfree(data);
+				kfree(data);
 				err = -ENOMEM;
 				goto __error;
 			}
@@ -305,7 +304,7 @@ static int snd_info_entry_open(struct in
 			buffer->buffer = vmalloc(buffer->len);
 			if (buffer->buffer == NULL) {
 				kfree(buffer);
-				snd_magic_kfree(data);
+				kfree(data);
 				err = -ENOMEM;
 				goto __error;
 			}
@@ -313,14 +312,13 @@ static int snd_info_entry_open(struct in
 			data->rbuffer = buffer;
 		}
 		if (mode == O_WRONLY || mode == O_RDWR) {
-			buffer = (snd_info_buffer_t *)
-					snd_kcalloc(sizeof(snd_info_buffer_t), GFP_KERNEL);
+			buffer = kcalloc(sizeof(*buffer), GFP_KERNEL);
 			if (buffer == NULL) {
 				if (mode == O_RDWR) {
 					vfree(data->rbuffer->buffer);
 					kfree(data->rbuffer);
 				}
-				snd_magic_kfree(data);
+				kfree(data);
 				err = -ENOMEM;
 				goto __error;
 			}
@@ -333,7 +331,7 @@ static int snd_info_entry_open(struct in
 					kfree(data->rbuffer);
 				}
 				kfree(buffer);
-				snd_magic_kfree(data);
+				kfree(data);
 				err = -ENOMEM;
 				goto __error;
 			}
@@ -345,7 +343,7 @@ static int snd_info_entry_open(struct in
 		if (entry->c.ops->open) {
 			if ((err = entry->c.ops->open(entry, mode,
 						      &data->file_private_data)) < 0) {
-				snd_magic_kfree(data);
+				kfree(data);
 				goto __error;
 			}
 		}
@@ -405,7 +403,7 @@ static int snd_info_entry_release(struct
 		break;
 	}
 	module_put(entry->module);
-	snd_magic_kfree(data);
+	kfree(data);
 	return 0;
 }
 
@@ -732,12 +730,12 @@ char *snd_info_get_str(char *dest, char 
 static snd_info_entry_t *snd_info_create_entry(const char *name)
 {
 	snd_info_entry_t *entry;
-	entry = snd_magic_kcalloc(snd_info_entry_t, 0, GFP_KERNEL);
+	entry = kcalloc(sizeof(*entry), GFP_KERNEL);
 	if (entry == NULL)
 		return NULL;
 	entry->name = snd_kmalloc_strdup(name, GFP_KERNEL);
 	if (entry->name == NULL) {
-		snd_magic_kfree(entry);
+		kfree(entry);
 		return NULL;
 	}
 	entry->mode = S_IFREG | S_IRUGO;
@@ -875,7 +873,7 @@ void snd_info_free_entry(snd_info_entry_
 		kfree((char *)entry->name);
 	if (entry->private_free)
 		entry->private_free(entry);
-	snd_magic_kfree(entry);
+	kfree(entry);
 }
 
 /**
--- linux-2.6.6/sound/core/init.c	2004-06-08 23:57:22.879967848 +0300
+++ alsa-2.6.6/sound/core/init.c	2004-06-06 22:29:58.000000000 +0300
@@ -71,7 +71,7 @@ snd_card_t *snd_card_new(int idx, const 
 
 	if (extra_size < 0)
 		extra_size = 0;
-	card = (snd_card_t *) snd_kcalloc(sizeof(snd_card_t) + extra_size, GFP_KERNEL);
+	card = kcalloc(sizeof(*card) + extra_size, GFP_KERNEL);
 	if (card == NULL)
 		return NULL;
 	if (xid) {
--- linux-2.6.6/sound/core/ioctl32/pcm32.c	2004-06-08 23:57:22.703994600 +0300
+++ alsa-2.6.6/sound/core/ioctl32/pcm32.c	2004-06-05 20:54:08.000000000 +0300
@@ -349,8 +349,8 @@ static int _snd_ioctl32_pcm_hw_params_ol
 	mm_segment_t oldseg;
 	int err;
 
-	data32 = snd_kcalloc(sizeof(*data32), GFP_KERNEL);
-	data = snd_kcalloc(sizeof(*data), GFP_KERNEL);
+	data32 = kcalloc(sizeof(*data32), GFP_KERNEL);
+	data = kcalloc(sizeof(*data), GFP_KERNEL);
 	if (data32 == NULL || data == NULL) {
 		err = -ENOMEM;
 		goto __end;
--- linux-2.6.6/sound/core/oss/mixer_oss.c	2004-06-08 23:57:22.557016944 +0300
+++ alsa-2.6.6/sound/core/oss/mixer_oss.c	2004-06-05 21:16:42.000000000 +0300
@@ -51,7 +51,7 @@ static int snd_mixer_oss_open(struct ino
 	err = snd_card_file_add(card, file);
 	if (err < 0)
 		return err;
-	fmixer = (snd_mixer_oss_file_t *)snd_kcalloc(sizeof(*fmixer), GFP_KERNEL);
+	fmixer = kcalloc(sizeof(*fmixer), GFP_KERNEL);
 	if (fmixer == NULL) {
 		snd_card_file_remove(card, file);
 		return -ENOMEM;
@@ -506,8 +506,8 @@ static void snd_mixer_oss_get_volume1_vo
 		up_read(&card->controls_rwsem);
 		return;
 	}
-	uinfo = snd_kcalloc(sizeof(*uinfo), GFP_KERNEL);
-	uctl = snd_kcalloc(sizeof(*uctl), GFP_KERNEL);
+	uinfo = kcalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kcalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL)
 		goto __unalloc;
 	snd_runtime_check(!kctl->info(kctl, uinfo), goto __unalloc);
@@ -542,8 +542,8 @@ static void snd_mixer_oss_get_volume1_sw
 		up_read(&card->controls_rwsem);
 		return;
 	}
-	uinfo = snd_kcalloc(sizeof(*uinfo), GFP_KERNEL);
-	uctl = snd_kcalloc(sizeof(*uctl), GFP_KERNEL);
+	uinfo = kcalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kcalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL)
 		goto __unalloc;
 	snd_runtime_check(!kctl->info(kctl, uinfo), goto __unalloc);
@@ -605,8 +605,8 @@ static void snd_mixer_oss_put_volume1_vo
 	down_read(&card->controls_rwsem);
 	if ((kctl = snd_ctl_find_numid(card, numid)) == NULL)
 		return;
-	uinfo = snd_kcalloc(sizeof(*uinfo), GFP_KERNEL);
-	uctl = snd_kcalloc(sizeof(*uctl), GFP_KERNEL);
+	uinfo = kcalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kcalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL)
 		goto __unalloc;
 	snd_runtime_check(!kctl->info(kctl, uinfo), goto __unalloc);
@@ -644,8 +644,8 @@ static void snd_mixer_oss_put_volume1_sw
 		up_read(&fmixer->card->controls_rwsem);
 		return;
 	}
-	uinfo = snd_kcalloc(sizeof(*uinfo), GFP_KERNEL);
-	uctl = snd_kcalloc(sizeof(*uctl), GFP_KERNEL);
+	uinfo = kcalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kcalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL)
 		goto __unalloc;
 	snd_runtime_check(!kctl->info(kctl, uinfo), goto __unalloc);
@@ -765,8 +765,8 @@ static int snd_mixer_oss_get_recsrc2(snd
 	snd_ctl_elem_value_t *uctl;
 	int err, idx;
 	
-	uinfo = snd_kcalloc(sizeof(*uinfo), GFP_KERNEL);
-	uctl = snd_kcalloc(sizeof(*uctl), GFP_KERNEL);
+	uinfo = kcalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kcalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL) {
 		err = -ENOMEM;
 		goto __unlock;
@@ -812,8 +812,8 @@ static int snd_mixer_oss_put_recsrc2(snd
 	int err;
 	unsigned int idx;
 
-	uinfo = snd_kcalloc(sizeof(*uinfo), GFP_KERNEL);
-	uctl = snd_kcalloc(sizeof(*uctl), GFP_KERNEL);
+	uinfo = kcalloc(sizeof(*uinfo), GFP_KERNEL);
+	uctl = kcalloc(sizeof(*uctl), GFP_KERNEL);
 	if (uinfo == NULL || uctl == NULL) {
 		err = -ENOMEM;
 		goto __unlock;
@@ -1235,7 +1235,7 @@ static int snd_mixer_oss_free1(void *pri
 		if (chn->private_free)
 			chn->private_free(chn);
 	}
-	snd_magic_kfree(mixer);
+	kfree(mixer);
 	return 0;
 }
 
@@ -1247,7 +1247,7 @@ static int snd_mixer_oss_notify_handler(
 		char name[128];
 		int idx, err;
 
-		mixer = snd_magic_kcalloc(snd_mixer_oss_t, sizeof(snd_mixer_oss_t), GFP_KERNEL);
+		mixer = kcalloc(sizeof(*mixer) * 2, GFP_KERNEL);
 		if (mixer == NULL)
 			return -ENOMEM;
 		init_MUTEX(&mixer->reg_mutex);
@@ -1257,7 +1257,7 @@ static int snd_mixer_oss_notify_handler(
 						   &snd_mixer_oss_reg,
 						   name)) < 0) {
 			snd_printk("unable to register OSS mixer device %i:%i\n", card->number, 0);
-			snd_magic_kfree(mixer);
+			kfree(mixer);
 			return err;
 		}
 		mixer->oss_dev_alloc = 1;
--- linux-2.6.6/sound/core/oss/pcm_oss.c	2004-06-08 23:57:22.610008888 +0300
+++ alsa-2.6.6/sound/core/oss/pcm_oss.c	2004-06-05 21:16:00.000000000 +0300
@@ -1691,7 +1691,7 @@ static int snd_pcm_oss_release_file(snd_
 		snd_pcm_oss_release_substream(substream);
 		snd_pcm_release_substream(substream);
 	}
-	snd_magic_kfree(pcm_oss_file);
+	kfree(pcm_oss_file);
 	return 0;
 }
 
@@ -1710,7 +1710,7 @@ static int snd_pcm_oss_open_file(struct 
 	snd_assert(rpcm_oss_file != NULL, return -EINVAL);
 	*rpcm_oss_file = NULL;
 
-	pcm_oss_file = snd_magic_kcalloc(snd_pcm_oss_file_t, 0, GFP_KERNEL);
+	pcm_oss_file = kcalloc(sizeof(*pcm_oss_file), GFP_KERNEL);
 	if (pcm_oss_file == NULL)
 		return -ENOMEM;
 
