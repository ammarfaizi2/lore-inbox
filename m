Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUBEOmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUBEOmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:42:06 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:133 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265178AbUBEOkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:40:55 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 5 Feb 2004 15:17:38 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: i2c cleanups
Message-ID: <20040205141738.GA23246@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch brings a few cleanups/fixes for the v4l-related i2c modules:

 * fix "badness in interruptible_sleep_on"
 * use completions instead of semaphores to sync
   rmmod + kernel thread exit
 * drop some some obsolete code.
 * minor tweaks for some tv cards.

Please apply,

  Gerd

diff -u linux-2.6.2/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.2/drivers/media/video/msp3400.c	2004-02-05 13:31:21.000000000 +0100
+++ linux/drivers/media/video/msp3400.c	2004-02-05 13:44:38.687242266 +0100
@@ -87,11 +87,13 @@
 	int dfp_regs[DFP_COUNT];
 
 	/* thread */
-	struct task_struct  *thread;
+	pid_t                tpid;
+	struct completion    texit;
 	wait_queue_head_t    wq;
 
-	struct semaphore    *notify;
-	int                  active,restart,rmmod;
+	int                  active:1;
+	int                  restart:1;
+	int                  rmmod:1;
 
 	int                  watch_stereo;
 	struct timer_list    wake_stereo;
@@ -101,14 +103,12 @@
 #define HAVE_SIMPLE(msp)  ((msp->rev1      & 0xff) >= 'D'-'@')
 #define HAVE_RADIO(msp)   ((msp->rev1      & 0xff) >= 'G'-'@')
 
-#define MSP3400_MAX 4
-static struct i2c_client *msps[MSP3400_MAX];
-
 #define VIDEO_MODE_RADIO 16      /* norm magic for radio mode */
 
 /* ---------------------------------------------------------------------- */
 
-#define dprintk     if (debug) printk
+#define dprintk      if (debug >= 1) printk
+#define d2printk     if (debug >= 2) printk
 
 MODULE_PARM(once,"i");
 MODULE_PARM(debug,"i");
@@ -735,6 +735,22 @@
  * in the ioctl while doing the sound carrier & stereo detect
  */
 
+static int msp34xx_sleep(struct msp3400c *msp, int timeout)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	
+	add_wait_queue(&msp->wq, &wait);
+	if (!msp->rmmod) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (timeout < 0)
+			schedule();
+		else
+			schedule_timeout(timeout);
+	}
+	remove_wait_queue(&msp->wq, &wait);
+	return msp->rmmod || signal_pending(current);
+}
+
 static void msp3400c_stereo_wake(unsigned long data)
 {
 	struct msp3400c *msp = (struct msp3400c*)data;   /* XXX alpha ??? */
@@ -771,26 +787,16 @@
 	struct CARRIER_DETECT *cd;
 	int count, max1,max2,val1,val2, val,this;
 	
-	lock_kernel();
 	daemonize("msp3400");
-	msp->thread = current;
-	unlock_kernel();
-
+	allow_signal(SIGTERM);
 	printk("msp3400: daemon started\n");
-	if(msp->notify != NULL)
-		up(msp->notify);
 
 	for (;;) {
-		if (msp->rmmod)
-			goto done;
-		if (debug > 1)
-			printk("msp3400: thread: sleep\n");
-		interruptible_sleep_on(&msp->wq);
-		if (debug > 1)
-			printk("msp3400: thread: wakeup\n");
-		if (msp->rmmod || signal_pending(current))
+		d2printk("msp3400: thread: sleep\n");
+		if (msp34xx_sleep(msp,-1))
 			goto done;
 
+		d2printk("msp3400: thread: wakeup\n");
 		msp->active = 1;
 
 		if (msp->watch_stereo) {
@@ -800,9 +806,7 @@
 		}
 
 		/* some time for the tuner to sync */
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/5);
-		if (signal_pending(current))
+		if (msp34xx_sleep(msp,HZ/5))
 			goto done;
 		
 	restart:
@@ -835,9 +839,7 @@
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
 
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ/10);
-			if (signal_pending(current))
+			if (msp34xx_sleep(msp,HZ/10))
 				goto done;
 			if (msp->restart)
 				msp->restart = 0;
@@ -872,9 +874,7 @@
 		for (this = 0; this < count; this++) {
 			msp3400c_setcarrier(client, cd[this].cdo,cd[this].cdo);
 
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(HZ/10);
-			if (signal_pending(current))
+			if (msp34xx_sleep(msp,HZ/10))
 				goto done;
 			if (msp->restart)
 				goto restart;
@@ -973,13 +973,9 @@
 	}
 
 done:
-	dprintk(KERN_DEBUG "msp3400: thread: exit\n");
 	msp->active = 0;
-	msp->thread = NULL;
-
-	if(msp->notify != NULL)
-		up(msp->notify);
-	return 0;
+	dprintk(KERN_DEBUG "msp3400: thread: exit\n");
+        complete_and_exit(&msp->texit, 0);
 }
 
 /* ----------------------------------------------------------------------- */
@@ -1019,26 +1015,16 @@
 	struct msp3400c *msp = i2c_get_clientdata(client);
 	int mode,val,i,std;
     
-	lock_kernel();
 	daemonize("msp3410 [auto]");
-	msp->thread = current;
-	unlock_kernel();
-
+	allow_signal(SIGTERM);
 	printk("msp3410: daemon started\n");
-	if(msp->notify != NULL)
-		up(msp->notify);
-		
+
 	for (;;) {
-		if (msp->rmmod)
-			goto done;
-		if (debug > 1)
-			printk(KERN_DEBUG "msp3410: thread: sleep\n");
-		interruptible_sleep_on(&msp->wq);
-		if (debug > 1)
-			printk(KERN_DEBUG "msp3410: thread: wakeup\n");
-		if (msp->rmmod || signal_pending(current))
+		d2printk(KERN_DEBUG "msp3410: thread: sleep\n");
+		if (msp34xx_sleep(msp,-1))
 			goto done;
 
+		d2printk(KERN_DEBUG "msp3410: thread: wakeup\n");
 		msp->active = 1;
 
 		if (msp->watch_stereo) {
@@ -1048,9 +1034,7 @@
 		}
 	
 		/* some time for the tuner to sync */
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/5);
-		if (signal_pending(current))
+		if (msp34xx_sleep(msp,HZ/5))
 			goto done;
 
 	restart:
@@ -1109,9 +1093,7 @@
 		} else {
 			/* triggered autodetect */
 			for (;;) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(HZ/10);
-				if (signal_pending(current))
+				if (msp34xx_sleep(msp,HZ/10))
 					goto done;
 				if (msp->restart)
 					goto restart;
@@ -1222,12 +1204,9 @@
 	}
 
 done:
-	dprintk(KERN_DEBUG "msp3410: thread: exit\n");
 	msp->active = 0;
-	msp->thread = NULL;
-
-	if(msp->notify != NULL)
-		up(msp->notify);
+	dprintk(KERN_DEBUG "msp3410: thread: exit\n");
+        complete_and_exit(&msp->texit, 0);
 	return 0;
 }
 
@@ -1257,10 +1236,9 @@
 
 static int msp_attach(struct i2c_adapter *adap, int addr, int kind)
 {
-	DECLARE_MUTEX_LOCKED(sem);
 	struct msp3400c *msp;
         struct i2c_client *c;
-	int i, rc;
+	int i;
 
         client_template.adapter = adap;
         client_template.addr = addr;
@@ -1342,24 +1320,13 @@
 	printk("\n");
 
 	/* startup control thread */
-	msp->notify = &sem;
-	rc = kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
-			   (void *)c, 0);
-	if (rc < 0)
+	init_completion(&msp->texit);
+	msp->tpid = kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
+				  (void *)c, 0);
+	if (msp->tpid < 0)
 		printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
-	else
-		down(&sem);
-	msp->notify = NULL;
 	wake_up_interruptible(&msp->wq);
 
-	/* update our own array */
-	for (i = 0; i < MSP3400_MAX; i++) {
-		if (NULL == msps[i]) {
-			msps[i] = c;
-			break;
-		}
-	}
-	
 	/* done */
         i2c_attach_client(c);
 	return 0;
@@ -1367,30 +1334,17 @@
 
 static int msp_detach(struct i2c_client *client)
 {
-	DECLARE_MUTEX_LOCKED(sem);
 	struct msp3400c *msp  = i2c_get_clientdata(client);
-	int i;
 	
 	/* shutdown control thread */
-	del_timer(&msp->wake_stereo);
-	if (msp->thread) 
-	{
-		msp->notify = &sem;
+	del_timer_sync(&msp->wake_stereo);
+	if (msp->tpid >= 0) {
 		msp->rmmod = 1;
 		wake_up_interruptible(&msp->wq);
-		down(&sem);
-		msp->notify = NULL;
+		wait_for_completion(&msp->texit);
 	}
     	msp3400c_reset(client);
 
-        /* update our own array */
-	for (i = 0; i < MSP3400_MAX; i++) {
-		if (client == msps[i]) {
-			msps[i] = NULL;
-			break;
-		}
-	}
-
 	i2c_detach_client(client);
 	kfree(msp);
 	kfree(client);
@@ -1403,8 +1357,13 @@
 	if (adap->class & I2C_ADAP_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, msp_attach);
 #else
-	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
+	case I2C_ALGO_BIT | I2C_HW_B_BT848:
+	//case I2C_ALGO_SAA7134:
 		return i2c_probe(adap, &addr_data, msp_attach);
+		break;
+	}
 #endif
 	return 0;
 }
diff -u linux-2.6.2/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.2/drivers/media/video/tda9887.c	2004-02-05 13:29:17.000000000 +0100
+++ linux/drivers/media/video/tda9887.c	2004-02-05 13:44:38.689241897 +0100
@@ -24,8 +24,12 @@
     
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = {I2C_CLIENT_END};
-static unsigned short normal_i2c_range[] = {0x86>>1,0x86>>1,I2C_CLIENT_END};
+static unsigned short normal_i2c[] = {
+	0x86 >>1,
+	0x96 >>1,
+	I2C_CLIENT_END,
+};
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* insmod options */
diff -u linux-2.6.2/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.6.2/drivers/media/video/tvaudio.c	2004-02-05 13:30:11.000000000 +0100
+++ linux/drivers/media/video/tvaudio.c	2004-02-05 13:44:38.692241344 +0100
@@ -122,9 +122,10 @@
 	__u16 left,right,treble,bass,mode;
 	int prevmode;
 	int norm;
+
 	/* thread */
-	struct task_struct  *thread;
-	struct semaphore    *notify;
+	pid_t                tpid;
+	struct completion    texit;
 	wait_queue_head_t    wq;
 	struct timer_list    wt;
 	int                  done;
@@ -269,23 +270,24 @@
 
 static int chip_thread(void *data)
 {
+	DECLARE_WAITQUEUE(wait, current);
         struct CHIPSTATE *chip = data;
 	struct CHIPDESC  *desc = chiplist + chip->type;
 	
-	lock_kernel();
 	daemonize("%s",i2c_clientname(&chip->c));
-	chip->thread = current;
-	unlock_kernel();
-
+	allow_signal(SIGTERM);
 	dprintk("%s: thread started\n", i2c_clientname(&chip->c));
-	if(chip->notify != NULL)
-		up(chip->notify);
-
+	
 	for (;;) {
-		interruptible_sleep_on(&chip->wq);
-		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
+		add_wait_queue(&chip->wq, &wait);
+		if (!chip->done) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+		}
+		remove_wait_queue(&chip->wq, &wait);
 		if (chip->done || signal_pending(current))
 			break;
+		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
 
 		/* don't do anything for radio or if mode != auto */
 		if (chip->norm == VIDEO_MODE_RADIO || chip->mode != 0)
@@ -298,11 +300,8 @@
 		mod_timer(&chip->wt, jiffies+2*HZ);
 	}
 
-	chip->thread = NULL;
 	dprintk("%s: thread exiting\n", i2c_clientname(&chip->c));
-	if(chip->notify != NULL)
-		up(chip->notify);
-
+        complete_and_exit(&chip->texit, 0);
 	return 0;
 }
 
@@ -1420,7 +1419,6 @@
 {
 	struct CHIPSTATE *chip;
 	struct CHIPDESC  *desc;
-	int rc;
 
 	chip = kmalloc(sizeof(*chip),GFP_KERNEL);
 	if (!chip)
@@ -1480,21 +1478,18 @@
 		chip_write(chip,desc->treblereg,desc->treblefunc(chip->treble));
 	}
 
+	chip->tpid = -1;
 	if (desc->checkmode) {
 		/* start async thread */
-		DECLARE_MUTEX_LOCKED(sem);
-		chip->notify = &sem;
 		init_timer(&chip->wt);
 		chip->wt.function = chip_thread_wake;
 		chip->wt.data     = (unsigned long)chip;
 		init_waitqueue_head(&chip->wq);
-		rc = kernel_thread(chip_thread,(void *)chip,0);
-		if (rc < 0)
+		init_completion(&chip->texit);
+		chip->tpid = kernel_thread(chip_thread,(void *)chip,0);
+		if (chip->tpid < 0)
 			printk(KERN_WARNING "%s: kernel_thread() failed\n",
 			       i2c_clientname(&chip->c));
-		else
-			down(&sem);
-		chip->notify = NULL;
 		wake_up_interruptible(&chip->wq);
 	}
 	return 0;
@@ -1520,15 +1515,12 @@
 {
 	struct CHIPSTATE *chip = i2c_get_clientdata(client);
 
-	del_timer(&chip->wt);
-	if (NULL != chip->thread) {
+	del_timer_sync(&chip->wt);
+	if (chip->tpid >= 0) {
 		/* shutdown async thread */
-		DECLARE_MUTEX_LOCKED(sem);
-		chip->notify = &sem;
 		chip->done = 1;
 		wake_up_interruptible(&chip->wq);
-		down(&sem);
-		chip->notify = NULL;
+		wait_for_completion(&chip->texit);
 	}
 	
 	i2c_detach_client(&chip->c);
diff -u linux-2.6.2/drivers/media/video/tvmixer.c linux/drivers/media/video/tvmixer.c
--- linux-2.6.2/drivers/media/video/tvmixer.c	2004-02-05 13:32:40.000000000 +0100
+++ linux/drivers/media/video/tvmixer.c	2004-02-05 13:44:38.694240975 +0100
@@ -134,6 +134,8 @@
 		va.volume  = max(left,right);
 		va.balance = (32768*min(left,right)) / (va.volume ? va.volume : 1);
 		va.balance = (left<right) ? (65535-va.balance) : va.balance;
+		if (va.volume)
+			va.flags &= ~VIDEO_AUDIO_MUTE;
 		client->driver->command(client,VIDIOCSAUDIO,&va);
 		client->driver->command(client,VIDIOCGAUDIO,&va);
 		/* fall throuth */
@@ -267,6 +269,7 @@
 #else
 	/* TV card ??? */
 	switch (client->adapter->id) {
+	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
 	case I2C_ALGO_BIT | I2C_HW_B_BT848:
 	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
 		/* ok, have a look ... */
diff -u linux-2.6.2/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.2/drivers/media/video/tuner.c	2004-02-05 13:32:28.000000000 +0100
+++ linux/drivers/media/video/tuner.c	2004-02-05 13:44:38.759228988 +0100
@@ -746,6 +746,7 @@
         printk("tuner: microtune: companycode=%04x part=%02x rev=%02x\n",
 	       company_code,buf[0x13],buf[0x14]);
 	switch (company_code) {
+	case 0x30bf:
 	case 0x3cbf:
 	case 0x3dbf:
 	case 0x4d54:
@@ -1060,6 +1061,7 @@
 		return i2c_probe(adap, &addr_data, tuner_attach);
 #else
 	switch (adap->id) {
+	case I2C_ALGO_BIT | I2C_HW_SMBUS_VOODOO3:
 	case I2C_ALGO_BIT | I2C_HW_B_BT848:
 	case I2C_ALGO_BIT | I2C_HW_B_RIVA:
 	case I2C_ALGO_SAA7134:
