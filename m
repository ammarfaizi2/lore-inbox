Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUFTG2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUFTG2S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 02:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUFTG2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 02:28:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:2447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264903AbUFTG2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 02:28:14 -0400
Date: Sat, 19 Jun 2004 23:27:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, vojtech@ucw.cz
Subject: Re: [PATCH 6/11] serio dynamic allocation
Message-Id: <20040619232717.69b1b6e9.akpm@osdl.org>
In-Reply-To: <200406200030.53331.dtor_core@ameritech.net>
References: <200406180335.52843.dtor_core@ameritech.net>
	<200406180340.55615.dtor_core@ameritech.net>
	<20040619220700.08425715.akpm@osdl.org>
	<200406200030.53331.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> > 
>  > It seems that simply removing that static initialiser will fix
>  > it up, but I assume it was added for some reason, so I'll leave
>  > you to ponder that.
>  > 
> 
>  No, removing the initialization is the correct way to fix it. We can
>  only assign these values after platform init is done.

Ok..

You'll be needing this...

 25-sparc64-akpm/drivers/serial/sunsu.c    |    8 ++++----
 25-sparc64-akpm/drivers/serial/sunzilog.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff -puN drivers/serial/sunzilog.c~input-serio-renames-1-fix drivers/serial/sunzilog.c
--- 25-sparc64/drivers/serial/sunzilog.c~input-serio-renames-1-fix	2004-06-19 23:12:14.764325264 -0700
+++ 25-sparc64-akpm/drivers/serial/sunzilog.c	2004-06-19 23:15:09.411774816 -0700
@@ -1295,7 +1295,7 @@ static spinlock_t sunzilog_serio_lock = 
 
 static int sunzilog_serio_write(struct serio *serio, unsigned char ch)
 {
-	struct uart_sunzilog_port *up = serio->driver;
+	struct uart_sunzilog_port *up = serio->port_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sunzilog_serio_lock, flags);
@@ -1309,7 +1309,7 @@ static int sunzilog_serio_write(struct s
 
 static int sunzilog_serio_open(struct serio *serio)
 {
-	struct uart_sunzilog_port *up = serio->driver;
+	struct uart_sunzilog_port *up = serio->port_data;
 	unsigned long flags;
 	int ret;
 
@@ -1326,7 +1326,7 @@ static int sunzilog_serio_open(struct se
 
 static void sunzilog_serio_close(struct serio *serio)
 {
-	struct uart_sunzilog_port *up = serio->driver;
+	struct uart_sunzilog_port *up = serio->port_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sunzilog_serio_lock, flags);
@@ -1549,7 +1549,7 @@ static void __init sunzilog_init_kbdms(s
 #ifdef CONFIG_SERIO
 	memset(&up->serio, 0, sizeof(up->serio));
 
-	up->serio.driver = up;
+	up->serio.port_data = up;
 
 	up->serio.type = SERIO_RS232;
 	if (channel == KEYBOARD_LINE) {
diff -puN drivers/serial/sunsu.c~input-serio-renames-1-fix drivers/serial/sunsu.c
--- 25-sparc64/drivers/serial/sunsu.c~input-serio-renames-1-fix	2004-06-19 23:12:14.780322832 -0700
+++ 25-sparc64-akpm/drivers/serial/sunsu.c	2004-06-19 23:16:11.737299896 -0700
@@ -994,7 +994,7 @@ static spinlock_t sunsu_serio_lock = SPI
 
 static int sunsu_serio_write(struct serio *serio, unsigned char ch)
 {
-	struct uart_sunsu_port *up = serio->driver;
+	struct uart_sunsu_port *up = serio->port_data;
 	unsigned long flags;
 	int lsr;
 
@@ -1014,7 +1014,7 @@ static int sunsu_serio_write(struct seri
 
 static int sunsu_serio_open(struct serio *serio)
 {
-	struct uart_sunsu_port *up = serio->driver;
+	struct uart_sunsu_port *up = serio->port_data;
 	unsigned long flags;
 	int ret;
 
@@ -1031,7 +1031,7 @@ static int sunsu_serio_open(struct serio
 
 static void sunsu_serio_close(struct serio *serio)
 {
-	struct uart_sunsu_port *up = serio->driver;
+	struct uart_sunsu_port *up = serio->port_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sunsu_serio_lock, flags);
@@ -1311,7 +1311,7 @@ static int __init sunsu_kbd_ms_init(void
 #ifdef CONFIG_SERIO
 		memset(&up->serio, 0, sizeof(up->serio));
 
-		up->serio.driver = up;
+		up->serio.port_data = up;
 
 		up->serio.type = SERIO_RS232;
 		if (up->su_type == SU_PORT_KBD) {
_

