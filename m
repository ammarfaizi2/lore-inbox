Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262994AbTCSMUX>; Wed, 19 Mar 2003 07:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263015AbTCSMUQ>; Wed, 19 Mar 2003 07:20:16 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:60295 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262994AbTCSMRA>;
	Wed, 19 Mar 2003 07:17:00 -0500
Date: Wed, 19 Mar 2003 13:27:43 +0100 (MET)
Message-Id: <200303191227.h2JCRh500892@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Amiga serial updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Amiga serial driver to use tasklets (from Roman Zippel)

--- linux-2.5.x/drivers/char/amiserial.c	Sun Oct 13 14:55:30 2002
+++ linux-m68k-2.5.x/drivers/char/amiserial.c	Sun Oct 13 10:55:56 2002
@@ -102,8 +102,6 @@
 
 static char *serial_name = "Amiga-builtin serial driver";
 
-static DECLARE_TASK_QUEUE(tq_serial);
-
 static struct tty_driver serial_driver, callout_driver;
 static int serial_refcount;
 
@@ -276,8 +274,7 @@
 				  int event)
 {
 	info->event |= 1 << event;
-	queue_task(&info->tqueue, &tq_serial);
-	mark_bh(SERIAL_BH);
+	tasklet_schedule(&info->tlet);
 }
 
 static _INLINE_ void receive_chars(struct async_struct *info)
@@ -560,12 +557,8 @@
  * interrupt driver proper are done; the interrupt driver schedules
  * them using rs_sched_event(), and they get done here.
  */
-static void do_serial_bh(void)
-{
-	run_task_queue(&tq_serial);
-}
 
-static void do_softint(void *private_)
+static void do_softint(unsigned long private_)
 {
 	struct async_struct	*info = (struct async_struct *) private_;
 	struct tty_struct	*tty;
@@ -1879,8 +1872,7 @@
 	info->flags = sstate->flags;
 	info->xmit_fifo_size = sstate->xmit_fifo_size;
 	info->line = line;
-	info->tqueue.routine = do_softint;
-	info->tqueue.data = info;
+	tasklet_init(&info->tlet, do_softint, (unsigned long)info);
 	info->state = sstate;
 	if (sstate->info) {
 		kfree(info);
@@ -2118,8 +2110,6 @@
 	if (!request_mem_region(CUSTOM_PHYSADDR+0x30, 4, "amiserial [Paula]"))
 		return -EBUSY;
 
-	init_bh(SERIAL_BH, do_serial_bh);
-
 	IRQ_ports = NULL;
 
 	show_serial_version();
@@ -2236,23 +2226,18 @@
 
 static __exit void rs_exit(void) 
 {
-	unsigned long flags;
 	int e1, e2;
-	struct async_struct *info;
+	struct async_struct *info = rs_table[0].info;
 
 	/* printk("Unloading %s: version %s\n", serial_name, serial_version); */
-	save_flags(flags);
-	cli();
-        remove_bh(SERIAL_BH);
+	tasklet_kill(&info->tlet);
 	if ((e1 = tty_unregister_driver(&serial_driver)))
 		printk("SERIAL: failed to unregister serial driver (%d)\n",
 		       e1);
 	if ((e2 = tty_unregister_driver(&callout_driver)))
 		printk("SERIAL: failed to unregister callout driver (%d)\n", 
 		       e2);
-	restore_flags(flags);
 
-	info = rs_table[0].info;
 	if (info) {
 	  rs_table[0].info = NULL;
 	  kfree(info);
--- linux-2.5.x/include/linux/serialP.h	Sat Oct 12 19:20:55 2002
+++ linux-m68k-2.5.x/include/linux/serialP.h	Sun Oct 13 10:55:56 2002
@@ -22,6 +22,7 @@
 #include <linux/config.h>
 #include <linux/termios.h>
 #include <linux/workqueue.h>
+#include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/wait.h>
 #if (LINUX_VERSION_CODE < 0x020300)
@@ -87,6 +88,7 @@
 	u16			iomem_reg_shift;
 	int			io_type;
 	struct work_struct			work;
+	struct tasklet_struct	tlet;
 #ifdef DECLARE_WAITQUEUE
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
