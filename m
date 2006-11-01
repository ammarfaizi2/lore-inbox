Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946380AbWKAFjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946380AbWKAFjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946510AbWKAFix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:38:53 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33169 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946270AbWKAFio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:38:44 -0500
Message-Id: <20061101053826.775248000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:00 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Russell King <rmk+kernel@arm.linux.org.uk>,
       maximilian attems <maks@sternwelten.at>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 20/61] SERIAL: Fix oops when removing suspended serial port
Content-Disposition: inline; filename=serial-fix-oops-when-removing-suspended-serial-port.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Russell King <rmk+kernel@arm.linux.org.uk>

[SERIAL] Fix oops when removing suspended serial port

A serial card might have been removed when the system is resumed.
This results in a suspended port being shut down, which results in
the ports shutdown method being called twice in a row.  This causes
BUGs.  Avoid this by tracking the suspended state separately from
the initialised state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: maximilian attems <maks@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/serial/serial_core.c |    9 +++++++--
 include/linux/serial_core.h  |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

--- linux-2.6.18.1.orig/drivers/serial/serial_core.c
+++ linux-2.6.18.1/drivers/serial/serial_core.c
@@ -1932,6 +1932,9 @@ int uart_suspend_port(struct uart_driver
 	if (state->info && state->info->flags & UIF_INITIALIZED) {
 		const struct uart_ops *ops = port->ops;
 
+		state->info->flags = (state->info->flags & ~UIF_INITIALIZED)
+				     | UIF_SUSPENDED;
+
 		spin_lock_irq(&port->lock);
 		ops->stop_tx(port);
 		ops->set_mctrl(port, 0);
@@ -1991,7 +1994,7 @@ int uart_resume_port(struct uart_driver 
 		console_start(port->cons);
 	}
 
-	if (state->info && state->info->flags & UIF_INITIALIZED) {
+	if (state->info && state->info->flags & UIF_SUSPENDED) {
 		const struct uart_ops *ops = port->ops;
 		int ret;
 
@@ -2003,15 +2006,17 @@ int uart_resume_port(struct uart_driver 
 			ops->set_mctrl(port, port->mctrl);
 			ops->start_tx(port);
 			spin_unlock_irq(&port->lock);
+			state->info->flags |= UIF_INITIALIZED;
 		} else {
 			/*
 			 * Failed to resume - maybe hardware went away?
 			 * Clear the "initialized" flag so we won't try
 			 * to call the low level drivers shutdown method.
 			 */
-			state->info->flags &= ~UIF_INITIALIZED;
 			uart_shutdown(state);
 		}
+
+		state->info->flags &= ~UIF_SUSPENDED;
 	}
 
 	mutex_unlock(&state->mutex);
--- linux-2.6.18.1.orig/include/linux/serial_core.h
+++ linux-2.6.18.1/include/linux/serial_core.h
@@ -319,6 +319,7 @@ struct uart_info {
 #define UIF_CTS_FLOW		((__force uif_t) (1 << 26))
 #define UIF_NORMAL_ACTIVE	((__force uif_t) (1 << 29))
 #define UIF_INITIALIZED		((__force uif_t) (1 << 31))
+#define UIF_SUSPENDED		((__force uif_t) (1 << 30))
 
 	int			blocked_open;
 

--
