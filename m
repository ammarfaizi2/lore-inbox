Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbSIWUBO>; Mon, 23 Sep 2002 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbSIWUA5>; Mon, 23 Sep 2002 16:00:57 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:5248 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S261354AbSIWT7a>;
	Mon, 23 Sep 2002 15:59:30 -0400
Message-ID: <3D8F73CD.9060005@welho.com>
Date: Mon, 23 Sep 2002 23:04:29 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
Reply-To: Mika.Liljeberg@welho.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, rem@osdl.org,
       pwaechtler@mac.com
Subject: [PATCH][2.5.38] OSS/sound locking+memory corruption problem
Content-Type: multipart/mixed;
 boundary="------------030803040803040202010307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030803040803040202010307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attached patch fixes some buggy DMA ioctl's in sound/oss/audio.c.

Cheers,

	MikaL


--------------030803040803040202010307
Content-Type: text/plain;
 name="oss.udiff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oss.udiff"

--- linux-2.5.38/sound/oss/audio.c.org	2002-09-23 20:57:10.000000000 +0300
+++ linux-2.5.38/sound/oss/audio.c	2002-09-23 22:34:45.000000000 +0300
@@ -826,37 +826,48 @@
 			if (!(audio_devs[dev]->flags & DMA_DUPLEX) && (bits & PCM_ENABLE_INPUT) &&
 				(bits & PCM_ENABLE_OUTPUT))
 				return -EINVAL;
-			spin_lock_irqsave(&dmap->lock,flags);
-			changed = audio_devs[dev]->enable_bits ^ bits;
-			if ((changed & bits) & PCM_ENABLE_INPUT && audio_devs[dev]->go) 
+
+			if (bits & PCM_ENABLE_INPUT)
 			{
-				reorganize_buffers(dev, dmap_in, 1);
-				if ((err = audio_devs[dev]->d->prepare_for_input(dev,
-					     dmap_in->fragment_size, dmap_in->nbufs)) < 0) {
-					spin_unlock_irqrestore(&dmap->lock,flags);
-					return -err;
-				}
-				dmap_in->dma_mode = DMODE_INPUT;
-				audio_devs[dev]->enable_bits = bits;
-				DMAbuf_activate_recording(dev, dmap_in);
+				spin_lock_irqsave(&dmap_in->lock,flags);
+				changed = (audio_devs[dev]->enable_bits ^ bits) & PCM_ENABLE_INPUT;
+				if (changed && audio_devs[dev]->go) 
+				{
+					reorganize_buffers(dev, dmap_in, 1);
+					if ((err = audio_devs[dev]->d->prepare_for_input(dev,
+						     dmap_in->fragment_size, dmap_in->nbufs)) < 0) {
+						spin_unlock_irqrestore(&dmap_in->lock,flags);
+						return -err;
+					}
+					dmap_in->dma_mode = DMODE_INPUT;
+					audio_devs[dev]->enable_bits |= PCM_ENABLE_INPUT;
+					DMAbuf_activate_recording(dev, dmap_in);
+				} else
+					audio_devs[dev]->enable_bits &= ~PCM_ENABLE_INPUT;
+				spin_unlock_irqrestore(&dmap_in->lock,flags);
 			}
-			if ((changed & bits) & PCM_ENABLE_OUTPUT &&
-			    (dmap_out->mapping_flags & DMA_MAP_MAPPED || dmap_out->qlen > 0) &&
-			    audio_devs[dev]->go) 
+			if (bits & PCM_ENABLE_OUTPUT)
 			{
-				if (!(dmap_out->flags & DMA_ALLOC_DONE))
-					reorganize_buffers(dev, dmap_out, 0);
-				dmap_out->dma_mode = DMODE_OUTPUT;
-				audio_devs[dev]->enable_bits = bits;
-				dmap_out->counts[dmap_out->qhead] = dmap_out->fragment_size;
-				DMAbuf_launch_output(dev, dmap_out);
+				spin_lock_irqsave(&dmap_out->lock,flags);
+				changed = (audio_devs[dev]->enable_bits ^ bits) & PCM_ENABLE_OUTPUT;
+				if (changed &&
+				    (dmap_out->mapping_flags & DMA_MAP_MAPPED || dmap_out->qlen > 0) &&
+				    audio_devs[dev]->go) 
+				{
+					if (!(dmap_out->flags & DMA_ALLOC_DONE))
+						reorganize_buffers(dev, dmap_out, 0);
+					dmap_out->dma_mode = DMODE_OUTPUT;
+					audio_devs[dev]->enable_bits |= PCM_ENABLE_OUTPUT;
+					dmap_out->counts[dmap_out->qhead] = dmap_out->fragment_size;
+					DMAbuf_launch_output(dev, dmap_out);
+				} else
+					audio_devs[dev]->enable_bits &= ~PCM_ENABLE_OUTPUT;
+				spin_unlock_irqrestore(&dmap_out->lock,flags);
 			}
-			audio_devs[dev]->enable_bits = bits;
 #if 0
 			if (changed && audio_devs[dev]->d->trigger)
 				audio_devs[dev]->d->trigger(dev, bits * audio_devs[dev]->go);
 #endif				
-			spin_unlock_irqrestore(&dmap->lock,flags);
 			/* Falls through... */
 
 		case SNDCTL_DSP_GETTRIGGER:
@@ -873,7 +884,7 @@
 		case SNDCTL_DSP_GETIPTR:
 			if (!(audio_devs[dev]->open_mode & OPEN_READ))
 				return -EINVAL;
-			spin_lock_irqsave(&dmap->lock,flags);
+			spin_lock_irqsave(&dmap_in->lock,flags);
 			cinfo.bytes = dmap_in->byte_counter;
 			cinfo.ptr = DMAbuf_get_buffer_pointer(dev, dmap_in, DMODE_INPUT) & ~3;
 			if (cinfo.ptr < dmap_in->fragment_size && dmap_in->qtail != 0)
@@ -882,7 +893,7 @@
 			cinfo.bytes += cinfo.ptr;
 			if (dmap_in->mapping_flags & DMA_MAP_MAPPED)
 				dmap_in->qlen = 0;	/* Reset interrupt counter */
-			spin_unlock_irqrestore(&dmap->lock,flags);
+			spin_unlock_irqrestore(&dmap_in->lock,flags);
 			if (copy_to_user(arg, &cinfo, sizeof(cinfo)))
 				return -EFAULT;
 			return 0;
@@ -891,7 +902,7 @@
 			if (!(audio_devs[dev]->open_mode & OPEN_WRITE))
 				return -EINVAL;
 
-			spin_lock_irqsave(&dmap->lock,flags);
+			spin_lock_irqsave(&dmap_out->lock,flags);
 			cinfo.bytes = dmap_out->byte_counter;
 			cinfo.ptr = DMAbuf_get_buffer_pointer(dev, dmap_out, DMODE_OUTPUT) & ~3;
 			if (cinfo.ptr < dmap_out->fragment_size && dmap_out->qhead != 0)
@@ -900,7 +911,7 @@
 			cinfo.bytes += cinfo.ptr;
 			if (dmap_out->mapping_flags & DMA_MAP_MAPPED)
 				dmap_out->qlen = 0;	/* Reset interrupt counter */
-			spin_unlock_irqrestore(&dmap->lock,flags);
+			spin_unlock_irqrestore(&dmap_out->lock,flags);
 			if (copy_to_user(arg, &cinfo, sizeof(cinfo)))
 				return -EFAULT;
 			return 0;
@@ -913,7 +924,7 @@
 				ret=0;
 				break;
 			}
-			spin_lock_irqsave(&dmap->lock,flags);
+			spin_lock_irqsave(&dmap_out->lock,flags);
 			/* Compute number of bytes that have been played */
 			count = DMAbuf_get_buffer_pointer (dev, dmap_out, DMODE_OUTPUT);
 			if (count < dmap_out->fragment_size && dmap_out->qhead != 0)
@@ -923,7 +934,7 @@
 			count = dmap_out->user_counter - count;
 			if (count < 0)
 				count = 0;
-			spin_unlock_irqrestore(&dmap->lock,flags);
+			spin_unlock_irqrestore(&dmap_out->lock,flags);
 			ret = count;
 			break;
 

--------------030803040803040202010307--

