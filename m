Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbTC0RDZ>; Thu, 27 Mar 2003 12:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263305AbTC0RCt>; Thu, 27 Mar 2003 12:02:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51589
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263298AbTC0RBH>; Thu, 27 Mar 2003 12:01:07 -0500
Date: Thu, 27 Mar 2003 18:18:35 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271818.h2RIIZ5m019664@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forward port the replacement to the horribly broken locking in 2.5
radio_cadet driver.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/drivers/media/radio/radio-cadet.c linux-2.5.66-ac1/drivers/media/radio/radio-cadet.c
--- linux-2.5.66-bk3/drivers/media/radio/radio-cadet.c	2003-03-27 17:13:02.000000000 +0000
+++ linux-2.5.66-ac1/drivers/media/radio/radio-cadet.c	2003-03-23 23:41:29.000000000 +0000
@@ -23,7 +23,9 @@
  * 2002-01-17	Adam Belay <ambx1@neo.rr.com>
  *		Updated to latest pnp code
  *
-*/
+ * 2003-01-31	Alan Cox <alan@redhat.com>
+ *		Cleaned up locking, delay code, general odds and ends
+ */
 
 #include <linux/module.h>	/* Modules 			*/
 #include <linux/init.h>		/* Initdata			*/
@@ -43,11 +45,11 @@
 static int curtuner=0;
 static int tunestat=0;
 static int sigstrength=0;
-static wait_queue_head_t tunerq,rdsq,readq;
+static wait_queue_head_t readq;
 struct timer_list tunertimer,rdstimer,readtimer;
 static __u8 rdsin=0,rdsout=0,rdsstat=0;
 static unsigned char rdsbuf[RDS_BUFFER];
-static int cadet_lock=0;
+static spinlock_t cadet_io_lock;
 
 static int cadet_probe(void);
 
@@ -58,37 +60,19 @@
  */
 static __u16 sigtable[2][4]={{5,10,30,150},{28,40,63,1000}};
 
-static void cadet_wake(unsigned long qnum)
-{
-        switch(qnum) {
-	case 0:           /* cadet_setfreq */
-	        wake_up(&tunerq);
-		break;
-	case 1:           /* cadet_getrds */
-	        wake_up(&rdsq);
-		break;
-	}	
-}
-
-
-
 static int cadet_getrds(void)
 {
         int rdsstat=0;
 
-	cadet_lock++;
+	spin_lock(&cadet_io_lock);
         outb(3,io);                 /* Select Decoder Control/Status */
 	outb(inb(io+1)&0x7f,io+1);  /* Reset RDS detection */
-	cadet_lock--;
-	init_timer(&rdstimer);
-	rdstimer.function=cadet_wake;
-	rdstimer.data=(unsigned long)1;
-	rdstimer.expires=jiffies+(HZ/10);
-	init_waitqueue_head(&rdsq);
-	add_timer(&rdstimer);
-	sleep_on(&rdsq);
+	spin_unlock(&cadet_io_lock);
 	
-	cadet_lock++;
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ/10);
+
+	spin_lock(&cadet_io_lock);	
         outb(3,io);                 /* Select Decoder Control/Status */
 	if((inb(io+1)&0x80)!=0) {
 	        rdsstat|=VIDEO_TUNER_RDS_ON;
@@ -96,32 +80,24 @@
 	if((inb(io+1)&0x10)!=0) {
 	        rdsstat|=VIDEO_TUNER_MBS_ON;
 	}
-	cadet_lock--;
+	spin_unlock(&cadet_io_lock);
 	return rdsstat;
 }
 
-
-
-
 static int cadet_getstereo(void)
 {
-        if(curtuner!=0) {          /* Only FM has stereo capability! */
+	int ret = 0;
+        if(curtuner != 0)	/* Only FM has stereo capability! */
 	        return 0;
-	}
-        cadet_lock++;
+
+	spin_lock(&cadet_io_lock);
         outb(7,io);          /* Select tuner control */
-        if((inb(io+1)&0x40)==0) {
-	        cadet_lock--;
-                return 1;    /* Stereo pilot detected */
-        }
-        else {
-	        cadet_lock--;
-                return 0;    /* Mono */
-        }
+	if( (inb(io+1) & 0x40) == 0)
+        	ret = 1;
+        spin_unlock(&cadet_io_lock);
+        return ret;
 }
 
-
-
 static unsigned cadet_gettune(void)
 {
         int curvol,i;
@@ -130,7 +106,9 @@
         /*
          * Prepare for read
          */
-	cadet_lock++;
+
+	spin_lock(&cadet_io_lock);
+	
         outb(7,io);       /* Select tuner control */
         curvol=inb(io+1); /* Save current volume/mute setting */
         outb(0x00,io+1);  /* Ensure WRITE-ENABLE is LOW */
@@ -152,13 +130,11 @@
          * Restore volume/mute setting
          */
         outb(curvol,io+1);
-	cadet_lock--;
+	spin_unlock(&cadet_io_lock);
 
 	return fifo;
 }
 
-
-
 static unsigned cadet_getfreq(void)
 {
         int i;
@@ -191,14 +167,13 @@
         return freq;
 }
 
-
-
 static void cadet_settune(unsigned fifo)
 {
         int i;
 	unsigned test;  
 
-	cadet_lock++;
+	spin_lock(&cadet_io_lock);
+	
 	outb(7,io);                /* Select tuner control */
 	/*
 	 * Write the shift register
@@ -217,11 +192,9 @@
 		test=0x1c|((fifo>>23)&0x02);
 		outb(test,io+1);
 	}
-	cadet_lock--;
+	spin_unlock(&cadet_io_lock);
 }
 
-
-
 static void cadet_setfreq(unsigned freq)
 {
         unsigned fifo;
@@ -253,92 +226,90 @@
         /*
          * Save current volume/mute setting
          */
-	cadet_lock++;
+
+	spin_lock(&cadet_io_lock);
 	outb(7,io);                /* Select tuner control */
         curvol=inb(io+1); 
+        spin_unlock(&cadet_io_lock);
 
 	/*
 	 * Tune the card
 	 */
 	for(j=3;j>-1;j--) {
 	        cadet_settune(fifo|(j<<16));
+	        
+	        spin_lock(&cadet_io_lock);
 		outb(7,io);         /* Select tuner control */
 		outb(curvol,io+1);
-		cadet_lock--;
-		init_timer(&tunertimer);
-		tunertimer.function=cadet_wake;
-		tunertimer.data=(unsigned long)0;
-		tunertimer.expires=jiffies+(HZ/10);
-		init_waitqueue_head(&tunerq);
-		add_timer(&tunertimer);
-		sleep_on(&tunerq);
+		spin_unlock(&cadet_io_lock);
+		
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/10);
+
 		cadet_gettune();
-		if((tunestat&0x40)==0) {   /* Tuned */
+		if((tunestat & 0x40) == 0) {   /* Tuned */
 		        sigstrength=sigtable[curtuner][j];
 			return;
 		}
-		cadet_lock++;
 	}
-	cadet_lock--;
 	sigstrength=0;
 }
 
 
 static int cadet_getvol(void)
 {
-        cadet_lock++;
+	int ret = 0;
+	
+	spin_lock(&cadet_io_lock);
+	
         outb(7,io);                /* Select tuner control */
-        if((inb(io+1)&0x20)!=0) {
-	        cadet_lock--;
-                return 0xffff;
-        }
-        else {
-	        cadet_lock--;
-                return 0;
-        }
+        if((inb(io + 1) & 0x20) != 0)
+        	ret = 0xffff;
+        
+        spin_unlock(&cadet_io_lock);
+        return ret;
 }
 
 
 static void cadet_setvol(int vol)
 {
-        cadet_lock++;
+	spin_lock(&cadet_io_lock);
         outb(7,io);                /* Select tuner control */
-        if(vol>0) {
+        if(vol>0)
                 outb(0x20,io+1);
-        }
-        else {
+        else
                 outb(0x00,io+1);
-        }
-	cadet_lock--;
+	spin_unlock(&cadet_io_lock);
 }  
 
-
-
 void cadet_handler(unsigned long data)
 {
 	/*
 	 * Service the RDS fifo
 	 */
-        if(cadet_lock==0) {
+
+	if(spin_trylock(&cadet_io_lock))
+	{
 	        outb(0x3,io);       /* Select RDS Decoder Control */
 		if((inb(io+1)&0x20)!=0) {
 		        printk(KERN_CRIT "cadet: RDS fifo overflow\n");
 		}
 		outb(0x80,io);      /* Select RDS fifo */
 		while((inb(io)&0x80)!=0) {
-		        rdsbuf[rdsin++]=inb(io+1);
-			if(rdsin==rdsout) {
-			        printk(KERN_CRIT "cadet: RDS buffer overflow\n");
-			}
+		        rdsbuf[rdsin]=inb(io+1);
+			if(rdsin==rdsout)
+			        printk(KERN_WARNING "cadet: RDS buffer overflow\n");
+			else
+				rdsin++;
 		}
+		spin_unlock(&cadet_io_lock);
 	}
 
 	/*
 	 * Service pending read
 	 */
-	if( rdsin!=rdsout) {
+	if( rdsin!=rdsout)
 	        wake_up_interruptible(&readq);
-	}
 
 	/* 
 	 * Clean up and exit
@@ -359,10 +330,10 @@
 	unsigned char readbuf[RDS_BUFFER];
 
         if(rdsstat==0) {
-	        cadet_lock++;
+		spin_lock(&cadet_io_lock);
 	        rdsstat=1;
 		outb(0x80,io);        /* Select RDS fifo */
-		cadet_lock--;
+		spin_unlock(&cadet_io_lock);
 		init_timer(&readtimer);
 		readtimer.function=cadet_handler;
 		readtimer.data=(unsigned long)0;
@@ -370,14 +341,13 @@
 		add_timer(&readtimer);
 	}
 	if(rdsin==rdsout) {
-  	        if (file->f_flags & O_NONBLOCK) {
+  	        if (file->f_flags & O_NONBLOCK)
 		        return -EWOULDBLOCK;
-		}
 	        interruptible_sleep_on(&readq);
 	}		
-	while((i<count)&&(rdsin!=rdsout)) {
+	while( i<count && rdsin!=rdsout)
 	        readbuf[i++]=rdsbuf[rdsout++];
-	}
+
 	if (copy_to_user(data,readbuf,i))
 	        return -EFAULT;
 	return i;
@@ -515,10 +485,8 @@
 
 static int cadet_release(struct inode *inode, struct file *file)
 {
-        if(rdsstat==1) {
-                del_timer(&readtimer);
-		rdsstat=0;
-	}
+	del_timer_sync(&readtimer);
+	rdsstat=0;
 	users--;
 	return 0;
 }
@@ -595,13 +563,15 @@
 	return -1;
 }
 
-	/* 
-	 * io should only be set if the user has used something like
-	 * isapnp (the userspace program) to initialize this card for us
-	 */
+/* 
+ * io should only be set if the user has used something like
+ * isapnp (the userspace program) to initialize this card for us
+ */
 
 static int __init cadet_init(void)
 {
+	spin_lock_init(&cadet_io_lock);
+	
 	/*
 	 *	If a probe was requested then probe ISAPnP first (safest)
 	 */
