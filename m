Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbTGKSXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265025AbTGKSW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:22:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20612
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264960AbTGKSC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:02:29 -0400
Date: Fri, 11 Jul 2003 19:16:17 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111816.h6BIGHa0017380@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update nec driver to new ac97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/nec_vrc5477.c linux-2.5.75-ac1/sound/oss/nec_vrc5477.c
--- linux-2.5.75/sound/oss/nec_vrc5477.c	2003-07-10 21:12:50.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/nec_vrc5477.c	2003-07-11 16:49:34.000000000 +0100
@@ -194,7 +194,7 @@
 	struct proc_dir_entry *ac97_ps;
 #endif /* VRC5477_AC97_DEBUG */
 
-	struct ac97_codec codec;
+	struct ac97_codec *codec;
 
 	unsigned dacChannels, adcChannels;
 	unsigned short dacRate, adcRate;
@@ -385,7 +385,7 @@
 
 static void set_adc_rate(struct vrc5477_ac97_state *s, unsigned rate)
 {
-	wrcodec(&s->codec, AC97_PCM_LR_ADC_RATE, rate);
+	wrcodec(s->codec, AC97_PCM_LR_ADC_RATE, rate);
 	s->adcRate = rate;
 }
 
@@ -393,8 +393,8 @@
 static void set_dac_rate(struct vrc5477_ac97_state *s, unsigned rate)
 {
 	if(s->extended_status & AC97_EXTSTAT_VRA) {
-	wrcodec(&s->codec, AC97_PCM_FRONT_DAC_RATE, rate);
-		s->dacRate = rdcodec(&s->codec, AC97_PCM_FRONT_DAC_RATE);
+	wrcodec(s->codec, AC97_PCM_FRONT_DAC_RATE, rate);
+		s->dacRate = rdcodec(s->codec, AC97_PCM_FRONT_DAC_RATE);
 	}
 }
 
@@ -865,7 +865,7 @@
 		if (list == &devs)
 			return -ENODEV;
 		s = list_entry(list, struct vrc5477_ac97_state, devs);
-		if (s->codec.dev_mixer == minor)
+		if (s->codec->dev_mixer == minor)
 			break;
 	}
 	file->private_data = s;
@@ -889,7 +889,7 @@
 {
     struct vrc5477_ac97_state *s = 
 	    (struct vrc5477_ac97_state *)file->private_data;
-    struct ac97_codec *codec = &s->codec;
+    struct ac97_codec *codec = s->codec;
 
     return mixdev_ioctl(codec, cmd, arg);
 }
@@ -1187,7 +1187,7 @@
 #endif
 
 		count -= copyCount;
-		totalCopyCount =+ copyCount;
+		totalCopyCount += copyCount;
 		avail -= copyFragCount;
 		totalCopyFragCount += copyFragCount;
 
@@ -1563,7 +1563,7 @@
 		return -EINVAL;
 	}
 
-	return mixdev_ioctl(&s->codec, cmd, arg);
+	return mixdev_ioctl(s->codec, cmd, arg);
 }
 
 
@@ -1789,7 +1789,7 @@
 	len += sprintf (buf + len, "----------------------\n");
 	for (cnt=0; cnt <= 0x7e; cnt = cnt +2)
 		len+= sprintf (buf + len, "reg %02x = %04x\n",
-			       cnt, rdcodec(&s->codec, cnt));
+			       cnt, rdcodec(s->codec, cnt));
 
 	if (fpos >=len){
 		*start = buf;
@@ -1842,12 +1842,14 @@
 	s->dev = pcidev;
 	s->io = pci_resource_start(pcidev, 0);
 	s->irq = pcidev->irq;
+	
+	s->codec = ac97_alloc_codec();
 
-	s->codec.private_data = s;
-	s->codec.id = 0;
-	s->codec.codec_read = rdcodec;
-	s->codec.codec_write = wrcodec;
-	s->codec.codec_wait = waitcodec;
+	s->codec->private_data = s;
+	s->codec->id = 0;
+	s->codec->codec_read = rdcodec;
+	s->codec->codec_write = wrcodec;
+	s->codec->codec_wait = waitcodec;
 
 	/* setting some other default values such as
 	 * adcChannels, adcRate is done in open() so that
@@ -1855,7 +1857,7 @@
 	 */
 
 	/* test if get response from ac97, if not return */
-        if (ac97_codec_not_present(&(s->codec))) {
+        if (ac97_codec_not_present(s->codec)) {
 		printk(KERN_ERR PFX "no ac97 codec\n");
 		goto err_region;
 
@@ -1878,7 +1880,7 @@
 	/* register devices */
 	if ((s->dev_audio = register_sound_dsp(&vrc5477_ac97_audio_fops, -1)) < 0)
 		goto err_dev1;
-	if ((s->codec.dev_mixer =
+	if ((s->codec->dev_mixer =
 	     register_sound_mixer(&vrc5477_ac97_mixer_fops, -1)) < 0)
 		goto err_dev2;
 
@@ -1899,22 +1901,22 @@
 	while (inl(s->io + VRC5477_ACLINK_CTRL) & VRC5477_ACLINK_CTRL_RST_ON);
 
 	/* codec init */
-	if (!ac97_probe_codec(&s->codec))
+	if (!ac97_probe_codec(s->codec))
 		goto err_dev3;
 
 #ifdef VRC5477_AC97_DEBUG
 	sprintf(proc_str, "driver/%s/%d/ac97", 
-		VRC5477_AC97_MODULE_NAME, s->codec.id);
+		VRC5477_AC97_MODULE_NAME, s->codec->id);
 	s->ac97_ps = create_proc_read_entry (proc_str, 0, NULL,
-					     ac97_read_proc, &s->codec);
+					     ac97_read_proc, s->codec);
 	/* TODO : why this proc file does not show up? */
 #endif
 
 	/* Try to enable variable rate audio mode. */
-	wrcodec(&s->codec, AC97_EXTENDED_STATUS,
-		rdcodec(&s->codec, AC97_EXTENDED_STATUS) | AC97_EXTSTAT_VRA);
+	wrcodec(s->codec, AC97_EXTENDED_STATUS,
+		rdcodec(s->codec, AC97_EXTENDED_STATUS) | AC97_EXTSTAT_VRA);
 	/* Did we enable it? */
-	if(rdcodec(&s->codec, AC97_EXTENDED_STATUS) & AC97_EXTSTAT_VRA)
+	if(rdcodec(s->codec, AC97_EXTENDED_STATUS) & AC97_EXTSTAT_VRA)
 		s->extended_status |= AC97_EXTSTAT_VRA;
 	else {
 		s->dacRate = 48000;
@@ -1923,17 +1925,17 @@
 	}
 
         /* let us get the default volumne louder */
-        wrcodec(&s->codec, 0x2, 0x1010);	/* master volume, middle */
-        wrcodec(&s->codec, 0xc, 0x10);		/* phone volume, middle */
-        // wrcodec(&s->codec, 0xe, 0x10);		/* misc volume, middle */
-	wrcodec(&s->codec, 0x10, 0x8000);	/* line-in 2 line-out disable */
-        wrcodec(&s->codec, 0x18, 0x0707);	/* PCM out (line out) middle */
+        wrcodec(s->codec, 0x2, 0x1010);	/* master volume, middle */
+        wrcodec(s->codec, 0xc, 0x10);		/* phone volume, middle */
+        // wrcodec(s->codec, 0xe, 0x10);		/* misc volume, middle */
+	wrcodec(s->codec, 0x10, 0x8000);	/* line-in 2 line-out disable */
+        wrcodec(s->codec, 0x18, 0x0707);	/* PCM out (line out) middle */
 
 
 	/* by default we select line in the input */
-	wrcodec(&s->codec, 0x1a, 0x0404);
-	wrcodec(&s->codec, 0x1c, 0x0f0f);
-	wrcodec(&s->codec, 0x1e, 0x07);
+	wrcodec(s->codec, 0x1a, 0x0404);
+	wrcodec(s->codec, 0x1c, 0x0f0f);
+	wrcodec(s->codec, 0x1e, 0x07);
 
 	/* enable the master interrupt but disable all others */
 	outl(VRC5477_INT_MASK_NMASK, s->io + VRC5477_INT_MASK);
@@ -1949,7 +1951,7 @@
 	return 0;
 
  err_dev3:
-	unregister_sound_mixer(s->codec.dev_mixer);
+	unregister_sound_mixer(s->codec->dev_mixer);
  err_dev2:
 	unregister_sound_dsp(s->dev_audio);
  err_dev1:
@@ -1958,6 +1960,7 @@
  err_irq:
 	release_region(s->io, pci_resource_len(pcidev,0));
  err_region:
+ 	ac97_release_codec(codec);
 	kfree(s);
 	return -1;
 }
@@ -1979,7 +1982,8 @@
 	free_irq(s->irq, s);
 	release_region(s->io, pci_resource_len(dev,0));
 	unregister_sound_dsp(s->dev_audio);
-	unregister_sound_mixer(s->codec.dev_mixer);
+	unregister_sound_mixer(s->codec->dev_mixer);
+	ac97_release_codec(s->codec);
 	kfree(s);
 	pci_set_drvdata(dev, NULL);
 }
