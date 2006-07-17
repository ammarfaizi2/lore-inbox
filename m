Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWGQQbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWGQQbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWGQQbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:31:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:19642 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750928AbWGQQbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:31:40 -0400
Date: Mon, 17 Jul 2006 09:29:34 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, rmk@arm.linux.org.uk
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       enrico.scholz@informatik.tu-chemnitz.de,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 44/45] serial 8250: sysrq deadlock fix
Message-ID: <20060717162934.GS4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="serial-8250-sysrq-deadlock-fix.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew Morton <akpm@osdl.org>

Fix http://bugzilla.kernel.org/show_bug.cgi?id=6716

Doing a sysrq over a serial line into an SMP machine presently deadlocks.

Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/serial/8250.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- linux-2.6.17.6.orig/drivers/serial/8250.c
+++ linux-2.6.17.6/drivers/serial/8250.c
@@ -2241,10 +2241,14 @@ serial8250_console_write(struct console 
 
 	touch_nmi_watchdog();
 
-	if (oops_in_progress) {
-		locked = spin_trylock_irqsave(&up->port.lock, flags);
+	local_irq_save(flags);
+	if (up->port.sysrq) {
+		/* serial8250_handle_port() already took the lock */
+		locked = 0;
+	} else if (oops_in_progress) {
+		locked = spin_trylock(&up->port.lock);
 	} else
-		spin_lock_irqsave(&up->port.lock, flags);
+		spin_lock(&up->port.lock);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -2266,7 +2270,8 @@ serial8250_console_write(struct console 
 	serial_out(up, UART_IER, ier);
 
 	if (locked)
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		spin_unlock(&up->port.lock);
+	local_irq_restore(flags);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)

--
