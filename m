Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314223AbSESGPQ>; Sun, 19 May 2002 02:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSESGPP>; Sun, 19 May 2002 02:15:15 -0400
Received: from panda.sul.com.br ([200.219.150.4]:57866 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S314223AbSESGPI>;
	Sun, 19 May 2002 02:15:08 -0400
Date: Sat, 18 May 2002 21:14:39 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: [BKPATCH] OSS: Re: AUDIT of 2.5.15 copy_to/from_user
Message-ID: <20020519001439.GC4164@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au> <20020518225535.GA4101@conectiva.com.br> <20020518235418.GB4164@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 18, 2002 at 08:54:19PM -0300, Arnaldo C. Melo escreveu:
> Em Sat, May 18, 2002 at 07:55:35PM -0300, Arnaldo C. Melo escreveu:
> > Heads up: I'm finishing a bk changeset for intermezzo, will be submitting
> > to Linus in some minutes.
> 
> Second heads up:
> 
> OSS will be on its way to Linus in some minutes...

Here it is the OSS one... Linus, please consider pulling it from:

http://kernel-acme.bkbits.net:8080/oss-copy_tofrom_user-2.5

- Arnaldo

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.540   -> 1.540.1.1
#	   sound/oss/cmpci.c	1.12    -> 1.13   
#	  sound/oss/cs46xx.c	1.17    -> 1.18   
#	sound/oss/msnd_pinnacle.c	1.7     -> 1.8    
#	sound/oss/esssolo1.c	1.12    -> 1.13   
#	 sound/oss/ite8172.c	1.6     -> 1.7    
#	  sound/oss/es1371.c	1.11    -> 1.12   
#	sound/oss/gus_wave.c	1.4     -> 1.5    
#	sound/oss/sb_audio.c	1.3     -> 1.4    
#	sound/oss/via82cxxx_audio.c	1.20    -> 1.21   
#	 sound/oss/maestro.c	1.10    -> 1.11   
#	 sound/oss/rme96xx.c	1.6     -> 1.7    
#	 sound/oss/midibuf.c	1.3     -> 1.4    
#	sound/oss/sonicvibes.c	1.11    -> 1.12   
#	sound/oss/emu10k1/passthrough.c	1.4     -> 1.5    
#	  sound/oss/es1370.c	1.12    -> 1.13   
#	sound/oss/sequencer.c	1.2     -> 1.3    
#	   sound/oss/vwsnd.c	1.4     -> 1.5    
#	sound/oss/wavfront.c	1.10    -> 1.11   
#	sound/oss/emu10k1/cardwi.c	1.5     -> 1.6    
#	sound/oss/i810_audio.c	1.23    -> 1.24   
#	 sound/oss/trident.c	1.20    -> 1.21   
#	sound/oss/emu10k1/cardwo.c	1.6     -> 1.7    
#	sound/oss/maestro3.c	1.16    -> 1.17   
#	sound/oss/cs4281/cs4281m.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/19	acme@conectiva.com.br	1.541
# fs/intermezzo/ext_attr.c
# fs/intermezzo/kml.c
# fs/intermezzo/psdev.c
# 
# 	- fix copy_{to,from}_user error handling (thans to Rusty for pointing this out)
# --------------------------------------------
# 02/05/19	acme@conectiva.com.br	1.540.1.1
# drivers/sound/*.c
# 
# 	- fix copy_{to,from}_user error handling (thanks to Rusty for pointing this out)
# --------------------------------------------
#
diff -Nru a/sound/oss/cmpci.c b/sound/oss/cmpci.c
--- a/sound/oss/cmpci.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/cmpci.c	Sun May 19 03:08:22 2002
@@ -2032,7 +2032,9 @@
 		if (s->dma_adc.mapped)
 			s->dma_adc.count &= s->dma_adc.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -2049,7 +2051,9 @@
 				s->dma_adc.count &= s->dma_adc.fragsize-1;
 		}
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
diff -Nru a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
--- a/sound/oss/cs4281/cs4281m.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/cs4281/cs4281m.c	Sun May 19 03:08:22 2002
@@ -3496,7 +3496,9 @@
 		if (s->dma_adc.mapped)
 			s->dma_adc.count &= s->dma_adc.fragsize - 1;
 		spin_unlock_irqrestore(&s->lock, flags);
-		return copy_to_user((void *) arg, &cinfo, sizeof(cinfo));
+		if (copy_to_user((void *) arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
 	case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -3520,7 +3522,9 @@
 		if (s->dma_dac.mapped)
 			s->dma_dac.count &= s->dma_dac.fragsize - 1;
 		spin_unlock_irqrestore(&s->lock, flags);
-		return copy_to_user((void *) arg, &cinfo, sizeof(cinfo));
+		if (copy_to_user((void *) arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
 	case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
diff -Nru a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/cs46xx.c	Sun May 19 03:08:22 2002
@@ -2965,7 +2965,9 @@
 			cinfo.blocks = dmabuf->count/dmabuf->divisor >> dmabuf->fragshift;
 			cinfo.ptr = dmabuf->hwptr/dmabuf->divisor;
 			spin_unlock_irqrestore(&state->card->lock, flags);
-			return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+			if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+				return -EFAULT;
+			return 0;
 		}
 		return -ENODEV;
 
@@ -2998,7 +3000,9 @@
 			    "cs46xx: GETOPTR bytes=%d blocks=%d ptr=%d\n",
 				cinfo.bytes,cinfo.blocks,cinfo.ptr) );
 			spin_unlock_irqrestore(&state->card->lock, flags);
-			return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+			if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+				return -EFAULT;
+			return 0;
 		}
 		return -ENODEV;
 
diff -Nru a/sound/oss/emu10k1/cardwi.c b/sound/oss/emu10k1/cardwi.c
--- a/sound/oss/emu10k1/cardwi.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/emu10k1/cardwi.c	Sun May 19 03:08:22 2002
@@ -304,9 +304,10 @@
 
 static void copy_block(u8 *dst, u8 * src, u32 str, u32 len, u8 cov)
 {
-	if (cov == 1)
-		__copy_to_user(dst, src + str, len);
-	else {
+	if (cov == 1) {
+		if (__copy_to_user(dst, src + str, len))
+			return;
+	} else {
 		u8 byte;
 		u32 i;
 
@@ -314,7 +315,8 @@
 
 		for (i = 0; i < len; i++) {
 			byte = src[2 * i] ^ 0x80;
-			__copy_to_user(dst + i, &byte, 1);
+			if (__copy_to_user(dst + i, &byte, 1))
+				return;
 		}
 	}
 }
diff -Nru a/sound/oss/emu10k1/cardwo.c b/sound/oss/emu10k1/cardwo.c
--- a/sound/oss/emu10k1/cardwo.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/emu10k1/cardwo.c	Sun May 19 03:08:22 2002
@@ -483,14 +483,17 @@
 
 	if (len > PAGE_SIZE - pgoff) {
 		k = PAGE_SIZE - pgoff;
-		__copy_from_user((u8 *)dst[pg] + pgoff, src, k);
+		if (__copy_from_user((u8 *)dst[pg] + pgoff, src, k))
+			return;
 		len -= k;
 		while (len > PAGE_SIZE) {
-			__copy_from_user(dst[++pg], src + k, PAGE_SIZE);
+			if (__copy_from_user(dst[++pg], src + k, PAGE_SIZE))
+				return;
 			k += PAGE_SIZE;
 			len -= PAGE_SIZE;
 		}
-		__copy_from_user(dst[++pg], src + k, len);
+		if (__copy_from_user(dst[++pg], src + k, len))
+			return;
 
 	} else
 		__copy_from_user((u8 *)dst[pg] + pgoff, src, len);
@@ -515,7 +518,8 @@
 
 	while (len) { 
 		for (voice_num = 0; voice_num < woinst->num_voices; voice_num++) {
-			__copy_from_user((u8 *)(mem[voice_num].addr[pg]) + pgoff, src, woinst->format.bytespervoicesample);
+			if (__copy_from_user((u8 *)(mem[voice_num].addr[pg]) + pgoff, src, woinst->format.bytespervoicesample))
+				return;
 			src += woinst->format.bytespervoicesample;
 		}
 
diff -Nru a/sound/oss/emu10k1/passthrough.c b/sound/oss/emu10k1/passthrough.c
--- a/sound/oss/emu10k1/passthrough.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/emu10k1/passthrough.c	Sun May 19 03:08:22 2002
@@ -165,12 +165,15 @@
 
 		DPD(3, "prepend size %d, prepending %d bytes\n", pt->prepend_size, needed);
 		if (count < needed) {
-			copy_from_user(pt->buf + pt->prepend_size, buffer, count);
+			if (copy_from_user(pt->buf + pt->prepend_size, buffer,
+					   count))
+				return -EFAULT;
 			pt->prepend_size += count;
 			DPD(3, "prepend size now %d\n", pt->prepend_size);
 			return count;
 		}
-		copy_from_user(pt->buf + pt->prepend_size, buffer, needed);
+		if (copy_from_user(pt->buf + pt->prepend_size, buffer, needed))
+			return -EFAULT;
 		r = pt_putblock(wave_dev, (u16 *) pt->buf, nonblock);
 		if (r)
 			return r;
@@ -181,7 +184,8 @@
 	blocks_copied = 0;
 	while (blocks > 0) {
 		u16 *bufptr = (u16 *) buffer + (bytes_copied/2);
-		copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE);
+		if (copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE))
+			return -EFAULT;
 		bufptr = (u16 *) pt->buf;
 		r = pt_putblock(wave_dev, bufptr, nonblock);
 		if (r) {
@@ -197,7 +201,8 @@
 	i = count - bytes_copied;
 	if (i) {
 		pt->prepend_size = i;
-		copy_from_user(pt->buf, buffer + bytes_copied, i);
+		if (copy_from_user(pt->buf, buffer + bytes_copied, i))
+			return -EFAULT;
 		bytes_copied += i;
 		DPD(3, "filling prepend buffer with %d bytes", i);
 	}
diff -Nru a/sound/oss/es1370.c b/sound/oss/es1370.c
--- a/sound/oss/es1370.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/es1370.c	Sun May 19 03:08:22 2002
@@ -1635,7 +1635,9 @@
 		if (s->dma_adc.mapped)
 			s->dma_adc.count &= s->dma_adc.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -1653,7 +1655,9 @@
 		if (s->dma_dac2.mapped)
 			s->dma_dac2.count &= s->dma_dac2.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
@@ -2112,7 +2116,9 @@
 		if (s->dma_dac1.mapped)
 			s->dma_dac1.count &= s->dma_dac1.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETBLKSIZE:
 		if ((val = prog_dmabuf_dac1(s)))
diff -Nru a/sound/oss/es1371.c b/sound/oss/es1371.c
--- a/sound/oss/es1371.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/es1371.c	Sun May 19 03:08:22 2002
@@ -1824,7 +1824,9 @@
 		if (s->dma_adc.mapped)
 			s->dma_adc.count &= s->dma_adc.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -1842,8 +1844,9 @@
 		if (s->dma_dac2.mapped)
 			s->dma_dac2.count &= s->dma_dac2.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
-
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
         case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
 			if ((val = prog_dmabuf_dac2(s)))
@@ -2292,7 +2295,9 @@
 		if (s->dma_dac1.mapped)
 			s->dma_dac1.count &= s->dma_dac1.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETBLKSIZE:
 		if ((val = prog_dmabuf_dac1(s)))
diff -Nru a/sound/oss/esssolo1.c b/sound/oss/esssolo1.c
--- a/sound/oss/esssolo1.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/esssolo1.c	Sun May 19 03:08:22 2002
@@ -1468,7 +1468,9 @@
 		if (s->dma_adc.mapped)
 			s->dma_adc.count &= s->dma_adc.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -1492,7 +1494,9 @@
 		       cinfo.bytes, cinfo.blocks, cinfo.ptr, s->dma_dac.buforder, s->dma_dac.numfrag, s->dma_dac.fragshift,
 		       s->dma_dac.swptr, s->dma_dac.count, s->dma_dac.fragsize, s->dma_dac.dmasize, s->dma_dac.fragsamples);
 #endif
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
diff -Nru a/sound/oss/gus_wave.c b/sound/oss/gus_wave.c
--- a/sound/oss/gus_wave.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/gus_wave.c	Sun May 19 03:08:22 2002
@@ -1719,7 +1719,9 @@
 	 * been transferred already.
 	 */
 
-	copy_from_user(&((char *) &patch)[offs], &(addr)[offs], sizeof_patch - offs);
+	if (copy_from_user(&((char *) &patch)[offs], &(addr)[offs],
+			   sizeof_patch - offs))
+		return -EFAULT;
 
 	if (patch.mode & WAVE_ROM)
 		return -EINVAL;
@@ -1864,7 +1866,10 @@
 			 * OK, move now. First in and then out.
 			 */
 
-			copy_from_user(audio_devs[gus_devnum]->dmap_out->raw_buf, &(addr)[sizeof_patch + src_offs], blk_sz);
+			if (copy_from_user(audio_devs[gus_devnum]->dmap_out->raw_buf,
+					   &(addr)[sizeof_patch + src_offs],
+					   blk_sz))
+				return -EFAULT;
 
 			save_flags(flags);
 			cli();
diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/i810_audio.c	Sun May 19 03:08:22 2002
@@ -2020,7 +2020,9 @@
 		printk("SNDCTL_DSP_GETOPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
-		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+		if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
@@ -2059,8 +2061,9 @@
 		printk("SNDCTL_DSP_GETIPTR %d, %d, %d, %d\n", cinfo.bytes,
 			cinfo.blocks, cinfo.ptr, dmabuf->count);
 #endif
-		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
-
+		if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 	case SNDCTL_DSP_NONBLOCK:
 #ifdef DEBUG
 		printk("SNDCTL_DSP_NONBLOCK\n");
diff -Nru a/sound/oss/ite8172.c b/sound/oss/ite8172.c
--- a/sound/oss/ite8172.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/ite8172.c	Sun May 19 03:08:22 2002
@@ -1427,7 +1427,9 @@
 	if (count < 0)
 	    count = 0;
 	cinfo.blocks = count >> s->dma_adc.fragshift;
-	return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+	if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+		return -EFAULT;
+	return 0;
 
     case SNDCTL_DSP_GETOPTR:
 	if (!(file->f_mode & FMODE_READ))
@@ -1448,7 +1450,9 @@
 	if (count < 0)
 	    count = 0;
 	cinfo.blocks = count >> s->dma_dac.fragshift;
-	return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+	if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+		return -EFAULT;
+	return 0;
 
     case SNDCTL_DSP_GETBLKSIZE:
 	if (file->f_mode & FMODE_WRITE)
diff -Nru a/sound/oss/maestro.c b/sound/oss/maestro.c
--- a/sound/oss/maestro.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/maestro.c	Sun May 19 03:08:22 2002
@@ -2756,7 +2756,9 @@
 		if (s->dma_adc.mapped)
 			s->dma_adc.count &= s->dma_adc.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -2771,7 +2773,9 @@
 		if (s->dma_dac.mapped)
 			s->dma_dac.count &= s->dma_dac.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
diff -Nru a/sound/oss/maestro3.c b/sound/oss/maestro3.c
--- a/sound/oss/maestro3.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/maestro3.c	Sun May 19 03:08:22 2002
@@ -1805,7 +1805,9 @@
         if (s->dma_adc.mapped)
             s->dma_adc.count &= s->dma_adc.fragsize-1;
         spin_unlock_irqrestore(&s->lock, flags);
-        return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+        if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+		return -EFAULT;
+	return 0;
 
     case SNDCTL_DSP_GETOPTR:
         if (!(file->f_mode & FMODE_WRITE))
@@ -1818,7 +1820,9 @@
         if (s->dma_dac.mapped)
             s->dma_dac.count &= s->dma_dac.fragsize-1;
         spin_unlock_irqrestore(&s->lock, flags);
-        return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+        if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+		return -EFAULT;
+	return 0;
 
     case SNDCTL_DSP_GETBLKSIZE:
         if (file->f_mode & FMODE_WRITE) {
diff -Nru a/sound/oss/midibuf.c b/sound/oss/midibuf.c
--- a/sound/oss/midibuf.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/midibuf.c	Sun May 19 03:08:22 2002
@@ -290,15 +290,15 @@
 				 */
 
 			if (file->f_flags & O_NONBLOCK) {
-				restore_flags(flags);
-				return -EAGAIN;
+				c = -EAGAIN;
+				goto out;
 			}
 
 			interruptible_sleep_on(&midi_sleeper[dev]);
 			if (signal_pending(current)) 
 			{
-				restore_flags(flags);
-				return -EINTR;
+				c = -EINTR;
+				goto out;
 			}
 			n = SPACE_AVAIL(midi_out_buf[dev]);
 		}
@@ -308,11 +308,15 @@
 		for (i = 0; i < n; i++)
 		{
 			/* BROKE BROKE BROKE - CANT DO THIS WITH CLI !! */
-			copy_from_user((char *) &tmp_data, &(buf)[c], 1);
+			if (copy_from_user((char *) &tmp_data, &(buf)[c], 1)) {
+				c = -EFAULT;
+				goto out;
+			}
 			QUEUE_BYTE(midi_out_buf[dev], tmp_data);
 			c++;
 		}
 	}
+out:
 	restore_flags(flags);
 	return c;
 }
@@ -333,8 +337,8 @@
 						 * No data yet, wait
 						 */
  		if (file->f_flags & O_NONBLOCK) {
- 			restore_flags(flags);
- 			return -EAGAIN;
+ 			c = -EAGAIN;
+			goto out;
  		}
 		interruptible_sleep_on_timeout(&input_sleeper[dev],
 					       parms[dev].prech_timeout);
@@ -357,10 +361,14 @@
 			REMOVE_BYTE(midi_in_buf[dev], tmp_data);
 			fixit = (char *) &tmp_data;
 			/* BROKE BROKE BROKE */
-			copy_to_user(&(buf)[c], fixit, 1);
+			if (copy_to_user(&(buf)[c], fixit, 1)) {
+				c = -EFAULT;
+				goto out;
+			}
 			c++;
 		}
 	}
+out:
 	restore_flags(flags);
 	return c;
 }
diff -Nru a/sound/oss/msnd_pinnacle.c b/sound/oss/msnd_pinnacle.c
--- a/sound/oss/msnd_pinnacle.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/msnd_pinnacle.c	Sun May 19 03:08:22 2002
@@ -564,11 +564,15 @@
 		mixer_info info;
 		set_mixer_info();
 		info.modify_counter = dev.mixer_mod_count;
-		return copy_to_user((void *)arg, &info, sizeof(info));
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
 	} else if (cmd == SOUND_OLD_MIXER_INFO) {
 		_old_mixer_info info;
 		set_mixer_info();
-		return copy_to_user((void *)arg, &info, sizeof(info));
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
 	} else if (cmd == SOUND_MIXER_PRIVATE1) {
 		dev.nresets = 0;
 		dsp_full_reset();
diff -Nru a/sound/oss/rme96xx.c b/sound/oss/rme96xx.c
--- a/sound/oss/rme96xx.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/rme96xx.c	Sun May 19 03:08:22 2002
@@ -1083,7 +1083,9 @@
 			dma->readptr &= s->fragsize<<1;
 		spin_unlock_irqrestore(&s->lock,flags);
 
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_READ))
@@ -1100,7 +1102,9 @@
 		if (dma->mmapped)
 			dma->writeptr &= s->fragsize<<1;
 		spin_unlock_irqrestore(&s->lock,flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
         case SNDCTL_DSP_GETBLKSIZE:
 	     return put_user(s->fragsize, (int *)arg);
 
@@ -1520,7 +1524,8 @@
 	VALIDATE_STATE(s);
 	if (cmd == SOUND_MIXER_PRIVATE1) {
 		rme_mixer mixer;
-		copy_from_user(&mixer,(void*)arg,sizeof(mixer));
+		if (copy_from_user(&mixer,(void*)arg,sizeof(mixer)))
+			return -EFAULT;
 		
 		if (file->f_mode & FMODE_WRITE) {
 		     s->dma[mixer.devnr].outoffset = mixer.o_offset;
@@ -1537,7 +1542,8 @@
 	}
 	if (cmd == SOUND_MIXER_PRIVATE3) {
 	     u32 control;
-	     copy_from_user(&control,(void*)arg,sizeof(control)); 
+	     if (copy_from_user(&control,(void*)arg,sizeof(control)))
+		     return -EFAULT;
 	     if (file->f_mode & FMODE_WRITE) {
 		  s->control_register = control;
 		  writel(control,s->iobase + RME96xx_control_register);
diff -Nru a/sound/oss/sb_audio.c b/sound/oss/sb_audio.c
--- a/sound/oss/sb_audio.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/sb_audio.c	Sun May 19 03:08:22 2002
@@ -849,7 +849,9 @@
 	/* if not duplex no conversion */
 	if (!devc->fullduplex)
 	{
-		copy_from_user (localbuf + localoffs, userbuf + useroffs, len);
+		if (copy_from_user(localbuf + localoffs,
+				   userbuf + useroffs, len))
+			return -EFAULT;
 		*used = len;
 		*returned = len;
 	}
@@ -869,9 +871,10 @@
 		{
 			locallen = (c >= LBUFCOPYSIZE ? LBUFCOPYSIZE : c);
 			/* << 1 in order to get 16 bit samples */
-			copy_from_user (lbuf16,
-					userbuf+useroffs + (p << 1),
-					locallen << 1);
+			if (copy_from_user(lbuf16,
+					   userbuf + useroffs + (p << 1),
+					   locallen << 1))
+				return -EFAULT;
 			for (i = 0; i < locallen; i++)
 			{
 				buf8[p+i] = ~((lbuf16[i] >> 8) & 0xff) ^ 0x80;
@@ -898,9 +901,10 @@
 		while (c)
 		{
 			locallen = (c >= LBUFCOPYSIZE ? LBUFCOPYSIZE : c);
-			copy_from_user (lbuf8,
-					userbuf+useroffs + p,
-					locallen);
+			if (copy_from_user(lbuf8,
+					   userbuf+useroffs + p,
+					   locallen))
+				return -EFAULT;
 			for (i = 0; i < locallen; i++)
 			{
 				buf16[p+i] = (~lbuf8[i] ^ 0x80) << 8;
diff -Nru a/sound/oss/sequencer.c b/sound/oss/sequencer.c
--- a/sound/oss/sequencer.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/sequencer.c	Sun May 19 03:08:22 2002
@@ -116,13 +116,15 @@
 	while (iqlen && c >= ev_len)
 	{
 		char *fixit = (char *) &iqueue[iqhead * IEV_SZ];
-		copy_to_user(&(buf)[p], fixit, ev_len);
+		if (copy_to_user(&(buf)[p], fixit, ev_len))
+			goto out;
 		p += ev_len;
 		c -= ev_len;
 
 		iqhead = (iqhead + 1) % SEQ_MAX_QUEUE;
 		iqlen--;
 	}
+out:
 	restore_flags(flags);
 	return count - c;
 }
@@ -226,7 +228,8 @@
 
 	while (c >= 4)
 	{
-		copy_from_user((char *) event_rec, &(buf)[p], 4);
+		if (copy_from_user((char *) event_rec, &(buf)[p], 4))
+			goto out;
 		ev_code = event_rec[0];
 
 		if (ev_code == SEQ_FULLSIZE)
@@ -262,7 +265,9 @@
 					seq_startplay();
 				return count - c;
 			}
-			copy_from_user((char *) &event_rec[4], &(buf)[p + 4], 4);
+			if (copy_from_user((char *)&event_rec[4],
+					   &(buf)[p + 4], 4))
+				goto out;
 
 		}
 		else
@@ -320,7 +325,7 @@
 
 	if (!seq_playing)
 		seq_startplay();
-
+out:
 	return count;
 }
 
diff -Nru a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
--- a/sound/oss/sonicvibes.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/sonicvibes.c	Sun May 19 03:08:22 2002
@@ -1802,7 +1802,9 @@
 		if (s->dma_adc.mapped)
 			s->dma_adc.count &= s->dma_adc.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -1820,7 +1822,9 @@
 		if (s->dma_dac.mapped)
 			s->dma_dac.count &= s->dma_dac.fragsize-1;
 		spin_unlock_irqrestore(&s->lock, flags);
-                return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+                if (copy_to_user((void *)arg, &cinfo, sizeof(cinfo)))
+			return -EFAULT;
+		return 0;
 
         case SNDCTL_DSP_GETBLKSIZE:
 		if (file->f_mode & FMODE_WRITE) {
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/trident.c	Sun May 19 03:08:22 2002
@@ -2447,7 +2447,8 @@
 		if (dmabuf->mapped)
 			dmabuf->count &= dmabuf->fragsize-1;
 		spin_unlock_irqrestore(&state->card->lock, flags);
-		ret = copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
+		ret = copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ?
+				-EFAULT : 0;
 		break;
 
 	case SNDCTL_DSP_GETOPTR:
diff -Nru a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
--- a/sound/oss/via82cxxx_audio.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/via82cxxx_audio.c	Sun May 19 03:08:22 2002
@@ -2526,7 +2526,7 @@
 		info.fragments,
 		info.bytes);
 
-	return copy_to_user (arg, &info, sizeof (info));
+	return copy_to_user(arg, &info, sizeof (info)) ? -EFAULT : 0;
 }
 
 
@@ -2570,7 +2570,7 @@
 		info.blocks,
 		info.ptr);
 
-	return copy_to_user (arg, &info, sizeof (info));
+	return copy_to_user(arg, &info, sizeof (info)) ? -EFAULT : 0;
 }
 
 
diff -Nru a/sound/oss/vwsnd.c b/sound/oss/vwsnd.c
--- a/sound/oss/vwsnd.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/vwsnd.c	Sun May 19 03:08:22 2002
@@ -2303,7 +2303,8 @@
 		if (nb > count)
 			nb = count;
 		DBGPV("nb = %d\n", nb);
-		copy_to_user(buffer, rport->swbuf + rport->swb_u_idx, nb);
+		if (copy_to_user(buffer, rport->swbuf + rport->swb_u_idx, nb))
+			return -EFAULT;
 		(void) swb_inc_u(rport, nb);
 		buffer += nb;
 		count -= nb;
@@ -2377,7 +2378,8 @@
 		if (nb > count)
 			nb = count;
 		DBGPV("nb = %d\n", nb);
-		copy_from_user(wport->swbuf + wport->swb_u_idx, buffer, nb);
+		if (copy_from_user(wport->swbuf + wport->swb_u_idx, buffer, nb))
+			return -EFAULT;
 		pcm_output(devc, 0, nb);
 		buffer += nb;
 		count -= nb;
@@ -2650,7 +2652,9 @@
 		DBGXV("SNDCTL_DSP_GETOSPACE returns { %d %d %d %d }\n",
 		     buf_info.fragments, buf_info.fragstotal,
 		     buf_info.fragsize, buf_info.bytes);
-		return copy_to_user((void *) arg, &buf_info, sizeof buf_info);
+		if (copy_to_user((void *) arg, &buf_info, sizeof buf_info))
+			return -EFAULT;
+		return 0;
 
 	case SNDCTL_DSP_GETISPACE:	/* _SIOR ('P',13, audio_buf_info) */
 		DBGX("SNDCTL_DSP_GETISPACE\n");
@@ -2667,7 +2671,9 @@
 		DBGX("SNDCTL_DSP_GETISPACE returns { %d %d %d %d }\n",
 		     buf_info.fragments, buf_info.fragstotal,
 		     buf_info.fragsize, buf_info.bytes);
-		return copy_to_user((void *) arg, &buf_info, sizeof buf_info);
+		if (copy_to_user((void *) arg, &buf_info, sizeof buf_info))
+			return -EFAULT;
+		return 0;
 
 	case SNDCTL_DSP_NONBLOCK:	/* _SIO  ('P',14) */
 		DBGX("SNDCTL_DSP_NONBLOCK\n");
@@ -2725,7 +2731,9 @@
 			rport->frag_count = 0;
 		}
 		spin_unlock_irqrestore(&rport->lock, flags);
-		return copy_to_user((void *) arg, &info, sizeof info);
+		if (copy_to_user((void *) arg, &info, sizeof info))
+			return -EFAULT;
+		return 0;
 
 	case SNDCTL_DSP_GETOPTR:	/* _SIOR ('P',18, count_info) */
 		DBGX("SNDCTL_DSP_GETOPTR\n");
@@ -2747,7 +2755,9 @@
 			wport->frag_count = 0;
 		}
 		spin_unlock_irqrestore(&wport->lock, flags);
-		return copy_to_user((void *) arg, &info, sizeof info);
+		if (copy_to_user((void *) arg, &info, sizeof info))
+			return -EFAULT;
+		return 0;
 
 	case SNDCTL_DSP_GETODELAY:	/* _SIOR ('P', 23, int) */
 		DBGX("SNDCTL_DSP_GETODELAY\n");
diff -Nru a/sound/oss/wavfront.c b/sound/oss/wavfront.c
--- a/sound/oss/wavfront.c	Sun May 19 03:08:22 2002
+++ b/sound/oss/wavfront.c	Sun May 19 03:08:22 2002
@@ -1525,8 +1525,9 @@
 	/* Copy in the header of the GUS patch */
 
 	sizeof_patch = (long) &guspatch.data[0] - (long) &guspatch; 
-	copy_from_user (&((char *) &guspatch)[offs],
-			&(addr)[offs], sizeof_patch - offs);
+	if (copy_from_user(&((char *) &guspatch)[offs],
+			   &(addr)[offs], sizeof_patch - offs))
+		return -EFAULT;
 
 	if ((i = wavefront_find_free_patch ()) == -1) {
 		return -EBUSY;
@@ -1662,7 +1663,7 @@
 	if (copy_from_user (&header, addr, sizeof(wavefront_patch_info) -
 			    sizeof(wavefront_any))) {
 		printk (KERN_WARNING LOGNAME "bad address for load patch.\n");
-		return -(EINVAL);
+		return -EFAULT;
 	}
 
 	DPRINT (WF_DEBUG_LOAD_PATCH, "download "
@@ -1676,47 +1677,53 @@
 	switch (header.subkey) {
 	case WF_ST_SAMPLE:  /* sample or sample_header, based on patch->size */
 
-		copy_from_user ((unsigned char *) &header.hdr.s,
-				(unsigned char *) header.hdrptr,
-				sizeof (wavefront_sample));
+		if (copy_from_user((unsigned char *) &header.hdr.s,
+				   (unsigned char *) header.hdrptr,
+				   sizeof (wavefront_sample)))
+			return -EFAULT;
 
 		return wavefront_send_sample (&header, header.dataptr, 0);
 
 	case WF_ST_MULTISAMPLE:
 
-		copy_from_user ((unsigned char *) &header.hdr.s,
-				(unsigned char *) header.hdrptr,
-				sizeof (wavefront_multisample));
+		if (copy_from_user((unsigned char *) &header.hdr.s,
+				   (unsigned char *) header.hdrptr,
+				   sizeof(wavefront_multisample)))
+			return -EFAULT;
 
 		return wavefront_send_multisample (&header);
 
 
 	case WF_ST_ALIAS:
 
-		copy_from_user ((unsigned char *) &header.hdr.a,
-				(unsigned char *) header.hdrptr,
-				sizeof (wavefront_alias));
+		if (copy_from_user((unsigned char *) &header.hdr.a,
+				   (unsigned char *) header.hdrptr,
+				   sizeof (wavefront_alias)))
+			return -EFAULT;
 
 		return wavefront_send_alias (&header);
 
 	case WF_ST_DRUM:
-		copy_from_user ((unsigned char *) &header.hdr.d, 
-				(unsigned char *) header.hdrptr,
-				sizeof (wavefront_drum));
+		if (copy_from_user((unsigned char *) &header.hdr.d, 
+				   (unsigned char *) header.hdrptr,
+				   sizeof (wavefront_drum)))
+			return -EFAULT;
 
 		return wavefront_send_drum (&header);
 
 	case WF_ST_PATCH:
-		copy_from_user ((unsigned char *) &header.hdr.p, 
-				(unsigned char *) header.hdrptr,
-				sizeof (wavefront_patch));
+		if (copy_from_user((unsigned char *) &header.hdr.p, 
+				   (unsigned char *) header.hdrptr,
+				   sizeof (wavefront_patch)))
+			return -EFAULT;
 
 		return wavefront_send_patch (&header);
 
 	case WF_ST_PROGRAM:
-		copy_from_user ((unsigned char *) &header.hdr.pr, 
-				(unsigned char *) header.hdrptr,
-				sizeof (wavefront_program));
+		if (copy_from_user((unsigned char *) &header.hdr.pr, 
+				   (unsigned char *) header.hdrptr,
+				   sizeof (wavefront_program)))
+			return -EFAULT;
 
 		return wavefront_send_program (&header);
 
@@ -1931,10 +1938,12 @@
 	switch (cmd) {
 
 	case WFCTL_WFCMD:
-		copy_from_user (&wc, (void *) arg, sizeof (wc));
+		if (copy_from_user(&wc, (void *) arg, sizeof (wc)))
+			return -EFAULT;
 		
 		if ((err = wavefront_synth_control (cmd, &wc)) == 0) {
-			copy_to_user ((void *) arg, &wc, sizeof (wc));
+			if (copy_to_user ((void *) arg, &wc, sizeof (wc)))
+				return -EFAULT;
 		}
 
 		return err;
@@ -2995,8 +3004,10 @@
 					"> 255 bytes to FX\n");
 				return -(EINVAL);
 			}
-			copy_from_user (page_data, (unsigned char *) r->data[3],
-					r->data[2]);
+			if (copy_from_user(page_data,
+					   (unsigned char *)r->data[3],
+					   r->data[2]))
+				return -EFAULT;
 			pd = page_data;
 		}
 
