Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281369AbRLACFf>; Fri, 30 Nov 2001 21:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283887AbRLACFQ>; Fri, 30 Nov 2001 21:05:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:11683 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281369AbRLACFE>; Fri, 30 Nov 2001 21:05:04 -0500
Date: Fri, 30 Nov 2001 18:05:05 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
Message-Id: <200112010205.fB1255o22033@localhost.localdomain>
To: george anzinger <george@mvista.com>
Subject: Re: [LART] pc_keyb.c changes
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> It depends on how it is referenced.  If it is just a counter, you 
> may be able to just make it atomic.

This was my first instinct in this case.  But it appears that some things expect aux_count to stay in it's state while operations are performed.  The operations on aux_queue look like they need locking.

> If it needs to "stick" for a little longer, then consider if there 
> are many readers and only a few writers, in which case look at the 
> read/write_lockirq code, however, this does have the down side of 
> irq off.

I think that Al's biggest objection here is that interrupts are disabled.  The rwlock idea is a good one because aux_count is only read in the interrupt.  So, we don't have to disable interrupts, except when we hold the write.  But, sadly, the only place this changes anything is in pckbd_pm_resume() and handle_mouse_event().  Open and release both need a write lock.  I've attached a patch that turns aux_count_lock into a rw_lock.  Let's hope I don't break 64-bit architectures again :)

> BKL did not protect against interrupts, so one wonders if the irq 
> bit is needed at all.
I think that this case is one where the risk was minimal, and ignored.

--
Dave Hansen
haveblue@us.ibm.com
--- linux-2.5.1-pre5/drivers/char/pc_keyb.c	Fri Nov 30 17:40:03 2001
+++ linux/drivers/char/pc_keyb.c	Fri Nov 30 17:45:58 2001
@@ -90,7 +90,7 @@
  
 static struct aux_queue *queue;	/* Mouse data buffer. */
 static int aux_count;
-static spinlock_t aux_count_lock = SPIN_LOCK_UNLOCKED;
+static rwlock_t aux_count_lock = RW_LOCK_UNLOCKED;
 /* used when we send commands to the mouse that expect an ACK. */
 static unsigned char mouse_reply_expected;
 
@@ -406,9 +406,9 @@
 
        if (rqst == PM_RESUME) {
                if (queue) {                    /* Aux port detected */
-		       spin_lock_irqsave(&aux_count_lock, flags);
+		       read_lock(&aux_count_lock);
               	       if ( aux_count == 0) {   /* Mouse not in use */ 
-                               spin_lock(&kbd_controller_lock);
+                               spin_lock_irqsave(&kbd_controller_lock, flags);
 			       /*
 				* Dell Lat. C600 A06 enables mouse after resume.
 				* When user touches the pad, it posts IRQ 12
@@ -420,9 +420,9 @@
 			       kbd_write_command(KBD_CCMD_WRITE_MODE);
 			       kb_wait();
 			       kbd_write_output(AUX_INTS_OFF);
-			       spin_unlock(&kbd_controller_lock);
+			       spin_unlock_irqrestore(&kbd_controller_lock, flags);
 		       }
-		       spin_unlock_irqrestore(&aux_count_lock, flags);
+		       read_unlock(&aux_count_lock);
 	       }
        }
 #endif
@@ -452,7 +452,7 @@
 
 	prev_code = scancode;
 	add_mouse_randomness(scancode);
-	spin_lock_irqsave(&aux_count_lock, flags);
+	read_lock(&aux_count_lock);
 	if ( aux_count ) {
 		int head = queue->head;
 
@@ -464,7 +464,7 @@
 			wake_up_interruptible(&queue->proc_list);
 		}
 	}
-	spin_unlock_irqrestore(&aux_count_lock, flags);
+	read_unlock(&aux_count_lock);
 #endif
 }
 
@@ -1054,12 +1054,12 @@
 {
 	unsigned long flags;
 	fasync_aux(-1, file, 0);
-	spin_lock_irqsave(&aux_count_lock, flags);
+	write_lock_irqsave(&aux_count_lock, flags);
 	if ( --aux_count ) {
-		spin_unlock_irqrestore(&aux_count_lock, flags);
+	        write_unlock_irqrestore(&aux_count_lock, flags);
 		return 0;
 	}
-	spin_unlock_irqrestore(&aux_count_lock, flags);
+	write_unlock_irqrestore(&aux_count_lock, flags);
 	kbd_write_cmd(AUX_INTS_OFF);			    /* Disable controller ints */
 	kbd_write_command_w(KBD_CCMD_MOUSE_DISABLE);
 	aux_free_irq(AUX_DEV);
@@ -1076,18 +1076,18 @@
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&aux_count_lock, flags);
+	write_lock_irqsave(&aux_count_lock, flags);
 	if ( aux_count++ ) {
-		spin_unlock_irqrestore(&aux_count_lock, flags);
+	        write_unlock_irqrestore(&aux_count_lock, flags);
 		return 0;
 	}
 	queue->head = queue->tail = 0;		/* Flush input queue */
-	spin_unlock_irqrestore(&aux_count_lock, flags);
+	write_unlock_irqrestore(&aux_count_lock, flags);
 	ret = aux_request_irq(keyboard_interrupt, AUX_DEV);
-	spin_lock_irqsave(&aux_count_lock, flags);
+	write_lock_irqsave(&aux_count_lock, flags);
 	if (ret) {
 		aux_count--;
-		spin_unlock_irqrestore(&aux_count_lock, flags);
+		write_unlock_irqrestore(&aux_count_lock, flags);
 		return -EBUSY;
 	}
 	kbd_write_command_w(KBD_CCMD_MOUSE_ENABLE);	/* Enable the
@@ -1099,7 +1099,7 @@
 	mdelay(2);			/* Ensure we follow the kbc access delay rules.. */
 
 	send_data(KBD_CMD_ENABLE);	/* try to workaround toshiba4030cdt problem */
-	spin_unlock_irqrestore(&aux_count_lock, flags);
+	write_unlock_irqrestore(&aux_count_lock, flags);
 	return 0;
 }
 
