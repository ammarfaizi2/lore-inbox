Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130356AbQK3Qlq>; Thu, 30 Nov 2000 11:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129539AbQK3Qlh>; Thu, 30 Nov 2000 11:41:37 -0500
Received: from goliath.siemens.de ([194.138.37.131]:45763 "EHLO
        goliath.siemens.de") by vger.kernel.org with ESMTP
        id <S130425AbQK3QlY>; Thu, 30 Nov 2000 11:41:24 -0500
X-Envelope-Sender-Is: tjeerd.mulder@fujitsu-siemens.com (at relayer goliath.siemens.de)
Message-ID: <3A267BB1.FEE196EA@fujitsu-siemens.com>
Date: Thu, 30 Nov 2000 17:09:21 +0100
From: Tjeerd Mulder <tjeerd.mulder@fujitsu-siemens.com>
X-Mailer: Mozilla 4.05 [de] (Win95; I)
MIME-Version: 1.0
To: torvalds@transmeta.com, sailer@ife.ee.ethz.ch,
        linux-kernel@vger.kernel.org
Subject: [PATCH]: 2.4.0-test11: sound drivers, again
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In http://www.cs.helsinki.fi/linux/linux-kernel/2000-47/0343.html
Thomas Sailer posted a patch to some ac97 sound drivers.
Because this patch is not in 2.4.0-test12-pre2 I post the same
patch again with some additions where the same bug does occur.

The bug is that dma buffer are not yet allocated, leading to
division by zero (dma buffer size).

kscdmagic triggers the bug because it does a ioctl GETIPTR
before ever reading from the device. The read would have allocated
the dma buffer.

The i810_audio driver is not included in this patch because I
have a seperate patch for that with a few more bug fixes.

I tested the maestro, cs4281, esssolo1, sonicvibes drivers:
of these the sonicvibes worked, the solo1 could only output,
the cs4281 failed to initialize its hardware and the maestro
crashed my system, and that is NOT due to this patch !

diff -u --recursive linux-2.4.0-test11-org/drivers/sound/cmpci.c linux-2.4.0-test11-clean/drivers/sound/cmpci.c
--- linux-2.4.0-test11-org/drivers/sound/cmpci.c	Thu Nov 16 21:51:28 2000
+++ linux-2.4.0-test11-clean/drivers/sound/cmpci.c	Thu Nov 30 14:22:11 2000
@@ -1373,10 +1373,17 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac.ready && prog_dmabuf(s, 0))
+			return 0;
 		poll_wait(file, &s->dma_dac.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf(s, 1))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
+
 	spin_lock_irqsave(&s->lock, flags);
 	cm_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -1604,8 +1611,8 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!(s->enable & CM_CENABLE_PE) && (val = prog_dmabuf(s, 0)) != 0)
-			return val;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		cm_update_ptr(s);
 		abinfo.fragsize = s->dma_dac.fragsize;
@@ -1618,8 +1625,8 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!(s->enable & CM_CENABLE_RE) && (val = prog_dmabuf(s, 1)) != 0)
-			return val;
+		if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		cm_update_ptr(s);
 		abinfo.fragsize = s->dma_adc.fragsize;
@@ -1636,6 +1643,8 @@
         case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		cm_update_ptr(s);
                 val = s->dma_dac.count;
@@ -1645,6 +1654,8 @@
         case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		cm_update_ptr(s);
                 cinfo.bytes = s->dma_adc.total_bytes;
@@ -1658,6 +1669,8 @@
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		cm_update_ptr(s);
                 cinfo.bytes = s->dma_dac.total_bytes;
diff -u --recursive linux-2.4.0-test11-org/drivers/sound/cs4281.c linux-2.4.0-test11-clean/drivers/sound/cs4281.c
--- linux-2.4.0-test11-org/drivers/sound/cs4281.c	Thu Nov 16 21:51:28 2000
+++ linux-2.4.0-test11-clean/drivers/sound/cs4281.c	Thu Nov 30 14:22:11 2000
@@ -2489,14 +2489,19 @@
 		CS_DBGOUT(CS_FUNCTION | CS_WAVE_WRITE | CS_WAVE_READ, 4,
 			  printk(KERN_INFO
 				 "cs4281: cs4281_poll() wait on FMODE_WRITE\n"));
+		if (!s->dma_dac.ready && prog_dmabuf_dac(s))
+			return 0;
 		poll_wait(file, &s->dma_dac.wait, wait);
 	}
 	if (file->f_mode & FMODE_READ) {
 		CS_DBGOUT(CS_FUNCTION | CS_WAVE_WRITE | CS_WAVE_READ, 4,
 			  printk(KERN_INFO
 				 "cs4281: cs4281_poll() wait on FMODE_READ\n"));
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
 	}
+
 	spin_lock_irqsave(&s->lock, flags);
 	cs4281_update_ptr(s);
 	if (file->f_mode & FMODE_WRITE) {
@@ -2516,8 +2521,8 @@
 	} else if (file->f_mode & FMODE_READ) {
 		if (s->dma_adc.mapped) {
 			if (s->dma_adc.count >=
-			    (signed) s->dma_adc.fragsize) mask |=
-				    POLLIN | POLLRDNORM;
+			    (signed) s->dma_adc.fragsize)
+				mask |= POLLIN | POLLRDNORM;
 		} else {
 			if (s->dma_adc.count > 0)
 				mask |= POLLIN | POLLRDNORM;
@@ -2836,8 +2841,7 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!(s->ena & FMODE_WRITE)
-		    && (val = prog_dmabuf_dac(s)) != 0)
+		if (!s->dma_adc.ready && (val = prog_dmabuf_adc(s)))
 			return val;
 		spin_lock_irqsave(&s->lock, flags);
 		cs4281_update_ptr(s);
@@ -2865,8 +2869,8 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!(s->ena & FMODE_READ)
-		    && (val = prog_dmabuf_adc(s)) != 0) return val;
+		if (!s->dma_dac.ready && (val = prog_dmabuf_dac(s)))
+			return val;
 		spin_lock_irqsave(&s->lock, flags);
 		cs4281_update_ptr(s);
 		if (s->conversion) {
@@ -2893,6 +2897,8 @@
 	case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_adc.ready && (val = prog_dmabuf_adc(s)))
+			return val;
 		spin_lock_irqsave(&s->lock, flags);
 		cs4281_update_ptr(s);
 		val = s->dma_dac.count;
@@ -2902,6 +2908,8 @@
 	case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (val = prog_dmabuf_dac(s)))
+			return val;
 		spin_lock_irqsave(&s->lock, flags);
 		cs4281_update_ptr(s);
 		cinfo.bytes = s->dma_adc.total_bytes;
@@ -2933,6 +2941,8 @@
 	case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_adc.ready && (val = prog_dmabuf_adc(s)))
+			return val;
 		spin_lock_irqsave(&s->lock, flags);
 		cs4281_update_ptr(s);
 		cinfo.bytes = s->dma_dac.total_bytes;
diff -u --recursive linux-2.4.0-test11-org/drivers/sound/cs46xx.c linux-2.4.0-test11-clean/drivers/sound/cs46xx.c
--- linux-2.4.0-test11-org/drivers/sound/cs46xx.c	Sun Nov 12 03:33:13 2000
+++ linux-2.4.0-test11-clean/drivers/sound/cs46xx.c	Thu Nov 30 14:22:11 2000
@@ -1124,10 +1124,16 @@
 	unsigned long flags;
 	unsigned int mask = 0;
 
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!dmabuf->ready && prog_dmabuf(state, 0))
+			return 0;
 		poll_wait(file, &dmabuf->wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!dmabuf->ready && prog_dmabuf(state, 1))
+			return 0;
 		poll_wait(file, &dmabuf->wait, wait);
+	}
 
 	spin_lock_irqsave(&state->card->lock, flags);
 	cs_update_ptr(state);
@@ -1368,7 +1374,7 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!dmabuf->enable && (val = prog_dmabuf(state, 0)) != 0)
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		cs_update_ptr(state);
@@ -1382,7 +1388,7 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!dmabuf->enable && (val = prog_dmabuf(state, 1)) != 0)
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		cs_update_ptr(state);
@@ -1433,6 +1439,8 @@
 	case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
+			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		cs_update_ptr(state);
 		cinfo.bytes = dmabuf->total_bytes;
@@ -1446,6 +1454,8 @@
 	case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
+			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		cs_update_ptr(state);
 		cinfo.bytes = dmabuf->total_bytes;
@@ -1462,6 +1472,8 @@
 	case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
+			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		cs_update_ptr(state);
 		val = dmabuf->count;
diff -u --recursive linux-2.4.0-test11-org/drivers/sound/es1370.c linux-2.4.0-test11-clean/drivers/sound/es1370.c
--- linux-2.4.0-test11-org/drivers/sound/es1370.c	Thu Nov 16 21:51:28 2000
+++ linux-2.4.0-test11-clean/drivers/sound/es1370.c	Thu Nov 30 14:22:11 2000
@@ -1280,10 +1280,17 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac2.ready && prog_dmabuf_dac2(s))
+			return 0;
 		poll_wait(file, &s->dma_dac2.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
+		 
 	spin_lock_irqsave(&s->lock, flags);
 	es1370_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -1530,8 +1537,8 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!(s->ctrl & CTRL_DAC2_EN) && (val = prog_dmabuf_dac2(s)) != 0)
-			return val;
+		if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1370_update_ptr(s);
 		abinfo.fragsize = s->dma_dac2.fragsize;
@@ -1547,8 +1554,8 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!(s->ctrl & CTRL_ADC_EN) && (val = prog_dmabuf_adc(s)) != 0)
-			return val;
+		if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1370_update_ptr(s);
 		abinfo.fragsize = s->dma_adc.fragsize;
@@ -1568,6 +1575,8 @@
         case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1370_update_ptr(s);
                 count = s->dma_dac2.count;
@@ -1579,6 +1588,8 @@
         case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1370_update_ptr(s);
                 cinfo.bytes = s->dma_adc.total_bytes;
@@ -1595,6 +1606,8 @@
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1370_update_ptr(s);
                 cinfo.bytes = s->dma_dac2.total_bytes;
diff -u --recursive linux-2.4.0-test11-org/drivers/sound/es1371.c linux-2.4.0-test11-clean/drivers/sound/es1371.c
--- linux-2.4.0-test11-org/drivers/sound/es1371.c	Fri Oct 27 19:55:01 2000
+++ linux-2.4.0-test11-clean/drivers/sound/es1371.c	Thu Nov 30 14:22:11 2000
@@ -1463,10 +1463,17 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac2.ready && prog_dmabuf_dac2(s))
+			return 0;
 		poll_wait(file, &s->dma_dac2.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
+
 	spin_lock_irqsave(&s->lock, flags);
 	es1371_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -1710,8 +1717,8 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!(s->ctrl & CTRL_DAC2_EN) && (val = prog_dmabuf_dac2(s)) != 0)
-			return val;
+		if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1371_update_ptr(s);
 		abinfo.fragsize = s->dma_dac2.fragsize;
@@ -1727,8 +1734,8 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!(s->ctrl & CTRL_ADC_EN) && (val = prog_dmabuf_adc(s)) != 0)
-			return val;
+		if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1371_update_ptr(s);
 		abinfo.fragsize = s->dma_adc.fragsize;
@@ -1748,6 +1755,8 @@
         case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1371_update_ptr(s);
                 count = s->dma_dac2.count;
@@ -1759,6 +1768,8 @@
         case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1371_update_ptr(s);
                 cinfo.bytes = s->dma_adc.total_bytes;
@@ -1775,6 +1786,8 @@
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac2.ready && (ret = prog_dmabuf_dac2(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		es1371_update_ptr(s);
                 cinfo.bytes = s->dma_dac2.total_bytes;
diff -u --recursive linux-2.4.0-test11-org/drivers/sound/esssolo1.c linux-2.4.0-test11-clean/drivers/sound/esssolo1.c
--- linux-2.4.0-test11-org/drivers/sound/esssolo1.c	Thu Nov 16 21:51:28 2000
+++ linux-2.4.0-test11-clean/drivers/sound/esssolo1.c	Thu Nov 30 14:22:11 2000
@@ -1168,10 +1168,17 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac.ready && prog_dmabuf_dac(s))
+			return 0;
 		poll_wait(file, &s->dma_dac.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf_adc(s))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
+
 	spin_lock_irqsave(&s->lock, flags);
 	solo1_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -1382,8 +1389,8 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!(s->ena & FMODE_WRITE) && (val = prog_dmabuf_dac(s)) != 0)
-			return val;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf_dac(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		solo1_update_ptr(s);
 		abinfo.fragsize = s->dma_dac.fragsize;
@@ -1399,8 +1406,8 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!(s->ena & FMODE_READ) && (val = prog_dmabuf_adc(s)) != 0)
-			return val;
+		if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		solo1_update_ptr(s);
 		abinfo.fragsize = s->dma_adc.fragsize;
@@ -1417,6 +1424,8 @@
         case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf_dac(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		solo1_update_ptr(s);
                 count = s->dma_dac.count;
@@ -1428,6 +1437,8 @@
         case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!s->dma_adc.ready && (ret = prog_dmabuf_adc(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		solo1_update_ptr(s);
                 cinfo.bytes = s->dma_adc.total_bytes;
@@ -1441,6 +1452,8 @@
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf_dac(s)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		solo1_update_ptr(s);
                 cinfo.bytes = s->dma_dac.total_bytes;
diff -u --recursive linux-2.4.0-test11-org/drivers/sound/maestro.c linux-2.4.0-test11-clean/drivers/sound/maestro.c
--- linux-2.4.0-test11-org/drivers/sound/maestro.c	Sun Nov 12 03:33:13 2000
+++ linux-2.4.0-test11-clean/drivers/sound/maestro.c	Thu Nov 30 14:22:11 2000
@@ -2384,18 +2384,17 @@
 	struct ess_state *s = (struct ess_state *)file->private_data;
 	unsigned long flags;
 	unsigned int mask = 0;
-	int ret;
 
 	VALIDATE_STATE(s);
 
 /* In 0.14 prog_dmabuf always returns success anyway ... */
 	if (file->f_mode & FMODE_WRITE) {
-		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0))) 
-			return POLLERR;
+		if (!s->dma_dac.ready && prog_dmabuf(s, 0)) 
+			return 0;
 	}
 	if (file->f_mode & FMODE_READ) {
-	  	if (!s->dma_adc.ready && (ret = prog_dmabuf(s, 1)))
-			return POLLERR;
+	  	if (!s->dma_adc.ready && prog_dmabuf(s, 1))
+			return 0;
 	}
 
 	if (file->f_mode & FMODE_WRITE)
@@ -2645,8 +2644,8 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!(s->enable & DAC_RUNNING) && (val = prog_dmabuf(s, 0)) != 0)
-			return val;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		ess_update_ptr(s);
 		abinfo.fragsize = s->dma_dac.fragsize;
@@ -2659,8 +2658,8 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!(s->enable & ADC_RUNNING) && (val = prog_dmabuf(s, 1)) != 0)
-			return val;
+		if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		ess_update_ptr(s);
 		abinfo.fragsize = s->dma_adc.fragsize;
@@ -2677,6 +2676,8 @@
         case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		ess_update_ptr(s);
                 val = s->dma_dac.count;
@@ -2686,6 +2687,8 @@
         case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		ess_update_ptr(s);
                 cinfo.bytes = s->dma_adc.total_bytes;
@@ -2699,6 +2702,8 @@
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		ess_update_ptr(s);
                 cinfo.bytes = s->dma_dac.total_bytes;
diff -u --recursive linux-2.4.0-test11-org/drivers/sound/sonicvibes.c linux-2.4.0-test11-clean/drivers/sound/sonicvibes.c
--- linux-2.4.0-test11-org/drivers/sound/sonicvibes.c	Thu Nov 16 21:51:28 2000
+++ linux-2.4.0-test11-clean/drivers/sound/sonicvibes.c	Thu Nov 30 14:22:11 2000
@@ -1484,10 +1484,17 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(s);
-	if (file->f_mode & FMODE_WRITE)
+	if (file->f_mode & FMODE_WRITE) {
+		if (!s->dma_dac.ready && prog_dmabuf(s, 0))
+			return 0;
 		poll_wait(file, &s->dma_dac.wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!s->dma_adc.ready && prog_dmabuf(s, 1))
+			return 0;
 		poll_wait(file, &s->dma_adc.wait, wait);
+	}
+
 	spin_lock_irqsave(&s->lock, flags);
 	sv_update_ptr(s);
 	if (file->f_mode & FMODE_READ) {
@@ -1716,8 +1723,8 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!(s->enable & SV_CENABLE_PE) && (val = prog_dmabuf(s, 0)) != 0)
-			return val;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		sv_update_ptr(s);
 		abinfo.fragsize = s->dma_dac.fragsize;
@@ -1733,8 +1740,8 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!(s->enable & SV_CENABLE_RE) && (val = prog_dmabuf(s, 1)) != 0)
-			return val;
+		if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		sv_update_ptr(s);
 		abinfo.fragsize = s->dma_adc.fragsize;
@@ -1754,6 +1761,8 @@
         case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		sv_update_ptr(s);
                 count = s->dma_dac.count;
@@ -1765,6 +1774,8 @@
         case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!s->dma_adc.ready && (ret =  prog_dmabuf(s, 1)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		sv_update_ptr(s);
                 cinfo.bytes = s->dma_adc.total_bytes;
@@ -1781,6 +1792,8 @@
         case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!s->dma_dac.ready && (ret = prog_dmabuf(s, 0)))
+			return ret;
 		spin_lock_irqsave(&s->lock, flags);
 		sv_update_ptr(s);
                 cinfo.bytes = s->dma_dac.total_bytes;
diff -u --recursive linux-2.4.0-test11-org/drivers/sound/trident.c linux-2.4.0-test11-clean/drivers/sound/trident.c
--- linux-2.4.0-test11-org/drivers/sound/trident.c	Fri Nov 10 20:37:55 2000
+++ linux-2.4.0-test11-clean/drivers/sound/trident.c	Thu Nov 30 14:22:11 2000
@@ -1595,10 +1595,17 @@
 	unsigned int mask = 0;
 
 	VALIDATE_STATE(state);
-	if (file->f_mode & FMODE_WRITE)
+
+	if (file->f_mode & FMODE_WRITE) {
+		if (!dmabuf->ready && prog_dmabuf(state, 0))
+			return 0;
 		poll_wait(file, &dmabuf->wait, wait);
-	if (file->f_mode & FMODE_READ)
+	}
+	if (file->f_mode & FMODE_READ) {
+		if (!dmabuf->ready && prog_dmabuf(state, 1))
+			return 0;
 		poll_wait(file, &dmabuf->wait, wait);
+	}
 
 	spin_lock_irqsave(&state->card->lock, flags);
 	trident_update_ptr(state);
@@ -1866,7 +1873,7 @@
 	case SNDCTL_DSP_GETOSPACE:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
-		if (!dmabuf->enable && (val = prog_dmabuf(state, 0)) != 0)
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		trident_update_ptr(state);
@@ -1880,7 +1887,7 @@
 	case SNDCTL_DSP_GETISPACE:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
-		if (!dmabuf->enable && (val = prog_dmabuf(state, 1)) != 0)
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
 			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		trident_update_ptr(state);
@@ -1931,6 +1938,8 @@
 	case SNDCTL_DSP_GETIPTR:
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 1)) != 0)
+			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		trident_update_ptr(state);
 		cinfo.bytes = dmabuf->total_bytes;
@@ -1944,6 +1953,8 @@
 	case SNDCTL_DSP_GETOPTR:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
+			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		trident_update_ptr(state);
 		cinfo.bytes = dmabuf->total_bytes;
@@ -1960,6 +1971,8 @@
 	case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
+		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
+			return val;
 		spin_lock_irqsave(&state->card->lock, flags);
 		trident_update_ptr(state);
 		val = dmabuf->count;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
