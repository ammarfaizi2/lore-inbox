Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSL0QIy>; Fri, 27 Dec 2002 11:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSL0QHS>; Fri, 27 Dec 2002 11:07:18 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:14415 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265092AbSL0QDs>; Fri, 27 Dec 2002 11:03:48 -0500
Date: Fri, 27 Dec 2002 17:11:09 +0100
Message-Id: <200212271611.gBRGB94R008011@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Atari core local_irq*() updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert core Atari code to new local_irq*() framework

--- linux-2.5.53/arch/m68k/atari/ataints.c	Tue Nov  5 10:09:40 2002
+++ linux-m68k-2.5.53/arch/m68k/atari/ataints.c	Thu Nov  7 22:02:56 2002
@@ -481,8 +481,7 @@
 		irq_node_t *node;
 		unsigned long flags;
 
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 
 		if (irq_handler[irq].handler != atari_call_irq_list) {
 			/* Only one handler yet, make a node for this first one */
@@ -507,7 +506,7 @@
 		node->next = irq_handler[irq].dev_id;
 		irq_handler[irq].dev_id = node;
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return 0;
 	} else {
 		printk ("%s: Irq %d allocated by other type int (call from %s)\n",
@@ -531,13 +530,12 @@
 	if (vectors[vector] == bad_interrupt)
 		goto not_found;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if (irq_handler[irq].handler != atari_call_irq_list) {
 		/* It's the only handler for the interrupt */
 		if (irq_handler[irq].dev_id != dev_id) {
-			restore_flags(flags);
+			local_irq_restore(flags);
 			goto not_found;
 		}
 		irq_handler[irq].handler = NULL;
@@ -548,7 +546,7 @@
 		atari_disable_irq(irq);
 		atari_turnoff_irq(irq);
 
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -557,7 +555,7 @@
 		if ((*list)->dev_id == dev_id) break;
 	}
 	if (!*list) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		goto not_found;
 	}
 
@@ -574,7 +572,7 @@
 		node->handler = NULL; /* Mark it as free for reallocation */
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return;
 
 not_found:
--- linux-2.5.53/arch/m68k/atari/config.c	Sat Oct 12 23:50:35 2002
+++ linux-m68k-2.5.53/arch/m68k/atari/config.c	Thu Nov  7 22:03:22 2002
@@ -509,12 +509,11 @@
     if (atari_dont_touch_floppy_select)
 	return;
     
-    save_flags(flags);
-    cli();
+    local_irq_save(flags);
     sound_ym.rd_data_reg_sel = 14; /* Select PSG Port A */
     tmp = sound_ym.rd_data_reg_sel;
     sound_ym.wd_data = on ? (tmp & ~0x02) : (tmp | 0x02);
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
 #endif
 
@@ -569,7 +568,7 @@
     /* processor independent: turn off interrupts and reset the VBR;
      * the caches must be left enabled, else prefetching the final jump
      * instruction doesn't work. */
-    cli();
+    local_irq_disable();
     __asm__ __volatile__
 	("moveq	#0,%/d0\n\t"
 	 "movec	%/d0,%/vbr"
--- linux-2.5.53/arch/m68k/atari/time.c	Sun Apr  7 10:56:12 2002
+++ linux-m68k-2.5.53/arch/m68k/atari/time.c	Thu Nov  7 22:03:37 2002
@@ -216,8 +216,7 @@
         schedule_timeout(HWCLK_POLL_INTERVAL);
     }
 
-    save_flags(flags);
-    cli();
+    local_irq_save(flags);
     RTC_WRITE( RTC_CONTROL, ctrl | RTC_SET );
     if (!op) {
         sec  = RTC_READ( RTC_SECONDS );
@@ -238,7 +237,7 @@
         if (wday >= 0) RTC_WRITE( RTC_DAY_OF_WEEK, wday );
     }
     RTC_WRITE( RTC_CONTROL, ctrl & ~RTC_SET );
-    restore_flags(flags);
+    local_irq_restore(flags);
 
     if (!op) {
         /* read: adjust values */
--- linux-2.5.53/arch/m68k/atari/atasound.c	Wed Sep  2 18:39:18 1998
+++ linux-m68k-2.5.53/arch/m68k/atari/atasound.c	Thu Nov  7 22:03:13 2002
@@ -58,8 +58,7 @@
 	unsigned char tmp;
 	int period;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 
 	/* Disable generator A in mixer control.  */
@@ -106,5 +105,5 @@
 	tmp &= ~1;
 	sound_ym.wd_data = tmp;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
--- linux-2.5.53/arch/m68k/atari/stdma.c	Sat Sep  4 22:06:41 1999
+++ linux-m68k-2.5.53/arch/m68k/atari/stdma.c	Thu Nov  7 22:03:33 2002
@@ -75,10 +75,9 @@
 
 void stdma_lock(void (*handler)(int, void *, struct pt_regs *), void *data)
 {
-	unsigned long	oldflags;
+	unsigned long flags;
 
-	save_flags(oldflags);
-	cli();		/* protect lock */
+	local_irq_save(flags);		/* protect lock */
 
 	while(stdma_locked)
 		/* Since the DMA is used for file system purposes, we
@@ -89,7 +88,7 @@
 	stdma_locked   = 1;
 	stdma_isr      = handler;
 	stdma_isr_data = data;
-	restore_flags(oldflags);
+	local_irq_restore(flags);
 }
 
 
@@ -106,17 +105,16 @@
 
 void stdma_release(void)
 {
-	unsigned long	oldflags;
+	unsigned long flags;
+
+	local_irq_save(flags);
 
-	save_flags(oldflags);
-	cli();
-	
 	stdma_locked   = 0;
 	stdma_isr      = NULL;
 	stdma_isr_data = NULL;
 	wake_up(&stdma_wait);
 
-	restore_flags(oldflags);
+	local_irq_restore(flags);
 }
 
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
