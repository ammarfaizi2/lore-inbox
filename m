Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVBPSiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVBPSiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 13:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVBPSii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 13:38:38 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:28024 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262019AbVBPSgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 13:36:54 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [BUG: UML 2.6.11-rc4-bk-latest] sleeping function called from invalid context and segmentation fault
Date: Wed, 16 Feb 2005 19:35:43 +0100
User-Agent: KMail/1.7.2
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Dike <jdike@addtoit.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <1108381733.10703.5.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1108381733.10703.5.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/J5ECLKCtOcrOSY"
Message-Id: <200502161935.43820.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/J5ECLKCtOcrOSY
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 14 February 2005 12:48, Anton Altaparmakov wrote:
> Hi,
>
> I get a few Debug messages of the form from UML:
>
> Debug: sleeping function called from invalid context at
> include/asm/arch/semaphore.h:107
> in_atomic():0, irqs_disabled():1
> Call Trace:
> 087d77b0:  [<0809aaa5>] __might_sleep+0x135/0x180
> 087d77d8:  [<084d377f>] mcount+0xf/0x20
> 087d77e0:  [<0807cc13>] uml_console_write+0x33/0x80

> Most are coming via uml_console_write.
The problem is that the UML tty drivers use a semaphore instead of a spinlock 
for the locking, which also causes some other problems.

The attached patch should fix this, but I've not yet made sure it is not 
deadlock-prone (I didn't hit any during some very limited testing).

So it's not yet ready for 2.6.11.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_/J5ECLKCtOcrOSY
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="uml-console-redo-locking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-console-redo-locking.patch"



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/line.c          |   49 +++++++++------------
 linux-2.6.11-paolo/arch/um/drivers/ssl.c           |   16 +-----
 linux-2.6.11-paolo/arch/um/drivers/stdio_console.c |   16 +-----
 linux-2.6.11-paolo/arch/um/include/line.h          |   16 ------
 4 files changed, 31 insertions(+), 66 deletions(-)

diff -puN arch/um/drivers/line.c~uml-console-redo-locking arch/um/drivers/line.c
--- linux-2.6.11/arch/um/drivers/line.c~uml-console-redo-locking	2005-02-07 19:16:49.954057296 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/line.c	2005-02-07 19:16:49.969055016 +0100
@@ -52,6 +52,7 @@ static int write_room(struct line *dev)
 	return (n - 1);
 }
 
+/* Must be called while holding line->lock!*/
 static int buffer_data(struct line *line, const char *buf, int len)
 {
 	int end, room;
@@ -84,6 +85,7 @@ static int buffer_data(struct line *line
 	return(len);
 }
 
+/* Must be called while holding line->lock!*/
 static int flush_buffer(struct line *line)
 {
 	int n, count;
@@ -122,16 +124,13 @@ int line_write(struct tty_struct *tty, c
 
 	if(tty->stopped) return 0;
 
-	down(&line->sem);
-	if(line->head != line->tail){
-		local_irq_save(flags);
+	spin_lock_irqsave(&line->lock, flags);
+	if (line->head != line->tail){
 		ret = buffer_data(line, buf, len);
 		err = flush_buffer(line);
-		local_irq_restore(flags);
 		if(err <= 0)
 			ret = err;
-	}
-	else {
+	} else {
 		n = write_chan(&line->chan_list, buf, len, 
 			       line->driver->write_irq);
 		if(n < 0){
@@ -144,8 +143,8 @@ int line_write(struct tty_struct *tty, c
 		if(len > 0)
 			ret += buffer_data(line, buf + n, len);
 	}
- out_up:
-	up(&line->sem);
+out_up:
+	spin_unlock_irqrestore(&line->lock, flags);
 	return(ret);
 }
 
@@ -260,6 +259,7 @@ static irqreturn_t line_write_interrupt(
 	struct line *line = tty->driver_data;
 	int err;
 
+	spin_lock(&line->lock);
 	err = flush_buffer(line);
 	if(err == 0)
 		return(IRQ_NONE);
@@ -267,6 +267,7 @@ static irqreturn_t line_write_interrupt(
 		line->head = line->buffer;
 		line->tail = line->buffer;
 	}
+	spin_unlock(&line->lock);
 
 	if(tty == NULL)
 		return(IRQ_NONE);
@@ -336,7 +337,9 @@ int line_open(struct line *lines, struct
 	line = &lines[tty->index];
 	tty->driver_data = line;
 
-	down(&line->sem);
+	/* The IRQ which takes this lock is not yet enabled and won't be run
+	 * before the end, so we don't need to use spin_lock_irq.*/
+	spin_lock(&line->lock);
 	if (tty->count == 1) {
 		if (!line->valid) {
 			err = -ENODEV;
@@ -349,6 +352,7 @@ int line_open(struct line *lines, struct
 			err = open_chan(&line->chan_list);
 			if(err) goto out;
 		}
+		/* Here the interrupt is registered.*/
 		enable_chan(&line->chan_list, tty);
 		INIT_WORK(&line->task, line_timer_cb, tty);
 	}
@@ -362,7 +366,7 @@ int line_open(struct line *lines, struct
 	line->count++;
 
 out:
-	up(&line->sem);
+	spin_unlock(&line->lock);
 	return(err);
 }
 
@@ -370,13 +374,17 @@ void line_close(struct tty_struct *tty, 
 {
 	struct line *line = tty->driver_data;
 
-	down(&line->sem);
+	spin_lock_irq(&line->lock);
+
+	/* We ignore the error anyway! */
+	flush_buffer(line);
+
 	line->count--;
 	if (tty->count == 1) {
 		line_disable(tty, -1);
 		tty->driver_data = NULL;
 	}
-	up(&line->sem);
+	spin_unlock_irq(&line->lock);
 }
 
 void close_lines(struct line *lines, int nlines)
@@ -474,13 +482,13 @@ int line_get_config(char *name, struct l
 
 	line = &lines[dev];
 
-	down(&line->sem);
+	spin_lock(&line->lock);
 	if(!line->valid)
 		CONFIG_CHUNK(str, size, n, "none", 1);
 	else if(line->count == 0)
 		CONFIG_CHUNK(str, size, n, line->init_str, 1);
 	else n = chan_config_string(&line->chan_list, str, size, error_out);
-	up(&line->sem);
+	spin_unlock(&line->lock);
 
 	return(n);
 }
@@ -553,7 +561,7 @@ void lines_init(struct line *lines, int 
 	for(i = 0; i < nlines; i++){
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
-		sema_init(&line->sem, 1);
+		spin_lock_init(&line->lock);
 		if(line->init_str != NULL){
 			line->init_str = uml_strdup(line->init_str);
 			if(line->init_str == NULL)
@@ -668,14 +676,3 @@ char *add_xterm_umid(char *base)
 	snprintf(title, len, "%s (%s)", base, umid);
 	return(title);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/include/line.h~uml-console-redo-locking arch/um/include/line.h
--- linux-2.6.11/arch/um/include/line.h~uml-console-redo-locking	2005-02-07 19:16:49.961056232 +0100
+++ linux-2.6.11-paolo/arch/um/include/line.h	2005-02-07 19:16:49.969055016 +0100
@@ -10,7 +10,7 @@
 #include "linux/workqueue.h"
 #include "linux/tty.h"
 #include "linux/interrupt.h"
-#include "asm/semaphore.h"
+#include "linux/spinlock.h"
 #include "chan_user.h"
 #include "mconsole_kern.h"
 
@@ -37,7 +37,7 @@ struct line {
 	struct list_head chan_list;
 	int valid;
 	int count;
-	struct semaphore sem;
+	spinlock_t lock;
 	char *buffer;
 	char *head;
 	char *tail;
@@ -52,7 +52,6 @@ struct line {
 	  init_pri :	INIT_STATIC, \
 	  chan_list : 	{ }, \
 	  valid :	1, \
-	  sem : 	{ }, \
 	  buffer :	NULL, \
 	  head :	NULL, \
 	  tail :	NULL, \
@@ -95,14 +94,3 @@ extern int line_get_config(char *dev, st
 			   int size, char **error_out);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/drivers/ssl.c~uml-console-redo-locking arch/um/drivers/ssl.c
--- linux-2.6.11/arch/um/drivers/ssl.c~uml-console-redo-locking	2005-02-07 19:16:49.963055928 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/ssl.c	2005-02-07 19:16:49.970054864 +0100
@@ -171,10 +171,11 @@ static void ssl_console_write(struct con
 			      unsigned len)
 {
 	struct line *line = &serial_lines[c->index];
+	unsigned long flags;
 
-	down(&line->sem);
+	spin_lock_irqsave(&line->lock, flags);
 	console_write_chan(&line->chan_list, string, len);
-	up(&line->sem);
+	spin_unlock_irqrestore(&line->lock, flags);
 }
 
 static struct tty_driver *ssl_console_device(struct console *c, int *index)
@@ -238,14 +239,3 @@ static int ssl_chan_setup(char *str)
 
 __setup("ssl", ssl_chan_setup);
 __channel_help(ssl_chan_setup, "ssl");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/drivers/stdio_console.c~uml-console-redo-locking arch/um/drivers/stdio_console.c
--- linux-2.6.11/arch/um/drivers/stdio_console.c~uml-console-redo-locking	2005-02-07 19:16:49.966055472 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/stdio_console.c	2005-02-07 19:16:49.970054864 +0100
@@ -126,10 +126,11 @@ static void uml_console_write(struct con
 			  unsigned len)
 {
 	struct line *line = &vts[console->index];
+	unsigned long flags;
 
-	down(&line->sem);
+	spin_lock_irqsave(&line->lock, flags);
 	console_write_chan(&line->chan_list, string, len);
-	up(&line->sem);
+	spin_unlock_irqrestore(&line->lock, flags);
 }
 
 static struct tty_driver *uml_console_device(struct console *c, int *index)
@@ -192,14 +193,3 @@ static int console_chan_setup(char *str)
 }
 __setup("con", console_chan_setup);
 __channel_help(console_chan_setup, "con");
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_

--Boundary-00=_/J5ECLKCtOcrOSY--

