Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTEYUKN (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTEYUKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:10:13 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:62619 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263722AbTEYUJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:09:52 -0400
Date: Sun, 25 May 2003 15:34:10 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sound/* strncpy conversion
Message-ID: <20030525193409.GA2657@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, this depends on René's strlcat. Does a lot of cleanup for
strncpy->strlcpy, replaces some sprintf/snprintf's aswell. There were
only two places where things weren't straight forward. All-in-all a good
cleanup though.


Index: sound/core/init.c
===================================================================
--- sound/core/init.c	(revision 10094)
+++ sound/core/init.c	(working copy)
@@ -76,7 +76,7 @@
 	if (xid) {
 		if (!snd_info_check_reserved_words(xid))
 			goto __error;
-		strncpy(card->id, xid, sizeof(card->id) - 1);
+		strlcpy(card->id, xid, sizeof(card->id));
 	}
 	write_lock(&snd_card_rwlock);
 	if (idx < 0) {
Index: sound/core/hwdep.c
===================================================================
--- sound/core/hwdep.c	(revision 10094)
+++ sound/core/hwdep.c	(working copy)
@@ -169,8 +169,8 @@
 	
 	memset(&info, 0, sizeof(info));
 	info.card = hw->card->number;
-	strncpy(info.id, hw->id, sizeof(info.id) - 1);	
-	strncpy(info.name, hw->name, sizeof(info.name) - 1);
+	strlcpy(info.id, hw->id, sizeof(info.id));	
+	strlcpy(info.name, hw->name, sizeof(info.name));
 	info.iface = hw->iface;
 	if (copy_to_user(_info, &info, sizeof(info)))
 		return -EFAULT;
@@ -343,7 +343,7 @@
 	hwdep->card = card;
 	hwdep->device = device;
 	if (id) {
-		strncpy(hwdep->id, id, sizeof(hwdep->id) - 1);
+		strlcpy(hwdep->id, id, sizeof(hwdep->id));
 	}
 #ifdef CONFIG_SND_OSSEMUL
 	hwdep->oss_type = -1;
Index: sound/core/seq/seq_device.c
===================================================================
--- sound/core/seq/seq_device.c	(revision 10094)
+++ sound/core/seq/seq_device.c	(working copy)
@@ -187,8 +187,7 @@
 	/* set up device info */
 	dev->card = card;
 	dev->device = device;
-	strncpy(dev->id, id, sizeof(dev->id) - 1);
-	dev->id[sizeof(dev->id) - 1] = 0;
+	strlcpy(dev->id, id, sizeof(dev->id));
 	dev->argsize = argsize;
 	dev->status = SNDRV_SEQ_DEVICE_FREE;
 
@@ -350,8 +349,7 @@
 	memset(ops, 0, sizeof(*ops));
 
 	/* set up driver entry */
-	strncpy(ops->id, id, sizeof(ops->id) - 1);
-	ops->id[sizeof(ops->id) - 1] = 0;
+	strlcpy(ops->id, id, sizeof(ops->id));
 	init_MUTEX(&ops->reg_mutex);
 	ops->driver = DRIVER_EMPTY;
 	INIT_LIST_HEAD(&ops->dev_list);
Index: sound/core/seq/seq_ports.c
===================================================================
--- sound/core/seq/seq_ports.c	(revision 10094)
+++ sound/core/seq/seq_ports.c	(working copy)
@@ -338,10 +338,8 @@
 	snd_assert(port && info, return -EINVAL);
 
 	/* set port name */
-	if (info->name[0]) {
-		strncpy(port->name, info->name, sizeof(port->name)-1);
-		port->name[sizeof(port->name)-1] = '\0';
-	}
+	if (info->name[0])
+		strlcpy(port->name, info->name, sizeof(port->name));
 	
 	/* set capabilities */
 	port->capability = info->capability;
@@ -363,7 +361,7 @@
 	snd_assert(port && info, return -EINVAL);
 
 	/* get port name */
-	strncpy(info->name, port->name, sizeof(info->name));
+	strlcpy(info->name, port->name, sizeof(info->name));
 	
 	/* get capabilities */
 	info->capability = port->capability;
@@ -621,10 +619,8 @@
 	/* Set up the port */
 	memset(&portinfo, 0, sizeof(portinfo));
 	portinfo.addr.client = client;
-	if (portname)
-		strncpy(portinfo.name, portname, sizeof(portinfo.name));
-	else
-		sprintf(portinfo.name, "Unamed port");
+	strlcpy(portinfo.name, portname ? portname : "Unamed port",
+		sizeof(portinfo.name));
 
 	portinfo.capability = cap;
 	portinfo.type = type;
Index: sound/core/seq/seq_instr.c
===================================================================
--- sound/core/seq/seq_instr.c	(revision 10094)
+++ sound/core/seq/seq_instr.c	(working copy)
@@ -478,8 +478,7 @@
 	}
 	instr->ops = ops;
 	instr->instr = put.id.instr;
-	strncpy(instr->name, put.data.name, sizeof(instr->name)-1);
-	instr->name[sizeof(instr->name)-1] = '\0';
+	strlcpy(instr->name, put.data.name, sizeof(instr->name));
 	instr->type = put.data.type;
 	if (instr->type == SNDRV_SEQ_INSTR_ATYPE_DATA) {
 		result = ops->put(ops->private_data,
Index: sound/core/seq/oss/seq_oss_synth.c
===================================================================
--- sound/core/seq/oss/seq_oss_synth.c	(revision 10094)
+++ sound/core/seq/oss/seq_oss_synth.c	(working copy)
@@ -117,8 +117,7 @@
 	snd_use_lock_init(&rec->use_lock);
 
 	/* copy and truncate the name of synth device */
-	strncpy(rec->name, dev->name, sizeof(rec->name));
-	rec->name[sizeof(rec->name)-1] = 0;
+	strlcpy(rec->name, dev->name, sizeof(rec->name));
 
 	/* registration */
 	spin_lock_irqsave(&register_lock, flags);
@@ -611,7 +610,7 @@
 		inf->synth_subtype = 0;
 		inf->nr_voices = 16;
 		inf->device = dev;
-		strncpy(inf->name, minf.name, sizeof(inf->name));
+		strlcpy(inf->name, minf.name, sizeof(inf->name));
 	} else {
 		if ((rec = get_synthdev(dp, dev)) == NULL)
 			return -ENXIO;
@@ -619,7 +618,7 @@
 		inf->synth_subtype = rec->synth_subtype;
 		inf->nr_voices = rec->nr_voices;
 		inf->device = dev;
-		strncpy(inf->name, rec->name, sizeof(inf->name));
+		strlcpy(inf->name, rec->name, sizeof(inf->name));
 		snd_use_lock_free(&rec->use_lock);
 	}
 	return 0;
Index: sound/core/seq/oss/seq_oss_midi.c
===================================================================
--- sound/core/seq/oss/seq_oss_midi.c	(revision 10094)
+++ sound/core/seq/oss/seq_oss_midi.c	(working copy)
@@ -184,8 +184,7 @@
 	snd_use_lock_init(&mdev->use_lock);
 
 	/* copy and truncate the name of synth device */
-	strncpy(mdev->name, pinfo->name, sizeof(mdev->name));
-	mdev->name[sizeof(mdev->name) - 1] = 0;
+	strlcpy(mdev->name, pinfo->name, sizeof(mdev->name));
 
 	/* create MIDI coder */
 	if (snd_midi_event_new(MAX_MIDI_EVENT_BUF, &mdev->coder) < 0) {
@@ -659,7 +658,7 @@
 	inf->device = dev;
 	inf->dev_type = 0; /* FIXME: ?? */
 	inf->capabilities = 0; /* FIXME: ?? */
-	strncpy(inf->name, mdev->name, sizeof(inf->name));
+	strlcpy(inf->name, mdev->name, sizeof(inf->name));
 	snd_use_lock_free(&mdev->use_lock);
 	return 0;
 }
Index: sound/core/seq/seq_clientmgr.c
===================================================================
--- sound/core/seq/seq_clientmgr.c	(revision 10094)
+++ sound/core/seq/seq_clientmgr.c	(working copy)
@@ -1184,10 +1184,9 @@
 		return -EINVAL;
 
 	/* fill the info fields */
-	if (client_info.name[0]) {
-		strncpy(client->name, client_info.name, sizeof(client->name)-1);
-		client->name[sizeof(client->name)-1] = '\0';
-	}
+	if (client_info.name[0])
+		strlcpy(client->name, client_info.name, sizeof(client->name));
+
 	client->filter = client_info.filter;
 	client->event_lost = client_info.event_lost;
 	memcpy(client->event_filter, client_info.event_filter, 32);
@@ -1487,9 +1486,8 @@
 
 	/* set queue name */
 	if (! info.name[0])
-		sprintf(info.name, "Queue-%d", q->queue);
-	strncpy(q->name, info.name, sizeof(q->name)-1);
-	q->name[sizeof(q->name)-1] = 0;
+		snprintf(info.name, sizeof(info.name), "Queue-%d", q->queue);
+	strlcpy(q->name, info.name, sizeof(q->name));
 	queuefree(q);
 
 	if (copy_to_user(arg, &info, sizeof(info)))
@@ -1526,8 +1524,7 @@
 	info.queue = q->queue;
 	info.owner = q->owner;
 	info.locked = q->locked;
-	strncpy(info.name, q->name, sizeof(info.name) - 1);
-	info.name[sizeof(info.name)-1] = 0;
+	strlcpy(info.name, q->name, sizeof(info.name));
 	queuefree(q);
 
 	if (copy_to_user(arg, &info, sizeof(info)))
@@ -1565,8 +1562,7 @@
 		queuefree(q);
 		return -EPERM;
 	}
-	strncpy(q->name, info.name, sizeof(q->name) - 1);
-	q->name[sizeof(q->name)-1] = 0;
+	strlcpy(q->name, info.name, sizeof(q->name));
 	queuefree(q);
 
 	return 0;
Index: sound/core/pcm.c
===================================================================
--- sound/core/pcm.c	(revision 10094)
+++ sound/core/pcm.c	(working copy)
@@ -639,7 +639,7 @@
 	pcm->card = card;
 	pcm->device = device;
 	if (id) {
-		strncpy(pcm->id, id, sizeof(pcm->id) - 1);
+		strlcpy(pcm->id, id, sizeof(pcm->id));
 	}
 	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK, playback_count)) < 0) {
 		snd_pcm_free(pcm);
Index: sound/core/control.c
===================================================================
--- sound/core/control.c	(revision 10094)
+++ sound/core/control.c	(working copy)
@@ -222,7 +222,7 @@
 	kctl.id.device = ncontrol->device;
 	kctl.id.subdevice = ncontrol->subdevice;
 	if (ncontrol->name)
-		strncpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name)-1);
+		strlcpy(kctl.id.name, ncontrol->name, sizeof(kctl.id.name));
 	kctl.id.index = ncontrol->index;
 	kctl.count = ncontrol->count ? ncontrol->count : 1;
 	access = ncontrol->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
@@ -449,12 +449,12 @@
 	memset(&info, 0, sizeof(info));
 	down_read(&snd_ioctl_rwsem);
 	info.card = card->number;
-	strncpy(info.id, card->id, sizeof(info.id) - 1);
-	strncpy(info.driver, card->driver, sizeof(info.driver) - 1);
-	strncpy(info.name, card->shortname, sizeof(info.name) - 1);
-	strncpy(info.longname, card->longname, sizeof(info.longname) - 1);
-	strncpy(info.mixername, card->mixername, sizeof(info.mixername) - 1);
-	strncpy(info.components, card->components, sizeof(info.components) - 1);
+	strlcpy(info.id, card->id, sizeof(info.id));
+	strlcpy(info.driver, card->driver, sizeof(info.driver));
+	strlcpy(info.name, card->shortname, sizeof(info.name));
+	strlcpy(info.longname, card->longname, sizeof(info.longname));
+	strlcpy(info.mixername, card->mixername, sizeof(info.mixername));
+	strlcpy(info.components, card->components, sizeof(info.components));
 	up_read(&snd_ioctl_rwsem);
 	if (copy_to_user((void *) arg, &info, sizeof(snd_ctl_card_info_t)))
 		return -EFAULT;
Index: sound/core/timer.c
===================================================================
--- sound/core/timer.c	(revision 10094)
+++ sound/core/timer.c	(working copy)
@@ -749,7 +749,7 @@
 	timer->tmr_device = tid->device;
 	timer->tmr_subdevice = tid->subdevice;
 	if (id)
-		strncpy(timer->id, id, sizeof(timer->id) - 1);
+		strlcpy(timer->id, id, sizeof(timer->id));
 	INIT_LIST_HEAD(&timer->device_list);
 	INIT_LIST_HEAD(&timer->open_list_head);
 	INIT_LIST_HEAD(&timer->active_list_head);
@@ -1317,8 +1317,8 @@
 		ginfo.card = t->card ? t->card->number : -1;
 		if (t->hw.flags & SNDRV_TIMER_HW_SLAVE)
 			ginfo.flags |= SNDRV_TIMER_FLG_SLAVE;
-		strncpy(ginfo.id, t->id, sizeof(ginfo.id)-1);
-		strncpy(ginfo.name, t->name, sizeof(ginfo.name)-1);
+		strlcpy(ginfo.id, t->id, sizeof(ginfo.id));
+		strlcpy(ginfo.name, t->name, sizeof(ginfo.name));
 		ginfo.resolution = t->hw.resolution;
 		if (t->hw.resolution_min > 0) {
 			ginfo.resolution_min = t->hw.resolution_min;
@@ -1457,8 +1457,8 @@
 	info.card = t->card ? t->card->number : -1;
 	if (t->hw.flags & SNDRV_TIMER_HW_SLAVE)
 		info.flags |= SNDRV_TIMER_FLG_SLAVE;
-	strncpy(info.id, t->id, sizeof(info.id)-1);
-	strncpy(info.name, t->name, sizeof(info.name)-1);
+	strlcpy(info.id, t->id, sizeof(info.id));
+	strlcpy(info.name, t->name, sizeof(info.name));
 	info.resolution = t->hw.resolution;
 	if (copy_to_user(_info, &info, sizeof(*_info)))
 		return -EFAULT;
Index: sound/core/oss/mixer_oss.c
===================================================================
--- sound/core/oss/mixer_oss.c	(revision 10094)
+++ sound/core/oss/mixer_oss.c	(working copy)
@@ -85,8 +85,8 @@
 	struct mixer_info info;
 	
 	memset(&info, 0, sizeof(info));
-	strncpy(info.id, mixer && mixer->id[0] ? mixer->id : card->driver, sizeof(info.id) - 1);
-	strncpy(info.name, mixer && mixer->name[0] ? mixer->name : card->mixername, sizeof(info.name) - 1);
+	strlcpy(info.id, mixer && mixer->id[0] ? mixer->id : card->driver, sizeof(info.id));
+	strlcpy(info.name, mixer && mixer->name[0] ? mixer->name : card->mixername, sizeof(info.name));
 	info.modify_counter = card->mixer_oss_change_count;
 	if (copy_to_user(_info, &info, sizeof(info)))
 		return -EFAULT;
@@ -101,8 +101,8 @@
 	_old_mixer_info info;
 	
 	memset(&info, 0, sizeof(info));
-	strncpy(info.id, mixer && mixer->id[0] ? mixer->id : card->driver, sizeof(info.id) - 1);
-	strncpy(info.name, mixer && mixer->name[0] ? mixer->name : card->mixername, sizeof(info.name) - 1);
+	strlcpy(info.id, mixer && mixer->id[0] ? mixer->id : card->driver, sizeof(info.id));
+	strlcpy(info.name, mixer && mixer->name[0] ? mixer->name : card->mixername, sizeof(info.name));
 	if (copy_to_user(_info, &info, sizeof(info)))
 		return -EFAULT;
 	return 0;
@@ -1215,11 +1215,10 @@
 		}
 		mixer->oss_dev_alloc = 1;
 		mixer->card = card;
-		if (*card->mixername) {
-			strncpy(mixer->name, card->mixername, sizeof(mixer->name) - 1);
-			mixer->name[sizeof(mixer->name)-1] = 0;
-		} else
-			strcpy(mixer->name, name);
+		if (*card->mixername)
+			strlcpy(mixer->name, card->mixername, sizeof(mixer->name));
+		else
+			strlcpy(mixer->name, name, sizeof(mixer->name));
 #ifdef SNDRV_OSS_INFO_DEV_MIXERS
 		snd_oss_info_register(SNDRV_OSS_INFO_DEV_MIXERS,
 				      card->number,
Index: sound/core/pcm_native.c
===================================================================
--- sound/core/pcm_native.c	(revision 10094)
+++ sound/core/pcm_native.c	(working copy)
@@ -92,13 +92,13 @@
 	info->device = pcm->device;
 	info->stream = substream->stream;
 	info->subdevice = substream->number;
-	strncpy(info->id, pcm->id, sizeof(info->id)-1);
-	strncpy(info->name, pcm->name, sizeof(info->name)-1);
+	strlcpy(info->id, pcm->id, sizeof(info->id));
+	strlcpy(info->name, pcm->name, sizeof(info->name));
 	info->dev_class = pcm->dev_class;
 	info->dev_subclass = pcm->dev_subclass;
 	info->subdevices_count = pstr->substream_count;
 	info->subdevices_avail = pstr->substream_count - pstr->substream_opened;
-	strncpy(info->subname, substream->name, sizeof(info->subname)-1);
+	strlcpy(info->subname, substream->name, sizeof(info->subname));
 	runtime = substream->runtime;
 	/* AB: FIXME!!! This is definitely nonsense */
 	if (runtime) {
Index: sound/core/rawmidi.c
===================================================================
--- sound/core/rawmidi.c	(revision 10094)
+++ sound/core/rawmidi.c	(working copy)
@@ -1394,7 +1394,7 @@
 	init_MUTEX(&rmidi->open_mutex);
 	init_waitqueue_head(&rmidi->open_wait);
 	if (id != NULL)
-		strncpy(rmidi->id, id, sizeof(rmidi->id) - 1);
+		strlcpy(rmidi->id, id, sizeof(rmidi->id));
 	if ((err = snd_rawmidi_alloc_substreams(rmidi, &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT], SNDRV_RAWMIDI_STREAM_INPUT, input_count)) < 0) {
 		snd_rawmidi_free(rmidi);
 		return err;
Index: sound/usb/usbmixer.c
===================================================================
--- sound/usb/usbmixer.c	(revision 10094)
+++ sound/usb/usbmixer.c	(working copy)
@@ -164,9 +164,7 @@
 		if (p->id == unitid &&
 		    (! control || ! p->control || control == p->control)) {
 			buflen--;
-			strncpy(buf, p->name, buflen);
-			buf[buflen] = 0;
-			return strlen(buf);
+			return strlcpy(buf, p->name, buflen);
 		}
 	}
 	return 0;
@@ -816,7 +814,8 @@
 			if (! len)
 				len = get_term_name(state, &state->oterm, kctl->id.name, sizeof(kctl->id.name), 1);
 			if (! len)
-				len = sprintf(kctl->id.name, "Feature %d", unitid);
+				len = snprintf(kctl->id.name, sizeof(kctl->id.name),
+					       "Feature %d", unitid);
 		}
 		/* determine the stream direction:
 		 * if the connected output is USB stream, then it's likely a
@@ -824,24 +823,19 @@
 		 */
 		if (! mapped_name && ! (state->oterm.type >> 16)) {
 			if ((state->oterm.type & 0xff00) == 0x0100) {
-				if (len + 8 < sizeof(kctl->id.name)) {
-					strcpy(kctl->id.name + len, " Capture");
-					len += 8;
-				}
+				len = strlcat(kctl->id.name, " Capture", sizeof(kctl->id.name));
 			} else {
-				if (len + 9 < sizeof(kctl->id.name)) {
-					strcpy(kctl->id.name + len, " Playback");
-					len += 9;
-				}
+				len = strlcat(kctl->id.name + len, " Playback", sizeof(kctl->id.name));
 			}
 		}
-		if (len + 7 < sizeof(kctl->id.name))
-			strcpy(kctl->id.name + len, control == USB_FEATURE_MUTE ? " Switch" : " Volume");
+		strlcat(kctl->id.name + len, control == USB_FEATURE_MUTE ? " Switch" : " Volume",
+			sizeof(kctl->id.name));
 		break;
 
 	default:
 		if (! len)
-			strcpy(kctl->id.name, audio_feature_info[control-1].name);
+			strlcpy(kctl->id.name, audio_feature_info[control-1].name,
+				sizeof(kctl->id.name));
 		break;
 	}
 
@@ -969,8 +963,7 @@
 		len = get_term_name(state, &iterm, kctl->id.name, sizeof(kctl->id.name), 0);
 	if (! len)
 		len = sprintf(kctl->id.name, "Mixer Source %d", in_ch);
-	if (len + 7 < sizeof(kctl->id.name))
-		strcpy(kctl->id.name + len, " Volume");
+	strlcat(kctl->id.name + len, " Volume", sizeof(kctl->id.name));
 
 	snd_printdd(KERN_INFO "[%d] MU [%s] ch = %d, val = %d/%d\n",
 		    cval->id, kctl->id.name, cval->channels, cval->min, cval->max);
@@ -1189,22 +1182,18 @@
 		if (check_mapped_name(state, unitid, cval->control, kctl->id.name, sizeof(kctl->id.name)))
 			;
 		else if (info->name)
-			strcpy(kctl->id.name, info->name);
+			strlcpy(kctl->id.name, info->name, sizeof(kctl->id.name));
 		else {
 			nameid = dsc[12 + num_ins + dsc[11 + num_ins]];
 			len = 0;
 			if (nameid)
 				len = snd_usb_copy_string_desc(state, nameid, kctl->id.name, sizeof(kctl->id.name));
-			if (! len) {
-				strncpy(kctl->id.name, name, sizeof(kctl->id.name) - 1);
-				kctl->id.name[sizeof(kctl->id.name)-1] = 0;
-			}
+			if (! len)
+				strlcpy(kctl->id.name, name, sizeof(kctl->id.name));
 		}
-		len = strlen(kctl->id.name);
-		if (len + sizeof(valinfo->suffix) + 1 < sizeof(kctl->id.name)) {
-			kctl->id.name[len] = ' ';
-			strcpy(kctl->id.name + len + 1, valinfo->suffix);
-		}
+		strlcat(kctl->id.name, ' ', sizeof(kctl->id.name));
+		strlcat(kctl->id.name, valinfo->suffix, sizeof(kctl->id.name));
+
 		snd_printdd(KERN_INFO "[%d] PU [%s] ch = %d, val = %d/%d\n",
 			    cval->id, kctl->id.name, cval->channels, cval->min, cval->max);
 		if ((err = add_control_to_empty(state->chip->card, kctl)) < 0)
@@ -1402,14 +1391,12 @@
 		len = get_term_name(state, &state->oterm,
 				    kctl->id.name, sizeof(kctl->id.name), 0);
 		if (! len)
-			len = sprintf(kctl->id.name, "USB");
-		if ((state->oterm.type & 0xff00) == 0x0100) {
-			if (len + 15 < sizeof(kctl->id.name))
-				strcpy(kctl->id.name + len, " Capture Source");
-		} else {
-			if (len + 16 < sizeof(kctl->id.name))
-				strcpy(kctl->id.name + len, " Playback Source");
-		}
+			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
+
+		if ((state->oterm.type & 0xff00) == 0x0100)
+			strlcat(kctl->id.name, " Capture Source", sizeof(kctl->id.name));
+		else
+			strlcat(kctl->id.name, " Playback Source", sizeof(kctl->id.name));
 	}
 
 	snd_printdd(KERN_INFO "[%d] SU [%s] items = %d\n",
Index: sound/usb/usbaudio.c
===================================================================
--- sound/usb/usbaudio.c	(revision 10094)
+++ sound/usb/usbaudio.c	(working copy)
@@ -2392,8 +2392,7 @@
 		len = 0;
 	if (len <= 0) {
  		if (quirk && quirk->product_name) {
-			strncpy(card->shortname, quirk->product_name, sizeof(card->shortname) - 1);
-			card->shortname[sizeof(card->shortname) - 1] = '\0';
+			strlcpy(card->shortname, quirk->product_name, sizeof(card->shortname));
 		} else {
 			sprintf(card->shortname, "USB Device %#04x:%#04x",
 				dev->descriptor.idVendor, dev->descriptor.idProduct);
@@ -2403,37 +2402,32 @@
 	/* retrieve the vendor and device strings as longname */
 	if (dev->descriptor.iManufacturer)
 		len = usb_string(dev, dev->descriptor.iManufacturer,
-				 card->longname, sizeof(card->longname) - 1);
+				 card->longname, sizeof(card->longname));
 	else
 		len = 0;
 	if (len <= 0) {
 		if (quirk && quirk->vendor_name) {
-			strncpy(card->longname, quirk->vendor_name, sizeof(card->longname) - 2);
-			card->longname[sizeof(card->longname) - 2] = '\0';
-			len = strlen(card->longname);
+			len = strlcpy(card->longname, quirk->vendor_name, sizeof(card->longname));
 		} else {
 			len = 0;
 		}
 	}
-	if (len > 0) {
-		card->longname[len] = ' ';
-		len++;
-	}
-	card->longname[len] = '\0';
+	if (len > 0)
+		strlcat(card->longname, ' ', sizeof(card->longname));
+
+	len = strlen(card->longname);
+
 	if ((!dev->descriptor.iProduct
 	     || usb_string(dev, dev->descriptor.iProduct,
 			   card->longname + len, sizeof(card->longname) - len) <= 0)
 	    && quirk && quirk->product_name) {
-		strncpy(card->longname + len, quirk->product_name, sizeof(card->longname) - len - 1);
-		card->longname[sizeof(card->longname) - 1] = '\0';
+		strlcat(card->longname, quirk->product_name, sizeof(card->longname));
 	}
-	/* add device path to longname */
-	len = strlen(card->longname);
-	if (sizeof(card->longname) - len > 10) {
-		strcpy(card->longname + len, " at ");
-		len += 4;
+
+	len = strlcat(card->longname, " at ", sizeof(card->longname));
+
+	if (len < sizeof(card->longname))
 		usb_make_path(dev, card->longname + len, sizeof(card->longname) - len);
-	}
 
 	*rchip = chip;
 	return 0;
Index: sound/oss/cs4281/cs4281m.c
===================================================================
--- sound/oss/cs4281/cs4281m.c	(revision 10094)
+++ sound/oss/cs4281/cs4281m.c	(working copy)
@@ -2266,8 +2266,8 @@
 	}
 	if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, "CS4281", sizeof(info.id));
-		strncpy(info.name, "Crystal CS4281", sizeof(info.name));
+		strlcpy(info.id, "CS4281", sizeof(info.id));
+		strlcpy(info.name, "Crystal CS4281", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *) arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -2275,8 +2275,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, "CS4281", sizeof(info.id));
-		strncpy(info.name, "Crystal CS4281", sizeof(info.name));
+		strlcpy(info.id, "CS4281", sizeof(info.id));
+		strlcpy(info.name, "Crystal CS4281", sizeof(info.name));
 		if (copy_to_user((void *) arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
Index: sound/oss/soundcard.c
===================================================================
--- sound/oss/soundcard.c	(revision 10094)
+++ sound/oss/soundcard.c	(working copy)
@@ -289,9 +289,8 @@
 {
 	mixer_info info;
 
-	strncpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
-	strncpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
-	info.name[sizeof(info.name)-1] = 0;
+	strlcpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
+	strlcpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
 	info.modify_counter = mixer_devs[dev]->modify_counter;
 	if (__copy_to_user(arg, &info,  sizeof(info)))
 		return -EFAULT;
@@ -302,9 +301,8 @@
 {
 	_old_mixer_info info;
 
- 	strncpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
- 	strncpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
- 	info.name[sizeof(info.name)-1] = 0;	
+ 	strlcpy(info.id, mixer_devs[dev]->id, sizeof(info.id));
+ 	strlcpy(info.name, mixer_devs[dev]->name, sizeof(info.name));
  	if (copy_to_user(arg, &info,  sizeof(info)))
 		return -EFAULT;
 	return 0;
Index: sound/oss/dev_table.c
===================================================================
--- sound/oss/dev_table.c	(revision 10094)
+++ sound/oss/dev_table.c	(working copy)
@@ -22,7 +22,7 @@
 {
 	struct audio_driver *d;
 	struct audio_operations *op;
-	int l, num;
+	int num;
 
 	if (vers != AUDIO_DRIVER_VERSION || driver_size > sizeof(struct audio_driver)) {
 		printk(KERN_ERR "Sound: Incompatible audio driver for %s\n", name);
@@ -58,11 +58,7 @@
 	memcpy((char *) d, (char *) driver, driver_size);
 
 	op->d = d;
-	l = strlen(name) + 1;
-	if (l > sizeof(op->name))
-		l = sizeof(op->name);
-	strncpy(op->name, name, l);
-	op->name[l - 1] = 0;
+	strlcpy(op->name, name, sizeof(op->name));
 	op->flags = flags;
 	op->format_mask = format_mask;
 	op->devc = devc;
@@ -82,7 +78,6 @@
 	int driver_size, void *devc)
 {
 	struct mixer_operations *op;
-	int l;
 
 	int n = sound_alloc_mixerdev();
 
@@ -110,11 +105,7 @@
 	memset((char *) op, 0, sizeof(struct mixer_operations));
 	memcpy((char *) op, (char *) driver, driver_size);
 
-	l = strlen(name) + 1;
-	if (l > sizeof(op->name))
-		l = sizeof(op->name);
-	strncpy(op->name, name, l);
-	op->name[l - 1] = 0;
+	strlcpy(op->name, name, sizeof(op->name));
 	op->devc = devc;
 
 	mixer_devs[n] = op;
Index: sound/oss/cmpci.c
===================================================================
--- sound/oss/cmpci.c	(revision 10094)
+++ sound/oss/cmpci.c	(working copy)
@@ -1268,8 +1268,8 @@
 	VALIDATE_STATE(s);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, "cmpci", sizeof(info.id));
-		strncpy(info.name, "C-Media PCI", sizeof(info.name));
+		strlcpy(info.id, "cmpci", sizeof(info.id));
+		strlcpy(info.name, "C-Media PCI", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -1277,8 +1277,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, "cmpci", sizeof(info.id));
-		strncpy(info.name, "C-Media cmpci", sizeof(info.name));
+		strlcpy(info.id, "cmpci", sizeof(info.id));
+		strlcpy(info.name, "C-Media cmpci", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
Index: sound/oss/msnd_pinnacle.c
===================================================================
--- sound/oss/msnd_pinnacle.c	(revision 10094)
+++ sound/oss/msnd_pinnacle.c	(working copy)
@@ -555,8 +555,8 @@
 }
 
 #define set_mixer_info()							\
-		strncpy(info.id, "MSNDMIXER", sizeof(info.id));			\
-		strncpy(info.name, "MultiSound Mixer", sizeof(info.name));
+		strlcpy(info.id, "MSNDMIXER", sizeof(info.id));			\
+		strlcpy(info.name, "MultiSound Mixer", sizeof(info.name));
 
 static int mixer_ioctl(unsigned int cmd, unsigned long arg)
 {
Index: sound/oss/sequencer.c
===================================================================
--- sound/oss/sequencer.c	(revision 10094)
+++ sound/oss/sequencer.c	(working copy)
@@ -1477,7 +1477,7 @@
 			if (!(synth_open_mask & (1 << dev)) && !orig_dev)
 				return -EBUSY;
 			memcpy(&inf, synth_devs[dev]->info, sizeof(inf));
-			strncpy(inf.name, synth_devs[dev]->id, sizeof(inf.name));
+			strlcpy(inf.name, synth_devs[dev]->id, sizeof(inf.name));
 			inf.device = dev;
 			return copy_to_user(arg, &inf, sizeof(inf))?-EFAULT:0;
 
Index: sound/oss/esssolo1.c
===================================================================
--- sound/oss/esssolo1.c	(revision 10094)
+++ sound/oss/esssolo1.c	(working copy)
@@ -721,8 +721,8 @@
 	}
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, "Solo1", sizeof(info.id));
-		strncpy(info.name, "ESS Solo1", sizeof(info.name));
+		strlcpy(info.id, "Solo1", sizeof(info.id));
+		strlcpy(info.name, "ESS Solo1", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -730,8 +730,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, "Solo1", sizeof(info.id));
-		strncpy(info.name, "ESS Solo1", sizeof(info.name));
+		strlcpy(info.id, "Solo1", sizeof(info.id));
+		strlcpy(info.name, "ESS Solo1", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
Index: sound/oss/maestro.c
===================================================================
--- sound/oss/maestro.c	(revision 10094)
+++ sound/oss/maestro.c	(working copy)
@@ -2024,8 +2024,8 @@
 	VALIDATE_CARD(card);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, card_names[card->card_type], sizeof(info.id));
-		strncpy(info.name,card_names[card->card_type],sizeof(info.name));
+		strlcpy(info.id, card_names[card->card_type], sizeof(info.id));
+		strlcpy(info.name, card_names[card->card_type], sizeof(info.name));
 		info.modify_counter = card->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -2033,8 +2033,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, card_names[card->card_type], sizeof(info.id));
-		strncpy(info.name,card_names[card->card_type],sizeof(info.name));
+		strlcpy(info.id, card_names[card->card_type], sizeof(info.id));
+		strlcpy(info.name, card_names[card->card_type], sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
Index: sound/oss/es1370.c
===================================================================
--- sound/oss/es1370.c	(revision 10094)
+++ sound/oss/es1370.c	(working copy)
@@ -889,8 +889,8 @@
 	}
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, "ES1370", sizeof(info.id));
-		strncpy(info.name, "Ensoniq ES1370", sizeof(info.name));
+		strlcpy(info.id, "ES1370", sizeof(info.id));
+		strlcpy(info.name, "Ensoniq ES1370", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -898,8 +898,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, "ES1370", sizeof(info.id));
-		strncpy(info.name, "Ensoniq ES1370", sizeof(info.name));
+		strlcpy(info.id, "ES1370", sizeof(info.id));
+		strlcpy(info.name, "Ensoniq ES1370", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
Index: sound/oss/dmasound/dmasound_core.c
===================================================================
--- sound/oss/dmasound/dmasound_core.c	(revision 10094)
+++ sound/oss/dmasound/dmasound_core.c	(working copy)
@@ -351,9 +351,8 @@
 	    case SOUND_MIXER_INFO:
 		{
 		    mixer_info info;
-		    strncpy(info.id, dmasound.mach.name2, sizeof(info.id));
-		    strncpy(info.name, dmasound.mach.name2, sizeof(info.name));
-		    info.name[sizeof(info.name)-1] = 0;
+		    strlcpy(info.id, dmasound.mach.name2, sizeof(info.id));
+		    strlcpy(info.name, dmasound.mach.name2, sizeof(info.name));
 		    info.modify_counter = mixer.modify_counter;
 		    if (copy_to_user((int *)arg, &info, sizeof(info)))
 			    return -EFAULT;
Index: sound/oss/emu10k1/mixer.c
===================================================================
--- sound/oss/emu10k1/mixer.c	(revision 10094)
+++ sound/oss/emu10k1/mixer.c	(working copy)
@@ -623,8 +623,8 @@
 		if (cmd == SOUND_MIXER_INFO) {
 			mixer_info info;
 
-			strncpy(info.id, card->ac97.name, sizeof(info.id));
-			strncpy(info.name, "Creative SBLive - Emu10k1", sizeof(info.name));
+			strlcpy(info.id, card->ac97.name, sizeof(info.id));
+			strlcpy(info.name, "Creative SBLive - Emu10k1", sizeof(info.name));
 			info.modify_counter = card->ac97.modcnt;
 
 			if (copy_to_user((void *)arg, &info, sizeof(info)))
Index: sound/oss/ac97_codec.c
===================================================================
--- sound/oss/ac97_codec.c	(revision 10094)
+++ sound/oss/ac97_codec.c	(working copy)
@@ -487,8 +487,8 @@
 
 	if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, codec->name, sizeof(info.id));
-		strncpy(info.name, codec->name, sizeof(info.name));
+		strlcpy(info.id, codec->name, sizeof(info.id));
+		strlcpy(info.name, codec->name, sizeof(info.name));
 		info.modify_counter = codec->modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -496,8 +496,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, codec->name, sizeof(info.id));
-		strncpy(info.name, codec->name, sizeof(info.name));
+		strlcpy(info.id, codec->name, sizeof(info.id));
+		strlcpy(info.name, codec->name, sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
Index: sound/oss/sonicvibes.c
===================================================================
--- sound/oss/sonicvibes.c	(revision 10094)
+++ sound/oss/sonicvibes.c	(working copy)
@@ -1046,8 +1046,8 @@
 	VALIDATE_STATE(s);
         if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
-		strncpy(info.id, "SonicVibes", sizeof(info.id));
-		strncpy(info.name, "S3 SonicVibes", sizeof(info.name));
+		strlcpy(info.id, "SonicVibes", sizeof(info.id));
+		strlcpy(info.name, "S3 SonicVibes", sizeof(info.name));
 		info.modify_counter = s->mix.modcnt;
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
@@ -1055,8 +1055,8 @@
 	}
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
-		strncpy(info.id, "SonicVibes", sizeof(info.id));
-		strncpy(info.name, "S3 SonicVibes", sizeof(info.name));
+		strlcpy(info.id, "SonicVibes", sizeof(info.id));
+		strlcpy(info.name, "S3 SonicVibes", sizeof(info.name));
 		if (copy_to_user((void *)arg, &info, sizeof(info)))
 			return -EFAULT;
 		return 0;
Index: sound/oss/btaudio.c
===================================================================
--- sound/oss/btaudio.c	(revision 10094)
+++ sound/oss/btaudio.c	(working copy)
@@ -328,8 +328,8 @@
 	if (cmd == SOUND_MIXER_INFO) {
 		mixer_info info;
 		memset(&info,0,sizeof(info));
-                strncpy(info.id,"bt878",sizeof(info.id)-1);
-                strncpy(info.name,"Brooktree Bt878 audio",sizeof(info.name)-1);
+                strlcpy(info.id,"bt878",sizeof(info.id));
+                strlcpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
                 info.modify_counter = bta->mixcount;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -338,8 +338,8 @@
 	if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
 		memset(&info,0,sizeof(info));
-                strncpy(info.id,"bt878",sizeof(info.id)-1);
-                strncpy(info.name,"Brooktree Bt878 audio",sizeof(info.name)-1);
+                strlcpy(info.id,"bt878",sizeof(info.id)-1);
+                strlcpy(info.name,"Brooktree Bt878 audio",sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
 		return 0;
Index: sound/oss/gus_wave.c
===================================================================
--- sound/oss/gus_wave.c	(revision 10094)
+++ sound/oss/gus_wave.c	(working copy)
@@ -2851,7 +2851,7 @@
 	unsigned long flags;
 	unsigned char val;
 	char *model_num = "2.4";
-	char tmp[64], tmp2[64];
+	char tmp[64];
 	int gus_type = 0x24;	/* 2.4 */
 
 	int irq = hw_config->irq, dma = hw_config->dma, dma2 = hw_config->dma2;
@@ -2998,19 +2998,14 @@
 	}
 
 	if (hw_config->name)
-	{
-		strncpy(tmp, hw_config->name, 45);
-		tmp[45] = 0;
-		sprintf(tmp2, "%s (%dk)", tmp, (int) gus_mem_size / 1024);
-		tmp2[sizeof(tmp2) - 1] = 0;
-	}
+		snprintf(tmp, sizeof(tmp), "%s (%dk)", hw_config->name,
+			 (int) gus_mem_size / 1024);
 	else if (gus_pnp_flag)
-	{
-		sprintf(tmp2, "Gravis UltraSound PnP (%dk)",
-			(int) gus_mem_size / 1024);
-	}
+		snprintf(tmp, sizeof(tmp), "Gravis UltraSound PnP (%dk)",
+			 (int) gus_mem_size / 1024);
 	else
-		sprintf(tmp2, "Gravis UltraSound %s (%dk)", model_num, (int) gus_mem_size / 1024);
+		snprintf(tmp, sizeof(tmp), "Gravis UltraSound %s (%dk)", model_num,
+			 (int) gus_mem_size / 1024);
 
 
 	samples = (struct patch_info *)vmalloc((MAX_SAMPLE + 1) * sizeof(*samples));
@@ -3019,9 +3014,8 @@
 		printk(KERN_WARNING "gus_init: Cant allocate memory for instrument tables\n");
 		return;
 	}
-	conf_printf(tmp2, hw_config);
-	tmp2[sizeof(gus_info.name) - 1] = 0;
-	strcpy(gus_info.name, tmp2);
+	conf_printf(tmp, hw_config);
+	strlcpy(gus_info.name, tmp, sizeof(gus_info.name));
 
 	if ((sdev = sound_alloc_synthdev()) == -1)
 		printk(KERN_WARNING "gus_init: Too many synthesizers\n");
Index: sound/pci/emu10k1/emufx.c
===================================================================
--- sound/pci/emu10k1/emufx.c	(revision 10094)
+++ sound/pci/emu10k1/emufx.c	(working copy)
@@ -1033,7 +1033,7 @@
 			memset(&gctl, 0, sizeof(gctl));
 			id = &ctl->kcontrol->id;
 			gctl.id.iface = id->iface;
-			strncpy(gctl.id.name, id->name, sizeof(gctl.id.name));
+			strlcpy(gctl.id.name, id->name, sizeof(gctl.id.name));
 			gctl.id.index = id->index;
 			gctl.id.device = id->device;
 			gctl.id.subdevice = id->subdevice;
@@ -1063,8 +1063,7 @@
 	down(&emu->fx8010.lock);
 	if ((err = snd_emu10k1_verify_controls(emu, icode)) < 0)
 		goto __error;
-	strncpy(emu->fx8010.name, icode->name, sizeof(emu->fx8010.name)-1);
-	emu->fx8010.name[sizeof(emu->fx8010.name)-1] = '\0';
+	strlcpy(emu->fx8010.name, icode->name, sizeof(emu->fx8010.name));
 	/* stop FX processor - this may be dangerous, but it's better to miss
 	   some samples than generate wrong ones - [jk] */
 	if (emu->audigy)
@@ -1092,8 +1091,7 @@
 	int err;
 
 	down(&emu->fx8010.lock);
-	strncpy(icode->name, emu->fx8010.name, sizeof(icode->name)-1);
-	emu->fx8010.name[sizeof(emu->fx8010.name)-1] = '\0';
+	strlcpy(icode->name, emu->fx8010.name, sizeof(icode->name));
 	/* ok, do the main job */
 	snd_emu10k1_gpr_peek(emu, icode);
 	snd_emu10k1_tram_peek(emu, icode);
Index: sound/isa/sb/sb_mixer.c
===================================================================
--- sound/isa/sb/sb_mixer.c	(revision 10094)
+++ sound/isa/sb/sb_mixer.c	(working copy)
@@ -452,7 +452,7 @@
 	ctl = snd_ctl_new1(&newctls[type], chip);
 	if (! ctl)
 		return -ENOMEM;
-	strncpy(ctl->id.name, name, sizeof(ctl->id.name)-1);
+	strlcpy(ctl->id.name, name, sizeof(ctl->id.name));
 	ctl->id.index = index;
 	ctl->private_value = value;
 	if ((err = snd_ctl_add(chip->card, ctl)) < 0) {
Index: sound/isa/sb/sb16_csp.c
===================================================================
--- sound/isa/sb/sb16_csp.c	(revision 10094)
+++ sound/isa/sb/sb16_csp.c	(working copy)
@@ -393,8 +393,7 @@
 				return err;
 
 			/* fill in codec header */
-			strncpy(p->codec_name, info.codec_name, sizeof(p->codec_name) - 1);
-			p->codec_name[sizeof(p->codec_name) - 1] = 0;
+			strlcpy(p->codec_name, info.codec_name, sizeof(p->codec_name));
 			p->func_nr = func_nr;
 			p->mode = LE_SHORT(funcdesc_h.flags_play_rec);
 			switch (LE_SHORT(funcdesc_h.VOC_type)) {
Index: sound/isa/ad1848/ad1848_lib.c
===================================================================
--- sound/isa/ad1848/ad1848_lib.c	(revision 10094)
+++ sound/isa/ad1848/ad1848_lib.c	(working copy)
@@ -1148,7 +1148,7 @@
 	ctl = snd_ctl_new1(&newctls[type], chip);
 	if (! ctl)
 		return -ENOMEM;
-	strncpy(ctl->id.name, name, sizeof(ctl->id.name)-1);
+	strlcpy(ctl->id.name, name, sizeof(ctl->id.name));
 	ctl->id.index = index;
 	ctl->private_value = value;
 	if ((err = snd_ctl_add(chip->card, ctl)) < 0) {
Index: sound/i2c/i2c.c
===================================================================
--- sound/i2c/i2c.c	(revision 10094)
+++ sound/i2c/i2c.c	(working copy)
@@ -93,7 +93,7 @@
 		list_add_tail(&bus->buses, &master->buses);
 		bus->master = master;
 	}
-	strncpy(bus->name, name, sizeof(bus->name) - 1);
+	strlcpy(bus->name, name, sizeof(bus->name));
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, bus, &ops)) < 0) {
 		snd_i2c_bus_free(bus);
 		return err;
@@ -112,7 +112,7 @@
 	if (device == NULL)
 		return -ENOMEM;
 	device->addr = addr;
-	strncpy(device->name, name, sizeof(device->name)-1);
+	strlcpy(device->name, name, sizeof(device->name));
 	list_add_tail(&device->list, &bus->devices);
 	device->bus = bus;
 	*rdevice = device;
Index: sound/drivers/opl3/opl3_oss.c
===================================================================
--- sound/drivers/opl3/opl3_oss.c	(revision 10094)
+++ sound/drivers/opl3/opl3_oss.c	(working copy)
@@ -123,8 +123,7 @@
 		return;
 
 	opl3->oss_seq_dev = dev;
-	strncpy(dev->name, name, sizeof(dev->name) - 1);
-	dev->name[sizeof(dev->name) - 1] = 0;
+	strlcpy(dev->name, name, sizeof(dev->name));
 	arg = SNDRV_SEQ_DEVICE_ARGPTR(dev);
 	arg->type = SYNTH_TYPE_FM;
 	if (opl3->hardware < OPL3_HW_OPL3) {
