Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSIKFQW>; Wed, 11 Sep 2002 01:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSIKFQU>; Wed, 11 Sep 2002 01:16:20 -0400
Received: from waste.org ([209.173.204.2]:27284 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318358AbSIKFPK>;
	Wed, 11 Sep 2002 01:15:10 -0400
Date: Wed, 11 Sep 2002 00:19:55 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/11] Entropy fixes - update users
Message-ID: <20020911051955.GV31597@waste.org>
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

diff -urN clean/arch/alpha/kernel/irq.c patched/arch/alpha/kernel/irq.c
--- clean/arch/alpha/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/alpha/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -88,7 +88,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	return status;
diff -urN clean/arch/arm/kernel/irq.c patched/arch/arm/kernel/irq.c
--- clean/arch/arm/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/arm/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -200,7 +200,7 @@
 	} while (action);
 
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 
 	spin_lock_irq(&irq_controller_lock);
 }
diff -urN clean/arch/cris/kernel/irq.c patched/arch/cris/kernel/irq.c
--- clean/arch/cris/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/cris/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -275,7 +275,7 @@
                         action = action->next;
                 } while (action);
                 if (do_random & SA_SAMPLE_RANDOM)
-                        add_interrupt_randomness(irq);
+                        add_timer_randomness(0, irq);
                 local_irq_disable();
         }
         irq_exit(cpu);
diff -urN clean/arch/i386/kernel/irq.c patched/arch/i386/kernel/irq.c
--- clean/arch/i386/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/i386/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -211,7 +211,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	return status;
diff -urN clean/arch/ia64/kernel/irq.c patched/arch/ia64/kernel/irq.c
--- clean/arch/ia64/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/ia64/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -228,7 +228,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	return status;
diff -urN clean/arch/mips/baget/irq.c patched/arch/mips/baget/irq.c
--- clean/arch/mips/baget/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/mips/baget/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -195,7 +195,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	} else {
 		printk("do_IRQ: Unregistered IRQ (0x%X) occurred\n", irq);
diff -urN clean/arch/mips/dec/irq.c patched/arch/mips/dec/irq.c
--- clean/arch/mips/dec/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/mips/dec/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -145,7 +145,7 @@
 	    action = action->next;
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-	    add_interrupt_randomness(irq);
+	    add_timer_randomness(0, irq);
 	local_irq_disable();
 	unmask_irq(irq);
     }
diff -urN clean/arch/mips/kernel/irq.c patched/arch/mips/kernel/irq.c
--- clean/arch/mips/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/mips/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -122,7 +122,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(cpu, irq);
diff -urN clean/arch/mips/kernel/old-irq.c patched/arch/mips/kernel/old-irq.c
--- clean/arch/mips/kernel/old-irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/mips/kernel/old-irq.c	2002-09-10 23:30:50.000000000 -0500
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
diff -urN clean/arch/mips/philips/nino/irq.c patched/arch/mips/philips/nino/irq.c
--- clean/arch/mips/philips/nino/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/mips/philips/nino/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -185,7 +185,7 @@
 	    action = action->next;
 	} while (action);
 	if (do_random & SA_SAMPLE_RANDOM)
-	    add_interrupt_randomness(irq);
+	    add_timer_randomness(0, irq);
 	unmask_irq(irq);
 	local_irq_disable();
     } else {
diff -urN clean/arch/mips64/sgi-ip22/ip22-int.c patched/arch/mips64/sgi-ip22/ip22-int.c
--- clean/arch/mips64/sgi-ip22/ip22-int.c	2002-08-17 00:29:50.000000000 -0500
+++ patched/arch/mips64/sgi-ip22/ip22-int.c	2002-09-10 23:30:50.000000000 -0500
@@ -315,7 +315,7 @@
 			action = action->next;
 		} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(cpu, irq);
diff -urN clean/arch/mips64/sgi-ip27/ip27-irq.c patched/arch/mips64/sgi-ip27/ip27-irq.c
--- clean/arch/mips64/sgi-ip27/ip27-irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/mips64/sgi-ip27/ip27-irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -183,7 +183,7 @@
 			action = action->next;
         	} while (action);
 		if (do_random & SA_SAMPLE_RANDOM)
-			add_interrupt_randomness(irq);
+			add_timer_randomness(0, irq);
 		local_irq_disable();
 	}
 	irq_exit(thiscpu, irq);
diff -urN clean/arch/ppc/kernel/irq.c patched/arch/ppc/kernel/irq.c
--- clean/arch/ppc/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/ppc/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -401,7 +401,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 }
 
diff -urN clean/arch/ppc64/kernel/irq.c patched/arch/ppc64/kernel/irq.c
--- clean/arch/ppc64/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/ppc64/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -383,7 +383,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 }
 
diff -urN clean/arch/sh/kernel/irq.c patched/arch/sh/kernel/irq.c
--- clean/arch/sh/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/sh/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -138,7 +138,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(cpu, irq);
diff -urN clean/arch/sparc64/kernel/irq.c patched/arch/sparc64/kernel/irq.c
--- clean/arch/sparc64/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/sparc64/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -779,7 +779,7 @@
 				upa_writel(ICLR_IDLE, bp->iclr);
 				/* Test and add entropy */
 				if (random)
-					add_interrupt_randomness(irq);
+					add_timer_randomness(0, irq);
 			}
 		} else
 			bp->pending = 1;
diff -urN clean/arch/x86_64/kernel/irq.c patched/arch/x86_64/kernel/irq.c
--- clean/arch/x86_64/kernel/irq.c	2002-09-10 23:30:48.000000000 -0500
+++ patched/arch/x86_64/kernel/irq.c	2002-09-10 23:30:50.000000000 -0500
@@ -450,7 +450,7 @@
 		action = action->next;
 	} while (action);
 	if (status & SA_SAMPLE_RANDOM)
-		add_interrupt_randomness(irq);
+		add_timer_randomness(0, irq);
 	local_irq_disable();
 
 	irq_exit(0, irq);
diff -urN clean/drivers/acorn/char/mouse_ps2.c patched/drivers/acorn/char/mouse_ps2.c
--- clean/drivers/acorn/char/mouse_ps2.c	2002-08-17 00:30:02.000000000 -0500
+++ patched/drivers/acorn/char/mouse_ps2.c	2002-09-10 23:30:50.000000000 -0500
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
diff -urN clean/drivers/block/DAC960.c patched/drivers/block/DAC960.c
--- clean/drivers/block/DAC960.c	2002-09-10 12:07:36.000000000 -0500
+++ patched/drivers/block/DAC960.c	2002-09-10 23:30:50.000000000 -0500
@@ -3013,7 +3013,7 @@
 	      complete(Command->Completion);
 	      Command->Completion = NULL;
 	    }
-	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
+	  add_timer_randomness(0, DAC960_MAJOR + Controller->ControllerNumber);
 	}
       else if ((CommandStatus == DAC960_V1_IrrecoverableDataError ||
 		CommandStatus == DAC960_V1_BadDataEncountered) &&
@@ -4119,7 +4119,7 @@
 	      complete(Command->Completion);
 	      Command->Completion = NULL;
 	    }
-	  add_blkdev_randomness(DAC960_MAJOR + Controller->ControllerNumber);
+	  add_timer_randomness(0, DAC960_MAJOR + Controller->ControllerNumber);
 	}
       else if (Command->V2.RequestSense.SenseKey
 	       == DAC960_SenseKey_MediumError &&
diff -urN clean/drivers/block/floppy.c patched/drivers/block/floppy.c
--- clean/drivers/block/floppy.c	2002-09-10 12:07:36.000000000 -0500
+++ patched/drivers/block/floppy.c	2002-09-10 23:30:50.000000000 -0500
@@ -2297,7 +2297,7 @@
 
 	if (end_that_request_first(req, uptodate, current_count_sectors))
 		return;
-	add_blkdev_randomness(major(dev));
+	add_timer_randomness(0, (unsigned)req);
 	floppy_off(DEVICE_NR(dev));
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
diff -urN clean/drivers/char/busmouse.c patched/drivers/char/busmouse.c
--- clean/drivers/char/busmouse.c	2002-07-20 14:11:11.000000000 -0500
+++ patched/drivers/char/busmouse.c	2002-09-10 23:30:50.000000000 -0500
@@ -47,6 +47,7 @@
 	char			ready;
 	int			dxpos;
 	int			dypos;
+	void                    *entropy;
 };
 
 #define NR_MICE			15
@@ -84,7 +85,8 @@
 	changed = (dx != 0 || dy != 0 || mse->buttons != buttons);
 
 	if (changed) {
-		add_mouse_randomness((buttons << 16) + (dy << 8) + dx);
+		add_timer_randomness(mse->entropy, 
+				     (buttons << 16) + (dy << 8) + dx);
 
 		mse->buttons = buttons;
 		mse->dxpos += dx;
@@ -387,6 +389,8 @@
 	mse->lock = (spinlock_t)SPIN_LOCK_UNLOCKED;
 	init_waitqueue_head(&mse->wait);
 
+	mse->entropy = create_entropy_source(1);
+
 	busmouse_data[msedev] = mse;
 
 	ret = misc_register(&mse->miscdev);
@@ -419,13 +423,15 @@
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
diff -urN clean/drivers/char/hp_psaux.c patched/drivers/char/hp_psaux.c
--- clean/drivers/char/hp_psaux.c	2002-07-20 14:12:22.000000000 -0500
+++ patched/drivers/char/hp_psaux.c	2002-09-10 23:30:50.000000000 -0500
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
diff -urN clean/drivers/char/keyboard.c patched/drivers/char/keyboard.c
--- clean/drivers/char/keyboard.c	2002-09-04 11:28:49.000000000 -0500
+++ patched/drivers/char/keyboard.c	2002-09-10 23:30:50.000000000 -0500
@@ -131,6 +131,7 @@
 static unsigned char diacr;
 static char rep;					/* flag telling character repeat */
 
+static void *entropy;
 static unsigned char ledstate = 0xff;			/* undefined */
 static unsigned char ledioctl;
 
@@ -993,7 +994,7 @@
 	int shift_final;
 
 	if (down != 2)
-		add_keyboard_randomness((keycode << 1) ^ down);
+		add_timer_randomness(entropy, (keycode << 1) ^ down);
 
 	tty = vc->vc_tty;
 
@@ -1185,6 +1186,8 @@
 {
 	int i;
 
+	entropy = create_entropy_source(1);
+
         kbd0.ledflagstate = kbd0.default_ledflagstate = KBD_DEFLEDS;
         kbd0.ledmode = LED_SHOW_FLAGS;
         kbd0.lockstate = KBD_DEFLOCK;
diff -urN clean/drivers/char/qtronix.c patched/drivers/char/qtronix.c
--- clean/drivers/char/qtronix.c	2002-07-20 14:11:13.000000000 -0500
+++ patched/drivers/char/qtronix.c	2002-09-10 23:30:50.000000000 -0500
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
 
diff -urN clean/drivers/char/random.c patched/drivers/char/random.c
--- clean/drivers/char/random.c	2002-09-10 23:30:49.000000000 -0500
+++ patched/drivers/char/random.c	2002-09-10 23:31:24.000000000 -0500
@@ -699,8 +699,6 @@
 	kfree(src);
 }
 
-static void *generic_kbd, *generic_mouse;
-
 static unsigned long last_ctxt=0, last_jiffies=0;
 static int trust_break=50, trust_pct=0, trust_min=0, trust_max=100;
 
@@ -771,27 +769,6 @@
 	batch_entropy_store(datum^time, entropy);
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
@@ -1395,8 +1372,6 @@
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
 #endif
-	generic_kbd = create_entropy_source(1);
-	generic_mouse = create_entropy_source(1);
 }
 
 static ssize_t
@@ -2198,10 +2173,6 @@
 EXPORT_SYMBOL(create_entropy_source);
 EXPORT_SYMBOL(free_entropy_source);
 EXPORT_SYMBOL(add_timer_randomness);
-EXPORT_SYMBOL(add_keyboard_randomness);
-EXPORT_SYMBOL(add_mouse_randomness);
-EXPORT_SYMBOL(add_interrupt_randomness);
-EXPORT_SYMBOL(add_blkdev_randomness);
 EXPORT_SYMBOL(batch_entropy_store);
 EXPORT_SYMBOL(generate_random_uuid);
 
diff -urN clean/drivers/ide/ide-cd.c patched/drivers/ide/ide-cd.c
--- clean/drivers/ide/ide-cd.c	2002-09-10 12:07:36.000000000 -0500
+++ patched/drivers/ide/ide-cd.c	2002-09-10 23:30:50.000000000 -0500
@@ -562,7 +562,7 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, rq->hard_cur_sectors)) {
-		add_blkdev_randomness(major(rq->rq_dev));
+		add_timer_randomness(0, (unsigned)rq);
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
diff -urN clean/drivers/ide/ide-disk.c patched/drivers/ide/ide-disk.c
--- clean/drivers/ide/ide-disk.c	2002-09-10 12:07:36.000000000 -0500
+++ patched/drivers/ide/ide-disk.c	2002-09-10 23:30:50.000000000 -0500
@@ -768,7 +768,7 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, rq->hard_cur_sectors)) {
-		add_blkdev_randomness(major(rq->rq_dev));
+		add_timer_randomness(0, (unsigned)rq);
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
diff -urN clean/drivers/ide/ide-floppy.c patched/drivers/ide/ide-floppy.c
--- clean/drivers/ide/ide-floppy.c	2002-09-10 12:07:36.000000000 -0500
+++ patched/drivers/ide/ide-floppy.c	2002-09-10 23:30:50.000000000 -0500
@@ -704,7 +704,7 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, rq->hard_cur_sectors)) {
-		add_blkdev_randomness(major(rq->rq_dev));
+		add_timer_randomness(0, (unsigned)rq);
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
diff -urN clean/drivers/ide/ide-tape.c patched/drivers/ide/ide-tape.c
--- clean/drivers/ide/ide-tape.c	2002-09-04 11:28:49.000000000 -0500
+++ patched/drivers/ide/ide-tape.c	2002-09-10 23:30:50.000000000 -0500
@@ -2688,7 +2688,7 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, rq->hard_cur_sectors)) {
-		add_blkdev_randomness(major(rq->rq_dev));
+		add_timer_randomness(0, (unsigned)rq);
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
diff -urN clean/drivers/ide/ide.c patched/drivers/ide/ide.c
--- clean/drivers/ide/ide.c	2002-09-10 12:07:36.000000000 -0500
+++ patched/drivers/ide/ide.c	2002-09-10 23:30:50.000000000 -0500
@@ -152,6 +152,7 @@
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
 #include <linux/seq_file.h>
+#include <linux/random.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -393,7 +394,7 @@
 	}
 
 	if (!end_that_request_first(rq, uptodate, rq->hard_cur_sectors)) {
-		add_blkdev_randomness(major(rq->rq_dev));
+		add_timer_randomness(0, (unsigned)rq);
 		blkdev_dequeue_request(rq);
 		HWGROUP(drive)->rq = NULL;
 		end_that_request_last(rq);
diff -urN clean/drivers/input/input.c patched/drivers/input/input.c
--- clean/drivers/input/input.c	2002-09-04 11:28:49.000000000 -0500
+++ patched/drivers/input/input.c	2002-09-10 23:30:50.000000000 -0500
@@ -66,7 +66,7 @@
 	if (type > EV_MAX || !test_bit(type, dev->evbit))
 		return;
 
-	add_mouse_randomness((type << 4) ^ code ^ (code >> 4) ^ value);
+	add_timer_randomness(dev->entropy, (type << 4) ^ code ^ value);
 
 	switch (type) {
 
@@ -411,6 +411,7 @@
 	dev->timer.function = input_repeat_key;
 	dev->rep[REP_DELAY] = HZ/4;
 	dev->rep[REP_PERIOD] = HZ/33;
+	dev->entropy = create_entropy_source(1);
 
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node,&input_dev_list);
diff -urN clean/drivers/s390/block/dasd.c patched/drivers/s390/block/dasd.c
--- clean/drivers/s390/block/dasd.c	2002-09-10 12:07:37.000000000 -0500
+++ patched/drivers/s390/block/dasd.c	2002-09-10 23:30:50.000000000 -0500
@@ -1481,7 +1481,7 @@
 {
 	if (end_that_request_first(req, uptodate, req->hard_nr_sectors))
 		BUG();
-	add_blkdev_randomness(major(req->rq_dev));
+	add_timer_randomness(0, (unsigned)req);
 	end_that_request_last(req);
 	return;
 }
diff -urN clean/drivers/s390/char/tapeblock.c patched/drivers/s390/char/tapeblock.c
--- clean/drivers/s390/char/tapeblock.c	2002-08-17 00:29:59.000000000 -0500
+++ patched/drivers/s390/char/tapeblock.c	2002-09-10 23:30:50.000000000 -0500
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
diff -urN clean/drivers/scsi/scsi_lib.c patched/drivers/scsi/scsi_lib.c
--- clean/drivers/scsi/scsi_lib.c	2002-08-17 00:29:54.000000000 -0500
+++ patched/drivers/scsi/scsi_lib.c	2002-09-10 23:30:50.000000000 -0500
@@ -335,7 +335,7 @@
 		return SCpnt;
 	}
 
-	add_blkdev_randomness(major(req->rq_dev));
+	add_timer_randomness(0, (unsigned)req);
 
 	if(blk_rq_tagged(req))
 		blk_queue_end_tag(q, req);
diff -urN clean/include/linux/blk.h patched/include/linux/blk.h
--- clean/include/linux/blk.h	2002-07-20 14:11:33.000000000 -0500
+++ patched/include/linux/blk.h	2002-09-10 23:30:50.000000000 -0500
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
+	add_timer_randomness(0, (unsigned)req);
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 }
diff -urN clean/include/linux/input.h patched/include/linux/input.h
--- clean/include/linux/input.h	2002-09-04 11:28:43.000000000 -0500
+++ patched/include/linux/input.h	2002-09-10 23:30:50.000000000 -0500
@@ -785,6 +785,7 @@
 
 	unsigned int repeat_key;
 	struct timer_list timer;
+	void *entropy;
 
 	struct pm_dev *pm_dev;
 	int state;
diff -urN clean/include/linux/random.h patched/include/linux/random.h
--- clean/include/linux/random.h	2002-09-10 23:30:49.000000000 -0500
+++ patched/include/linux/random.h	2002-09-10 23:30:50.000000000 -0500
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
