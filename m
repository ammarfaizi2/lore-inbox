Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264934AbTGKSpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTGKSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:21:51 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14468
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264897AbTGKR7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:59:43 -0400
Date: Fri, 11 Jul 2003 19:13:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111813.h6BIDUB0017332@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: bring es1371 in line with 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes security leak
Fixes a crash
Updates to use the new ac97

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/es1371.c linux-2.5.75-ac1/sound/oss/es1371.c
--- linux-2.5.75/sound/oss/es1371.c	2003-07-10 21:12:51.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/es1371.c	2003-07-11 17:40:25.000000000 +0100
@@ -406,7 +406,7 @@
 	struct proc_dir_entry *ps;
 #endif /* ES1371_DEBUG */
 
-	struct ac97_codec codec;
+	struct ac97_codec *codec;
 
 	/* wave stuff */
 	unsigned ctrl;
@@ -682,10 +682,10 @@
 	unsigned long flags;
 	unsigned t, x;
         
+	spin_lock_irqsave(&s->lock, flags);
 	for (t = 0; t < POLL_COUNT; t++)
 		if (!(inl(s->io+ES1371_REG_CODEC) & CODEC_WIP))
 			break;
-	spin_lock_irqsave(&s->lock, flags);
 
         /* save the current state for later */
         x = wait_src_ready(s);
@@ -724,11 +724,12 @@
 	unsigned long flags;
 	unsigned t, x;
 
+	spin_lock_irqsave(&s->lock, flags);
+	
         /* wait for WIP to go away */
 	for (t = 0; t < 0x1000; t++)
 		if (!(inl(s->io+ES1371_REG_CODEC) & CODEC_WIP))
 			break;
-	spin_lock_irqsave(&s->lock, flags);
 
 	/* save the current state for later */
 	x = (wait_src_ready(s) & (SRC_DIS | SRC_DDAC1 | SRC_DDAC2 | SRC_DADC));
@@ -756,7 +757,6 @@
 	/* restore SRC reg */
 	wait_src_ready(s);
 	outl(x, s->io+ES1371_REG_SRCONV);
-	spin_unlock_irqrestore(&s->lock, flags);
 
         /* wait for WIP again */
 	for (t = 0; t < 0x1000; t++)
@@ -768,6 +768,7 @@
 		if ((x = inl(s->io+ES1371_REG_CODEC)) & CODEC_RDY)
 			break;
         
+	spin_unlock_irqrestore(&s->lock, flags);
 	return ((x & CODEC_PIDAT_MASK) >> CODEC_PIDAT_SHIFT);
 }
 
@@ -1217,7 +1218,7 @@
 		if (list == &devs)
 			return -ENODEV;
 		s = list_entry(list, struct es1371_state, devs);
-		if (s->codec.dev_mixer == minor)
+		if (s->codec->dev_mixer == minor)
 			break;
 	}
        	VALIDATE_STATE(s);
@@ -1236,7 +1237,7 @@
 static int es1371_ioctl_mixdev(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct es1371_state *s = (struct es1371_state *)file->private_data;
-	struct ac97_codec *codec = &s->codec;
+	struct ac97_codec *codec = s->codec;
 
 	return mixdev_ioctl(codec, cmd, arg);
 }
@@ -1908,7 +1909,7 @@
                 return -EINVAL;
 		
 	}
-	return mixdev_ioctl(&s->codec, cmd, arg);
+	return mixdev_ioctl(s->codec, cmd, arg);
 }
 
 static int es1371_open(struct inode *inode, struct file *file)
@@ -2339,7 +2340,7 @@
                 return -EINVAL;
 		
 	}
-	return mixdev_ioctl(&s->codec, cmd, arg);
+	return mixdev_ioctl(s->codec, cmd, arg);
 }
 
 static int es1371_open_dac(struct inode *inode, struct file *file)
@@ -2661,12 +2662,8 @@
 				break;
 			if (signal_pending(current))
 				break;
-			if (file->f_flags & O_NONBLOCK) {
-				remove_wait_queue(&s->midi.owait, &wait);
-				set_current_state(TASK_RUNNING);
-				unlock_kernel();
-				return -EBUSY;
-			}
+			if (file->f_flags & O_NONBLOCK)
+				break;
 			tmo = (count * HZ) / 3100;
 			if (!schedule_timeout(tmo ? : 1) && tmo)
 				printk(KERN_DEBUG PFX "midi timed out??\n");
@@ -2720,7 +2717,7 @@
         /* print out CODEC state */
         len += sprintf (buf + len, "AC97 CODEC state\n");
 	for (cnt=0; cnt <= 0x7e; cnt = cnt +2)
-                len+= sprintf (buf + len, "reg:0x%02x  val:0x%04x\n", cnt, rdcodec(&s->codec, cnt));
+                len+= sprintf (buf + len, "reg:0x%02x  val:0x%04x\n", cnt, rdcodec(s->codec, cnt));
 
         if (fpos >=len){
                 *start = buf;
@@ -2820,6 +2817,11 @@
 		return -ENOMEM;
 	}
 	memset(s, 0, sizeof(struct es1371_state));
+	
+	s->codec = ac97_alloc_codec();
+	if(s->codec == NULL)
+		goto err_codec;
+		
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac1.wait);
 	init_waitqueue_head(&s->dma_dac2.wait);
@@ -2835,10 +2837,10 @@
 	s->vendor = pcidev->vendor;
 	s->device = pcidev->device;
 	pci_read_config_byte(pcidev, PCI_REVISION_ID, &s->rev);
-	s->codec.private_data = s;
-	s->codec.id = 0;
-	s->codec.codec_read = rdcodec;
-	s->codec.codec_write = wrcodec;
+	s->codec->private_data = s;
+	s->codec->id = 0;
+	s->codec->codec_read = rdcodec;
+	s->codec->codec_write = wrcodec;
 	printk(KERN_INFO PFX "found chip, vendor id 0x%04x device id 0x%04x revision 0x%02x\n",
 	       s->vendor, s->device, s->rev);
 	if (!request_region(s->io, ES1371_EXTENT, "es1371")) {
@@ -2855,7 +2857,7 @@
 	/* register devices */
 	if ((res=(s->dev_audio = register_sound_dsp(&es1371_audio_fops,-1)))<0)
 		goto err_dev1;
-	if ((res=(s->codec.dev_mixer = register_sound_mixer(&es1371_mixer_fops, -1))) < 0)
+	if ((res=(s->codec->dev_mixer = register_sound_mixer(&es1371_mixer_fops, -1))) < 0)
 		goto err_dev2;
 	if ((res=(s->dev_dac = register_sound_dsp(&es1371_dac_fops, -1))) < 0)
 		goto err_dev3;
@@ -2938,7 +2940,7 @@
 	/* init the sample rate converter */
 	src_init(s);
 	/* codec init */
-	if (!ac97_probe_codec(&s->codec)) {
+	if (!ac97_probe_codec(s->codec)) {
 		res = -ENODEV;
 		goto err_gp;
 	}
@@ -2947,16 +2949,16 @@
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 	val = SOUND_MASK_LINE;
-	mixdev_ioctl(&s->codec, SOUND_MIXER_WRITE_RECSRC, (unsigned long)&val);
+	mixdev_ioctl(s->codec, SOUND_MIXER_WRITE_RECSRC, (unsigned long)&val);
 	for (i = 0; i < sizeof(initvol)/sizeof(initvol[0]); i++) {
 		val = initvol[i].vol;
-		mixdev_ioctl(&s->codec, initvol[i].mixch, (unsigned long)&val);
+		mixdev_ioctl(s->codec, initvol[i].mixch, (unsigned long)&val);
 	}
 	/* mute master and PCM when in S/PDIF mode */
 	if (s->spdif_volume != -1) {
 		val = 0x0000;
-		s->codec.mixer_ioctl(&s->codec, SOUND_MIXER_WRITE_VOLUME, (unsigned long)&val);
-		s->codec.mixer_ioctl(&s->codec, SOUND_MIXER_WRITE_PCM, (unsigned long)&val);
+		s->codec->mixer_ioctl(s->codec, SOUND_MIXER_WRITE_VOLUME, (unsigned long)&val);
+		s->codec->mixer_ioctl(s->codec, SOUND_MIXER_WRITE_PCM, (unsigned long)&val);
 	}
 	set_fs(fs);
 	/* turn on S/PDIF output driver if requested */
@@ -2984,7 +2986,7 @@
  err_dev4:
 	unregister_sound_dsp(s->dev_dac);
  err_dev3:
-	unregister_sound_mixer(s->codec.dev_mixer);
+	unregister_sound_mixer(s->codec->dev_mixer);
  err_dev2:
 	unregister_sound_dsp(s->dev_audio);
  err_dev1:
@@ -2993,6 +2995,8 @@
  err_irq:
 	release_region(s->io, ES1371_EXTENT);
  err_region:
+ err_codec:
+	ac97_release_codec(s->codec);
 	kfree(s);
 	return res;
 }
@@ -3018,9 +3022,10 @@
 	}
 	release_region(s->io, ES1371_EXTENT);
 	unregister_sound_dsp(s->dev_audio);
-	unregister_sound_mixer(s->codec.dev_mixer);
+	unregister_sound_mixer(s->codec->dev_mixer);
 	unregister_sound_dsp(s->dev_dac);
 	unregister_sound_midi(s->dev_midi);
+	ac97_release_codec(s->codec);
 	kfree(s);
 	pci_set_drvdata(dev, NULL);
 }
