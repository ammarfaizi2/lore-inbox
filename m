Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVERJAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVERJAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVERJAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:00:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43790 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262134AbVERI6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 04:58:05 -0400
Date: Wed, 18 May 2005 10:58:00 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/core/: possible cleanups
Message-ID: <20050518085800.GQ5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - pcm_lib.c: snd_pcm_hw_param_any
  - pcm_lib.c: snd_pcm_hw_params_any
  - pcm_lib.c: snd_pcm_hw_param_setinteger
  - pcm_misc.c: snd_pcm_format_cpu_endian
  - pcm_misc.c: snd_pcm_format_size
  - seq/seq_midi_event.c: snd_midi_event_init
  - seq/seq_midi_event.c: snd_midi_event_resize_buffer
  - seq/seq_virmidi.c: snd_virmidi_receive
  - timer.c: snd_timer_system_resolution
- remove the following unneeded EXPORT_SYMBOL's:
  - pcm_lib.c: snd_interval_muldivk
  - pcm_lib.c: snd_interval_mulkdiv
  - pcm_lib.c: snd_interval_div
  - pcm_lib.c: snd_pcm_hw_params
  - pcm.c: snd_pcm_start
  - pcm.c: snd_pcm_suspend
  - rawmidi.c: snd_rawmidi_drop_output
  - rawmidi.c: snd_rawmidi_drain_input
  - rawmidi.c: snd_rawmidi_info
  - seq/seq_midi_event.c: snd_midi_event_resize_buffer
  - seq/seq_midi_event.c: snd_midi_event_init
  - seq/seq_virmidi.c: snd_virmidi_receive
  - timer.c: snd_timer_continue
  - timer.c: snd_timer_system_resolution
  - sound.c: snd_device_free_all

Please check which of these changes do make sense and which might 
conflict with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/sound/core.h            |    1 
 include/sound/pcm.h             |   20 ------------
 include/sound/rawmidi.h         |    2 -
 include/sound/seq_midi_event.h  |    2 -
 include/sound/seq_virmidi.h     |    1 
 include/sound/timer.h           |    3 -
 sound/core/device.c             |    2 -
 sound/core/pcm.c                |    2 -
 sound/core/pcm_lib.c            |   52 +++++++++++++++++---------------
 sound/core/pcm_memory.c         |    2 -
 sound/core/pcm_misc.c           |    4 ++
 sound/core/pcm_native.c         |    6 +--
 sound/core/rawmidi.c            |   10 ++----
 sound/core/seq/seq_midi_event.c |    6 ++-
 sound/core/seq/seq_queue.c      |    3 +
 sound/core/seq/seq_queue.h      |    1 
 sound/core/seq/seq_timer.c      |    3 +
 sound/core/seq/seq_timer.h      |    2 -
 sound/core/seq/seq_virmidi.c    |    4 +-
 sound/core/sound.c              |    1 
 sound/core/timer.c              |    8 ++--
 21 files changed, 56 insertions(+), 79 deletions(-)

--- linux-2.6.12-rc4-mm2-full/include/sound/core.h.old	2005-05-17 01:19:57.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/include/sound/core.h	2005-05-17 02:21:24.000000000 +0200
@@ -350,7 +350,6 @@
 		   void *device_data, snd_device_ops_t *ops);
 int snd_device_register(snd_card_t *card, void *device_data);
 int snd_device_register_all(snd_card_t *card);
-int snd_device_disconnect(snd_card_t *card, void *device_data);
 int snd_device_disconnect_all(snd_card_t *card);
 int snd_device_free(snd_card_t *card, void *device_data);
 int snd_device_free_all(snd_card_t *card, snd_device_cmd_t cmd);
--- linux-2.6.12-rc4-mm2-full/sound/core/device.c.old	2005-05-17 01:20:19.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/device.c	2005-05-17 02:21:24.000000000 +0200
@@ -114,7 +114,7 @@
  * Returns zero if successful, or a negative error code on failure or if the
  * device not found.
  */
-int snd_device_disconnect(snd_card_t *card, void *device_data)
+static int snd_device_disconnect(snd_card_t *card, void *device_data)
 {
 	struct list_head *list;
 	snd_device_t *dev;
--- linux-2.6.12-rc4-mm2-full/include/sound/pcm.h.old	2005-05-17 01:22:52.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/include/sound/pcm.h	2005-05-17 02:25:22.000000000 +0200
@@ -491,7 +491,6 @@
 int snd_pcm_stop(snd_pcm_substream_t *substream, int status);
 int snd_pcm_drain_done(snd_pcm_substream_t *substream);
 #ifdef CONFIG_PM
-int snd_pcm_suspend(snd_pcm_substream_t *substream);
 int snd_pcm_suspend_all(snd_pcm_t *pcm);
 #endif
 int snd_pcm_kernel_playback_ioctl(snd_pcm_substream_t *substream, unsigned int cmd, void *arg);
@@ -848,23 +847,6 @@
 
 void _snd_pcm_hw_params_any(snd_pcm_hw_params_t *params);
 void _snd_pcm_hw_param_setempty(snd_pcm_hw_params_t *params, snd_pcm_hw_param_t var);
-int snd_pcm_hw_param_min(snd_pcm_substream_t *substream, 
-			 snd_pcm_hw_params_t *params,
-			 snd_pcm_hw_param_t var,
-			 unsigned int val, int *dir);
-int snd_pcm_hw_param_max(snd_pcm_substream_t *substream, 
-			 snd_pcm_hw_params_t *params,
-			 snd_pcm_hw_param_t var,
-			 unsigned int val, int *dir);
-int snd_pcm_hw_param_setinteger(snd_pcm_substream_t *substream, 
-				snd_pcm_hw_params_t *params,
-				snd_pcm_hw_param_t var);
-int snd_pcm_hw_param_first(snd_pcm_substream_t *substream, 
-			   snd_pcm_hw_params_t *params,
-			   snd_pcm_hw_param_t var, int *dir);
-int snd_pcm_hw_param_last(snd_pcm_substream_t *substream, 
-			  snd_pcm_hw_params_t *params,
-			  snd_pcm_hw_param_t var, int *dir);
 int snd_pcm_hw_param_near(snd_pcm_substream_t *substream, 
 			  snd_pcm_hw_params_t *params,
 			  snd_pcm_hw_param_t var, 
@@ -876,7 +858,6 @@
 int snd_pcm_hw_params_choose(snd_pcm_substream_t *substream, snd_pcm_hw_params_t *params);
 
 int snd_pcm_hw_refine(snd_pcm_substream_t *substream, snd_pcm_hw_params_t *params);
-int snd_pcm_hw_params(snd_pcm_substream_t *substream, snd_pcm_hw_params_t *params);
 
 int snd_pcm_hw_constraints_init(snd_pcm_substream_t *substream);
 int snd_pcm_hw_constraints_complete(snd_pcm_substream_t *substream);
@@ -985,7 +966,6 @@
  *  Memory
  */
 
-int snd_pcm_lib_preallocate_free(snd_pcm_substream_t *substream);
 int snd_pcm_lib_preallocate_free_for_all(snd_pcm_t *pcm);
 int snd_pcm_lib_preallocate_pages(snd_pcm_substream_t *substream,
 				  int type, struct device *data,
--- linux-2.6.12-rc4-mm2-full/sound/core/pcm_lib.c.old	2005-05-17 01:21:33.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/pcm_lib.c	2005-05-17 02:21:24.000000000 +0200
@@ -1143,7 +1143,8 @@
 #define INT_MIN ((int)((unsigned int)INT_MAX+1))
 #endif
 
-void _snd_pcm_hw_param_any(snd_pcm_hw_params_t *params, snd_pcm_hw_param_t var)
+static void _snd_pcm_hw_param_any(snd_pcm_hw_params_t *params,
+				  snd_pcm_hw_param_t var)
 {
 	if (hw_is_mask(var)) {
 		snd_mask_any(hw_param_mask(params, var));
@@ -1163,12 +1164,14 @@
 /**
  * snd_pcm_hw_param_any
  */
+#if 0
 int snd_pcm_hw_param_any(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
 			 snd_pcm_hw_param_t var)
 {
 	_snd_pcm_hw_param_any(params, var);
 	return snd_pcm_hw_refine(pcm, params);
 }
+#endif  /*  0  */
 
 void _snd_pcm_hw_params_any(snd_pcm_hw_params_t *params)
 {
@@ -1186,11 +1189,13 @@
  *
  * Fill PARAMS with full configuration space boundaries
  */
+#if 0
 int snd_pcm_hw_params_any(snd_pcm_t *pcm, snd_pcm_hw_params_t *params)
 {
 	_snd_pcm_hw_params_any(params);
 	return snd_pcm_hw_refine(pcm, params);
 }
+#endif  /*  0  */
 
 /**
  * snd_pcm_hw_param_value
@@ -1198,8 +1203,8 @@
  * Return the value for field PAR if it's fixed in configuration space 
  *  defined by PARAMS. Return -EINVAL otherwise
  */
-int snd_pcm_hw_param_value(const snd_pcm_hw_params_t *params,
-			   snd_pcm_hw_param_t var, int *dir)
+static int snd_pcm_hw_param_value(const snd_pcm_hw_params_t *params,
+				  snd_pcm_hw_param_t var, int *dir)
 {
 	if (hw_is_mask(var)) {
 		const snd_mask_t *mask = hw_param_mask_c(params, var);
@@ -1303,6 +1308,7 @@
  * non integer values. Reduce configuration space accordingly.
  * Return -EINVAL if the configuration space is empty
  */
+#if 0
 int snd_pcm_hw_param_setinteger(snd_pcm_t *pcm, 
 				snd_pcm_hw_params_t *params,
 				snd_pcm_hw_param_t var)
@@ -1317,9 +1323,10 @@
 	}
 	return 0;
 }
+#endif  /*  0  */
 
-int _snd_pcm_hw_param_first(snd_pcm_hw_params_t *params,
-			    snd_pcm_hw_param_t var)
+static int _snd_pcm_hw_param_first(snd_pcm_hw_params_t *params,
+				   snd_pcm_hw_param_t var)
 {
 	int changed;
 	if (hw_is_mask(var))
@@ -1345,9 +1352,9 @@
  * values > minimum. Reduce configuration space accordingly.
  * Return the minimum.
  */
-int snd_pcm_hw_param_first(snd_pcm_t *pcm, 
-			   snd_pcm_hw_params_t *params, 
-			   snd_pcm_hw_param_t var, int *dir)
+static int snd_pcm_hw_param_first(snd_pcm_t *pcm, 
+				  snd_pcm_hw_params_t *params, 
+				  snd_pcm_hw_param_t var, int *dir)
 {
 	int changed = _snd_pcm_hw_param_first(params, var);
 	if (changed < 0)
@@ -1359,8 +1366,8 @@
 	return snd_pcm_hw_param_value(params, var, dir);
 }
 
-int _snd_pcm_hw_param_last(snd_pcm_hw_params_t *params,
-			   snd_pcm_hw_param_t var)
+static int _snd_pcm_hw_param_last(snd_pcm_hw_params_t *params,
+				  snd_pcm_hw_param_t var)
 {
 	int changed;
 	if (hw_is_mask(var))
@@ -1386,9 +1393,9 @@
  * values < maximum. Reduce configuration space accordingly.
  * Return the maximum.
  */
-int snd_pcm_hw_param_last(snd_pcm_t *pcm, 
-			  snd_pcm_hw_params_t *params,
-			  snd_pcm_hw_param_t var, int *dir)
+static int snd_pcm_hw_param_last(snd_pcm_t *pcm, 
+				 snd_pcm_hw_params_t *params,
+				 snd_pcm_hw_param_t var, int *dir)
 {
 	int changed = _snd_pcm_hw_param_last(params, var);
 	if (changed < 0)
@@ -1437,8 +1444,9 @@
  * values < VAL. Reduce configuration space accordingly.
  * Return new minimum or -EINVAL if the configuration space is empty
  */
-int snd_pcm_hw_param_min(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
-			 snd_pcm_hw_param_t var, unsigned int val, int *dir)
+static int snd_pcm_hw_param_min(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
+				snd_pcm_hw_param_t var, unsigned int val,
+				int *dir)
 {
 	int changed = _snd_pcm_hw_param_min(params, var, val, dir ? *dir : 0);
 	if (changed < 0)
@@ -1451,8 +1459,9 @@
 	return snd_pcm_hw_param_value_min(params, var, dir);
 }
 
-int _snd_pcm_hw_param_max(snd_pcm_hw_params_t *params,
-			   snd_pcm_hw_param_t var, unsigned int val, int dir)
+static int _snd_pcm_hw_param_max(snd_pcm_hw_params_t *params,
+				 snd_pcm_hw_param_t var, unsigned int val,
+				 int dir)
 {
 	int changed;
 	int open = 0;
@@ -1490,8 +1499,9 @@
  *  values >= VAL + 1. Reduce configuration space accordingly.
  *  Return new maximum or -EINVAL if the configuration space is empty
  */
-int snd_pcm_hw_param_max(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
-			  snd_pcm_hw_param_t var, unsigned int val, int *dir)
+static int snd_pcm_hw_param_max(snd_pcm_t *pcm, snd_pcm_hw_params_t *params,
+				snd_pcm_hw_param_t var, unsigned int val,
+				int *dir)
 {
 	int changed = _snd_pcm_hw_param_max(params, var, val, dir ? *dir : 0);
 	if (changed < 0)
@@ -2564,9 +2574,6 @@
 EXPORT_SYMBOL(snd_interval_refine);
 EXPORT_SYMBOL(snd_interval_list);
 EXPORT_SYMBOL(snd_interval_ratnum);
-EXPORT_SYMBOL(snd_interval_muldivk);
-EXPORT_SYMBOL(snd_interval_mulkdiv);
-EXPORT_SYMBOL(snd_interval_div);
 EXPORT_SYMBOL(_snd_pcm_hw_params_any);
 EXPORT_SYMBOL(_snd_pcm_hw_param_min);
 EXPORT_SYMBOL(_snd_pcm_hw_param_set);
@@ -2580,7 +2587,6 @@
 EXPORT_SYMBOL(snd_pcm_hw_param_near);
 EXPORT_SYMBOL(snd_pcm_hw_param_set);
 EXPORT_SYMBOL(snd_pcm_hw_refine);
-EXPORT_SYMBOL(snd_pcm_hw_params);
 EXPORT_SYMBOL(snd_pcm_hw_constraints_init);
 EXPORT_SYMBOL(snd_pcm_hw_constraints_complete);
 EXPORT_SYMBOL(snd_pcm_hw_constraint_list);
--- linux-2.6.12-rc4-mm2-full/sound/core/pcm_memory.c.old	2005-05-17 01:27:51.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/pcm_memory.c	2005-05-17 02:21:24.000000000 +0200
@@ -97,7 +97,7 @@
  *
  * Returns zero if successful, or a negative error code on failure.
  */
-int snd_pcm_lib_preallocate_free(snd_pcm_substream_t *substream)
+static int snd_pcm_lib_preallocate_free(snd_pcm_substream_t *substream)
 {
 	snd_pcm_lib_preallocate_dma_free(substream);
 	if (substream->proc_prealloc_entry) {
--- linux-2.6.12-rc4-mm2-full/sound/core/pcm_misc.c.old	2005-05-17 01:28:20.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/pcm_misc.c	2005-05-17 02:21:24.000000000 +0200
@@ -276,6 +276,7 @@
  * Returns 1 if the given PCM format is CPU-endian, 0 if
  * opposite, or a negative error code if endian not specified.
  */
+#if 0
 int snd_pcm_format_cpu_endian(snd_pcm_format_t format)
 {
 #ifdef SNDRV_LITTLE_ENDIAN
@@ -284,6 +285,7 @@
 	return snd_pcm_format_big_endian(format);
 #endif
 }
+#endif  /*  0  */
 
 /**
  * snd_pcm_format_width - return the bit-width of the format
@@ -326,6 +328,7 @@
  * Returns the byte size of the given samples for the format, or a
  * negative error code if unknown format.
  */
+#if 0
 ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples)
 {
 	int phys_width = snd_pcm_format_physical_width(format);
@@ -333,6 +336,7 @@
 		return -EINVAL;
 	return samples * phys_width / 8;
 }
+#endif  /*  0  */
 
 /**
  * snd_pcm_format_silence_64 - return the silent data in 8 bytes array
--- linux-2.6.12-rc4-mm2-full/sound/core/pcm_native.c.old	2005-05-17 01:31:42.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/pcm_native.c	2005-05-17 02:21:24.000000000 +0200
@@ -337,8 +337,8 @@
 	return err;
 }
 
-int snd_pcm_hw_params(snd_pcm_substream_t *substream,
-		      snd_pcm_hw_params_t *params)
+static int snd_pcm_hw_params(snd_pcm_substream_t *substream,
+			     snd_pcm_hw_params_t *params)
 {
 	snd_pcm_runtime_t *runtime;
 	int err;
@@ -1044,7 +1044,7 @@
  * Trigger SUSPEND to all linked streams.
  * After this call, all streams are changed to SUSPENDED state.
  */
-int snd_pcm_suspend(snd_pcm_substream_t *substream)
+static int snd_pcm_suspend(snd_pcm_substream_t *substream)
 {
 	int err;
 	unsigned long flags;
--- linux-2.6.12-rc4-mm2-full/sound/core/pcm.c.old	2005-05-17 01:41:29.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/pcm.c	2005-05-17 02:21:24.000000000 +0200
@@ -1049,9 +1049,7 @@
 EXPORT_SYMBOL(snd_pcm_format_name);
   /* pcm_native.c */
 EXPORT_SYMBOL(snd_pcm_link_rwlock);
-EXPORT_SYMBOL(snd_pcm_start);
 #ifdef CONFIG_PM
-EXPORT_SYMBOL(snd_pcm_suspend);
 EXPORT_SYMBOL(snd_pcm_suspend_all);
 #endif
 EXPORT_SYMBOL(snd_pcm_kernel_playback_ioctl);
--- linux-2.6.12-rc4-mm2-full/include/sound/rawmidi.h.old	2005-05-17 01:42:08.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/include/sound/rawmidi.h	2005-05-17 02:21:24.000000000 +0200
@@ -171,9 +171,7 @@
 int snd_rawmidi_kernel_release(snd_rawmidi_file_t * rfile);
 int snd_rawmidi_output_params(snd_rawmidi_substream_t * substream, snd_rawmidi_params_t * params);
 int snd_rawmidi_input_params(snd_rawmidi_substream_t * substream, snd_rawmidi_params_t * params);
-int snd_rawmidi_drop_output(snd_rawmidi_substream_t * substream);
 int snd_rawmidi_drain_output(snd_rawmidi_substream_t * substream);
-int snd_rawmidi_drain_input(snd_rawmidi_substream_t * substream);
 long snd_rawmidi_kernel_read(snd_rawmidi_substream_t * substream, unsigned char *buf, long count);
 long snd_rawmidi_kernel_write(snd_rawmidi_substream_t * substream, const unsigned char *buf, long count);
 
--- linux-2.6.12-rc4-mm2-full/sound/core/rawmidi.c.old	2005-05-17 01:42:30.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/rawmidi.c	2005-05-17 02:21:24.000000000 +0200
@@ -156,7 +156,7 @@
 		tasklet_kill(&substream->runtime->tasklet);
 }
 
-int snd_rawmidi_drop_output(snd_rawmidi_substream_t * substream)
+static int snd_rawmidi_drop_output(snd_rawmidi_substream_t * substream)
 {
 	unsigned long flags;
 	snd_rawmidi_runtime_t *runtime = substream->runtime;
@@ -199,7 +199,7 @@
 	return err;
 }
 
-int snd_rawmidi_drain_input(snd_rawmidi_substream_t * substream)
+static int snd_rawmidi_drain_input(snd_rawmidi_substream_t * substream)
 {
 	unsigned long flags;
 	snd_rawmidi_runtime_t *runtime = substream->runtime;
@@ -532,7 +532,8 @@
 	return err;
 }
 
-int snd_rawmidi_info(snd_rawmidi_substream_t *substream, snd_rawmidi_info_t *info)
+static int snd_rawmidi_info(snd_rawmidi_substream_t *substream,
+			    snd_rawmidi_info_t *info)
 {
 	snd_rawmidi_t *rmidi;
 	
@@ -1662,9 +1663,7 @@
 
 EXPORT_SYMBOL(snd_rawmidi_output_params);
 EXPORT_SYMBOL(snd_rawmidi_input_params);
-EXPORT_SYMBOL(snd_rawmidi_drop_output);
 EXPORT_SYMBOL(snd_rawmidi_drain_output);
-EXPORT_SYMBOL(snd_rawmidi_drain_input);
 EXPORT_SYMBOL(snd_rawmidi_receive);
 EXPORT_SYMBOL(snd_rawmidi_transmit_empty);
 EXPORT_SYMBOL(snd_rawmidi_transmit_peek);
@@ -1672,7 +1671,6 @@
 EXPORT_SYMBOL(snd_rawmidi_transmit);
 EXPORT_SYMBOL(snd_rawmidi_new);
 EXPORT_SYMBOL(snd_rawmidi_set_ops);
-EXPORT_SYMBOL(snd_rawmidi_info);
 EXPORT_SYMBOL(snd_rawmidi_info_select);
 EXPORT_SYMBOL(snd_rawmidi_kernel_open);
 EXPORT_SYMBOL(snd_rawmidi_kernel_release);
--- linux-2.6.12-rc4-mm2-full/include/sound/seq_midi_event.h.old	2005-05-17 01:46:31.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/include/sound/seq_midi_event.h	2005-05-17 02:21:24.000000000 +0200
@@ -41,9 +41,7 @@
 };
 
 int snd_midi_event_new(int bufsize, snd_midi_event_t **rdev);
-int snd_midi_event_resize_buffer(snd_midi_event_t *dev, int bufsize);
 void snd_midi_event_free(snd_midi_event_t *dev);
-void snd_midi_event_init(snd_midi_event_t *dev);
 void snd_midi_event_reset_encode(snd_midi_event_t *dev);
 void snd_midi_event_reset_decode(snd_midi_event_t *dev);
 void snd_midi_event_no_status(snd_midi_event_t *dev, int on);
--- linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_midi_event.c.old	2005-05-17 01:46:43.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_midi_event.c	2005-05-17 02:21:24.000000000 +0200
@@ -171,11 +171,13 @@
 	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
+#if 0
 void snd_midi_event_init(snd_midi_event_t *dev)
 {
 	snd_midi_event_reset_encode(dev);
 	snd_midi_event_reset_decode(dev);
 }
+#endif  /*  0  */
 
 void snd_midi_event_no_status(snd_midi_event_t *dev, int on)
 {
@@ -185,6 +187,7 @@
 /*
  * resize buffer
  */
+#if 0
 int snd_midi_event_resize_buffer(snd_midi_event_t *dev, int bufsize)
 {
 	unsigned char *new_buf, *old_buf;
@@ -204,6 +207,7 @@
 	kfree(old_buf);
 	return 0;
 }
+#endif  /*  0  */
 
 /*
  *  read bytes and encode to sequencer event if finished
@@ -517,8 +521,6 @@
  
 EXPORT_SYMBOL(snd_midi_event_new);
 EXPORT_SYMBOL(snd_midi_event_free);
-EXPORT_SYMBOL(snd_midi_event_resize_buffer);
-EXPORT_SYMBOL(snd_midi_event_init);
 EXPORT_SYMBOL(snd_midi_event_reset_encode);
 EXPORT_SYMBOL(snd_midi_event_reset_decode);
 EXPORT_SYMBOL(snd_midi_event_no_status);
--- linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_queue.h.old	2005-05-17 01:47:48.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_queue.h	2005-05-17 02:21:42.000000000 +0200
@@ -111,7 +111,6 @@
 int snd_seq_queue_is_used(int queueid, int client);
 
 int snd_seq_control_queue(snd_seq_event_t *ev, int atomic, int hop);
-void snd_seq_queue_process_event(queue_t *q, snd_seq_event_t *ev, int atomic, int hop);
 
 /*
  * 64bit division - for sync stuff..
--- linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_queue.c.old	2005-05-17 01:48:03.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_queue.c	2005-05-17 02:21:57.000000000 +0200
@@ -672,7 +672,8 @@
  * process a received queue-control event.
  * this function is exported for seq_sync.c.
  */
-void snd_seq_queue_process_event(queue_t *q, snd_seq_event_t *ev, int atomic, int hop)
+static void snd_seq_queue_process_event(queue_t *q, snd_seq_event_t *ev,
+					int atomic, int hop)
 {
 	switch (ev->type) {
 	case SNDRV_SEQ_EVENT_START:
--- linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_timer.h.old	2005-05-17 01:48:35.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_timer.h	2005-05-17 02:21:24.000000000 +0200
@@ -64,8 +64,6 @@
 /* delete timer (destructor) */
 extern void snd_seq_timer_delete(seq_timer_t **tmr);
 
-void snd_seq_timer_set_tick_resolution(seq_timer_tick_t *tick, int tempo, int ppq, int nticks);
-
 /* */
 static inline void snd_seq_timer_update_tick(seq_timer_tick_t *tick, unsigned long resolution)
 {
--- linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_timer.c.old	2005-05-17 01:48:50.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_timer.c	2005-05-17 02:21:24.000000000 +0200
@@ -36,7 +36,8 @@
 
 #define SKEW_BASE	0x10000	/* 16bit shift */
 
-void snd_seq_timer_set_tick_resolution(seq_timer_tick_t *tick, int tempo, int ppq, int nticks)
+static void snd_seq_timer_set_tick_resolution(seq_timer_tick_t *tick,
+					      int tempo, int ppq, int nticks)
 {
 	if (tempo < 1000000)
 		tick->resolution = (tempo * 1000) / ppq;
--- linux-2.6.12-rc4-mm2-full/include/sound/seq_virmidi.h.old	2005-05-17 01:51:13.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/include/sound/seq_virmidi.h	2005-05-17 02:21:24.000000000 +0200
@@ -79,6 +79,5 @@
 #define SNDRV_VIRMIDI_SEQ_DISPATCH	2
 
 int snd_virmidi_new(snd_card_t *card, int device, snd_rawmidi_t **rrmidi);
-int snd_virmidi_receive(snd_rawmidi_t *rmidi, snd_seq_event_t *ev);
 
 #endif /* __SOUND_SEQ_VIRMIDI */
--- linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_virmidi.c.old	2005-05-17 01:51:41.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/seq/seq_virmidi.c	2005-05-17 02:21:24.000000000 +0200
@@ -110,7 +110,7 @@
  * handler of a remote port which is attached to the virmidi via
  * SNDRV_VIRMIDI_SEQ_ATTACH.
  */
-/* exported */
+#if 0
 int snd_virmidi_receive(snd_rawmidi_t *rmidi, snd_seq_event_t *ev)
 {
 	snd_virmidi_dev_t *rdev;
@@ -118,6 +118,7 @@
 	rdev = rmidi->private_data;
 	return snd_virmidi_dev_receive_event(rdev, ev);
 }
+#endif  /*  0  */
 
 /*
  * event handler of virmidi port
@@ -548,4 +549,3 @@
 module_exit(alsa_virmidi_exit)
 
 EXPORT_SYMBOL(snd_virmidi_new);
-EXPORT_SYMBOL(snd_virmidi_receive);
--- linux-2.6.12-rc4-mm2-full/include/sound/timer.h.old	2005-05-17 01:52:15.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/include/sound/timer.h	2005-05-17 02:21:24.000000000 +0200
@@ -147,11 +147,8 @@
 extern unsigned long snd_timer_resolution(snd_timer_instance_t * timeri);
 extern int snd_timer_start(snd_timer_instance_t * timeri, unsigned int ticks);
 extern int snd_timer_stop(snd_timer_instance_t * timeri);
-extern int snd_timer_continue(snd_timer_instance_t * timeri);
 extern int snd_timer_pause(snd_timer_instance_t * timeri);
 
 extern void snd_timer_interrupt(snd_timer_t * timer, unsigned long ticks_left);
 
-extern unsigned int snd_timer_system_resolution(void);
-
 #endif /* __SOUND_TIMER_H */
--- linux-2.6.12-rc4-mm2-full/sound/core/timer.c.old	2005-05-17 01:52:27.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/timer.c	2005-05-17 02:21:24.000000000 +0200
@@ -534,7 +534,7 @@
 /*
  * start again..  the tick is kept.
  */
-int snd_timer_continue(snd_timer_instance_t * timeri)
+static int snd_timer_continue(snd_timer_instance_t * timeri)
 {
 	snd_timer_t *timer;
 	int result = -EINVAL;
@@ -846,7 +846,7 @@
 	return 0;
 }
 
-int snd_timer_unregister(snd_timer_t *timer)
+static int snd_timer_unregister(snd_timer_t *timer)
 {
 	struct list_head *p, *n;
 	snd_timer_instance_t *ti;
@@ -947,10 +947,12 @@
 	unsigned long correction;
 };
 
+#if 0
 unsigned int snd_timer_system_resolution(void)
 {
 	return 1000000000L / HZ;
 }
+#endif  /*  0  */
 
 static void snd_timer_s_function(unsigned long data)
 {
@@ -1903,7 +1905,6 @@
 EXPORT_SYMBOL(snd_timer_resolution);
 EXPORT_SYMBOL(snd_timer_start);
 EXPORT_SYMBOL(snd_timer_stop);
-EXPORT_SYMBOL(snd_timer_continue);
 EXPORT_SYMBOL(snd_timer_pause);
 EXPORT_SYMBOL(snd_timer_new);
 EXPORT_SYMBOL(snd_timer_notify);
@@ -1912,4 +1913,3 @@
 EXPORT_SYMBOL(snd_timer_global_register);
 EXPORT_SYMBOL(snd_timer_global_unregister);
 EXPORT_SYMBOL(snd_timer_interrupt);
-EXPORT_SYMBOL(snd_timer_system_resolution);
--- linux-2.6.12-rc4-mm2-full/sound/core/sound.c.old	2005-05-17 02:16:12.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/core/sound.c	2005-05-17 02:21:24.000000000 +0200
@@ -431,7 +431,6 @@
 EXPORT_SYMBOL(snd_device_new);
 EXPORT_SYMBOL(snd_device_register);
 EXPORT_SYMBOL(snd_device_free);
-EXPORT_SYMBOL(snd_device_free_all);
   /* isadma.c */
 #ifdef CONFIG_ISA
 EXPORT_SYMBOL(snd_dma_program);


