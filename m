Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282234AbRK2Asx>; Wed, 28 Nov 2001 19:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282228AbRK2As2>; Wed, 28 Nov 2001 19:48:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4371 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282232AbRK2Arx>; Wed, 28 Nov 2001 19:47:53 -0500
Subject: Re: [PATCH] fix for drivers/char/pc_keyb.c in 2.5.1-pre3
To: greg@kroah.com (Greg KH)
Date: Thu, 29 Nov 2001 00:55:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011128163810.C2512@kroah.com> from "Greg KH" at Nov 28, 2001 04:38:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169FUY-0006k8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's a patch for 2.5.1-pre3 to fix the compile time problems in
> drivers/char/pc_keyb.c.  It also fixes the places where the flags
> variable is the wrong type.

This is the diff I'm using. It

-	Fixes the initrd lock
-	Fixes keyboard (as with Greg but with the formatting unmangled too)
-	Fixes wdt_pci (bitops on it)
-	Makes wdt use the same locking as wdt_pci
-	Returns pc110pad to the coding style and redoes the locks to
	kill old style locking totally

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.1p3/drivers/block/rd.c linux.ac/drivers/block/rd.c
--- linux.1p3/drivers/block/rd.c	Thu Nov 29 01:18:32 2001
+++ linux.ac/drivers/block/rd.c	Thu Nov 29 01:41:37 2001
@@ -409,13 +409,13 @@
 {
 	extern void free_initrd_mem(unsigned long, unsigned long);
 
-	spin_lock( &initrd_users_lock );
+	spin_lock(&initrd_users_lock);
 	if (!--initrd_users) {
-		spin_unlock( &initrd_users_lock );
+		spin_unlock(&initrd_users_lock);
 		free_initrd_mem(initrd_start, initrd_end);
 		initrd_start = 0;
 	} else {
-		spin_unlock( &initrd_users_lock );
+		spin_unlock(&initrd_users_lock);
 	}
 		
 	blkdev_put(inode->i_bdev, BDEV_FILE);
@@ -437,10 +437,11 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (unit == INITRD_MINOR) {
-		spin_lock( &initrd_users_lock );
+		spin_lock(&initrd_users_lock);
 		initrd_users++;
-		if (!initrd_start) return -ENODEV;
-		spin_unlock( &initrd_users_lock );
+		spin_unlock(&initrd_users_lock);
+		if (!initrd_start) 
+			return -ENODEV;
 		filp->f_op = &initrd_fops;
 		return 0;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.1p3/drivers/char/pc110pad.c linux.ac/drivers/char/pc110pad.c
--- linux.1p3/drivers/char/pc110pad.c	Thu Nov 29 01:18:32 2001
+++ linux.ac/drivers/char/pc110pad.c	Thu Nov 29 01:39:21 2001
@@ -68,8 +68,8 @@
 /* driver/filesystem interface management */
 static wait_queue_head_t queue;
 static struct fasync_struct *asyncptr;
-static active_count = 0; 	/* number of concurrent open()s */
-static spinlock_t active_lock = SPIN_LOCK_UNLOCKED;
+static int active_count = 0; 	/* number of concurrent open()s */
+static spinlock_t pc110_lock = SPIN_LOCK_UNLOCKED;
 /* this lock should be held when referencing active_count */
 static struct semaphore reader_lock;
 
@@ -482,15 +482,14 @@
 	int thisd, thisdd, thisx, thisy;
 	int b;
 	unsigned long flags;
-	
-	save_flags(flags);
-	cli();
+
+	spin_lock_irqsave(&pc110_lock, flags);	
 	read_raw_pad(&thisd, &thisdd, &thisx, &thisy);
 	d[0]=(thisd?0x80:0) | (thisdd?0x40:0) | bounce;
 	d[1]=(recent_transition?0x80:0)+transition_count;
 	read_button(&b);
 	d[2]=(synthesize_tap<<4) | (b?0x01:0);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&pc110_lock, flags);
 }
 
 /**
@@ -586,11 +585,12 @@
  
 static int close_pad(struct inode * inode, struct file * file)
 {
+	unsigned long flags;
 	fasync_pad(-1, file, 0);
-	spin_lock( &active_lock );
+	spin_lock_irqsave(&pc110_lock, flags);
 	if (!--active_count)
 		outb(0x30, current_params.io+2);  /* switch off digitiser */
-	spin_unlock( &active_lock );	
+	spin_unlock_irqrestore(&active_lock, flags);	
 	return 0;
 }
 
@@ -610,16 +610,13 @@
 {
 	unsigned long flags;
 	
-	spin_lock( &active_lock );
+       	spin_lock_irqsave(&pc110_lock, flags);
 	if (active_count++)
         {
-		spin_unlock( &active_lock );
+        	spin_unlock_irqrestore(&pc110_lock, flags);
 		return 0;
 	}
-	spin_unlock( &active_lock );
 
-	save_flags(flags);
-	cli();
 	outb(0x30, current_params.io+2);	/* switch off digitiser */
 	pad_irq(0,0,0);		/* read to flush any pending bytes */
 	pad_irq(0,0,0);		/* read to flush any pending bytes */
@@ -634,7 +631,7 @@
 	synthesize_tap=0;
 	del_timer(&bounce_timer);
 	del_timer(&tap_timer);
-	restore_flags(flags);
+       	spin_unlock_irqrestore(&pc110_lock, flags);
 
 	return 0;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.1p3/drivers/char/pc_keyb.c linux.ac/drivers/char/pc_keyb.c
--- linux.1p3/drivers/char/pc_keyb.c	Thu Nov 29 01:18:32 2001
+++ linux.ac/drivers/char/pc_keyb.c	Thu Nov 29 01:44:51 2001
@@ -406,7 +406,7 @@
 
        if (rqst == PM_RESUME) {
                if (queue) {                    /* Aux port detected */
-		       spin_lock_irqsave( &aux_count_lock, flags);
+		       spin_lock_irqsave(&aux_count_lock, flags);
               	       if ( aux_count == 0) {   /* Mouse not in use */ 
                                spin_lock(&kbd_controller_lock);
 			       /*
@@ -420,9 +420,9 @@
 			       kbd_write_command(KBD_CCMD_WRITE_MODE);
 			       kb_wait();
 			       kbd_write_output(AUX_INTS_OFF);
-			       spin_unlock(&kbd_controller_lock, flags);
+			       spin_unlock(&kbd_controller_lock);
 		       }
-		       spin_unlock_irqrestore( &aux_count_lock,flags );
+		       spin_unlock_irqrestore(&aux_count_lock, flags);
 	       }
        }
 #endif
@@ -433,7 +433,7 @@
 static inline void handle_mouse_event(unsigned char scancode)
 {
 #ifdef CONFIG_PSMOUSE
-	int flags;
+	unsigned long flags;
 	static unsigned char prev_code;
 	if (mouse_reply_expected) {
 		if (scancode == AUX_ACK) {
@@ -452,7 +452,7 @@
 
 	prev_code = scancode;
 	add_mouse_randomness(scancode);
-	spin_lock_irqsave( &aux_count_lock, flags);
+	spin_lock_irqsave(&aux_count_lock, flags);
 	if ( aux_count ) {
 		int head = queue->head;
 
@@ -464,7 +464,7 @@
 			wake_up_interruptible(&queue->proc_list);
 		}
 	}
-	spin_unlock_irqrestore( &aux_count_lock, flags);
+	spin_unlock_irqrestore(&aux_count_lock, flags);
 #endif
 }
 
@@ -1052,14 +1052,14 @@
 
 static int release_aux(struct inode * inode, struct file * file)
 {
-	int flags;
+	unsigned long flags;
 	fasync_aux(-1, file, 0);
-	spin_lock_irqsave( &aux_count, flags );
+	spin_lock_irqsave(&aux_count, flags);
 	if ( --aux_count ) {
-		spin_unlock_irqrestore( &aux_count_lock );
+		spin_unlock_irqrestore(&aux_count_lock, flags);
 		return 0;
 	}
-	spin_unlock_irqrestore( &aux_count_lock, flags );
+	spin_unlock_irqrestore(&aux_count_lock, flags);
 	kbd_write_cmd(AUX_INTS_OFF);			    /* Disable controller ints */
 	kbd_write_command_w(KBD_CCMD_MOUSE_DISABLE);
 	aux_free_irq(AUX_DEV);
@@ -1073,16 +1073,16 @@
 
 static int open_aux(struct inode * inode, struct file * file)
 {
-	int flags;
-	spin_lock_irqsave( &aux_count_lock, flags );
+	unsigned long flags;
+	spin_lock_irqsave(&aux_count_lock, flags);
 	if ( aux_count++ ) {
-		spin_unlock_irqrestore( &aux_count_lock );
+		spin_unlock_irqrestore(&aux_count_lock, flags);
 		return 0;
 	}
 	queue->head = queue->tail = 0;		/* Flush input queue */
 	if (aux_request_irq(keyboard_interrupt, AUX_DEV)) {
 		aux_count--;
-		spin_unlock_irqrestore( &aux_count_lock, flags );
+		spin_unlock_irqrestore(&aux_count_lock, flags);
 		return -EBUSY;
 	}
 	kbd_write_command_w(KBD_CCMD_MOUSE_ENABLE);	/* Enable the
@@ -1094,7 +1094,7 @@
 	mdelay(2);			/* Ensure we follow the kbc access delay rules.. */
 
 	send_data(KBD_CMD_ENABLE);	/* try to workaround toshiba4030cdt problem */
-	spin_unlock_irqrestore( &aux_count_lock, flags );
+	spin_unlock_irqrestore(&aux_count_lock, flags);
 	return 0;
 }
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.1p3/drivers/char/wdt.c linux.ac/drivers/char/wdt.c
--- linux.1p3/drivers/char/wdt.c	Thu Nov 29 01:18:32 2001
+++ linux.ac/drivers/char/wdt.c	Thu Nov 29 01:22:32 2001
@@ -50,7 +50,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 
-static int wdt_is_open;
+static unsigned long wdt_is_open;
 
 /*
  *	You must set these - there is no sane way to probe for this board.
@@ -337,13 +337,12 @@
 	switch(MINOR(inode->i_rdev))
 	{
 		case WATCHDOG_MINOR:
-			if(wdt_is_open)
+			if(test_and_set_bit(0, &wdt_is_open))
 				return -EBUSY;
 			/*
 			 *	Activate 
 			 */
 	 
-			wdt_is_open=1;
 			inb_p(WDT_DC);		/* Disable */
 			wdt_ctr_mode(0,3);
 			wdt_ctr_mode(1,2);
@@ -380,7 +379,7 @@
 		inb_p(WDT_DC);		/* Disable counters */
 		wdt_ctr_load(2,0);	/* 0 length reset pulses now */
 #endif		
-		wdt_is_open=0;
+		clear_bit(0, &wdt_is_open);
 	}
 	return 0;
 }
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.1p3/drivers/char/wdt_pci.c linux.ac/drivers/char/wdt_pci.c
--- linux.1p3/drivers/char/wdt_pci.c	Thu Nov 29 01:18:32 2001
+++ linux.ac/drivers/char/wdt_pci.c	Thu Nov 29 01:23:17 2001
@@ -71,7 +71,7 @@
 #define PCI_DEVICE_ID_WDG_CSM 0x22c0
 #endif
 
-static int wdt_is_open;
+static unsigned long wdt_is_open;
 
 /*
  *	You must set these - there is no sane way to probe for this board.
