Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262753AbSI1JIS>; Sat, 28 Sep 2002 05:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262754AbSI1JIS>; Sat, 28 Sep 2002 05:08:18 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:14730 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S262753AbSI1JIQ>;
	Sat, 28 Sep 2002 05:08:16 -0400
Subject: Re: Linux v2.5.39
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0209271459210.1807-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0209271459210.1807-100000@penguin.transmeta.com>
Content-Type: multipart/mixed; boundary="=-wSiClNCboN9BL2qlUC1g"
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Sep 2002 12:13:12 +0300
Message-Id: <1033204392.616.10.camel@devil>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wSiClNCboN9BL2qlUC1g
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-09-28 at 01:02, Linus Torvalds wrote:
> 
> Changes all over the map.

Looks like the attached patch didn't work its way in there. Please
apply. The patch is good for 2.5.39 as well.

The current code in sound/oss/audio.c tries to access spinlocks through
a garbage pointer in many places. This causes bad things to happen on
SMP machines.

Regards,

	MikaL


--=-wSiClNCboN9BL2qlUC1g
Content-Disposition: attachment; filename=oss.udiff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=oss.udiff; charset=ISO-8859-1

--- linux-2.5.38/sound/oss/audio.c.org	2002-09-23 20:57:10.000000000 +0300
+++ linux-2.5.38/sound/oss/audio.c	2002-09-23 22:34:45.000000000 +0300
@@ -826,37 +826,48 @@
 			if (!(audio_devs[dev]->flags & DMA_DUPLEX) && (bits & PCM_ENABLE_INPUT)=
 &&
 				(bits & PCM_ENABLE_OUTPUT))
 				return -EINVAL;
-			spin_lock_irqsave(&dmap->lock,flags);
-			changed =3D audio_devs[dev]->enable_bits ^ bits;
-			if ((changed & bits) & PCM_ENABLE_INPUT && audio_devs[dev]->go)=20
+
+			if (bits & PCM_ENABLE_INPUT)
 			{
-				reorganize_buffers(dev, dmap_in, 1);
-				if ((err =3D audio_devs[dev]->d->prepare_for_input(dev,
-					     dmap_in->fragment_size, dmap_in->nbufs)) < 0) {
-					spin_unlock_irqrestore(&dmap->lock,flags);
-					return -err;
-				}
-				dmap_in->dma_mode =3D DMODE_INPUT;
-				audio_devs[dev]->enable_bits =3D bits;
-				DMAbuf_activate_recording(dev, dmap_in);
+				spin_lock_irqsave(&dmap_in->lock,flags);
+				changed =3D (audio_devs[dev]->enable_bits ^ bits) & PCM_ENABLE_INPUT;
+				if (changed && audio_devs[dev]->go)=20
+				{
+					reorganize_buffers(dev, dmap_in, 1);
+					if ((err =3D audio_devs[dev]->d->prepare_for_input(dev,
+						     dmap_in->fragment_size, dmap_in->nbufs)) < 0) {
+						spin_unlock_irqrestore(&dmap_in->lock,flags);
+						return -err;
+					}
+					dmap_in->dma_mode =3D DMODE_INPUT;
+					audio_devs[dev]->enable_bits |=3D PCM_ENABLE_INPUT;
+					DMAbuf_activate_recording(dev, dmap_in);
+				} else
+					audio_devs[dev]->enable_bits &=3D ~PCM_ENABLE_INPUT;
+				spin_unlock_irqrestore(&dmap_in->lock,flags);
 			}
-			if ((changed & bits) & PCM_ENABLE_OUTPUT &&
-			    (dmap_out->mapping_flags & DMA_MAP_MAPPED || dmap_out->qlen > 0) &&
-			    audio_devs[dev]->go)=20
+			if (bits & PCM_ENABLE_OUTPUT)
 			{
-				if (!(dmap_out->flags & DMA_ALLOC_DONE))
-					reorganize_buffers(dev, dmap_out, 0);
-				dmap_out->dma_mode =3D DMODE_OUTPUT;
-				audio_devs[dev]->enable_bits =3D bits;
-				dmap_out->counts[dmap_out->qhead] =3D dmap_out->fragment_size;
-				DMAbuf_launch_output(dev, dmap_out);
+				spin_lock_irqsave(&dmap_out->lock,flags);
+				changed =3D (audio_devs[dev]->enable_bits ^ bits) & PCM_ENABLE_OUTPUT;
+				if (changed &&
+				    (dmap_out->mapping_flags & DMA_MAP_MAPPED || dmap_out->qlen > 0) &=
&
+				    audio_devs[dev]->go)=20
+				{
+					if (!(dmap_out->flags & DMA_ALLOC_DONE))
+						reorganize_buffers(dev, dmap_out, 0);
+					dmap_out->dma_mode =3D DMODE_OUTPUT;
+					audio_devs[dev]->enable_bits |=3D PCM_ENABLE_OUTPUT;
+					dmap_out->counts[dmap_out->qhead] =3D dmap_out->fragment_size;
+					DMAbuf_launch_output(dev, dmap_out);
+				} else
+					audio_devs[dev]->enable_bits &=3D ~PCM_ENABLE_OUTPUT;
+				spin_unlock_irqrestore(&dmap_out->lock,flags);
 			}
-			audio_devs[dev]->enable_bits =3D bits;
 #if 0
 			if (changed && audio_devs[dev]->d->trigger)
 				audio_devs[dev]->d->trigger(dev, bits * audio_devs[dev]->go);
 #endif			=09
-			spin_unlock_irqrestore(&dmap->lock,flags);
 			/* Falls through... */
=20
 		case SNDCTL_DSP_GETTRIGGER:
@@ -873,7 +884,7 @@
 		case SNDCTL_DSP_GETIPTR:
 			if (!(audio_devs[dev]->open_mode & OPEN_READ))
 				return -EINVAL;
-			spin_lock_irqsave(&dmap->lock,flags);
+			spin_lock_irqsave(&dmap_in->lock,flags);
 			cinfo.bytes =3D dmap_in->byte_counter;
 			cinfo.ptr =3D DMAbuf_get_buffer_pointer(dev, dmap_in, DMODE_INPUT) & ~3=
;
 			if (cinfo.ptr < dmap_in->fragment_size && dmap_in->qtail !=3D 0)
@@ -882,7 +893,7 @@
 			cinfo.bytes +=3D cinfo.ptr;
 			if (dmap_in->mapping_flags & DMA_MAP_MAPPED)
 				dmap_in->qlen =3D 0;	/* Reset interrupt counter */
-			spin_unlock_irqrestore(&dmap->lock,flags);
+			spin_unlock_irqrestore(&dmap_in->lock,flags);
 			if (copy_to_user(arg, &cinfo, sizeof(cinfo)))
 				return -EFAULT;
 			return 0;
@@ -891,7 +902,7 @@
 			if (!(audio_devs[dev]->open_mode & OPEN_WRITE))
 				return -EINVAL;
=20
-			spin_lock_irqsave(&dmap->lock,flags);
+			spin_lock_irqsave(&dmap_out->lock,flags);
 			cinfo.bytes =3D dmap_out->byte_counter;
 			cinfo.ptr =3D DMAbuf_get_buffer_pointer(dev, dmap_out, DMODE_OUTPUT) & =
~3;
 			if (cinfo.ptr < dmap_out->fragment_size && dmap_out->qhead !=3D 0)
@@ -900,7 +911,7 @@
 			cinfo.bytes +=3D cinfo.ptr;
 			if (dmap_out->mapping_flags & DMA_MAP_MAPPED)
 				dmap_out->qlen =3D 0;	/* Reset interrupt counter */
-			spin_unlock_irqrestore(&dmap->lock,flags);
+			spin_unlock_irqrestore(&dmap_out->lock,flags);
 			if (copy_to_user(arg, &cinfo, sizeof(cinfo)))
 				return -EFAULT;
 			return 0;
@@ -913,7 +924,7 @@
 				ret=3D0;
 				break;
 			}
-			spin_lock_irqsave(&dmap->lock,flags);
+			spin_lock_irqsave(&dmap_out->lock,flags);
 			/* Compute number of bytes that have been played */
 			count =3D DMAbuf_get_buffer_pointer (dev, dmap_out, DMODE_OUTPUT);
 			if (count < dmap_out->fragment_size && dmap_out->qhead !=3D 0)
@@ -923,7 +934,7 @@
 			count =3D dmap_out->user_counter - count;
 			if (count < 0)
 				count =3D 0;
-			spin_unlock_irqrestore(&dmap->lock,flags);
+			spin_unlock_irqrestore(&dmap_out->lock,flags);
 			ret =3D count;
 			break;
=20

--=-wSiClNCboN9BL2qlUC1g--
