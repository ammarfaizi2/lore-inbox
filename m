Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUK0Uqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUK0Uqq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 15:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUK0Uqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 15:46:46 -0500
Received: from smtp.etmail.cz ([160.218.43.220]:64673 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S261324AbUK0Unr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 15:43:47 -0500
Date: Sat, 27 Nov 2004 21:43:17 +0100
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] Document kfree and vfree NULL usage
Message-ID: <20041127204317.GA21422@penguin.localdomain>
Mail-Followup-To: Pekka Enberg <penberg@cs.helsinki.fi>,
	akpm@osdl.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
References: <1101565560.9988.20.camel@localhost> <20041127171357.GA5381@penguin.localdomain> <1101583844.9988.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <1101583844.9988.6.camel@localhost>
User-Agent: Mutt/1.5.6+20040722i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 27, 2004 at 09:30:43PM +0200, Pekka Enberg wrote:
> Hi Marcel,
>=20
> On Sat, 2004-11-27 at 18:13 +0100, Marcel Sebek wrote:
> > I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
> > constructions. I'm going to to this for most of the kernel if I found
> > some time.
>=20
> I have patches to clean up vfree() in the kernel which I am planning to
> send to the maintainers.
>=20
> On Sat, 2004-11-27 at 18:13 +0100, Marcel Sebek wrote:
> >  static int snd_emu10k1_playback_open(snd_pcm_substream_t * substream)
> > diff -urpN linux-2.6.10-rc2/sound/pci/ice1712/ak4xxx.c linux-2.6.10-rc2=
=2Echanged/sound/pci/ice1712/ak4xxx.c
> > --- linux-2.6.10-rc2/sound/pci/ice1712/ak4xxx.c	2004-09-13 19:45:33.000=
000000 +0200
> > +++ linux-2.6.10-rc2.changed/sound/pci/ice1712/ak4xxx.c	2004-11-27 17:2=
1:57.000000000 +0100
> > @@ -151,8 +151,7 @@ void snd_ice1712_akm4xxx_free(ice1712_t=20
> >  		return;
> >  	for (akidx =3D 0; akidx < ice->akm_codecs; akidx++) {
> >  		akm4xxx_t *ak =3D &ice->akm[akidx];
> > -		if (ak->private_value[0])
> > -			kfree((void *)ak->private_value[0]);
> > +		kfree(ak->private_value[0]);
>=20
> Did you compile this? The type of ak->private_value seems to be unsigned
> long so you need that cast here.
>=20
> Please compile the kernel with allmodconfig to make sure you did not
> break anything and then send these to the ALSA maintainers.
>=20
You are right. Next time I'll do it. Here's corrected compile-tested
version of the patch.

Signed-off-by: Marcel Sebek <sebek64@post.cz>


diff -urpN linux-2.6.10/sound/core/info.c linux-2.6.10-new/sound/core/info.c
--- linux-2.6.10/sound/core/info.c	2004-11-15 15:55:09.000000000 +0100
+++ linux-2.6.10-new/sound/core/info.c	2004-11-27 21:21:50.000000000 +0100
@@ -895,8 +895,7 @@ void snd_info_free_entry(snd_info_entry_
 {
 	if (entry =3D=3D NULL)
 		return;
-	if (entry->name)
-		kfree((char *)entry->name);
+	kfree(entry->name);
 	if (entry->private_free)
 		entry->private_free(entry);
 	kfree(entry);
diff -urpN linux-2.6.10/sound/core/init.c linux-2.6.10-new/sound/core/init.c
--- linux-2.6.10/sound/core/init.c	2004-10-23 10:55:09.000000000 +0200
+++ linux-2.6.10-new/sound/core/init.c	2004-11-27 21:21:50.000000000 +0100
@@ -665,9 +665,8 @@ int snd_card_file_remove(snd_card_t *car
 	spin_unlock(&card->files_lock);
 	if (card->files =3D=3D NULL)
 		wake_up(&card->shutdown_sleep);
-	if (mfile) {
-		kfree(mfile);
-	} else {
+	kfree(mfile);
+	if (!mfile) {
 		snd_printk(KERN_ERR "ALSA card file remove problem (%p)\n", file);
 		return -ENOENT;
 	}
diff -urpN linux-2.6.10/sound/core/ioctl32/ioctl32.c linux-2.6.10-new/sound=
/core/ioctl32/ioctl32.c
--- linux-2.6.10/sound/core/ioctl32/ioctl32.c	2004-11-15 15:55:09.000000000=
 +0100
+++ linux-2.6.10-new/sound/core/ioctl32/ioctl32.c	2004-11-27 21:21:50.00000=
0000 +0100
@@ -370,10 +370,8 @@ static inline int _snd_ioctl32_ctl_elem_
 	if (copy_to_user((void __user *)arg, data32, sizeof(*data32)))
 		err =3D -EFAULT;
       __end:
-      	if (data32)
-      		kfree(data32);
-	if (data)
-		kfree(data);
+      	kfree(data32);
+	kfree(data);
 	return err;
 }
=20
diff -urpN linux-2.6.10/sound/core/ioctl32/ioctl32.h linux-2.6.10-new/sound=
/core/ioctl32/ioctl32.h
--- linux-2.6.10/sound/core/ioctl32/ioctl32.h	2004-11-15 15:55:09.000000000=
 +0100
+++ linux-2.6.10-new/sound/core/ioctl32/ioctl32.h	2004-11-27 21:21:50.00000=
0000 +0100
@@ -103,10 +103,8 @@ static inline int _snd_ioctl32_##type(un
 			err =3D -EFAULT;\
 	}\
       __end:\
-      	if (data)\
-      		kfree(data);\
-      	if (data32)\
-      		kfree(data32);\
+      	kfree(data);\
+      	kfree(data32);\
 	return err;\
 }
=20
diff -urpN linux-2.6.10/sound/core/ioctl32/pcm32.c linux-2.6.10-new/sound/c=
ore/ioctl32/pcm32.c
--- linux-2.6.10/sound/core/ioctl32/pcm32.c	2004-11-15 15:55:09.000000000 +=
0100
+++ linux-2.6.10-new/sound/core/ioctl32/pcm32.c	2004-11-27 21:21:50.0000000=
00 +0100
@@ -224,10 +224,8 @@ static inline int _snd_ioctl32_pcm_hw_pa
 	else
 		recalculate_boundary(file);
       __end:
-      	if (data)
-      		kfree(data);
-      	if (data32)
-      		kfree(data32);
+      	kfree(data);
+      	kfree(data32);
 	return err;
 }
=20
@@ -432,10 +430,8 @@ static inline int _snd_ioctl32_pcm_hw_pa
 	else
 		recalculate_boundary(file);
       __end:
-      	if (data)
-      		kfree(data);
-      	if (data32)
-      		kfree(data32);
+      	kfree(data);
+      	kfree(data32);
 	return err;
 }
=20
diff -urpN linux-2.6.10/sound/core/oss/mixer_oss.c linux-2.6.10-new/sound/c=
ore/oss/mixer_oss.c
--- linux-2.6.10/sound/core/oss/mixer_oss.c	2004-09-13 19:45:29.000000000 +=
0200
+++ linux-2.6.10-new/sound/core/oss/mixer_oss.c	2004-11-27 21:21:50.0000000=
00 +0100
@@ -527,10 +527,8 @@ static void snd_mixer_oss_get_volume1_vo
 		*right =3D snd_mixer_oss_conv1(uctl->value.integer.value[1], uinfo->valu=
e.integer.min, uinfo->value.integer.max, &pslot->volume[1]);
       __unalloc:
 	up_read(&card->controls_rwsem);
-      	if (uctl)
-      		kfree(uctl);
-      	if (uinfo)
-      		kfree(uinfo);
+      	kfree(uctl);
+      	kfree(uinfo);
 }
=20
 static void snd_mixer_oss_get_volume1_sw(snd_mixer_oss_file_t *fmixer,
@@ -566,10 +564,8 @@ static void snd_mixer_oss_get_volume1_sw
 		*right =3D 0;
       __unalloc:
 	up_read(&card->controls_rwsem);
-      	if (uctl)
-      		kfree(uctl);
-      	if (uinfo)
-		kfree(uinfo);
+      	kfree(uctl);
+	kfree(uinfo);
 }
=20
 static int snd_mixer_oss_get_volume1(snd_mixer_oss_file_t *fmixer,
@@ -628,10 +624,8 @@ static void snd_mixer_oss_put_volume1_vo
 		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
       __unalloc:
 	up_read(&card->controls_rwsem);
-      	if (uctl)
-      		kfree(uctl);
-      	if (uinfo)
-		kfree(uinfo);
+      	kfree(uctl);
+	kfree(uinfo);
 }
=20
 static void snd_mixer_oss_put_volume1_sw(snd_mixer_oss_file_t *fmixer,
@@ -673,10 +667,8 @@ static void snd_mixer_oss_put_volume1_sw
 		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
       __unalloc:
 	up_read(&card->controls_rwsem);
-      	if (uctl)
-      		kfree(uctl);
-      	if (uinfo)
-		kfree(uinfo);
+      	kfree(uctl);
+	kfree(uinfo);
 }
=20
 static int snd_mixer_oss_put_volume1(snd_mixer_oss_file_t *fmixer,
@@ -802,10 +794,8 @@ static int snd_mixer_oss_get_recsrc2(snd
 	err =3D 0;
       __unlock:
      	up_read(&card->controls_rwsem);
-      	if (uctl)
-      		kfree(uctl);
-      	if (uinfo)
-      		kfree(uinfo);
+      	kfree(uctl);
+      	kfree(uinfo);
       	return err;
 }
=20
@@ -853,10 +843,8 @@ static int snd_mixer_oss_put_recsrc2(snd
 	err =3D 0;
       __unlock:
 	up_read(&card->controls_rwsem);
-	if (uctl)
-		kfree(uctl);
-	if (uinfo)
-		kfree(uinfo);
+	kfree(uctl);
+	kfree(uinfo);
 	return err;
 }
=20
diff -urpN linux-2.6.10/sound/core/oss/pcm_oss.c linux-2.6.10-new/sound/cor=
e/oss/pcm_oss.c
--- linux-2.6.10/sound/core/oss/pcm_oss.c	2004-11-27 17:06:17.000000000 +01=
00
+++ linux-2.6.10-new/sound/core/oss/pcm_oss.c	2004-11-27 21:21:50.000000000=
 +0100
@@ -513,8 +513,7 @@ static int snd_pcm_oss_change_params(snd
=20
 	runtime->oss.params =3D 0;
 	runtime->oss.prepare =3D 1;
-	if (runtime->oss.buffer !=3D NULL)
-		vfree(runtime->oss.buffer);
+	vfree(runtime->oss.buffer);
 	runtime->oss.buffer =3D vmalloc(runtime->oss.period_bytes);
 	runtime->oss.buffer_used =3D 0;
 	if (runtime->dma_area)
@@ -524,12 +523,9 @@ static int snd_pcm_oss_change_params(snd
=20
 	err =3D 0;
 failure:
-	if (sw_params)
-		kfree(sw_params);
-	if (params)
-		kfree(params);
-	if (sparams)
-		kfree(sparams);
+	kfree(sw_params);
+	kfree(params);
+	kfree(sparams);
 	return err;
 }
=20
@@ -1671,8 +1667,7 @@ static void snd_pcm_oss_release_substrea
 {
 	snd_pcm_runtime_t *runtime;
 	runtime =3D substream->runtime;
-	if (runtime->oss.buffer)
-		vfree(runtime->oss.buffer);
+	vfree(runtime->oss.buffer);
 	snd_pcm_oss_plugin_clear(substream);
 	substream->oss.file =3D NULL;
 	substream->oss.oss =3D 0;
diff -urpN linux-2.6.10/sound/core/oss/pcm_plugin.c linux-2.6.10-new/sound/=
core/oss/pcm_plugin.c
--- linux-2.6.10/sound/core/oss/pcm_plugin.c	2004-09-13 19:45:29.000000000 =
+0200
+++ linux-2.6.10-new/sound/core/oss/pcm_plugin.c	2004-11-27 21:21:50.000000=
000 +0100
@@ -86,8 +86,7 @@ static int snd_pcm_plugin_alloc(snd_pcm_
 	snd_assert((size % 8) =3D=3D 0, return -ENXIO);
 	size /=3D 8;
 	if (plugin->buf_frames < frames) {
-		if (plugin->buf)
-			vfree(plugin->buf);
+		vfree(plugin->buf);
 		plugin->buf =3D vmalloc(size);
 		plugin->buf_frames =3D frames;
 	}
@@ -217,14 +216,10 @@ int snd_pcm_plugin_free(snd_pcm_plugin_t
 		return 0;
 	if (plugin->private_free)
 		plugin->private_free(plugin);
-	if (plugin->buf_channels)
-		kfree(plugin->buf_channels);
-	if (plugin->buf)
-		vfree(plugin->buf);
-	if (plugin->src_vmask)
-		kfree(plugin->src_vmask);
-	if (plugin->dst_vmask)
-		kfree(plugin->dst_vmask);
+	kfree(plugin->buf_channels);
+	vfree(plugin->buf);
+	kfree(plugin->src_vmask);
+	kfree(plugin->dst_vmask);
 	kfree(plugin);
 	return 0;
 }
diff -urpN linux-2.6.10/sound/core/oss/route.c linux-2.6.10-new/sound/core/=
oss/route.c
--- linux-2.6.10/sound/core/oss/route.c	2004-09-13 19:45:29.000000000 +0200
+++ linux-2.6.10-new/sound/core/oss/route.c	2004-11-27 21:21:50.000000000 +=
0100
@@ -407,8 +407,7 @@ static void route_free(snd_pcm_plugin_t=20
 	route_t *data =3D (route_t *)plugin->extra_data;
 	unsigned int dst_channel;
 	for (dst_channel =3D 0; dst_channel < plugin->dst_format.channels; ++dst_=
channel) {
-		if (data->ttable[dst_channel].srcs !=3D NULL)
-			kfree(data->ttable[dst_channel].srcs);
+		kfree(data->ttable[dst_channel].srcs);
 	}
 }
=20
diff -urpN linux-2.6.10/sound/core/pcm.c linux-2.6.10-new/sound/core/pcm.c
--- linux-2.6.10/sound/core/pcm.c	2004-11-15 15:55:09.000000000 +0100
+++ linux-2.6.10-new/sound/core/pcm.c	2004-11-27 21:21:50.000000000 +0100
@@ -830,8 +830,7 @@ void snd_pcm_release_substream(snd_pcm_s
 		runtime->private_free(runtime);
 	snd_free_pages((void*)runtime->status, PAGE_ALIGN(sizeof(snd_pcm_mmap_sta=
tus_t)));
 	snd_free_pages((void*)runtime->control, PAGE_ALIGN(sizeof(snd_pcm_mmap_co=
ntrol_t)));
-	if (runtime->hw_constraints.rules)
-		kfree(runtime->hw_constraints.rules);
+	kfree(runtime->hw_constraints.rules);
 	kfree(runtime);
 	substream->runtime =3D NULL;
 	substream->pstr->substream_opened--;
diff -urpN linux-2.6.10/sound/core/pcm_native.c linux-2.6.10-new/sound/core=
/pcm_native.c
--- linux-2.6.10/sound/core/pcm_native.c	2004-11-15 15:55:09.000000000 +0100
+++ linux-2.6.10-new/sound/core/pcm_native.c	2004-11-27 21:21:50.000000000 =
+0100
@@ -1445,7 +1445,7 @@ static int snd_pcm_drain(snd_pcm_substre
=20
  _end:
 	snd_pcm_stream_unlock_irq(substream);
-	if (drec && drec !=3D &drec_tmp)
+	if (drec !=3D &drec_tmp)
 		kfree(drec);
  _unlock:
 	snd_power_unlock(card);
diff -urpN linux-2.6.10/sound/core/seq/oss/seq_oss_readq.c linux-2.6.10-new=
/sound/core/seq/oss/seq_oss_readq.c
--- linux-2.6.10/sound/core/seq/oss/seq_oss_readq.c	2004-09-13 19:45:29.000=
000000 +0200
+++ linux-2.6.10-new/sound/core/seq/oss/seq_oss_readq.c	2004-11-27 21:21:50=
=2E000000000 +0100
@@ -74,8 +74,7 @@ void
 snd_seq_oss_readq_delete(seq_oss_readq_t *q)
 {
 	if (q) {
-		if (q->q)
-			kfree(q->q);
+		kfree(q->q);
 		kfree(q);
 	}
 }
diff -urpN linux-2.6.10/sound/core/seq/seq_instr.c linux-2.6.10-new/sound/c=
ore/seq/seq_instr.c
--- linux-2.6.10/sound/core/seq/seq_instr.c	2004-09-13 19:45:29.000000000 +=
0200
+++ linux-2.6.10-new/sound/core/seq/seq_instr.c	2004-11-27 21:21:50.0000000=
00 +0100
@@ -56,8 +56,6 @@ snd_seq_kcluster_t *snd_seq_cluster_new(
=20
 void snd_seq_cluster_free(snd_seq_kcluster_t *cluster, int atomic)
 {
-	if (cluster =3D=3D NULL)
-		return;
 	kfree(cluster);
 }
=20
diff -urpN linux-2.6.10/sound/core/seq/seq_memory.c linux-2.6.10-new/sound/=
core/seq/seq_memory.c
--- linux-2.6.10/sound/core/seq/seq_memory.c	2004-09-13 19:45:29.000000000 =
+0200
+++ linux-2.6.10-new/sound/core/seq/seq_memory.c	2004-11-27 21:21:50.000000=
000 +0100
@@ -436,8 +436,7 @@ int snd_seq_pool_done(pool_t *pool)
 	pool->total_elements =3D 0;
 	spin_unlock_irqrestore(&pool->lock, flags);
=20
-	if (ptr)
-		vfree(ptr);
+	vfree(ptr);
=20
 	spin_lock_irqsave(&pool->lock, flags);
 	pool->closing =3D 0;
diff -urpN linux-2.6.10/sound/core/seq/seq_midi_emul.c linux-2.6.10-new/sou=
nd/core/seq/seq_midi_emul.c
--- linux-2.6.10/sound/core/seq/seq_midi_emul.c	2004-09-13 19:45:29.0000000=
00 +0200
+++ linux-2.6.10-new/sound/core/seq/seq_midi_emul.c	2004-11-27 21:21:50.000=
000000 +0100
@@ -713,8 +713,7 @@ void snd_midi_channel_free_set(snd_midi_
 {
 	if (chset =3D=3D NULL)
 		return;
-	if (chset->channels !=3D NULL)
-		kfree(chset->channels);
+	kfree(chset->channels);
 	kfree(chset);
 }
=20
diff -urpN linux-2.6.10/sound/core/seq/seq_midi_event.c linux-2.6.10-new/so=
und/core/seq/seq_midi_event.c
--- linux-2.6.10/sound/core/seq/seq_midi_event.c	2004-09-13 19:45:29.000000=
000 +0200
+++ linux-2.6.10-new/sound/core/seq/seq_midi_event.c	2004-11-27 21:21:50.00=
0000000 +0100
@@ -138,8 +138,7 @@ int snd_midi_event_new(int bufsize, snd_
 void snd_midi_event_free(snd_midi_event_t *dev)
 {
 	if (dev !=3D NULL) {
-		if (dev->buf)
-			kfree(dev->buf);
+		kfree(dev->buf);
 		kfree(dev);
 	}
 }
@@ -202,8 +201,7 @@ int snd_midi_event_resize_buffer(snd_mid
 	dev->bufsize =3D bufsize;
 	reset_encode(dev);
 	spin_unlock_irqrestore(&dev->lock, flags);
-	if (old_buf)
-		kfree(old_buf);
+	kfree(old_buf);
 	return 0;
 }
=20
diff -urpN linux-2.6.10/sound/core/sgbuf.c linux-2.6.10-new/sound/core/sgbu=
f.c
--- linux-2.6.10/sound/core/sgbuf.c	2004-09-13 19:45:29.000000000 +0200
+++ linux-2.6.10-new/sound/core/sgbuf.c	2004-11-27 21:21:50.000000000 +0100
@@ -51,10 +51,8 @@ int snd_free_sgbuf_pages(struct snd_dma_
 		vunmap(dmab->area);
 	dmab->area =3D NULL;
=20
-	if (sgbuf->table)
-		kfree(sgbuf->table);
-	if (sgbuf->page_table)
-		kfree(sgbuf->page_table);
+	kfree(sgbuf->table);
+	kfree(sgbuf->page_table);
 	kfree(sgbuf);
 	dmab->private_data =3D NULL;
 =09
diff -urpN linux-2.6.10/sound/core/timer.c linux-2.6.10-new/sound/core/time=
r.c
--- linux-2.6.10/sound/core/timer.c	2004-09-13 19:45:29.000000000 +0200
+++ linux-2.6.10-new/sound/core/timer.c	2004-11-27 21:21:50.000000000 +0100
@@ -351,8 +351,7 @@ int snd_timer_close(snd_timer_instance_t
 	}
 	if (timeri->private_free)
 		timeri->private_free(timeri);
-	if (timeri->owner)
-		kfree(timeri->owner);
+	kfree(timeri->owner);
 	kfree(timeri);
 	if (timer && timer->card)
 		module_put(timer->card->module);
@@ -1004,8 +1003,7 @@ static struct _snd_timer_hardware snd_ti
=20
 static void snd_timer_free_system(snd_timer_t *timer)
 {
-	if (timer->private_data)
-		kfree(timer->private_data);
+	kfree(timer->private_data);
 }
=20
 static int snd_timer_register_system(void)
@@ -1226,10 +1224,8 @@ static int snd_timer_user_release(struct
 		fasync_helper(-1, file, 0, &tu->fasync);
 		if (tu->timeri)
 			snd_timer_close(tu->timeri);
-		if (tu->queue)
-			kfree(tu->queue);
-		if (tu->tqueue)
-			kfree(tu->tqueue);
+		kfree(tu->queue);
+		kfree(tu->tqueue);
 		kfree(tu);
 	}
 	return 0;
diff -urpN linux-2.6.10/sound/i2c/cs8427.c linux-2.6.10-new/sound/i2c/cs842=
7.c
--- linux-2.6.10/sound/i2c/cs8427.c	2004-09-13 19:45:30.000000000 +0200
+++ linux-2.6.10-new/sound/i2c/cs8427.c	2004-11-27 21:21:50.000000000 +0100
@@ -156,8 +156,7 @@ static int snd_cs8427_send_corudata(snd_
=20
 static void snd_cs8427_free(snd_i2c_device_t *device)
 {
-	if (device->private_data)
-		kfree(device->private_data);
+	kfree(device->private_data);
 }
=20
 int snd_cs8427_create(snd_i2c_bus_t *bus,
diff -urpN linux-2.6.10/sound/i2c/l3/uda1341.c linux-2.6.10-new/sound/i2c/l=
3/uda1341.c
--- linux-2.6.10/sound/i2c/l3/uda1341.c	2004-09-13 19:45:30.000000000 +0200
+++ linux-2.6.10-new/sound/i2c/l3/uda1341.c	2004-11-27 21:21:50.000000000 +=
0100
@@ -730,8 +730,7 @@ static int uda1341_attach(struct l3_clie
=20
 static void uda1341_detach(struct l3_client *clnt)
 {
-	if (clnt->driver_data)
-		kfree(clnt->driver_data);
+	kfree(clnt->driver_data);
 }
=20
 static int
diff -urpN linux-2.6.10/sound/isa/gus/gus_mem.c linux-2.6.10-new/sound/isa/=
gus/gus_mem.c
--- linux-2.6.10/sound/isa/gus/gus_mem.c	2004-09-13 19:45:30.000000000 +0200
+++ linux-2.6.10-new/sound/isa/gus/gus_mem.c	2004-11-27 21:21:50.000000000 =
+0100
@@ -100,8 +100,7 @@ int snd_gf1_mem_xfree(snd_gf1_mem_t * al
 		if (block->prev)
 			block->prev->next =3D block->next;
 	}
-	if (block->name)
-		kfree(block->name);
+	kfree(block->name);
 	kfree(block);
 	return 0;
 }
diff -urpN linux-2.6.10/sound/isa/sb/emu8000_pcm.c linux-2.6.10-new/sound/i=
sa/sb/emu8000_pcm.c
--- linux-2.6.10/sound/isa/sb/emu8000_pcm.c	2004-09-13 19:45:30.000000000 +=
0200
+++ linux-2.6.10-new/sound/isa/sb/emu8000_pcm.c	2004-11-27 21:21:50.0000000=
00 +0100
@@ -260,8 +260,7 @@ static int emu8k_pcm_open(snd_pcm_substr
 static int emu8k_pcm_close(snd_pcm_substream_t *subs)
 {
 	emu8k_pcm_t *rec =3D subs->runtime->private_data;
-	if (rec)
-		kfree(rec);
+	kfree(rec);
 	subs->runtime->private_data =3D NULL;
 	return 0;
 }
diff -urpN linux-2.6.10/sound/isa/wavefront/wavefront_fx.c linux-2.6.10-new=
/sound/isa/wavefront/wavefront_fx.c
--- linux-2.6.10/sound/isa/wavefront/wavefront_fx.c	2004-09-13 19:45:30.000=
000000 +0200
+++ linux-2.6.10-new/sound/isa/wavefront/wavefront_fx.c	2004-11-27 21:21:50=
=2E000000000 +0100
@@ -537,8 +537,7 @@ snd_wavefront_fx_ioctl (snd_hwdep_t *sde
 			     r.data[1], /* addr */
 			     r.data[2], /* cnt */
 			     pd);
-		if (page_data)
-			kfree(page_data);
+		kfree(page_data);
 		break;
=20
 	default:
diff -urpN linux-2.6.10/sound/pci/ac97/ac97_codec.c linux-2.6.10-new/sound/=
pci/ac97/ac97_codec.c
--- linux-2.6.10/sound/pci/ac97/ac97_codec.c	2004-11-15 15:55:12.000000000 =
+0100
+++ linux-2.6.10-new/sound/pci/ac97/ac97_codec.c	2004-11-27 21:21:50.000000=
000 +0100
@@ -1055,8 +1055,7 @@ static int snd_ac97_bus_free(ac97_bus_t=20
 {
 	if (bus) {
 		snd_ac97_bus_proc_done(bus);
-		if (bus->pcms)
-			kfree(bus->pcms);
+		kfree(bus->pcms);
 		if (bus->private_free)
 			bus->private_free(bus);
 		kfree(bus);
diff -urpN linux-2.6.10/sound/pci/ali5451/ali5451.c linux-2.6.10-new/sound/=
pci/ali5451/ali5451.c
--- linux-2.6.10/sound/pci/ali5451/ali5451.c	2004-10-23 10:55:12.000000000 =
+0200
+++ linux-2.6.10-new/sound/pci/ali5451/ali5451.c	2004-11-27 21:21:50.000000=
000 +0100
@@ -1987,8 +1987,7 @@ static int snd_ali_free(ali_t * codec)
 	if (codec->port)
 		pci_release_regions(codec->pci);
 #ifdef CONFIG_PM
-	if (codec->image)
-		kfree(codec->image);
+	kfree(codec->image);
 #endif
 	kfree(codec);
 	return 0;
diff -urpN linux-2.6.10/sound/pci/cs46xx/dsp_spos.c linux-2.6.10-new/sound/=
pci/cs46xx/dsp_spos.c
--- linux-2.6.10/sound/pci/cs46xx/dsp_spos.c	2004-11-27 21:20:33.000000000 =
+0100
+++ linux-2.6.10-new/sound/pci/cs46xx/dsp_spos.c	2004-11-27 21:21:50.000000=
000 +0100
@@ -289,15 +289,9 @@ void  cs46xx_dsp_spos_destroy (cs46xx_t=20
 		cs46xx_dsp_proc_free_scb_desc ( (ins->scbs + i) );
 	}
=20
-	if (ins->code.data)
-		kfree(ins->code.data);
-
-	if (ins->symbol_table.symbols)
-		vfree(ins->symbol_table.symbols);
-
-	if (ins->modules)
-		kfree(ins->modules);
-=09
+	kfree(ins->code.data);
+	vfree(ins->symbol_table.symbols);
+	kfree(ins->modules);
 	kfree(ins);
 	up(&chip->spos_mutex);
 }
diff -urpN linux-2.6.10/sound/pci/emu10k1/emu10k1_main.c linux-2.6.10-new/s=
ound/pci/emu10k1/emu10k1_main.c
--- linux-2.6.10/sound/pci/emu10k1/emu10k1_main.c	2004-09-13 19:45:32.00000=
0000 +0200
+++ linux-2.6.10-new/sound/pci/emu10k1/emu10k1_main.c	2004-11-27 21:21:50.0=
00000000 +0100
@@ -553,10 +553,8 @@ static int snd_emu10k1_free(emu10k1_t *e
 		snd_dma_free_pages(&emu->silent_page);
 	if (emu->ptb_pages.area)
 		snd_dma_free_pages(&emu->ptb_pages);
-	if (emu->page_ptr_table)
-		vfree(emu->page_ptr_table);
-	if (emu->page_addr_table)
-		vfree(emu->page_addr_table);
+	vfree(emu->page_ptr_table);
+	vfree(emu->page_addr_table);
 	if (emu->irq >=3D 0)
 		free_irq(emu->irq, (void *)emu);
 	if (emu->port)
diff -urpN linux-2.6.10/sound/pci/emu10k1/emupcm.c linux-2.6.10-new/sound/p=
ci/emu10k1/emupcm.c
--- linux-2.6.10/sound/pci/emu10k1/emupcm.c	2004-11-15 15:55:12.000000000 +=
0100
+++ linux-2.6.10-new/sound/pci/emu10k1/emupcm.c	2004-11-27 21:21:50.0000000=
00 +0100
@@ -777,8 +777,7 @@ static void snd_emu10k1_pcm_free_substre
 {
 	emu10k1_pcm_t *epcm =3D runtime->private_data;
=20
-	if (epcm)
-		kfree(epcm);
+	kfree(epcm);
 }
=20
 static int snd_emu10k1_playback_open(snd_pcm_substream_t * substream)
diff -urpN linux-2.6.10/sound/pci/ice1712/ak4xxx.c linux-2.6.10-new/sound/p=
ci/ice1712/ak4xxx.c
--- linux-2.6.10/sound/pci/ice1712/ak4xxx.c	2004-09-13 19:45:33.000000000 +=
0200
+++ linux-2.6.10-new/sound/pci/ice1712/ak4xxx.c	2004-11-27 21:22:30.0000000=
00 +0100
@@ -151,8 +151,7 @@ void snd_ice1712_akm4xxx_free(ice1712_t=20
 		return;
 	for (akidx =3D 0; akidx < ice->akm_codecs; akidx++) {
 		akm4xxx_t *ak =3D &ice->akm[akidx];
-		if (ak->private_value[0])
-			kfree((void *)ak->private_value[0]);
+		kfree((void*)ak->private_value[0]);
 	}
 	kfree(ice->akm);
 }
diff -urpN linux-2.6.10/sound/pci/maestro3.c linux-2.6.10-new/sound/pci/mae=
stro3.c
--- linux-2.6.10/sound/pci/maestro3.c	2004-10-23 10:55:13.000000000 +0200
+++ linux-2.6.10-new/sound/pci/maestro3.c	2004-11-27 21:21:50.000000000 +01=
00
@@ -2374,8 +2374,7 @@ static int snd_m3_free(m3_t *chip)
 	}
=20
 #ifdef CONFIG_PM
-	if (chip->suspend_mem)
-		vfree(chip->suspend_mem);
+	vfree(chip->suspend_mem);
 #endif
=20
 	if (chip->irq >=3D 0) {
diff -urpN linux-2.6.10/sound/pci/trident/trident_main.c linux-2.6.10-new/s=
ound/pci/trident/trident_main.c
--- linux-2.6.10/sound/pci/trident/trident_main.c	2004-09-13 19:45:34.00000=
0000 +0200
+++ linux-2.6.10-new/sound/pci/trident/trident_main.c	2004-11-27 21:21:50.0=
00000000 +0100
@@ -3675,8 +3675,7 @@ int snd_trident_free(trident_t *trident)
 			snd_util_memhdr_free(trident->tlb.memhdr);
 		if (trident->tlb.silent_page.area)
 			snd_dma_free_pages(&trident->tlb.silent_page);
-		if (trident->tlb.shadow_entries)
-			vfree(trident->tlb.shadow_entries);
+		vfree(trident->tlb.shadow_entries);
 		snd_dma_free_pages(&trident->tlb.buffer);
 	}
 	if (trident->irq >=3D 0)
diff -urpN linux-2.6.10/sound/pci/ymfpci/ymfpci_main.c linux-2.6.10-new/sou=
nd/pci/ymfpci/ymfpci_main.c
--- linux-2.6.10/sound/pci/ymfpci/ymfpci_main.c	2004-11-15 15:55:12.0000000=
00 +0100
+++ linux-2.6.10-new/sound/pci/ymfpci/ymfpci_main.c	2004-11-27 21:21:50.000=
000000 +0100
@@ -831,8 +831,7 @@ static void snd_ymfpci_pcm_free_substrea
 {
 	ymfpci_pcm_t *ypcm =3D runtime->private_data;
 =09
-	if (ypcm)
-		kfree(ypcm);
+	kfree(ypcm);
 }
=20
 static int snd_ymfpci_playback_open_1(snd_pcm_substream_t * substream)
@@ -2065,8 +2064,7 @@ static int snd_ymfpci_free(ymfpci_t *chi
 #endif
=20
 #ifdef CONFIG_PM
-	if (chip->saved_regs)
-		vfree(chip->saved_regs);
+	vfree(chip->saved_regs);
 #endif
 	if (chip->mpu_res) {
 		release_resource(chip->mpu_res);
diff -urpN linux-2.6.10/sound/ppc/pmac.c linux-2.6.10-new/sound/ppc/pmac.c
--- linux-2.6.10/sound/ppc/pmac.c	2004-09-13 19:45:34.000000000 +0200
+++ linux-2.6.10-new/sound/ppc/pmac.c	2004-11-27 21:21:50.000000000 +0100
@@ -71,7 +71,7 @@ static int snd_pmac_dbdma_alloc(pmac_dbd
=20
 static void snd_pmac_dbdma_free(pmac_dbdma_t *rec)
 {
-	if (rec && rec->space)
+	if (rec)
 		kfree(rec->space);
 }
=20
diff -urpN linux-2.6.10/sound/synth/emux/emux.c linux-2.6.10-new/sound/synt=
h/emux/emux.c
--- linux-2.6.10/sound/synth/emux/emux.c	2004-09-13 19:45:34.000000000 +0200
+++ linux-2.6.10-new/sound/synth/emux/emux.c	2004-11-27 21:21:50.000000000 =
+0100
@@ -137,12 +137,8 @@ int snd_emux_free(snd_emux_t *emu)
 	if (emu->sflist)
 		snd_sf_free(emu->sflist);
=20
-	if (emu->voices)
-		kfree(emu->voices);
-
-	if (emu->name)
-		kfree(emu->name);
-
+	kfree(emu->voices);
+	kfree(emu->name);
 	kfree(emu);
 	return 0;
 }
diff -urpN linux-2.6.10/sound/synth/emux/emux_seq.c linux-2.6.10-new/sound/=
synth/emux/emux_seq.c
--- linux-2.6.10/sound/synth/emux/emux_seq.c	2004-09-13 19:45:34.000000000 =
+0200
+++ linux-2.6.10-new/sound/synth/emux/emux_seq.c	2004-11-27 21:21:50.000000=
000 +0100
@@ -197,8 +197,7 @@ free_port(void *private_data)
 #ifdef SNDRV_EMUX_USE_RAW_EFFECT
 		snd_emux_delete_effect(p);
 #endif
-		if (p->chset.channels)
-			kfree(p->chset.channels);
+		kfree(p->chset.channels);
 		kfree(p);
 	}
 }
diff -urpN linux-2.6.10/sound/usb/usbaudio.c linux-2.6.10-new/sound/usb/usb=
audio.c
--- linux-2.6.10/sound/usb/usbaudio.c	2004-11-15 15:55:12.000000000 +0100
+++ linux-2.6.10-new/sound/usb/usbaudio.c	2004-11-27 21:21:50.000000000 +01=
00
@@ -2063,8 +2063,7 @@ static void free_substream(snd_usb_subst
 		return; /* not initialized */
 	list_for_each_safe(p, n, &subs->fmt_list) {
 		struct audioformat *fp =3D list_entry(p, struct audioformat, list);
-		if (fp->rate_table)
-			kfree(fp->rate_table);
+		kfree(fp->rate_table);
 		kfree(fp);
 	}
 }
@@ -2550,8 +2549,7 @@ static int parse_audio_endpoints(snd_usb
=20
 		/* ok, let's parse further... */
 		if (parse_audio_format(dev, fp, format, fmt, stream) < 0) {
-			if (fp->rate_table)
-				kfree(fp->rate_table);
+			kfree(fp->rate_table);
 			kfree(fp);
 			continue;
 		}
@@ -2559,8 +2557,7 @@ static int parse_audio_endpoints(snd_usb
 		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint 0x%x\n", dev->devnum=
, iface_no, i, fp->endpoint);
 		err =3D add_audio_endpoint(chip, stream, fp);
 		if (err < 0) {
-			if (fp->rate_table)
-				kfree(fp->rate_table);
+			kfree(fp->rate_table);
 			kfree(fp);
 			return err;
 		}
@@ -2693,15 +2690,13 @@ static int create_fixed_stream_quirk(snd
 	err =3D add_audio_endpoint(chip, stream, fp);
 	if (err < 0) {
 		kfree(fp);
-		if (rate_table)
-			kfree(rate_table);
+		kfree(rate_table);
 		return err;
 	}
 	if (fp->iface !=3D get_iface_desc(&iface->altsetting[0])->bInterfaceNumbe=
r ||
 	    fp->altset_idx >=3D iface->num_altsetting) {
 		kfree(fp);
-		if (rate_table)
-			kfree(rate_table);
+		kfree(rate_table);
 		return -EINVAL;
 	}
 	alts =3D &iface->altsetting[fp->altset_idx];
diff -urpN linux-2.6.10/sound/usb/usbmidi.c linux-2.6.10-new/sound/usb/usbm=
idi.c
--- linux-2.6.10/sound/usb/usbmidi.c	2004-11-15 15:55:12.000000000 +0100
+++ linux-2.6.10-new/sound/usb/usbmidi.c	2004-11-27 21:21:50.000000000 +0100
@@ -504,8 +504,7 @@ static snd_rawmidi_ops_t snd_usbmidi_inp
 static void snd_usbmidi_in_endpoint_delete(snd_usb_midi_in_endpoint_t* ep)
 {
 	if (ep->urb) {
-		if (ep->urb->transfer_buffer)
-			kfree(ep->urb->transfer_buffer);
+		kfree(ep->urb->transfer_buffer);
 		usb_free_urb(ep->urb);
 	}
 	kfree(ep);
@@ -632,8 +631,7 @@ static void snd_usbmidi_out_endpoint_del
 	if (ep->tasklet.func)
 		tasklet_kill(&ep->tasklet);
 	if (ep->urb) {
-		if (ep->urb->transfer_buffer)
-			kfree(ep->urb->transfer_buffer);
+		kfree(ep->urb->transfer_buffer);
 		usb_free_urb(ep->urb);
 	}
 	kfree(ep);
diff -urpN linux-2.6.10/sound/usb/usbmixer.c linux-2.6.10-new/sound/usb/usb=
mixer.c
--- linux-2.6.10/sound/usb/usbmixer.c	2004-09-13 19:45:34.000000000 +0200
+++ linux-2.6.10-new/sound/usb/usbmixer.c	2004-11-27 21:21:51.000000000 +01=
00
@@ -573,7 +573,7 @@ static struct usb_feature_control_info a
 static void usb_mixer_elem_free(snd_kcontrol_t *kctl)
 {
 	if (kctl->private_data) {
-		kfree((void *)kctl->private_data);
+		kfree(kctl->private_data);
 		kctl->private_data =3D NULL;
 	}
 }
diff -urpN linux-2.6.10/sound/usb/usx2y/usbusx2y.c linux-2.6.10-new/sound/u=
sb/usx2y/usbusx2y.c
--- linux-2.6.10/sound/usb/usx2y/usbusx2y.c	2004-11-15 15:55:12.000000000 +=
0100
+++ linux-2.6.10-new/sound/usb/usx2y/usbusx2y.c	2004-11-27 21:21:51.0000000=
00 +0100
@@ -285,8 +285,7 @@ static void usX2Y_unlinkSeq(snd_usX2Y_As
 			S->urb[i] =3D NULL;
 		}
 	}
-	if (S->buffer)
-		kfree(S->buffer);
+	kfree(S->buffer);
 }
=20
=20
@@ -389,8 +388,7 @@ static struct usb_driver snd_usX2Y_usb_d
=20
 static void snd_usX2Y_card_private_free(snd_card_t *card)
 {
-	if (usX2Y(card)->In04Buf)
-		kfree(usX2Y(card)->In04Buf);
+	kfree(usX2Y(card)->In04Buf);
 	usb_free_urb(usX2Y(card)->In04urb);
 	if (usX2Y(card)->us428ctls_sharedmem)
 		snd_free_pages(usX2Y(card)->us428ctls_sharedmem, sizeof(*usX2Y(card)->us=
428ctls_sharedmem));


--=20
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBqObli2PKBl+Ic14RAgXsAKCFFG7Tgjb9NOCQM43ZI6LFB6fQJgCfQcdA
YTzmFEqCsYleZreRJOt9abQ=
=fUy+
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
