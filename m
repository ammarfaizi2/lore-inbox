Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319387AbSH2Vws>; Thu, 29 Aug 2002 17:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319386AbSH2VwH>; Thu, 29 Aug 2002 17:52:07 -0400
Received: from smtpout.mac.com ([204.179.120.86]:63954 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319355AbSH2Vuk>;
	Thu, 29 Aug 2002 17:50:40 -0400
Message-Id: <200208292155.g7TLt3KN026207@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 9/41 sound/oss/audio.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/audio.c	Sat Apr 20 18:25:18 2002
+++ linux-2.5-cli-oss/sound/oss/audio.c	Wed Aug 14 22:27:56 2002
@@ -291,10 +291,6 @@
 
 		if (audio_devs[dev]->local_conversion & CNV_MU_LAW)
 		{
-			/*
-			 * This just allows interrupts while the conversion is running
-			 */
-			sti();
 			translate_bytes(ulaw_dsp, (unsigned char *) dma_buf, l);
 		}
 		c -= used;
@@ -352,11 +348,6 @@
 
 		if (audio_devs[dev]->local_conversion & CNV_MU_LAW)
 		{
-			/*
-			 * This just allows interrupts while the conversion is running
-			 */
-			sti();
-
 			translate_bytes(dsp_ulaw, (unsigned char *) dmabuf, l);
 		}
 		
@@ -515,8 +506,7 @@
 				break;
 			}
 		
-			save_flags (flags);
-			cli();
+			spin_lock_irqsave(&dmap->lock,flags);
 			/* Compute number of bytes that have been played */
 			count = DMAbuf_get_buffer_pointer (dev, dmap, DMODE_OUTPUT);
 			if (count < dmap->fragment_size && dmap->qhead != 0)
@@ -527,7 +517,7 @@
 			count = dmap->user_counter - count;
 			if (count < 0)
 				count = 0;
-			restore_flags (flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 			val = count;
 			break;
 		
@@ -836,15 +826,14 @@
 			if (!(audio_devs[dev]->flags & DMA_DUPLEX) && (bits & PCM_ENABLE_INPUT) &&
 				(bits & PCM_ENABLE_OUTPUT))
 				return -EINVAL;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&dmap->lock,flags);
 			changed = audio_devs[dev]->enable_bits ^ bits;
 			if ((changed & bits) & PCM_ENABLE_INPUT && audio_devs[dev]->go) 
 			{
 				reorganize_buffers(dev, dmap_in, 1);
 				if ((err = audio_devs[dev]->d->prepare_for_input(dev,
 					     dmap_in->fragment_size, dmap_in->nbufs)) < 0) {
-					restore_flags(flags);
+					spin_unlock_irqrestore(&dmap->lock,flags);
 					return -err;
 				}
 				dmap_in->dma_mode = DMODE_INPUT;
@@ -867,7 +856,7 @@
 			if (changed && audio_devs[dev]->d->trigger)
 				audio_devs[dev]->d->trigger(dev, bits * audio_devs[dev]->go);
 #endif				
-			restore_flags(flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 			/* Falls through... */
 
 		case SNDCTL_DSP_GETTRIGGER:
@@ -884,8 +873,7 @@
 		case SNDCTL_DSP_GETIPTR:
 			if (!(audio_devs[dev]->open_mode & OPEN_READ))
 				return -EINVAL;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&dmap->lock,flags);
 			cinfo.bytes = dmap_in->byte_counter;
 			cinfo.ptr = DMAbuf_get_buffer_pointer(dev, dmap_in, DMODE_INPUT) & ~3;
 			if (cinfo.ptr < dmap_in->fragment_size && dmap_in->qtail != 0)
@@ -894,7 +882,7 @@
 			cinfo.bytes += cinfo.ptr;
 			if (dmap_in->mapping_flags & DMA_MAP_MAPPED)
 				dmap_in->qlen = 0;	/* Reset interrupt counter */
-			restore_flags(flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 			if (copy_to_user(arg, &cinfo, sizeof(cinfo)))
 				return -EFAULT;
 			return 0;
@@ -903,8 +891,7 @@
 			if (!(audio_devs[dev]->open_mode & OPEN_WRITE))
 				return -EINVAL;
 
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&dmap->lock,flags);
 			cinfo.bytes = dmap_out->byte_counter;
 			cinfo.ptr = DMAbuf_get_buffer_pointer(dev, dmap_out, DMODE_OUTPUT) & ~3;
 			if (cinfo.ptr < dmap_out->fragment_size && dmap_out->qhead != 0)
@@ -913,7 +900,7 @@
 			cinfo.bytes += cinfo.ptr;
 			if (dmap_out->mapping_flags & DMA_MAP_MAPPED)
 				dmap_out->qlen = 0;	/* Reset interrupt counter */
-			restore_flags(flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 			if (copy_to_user(arg, &cinfo, sizeof(cinfo)))
 				return -EFAULT;
 			return 0;
@@ -926,8 +913,7 @@
 				ret=0;
 				break;
 			}
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&dmap->lock,flags);
 			/* Compute number of bytes that have been played */
 			count = DMAbuf_get_buffer_pointer (dev, dmap_out, DMODE_OUTPUT);
 			if (count < dmap_out->fragment_size && dmap_out->qhead != 0)
@@ -937,7 +923,7 @@
 			count = dmap_out->user_counter - count;
 			if (count < 0)
 				count = 0;
-			restore_flags (flags);
+			spin_unlock_irqrestore(&dmap->lock,flags);
 			ret = count;
 			break;
 

