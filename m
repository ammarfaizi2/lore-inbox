Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274816AbRJKBql>; Wed, 10 Oct 2001 21:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRJKBqe>; Wed, 10 Oct 2001 21:46:34 -0400
Received: from pc3-oxfo3-0-cust171.oxf.cable.ntl.com ([213.107.68.171]:38671
	"EHLO noetbook.telent.net") by vger.kernel.org with ESMTP
	id <S274816AbRJKBqS>; Wed, 10 Oct 2001 21:46:18 -0400
To: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] i810_audio APM support and minor cleanup
From: Daniel Barlow <dan@telent.net>
Date: 11 Oct 2001 02:46:48 +0100
Message-ID: <87wv23x81j.fsf@noetbook.telent.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


This patch adds APM support to the i810_audio.o module in kernel 2.4 I
don't know if it works on absolutely everything out there, but it
certainly helps matters on my Toshiba portable (portege 3440ct) which
locks solid on APM resume without it.  Google suggests that users of
at least some other notebooks that use this module also have this
problem.  If you're using i810_audio on a machine with APM, you might
like to give it a try

There is a partial user-space workaround for this problem, but it
involves killing all audio applications on suspend, which is not
really as nice.  With this patch I can "apm -s" while playing an mp3,
and the mp3 carries on where it left off when I resume.

(Patch against 2.4.9ac3, but shouldn't be too hard to apply to
anything reasonably recent)


--=-=-=
Content-Disposition: attachment; filename=i810_audio.c.diff

--- /usr/src/linux/drivers/sound/i810_audio.c	Tue Oct  2 20:31:41 2001
+++ i810_audio.c	Fri Oct  5 19:34:59 2001
@@ -247,6 +247,12 @@
 
 MODULE_DEVICE_TABLE (pci, i810_pci_tbl);
 
+#ifdef CONFIG_PM
+#define PM_SUSPENDED(card) (card->pm_suspended)
+#else
+#define PM_SUSPENDED(card) (0)
+#endif
+
 /* "software" or virtual channel, an instance of opened /dev/dsp */
 struct i810_state {
 	unsigned int magic;
@@ -262,6 +268,9 @@
 	/* virtual channel number */
 	int virt;
 
+#ifdef CONFIG_PM
+	unsigned int pm_saved_dac_rate,pm_saved_adc_rate;
+#endif
 	struct dmabuf {
 		/* wave sample stuff */
 		unsigned int rate;
@@ -322,7 +331,11 @@
 	/* PCI device stuff */
 	struct pci_dev * pci_dev;
 	u16 pci_id;
-
+#ifdef CONFIG_PM	
+	u16 pm_suspended;
+	u32 pm_save_state[64/sizeof(u32)];
+	int pm_saved_mixer_settings[SOUND_MIXER_NRDEVICES][NR_AC97];
+#endif
 	/* soundcore stuff */
 	int dev_audio;
 
@@ -451,7 +464,7 @@
 
 	if(!(state->card->ac97_features & 4)) {
 #ifdef DEBUG
-		printk(KERN_WARNING "i810_audio: S/PDIF transmitter not avalible.\n");
+		printk(KERN_WARNING "i810_audio: S/PDIF transmitter not available.\n");
 #endif
 		state->card->ac97_status &= ~SPDIF_ON;
 	} else {
@@ -572,6 +585,10 @@
 	if(!(state->card->ac97_features&0x0001))
 	{
 		dmabuf->rate = clocking;
+#ifdef DEBUG
+		printk("Asked for %d Hz, but ac97_features says we only do %dHz.  Sorry!\n",
+		       rate,clocking);
+#endif		       
 		return clocking;
 	}
 			
@@ -594,11 +611,11 @@
 
 	if(new_rate != rate) {
 		dmabuf->rate = (new_rate * 48000)/clocking;
-		rate = new_rate;
 	}
 #ifdef DEBUG
-	printk("i810_audio: called i810_set_dac_rate : rate = %d/%d\n", dmabuf->rate, rate);
+	printk("i810_audio: called i810_set_dac_rate : asked for %d, got %d\n", rate, dmabuf->rate);
 #endif
+	rate = new_rate;
 	return dmabuf->rate;
 }
 
@@ -1066,7 +1083,7 @@
 	for (;;) {
 		/* It seems that we have to set the current state to TASK_INTERRUPTIBLE
 		   every time to make the process really go to sleep */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		spin_lock_irqsave(&state->card->lock, flags);
 		i810_update_ptr(state);
@@ -1085,7 +1102,7 @@
 
 		if (nonblock) {
 			remove_wait_queue(&dmabuf->wait, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			return -EBUSY;
 		}
 
@@ -1099,7 +1116,7 @@
 	stop_dac(state);
 	synchronize_irq();
 	remove_wait_queue(&dmabuf->wait, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	if (signal_pending(current))
 		return -ERESTARTSYS;
 
@@ -1201,16 +1218,20 @@
 	spin_unlock(&card->lock);
 }
 
-/* in this loop, dmabuf.count signifies the amount of data that is waiting to be copied to
-   the user's buffer.  it is filled by the dma machine and drained by this loop. */
+/* in this loop, dmabuf.count signifies the amount of data that is
+   waiting to be copied to the user's buffer.  It is filled by the dma
+   machine and drained by this loop. */
+
 static ssize_t i810_read(struct file *file, char *buffer, size_t count, loff_t *ppos)
 {
 	struct i810_state *state = (struct i810_state *)file->private_data;
+	struct i810_card *card=state ? state->card : 0;
 	struct dmabuf *dmabuf = &state->dmabuf;
 	ssize_t ret;
 	unsigned long flags;
 	unsigned int swptr;
 	int cnt;
+        DECLARE_WAITQUEUE(waita, current);
 
 #ifdef DEBUG2
 	printk("i810_audio: i810_read called, count = %d\n", count);
@@ -1224,7 +1245,7 @@
 		return -ENODEV;
 	if (!dmabuf->read_channel) {
 		dmabuf->ready = 0;
-		dmabuf->read_channel = state->card->alloc_rec_pcm_channel(state->card);
+		dmabuf->read_channel = card->alloc_rec_pcm_channel(card);
 		if (!dmabuf->read_channel) {
 			return -EBUSY;
 		}
@@ -1236,8 +1257,19 @@
 	dmabuf->trigger &= ~PCM_ENABLE_OUTPUT;
 	ret = 0;
 
+        add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
-		spin_lock_irqsave(&state->card->lock, flags);
+		spin_lock_irqsave(&card->lock, flags);
+                if (PM_SUSPENDED(card)) {
+                        spin_unlock_irqrestore(&card->lock, flags);
+                        set_current_state(TASK_INTERRUPTIBLE);
+                        schedule();
+                        if (signal_pending(current)) {
+                                if (!ret) ret = -EAGAIN;
+                                break;
+                        }
+                        continue;
+                }
 		swptr = dmabuf->swptr;
 		if (dmabuf->count > dmabuf->dmasize) {
 			dmabuf->count = dmabuf->dmasize;
@@ -1246,7 +1278,7 @@
 		// this is to make the copy_to_user simpler below
 		if(cnt > (dmabuf->dmasize - swptr))
 			cnt = dmabuf->dmasize - swptr;
-		spin_unlock_irqrestore(&state->card->lock, flags);
+		spin_unlock_irqrestore(&card->lock, flags);
 
 		if (cnt > count)
 			cnt = count;
@@ -1290,15 +1322,20 @@
 
 		if (copy_to_user(buffer, dmabuf->rawbuf + swptr, cnt)) {
 			if (!ret) ret = -EFAULT;
-			return ret;
+			goto done;
 		}
 
 		swptr = (swptr + cnt) % dmabuf->dmasize;
 
-		spin_lock_irqsave(&state->card->lock, flags);
+		spin_lock_irqsave(&card->lock, flags);
+
+                if (PM_SUSPENDED(card)) {
+                        spin_unlock_irqrestore(&card->lock, flags);
+                        continue;
+                }
 		dmabuf->swptr = swptr;
 		dmabuf->count -= cnt;
-		spin_unlock_irqrestore(&state->card->lock, flags);
+		spin_unlock_irqrestore(&card->lock, flags);
 
 		count -= cnt;
 		buffer += cnt;
@@ -1307,6 +1344,10 @@
 	i810_update_lvi(state,1);
 	if(!(dmabuf->enable & ADC_RUNNING))
 		start_adc(state);
+ done:
+        set_current_state(TASK_RUNNING);
+        remove_wait_queue(&dmabuf->wait, &waita);
+
 	return ret;
 }
 
@@ -1315,11 +1356,13 @@
 static ssize_t i810_write(struct file *file, const char *buffer, size_t count, loff_t *ppos)
 {
 	struct i810_state *state = (struct i810_state *)file->private_data;
+	struct i810_card *card=state ? state->card : 0;
 	struct dmabuf *dmabuf = &state->dmabuf;
 	ssize_t ret;
 	unsigned long flags;
 	unsigned int swptr = 0;
 	int cnt, x;
+        DECLARE_WAITQUEUE(waita, current);
 
 #ifdef DEBUG2
 	printk("i810_audio: i810_write called, count = %d\n", count);
@@ -1333,7 +1376,7 @@
 		return -ENODEV;
 	if (!dmabuf->write_channel) {
 		dmabuf->ready = 0;
-		dmabuf->write_channel = state->card->alloc_pcm_channel(state->card);
+		dmabuf->write_channel = card->alloc_pcm_channel(card);
 		if(!dmabuf->write_channel)
 			return -EBUSY;
 	}
@@ -1344,8 +1387,20 @@
 	dmabuf->trigger &= ~PCM_ENABLE_INPUT;
 	ret = 0;
 
+        add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
 		spin_lock_irqsave(&state->card->lock, flags);
+                if (PM_SUSPENDED(card)) {
+                        spin_unlock_irqrestore(&card->lock, flags);
+                        set_current_state(TASK_INTERRUPTIBLE);
+                        schedule();
+                        if (signal_pending(current)) {
+                                if (!ret) ret = -EAGAIN;
+                                break;
+                        }
+                        continue;
+                }
+
 		swptr = dmabuf->swptr;
 		if (dmabuf->count < 0) {
 			dmabuf->count = 0;
@@ -1376,7 +1431,7 @@
 			i810_update_lvi(state,0);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
-				return ret;
+				goto ret;
 			}
 			/* Not strictly correct but works */
 			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 4);
@@ -1400,25 +1455,30 @@
 			}
 			if (signal_pending(current)) {
 				if (!ret) ret = -ERESTARTSYS;
-				return ret;
+				goto ret;
 			}
 			continue;
 		}
 		if (copy_from_user(dmabuf->rawbuf+swptr,buffer,cnt)) {
 			if (!ret) ret = -EFAULT;
-			return ret;
+			goto ret;
 		}
 
 		swptr = (swptr + cnt) % dmabuf->dmasize;
 
 		spin_lock_irqsave(&state->card->lock, flags);
+                if (PM_SUSPENDED(card)) {
+                        spin_unlock_irqrestore(&card->lock, flags);
+                        continue;
+                }
+
 		dmabuf->swptr = swptr;
 		dmabuf->count += cnt;
-		spin_unlock_irqrestore(&state->card->lock, flags);
 
 		count -= cnt;
 		buffer += cnt;
 		ret += cnt;
+		spin_unlock_irqrestore(&state->card->lock, flags);
 	}
 	if (swptr % dmabuf->fragsize) {
 		x = dmabuf->fragsize - (swptr % dmabuf->fragsize);
@@ -1427,6 +1487,9 @@
 	i810_update_lvi(state,0);
 	if (!dmabuf->enable && dmabuf->count >= dmabuf->userfragsize)
 		start_dac(state);
+ ret:
+        set_current_state(TASK_RUNNING);
+        remove_wait_queue(&dmabuf->wait, &waita);
 
 	return ret;
 }
@@ -2310,18 +2373,52 @@
 	open:		i810_open_mixdev,
 };
 
-/* AC97 codec initialisation. */
-static int __init i810_ac97_init(struct i810_card *card)
+/* AC97 codec initialisation.  These small functions exist so we don't
+   duplicate code between module init and apm resume */
+
+static inline int i810_ac97_exists(struct i810_card *card,int ac97_number)
 {
-	int num_ac97 = 0;
-	int total_channels = 0;
-	struct ac97_codec *codec;
-	u16 eid;
-	int i=0;
-	u32 reg;
+	u32 reg = inl(card->iobase + GLOB_STA);
+	return (reg & (0x100 << ac97_number));
+}
 
-	reg = inl(card->iobase + GLOB_CNT);
+static inline int i810_ac97_enable_variable_rate(struct ac97_codec *codec)
+{
+	i810_ac97_set(codec, AC97_EXTENDED_STATUS, 9);
+	i810_ac97_set(codec,AC97_EXTENDED_STATUS,
+		      i810_ac97_get(codec, AC97_EXTENDED_STATUS)|0xE800);
 	
+	return (i810_ac97_get(codec, AC97_EXTENDED_STATUS)&1);
+}
+
+
+static int i810_ac97_probe_and_powerup(struct i810_card *card,struct ac97_codec *codec)
+{
+	/* Returns 0 on failure */
+	int i;
+
+	if (ac97_probe_codec(codec) == 0) return 0;
+	
+	/* power it all up */
+	i810_ac97_set(codec, AC97_POWER_CONTROL,
+		      i810_ac97_get(codec, AC97_POWER_CONTROL) & ~0x7f00);
+	/* wait for analog ready */
+	for (i=10;
+	     i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) & 0xf) != 0xf);
+	     i--)
+	{
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/20);
+	} 
+	return i;
+}
+
+/* if I knew what this did, I'd give it a better name */
+static int i810_ac97_random_init_stuff(struct i810_card *card)
+{	
+	u32 reg = inl(card->iobase + GLOB_CNT);
+	int i;
+
 	if((reg&2)==0)	/* Cold required */
 		reg|=2;
 	else
@@ -2330,13 +2427,13 @@
 	reg&=~8;	/* ACLink on */
 	outl(reg , card->iobase + GLOB_CNT);
 	
-	while(i<10)
+	for(i=0;i<10;i++)
 	{
 		if((inl(card->iobase+GLOB_CNT)&4)==0)
 			break;
-		current->state = TASK_UNINTERRUPTIBLE;
+
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(HZ/20);
-		i++;
 	}
 	if(i==10)
 	{
@@ -2344,8 +2441,22 @@
 		return 0;
 	}
 
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/2);
+	reg = inl(card->iobase + GLOB_STA);
+	inw(card->ac97base);
+	return 1;
+}
+
+static int __init i810_ac97_init(struct i810_card *card)
+{
+	int num_ac97 = 0;
+	int total_channels = 0;
+	struct ac97_codec *codec;
+	u16 eid;
+	u32 reg;
+
+	if(!i810_ac97_random_init_stuff(card)) return 0;
 
 	/* Number of channels supported */
 	/* What about the codec?  Just because the ICH supports */
@@ -2371,10 +2482,10 @@
 		/* check the ready status before probing. So we chk */
 		/*   What do we do if it's not ready?  Wait and try */
 		/*   again, or abort?                               */
-		reg = inl(card->iobase + GLOB_STA);
-		if (!(reg & (0x100 << num_ac97))) {
+		if (!i810_ac97_exists(card,num_ac97)) {
 			if(num_ac97 == 0)
 				printk(KERN_ERR "i810_audio: Primary codec not ready.\n");
+			card->ac97_codec[num_ac97] = 0;
 			break; /* I think this works, if not ready stop */
 		}
 
@@ -2390,24 +2501,13 @@
 		codec->codec_read = i810_ac97_get;
 		codec->codec_write = i810_ac97_set;
 	
-		if (ac97_probe_codec(codec) == 0)
-			break;
-
-		/* power up everything, modify this when implementing power saving */
-		i810_ac97_set(codec, AC97_POWER_CONTROL,
-			i810_ac97_get(codec, AC97_POWER_CONTROL) & ~0x7f00);
-		/* wait for analog ready */
-	        for (i=10;
-		     i && ((i810_ac97_get(codec, AC97_POWER_CONTROL) & 0xf) != 0xf);
-		     i--)
-		{
-			current->state = TASK_UNINTERRUPTIBLE;
-			schedule_timeout(HZ/20);
+		if(!i810_ac97_probe_and_powerup(card,codec)) {
+			printk("i810_audio: timed out waiting for codec %d analog ready", num_ac97);
+			break;	/* it didn't work */
 		}
-
 		/* Store state information about S/PDIF transmitter */
 		card->ac97_status = 0;
-
+		
 		/* Don't attempt to get eid until powerup is complete */
 		eid = i810_ac97_get(codec, AC97_EXTENDED_ID);
 		
@@ -2427,16 +2527,10 @@
 			printk(KERN_WARNING "i810_audio: only 48Khz playback available.\n");
 		else
 		{
-			/* Enable variable rate mode */
-			i810_ac97_set(codec, AC97_EXTENDED_STATUS, 9);
-			i810_ac97_set(codec,AC97_EXTENDED_STATUS,
-				i810_ac97_get(codec, AC97_EXTENDED_STATUS)|0xE800);
-
-			if(!(i810_ac97_get(codec, AC97_EXTENDED_STATUS)&1))
-			{
+			if(!i810_ac97_enable_variable_rate(codec)) {
 				printk(KERN_WARNING "i810_audio: Codec refused to allow VRA, using 48Khz only.\n");
 				card->ac97_features&=~1;
-			}
+			}			
 		}
    		
 		/* Determine how many channels the codec(s) support   */
@@ -2609,6 +2703,9 @@
 	card->irq = pci_dev->irq;
 	card->next = devs;
 	card->magic = I810_CARD_MAGIC;
+#ifdef CONFIG_PM
+	card->pm_suspended=0;
+#endif
 	spin_lock_init(&card->lock);
 	devs = card;
 
@@ -2697,6 +2794,131 @@
 	kfree(card);
 }
 
+#ifdef CONFIG_PM
+static int i810_pm_suspend(struct pci_dev *dev, u32 pm_state)
+{
+        struct i810_card *card = dev->driver_data;
+        struct i810_state *state;
+	unsigned long flags;
+	struct dmabuf *dmabuf;
+	int i,num_ac97;
+#ifdef DEBUG
+	printk("i810_audio: i810_pm_suspend called\n");
+#endif
+	if(!card) return 0;
+	spin_lock_irqsave(&card->lock, flags);
+	card->pm_suspended=1;
+	for(i=0;i<NR_HW_CH;i++) {
+		state = card->states[i];
+		if(!state) continue;
+		/* this happens only if there are open files */
+		dmabuf = &state->dmabuf;
+		if(dmabuf->enable & DAC_RUNNING ||
+		   (dmabuf->count && (dmabuf->trigger & PCM_ENABLE_OUTPUT))) {
+			state->pm_saved_dac_rate=dmabuf->rate;
+			stop_dac(state);
+		} else {
+			state->pm_saved_dac_rate=0;
+		}
+		if(dmabuf->enable & ADC_RUNNING) {
+			state->pm_saved_adc_rate=dmabuf->rate;	
+			stop_adc(state);
+		} else {
+			state->pm_saved_adc_rate=0;
+		}
+		dmabuf->ready = 0;
+		dmabuf->swptr = dmabuf->hwptr = 0;
+		dmabuf->count = dmabuf->total_bytes = 0;
+	}
+
+	spin_unlock_irqrestore(&card->lock, flags);
+
+	/* save mixer settings */
+	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
+		struct ac97_codec *codec = card->ac97_codec[num_ac97];
+		if(!codec) continue;
+		for(i=0;i< SOUND_MIXER_NRDEVICES ;i++) {
+			if((supported_mixer(codec,i)) &&
+			   (codec->read_mixer)) {
+				card->pm_saved_mixer_settings[i][num_ac97]=
+					codec->read_mixer(codec,i);
+			}
+		}
+	}
+	pci_save_state(dev,card->pm_save_state); /* XXX do we need this? */
+	pci_disable_device(dev); /* disable busmastering */
+	pci_set_power_state(dev,3); /* Zzz. */
+
+	return 0;
+}
+
+
+static int i810_pm_resume(struct pci_dev *dev)
+{
+	int num_ac97,i=0;
+	struct i810_card *card=(struct i810_card *)dev->driver_data;
+	pci_enable_device(dev);
+	pci_restore_state (dev,card->pm_save_state);
+
+	/* observation of a toshiba portege 3440ct suggests that the 
+	   hardware has to be more or less completely reinitialized from
+	   scratch after an apm suspend.  Works For Me.   -dan */
+
+	i810_ac97_random_init_stuff(card);
+
+	for (num_ac97 = 0; num_ac97 < NR_AC97; num_ac97++) {
+		struct ac97_codec *codec = card->ac97_codec[num_ac97];
+		/* check they haven't stolen the hardware while we were
+		   away */
+		if(!i810_ac97_exists(card,num_ac97)) {
+			if(num_ac97) continue;
+			else BUG();
+		}
+		if(!i810_ac97_probe_and_powerup(card,codec)) BUG();
+		
+		if((card->ac97_features&0x0001)) {
+			/* at probe time we found we could do variable
+			   rates, but APM suspend has made it forget
+			   its magical powers */
+			if(!i810_ac97_enable_variable_rate(codec)) BUG();
+		}
+		/* we lost our mixer settings, so restore them */
+		for(i=0;i< SOUND_MIXER_NRDEVICES ;i++) {
+			if(supported_mixer(codec,i)){
+				int val=card->
+					pm_saved_mixer_settings[i][num_ac97];
+				codec->mixer_state[i]=val;
+				codec->write_mixer(codec,i,
+						   (val  & 0xff) ,
+						   ((val >> 8)  & 0xff) );
+			}
+		}
+	}
+
+	/* we need to restore the sample rate from whatever it was */
+	for(i=0;i<NR_HW_CH;i++) {
+		struct i810_state * state=card->states[i];
+		if(state) {
+			if(state->pm_saved_adc_rate)
+				i810_set_adc_rate(state,state->pm_saved_adc_rate);
+			if(state->pm_saved_dac_rate)
+				i810_set_dac_rate(state,state->pm_saved_dac_rate);
+		}
+	}
+
+	
+        card->pm_suspended = 0;
+
+	/* any processes that were reading/writing during the suspend
+	   probably ended up here */
+	for(i=0;i<NR_HW_CH;i++) {
+		struct i810_state *state = card->states[i];
+		if(state) wake_up(&state->dmabuf.wait);
+        }
+
+	return 0;
+}	
+#endif /* CONFIG_PM */
 
 MODULE_AUTHOR("");
 MODULE_DESCRIPTION("Intel 810 audio support");
@@ -2713,6 +2935,10 @@
 	id_table:	i810_pci_tbl,
 	probe:		i810_probe,
 	remove:		i810_remove,
+#ifdef CONFIG_PM
+	suspend:	i810_pm_suspend,
+	resume:		i810_pm_resume,
+#endif /* CONFIG_PM */
 };
 
 
@@ -2753,3 +2979,9 @@
 
 module_init(i810_init_module);
 module_exit(i810_cleanup_module);
+
+/*
+Local Variables:
+c-basic-offset: 8
+End:
+*/

--=-=-=



-dan

-- 

  http://ww.telent.net/cliki/ - Link farm for free CL-on-Unix resources 

--=-=-=--
