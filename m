Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965715AbWCTQER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965715AbWCTQER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965714AbWCTQEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:04:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36248 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966434AbWCTPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:15:55 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 103/141] V4L/DVB (3371): Add debug to ioctl arguments.
Date: Mon, 20 Mar 2006 12:08:54 -0300
Message-id: <20060320150854.PS156175000103@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1141009729 -0300

Added a new function that allows printing ioctl arguments.
This makes easier to include debug code under v4l ioctl
handling.
Also fixed some declarations on internal ioctl.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
diff --git a/drivers/media/video/v4l2-common.c b/drivers/media/video/v4l2-common.c
index cd2c447..a241bf7 100644
--- a/drivers/media/video/v4l2-common.c
+++ b/drivers/media/video/v4l2-common.c
@@ -362,6 +362,529 @@ void v4l_printk_ioctl(unsigned int cmd)
 	}
 }
 
+/* Common ioctl debug function. This function can be used by
+   external ioctl messages as well as internal V4L ioctl and its
+   arguments */
+void v4l_printk_ioctl_arg(char *s,unsigned int cmd, void *arg)
+{
+	printk(s);
+	printk(": ");
+	v4l_printk_ioctl(cmd);
+	switch (cmd) {
+	case VIDIOC_INT_G_CHIP_IDENT:
+	{
+		enum v4l2_chip_ident  *p=arg;
+		printk ("%s: chip ident=%d\n", s, *p);
+		break;
+	}
+	case VIDIOC_G_PRIORITY:
+	case VIDIOC_S_PRIORITY:
+	{
+		enum v4l2_priority *p=arg;
+		printk ("%s: priority=%d\n", s, *p);
+		break;
+	}
+	case VIDIOC_INT_S_TUNER_MODE:
+	{
+		enum v4l2_tuner_type *p=arg;
+		printk ("%s: tuner type=%d\n", s, *p);
+		break;
+	}
+	case DECODER_SET_VBI_BYPASS:
+	case DECODER_ENABLE_OUTPUT:
+	case DECODER_GET_STATUS:
+	case DECODER_SET_OUTPUT:
+	case DECODER_SET_INPUT:
+	case DECODER_SET_GPIO:
+	case DECODER_SET_NORM:
+	case VIDIOCCAPTURE:
+	case VIDIOCSYNC:
+	case VIDIOCSWRITEMODE:
+	case TUNER_SET_TYPE_ADDR:
+	case TUNER_SET_STANDBY:
+	case TDA9887_SET_CONFIG:
+	case AUDC_SET_INPUT:
+	case VIDIOC_OVERLAY_OLD:
+	case VIDIOC_STREAMOFF:
+	case VIDIOC_G_OUTPUT:
+	case VIDIOC_S_OUTPUT:
+	case VIDIOC_STREAMON:
+	case VIDIOC_G_INPUT:
+	case VIDIOC_OVERLAY:
+	case VIDIOC_S_INPUT:
+	{
+		int *p=arg;
+		printk ("%s: value=%d\n", s, *p);
+		break;
+	}
+	case MSP_SET_MATRIX:
+	{
+		struct msp_matrix *p=arg;
+		printk ("%s: input=%d, output=%d\n", s, p->input, p->output);
+		break;
+	}
+	case VIDIOC_G_AUDIO:
+	case VIDIOC_S_AUDIO:
+	case VIDIOC_ENUMAUDIO:
+	case VIDIOC_G_AUDIO_OLD:
+	{
+		struct v4l2_audio *p=arg;
+
+		printk ("%s: index=%d, name=%s, capability=%d, mode=%d\n",
+			s,p->index, p->name,p->capability, p->mode);
+		break;
+	}
+	case VIDIOC_G_AUDOUT:
+	case VIDIOC_S_AUDOUT:
+	case VIDIOC_ENUMAUDOUT:
+	case VIDIOC_G_AUDOUT_OLD:
+	{
+		struct v4l2_audioout *p=arg;
+		printk ("%s: index=%d, name=%s, capability=%d, mode=%d\n", s,
+				p->index, p->name, p->capability,p->mode);
+		break;
+	}
+	case VIDIOC_QBUF:
+	case VIDIOC_DQBUF:
+	case VIDIOC_QUERYBUF:
+	{
+		struct v4l2_buffer *p=arg;
+		struct v4l2_timecode *tc=&p->timecode;
+		printk ("%s: %02ld:%02d:%02d.%08ld index=%d, type=%d, "
+			"bytesused=%d, flags=0x%08d, "
+			"field=%0d, sequence=%d, memory=%d, offset/userptr=0x%08lx,",
+				s,
+				(p->timestamp.tv_sec/3600),
+				(int)(p->timestamp.tv_sec/60)%60,
+				(int)(p->timestamp.tv_sec%60),
+				p->timestamp.tv_usec,
+				p->index,p->type,p->bytesused,p->flags,
+				p->field,p->sequence,p->memory,p->m.userptr);
+		printk ("%s: timecode= %02d:%02d:%02d type=%d, "
+			"flags=0x%08d, frames=%d, userbits=0x%08x",
+				s,tc->hours,tc->minutes,tc->seconds,
+				tc->type, tc->flags, tc->frames, (__u32) tc->userbits);
+		break;
+	}
+	case VIDIOC_QUERYCAP:
+	{
+		struct v4l2_capability *p=arg;
+		printk ("%s: driver=%s, card=%s, bus=%s, version=%d, "
+			"capabilities=%d\n", s,
+				p->driver,p->card,p->bus_info,
+				p->version,
+				p->capabilities);
+		break;
+	}
+	case VIDIOC_G_CTRL:
+	case VIDIOC_S_CTRL:
+	case VIDIOC_S_CTRL_OLD:
+	{
+		struct v4l2_control *p=arg;
+		printk ("%s: id=%d, value=%d\n", s, p->id, p->value);
+		break;
+	}
+	case VIDIOC_G_CROP:
+	case VIDIOC_S_CROP:
+	{
+		struct v4l2_crop *p=arg;
+		/*FIXME: Should also show rect structs */
+		printk ("%s: type=%d\n", s, p->type);
+		break;
+	}
+	case VIDIOC_CROPCAP:
+	case VIDIOC_CROPCAP_OLD:
+	{
+		struct v4l2_cropcap *p=arg;
+		/*FIXME: Should also show rect structs */
+		printk ("%s: type=%d\n", s, p->type);
+		break;
+	}
+	case VIDIOC_INT_DECODE_VBI_LINE:
+	{
+		struct v4l2_decode_vbi_line *p=arg;
+		printk ("%s: is_second_field=%d, ptr=0x%08lx, line=%d, "
+			"type=%d\n", s,
+				p->is_second_field,(unsigned long)p->p,p->line,p->type);
+		break;
+	}
+	case VIDIOC_ENUM_FMT:
+	{
+		struct v4l2_fmtdesc *p=arg;
+		printk ("%s: index=%d, type=%d, flags=%d, description=%s,"
+			" pixelformat=%d\n", s,
+				p->index, p->type, p->flags,p->description,
+				p->pixelformat);
+
+		break;
+	}
+	case VIDIOC_G_FMT:
+	case VIDIOC_S_FMT:
+	case VIDIOC_TRY_FMT:
+	{
+		struct v4l2_format *p=arg;
+		/* FIXME: Should be one dump per type*/
+		printk ("%s: type=%d\n", s,p->type);
+		break;
+	}
+	case VIDIOC_G_FBUF:
+	case VIDIOC_S_FBUF:
+	{
+		struct v4l2_framebuffer *p=arg;
+		/*FIXME: should show also struct v4l2_pix_format p->fmt field */
+		printk ("%s: capability=%d, flags=%d, base=0x%08lx\n", s,
+				p->capability,p->flags, (unsigned long)p->base);
+		break;
+	}
+	case VIDIOC_G_FREQUENCY:
+	case VIDIOC_S_FREQUENCY:
+	{
+		struct v4l2_frequency *p=arg;
+		printk ("%s: tuner=%d, type=%d, frequency=%d\n", s,
+				p->tuner,p->type,p->frequency);
+		break;
+	}
+	case VIDIOC_ENUMINPUT:
+	{
+		struct v4l2_input *p=arg;
+		printk ("%s: index=%d, name=%s, type=%d, audioset=%d, "
+			"tuner=%d, std=%lld, status=%d\n", s,
+				p->index,p->name,p->type,p->audioset,
+				p->tuner,p->std,
+				p->status);
+		break;
+	}
+	case VIDIOC_G_JPEGCOMP:
+	case VIDIOC_S_JPEGCOMP:
+	{
+		struct v4l2_jpegcompression *p=arg;
+		printk ("%s: quality=%d, APPn=%d, APP_len=%d, COM_len=%d,"
+			" jpeg_markers=%d\n", s,
+				p->quality,p->APPn,p->APP_len,
+				p->COM_len,p->jpeg_markers);
+		break;
+	}
+	case VIDIOC_G_MODULATOR:
+	case VIDIOC_S_MODULATOR:
+	{
+		struct v4l2_modulator *p=arg;
+		printk ("%s: index=%d, name=%s, capability=%d, rangelow=%d,"
+			" rangehigh=%d, txsubchans=%d\n", s,
+				p->index, p->name,p->capability,p->rangelow,
+				p->rangehigh,p->txsubchans);
+		break;
+	}
+	case VIDIOC_G_MPEGCOMP:
+	case VIDIOC_S_MPEGCOMP:
+	{
+		struct v4l2_mpeg_compression *p=arg;
+		/*FIXME: Several fields not shown */
+		printk ("%s: ts_pid_pmt=%d, ts_pid_audio=%d, ts_pid_video=%d, "
+			"ts_pid_pcr=%d, ps_size=%d, au_sample_rate=%d, "
+			"au_pesid=%c, vi_frame_rate=%d, vi_frames_per_gop=%d, "
+			"vi_bframes_count=%d, vi_pesid=%c\n", s,
+				p->ts_pid_pmt,p->ts_pid_audio, p->ts_pid_video,
+				p->ts_pid_pcr, p->ps_size, p->au_sample_rate,
+				p->au_pesid, p->vi_frame_rate,
+				p->vi_frames_per_gop, p->vi_bframes_count,
+				p->vi_pesid);
+		break;
+	}
+	case VIDIOC_ENUMOUTPUT:
+	{
+		struct v4l2_output *p=arg;
+		printk ("%s: index=%d, name=%s,type=%d, audioset=%d, "
+			"modulator=%d, std=%lld\n",
+				s,p->index,p->name,p->type,p->audioset,
+				p->modulator,p->std);
+		break;
+	}
+	case VIDIOC_QUERYCTRL:
+	{
+		struct v4l2_queryctrl *p=arg;
+		printk ("%s: id=%d, type=%d, name=%s, min/max=%d/%d,"
+			" step=%d, default=%d, flags=0x%08x\n", s,
+				p->id,p->type,p->name,p->minimum,p->maximum,
+				p->step,p->default_value,p->flags);
+		break;
+	}
+	case VIDIOC_QUERYMENU:
+	{
+		struct v4l2_querymenu *p=arg;
+		printk ("%s: id=%d, index=%d, name=%s\n", s,
+				p->id,p->index,p->name);
+		break;
+	}
+	case VIDIOC_INT_G_REGISTER:
+	case VIDIOC_INT_S_REGISTER:
+	{
+		struct v4l2_register *p=arg;
+		printk ("%s: i2c_id=%d, reg=%lu, val=%d\n", s,
+				p->i2c_id,p->reg,p->val);
+
+		break;
+	}
+	case VIDIOC_REQBUFS:
+	{
+		struct v4l2_requestbuffers *p=arg;
+		printk ("%s: count=%d, type=%d, memory=%d\n", s,
+				p->count,p->type,p->memory);
+		break;
+	}
+	case VIDIOC_INT_S_AUDIO_ROUTING:
+	case VIDIOC_INT_S_VIDEO_ROUTING:
+	case VIDIOC_INT_G_AUDIO_ROUTING:
+	case VIDIOC_INT_G_VIDEO_ROUTING:
+	{
+		struct v4l2_routing  *p=arg;
+		printk ("%s: input=%d, output=%d\n", s, p->input, p->output);
+		break;
+	}
+	case VIDIOC_G_SLICED_VBI_CAP:
+	{
+		struct v4l2_sliced_vbi_cap *p=arg;
+		printk ("%s: service_set=%d\n", s,
+				p->service_set);
+		break;
+	}
+	case VIDIOC_INT_S_VBI_DATA:
+	case VIDIOC_INT_G_VBI_DATA:
+	{
+		struct v4l2_sliced_vbi_data  *p=arg;
+		printk ("%s: id=%d, field=%d, line=%d\n", s,
+				p->id, p->field, p->line);
+		break;
+	}
+	case VIDIOC_ENUMSTD:
+	{
+		struct v4l2_standard *p=arg;
+		printk ("%s: index=%d, id=%lld, name=%s, fps=%d/%d, framelines=%d\n", s,
+				p->index, p->id, p->name,
+				p->frameperiod.numerator,
+				p->frameperiod.denominator,
+				p->framelines);
+
+		break;
+	}
+	case VIDIOC_G_PARM:
+	case VIDIOC_S_PARM:
+	case VIDIOC_S_PARM_OLD:
+	{
+		struct v4l2_streamparm *p=arg;
+		printk ("%s: type=%d\n", s, p->type);
+
+		break;
+	}
+	case VIDIOC_G_TUNER:
+	case VIDIOC_S_TUNER:
+	{
+		struct v4l2_tuner *p=arg;
+		printk ("%s: index=%d, name=%s, type=%d, capability=%d, "
+			"rangelow=%d, rangehigh=%d, signal=%d, afc=%d, "
+			"rxsubchans=%d, audmode=%d\n", s,
+				p->index, p->name, p->type,
+				p->capability, p->rangelow,p->rangehigh,
+				p->rxsubchans, p->audmode, p->signal,
+				p->afc);
+		break;
+	}
+	case VIDIOCGVBIFMT:
+	case VIDIOCSVBIFMT:
+	{
+		struct vbi_format *p=arg;
+		printk ("%s: sampling_rate=%d, samples_per_line=%d, "
+			"sample_format=%d, start=%d/%d, count=%d/%d, flags=%d\n", s,
+				p->sampling_rate,p->samples_per_line,
+				p->sample_format,p->start[0],p->start[1],
+				p->count[0],p->count[1],p->flags);
+		break;
+	}
+	case VIDIOCGAUDIO:
+	case VIDIOCSAUDIO:
+	{
+		struct video_audio *p=arg;
+		printk ("%s: audio=%d, volume=%d, bass=%d, treble=%d, "
+			"flags=%d, name=%s, mode=%d, balance=%d, step=%d\n",
+				s,p->audio,p->volume,p->bass, p->treble,
+				p->flags,p->name,p->mode,p->balance,p->step);
+		break;
+	}
+	case VIDIOCGFBUF:
+	case VIDIOCSFBUF:
+	{
+		struct video_buffer *p=arg;
+		printk ("%s: base=%08lx, height=%d, width=%d, depth=%d, "
+			"bytesperline=%d\n", s,
+				(unsigned long) p->base, p->height, p->width,
+				p->depth,p->bytesperline);
+		break;
+	}
+	case VIDIOCGCAP:
+	{
+		struct video_capability *p=arg;
+		printk ("%s: name=%s, type=%d, channels=%d, audios=%d, "
+			"maxwidth=%d, maxheight=%d, minwidth=%d, minheight=%d\n",
+				s,p->name,p->type,p->channels,p->audios,
+				p->maxwidth,p->maxheight,p->minwidth,
+				p->minheight);
+
+		break;
+	}
+	case VIDIOCGCAPTURE:
+	case VIDIOCSCAPTURE:
+	{
+		struct video_capture *p=arg;
+		printk ("%s: x=%d, y=%d, width=%d, height=%d, decimation=%d,"
+			" flags=%d\n", s,
+				p->x, p->y,p->width, p->height,
+				p->decimation,p->flags);
+		break;
+	}
+	case VIDIOCGCHAN:
+	case VIDIOCSCHAN:
+	{
+		struct video_channel *p=arg;
+		printk ("%s: channel=%d, name=%s, tuners=%d, flags=%d, "
+			"type=%d, norm=%d\n", s,
+				p->channel,p->name,p->tuners,
+				p->flags,p->type,p->norm);
+
+		break;
+	}
+	case VIDIOCSMICROCODE:
+	{
+		struct video_code *p=arg;
+		printk ("%s: loadwhat=%s, datasize=%d\n", s,
+				p->loadwhat,p->datasize);
+		break;
+	}
+	case DECODER_GET_CAPABILITIES:
+	{
+		struct video_decoder_capability *p=arg;
+		printk ("%s: flags=%d, inputs=%d, outputs=%d\n", s,
+				p->flags,p->inputs,p->outputs);
+		break;
+	}
+	case DECODER_INIT:
+	{
+		struct video_decoder_init *p=arg;
+		printk ("%s: len=%c\n", s, p->len);
+		break;
+	}
+	case VIDIOCGPLAYINFO:
+	{
+		struct video_info *p=arg;
+		printk ("%s: frame_count=%d, h_size=%d, v_size=%d, "
+			"smpte_timecode=%d, picture_type=%d, "
+			"temporal_reference=%d, user_data=%s\n", s,
+				p->frame_count, p->h_size,
+				p->v_size, p->smpte_timecode,
+				p->picture_type, p->temporal_reference,
+				p->user_data);
+		break;
+	}
+	case VIDIOCKEY:
+	{
+		struct video_key *p=arg;
+		printk ("%s: key=%s, flags=%d\n", s,
+				p->key, p->flags);
+		break;
+	}
+	case VIDIOCGMBUF:
+	{
+		struct video_mbuf *p=arg;
+		printk ("%s: size=%d, frames=%d, offsets=0x%08lx\n", s,
+				p->size,
+				p->frames,
+				(unsigned long)p->offsets);
+		break;
+	}
+	case VIDIOCMCAPTURE:
+	{
+		struct video_mmap *p=arg;
+		printk ("%s: frame=%d, height=%d, width=%d, format=%d\n", s,
+				p->frame,
+				p->height, p->width,
+				p->format);
+		break;
+	}
+	case VIDIOCGPICT:
+	case VIDIOCSPICT:
+	case DECODER_SET_PICTURE:
+	{
+		struct video_picture *p=arg;
+
+		printk ("%s: brightness=%d, hue=%d, colour=%d, contrast=%d,"
+			" whiteness=%d, depth=%d, palette=%d\n", s,
+				p->brightness, p->hue, p->colour,
+				p->contrast, p->whiteness, p->depth,
+				p->palette);
+		break;
+	}
+	case VIDIOCSPLAYMODE:
+	{
+		struct video_play_mode *p=arg;
+		printk ("%s: mode=%d, p1=%d, p2=%d\n", s,
+				p->mode,p->p1,p->p2);
+		break;
+	}
+	case VIDIOCGTUNER:
+	case VIDIOCSTUNER:
+	{
+		struct video_tuner *p=arg;
+		printk ("%s: tuner=%d, name=%s, rangelow=%ld, rangehigh=%ld, "
+			"flags=%d, mode=%d, signal=%d\n", s,
+				p->tuner, p->name,p->rangelow, p->rangehigh,
+				p->flags,p->mode, p->signal);
+		break;
+	}
+	case VIDIOCGUNIT:
+	{
+		struct video_unit *p=arg;
+		printk ("%s: video=%d, vbi=%d, radio=%d, audio=%d, "
+			"teletext=%d\n", s,
+				p->video,p->vbi,p->radio,p->audio,p->teletext);
+		break;
+	}
+	case VIDIOCGWIN:
+	case VIDIOCSWIN:
+	{
+		struct video_window *p=arg;
+		printk ("%s: x=%d, y=%d, width=%d, height=%d, chromakey=%d,"
+			" flags=%d, clipcount=%d\n", s,
+				p->x, p->y,p->width, p->height,
+				p->chromakey,p->flags,
+				p->clipcount);
+		break;
+	}
+	case VIDIOC_INT_AUDIO_CLOCK_FREQ:
+	case VIDIOC_INT_I2S_CLOCK_FREQ:
+	case VIDIOC_INT_S_STANDBY:
+	{
+		u32 *p=arg;
+
+		printk ("%s: value=%d\n", s, *p);
+		break;
+	}
+	case VIDIOCGFREQ:
+	case VIDIOCSFREQ:
+	{
+		unsigned long *p=arg;
+		printk ("%s: value=%lu\n", s, *p);
+		break;
+	}
+	case VIDIOC_G_STD:
+	case VIDIOC_S_STD:
+	case VIDIOC_QUERYSTD:
+	{
+		v4l2_std_id *p=arg;
+
+		printk ("%s: value=%llu\n", s, *p);
+		break;
+	}
+	}
+}
+
 /* ----------------------------------------------------------------- */
 
 EXPORT_SYMBOL(v4l2_video_std_construct);
@@ -376,6 +899,7 @@ EXPORT_SYMBOL(v4l2_prio_check);
 EXPORT_SYMBOL(v4l2_field_names);
 EXPORT_SYMBOL(v4l2_type_names);
 EXPORT_SYMBOL(v4l_printk_ioctl);
+EXPORT_SYMBOL(v4l_printk_ioctl_arg);
 
 /*
  * Local variables:
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
diff --git a/include/media/v4l2-common.h b/include/media/v4l2-common.h
index 234e9cf..c44741e 100644
--- a/include/media/v4l2-common.h
+++ b/include/media/v4l2-common.h
@@ -58,6 +58,9 @@
 /* Prints the ioctl in a human-readable format */
 extern void v4l_printk_ioctl(unsigned int cmd);
 
+/* Prints the ioctl and arg in a human-readable format */
+extern void v4l_printk_ioctl_arg(char *s,unsigned int cmd, void *arg);
+
 /* Use this macro for non-I2C drivers. Pass the driver name as the first arg. */
 #define v4l_print_ioctl(name, cmd)  		 \
 	do {  					 \
@@ -185,11 +188,11 @@ struct msp_matrix {
    register contains invalid or erroneous data -EIO is returned. Note that
    you must fill in the 'id' member and the 'field' member (to determine
    whether CC data from the first or second field should be obtained). */
-#define VIDIOC_INT_G_VBI_DATA 		_IOWR('d', 106, struct v4l2_sliced_vbi_data *)
+#define VIDIOC_INT_G_VBI_DATA 		_IOWR('d', 106, struct v4l2_sliced_vbi_data)
 
 /* Returns the chip identifier or V4L2_IDENT_UNKNOWN if no identification can
    be made. */
-#define VIDIOC_INT_G_CHIP_IDENT		_IOR ('d', 107, enum v4l2_chip_ident *)
+#define VIDIOC_INT_G_CHIP_IDENT		_IOR ('d', 107, enum v4l2_chip_ident)
 
 /* Sets I2S speed in bps. This is used to provide a standard way to select I2S
    clock used by driving digital audio streams at some board designs.
@@ -214,8 +217,8 @@ struct v4l2_routing {
    These four commands should only be sent directly to an i2c device, they
    should not be broadcast as the routing is very device specific. */
 #define	VIDIOC_INT_S_AUDIO_ROUTING	_IOW ('d', 109, struct v4l2_routing)
-#define	VIDIOC_INT_G_AUDIO_ROUTING	_IOR ('d', 110, struct v4l2_routing *)
+#define	VIDIOC_INT_G_AUDIO_ROUTING	_IOR ('d', 110, struct v4l2_routing)
 #define	VIDIOC_INT_S_VIDEO_ROUTING	_IOW ('d', 111, struct v4l2_routing)
-#define	VIDIOC_INT_G_VIDEO_ROUTING	_IOR ('d', 112, struct v4l2_routing *)
+#define	VIDIOC_INT_G_VIDEO_ROUTING	_IOR ('d', 112, struct v4l2_routing)
 
 #endif /* V4L2_COMMON_H_ */

