Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319180AbSHWSeK>; Fri, 23 Aug 2002 14:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319181AbSHWSeK>; Fri, 23 Aug 2002 14:34:10 -0400
Received: from waste.org ([209.173.204.2]:24749 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319180AbSHWSeC>;
	Fri, 23 Aug 2002 14:34:02 -0400
Date: Fri, 23 Aug 2002 13:38:11 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (7/7) update entropy users
Message-ID: <20020823183811.GG2224@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the old API and updates users to the new one. This also
allows different input devices of the same class (eg mice) to have
their entropy state tracked independently and removes hardwired source
classes from the core.

diff -ur a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
--- a/arch/alpha/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/alpha/kernel/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -88,7 +88,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	return status;
diff -ur a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
--- a/arch/arm/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/arm/kernel/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -200,7 +200,7 @@
 	} while (action);
 
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 
 	spin_lock_irq(&irq_controller_lock);
 }
diff -ur a/arch/cris/kernel/irq.c b/arch/cris/kernel/irq.c
--- a/arch/cris/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/cris/kernel/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -275,7 +275,7 @@
                         action = action->next;
                 } while (action);
                 if (do_random & SA_SAMPLE_RANDOM)
-                        add_interrupt_randomness(irq);
+                        add_timer_randomness(0, irq);
                 local_irq_disable();
         }
         irq_exit(cpu);
diff -ur a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/i386/kernel/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -212,7 +212,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	return status;
diff -ur a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
--- a/arch/ia64/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/ia64/kernel/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -497,7 +497,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	local_irq_exit(irq);
diff -ur a/arch/mips/baget/irq.c b/arch/mips/baget/irq.c
--- a/arch/mips/baget/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/mips/baget/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -195,7 +195,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	} else {
 		printk("do_IRQ: Unregistered IRQ (0x%X) occurred\n", irq);
diff -ur a/arch/mips/dec/irq.c b/arch/mips/dec/irq.c
--- a/arch/mips/dec/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/mips/dec/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -145,7 +145,7 @@
 	    action = action->next;
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-	    add_interrupt_randomness(irq);
+	    add_timer_randomness(0, irq);
 	local_irq_disable();
 	unmask_irq(irq);
     }
diff -ur a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
--- a/arch/mips/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/mips/kernel/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -122,7 +122,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(cpu, irq);
diff -ur a/arch/mips/kernel/old-irq.c b/arch/mips/kernel/old-irq.c
--- a/arch/mips/kernel/old-irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/mips/kernel/old-irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -192,7 +192,7 @@
 		action = action->next;
        	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 	unmask_irq (irq);
 
@@ -228,7 +228,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(cpu, irq);
diff -ur a/arch/mips/philips/nino/irq.c b/arch/mips/philips/nino/irq.c
--- a/arch/mips/philips/nino/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/mips/philips/nino/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -185,7 +185,7 @@
 	    action = action->next;
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-	    add_interrupt_randomness(irq);
+	    add_timer_randomness(0, irq);
 	unmask_irq(irq);
 	local_irq_disable();
     } else {
diff -ur a/arch/mips64/sgi-ip22/ip22-int.c b/arch/mips64/sgi-ip22/ip22-int.c
--- a/arch/mips64/sgi-ip22/ip22-int.c	2002-08-17 00:29:50.000000000 -0500
+++ b/arch/mips64/sgi-ip22/ip22-int.c	2002-08-23 12:43:36.000000000 -0500
@@ -315,7 +315,7 @@
 			action = action->next;
 		} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(cpu, irq);
diff -ur a/arch/mips64/sgi-ip27/ip27-irq.c b/arch/mips64/sgi-ip27/ip27-irq.c
--- a/arch/mips64/sgi-ip27/ip27-irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/mips64/sgi-ip27/ip27-irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -183,7 +183,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(thiscpu, irq);
diff -ur a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
--- a/arch/sh/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/sh/kernel/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -138,7 +138,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(cpu, irq);
diff -ur a/arch/x86_64/kernel/irq.c b/arch/x86_64/kernel/irq.c
--- a/arch/x86_64/kernel/irq.c	2002-08-23 12:43:29.000000000 -0500
+++ b/arch/x86_64/kernel/irq.c	2002-08-23 12:43:36.000000000 -0500
@@ -450,7 +450,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(0, irq);
diff -ur a/drivers/acorn/char/mouse_ps2.c b/drivers/acorn/char/mouse_ps2.c
--- a/drivers/acorn/char/mouse_ps2.c	2002-08-17 00:30:02.000000000 -0500
+++ b/drivers/acorn/char/mouse_ps2.c	2002-08-23 12:43:36.000000000 -0500
@@ -34,6 +34,7 @@
 static int aux_count = 0;
 /* used when we send commands to the mouse that expect an ACK. */
 static unsigned char mouse_reply_expected = 0;
+static void *entropy;
 
 #define MAX_RETRIES	60		/* some aux operations take long time*/
 
@@ -107,7 +108,7 @@
 		mouse_reply_expected = 0;
 	}
 
-	add_mouse_randomness(val);
+	add_timer_randomness(entropy, val);
 	if (aux_count) {
 		int head = queue->head;
 
@@ -271,6 +272,8 @@
 	iomd_writeb(0, IOMD_MSECTL);
 	iomd_writeb(8, IOMD_MSECTL);
   
+	entropy = create_entropy_source(1);
+
 	if (misc_register(&psaux_mouse))
 		return -ENODEV;
 	queue = (struct aux_queue *) kmalloc(sizeof(*queue), GFP_KERNEL);
diff -ur a/drivers/block/DAC960.c b/drivers/block/DAC960.c
--- a/drivers/block/DAC960.c	2002-08-17 00:29:59.000000000 -0500
+++ b/drivers/block/DAC960.c	2002-08-23 12:43:36.000000000 -0500
@@ -3036,7 +3036,7 @@
 	      complete(Command->Completion);
 	      Command->Completion = NULL;
 	    }
-	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
+	  add_timer_randomness(0, DAC960_MAJOR + Controller->ControllerNumber);
 	}
       else if ((CommandStatus == DAC960_V1_IrrecoverableDataError ||
 		CommandStatus == DAC960_V1_BadDataEncountered) &&
@@ -4142,7 +4142,7 @@
 	      complete(Command->Completion);
 	      Command->Completion = NULL;
 	    }
-	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
+	  add_timer_randomness(0, DAC960_MAJOR + Controller->ControllerNumber);
 	}
       else if (Command->V2.RequestSense.SenseKey
 	       == DAC960_SenseKey_MediumError &&
diff -ur a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	2002-08-17 00:30:02.000000000 -0500
+++ b/drivers/block/floppy.c	2002-08-23 12:43:36.000000000 -0500
@@ -2294,7 +2294,7 @@
 
 	if (end_that_request_first(req, uptodate, req->hard_cur_sectors))
 		return;
-	add_blkdev_randomness(major(dev));
+	add_timer_randomness(0, major(dev));
 	floppy_off(DEVICE_NR(dev));
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
diff -ur a/drivers/char/busmouse.c b/drivers/char/busmouse.c
--- a/drivers/char/busmouse.c	2002-07-20 14:11:11.000000000 -0500
+++ b/drivers/char/busmouse.c	2002-08-23 12:43:36.000000000 -0500
@@ -47,6 +47,7 @@
 	char			ready;
 	int			dxpos;
 	int			dypos;
+	void                    *entropy;
 };
 
 #define NR_MICE			15
@@ -84,7 +85,7 @@
 	changed = (dx != 0 || dy != 0 || mse->buttons != buttons);
 
 	if (changed) {
-		add_mouse_randomness((buttons << 16) + (dy << 8) + dx);
+		add_timer_randomness(mse->entropy, (buttons << 16) + (dy << 8) + dx);
 
 		mse->buttons = buttons;
 		mse->dxpos += dx;
@@ -387,6 +388,8 @@
 	mse->lock = (spinlock_t)SPIN_LOCK_UNLOCKED;
 	init_waitqueue_head(&mse->wait);
 
+	mse->entropy = create_entropy_source(1);
+
 	busmouse_data[msedev] = mse;
 
 	ret = misc_register(&mse->miscdev);
@@ -419,13 +422,15 @@
 	}
 
 	down(&mouse_sem);
-	
+
 	if (!busmouse_data[mousedev]) {
 		printk(KERN_WARNING "busmouse: trying to free free mouse"
 		       " on mousedev %d\n", mousedev);
 		goto fail;
 	}
 
+	free_entropy_source(busmouse_data[mousedev].entropy);
+
 	if (busmouse_data[mousedev]->active) {
 		printk(KERN_ERR "busmouse: trying to free active mouse"
 		       " on mousedev %d\n", mousedev);
diff -ur a/drivers/char/hp_psaux.c b/drivers/char/hp_psaux.c
--- a/drivers/char/hp_psaux.c	2002-07-20 14:12:22.000000000 -0500
+++ b/drivers/char/hp_psaux.c	2002-08-23 12:43:36.000000000 -0500
@@ -182,6 +182,8 @@
 static void lasi_ps2_init_hw(void)
 {
 	++inited;
+
+	entropy = create_entropy_source(1);
 }
 
 
@@ -205,6 +207,7 @@
 static spinlock_t	kbd_controller_lock = SPIN_LOCK_UNLOCKED;
 static unsigned char	mouse_reply_expected;
 static int 		aux_count;
+static void *entropy;
 
 static int fasync_aux(int fd, struct file *filp, int on)
 {
@@ -233,7 +236,7 @@
 		return;
 	}
 
-	add_mouse_randomness(scancode);
+	add_timer_randomness(entropy, scancode);
 	if (aux_count) {
 		int head = queue->head;
 				
@@ -509,6 +512,8 @@
 		if (!queue)
 			return -ENOMEM;
 
+		entropy = create_entropy_source(1);
+
 		memset(queue, 0, sizeof(*queue));
 		queue->head = queue->tail = 0;
 		init_waitqueue_head(&queue->proc_list);
diff -ur a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	2002-07-20 14:11:14.000000000 -0500
+++ b/drivers/char/keyboard.c	2002-08-23 12:43:36.000000000 -0500
@@ -153,6 +153,7 @@
 pm_callback pm_kbd_request_override = NULL;
 typedef void (pm_kbd_func) (void);
 static struct pm_dev *pm_kbd;
+static void *entropy;
 
 static unsigned char ledstate = 0xff; /* undefined */
 static unsigned char ledioctl;
@@ -803,7 +804,7 @@
 	char raw_mode;
 
 	pm_access(pm_kbd);
-	add_keyboard_randomness(scancode | up_flag);
+	add_timer_randomness(entropy, scancode | up_flag);
 
 	tty = vc->vc_tty;
 
@@ -935,6 +936,8 @@
 	int i;
 	struct kbd_struct kbd0;
 
+	entropy = create_entropy_source(1);
+
 	kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
 	kbd0.ledmode = LED_SHOW_FLAGS;
 	kbd0.lockstate = KBD_DEFLOCK;
diff -ur a/drivers/char/pc_keyb.c b/drivers/char/pc_keyb.c
--- a/drivers/char/pc_keyb.c	2002-07-20 14:11:15.000000000 -0500
+++ b/drivers/char/pc_keyb.c	2002-08-23 12:43:36.000000000 -0500
@@ -76,7 +76,7 @@
 static volatile unsigned char reply_expected;
 static volatile unsigned char acknowledge;
 static volatile unsigned char resend;
-
+static void *entropy;
 
 #if defined CONFIG_PSMOUSE
 /*
@@ -451,7 +451,7 @@
 	}
 
 	prev_code = scancode;
-	add_mouse_randomness(scancode);
+	add_timer_randomness(entropy, scancode);
 	spin_lock_irqsave(&aux_count_lock, flags);
 	if ( aux_count ) {
 		int head = queue->head;
@@ -931,6 +931,7 @@
 
 #if defined CONFIG_PSMOUSE
 	psaux_init();
+	entropy = create_entropy_source(1);
 #endif
 
 	kbd_rate = pckbd_rate;
diff -ur a/drivers/char/qtronix.c b/drivers/char/qtronix.c
--- a/drivers/char/qtronix.c	2002-07-20 14:11:13.000000000 -0500
+++ b/drivers/char/qtronix.c	2002-08-23 12:43:36.000000000 -0500
@@ -93,6 +93,7 @@
 struct cir_port *cir;
 static unsigned char kbdbytes[5];
 static unsigned char cir_data[32]; /* we only need 16 chars */
+static void *entropy;
 
 static void kbd_int_handler(int irq, void *dev_id, struct pt_regs *regs);
 static int handle_data(unsigned char *p_data);
@@ -153,6 +154,7 @@
 				cir->port, IT8172_CIR0_IRQ);
 	}
 #ifdef CONFIG_PSMOUSE
+	entropy = create_entropy_source(1);
 	psaux_init();
 #endif
 }
@@ -441,7 +443,7 @@
 		return;
 	}
 
-	add_mouse_randomness(scancode);
+	add_timer_randomness(entropy, scancode);
 	if (aux_count) {
 		int head = queue->head;
 
diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-08-23 12:43:31.000000000 -0500
+++ b/drivers/char/random.c	2002-08-23 12:43:36.000000000 -0500
@@ -719,8 +719,6 @@
 	kfree(src);
 }
 
-static void *generic_kbd, *generic_mouse;
-
 /*
  * estimation of entropy contained in a n-bit delta from an exponential
  * distribution, derived from Benford's Law (rounded down)
@@ -787,27 +785,6 @@
 	batch_entropy_store(datum^time, bits);
 }
 
-void add_keyboard_randomness(unsigned char scancode)
-{
-	/* autorepeat ignored based on coarse timing */
-	add_timer_randomness(generic_kbd, scancode);
-}
-
-void add_mouse_randomness(__u32 mouse_data)
-{
-	add_timer_randomness(generic_mouse, mouse_data);
-}
-
-void add_interrupt_randomness(int irq)
-{
-	add_timer_randomness(0, irq);
-}
-
-void add_blkdev_randomness(int major)
-{
-	add_timer_randomness(0, 0x200+major);
-}
-
 /******************************************************************
  *
  * Hash function definition
@@ -1411,8 +1388,6 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	generic_kbd = create_entropy_source(1);
-	generic_mouse = create_entropy_source(1);
 }
 
 static ssize_t
@@ -2214,10 +2189,6 @@
 EXPORT_SYMBOL(create_entropy_source);
 EXPORT_SYMBOL(free_entropy_source);
 EXPORT_SYMBOL(add_timer_randomness);
-EXPORT_SYMBOL(add_keyboard_randomness);
-EXPORT_SYMBOL(add_mouse_randomness);
-EXPORT_SYMBOL(add_interrupt_randomness);
-EXPORT_SYMBOL(add_blkdev_randomness);
 EXPORT_SYMBOL(batch_entropy_store);
 EXPORT_SYMBOL(generate_random_uuid);
 
diff -ur a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2002-08-17 00:30:02.000000000 -0500
+++ b/drivers/ide/ide.c	2002-08-23 12:43:36.000000000 -0500
@@ -132,7 +132,7 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, nr_secs)) {
-		add_blkdev_randomness(ch->major);
+		add_timer_randomness(0, ch->major);
 		if (!blk_rq_tagged(rq))
 			blkdev_dequeue_request(rq);
 		else
diff -ur a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	2002-08-17 00:29:59.000000000 -0500
+++ b/drivers/input/input.c	2002-08-23 12:43:36.000000000 -0500
@@ -78,7 +78,7 @@
 	if (type > EV_MAX || !test_bit(type, dev->evbit))
 		return;
 
-	add_mouse_randomness((type << 4) ^ code ^ (code >> 4) ^ value);
+	add_timer_randomness(dev->entropy, (type << 4) ^ code ^ value);
 
 	switch (type) {
 
@@ -462,6 +462,8 @@
 	dev->rep[REP_DELAY] = HZ/4;
 	dev->rep[REP_PERIOD] = HZ/33;
 
+	dev->entropy = create_entropy_source(1);
+
 /*
  * Add the device.
  */
diff -ur a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c	2002-07-20 14:11:17.000000000 -0500
+++ b/drivers/s390/block/dasd.c	2002-08-23 12:43:36.000000000 -0500
@@ -1489,7 +1489,7 @@
 {
 	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
-	add_blkdev_randomness(major(req->rq_dev));
+	add_timer_randomness(0, major(req->rq_dev));
 	end_that_request_last(req);
 	return;
 }
diff -ur a/drivers/s390/char/tapeblock.c b/drivers/s390/char/tapeblock.c
--- a/drivers/s390/char/tapeblock.c	2002-08-17 00:29:59.000000000 -0500
+++ b/drivers/s390/char/tapeblock.c	2002-08-23 12:43:36.000000000 -0500
@@ -283,9 +283,6 @@
 	bh->b_end_io (bh, uptodate);
     }
     if (!end_that_request_first (td->blk_data.current_request, uptodate, "tBLK")) {
-#ifndef DEVICE_NO_RANDOM
-	add_blkdev_randomness (MAJOR (td->blk_data.current_request->rq_dev));
-#endif
 	end_that_request_last (td->blk_data.current_request);
     }
     if (treq!=NULL) {
diff -ur a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	2002-08-17 00:29:54.000000000 -0500
+++ b/drivers/scsi/scsi_lib.c	2002-08-23 12:43:36.000000000 -0500
@@ -335,7 +335,7 @@
 		return SCpnt;
 	}
 
-	add_blkdev_randomness(major(req->rq_dev));
+	add_timer_randomness(0, major(req->rq_dev));
 
 	if(blk_rq_tagged(req))
 		blk_queue_end_tag(q, req);
diff -ur a/include/linux/blk.h b/include/linux/blk.h
--- a/include/linux/blk.h	2002-07-20 14:11:33.000000000 -0500
+++ b/include/linux/blk.h	2002-08-23 12:43:36.000000000 -0500
@@ -8,7 +8,6 @@
 #include <linux/compiler.h>
 
 extern void set_device_ro(kdev_t dev,int flag);
-extern void add_blkdev_randomness(int major);
 
 #ifdef CONFIG_BLK_DEV_RAM
 
@@ -83,12 +82,14 @@
  * If we have our own end_request, we do not want to include this mess
  */
 #ifndef LOCAL_END_REQUEST
+extern void add_timer_randomness(void *src, int datum);
+
 static inline void end_request(struct request *req, int uptodate)
 {
 	if (end_that_request_first(req, uptodate, req->hard_cur_sectors))
 		return;
 
-	add_blkdev_randomness(major(req->rq_dev));
+	add_timer_randomness(0, major(req->rq_dev));
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 }
diff -ur a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	2002-08-17 00:30:00.000000000 -0500
+++ b/include/linux/input.h	2002-08-23 12:43:36.000000000 -0500
@@ -781,6 +781,7 @@
 
 	unsigned int repeat_key;
 	struct timer_list timer;
+	void *entropy;
 
 	struct pm_dev *pm_dev;
 	int state;
diff -ur a/include/linux/random.h b/include/linux/random.h
--- a/include/linux/random.h	2002-08-23 12:43:31.000000000 -0500
+++ b/include/linux/random.h	2002-08-23 12:43:36.000000000 -0500
@@ -49,10 +49,6 @@
 extern void *create_entropy_source(int granularity_khz);
 extern void free_entropy_source(void *src);
 extern void add_timer_randomness(void *src, unsigned datum);
-extern void add_keyboard_randomness(unsigned char scancode);
-extern void add_mouse_randomness(__u32 mouse_data);
-extern void add_interrupt_randomness(int irq);
-extern void add_blkdev_randomness(int major);
 
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);



-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
