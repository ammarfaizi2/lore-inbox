Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSFAUmj>; Sat, 1 Jun 2002 16:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317062AbSFAUmi>; Sat, 1 Jun 2002 16:42:38 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:14280 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317059AbSFAUme>; Sat, 1 Jun 2002 16:42:34 -0400
Date: Sat, 1 Jun 2002 22:42:28 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Cc: andrea@e-mind.com
Subject: [PATCH] SB16: 2.4.18 lockup on odd-numbered 16bit sound input
Message-ID: <20020601204228.GA1637@andi.hausnetz>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

when running a program on Wine, suddenly my 2.4.18 froze completely.
This has been caused by the program submitting an odd number of output
bytes to the soundcard in 16bit output mode, thus causing the sound
driver to loop endlessly on the last remaining byte.
When digging deeper, I found that this odd number of output bytes had
been caused by the SoundBlaster 16 driver always returning one half of
the output bytes that it could take (in the SNDCTL_DSP_GETOSPACE ioctl
result), thus always cutting the remaining free buffer in half, thus
hitting an odd number after some time (1988 bytes -> 994 -> 497).
The SB16 driver is doing an internal 16bit -> 8bit conversion in case
it's running in fullduplex mode, and it simply returned the remaining
free bytes in the DMA buffer, which should have been twice that number
due to the 16bit -> 8bit conversion in fullduplex mode.
Also, it's doing 8bit -> 16bit conversion in the 8bit output case,
which SNDCTL_DSP_GETOSPACE ioctl didn't account for either.

In short: When using SB16 in fullduplex mode, the SNDCTL_DSP_GETOSPACE
ioctl didn't account for the 16/8bit format conversions that the SB16
does in this case, thus leading to an odd-numbered input count freezing
the box due to a second "odd remainder" endless loop bug.

Thus this patch does:
- add two flags DMA_CONV_16_8, DMA_CONV_8_16 to struct dma_buffparms
  to check for format conversion in dma_ioctl()/SNDCTL_DSP_GETOSPACE
  and thus fix SNDCTL_DSP_GETOSPACE result to account for format
  conversion
- prevent endless looping (lockup) on single remaining byte by
  discarding odd remainders of odd output counts in case of 16bit format

This WORKS (well, for me at least :-).

My previous LKML mails about this problem were:
 950     May 25 Andreas Mohr    (  80) SB16: 2.4.18 lockup on odd-numbered 16bit
 951     May 26 Andreas Mohr    (  59) SNDCTL_DSP_GETOSPACE bug for SB16 (was: S

I'm not in the least experienced with sound card programming, and I
didn't get much LKML help on this issue, so please review and let me know
the result, if possible.

CC'd to Andrea, the original author of SB16 fullduplex support.

Thanks !

-- 
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germany

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sb16_conversion.diff"

diff -urN linux-2.4.18/drivers/sound/audio.c linux/drivers/sound/audio.c
--- linux-2.4.18/drivers/sound/audio.c	Sat Jun  1 16:42:43 2002
+++ linux/drivers/sound/audio.c	Sat Jun  1 17:11:05 2002
@@ -281,6 +281,11 @@
 			if(copy_from_user(dma_buf, &(buf)[p], l))
 				return -EFAULT;
 		} 
+		/* Warning: make sure the hardware driver's copy_user accepts
+		 * remainders resulting from odd data byte count input properly,
+		 * i.e. it doesn't leave us looping here e.g. with a constantly
+		 * rejected lone byte that it considers insufficient
+		 * for 16bit output (which needs 2 bytes/sample)... */
 		else audio_devs[dev]->d->copy_user (dev,
 						dma_buf, 0,
 						buf, p,
@@ -814,7 +819,22 @@
 				info.fragments = dmap->nbufs;
 
 			info.fragsize = dmap->fragment_size;
-			info.bytes = info.fragments * dmap->fragment_size;
+			info.bytes = info.fragments * info.fragsize;
+
+			if (dmap->flags & (DMA_CONV_16_8|DMA_CONV_8_16))
+			{ /* attention, sound card does 8/16bit conversion ! */
+			    if (dmap->flags & DMA_CONV_16_8)
+			    { /* 2 bytes input result in 1 byte in DMA only:
+			         need to receive *twice* the internal amount */
+				info.fragsize <<= 1;
+				info.bytes <<= 1;
+			    }
+			    else
+			    { /* 1 byte input -> 2 bytes DMA */
+				info.fragsize >>= 1;
+				info.bytes >>= 1;
+			    }
+			}
 
 			if (cmd == SNDCTL_DSP_GETISPACE && dmap->qlen)
 				info.bytes -= dmap->counts[dmap->qhead];
diff -urN linux-2.4.18/drivers/sound/dev_table.h linux/drivers/sound/dev_table.h
--- linux-2.4.18/drivers/sound/dev_table.h	Sat Jun  1 16:44:20 2002
+++ linux/drivers/sound/dev_table.h	Sat Jun  1 15:41:44 2002
@@ -101,6 +101,8 @@
 #define DMA_POST	0x00000100
 #define DMA_NODMA	0x00000200
 #define DMA_NOTIMEOUT	0x00000400
+#define DMA_CONV_16_8	0x00000800 /* SB16: 16bit -> 8bit conversion */
+#define DMA_CONV_8_16	0x00001000 /* SB16: 8bit -> 16bit conversion */
 
 	int      open_mode;
 
diff -urN linux-2.4.18/drivers/sound/sb_audio.c linux/drivers/sound/sb_audio.c
--- linux-2.4.18/drivers/sound/sb_audio.c	Sat Jun  1 16:46:55 2002
+++ linux/drivers/sound/sb_audio.c	Sat Jun  1 17:12:11 2002
@@ -20,6 +20,15 @@
  *                       Maybe other 16 bit cards in this code could behave
  *                       the same.
  * Chris Rankin:         Use spinlocks instead of CLI/STI
+ *
+ * SB16 comment, mostly by -aa:
+ * Since sb cards don't have two dma16 channels, when you playback data at 16
+ * bit the driver will convert data to 8bit and will play it with the dma8,
+ * allowing you to use the dma16 for recording at the same time. The patch
+ * isn't smart because it hardlock dma8 for playback of 16bit data and
+ * dma16 for playback of 8bit data, so with this patch applied, the sb
+ * driver will convert all 16bit data to 8bit even if dma16 isn't used
+ * for recording.
  */
 
 #include <linux/spinlock.h>
@@ -623,6 +632,15 @@
 			devc->bits = bits;
 		else
 			devc->bits = AFMT_U8;
+		if (devc->fullduplex)
+		{ /* set 8bit vs. 16bit conversion flags */
+			struct dma_buffparms *dmap = audio_devs[dev]->dmap_out;
+			dmap->flags &= ~(DMA_CONV_16_8|DMA_CONV_8_16);
+			if (devc->bits == AFMT_S16_LE)
+			    dmap->flags |= DMA_CONV_16_8;
+			else
+			    dmap->flags |= DMA_CONV_8_16;
+		}
 	}
 
 	return devc->bits;
@@ -858,9 +876,9 @@
 		/* 16 -> 8 */
 		/* max_in >> 1, max number of samples in ( 16 bits ) */
 		/* max_out, max number of samples out ( 8 bits ) */
-		/* len, number of samples that will be taken ( 16 bits )*/
-		/* c, count of samples remaining in buffer ( 16 bits )*/
-		/* p, count of samples already processed ( 16 bits )*/
+		/* len, number of samples that will be taken ( 16 bits ) */
+		/* c, count of samples remaining in buffer ( 16 bits ) */
+		/* p, count of samples already processed ( 16 bits ) */
 		len = ( (max_in >> 1) > max_out) ? max_out : (max_in >> 1);
 		c = len;
 		p = 0;
@@ -880,6 +898,12 @@
 		}
 		/* used = ( samples * 16 bits size ) */
 		*used = len << 1;
+		/* make sure to discard any remaining odd incoming byte count */
+		if (max_in & 1)
+		{
+			printk(KERN_ERR "got odd byte count for 16bit audio, discarding remainder\n");
+			(*used)++;
+		}
 		/* returned = ( samples * 8 bits size ) */
 		*returned = len;
 	}

--FkmkrVfFsRoUs1wW--
