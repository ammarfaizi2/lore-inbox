Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbTBUIN5>; Fri, 21 Feb 2003 03:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTBUIN4>; Fri, 21 Feb 2003 03:13:56 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:14291 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S267239AbTBUINs>; Fri, 21 Feb 2003 03:13:48 -0500
Date: Fri, 21 Feb 2003 10:20:54 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Jaroslav Kysela <perex@suse.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] snd_pcm_oss_change_params is a stack offender
Message-ID: <20030221082054.GL1202@actcom.co.il>
References: <39710000.1045757490@[10.10.2.4]> <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com> <20030221073948.GJ1202@actcom.co.il> <20030221005852.K1723@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221005852.K1723@schatzie.adilger.int>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[again, with a real subject line this time. This just isn't my day]. 

On Fri, Feb 21, 2003 at 12:58:52AM -0700, Andreas Dilger wrote:
> On Feb 21, 2003  09:39 +0200, Muli Ben-Yehuda wrote:
> > +static int alloc_param_structs(snd_pcm_hw_params_t** params, 
> > +			       snd_pcm_hw_params_t** sparams,
> > +			       snd_pcm_sw_params_t** sw_params)
> 
> So, it looks like you've changed a large stack user into a leaker of
> memory.  Nowhere is the allocated memory freed, AFAICS, not upon
> successful completion, nor at any of the error exits.

Thanks for spotting. I can only claim not having woken up yet. 

Here's a fixed patch, which frees the allocations properly. I didn't
want to make more than the minimal changes necessary, but if it's ok
with the maintainer, it should be switched to the common "goto style",
and something should be done about those snd_asserts. Jaroslav, ok to
rewrite?

#	sound/core/oss/pcm_oss.c	1.20    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/21	mulix@alhambra.mulix.org	1.1007
# snd_pcm_oss_change_params was a stack offender, having three large 
# structs on the stack. Allocate those structs on the heap and change
# the code accordingly. 
# --------------------------------------------
# 03/02/21	mulix@alhambra.mulix.org	1.1008
# This time, also free the memory :-((
# Thanks to Andreas Dilger for spotting.
# --------------------------------------------
#
diff -Nru a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
--- a/sound/core/oss/pcm_oss.c	Fri Feb 21 10:15:10 2003
+++ b/sound/core/oss/pcm_oss.c	Fri Feb 21 10:15:10 2003
@@ -291,11 +291,58 @@
 	return snd_pcm_hw_param_near(substream, params, SNDRV_PCM_HW_PARAM_RATE, best_rate, 0);
 }
 
+static int alloc_param_structs(snd_pcm_hw_params_t** params, 
+			       snd_pcm_hw_params_t** sparams,
+			       snd_pcm_sw_params_t** sw_params)
+{
+	snd_pcm_hw_params_t* hwp; 
+	snd_pcm_sw_params_t* swp; 
+
+	if (!(hwp = kmalloc(sizeof(*hwp), GFP_KERNEL)))
+		goto out; 
+
+	memset(hwp, 0, sizeof(*hwp)); 
+	*params = hwp; 
+
+	if (!(hwp = kmalloc(sizeof(*hwp), GFP_KERNEL)))
+		goto free_params; 
+
+	memset(hwp, 0, sizeof(*hwp)); 
+	*sparams = hwp; 
+
+	if (!(swp = kmalloc(sizeof(*swp), GFP_KERNEL)))
+		goto free_sparams; 
+
+	memset(swp, 0, sizeof(*swp)); 
+	*sw_params = swp; 
+	
+	return 0; 
+
+ free_sparams:
+	kfree(*sparams); 
+	*sparams = NULL; 
+
+ free_params:
+	kfree(*params); 
+	*params = NULL; 
+
+ out: 
+	return -ENOMEM; 
+}
+
+static void free_param_structs(snd_pcm_hw_params_t* params, snd_pcm_hw_params_t* sparams,
+			       snd_pcm_sw_params_t* sw_params)
+{
+	kfree(params); 
+	kfree(sparams); 
+	kfree(sw_params); 
+}
+
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
@@ -311,9 +358,14 @@
 		direct = (setup != NULL && setup->direct);
 	}
 
-	_snd_pcm_hw_params_any(&sparams);
-	_snd_pcm_hw_param_setinteger(&sparams, SNDRV_PCM_HW_PARAM_PERIODS);
-	_snd_pcm_hw_param_min(&sparams, SNDRV_PCM_HW_PARAM_PERIODS, 2, 0);
+	if ((err = alloc_param_structs(&params, &sparams, &sw_params))) {
+		snd_printd("out of memory\n"); 
+		return err; 
+	}
+
+	_snd_pcm_hw_params_any(sparams);
+	_snd_pcm_hw_param_setinteger(sparams, SNDRV_PCM_HW_PARAM_PERIODS);
+	_snd_pcm_hw_param_min(sparams, SNDRV_PCM_HW_PARAM_PERIODS, 2, 0);
 	snd_mask_none(&mask);
 	if (atomic_read(&runtime->mmap_count))
 		snd_mask_set(&mask, SNDRV_PCM_ACCESS_MMAP_INTERLEAVED);
@@ -322,17 +374,18 @@
 		if (!direct)
 			snd_mask_set(&mask, SNDRV_PCM_ACCESS_RW_NONINTERLEAVED);
 	}
-	err = snd_pcm_hw_param_mask(substream, &sparams, SNDRV_PCM_HW_PARAM_ACCESS, &mask);
+	err = snd_pcm_hw_param_mask(substream, sparams, SNDRV_PCM_HW_PARAM_ACCESS, &mask);
 	if (err < 0) {
+		free_param_structs(params, sparams, sw_params); 
 		snd_printd("No usable accesses\n");
 		return -EINVAL;
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
@@ -345,50 +398,53 @@
 				break;
 		}
 		if (sformat > SNDRV_PCM_FORMAT_LAST) {
+			free_param_structs(params, sparams, sw_params); 
 			snd_printd("Cannot find a format!!!\n");
 			return -EINVAL;
 		}
 	}
-	err = _snd_pcm_hw_param_set(&sparams, SNDRV_PCM_HW_PARAM_FORMAT, sformat, 0);
-	snd_assert(err >= 0, return err);
+	err = _snd_pcm_hw_param_set(sparams, SNDRV_PCM_HW_PARAM_FORMAT, sformat, 0);
+	snd_assert(err >= 0, {free_param_structs(params, sparams, sw_params); return err});
 
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
+			free_param_structs(params, sparams, sw_params); 
 			snd_printd("snd_pcm_plug_format_plugins failed: %i\n", err);
 			snd_pcm_oss_plugin_clear(substream);
 			return err;
 		}
 		if (runtime->oss.plugin_first) {
 			snd_pcm_plugin_t *plugin;
-			if ((err = snd_pcm_plugin_build_io(substream, &sparams, &plugin)) < 0) {
+			if ((err = snd_pcm_plugin_build_io(substream, sparams, &plugin)) < 0) {
+				free_param_structs(params, sparams, sw_params); 
 				snd_printd("snd_pcm_plugin_build_io failed: %i\n", err);
 				snd_pcm_oss_plugin_clear(substream);
 				return err;
@@ -399,67 +455,73 @@
 				err = snd_pcm_plugin_insert(plugin);
 			}
 			if (err < 0) {
+				free_param_structs(params, sparams, sw_params); 
 				snd_pcm_oss_plugin_clear(substream);
 				return err;
 			}
 		}
 	}
 
-	err = snd_pcm_oss_period_size(substream, &params, &sparams);
-	if (err < 0)
+	err = snd_pcm_oss_period_size(substream, params, sparams);
+	if (err < 0) {
+		free_param_structs(params, sparams, sw_params); 
 		return err;
+	}
 
 	n = snd_pcm_plug_slave_size(substream, runtime->oss.period_bytes / oss_frame_size);
-	err = snd_pcm_hw_param_near(substream, &sparams, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, n, 0);
-	snd_assert(err >= 0, return err);
+	err = snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, n, 0);
+	snd_assert(err >= 0, {free_param_structs(params, sparams, sw_params); return err});
 
-	err = snd_pcm_hw_param_near(substream, &sparams, SNDRV_PCM_HW_PARAM_PERIODS,
+	err = snd_pcm_hw_param_near(substream, sparams, SNDRV_PCM_HW_PARAM_PERIODS,
 				     runtime->oss.periods, 0);
-	snd_assert(err >= 0, return err);
+	snd_assert(err >= 0, {free_param_structs(params, sparams, sw_params); return err});
 
 	snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, 0);
 
-	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_HW_PARAMS, &sparams)) < 0) {
+	if ((err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_HW_PARAMS, sparams)) < 0) {
+		free_param_structs(params, sparams, sw_params); 
 		snd_printd("HW_PARAMS failed: %i\n", err);
 		return err;
 	}
 
-	memset(&sw_params, 0, sizeof(sw_params));
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
+		free_param_structs(params, sparams, sw_params); 
 		snd_printd("SW_PARAMS failed: %i\n", err);
 		return err;
 	}
 	runtime->control->avail_min = runtime->period_size;
 
-	runtime->oss.periods = params_periods(&sparams);
-	oss_period_size = snd_pcm_plug_client_size(substream, params_period_size(&sparams));
-	snd_assert(oss_period_size >= 0, return -EINVAL);
+	runtime->oss.periods = params_periods(sparams);
+	oss_period_size = snd_pcm_plug_client_size(substream, params_period_size(sparams));
+	snd_assert(oss_period_size >= 0, {free_param_structs(params, sparams, sw_params); return -EINVAL});
 	if (runtime->oss.plugin_first) {
 		err = snd_pcm_plug_alloc(substream, oss_period_size);
-		if (err < 0)
+		if (err < 0) {
+			free_param_structs(params, sparams, sw_params); 
 			return err;
+		}
 	}
 	oss_period_size *= oss_frame_size;
 
 	oss_buffer_size = oss_period_size * runtime->oss.periods;
-	snd_assert(oss_buffer_size >= 0, return -EINVAL);
+	snd_assert(oss_buffer_size >= 0, {free_param_structs(params, sparams, sw_params); return -EINVAL});
 
 	runtime->oss.period_bytes = oss_period_size;
 	runtime->oss.buffer_bytes = oss_buffer_size;
@@ -468,12 +530,12 @@
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
@@ -483,6 +545,8 @@
 	runtime->oss.buffer_used = 0;
 	if (runtime->dma_area)
 		snd_pcm_format_set_silence(runtime->format, runtime->dma_area, bytes_to_samples(runtime, runtime->dma_bytes));
+
+	free_param_structs(params, sparams, sw_params); 
 	return 0;
 }
 

-- 
Muli Ben-Yehuda
http://www.mulix.org


