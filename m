Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWI3X3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWI3X3B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 19:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWI3X27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 19:28:59 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:34233 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1750842AbWI3X26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 19:28:58 -0400
Message-id: <244313432324342@wsc.cz>
Subject: [PATCH] Char, another tmp_buf cleanup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <bentson@grieg.seaslug.org>
Cc: <acme@conectiva.com.br>, <Eng.Linux@digi.com>
Cc: <async@cyclades.com>, <marcio@cyclades.com>, <digiLinux@digi.com>
Cc: <R.E.Wolff@BitWizard.nl>, <pgmdsg@ibi.com>
Date: Sun,  1 Oct 2006 01:28:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

char, another tmp_buf cleanup

No need to allocate one page as a side buffer. It's no more used. Clean
this (de)allocs of this useless memory pages in char subtree.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 810378cbe277c73f99219e343f54e782459b6b61
tree c15ae0d37590a8a31dd38c47e05ea97f09d3e1a2
parent 4942c46b234b3aefcfae4ceb59e54af7b537895d
author Jiri Slaby <jirislaby@gmail.com> Sun, 01 Oct 2006 01:06:39 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sun, 01 Oct 2006 01:06:39 +0200

 drivers/char/amiserial.c      |   30 +-----------------------------
 drivers/char/cyclades.c       |   28 +---------------------------
 drivers/char/epca.c           |   17 ++---------------
 drivers/char/epca.h           |    1 -
 drivers/char/generic_serial.c |   19 +------------------
 drivers/char/riscom8.c        |   10 +---------
 drivers/char/serial167.c      |   20 +-------------------
 7 files changed, 7 insertions(+), 118 deletions(-)

diff --git a/drivers/char/amiserial.c b/drivers/char/amiserial.c
index d0e92ed..486f97c 100644
--- a/drivers/char/amiserial.c
+++ b/drivers/char/amiserial.c
@@ -112,17 +112,6 @@ static struct serial_state rs_table[1];
 
 #define NR_PORTS ARRAY_SIZE(rs_table)
 
-/*
- * tmp_buf is used as a temporary buffer by serial_write.  We need to
- * lock it in case the copy_from_user blocks while swapping in a page,
- * and some other program tries to do a serial write at the same time.
- * Since the lock will only come under contention when the system is
- * swapping and available memory is low, it makes sense to share one
- * buffer across all the serial ports, since it significantly saves
- * memory if large numbers of serial ports are open.
- */
-static unsigned char *tmp_buf;
-
 #include <asm/uaccess.h>
 
 #define serial_isroot()	(capable(CAP_SYS_ADMIN))
@@ -912,7 +901,7 @@ static int rs_write(struct tty_struct * 
 	if (serial_paranoia_check(info, tty->name, "rs_write"))
 		return 0;
 
-	if (!info->xmit.buf || !tmp_buf)
+	if (!info->xmit.buf)
 		return 0;
 
 	local_save_flags(flags);
@@ -1778,7 +1767,6 @@ static int rs_open(struct tty_struct *tt
 {
 	struct async_struct	*info;
 	int 			retval, line;
-	unsigned long		page;
 
 	line = tty->index;
 	if ((line < 0) || (line >= NR_PORTS)) {
@@ -1798,17 +1786,6 @@ #ifdef SERIAL_DEBUG_OPEN
 #endif
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
-	if (!tmp_buf) {
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page) {
-			return -ENOMEM;
-		}
-		if (tmp_buf)
-			free_page(page);
-		else
-			tmp_buf = (unsigned char *) page;
-	}
-
 	/*
 	 * If the port is the middle of closing, bail out now
 	 */
@@ -2090,11 +2067,6 @@ static __exit void rs_exit(void) 
 	  kfree(info);
 	}
 
-	if (tmp_buf) {
-		free_page((unsigned long) tmp_buf);
-		tmp_buf = NULL;
-	}
-
 	release_mem_region(CUSTOM_PHYSADDR+0x30, 4);
 }
 
diff --git a/drivers/char/cyclades.c b/drivers/char/cyclades.c
index f85b4eb..87b2fb5 100644
--- a/drivers/char/cyclades.c
+++ b/drivers/char/cyclades.c
@@ -748,18 +748,6 @@ static struct cyclades_port cy_port[NR_P
 static int cy_next_channel; /* next minor available */
 
 /*
- * tmp_buf is used as a temporary buffer by serial_write.  We need to
- * lock it in case the copy_from_user blocks while swapping in a page,
- * and some other program tries to do a serial write at the same time.
- * Since the lock will only come under contention when the system is
- * swapping and available memory is low, it makes sense to share one
- * buffer across all the serial ports, since it significantly saves
- * memory if large numbers of serial ports are open.  This buffer is
- * allocated when the first cy_open occurs.
- */
-static unsigned char *tmp_buf;
-
-/*
  * This is used to look up the divisor speeds and the timeouts
  * We're normally limited to 15 distinct baud rates.  The extra
  * are accessed via settings in info->flags.
@@ -2466,7 +2454,6 @@ cy_open(struct tty_struct *tty, struct f
 {
   struct cyclades_port  *info;
   int retval, line;
-  unsigned long page;
 
     line = tty->index;
     if ((line < 0) || (NR_PORTS <= line)){
@@ -2545,15 +2532,6 @@ #ifdef CY_DEBUG_COUNT
     printk("cyc:cy_open (%d): incrementing count to %d\n",
         current->pid, info->count);
 #endif
-    if (!tmp_buf) {
-	page = get_zeroed_page(GFP_KERNEL);
-	if (!page)
-	    return -ENOMEM;
-	if (tmp_buf)
-	    free_page(page);
-	else
-	    tmp_buf = (unsigned char *) page;
-    }
 
     /*
      * If the port is the middle of closing, bail out now
@@ -2832,7 +2810,7 @@ #endif
         return 0;
     }
         
-    if (!info->xmit_buf || !tmp_buf)
+    if (!info->xmit_buf)
 	return 0;
 
     CY_LOCK(info, flags);
@@ -5490,10 +5468,6 @@ #ifdef CONFIG_PCI
 #endif
         }
     }
-    if (tmp_buf) {
-	free_page((unsigned long) tmp_buf);
-	tmp_buf = NULL;
-    }
 } /* cy_cleanup_module */
 
 module_init(cy_init);
diff --git a/drivers/char/epca.c b/drivers/char/epca.c
index 3baa2ab..c3f9558 100644
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -1113,11 +1113,8 @@ static void __exit epca_module_exit(void
 		ch = card_ptr[crd];
 		for (count = 0; count < bd->numports; count++, ch++) 
 		{ /* Begin for each port */
-			if (ch) {
-				if (ch->tty)
-					tty_hangup(ch->tty);
-				kfree(ch->tmp_buf);
-			}
+			if (ch && ch->tty)
+				tty_hangup(ch->tty);
 		} /* End for each port */
 	} /* End for each card */
 	pci_unregister_driver (&epca_driver);
@@ -1635,16 +1632,6 @@ static void post_fep_init(unsigned int c
 		init_waitqueue_head(&ch->close_wait);
 
 		spin_unlock_irqrestore(&epca_lock, flags);
-
-		ch->tmp_buf = kmalloc(ch->txbufsize,GFP_KERNEL);
-		if (!ch->tmp_buf) {
-			printk(KERN_ERR "POST FEP INIT : kmalloc failed for port 0x%x\n",i);
-			release_region((int)bd->port, 4);
-			while(i-- > 0)
-				kfree((ch--)->tmp_buf);
-			return;
-		} else
-			memset((void *)ch->tmp_buf,0,ch->txbufsize);
 	} /* End for each port */
 
 	printk(KERN_INFO 
diff --git a/drivers/char/epca.h b/drivers/char/epca.h
index 456d6c8..a297238 100644
--- a/drivers/char/epca.h
+++ b/drivers/char/epca.h
@@ -130,7 +130,6 @@ struct channel 
 	unsigned long  c_oflag;
 	unsigned char __iomem *txptr;
 	unsigned char __iomem *rxptr;
-	unsigned char *tmp_buf;
 	struct board_info           *board;
 	struct board_chan	    __iomem *brdchan;
 	struct digi_struct          digiext;
diff --git a/drivers/char/generic_serial.c b/drivers/char/generic_serial.c
index 4711d9b..87127e4 100644
--- a/drivers/char/generic_serial.c
+++ b/drivers/char/generic_serial.c
@@ -33,8 +33,6 @@ #include <asm/uaccess.h>
 
 #define DEBUG 
 
-static char *                  tmp_buf; 
-
 static int gs_debug;
 
 #ifdef DEBUG
@@ -205,7 +203,7 @@ int gs_write(struct tty_struct * tty,
 	if (!tty) return -EIO;
 
 	port = tty->driver_data;
-	if (!port || !port->xmit_buf || !tmp_buf)
+	if (!port || !port->xmit_buf)
 		return -EIO;
 
 	local_save_flags(flags);
@@ -837,24 +835,9 @@ #endif
 int gs_init_port(struct gs_port *port)
 {
 	unsigned long flags;
-	unsigned long page;
 
 	func_enter ();
 
-        if (!tmp_buf) {
-		page = get_zeroed_page(GFP_KERNEL);
-		spin_lock_irqsave (&port->driver_lock, flags); /* Don't expect this to make a difference. */
-		if (tmp_buf)
-			free_page(page);
-		else
-			tmp_buf = (unsigned char *) page;
-		spin_unlock_irqrestore (&port->driver_lock, flags);
-		if (!tmp_buf) {
-			func_exit ();
-			return -ENOMEM;
-		}
-	}
-
 	if (port->flags & ASYNC_INITIALIZED) {
 		func_exit ();
 		return 0;
diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
index 214d850..b0ab3f2 100644
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -81,7 +81,6 @@ #define RS_EVENT_WRITE_WAKEUP	0
 
 static struct riscom_board * IRQ_to_board[16];
 static struct tty_driver *riscom_driver;
-static unsigned char * tmp_buf;
 
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
@@ -1124,7 +1123,7 @@ static int rc_write(struct tty_struct * 
 	
 	bp = port_Board(port);
 
-	if (!tty || !port->xmit_buf || !tmp_buf)
+	if (!tty || !port->xmit_buf)
 		return 0;
 
 	save_flags(flags);
@@ -1612,11 +1611,6 @@ static inline int rc_init_drivers(void)
 	if (!riscom_driver)	
 		return -ENOMEM;
 	
-	if (!(tmp_buf = (unsigned char *) get_zeroed_page(GFP_KERNEL))) {
-		printk(KERN_ERR "rc: Couldn't get free page.\n");
-		put_tty_driver(riscom_driver);
-		return 1;
-	}
 	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));
 	riscom_driver->owner = THIS_MODULE;
 	riscom_driver->name = "ttyL";
@@ -1629,7 +1623,6 @@ static inline int rc_init_drivers(void)
 	riscom_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(riscom_driver, &riscom_ops);
 	if ((error = tty_register_driver(riscom_driver)))  {
-		free_page((unsigned long)tmp_buf);
 		put_tty_driver(riscom_driver);
 		printk(KERN_ERR "rc: Couldn't register RISCom/8 driver, "
 				"error = %d\n",
@@ -1657,7 +1650,6 @@ static void rc_release_drivers(void)
 
 	save_flags(flags);
 	cli();
-	free_page((unsigned long)tmp_buf);
 	tty_unregister_driver(riscom_driver);
 	put_tty_driver(riscom_driver);
 	restore_flags(flags);
diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
index b4ea126..48dae5d 100644
--- a/drivers/char/serial167.c
+++ b/drivers/char/serial167.c
@@ -119,17 +119,6 @@ struct cyclades_port cy_port[] = {
 #define NR_PORTS        ARRAY_SIZE(cy_port)
 
 /*
- * tmp_buf is used as a temporary buffer by serial_write.  We need to
- * lock it in case the copy_from_user blocks while swapping in a page,
- * and some other program tries to do a serial write at the same time.
- * Since the lock will only come under contention when the system is
- * swapping and available memory is low, it makes sense to share one
- * buffer across all the serial ports, since it significantly saves
- * memory if large numbers of serial ports are open.
- */
-static unsigned char *tmp_buf = 0;
-
-/*
  * This is used to look up the divisor speeds and the timeouts
  * We're normally limited to 15 distinct baud rates.  The extra
  * are accessed via settings in info->flags.
@@ -1198,7 +1187,7 @@ #endif
 	return 0;
     }
 	
-    if (!tty || !info->xmit_buf || !tmp_buf){
+    if (!tty || !info->xmit_buf){
         return 0;
     }
 
@@ -1983,13 +1972,6 @@ #endif
     tty->driver_data = info;
     info->tty = tty;
 
-    if (!tmp_buf) {
-	tmp_buf = (unsigned char *) get_zeroed_page(GFP_KERNEL);
-	if (!tmp_buf){
-	    return -ENOMEM;
-        }
-    }
-
     /*
      * Start up serial port
      */
