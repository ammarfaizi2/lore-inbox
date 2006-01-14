Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWANQbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWANQbx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 11:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWANQbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 11:31:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6087 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964801AbWANQbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 11:31:52 -0500
Date: Sat, 14 Jan 2006 17:32:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: [patch 2.6.15-mm4] sem2mutex: serial ->port_write_mutex
Message-ID: <20060114163206.GA6131@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 drivers/char/generic_serial.c  |   14 +++++++-------
 drivers/char/ser_a2232.c       |    4 ++--
 drivers/char/sx.c              |    2 +-
 drivers/char/vme_scc.c         |    2 +-
 include/linux/generic_serial.h |    2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

Index: linux/drivers/char/generic_serial.c
===================================================================
--- linux.orig/drivers/char/generic_serial.c
+++ linux/drivers/char/generic_serial.c
@@ -49,8 +49,8 @@ static int gs_debug;
 #define NEW_WRITE_LOCKING 1
 #if NEW_WRITE_LOCKING
 #define DECL      /* Nothing */
-#define LOCKIT    down (& port->port_write_sem);
-#define RELEASEIT up (&port->port_write_sem);
+#define LOCKIT    mutex_lock(& port->port_write_mutex);
+#define RELEASEIT mutex_unlock(&port->port_write_mutex);
 #else
 #define DECL      unsigned long flags;
 #define LOCKIT    save_flags (flags);cli ()
@@ -125,14 +125,14 @@ int gs_write(struct tty_struct * tty, 
 	/* get exclusive "write" access to this port (problem 3) */
 	/* This is not a spinlock because we can have a disk access (page 
 		 fault) in copy_from_user */
-	down (& port->port_write_sem);
+	mutex_lock(& port->port_write_mutex);
 
 	while (1) {
 
 		c = count;
  
 		/* This is safe because we "OWN" the "head". Noone else can 
-		   change the "head": we own the port_write_sem. */
+		   change the "head": we own the port_write_mutex. */
 		/* Don't overrun the end of the buffer */
 		t = SERIAL_XMIT_SIZE - port->xmit_head;
 		if (t < c) c = t;
@@ -154,7 +154,7 @@ int gs_write(struct tty_struct * tty, 
 		count -= c;
 		total += c;
 	}
-	up (& port->port_write_sem);
+	mutex_unlock(& port->port_write_mutex);
 
 	gs_dprintk (GS_DEBUG_WRITE, "write: interrupts are %s\n", 
 	            (port->flags & GS_TX_INTEN)?"enabled": "disabled"); 
@@ -215,7 +215,7 @@ int gs_write(struct tty_struct * tty,
 		c = count;
 
 		/* This is safe because we "OWN" the "head". Noone else can 
-		   change the "head": we own the port_write_sem. */
+		   change the "head": we own the port_write_mutex. */
 		/* Don't overrun the end of the buffer */
 		t = SERIAL_XMIT_SIZE - port->xmit_head;
 		if (t < c) c = t;
@@ -889,7 +889,7 @@ int gs_init_port(struct gs_port *port)
 	spin_lock_irqsave (&port->driver_lock, flags);
 	if (port->tty) 
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
-	init_MUTEX(&port->port_write_sem);
+	mutex_init(&port->port_write_mutex);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
 	spin_unlock_irqrestore(&port->driver_lock, flags);
 	gs_set_termios(port->tty, NULL);
Index: linux/drivers/char/ser_a2232.c
===================================================================
--- linux.orig/drivers/char/ser_a2232.c
+++ linux/drivers/char/ser_a2232.c
@@ -97,7 +97,7 @@
 #include <asm/amigahw.h>
 #include <linux/zorro.h>
 #include <asm/irq.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #include <linux/delay.h>
 
@@ -653,7 +653,7 @@ static void a2232_init_portstructs(void)
 		port->gs.closing_wait = 30 * HZ;
 		port->gs.rd = &a2232_real_driver;
 #ifdef NEW_WRITE_LOCKING
-		init_MUTEX(&(port->gs.port_write_sem));
+		init_MUTEX(&(port->gs.port_write_mutex));
 #endif
 		init_waitqueue_head(&port->gs.open_wait);
 		init_waitqueue_head(&port->gs.close_wait);
Index: linux/drivers/char/sx.c
===================================================================
--- linux.orig/drivers/char/sx.c
+++ linux/drivers/char/sx.c
@@ -2314,7 +2314,7 @@ static int sx_init_portstructs (int nboa
 			port->board = board;
 			port->gs.rd = &sx_real_driver;
 #ifdef NEW_WRITE_LOCKING
-			port->gs.port_write_sem = MUTEX;
+			port->gs.port_write_mutex = MUTEX;
 #endif
 			port->gs.driver_lock = SPIN_LOCK_UNLOCKED;
 			/*
Index: linux/drivers/char/vme_scc.c
===================================================================
--- linux.orig/drivers/char/vme_scc.c
+++ linux/drivers/char/vme_scc.c
@@ -184,7 +184,7 @@ static void scc_init_portstructs(void)
 		port->gs.closing_wait = 30 * HZ;
 		port->gs.rd = &scc_real_driver;
 #ifdef NEW_WRITE_LOCKING
-		port->gs.port_write_sem = MUTEX;
+		port->gs.port_write_mutex = MUTEX;
 #endif
 		init_waitqueue_head(&port->gs.open_wait);
 		init_waitqueue_head(&port->gs.close_wait);
Index: linux/include/linux/generic_serial.h
===================================================================
--- linux.orig/include/linux/generic_serial.h
+++ linux/include/linux/generic_serial.h
@@ -34,7 +34,7 @@ struct gs_port {
   int                     xmit_head;
   int                     xmit_tail;
   int                     xmit_cnt;
-  struct semaphore        port_write_sem;
+  struct mutex            port_write_mutex;
   int                     flags;
   wait_queue_head_t       open_wait;
   wait_queue_head_t       close_wait;
