Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTGKSRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTGKSMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:12:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11396
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264880AbTGKR6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:58:15 -0400
Date: Fri, 11 Jul 2003 19:12:02 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111812.h6BIC2aS017308@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Update cs46xx in 2.5 to the newer 2.4 release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/cs46xx.c linux-2.5.75-ac1/sound/oss/cs46xx.c
--- linux-2.5.75/sound/oss/cs46xx.c	2003-07-10 21:04:01.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/cs46xx.c	2003-07-11 17:05:46.000000000 +0100
@@ -311,6 +311,9 @@
 	/* The cs461x has a certain amount of cross channel interaction
 	   so we use a single per card lock */
 	spinlock_t lock;
+	
+	/* Keep AC97 sane */
+	spinlock_t ac97_lock;
 
 	/* mixer use count */
 	atomic_t mixer_use_cnt;
@@ -1014,7 +1017,7 @@
 	}
 		
 	/*
-	 * ganularity is byte boundary, good part.
+	 * granularity is byte boundary, good part.
 	 */
 	if(dmabuf->enable & DAC_RUNNING)
 	{
@@ -1195,7 +1198,7 @@
 
 	// 2. mark each physical page in range as 'reserved'.
 	for (map = virt_to_page(dmabuf->rawbuf); map <= mapend; map++)
-		SetPageReserved(map);
+		cs4x_mem_map_reserve(map);
 
 	CS_DBGOUT(CS_PARMS, 9, printk("cs46xx: alloc_dmabuf(): allocated %ld (order = %d) bytes at %p\n",
 	       PAGE_SIZE << order, order, rawbuf) );
@@ -1232,7 +1235,7 @@
 
 	// 2. mark each physical page in range as 'reserved'.
 	for (map = virt_to_page(dmabuf->tmpbuff); map <= mapend; map++)
-		SetPageReserved(map);
+		cs4x_mem_map_reserve(map);
 	return 0;
 }
 
@@ -1247,7 +1250,7 @@
 		mapend = virt_to_page(dmabuf->rawbuf + 
 				(PAGE_SIZE << dmabuf->buforder) - 1);
 		for (map = virt_to_page(dmabuf->rawbuf); map <= mapend; map++)
-			ClearPageReserved(map);
+			cs4x_mem_map_unreserve(map);
 		free_dmabuf(state->card, dmabuf);
 	}
 
@@ -1256,7 +1259,7 @@
 		mapend = virt_to_page(dmabuf->tmpbuff +
 				(PAGE_SIZE << dmabuf->buforder_tmpbuff) - 1);
 		for (map = virt_to_page(dmabuf->tmpbuff); map <= mapend; map++)
-			ClearPageReserved(map);
+			cs4x_mem_map_unreserve(map);
 		free_dmabuf2(state->card, dmabuf);
 	}
 
@@ -1910,11 +1913,8 @@
                                 break;
                         if (signal_pending(current))
                                 break;
-                        if (file->f_flags & O_NONBLOCK) {
-                                remove_wait_queue(&card->midi.owait, &wait);
-                                current->state = TASK_RUNNING;
-                                return -EBUSY;
-                        }                      
+                        if (file->f_flags & O_NONBLOCK)
+                        	break;
                         tmo = (count * HZ) / 3100;
                         if (!schedule_timeout(tmo ? : 1) && tmo)
                                 printk(KERN_DEBUG "cs46xx: midi timed out??\n");
@@ -2117,7 +2117,7 @@
 	
 	down(&state->sem);
 	if (!dmabuf->ready && (ret = __prog_dmabuf(state)))
-		goto out;
+		goto out2;
 
 	add_wait_queue(&state->dmabuf.wait, &wait);
 	while (count > 0) {
@@ -2187,8 +2187,9 @@
                 start_adc(state);
 	}
 out:
-	up(&state->sem);
 	remove_wait_queue(&state->dmabuf.wait, &wait);
+out2:
+	up(&state->sem);
 	set_current_state(TASK_RUNNING);
 	CS_DBGOUT(CS_WAVE_READ | CS_FUNCTION, 4, 
 		printk("cs46xx: cs_read()- %d\n",ret) );
@@ -2213,6 +2214,8 @@
 	state = (struct cs_state *)card->states[1];
 	if(!state)
 		return -ENODEV;
+	if (!access_ok(VERIFY_READ, buffer, count))
+		return -EFAULT;
 	dmabuf = &state->dmabuf;
 
 	if (ppos != &file->f_pos)
@@ -2227,11 +2230,6 @@
 
 	if (!dmabuf->ready && (ret = __prog_dmabuf(state)))
 		goto out;
-	if (!access_ok(VERIFY_READ, buffer, count))
-	{
-	ret = -EFAULT;
-	goto out;
-	}
 	add_wait_queue(&state->dmabuf.wait, &wait);
 	ret = 0;
 /*
@@ -3007,7 +3005,7 @@
 		return -ENODEV;
 
 	case SNDCTL_DSP_SETDUPLEX:
-		return -EINVAL;
+		return 0;
 
 	case SNDCTL_DSP_GETODELAY:
 		if (!(file->f_mode & FMODE_WRITE))
@@ -3832,11 +3830,12 @@
 /* Write AC97 codec registers */
 
 
-static u16 cs_ac97_get(struct ac97_codec *dev, u8 reg)
+static u16 _cs_ac97_get(struct ac97_codec *dev, u8 reg)
 {
 	struct cs_card *card = dev->private_data;
 	int count,loopcnt;
 	unsigned int tmp;
+	u16 ret;
 	
 	/*
 	 *  1. Write ACCAD = Command Address Register = 46Ch for AC97 register address
@@ -3847,7 +3846,6 @@
 	 *  6. Read ACSTS = Status Register = 464h, check VSTS bit
 	 */
 
-
 	cs461x_peekBA0(card, BA0_ACSDA);
 
 	/*
@@ -3938,7 +3936,19 @@
 		"cs46xx: cs_ac97_get() reg = 0x%x, val = 0x%x, BA0_ACCAD = 0x%x\n", 
 			reg, cs461x_peekBA0(card, BA0_ACSDA),
 			cs461x_peekBA0(card, BA0_ACCAD)));
-	return(cs461x_peekBA0(card, BA0_ACSDA));
+	ret = cs461x_peekBA0(card, BA0_ACSDA);
+	return ret;
+}
+
+static u16 cs_ac97_get(struct ac97_codec *dev, u8 reg)
+{
+	u16 ret;
+	struct cs_card *card = dev->private_data;
+	
+	spin_lock(&card->ac97_lock);
+	ret = _cs_ac97_get(dev, reg);
+	spin_unlock(&card->ac97_lock);
+	return ret;
 }
 
 static void cs_ac97_set(struct ac97_codec *dev, u8 reg, u16 val)
@@ -3947,11 +3957,14 @@
 	int count;
 	int val2 = 0;
 	
+	spin_lock(&card->ac97_lock);
+	
 	if(reg == AC97_CD_VOL)
 	{
-		val2 = cs_ac97_get(dev, AC97_CD_VOL);
+		val2 = _cs_ac97_get(dev, AC97_CD_VOL);
 	}
 	
+	
 	/*
 	 *  1. Write ACCAD = Command Address Register = 46Ch for AC97 register address
 	 *  2. Write ACCDA = Command Data Register = 470h    for data to write to AC97
@@ -3999,6 +4012,8 @@
 			"cs46xx: AC'97 write problem, reg = 0x%x, val = 0x%x\n", reg, val));
 	}
 
+	spin_unlock(&card->ac97_lock);
+
 	/*
 	 *	Adjust power if the mixer is selected/deselected according
 	 *	to the CD.
@@ -4244,9 +4259,8 @@
 		"cs46xx: cs_ac97_init()+\n") );
 
 	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
-		if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)
+		if ((codec = ac97_alloc_codec()) == NULL)
 			return -ENOMEM;
-		memset(codec, 0, sizeof(struct ac97_codec));
 
 		/* initialize some basic codec information, other fields will be filled
 		   in ac97_probe_codec */
@@ -4269,10 +4283,10 @@
 
 		eid = cs_ac97_get(codec, AC97_EXTENDED_ID);
 		
-		if(eid==0xFFFFFF)
+		if(eid==0xFFFF)
 		{
 			printk(KERN_WARNING "cs46xx: codec %d not present\n",num_ac97);
-			kfree(codec);
+			ac97_release_codec(codec);
 			break;
 		}
 		
@@ -4280,7 +4294,7 @@
 			
 		if ((codec->dev_mixer = register_sound_mixer(&cs_mixer_fops, -1)) < 0) {
 			printk(KERN_ERR "cs46xx: couldn't register mixer!\n");
-			kfree(codec);
+			ac97_release_codec(codec);
 			break;
 		}
 		card->ac97_codec[num_ac97] = codec;
@@ -5298,6 +5312,12 @@
 		.name	= "Hercules Game Theatre XP",
 		.amp	= amp_hercules,
 	},
+	{
+		.vendor	= 0x1681,
+		.id	= 0xa010,
+		.name	= "Hercules Fortissimo II",
+		.amp	= amp_none,
+	},
 	/* Not sure if the 570 needs the clkrun hack */
 	{
 		.vendor	= PCI_VENDOR_ID_IBM,
@@ -5381,6 +5401,7 @@
 	card->irq = pci_dev->irq;
 	card->magic = CS_CARD_MAGIC;
 	spin_lock_init(&card->lock);
+	spin_lock_init(&card->ac97_lock);
 
 	pci_set_master(pci_dev);
 
@@ -5508,7 +5529,7 @@
 			for (j = 0; j < NR_AC97; j++)
 				if (card->ac97_codec[j] != NULL) {
 					unregister_sound_mixer(card->ac97_codec[j]->dev_mixer);
-					kfree (card->ac97_codec[j]);
+					ac97_release_codec(card->ac97_codec[j]);
 				}
 			mdelay(10 * cs_laptop_wait);
 			continue;
@@ -5665,7 +5686,7 @@
 	for (i = 0; i < NR_AC97; i++)
 		if (card->ac97_codec[i] != NULL) {
 			unregister_sound_mixer(card->ac97_codec[i]->dev_mixer);
-			kfree (card->ac97_codec[i]);
+			ac97_release_codec(card->ac97_codec[i]);
 		}
 	unregister_sound_dsp(card->dev_audio);
         if(card->dev_midi)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/cs46xx_wrapper-24.h linux-2.5.75-ac1/sound/oss/cs46xx_wrapper-24.h
--- linux-2.5.75/sound/oss/cs46xx_wrapper-24.h	2003-07-10 21:12:09.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/cs46xx_wrapper-24.h	2003-07-11 17:07:37.000000000 +0100
@@ -31,6 +31,9 @@
 #define CS_OWNER owner:
 #define CS_THIS_MODULE THIS_MODULE,
 void cs46xx_null(struct pci_dev *pcidev) { return; }
+#define cs4x_mem_map_reserve(page) SetPageReserved(page)
+#define cs4x_mem_map_unreserve(page) ClearPageReserved(page)
+
 #define free_dmabuf(card, dmabuf) \
 	pci_free_consistent((card)->pci_dev, \
 			    PAGE_SIZE << (dmabuf)->buforder, \
