Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313584AbSDHIIn>; Mon, 8 Apr 2002 04:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313585AbSDHIIl>; Mon, 8 Apr 2002 04:08:41 -0400
Received: from stingr.net ([212.193.32.15]:41096 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S313584AbSDHII1>;
	Mon, 8 Apr 2002 04:08:27 -0400
Date: Mon, 8 Apr 2002 12:08:14 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][CLEANUP] task->state cleanups part 10
Message-ID: <20020408080814.GQ839@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	William Lee Irwin III <wli@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2Marcelo: the whole cleanup tree derived from yours available at
linux-stingr.bkbits.net/taskstate

2others: people says that it is nice patch, howewer it is completely
untested. But I dunno what can be broken such way so ...

This is task->state cleanup. Big part seems to be eaten my Matti Aarnio so
splitted goes below.

If you want to blame me for incorrect using of set instead of __set - feel
free to mail me and point where I should to change. Or mail me a patch.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.319   -> 1.320  
#	drivers/sound/cs46xx.c	1.17    -> 1.18   
#	drivers/sound/vwsnd.c	1.4     -> 1.5    
#	drivers/sound/cs4232.c	1.4     -> 1.5    
#	drivers/sound/msnd_pinnacle.c	1.6     -> 1.7    
#	drivers/sound/sscape.c	1.4     -> 1.5    
#	   drivers/scsi/sd.c	1.20    -> 1.21   
#	drivers/sound/btaudio.c	1.8     -> 1.9    
#	 drivers/scsi/scsi.h	1.6     -> 1.7    
#	drivers/sgi/char/sgiserial.c	1.3     -> 1.4    
#	drivers/scsi/dpt_i2o.c	1.6     -> 1.7    
#	drivers/sound/maestro.c	1.7     -> 1.8    
#	drivers/sound/awe_wave.c	1.5     -> 1.6    
#	drivers/sound/swarm_cs4297a.c	1.2     -> 1.3    
#	drivers/sound/dmasound/dmasound.h	1.4     -> 1.5    
#	drivers/sound/sgalaxy.c	1.2     -> 1.3    
#	drivers/sound/maui.c	1.2     -> 1.3    
#	drivers/sound/emu10k1/ecard.c	1.2     -> 1.3    
#	drivers/sound/cs4281/cs4281m.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/08	stingray@stingr.net	1.320
# task->state cleanup part 10
# --------------------------------------------
#
diff -Nru a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
--- a/drivers/scsi/dpt_i2o.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/scsi/dpt_i2o.c	Mon Apr  8 01:23:57 2002
@@ -1904,7 +1904,7 @@
 	}
 
 	while((volatile u32) pHba->state & DPTI_STATE_RESET ) {
-		set_task_state(current,TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(2);
 
 	}
diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Mon Apr  8 01:23:57 2002
+++ b/drivers/scsi/scsi.h	Mon Apr  8 01:23:57 2002
@@ -846,7 +846,7 @@
 	    break;      		\
 	}			        \
 	remove_wait_queue(QUEUE, &wait);\
-	current->state = TASK_RUNNING;	\
+	set_current_state(TASK_RUNNING);	\
     }; }
 
 /*
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/scsi/sd.c	Mon Apr  8 01:23:57 2002
@@ -864,7 +864,7 @@
 			time1 = HZ;
 			/* Wait 1 second for next try */
 			do {
-				current->state = TASK_UNINTERRUPTIBLE;
+				set_current_state(TASK_UNINTERRUPTIBLE);
 				time1 = schedule_timeout(time1);
 			} while(time1);
 			printk(".");
diff -Nru a/drivers/sgi/char/sgiserial.c b/drivers/sgi/char/sgiserial.c
--- a/drivers/sgi/char/sgiserial.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sgi/char/sgiserial.c	Mon Apr  8 01:23:57 2002
@@ -1370,7 +1370,7 @@
 {
 	if (!info->port)
 		return;
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	cli();
 	write_zsreg(info->zs_channel, 5, (info->curregs[5] | SND_BRK));
 	schedule_timeout(duration);
@@ -1563,7 +1563,7 @@
 	}
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(info->close_delay);
 		}
 		wake_up_interruptible(&info->open_wait);
@@ -1706,7 +1706,7 @@
 #endif
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 	if (!tty_hung_up_p(filp))
 		info->count++;
diff -Nru a/drivers/sound/awe_wave.c b/drivers/sound/awe_wave.c
--- a/drivers/sound/awe_wave.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/awe_wave.c	Mon Apr  8 01:23:57 2002
@@ -724,7 +724,7 @@
 
 static void awe_wait(unsigned short delay)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout((HZ*(unsigned long)delay + 44099)/44100);
 }
 /*
diff -Nru a/drivers/sound/btaudio.c b/drivers/sound/btaudio.c
--- a/drivers/sound/btaudio.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/btaudio.c	Mon Apr  8 01:23:57 2002
@@ -527,7 +527,7 @@
 				break;
 			}
 			up(&bta->lock);
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
 			down(&bta->lock);
 			if(signal_pending(current)) {
@@ -604,7 +604,7 @@
 	}
 	up(&bta->lock);
 	remove_wait_queue(&bta->readq, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	return ret;
 }
 
diff -Nru a/drivers/sound/cs4232.c b/drivers/sound/cs4232.c
--- a/drivers/sound/cs4232.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/cs4232.c	Mon Apr  8 01:23:57 2002
@@ -93,7 +93,7 @@
 
 static void sleep(unsigned howlong)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(howlong);
 }
 
diff -Nru a/drivers/sound/cs4281/cs4281m.c b/drivers/sound/cs4281/cs4281m.c
--- a/drivers/sound/cs4281/cs4281m.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/cs4281/cs4281m.c	Mon Apr  8 01:23:57 2002
@@ -571,7 +571,7 @@
 		j = (delay * HZ) / 1000000;	/* calculate delay in jiffies  */
 		if (j < 1)
 			j = 1;	/* minimum one jiffy. */
-		current->state = TASK_UNINTERRUPTIBLE;
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(j);
 	} else
 		udelay(delay);
@@ -2718,7 +2718,7 @@
 			break;
 		if (nonblock) {
 			remove_wait_queue(&s->dma_adc.wait, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			return -EBUSY;
 		}
 		tmo =
@@ -2732,7 +2732,7 @@
 			printk(KERN_DEBUG "cs4281: dma timed out??\n");
 	}
 	remove_wait_queue(&s->dma_adc.wait, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	if (signal_pending(current))
 		return -ERESTARTSYS;
 	return 0;
@@ -2768,7 +2768,7 @@
 			break;
 		if (nonblock) {
 			remove_wait_queue(&s->dma_dac.wait, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			CS_DBGOUT(CS_FUNCTION, 2,
 				  printk(KERN_INFO "cs4281: drain_dac()- -EBUSY\n"));
 			return -EBUSY;
@@ -2784,7 +2784,7 @@
 			printk(KERN_DEBUG "cs4281: dma timed out??\n");
 	}
 	remove_wait_queue(&s->dma_dac.wait, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	if (signal_pending(current))
 	{
 		CS_DBGOUT(CS_FUNCTION, 2,
@@ -4142,7 +4142,7 @@
 				break;
 			if (file->f_flags & O_NONBLOCK) {
 				remove_wait_queue(&s->midi.owait, &wait);
-				current->state = TASK_RUNNING;
+				set_current_state(TASK_RUNNING);
 				return -EBUSY;
 			}
 			tmo = (count * HZ) / 3100;
@@ -4151,7 +4151,7 @@
 				       "cs4281: midi timed out??\n");
 		}
 		remove_wait_queue(&s->midi.owait, &wait);
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 	}
 	down(&s->open_sem);
 	s->open_mode &=
diff -Nru a/drivers/sound/cs46xx.c b/drivers/sound/cs46xx.c
--- a/drivers/sound/cs46xx.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/cs46xx.c	Mon Apr  8 01:23:57 2002
@@ -1483,7 +1483,7 @@
 	for (;;) {
 		/* It seems that we have to set the current state to TASK_INTERRUPTIBLE
 		   every time to make the process really go to sleep */
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 
 		spin_lock_irqsave(&state->card->lock, flags);
 		count = dmabuf->count;
@@ -1497,7 +1497,7 @@
 
 		if (nonblock) {
 			remove_wait_queue(&dmabuf->wait, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			return -EBUSY;
 		}
 
@@ -1511,7 +1511,7 @@
 		}
 	}
 	remove_wait_queue(&dmabuf->wait, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	if (signal_pending(current))
 	{
 		CS_DBGOUT(CS_FUNCTION, 4, printk("cs46xx: drain_dac()- -ERESTARTSYS\n"));
@@ -1900,7 +1900,7 @@
         unsigned count, tmo;
 
         if (file->f_mode & FMODE_WRITE) {
-                current->state = TASK_INTERRUPTIBLE;
+                set_current_state(TASK_INTERRUPTIBLE);
                 add_wait_queue(&card->midi.owait, &wait);
                 for (;;) {
                         spin_lock_irqsave(&card->midi.lock, flags);
@@ -1917,7 +1917,7 @@
                                 printk(KERN_DEBUG "cs46xx: midi timed out??\n");
                 }
                 remove_wait_queue(&card->midi.owait, &wait);
-                current->state = TASK_RUNNING;
+                set_current_state(TASK_RUNNING);
         }
         down(&card->midi.open_sem);
         card->midi.open_mode &= (~(file->f_mode & (FMODE_READ | FMODE_WRITE)));
@@ -5045,7 +5045,7 @@
 		 */
 			if (cs461x_peekBA0(card, BA0_ACSTS) & ACSTS_CRDY)
 				break;
-			current->state = TASK_UNINTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		} while (time_before(jiffies, end_time));
 	}
@@ -5093,7 +5093,7 @@
 			 */
 			if ((cs461x_peekBA0(card, BA0_ACISV) & (ACISV_ISV3 | ACISV_ISV4)) == (ACISV_ISV3 | ACISV_ISV4))
 				break;
-			current->state = TASK_UNINTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		} while (time_before(jiffies, end_time));
 	}
diff -Nru a/drivers/sound/dmasound/dmasound.h b/drivers/sound/dmasound/dmasound.h
--- a/drivers/sound/dmasound/dmasound.h	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/dmasound/dmasound.h	Mon Apr  8 01:23:57 2002
@@ -269,7 +269,7 @@
 
 static inline void wait_ms(unsigned int ms)
 {
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(1 + ms * HZ / 1000);
 }
 
diff -Nru a/drivers/sound/emu10k1/ecard.c b/drivers/sound/emu10k1/ecard.c
--- a/drivers/sound/emu10k1/ecard.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/emu10k1/ecard.c	Mon Apr  8 01:23:57 2002
@@ -139,7 +139,7 @@
 
 	/* Step 3: Wait for awhile; FIXME: Is this correct? */
 
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(HZ);
 
 	/* Step 4: Switch off the DAC and ADC calibration.  Note
diff -Nru a/drivers/sound/maestro.c b/drivers/sound/maestro.c
--- a/drivers/sound/maestro.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/maestro.c	Mon Apr  8 01:23:57 2002
@@ -2184,7 +2184,7 @@
 
 	if (s->dma_dac.mapped || !s->dma_dac.ready)
 		return 0;
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
         add_wait_queue(&s->dma_dac.wait, &wait);
         for (;;) {
 		/* XXX uhm.. questionable locking*/
@@ -2197,7 +2197,7 @@
                         break;
                 if (nonblock) {
                         remove_wait_queue(&s->dma_dac.wait, &wait);
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
                         return -EBUSY;
                 }
 		tmo = (count * HZ) / s->ratedac;
@@ -2208,7 +2208,7 @@
 			M_printk(KERN_DEBUG "maestro: dma timed out?? %ld\n",jiffies);
         }
         remove_wait_queue(&s->dma_dac.wait, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
         if (signal_pending(current))
                 return -ERESTARTSYS;
         return 0;
@@ -3657,10 +3657,10 @@
 
 	card->in_suspend++;
 	add_wait_queue(&(card->suspend_queue), &wait);
-	current->state = TASK_UNINTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule();
 	remove_wait_queue(&(card->suspend_queue), &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 }
 
 static int 
diff -Nru a/drivers/sound/maui.c b/drivers/sound/maui.c
--- a/drivers/sound/maui.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/maui.c	Mon Apr  8 01:23:57 2002
@@ -76,7 +76,7 @@
 	for (i = 0; i < 150; i++) {
 		if (inb(HOST_STAT_PORT) & mask)
 			return 1;
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ / 10);
 		if (signal_pending(current))
 			return 0;
diff -Nru a/drivers/sound/msnd_pinnacle.c b/drivers/sound/msnd_pinnacle.c
--- a/drivers/sound/msnd_pinnacle.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/msnd_pinnacle.c	Mon Apr  8 01:23:57 2002
@@ -666,7 +666,7 @@
 		get_play_delay_jiffies(dev.DAPF.len));
 	clear_bit(F_WRITEFLUSH, &dev.flags);
 	if (!signal_pending(current)) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(get_play_delay_jiffies(DAP_BUFF_SIZE));
 	}
 	clear_bit(F_WRITING, &dev.flags);
@@ -1248,7 +1248,7 @@
 		       & ~0x0001, dev.SMA + SMA_wCurrHostStatusFlags);
 	if (msnd_send_word(&dev, 0, 0, HDEXAR_CAL_A_TO_D) == 0 &&
 	    chk_send_dsp_cmd(&dev, HDEX_AUX_REQ) == 0) {
-		current->state = TASK_INTERRUPTIBLE;
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ / 3);
 		return 0;
 	}
diff -Nru a/drivers/sound/sgalaxy.c b/drivers/sound/sgalaxy.c
--- a/drivers/sound/sgalaxy.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/sgalaxy.c	Mon Apr  8 01:23:57 2002
@@ -30,7 +30,7 @@
 
 static void sleep( unsigned howlong )
 {
-	current->state   = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(howlong);
 }
 
diff -Nru a/drivers/sound/sscape.c b/drivers/sound/sscape.c
--- a/drivers/sound/sscape.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/sscape.c	Mon Apr  8 01:23:57 2002
@@ -156,7 +156,7 @@
 
 static void sleep(unsigned howlong)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_INTERRUPTIBLE);
 	schedule_timeout(howlong);
 }
 
diff -Nru a/drivers/sound/swarm_cs4297a.c b/drivers/sound/swarm_cs4297a.c
--- a/drivers/sound/swarm_cs4297a.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/swarm_cs4297a.c	Mon Apr  8 01:23:57 2002
@@ -1632,7 +1632,7 @@
         s->dma_dac.hwptr = s->dma_dac.swptr = hwptr;
         spin_unlock_irqrestore(&s->lock, flags);
 	remove_wait_queue(&s->dma_dac.wait, &wait);
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	return 0;
 }
 
diff -Nru a/drivers/sound/vwsnd.c b/drivers/sound/vwsnd.c
--- a/drivers/sound/vwsnd.c	Mon Apr  8 01:23:57 2002
+++ b/drivers/sound/vwsnd.c	Mon Apr  8 01:23:57 2002
@@ -1839,7 +1839,7 @@
 			break;
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&aport->queue, &wait);
 	li_disable_interrupts(&devc->lith, mask);
 	if (aport == &devc->rport)
@@ -2209,7 +2209,7 @@
 			break;
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&wport->queue, &wait);
 	DBGPV("swstate = %d, hwstate = %d\n", wport->swstate, wport->hwstate);
 	DBGRV();
@@ -2285,18 +2285,18 @@
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (rport->flags & DISABLED ||
 			    file->f_flags & O_NONBLOCK) {
-				current->state = TASK_RUNNING;
+				set_current_state(TASK_RUNNING);
 				remove_wait_queue(&rport->queue, &wait);
 				return ret ? ret : -EAGAIN;
 			}
 			schedule();
 			if (signal_pending(current)) {
-				current->state = TASK_RUNNING;
+				set_current_state(TASK_RUNNING);
 				remove_wait_queue(&rport->queue, &wait);
 				return ret ? ret : -ERESTARTSYS;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&rport->queue, &wait);
 		pcm_input(devc, 0, 0);
 		/* nb bytes are available in userbuf. */
@@ -2360,18 +2360,18 @@
 			set_current_state(TASK_INTERRUPTIBLE);
 			if (wport->flags & DISABLED ||
 			    file->f_flags & O_NONBLOCK) {
-				current->state = TASK_RUNNING;
+				set_current_state(TASK_RUNNING);
 				remove_wait_queue(&wport->queue, &wait);
 				return ret ? ret : -EAGAIN;
 			}
 			schedule();
 			if (signal_pending(current)) {
-				current->state = TASK_RUNNING;
+				set_current_state(TASK_RUNNING);
 				remove_wait_queue(&wport->queue, &wait);
 				return ret ? ret : -ERESTARTSYS;
 			}
 		}
-		current->state = TASK_RUNNING;
+		set_current_state(TASK_RUNNING);
 		remove_wait_queue(&wport->queue, &wait);
 		/* nb bytes are available in userbuf. */
 		if (nb > count)

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
