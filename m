Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVA3SEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVA3SEQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVA3SEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:04:16 -0500
Received: from quark.didntduck.org ([69.55.226.66]:10951 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261753AbVA3SCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:02:20 -0500
Message-ID: <41FD2127.5090907@didntduck.org>
Date: Sun, 30 Jan 2005 13:02:15 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de, perex@suse.cz
Subject: Re: [PATCH 0/3] Conversion to compat_ioctl for ALSA drivers
References: <s5hfz0ywve8.wl@alsa2.suse.de>
In-Reply-To: <s5hfz0ywve8.wl@alsa2.suse.de>
Content-Type: multipart/mixed;
 boundary="------------080904070009070502090204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080904070009070502090204
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> Hi,
> 
> the following three patches convert the 32bit ioctl layer of ALSA to
> the new compat_ioctl (and unlocked_ioctl for native ioctls).
> 
> The first patch covers the basic entries and control API.
> The second patch is for PCM API.
> The last one is for other APIs including OSS-emulation modules.
> 
> After these patches are applied, remove the whole subtree in
> sound/core/ioctl32.  The files in this directory are no longer
> necessary.

Fix 32-bit calls to snd_pcm_channel_info().

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------080904070009070502090204
Content-Type: text/plain;
 name="alsa-pcm-compat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-pcm-compat"

--- linux/sound/core/pcm_native.c.bak	2005-01-30 11:15:24.000000000 -0500
+++ linux/sound/core/pcm_native.c	2005-01-30 11:17:31.000000000 -0500
@@ -602,17 +602,13 @@
 	return 0;
 }
 
-static int snd_pcm_channel_info(snd_pcm_substream_t * substream, snd_pcm_channel_info_t __user * _info)
+static int snd_pcm_channel_info(snd_pcm_substream_t * substream, snd_pcm_channel_info_t * info)
 {
-	snd_pcm_channel_info_t info;
 	snd_pcm_runtime_t *runtime;
-	int res;
 	unsigned int channel;
 	
 	snd_assert(substream != NULL, return -ENXIO);
-	if (copy_from_user(&info, _info, sizeof(info)))
-		return -EFAULT;
-	channel = info.channel;
+	channel = info->channel;
 	runtime = substream->runtime;
 	snd_pcm_stream_lock_irq(substream);
 	if (runtime->status->state == SNDRV_PCM_STATE_OPEN) {
@@ -622,9 +618,19 @@
 	snd_pcm_stream_unlock_irq(substream);
 	if (channel >= runtime->channels)
 		return -EINVAL;
-	memset(&info, 0, sizeof(info));
-	info.channel = channel;
-	res = substream->ops->ioctl(substream, SNDRV_PCM_IOCTL1_CHANNEL_INFO, &info);
+	memset(info, 0, sizeof(*info));
+	info->channel = channel;
+	return substream->ops->ioctl(substream, SNDRV_PCM_IOCTL1_CHANNEL_INFO, info);
+}
+
+static int snd_pcm_channel_info_user(snd_pcm_substream_t * substream, snd_pcm_channel_info_t __user * _info)
+{
+	snd_pcm_channel_info_t info;
+	int res;
+	
+	if (copy_from_user(&info, _info, sizeof(info)))
+		return -EFAULT;
+	res = snd_pcm_channel_info(substream, &info);
 	if (res < 0)
 		return res;
 	if (copy_to_user(_info, &info, sizeof(info)))
@@ -2440,7 +2446,7 @@
 	case SNDRV_PCM_IOCTL_STATUS:
 		return snd_pcm_status_user(substream, arg);
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO:
-		return snd_pcm_channel_info(substream, arg);
+		return snd_pcm_channel_info_user(substream, arg);
 	case SNDRV_PCM_IOCTL_PREPARE:
 		return snd_pcm_prepare(substream);
 	case SNDRV_PCM_IOCTL_RESET:

--------------080904070009070502090204--
