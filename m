Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267491AbTB1GVE>; Fri, 28 Feb 2003 01:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbTB1GVE>; Fri, 28 Feb 2003 01:21:04 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:17846 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP
	id <S267491AbTB1GU7>; Fri, 28 Feb 2003 01:20:59 -0500
Message-ID: <3E5F01B5.F4AE53F3@verizon.net>
Date: Thu, 27 Feb 2003 22:29:09 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.63 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@lists.sf.net
Subject: [PATCH] reduce large oss_pcm stack usage
Content-Type: multipart/mixed;
 boundary="------------6BE4E7458710081763E379BC"
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [4.64.238.61] at Fri, 28 Feb 2003 00:31:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6BE4E7458710081763E379BC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Jaroslav, Please review and apply.
Patch applies to 2.5.63.
Builds cleanly.

description:	reduce stack usage in snd_pcm_oss_change_params()
		from 0x584 to < 0x100 bytes;

Thanks,
~Randy
--------------6BE4E7458710081763E379BC
Content-Type: text/plain; charset=us-ascii;
 name="oss_pcm_stack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oss_pcm_stack.patch"

patch_name:	oss_pcm_stack.patch
patch_version:	2003-02-27.22:19:29
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	reduce stack usage in snd_pcm_oss_change_params()
		from 0x584 to < 0x100 bytes;
product:	Linux
product_versions: linux-2563
changelog:	_
URL:		_
requires:	_
conflicts:	_
maintainer:	Jaroslav Kysela <perex@suse.cz>
diffstat:	=
 sound/core/oss/pcm_oss.c |  145 ++++++++++++++++++++++++++---------------------
 1 files changed, 81 insertions(+), 64 deletions(-)


diff -Naur ./sound/core/oss/pcm_oss.c%STCK ./sound/core/oss/pcm_oss.c
--- ./sound/core/oss/pcm_oss.c%STCK	Mon Feb 24 11:05:42 2003
+++ ./sound/core/oss/pcm_oss.c	Thu Feb 27 22:16:24 2003
@@ -294,8 +294,8 @@
 static int snd_pcm_oss_change_params(snd_pcm_substream_t *substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	snd_pcm_hw_params_t params, sparams;
-	snd_pcm_sw_params_t sw_params;
+	snd_pcm_hw_params_t *params, *sparams;
+	snd_pcm_sw_params_t *sw_params;
 	ssize_t oss_buffer_size, oss_period_size;
 	size_t oss_frame_size;
 	int err;
@@ -304,6 +304,15 @@
 	snd_mask_t sformat_mask;
 	snd_mask_t mask;
 
+	sw_params = kmalloc(sizeof(*sw_params), GFP_KERNEL);
+	params = kmalloc(sizeof(*params), GFP_KERNEL);
+	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
+	if (!sw_params || !params || !sparams) {
+		snd_printd("No memory\n");
+		err = -ENOMEM;
+		goto failure;
+	}
+
 	if (atomic_read(&runtime->mmap_count)) {
 		direct = 1;
 	} else {
@@ -311,9 +320,9 @@
 		direct = (setup != NULL && setup->direct);
 	}
 
-	_snd_pcm_hw_params_any(&sparams);
-	_snd_pcm_hw_param_setinteger(&sparams, SNDRV_PCM_HW_PARAM_PERIODS);
-	_snd_pcm_hw_param_min(&sparams, SNDRV_PCM_HW_PARAM_PERIODS, 2, 0);
+	_snd_pcm_hw_params_any(sparams);
+	_snd_pcm_hw_param_setinteger(sparams, SNDRV_PCM_HW_PARAM_PERIODS);
+	_snd_pcm_hw_param_min(sparams, SNDRV_PCM_HW_PARAM_PERIODS, 2, 0);
 	snd_mask_none(&mask);
 	if (atomic_read(&runtime->mmap_count))
 		snd_mask_set(&mask, SNDRV_PCM_ACCESS_MMAP_INTERLEAVED);
@@ -322,17 +331,18 @@
 		if (!direct)
 			snd_mask_set(&mask, SNDRV_PCM_ACCESS_RW_NONINTERLEAVED);
 	}
-	err = snd_pcm_hw_param_mask(substream, &sparams, SNDRV_PCM_HW_PARAM_ACCESS, &mask);
+	err = snd_pcm_hw_param_mask(substream, sparams, SNDRV_PCM_HW_PARAM_ACCESS, &mask);
 	if (err < 0) {
 		snd_printd("No usable accesses\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto failure;
 	}
-	choose_rate(substream, &sparams, runtime->oss.rate);
-	snd_pcm_hw_param_near(substream, &sparams, SNDRV_PCM_HW_PARAM_CHANNELS, runtime->oss.channels, 0);
+	choose_rate(substream, sparams, runtime->oss.rate);
+	snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_CHANNELS, runtime->oss.channels, 0);
 
 	format = snd_pcm_oss_format_from(runtime->oss.format);
 
-	sformat_mask = *hw_param_mask(&sparams, SNDRV_PCM_HW_PARAM_FORMAT);
+	sformat_mask = *hw_param_mask(sparams, SNDRV_PCM_HW_PARAM_FORMAT);
 	if (direct)
 		sformat = format;
 	else
@@ -346,52 +356,53 @@
 		}
 		if (sformat > SNDRV_PCM_FORMAT_LAST) {
 			snd_printd("Cannot find a format!!!\n");
-			return -EINVAL;
+			err = -EINVAL;
+			goto failure;
 		}
 	}
-	err = _snd_pcm_hw_param_set(&sparams, SNDRV_PCM_HW_PARAM_FORMAT, sformat, 0);
-	snd_assert(err >= 0, return err);
+	err = _snd_pcm_hw_param_set(sparams, SNDRV_PCM_HW_PARAM_FORMAT, sformat, 0);
+	snd_assert(err >= 0, goto failure);
 
 	if (direct) {
-		params = sparams;
+		memcpy(params, sparams, sizeof(*params));
 	} else {
-		_snd_pcm_hw_params_any(&params);
-		_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_ACCESS,
+		_snd_pcm_hw_params_any(params);
+		_snd_pcm_hw_param_set(params, SNDRV_PCM_HW_PARAM_ACCESS,
 				      SNDRV_PCM_ACCESS_RW_INTERLEAVED, 0);
-		_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_FORMAT,
+		_snd_pcm_hw_param_set(params, SNDRV_PCM_HW_PARAM_FORMAT,
 				      snd_pcm_oss_format_from(runtime->oss.format), 0);
-		_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_CHANNELS,
+		_snd_pcm_hw_param_set(params, SNDRV_PCM_HW_PARAM_CHANNELS,
 				      runtime->oss.channels, 0);
-		_snd_pcm_hw_param_set(&params, SNDRV_PCM_HW_PARAM_RATE,
+		_snd_pcm_hw_param_set(params, SNDRV_PCM_HW_PARAM_RATE,
 				      runtime->oss.rate, 0);
 		pdprintf("client: access = %i, format = %i, channels = %i, rate = %i\n",
-			 params_access(&params), params_format(&params),
-			 params_channels(&params), params_rate(&params));
+			 params_access(params), params_format(params),
+			 params_channels(params), params_rate(params));
 	}
 	pdprintf("slave: access = %i, format = %i, channels = %i, rate = %i\n",
-		 params_access(&sparams), params_format(&sparams),
-		 params_channels(&sparams), params_rate(&sparams));
+		 params_access(sparams), params_format(sparams),
+		 params_channels(sparams), params_rate(sparams));
 
-	oss_frame_size = snd_pcm_format_physical_width(params_format(&params)) *
-			 params_channels(&params) / 8;
+	oss_frame_size = snd_pcm_format_physical_width(params_format(params)) *
+			 params_channels(params) / 8;
 
 	snd_pcm_oss_plugin_clear(substream);
 	if (!direct) {
 		/* add necessary plugins */
 		snd_pcm_oss_plugin_clear(substream);
 		if ((err = snd_pcm_plug_format_plugins(substream,
-						       &params, 
-						       &sparams)) < 0) {
+						       params, 
+						       sparams)) < 0) {
 			snd_printd("snd_pcm_plug_format_plugins failed: %i\n", err);
 			snd_pcm_oss_plugin_clear(substream);
-			return err;
+			goto failure;
 		}
 		if (runtime->oss.plugin_first) {
 			snd_pcm_plugin_t *plugin;
-			if ((err = snd_pcm_plugin_build_io(substream, &sparams, &plugin)) < 0) {
+			if ((err = snd_pcm_plugin_build_io(substream, sparams, &plugin)) < 0) {
 				snd_printd("snd_pcm_plugin_build_io failed: %i\n", err);
 				snd_pcm_oss_plugin_clear(substream);
-				return err;
+				goto failure;
 			}
 			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 				err = snd_pcm_plugin_append(plugin);
@@ -400,66 +411,66 @@
 			}
 			if (err < 0) {
 				snd_pcm_oss_plugin_clear(substream);
-				return err;
+				goto failure;
 			}
 		}
 	}
 
-	err = snd_pcm_oss_period_size(substream, &params, &sparams);
+	err = snd_pcm_oss_period_size(substream, params, sparams);
 	if (err < 0)
-		return err;
+		goto failure;
 
 	n = snd_pcm_plug_slave_size(substream, runtime->oss.period_bytes / oss_frame_size);
-	err = snd_pcm_hw_param_near(substream, &sparams, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, n, 0);
-	snd_assert(err >= 0, return err);
+	err = snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, n, 0);
+	snd_assert(err >= 0, goto failure);
 
-	err = snd_pcm_hw_param_near(substream, &sparams, SNDRV_PCM_HW_PARAM_PERIODS,
+	err = snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_PERIODS,
 				     runtime->oss.periods, 0);
-	snd_assert(err >= 0, return err);
+	snd_assert(err >= 0, goto failure);
 
 	snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, 0);
 
-	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_HW_PARAMS, &sparams)) < 0) {
+	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_HW_PARAMS, sparams)) < 0) {
 		snd_printd("HW_PARAMS failed: %i\n", err);
-		return err;
+		goto failure;
 	}
 
-	memset(&sw_params, 0, sizeof(sw_params));
+	memset(sw_params, 0, sizeof(*sw_params));
 	if (runtime->oss.trigger) {
-		sw_params.start_threshold = 1;
+		sw_params->start_threshold = 1;
 	} else {
-		sw_params.start_threshold = runtime->boundary;
+		sw_params->start_threshold = runtime->boundary;
 	}
 	if (atomic_read(&runtime->mmap_count))
-		sw_params.stop_threshold = runtime->boundary;
+		sw_params->stop_threshold = runtime->boundary;
 	else
-		sw_params.stop_threshold = runtime->buffer_size;
-	sw_params.tstamp_mode = SNDRV_PCM_TSTAMP_NONE;
-	sw_params.period_step = 1;
-	sw_params.sleep_min = 0;
-	sw_params.avail_min = runtime->period_size;
-	sw_params.xfer_align = 1;
-	sw_params.silence_threshold = 0;
-	sw_params.silence_size = 0;
+		sw_params->stop_threshold = runtime->buffer_size;
+	sw_params->tstamp_mode = SNDRV_PCM_TSTAMP_NONE;
+	sw_params->period_step = 1;
+	sw_params->sleep_min = 0;
+	sw_params->avail_min = runtime->period_size;
+	sw_params->xfer_align = 1;
+	sw_params->silence_threshold = 0;
+	sw_params->silence_size = 0;
 
-	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_SW_PARAMS, &sw_params)) < 0) {
+	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_SW_PARAMS, sw_params)) < 0) {
 		snd_printd("SW_PARAMS failed: %i\n", err);
-		return err;
+		goto failure;
 	}
 	runtime->control->avail_min = runtime->period_size;
 
-	runtime->oss.periods = params_periods(&sparams);
-	oss_period_size = snd_pcm_plug_client_size(substream, params_period_size(&sparams));
-	snd_assert(oss_period_size >= 0, return -EINVAL);
+	runtime->oss.periods = params_periods(sparams);
+	oss_period_size = snd_pcm_plug_client_size(substream, params_period_size(sparams));
+	snd_assert(oss_period_size >= 0, err = -EINVAL; goto failure);
 	if (runtime->oss.plugin_first) {
 		err = snd_pcm_plug_alloc(substream, oss_period_size);
 		if (err < 0)
-			return err;
+			goto failure;
 	}
 	oss_period_size *= oss_frame_size;
 
 	oss_buffer_size = oss_period_size * runtime->oss.periods;
-	snd_assert(oss_buffer_size >= 0, return -EINVAL);
+	snd_assert(oss_buffer_size >= 0, err = -EINVAL; goto failure);
 
 	runtime->oss.period_bytes = oss_period_size;
 	runtime->oss.buffer_bytes = oss_buffer_size;
@@ -468,12 +479,12 @@
 		 runtime->oss.period_bytes,
 		 runtime->oss.buffer_bytes);
 	pdprintf("slave: period_size = %i, buffer_size = %i\n",
-		 params_period_size(&sparams),
-		 params_buffer_size(&sparams));
+		 params_period_size(sparams),
+		 params_buffer_size(sparams));
 
-	runtime->oss.format = snd_pcm_oss_format_to(params_format(&params));
-	runtime->oss.channels = params_channels(&params);
-	runtime->oss.rate = params_rate(&params);
+	runtime->oss.format = snd_pcm_oss_format_to(params_format(params));
+	runtime->oss.channels = params_channels(params);
+	runtime->oss.rate = params_rate(params);
 
 	runtime->oss.params = 0;
 	runtime->oss.prepare = 1;
@@ -483,7 +494,13 @@
 	runtime->oss.buffer_used = 0;
 	if (runtime->dma_area)
 		snd_pcm_format_set_silence(runtime->format, runtime->dma_area, bytes_to_samples(runtime, runtime->dma_bytes));
-	return 0;
+
+	err = 0;
+failure:
+	kfree(sw_params);
+	kfree(params);
+	kfree(sparams);
+	return err;
 }
 
 static int snd_pcm_oss_get_active_substream(snd_pcm_oss_file_t *pcm_oss_file, snd_pcm_substream_t **r_substream)

--------------6BE4E7458710081763E379BC--

