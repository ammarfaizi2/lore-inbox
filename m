Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWAPJXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWAPJXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWAPJXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:23:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37099 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932263AbWAPJXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:02 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Ingo Molnar <mingo@elte.hu>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 02/25] bttv semaphore to mutex conversion
Date: Mon, 16 Jan 2006 07:11:19 -0200
Message-id: <20060116091119.PS17726800002@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Ingo Molnar <mingo@elte.hu>

Semaphore to mutex conversion.

The conversion was generated via scripts, and the result was validated
automatically via a script as well.

build-tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/bttv-driver.c |   60 +++++++++++++++++++------------------
 drivers/media/video/bttvp.h       |    5 ++-
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
index 1c6cfe9..aa4c4c5 100644
--- a/drivers/media/video/bttv-driver.c
+++ b/drivers/media/video/bttv-driver.c
@@ -684,16 +684,16 @@ int check_alloc_btres(struct bttv *btv, 
 		return 1;
 
 	/* is it free? */
-	down(&btv->reslock);
+	mutex_lock(&btv->reslock);
 	if (btv->resources & bit) {
 		/* no, someone else uses it */
-		up(&btv->reslock);
+		mutex_unlock(&btv->reslock);
 		return 0;
 	}
 	/* it's free, grab it */
 	fh->resources  |= bit;
 	btv->resources |= bit;
-	up(&btv->reslock);
+	mutex_unlock(&btv->reslock);
 	return 1;
 }
 
@@ -716,10 +716,10 @@ void free_btres(struct bttv *btv, struct
 		/* trying to free ressources not allocated by us ... */
 		printk("bttv: BUG! (btres)\n");
 	}
-	down(&btv->reslock);
+	mutex_lock(&btv->reslock);
 	fh->resources  &= ~bits;
 	btv->resources &= ~bits;
-	up(&btv->reslock);
+	mutex_unlock(&btv->reslock);
 }
 
 /* ----------------------------------------------------------------------- */
@@ -1536,12 +1536,12 @@ static int bttv_common_ioctls(struct btt
 	case VIDIOCSFREQ:
 	{
 		unsigned long *freq = arg;
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		btv->freq=*freq;
 		bttv_call_i2c_clients(btv,VIDIOCSFREQ,freq);
 		if (btv->has_matchbox && btv->radio_user)
 			tea5757_set_freq(btv,*freq);
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 
@@ -1571,10 +1571,10 @@ static int bttv_common_ioctls(struct btt
 		if (v->mode >= BTTV_TVNORMS)
 			return -EINVAL;
 
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		set_tvnorm(btv,v->mode);
 		bttv_call_i2c_clients(btv,cmd,v);
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 
@@ -1611,17 +1611,17 @@ static int bttv_common_ioctls(struct btt
 		if (v->norm >= BTTV_TVNORMS)
 			return -EINVAL;
 
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		if (channel == btv->input &&
 		    v->norm == btv->tvnorm) {
 			/* nothing to do */
-			up(&btv->lock);
+			mutex_unlock(&btv->lock);
 			return 0;
 		}
 
 		btv->tvnorm = v->norm;
 		set_input(btv,v->channel);
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 
@@ -1634,14 +1634,14 @@ static int bttv_common_ioctls(struct btt
 		v->flags |= VIDEO_AUDIO_MUTABLE;
 		v->mode  = VIDEO_SOUND_MONO;
 
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		bttv_call_i2c_clients(btv,cmd,v);
 
 		/* card specific hooks */
 		if (btv->audio_hook)
 			btv->audio_hook(btv,v,0);
 
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 	case VIDIOCSAUDIO:
@@ -1652,7 +1652,7 @@ static int bttv_common_ioctls(struct btt
 		if (audio >= bttv_tvcards[btv->c.type].audio_inputs)
 			return -EINVAL;
 
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		audio_mux(btv, (v->flags&VIDEO_AUDIO_MUTE) ? AUDIO_MUTE : AUDIO_UNMUTE);
 		bttv_call_i2c_clients(btv,cmd,v);
 
@@ -1660,7 +1660,7 @@ static int bttv_common_ioctls(struct btt
 		if (btv->audio_hook)
 			btv->audio_hook(btv,v,1);
 
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 
@@ -1694,10 +1694,10 @@ static int bttv_common_ioctls(struct btt
 		if (i == BTTV_TVNORMS)
 			return -EINVAL;
 
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		set_tvnorm(btv,i);
 		i2c_vidiocschan(btv);
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 	case VIDIOC_QUERYSTD:
@@ -1755,9 +1755,9 @@ static int bttv_common_ioctls(struct btt
 
 		if (*i > bttv_tvcards[btv->c.type].video_inputs)
 			return -EINVAL;
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		set_input(btv,*i);
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 
@@ -1769,7 +1769,7 @@ static int bttv_common_ioctls(struct btt
 			return -EINVAL;
 		if (0 != t->index)
 			return -EINVAL;
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		memset(t,0,sizeof(*t));
 		strcpy(t->name, "Television");
 		t->type       = V4L2_TUNER_ANALOG_TV;
@@ -1804,7 +1804,7 @@ static int bttv_common_ioctls(struct btt
 			}
 		}
 		/* FIXME: fill capability+audmode */
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 	case VIDIOC_S_TUNER:
@@ -1815,7 +1815,7 @@ static int bttv_common_ioctls(struct btt
 			return -EINVAL;
 		if (0 != t->index)
 			return -EINVAL;
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		{
 			struct video_audio va;
 			memset(&va, 0, sizeof(struct video_audio));
@@ -1832,7 +1832,7 @@ static int bttv_common_ioctls(struct btt
 			if (btv->audio_hook)
 				btv->audio_hook(btv,&va,1);
 		}
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 
@@ -1853,12 +1853,12 @@ static int bttv_common_ioctls(struct btt
 			return -EINVAL;
 		if (unlikely (f->type != V4L2_TUNER_ANALOG_TV))
 			return -EINVAL;
-		down(&btv->lock);
+		mutex_lock(&btv->lock);
 		btv->freq = f->frequency;
 		bttv_call_i2c_clients(btv,VIDIOCSFREQ,&btv->freq);
 		if (btv->has_matchbox && btv->radio_user)
 			tea5757_set_freq(btv,btv->freq);
-		up(&btv->lock);
+		mutex_unlock(&btv->lock);
 		return 0;
 	}
 	case VIDIOC_LOG_STATUS:
@@ -3156,7 +3156,7 @@ static int radio_open(struct inode *inod
 		return -ENODEV;
 
 	dprintk("bttv%d: open called (radio)\n",btv->c.nr);
-	down(&btv->lock);
+	mutex_lock(&btv->lock);
 
 	btv->radio_user++;
 
@@ -3165,7 +3165,7 @@ static int radio_open(struct inode *inod
 	bttv_call_i2c_clients(btv,AUDC_SET_RADIO,&btv->tuner_type);
 	audio_mux(btv,AUDIO_RADIO);
 
-	up(&btv->lock);
+	mutex_unlock(&btv->lock);
 	return 0;
 }
 
@@ -3920,8 +3920,8 @@ static int __devinit bttv_probe(struct p
 	sprintf(btv->c.name,"bttv%d",btv->c.nr);
 
 	/* initialize structs / fill in defaults */
-	init_MUTEX(&btv->lock);
-	init_MUTEX(&btv->reslock);
+	mutex_init(&btv->lock);
+	mutex_init(&btv->reslock);
 	spin_lock_init(&btv->s_lock);
 	spin_lock_init(&btv->gpio_lock);
 	init_waitqueue_head(&btv->gpioq);
diff --git a/drivers/media/video/bttvp.h b/drivers/media/video/bttvp.h
index dd00c20..9cb72f1 100644
--- a/drivers/media/video/bttvp.h
+++ b/drivers/media/video/bttvp.h
@@ -35,6 +35,7 @@
 #include <linux/videodev.h>
 #include <linux/pci.h>
 #include <linux/input.h>
+#include <linux/mutex.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 
@@ -309,9 +310,9 @@ struct bttv {
 
 	/* locking */
 	spinlock_t s_lock;
-	struct semaphore lock;
+	struct mutex lock;
 	int resources;
-	struct semaphore reslock;
+	struct mutex reslock;
 #ifdef VIDIOC_G_PRIORITY
 	struct v4l2_prio_state prio;
 #endif

