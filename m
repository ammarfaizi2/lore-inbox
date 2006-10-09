Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933001AbWJISwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbWJISwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932995AbWJISwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:52:46 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:64644 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S933001AbWJISwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:52:45 -0400
Date: Mon, 9 Oct 2006 14:52:43 -0400
From: "George G. Davis" <gdavis@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Make sure UART is powered up when dumping MCTRL status
Message-ID: <20061009185243.GL21011@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since serial devices are powered down when not in use and some of those
devices cannot be accessed when powered down, we need to enable power
around calls to get_mcrtl() when dumping port state via uart_line_info().
This resolves hangs observed on some machines while reading serial device
registers when a port is powered off.

Signed-off-by: George G. Davis <gdavis@mvista.com>

 drivers/serial/serial_core.c |   11 +++++++++++
 1 files changed, 11 insertions(+)


Index: linux-2.6/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.orig/drivers/serial/serial_core.c
+++ linux-2.6/drivers/serial/serial_core.c
@@ -1652,6 +1652,7 @@ static const char *uart_type(struct uart
 static int uart_line_info(char *buf, struct uart_driver *drv, int i)
 {
 	struct uart_state *state = drv->state + i;
+	int pm_state;
 	struct uart_port *port = state->port;
 	char stat_buf[32];
 	unsigned int status;
@@ -1674,9 +1675,16 @@ static int uart_line_info(char *buf, str
 
 	if(capable(CAP_SYS_ADMIN))
 	{
+		mutex_lock(&state->mutex);
+		pm_state = state->pm_state;
+		if (pm_state)
+			uart_change_pm(state, 0);
 		spin_lock_irq(&port->lock);
 		status = port->ops->get_mctrl(port);
 		spin_unlock_irq(&port->lock);
+		if (pm_state)
+			uart_change_pm(state, pm_state);
+		mutex_unlock(&state->mutex);
 
 		ret += sprintf(buf + ret, " tx:%d rx:%d",
 				port->icount.tx, port->icount.rx);
@@ -2071,6 +2079,9 @@ uart_configure_port(struct uart_driver *
 
 		uart_report_port(drv, port);
 
+		/* Power up port for set_mctrl() */
+		uart_change_pm(state, 0);
+
 		/*
 		 * Ensure that the modem control lines are de-activated.
 		 * We probably don't need a spinlock around this, but


FYI: I've posted the above to the linux-serial mailing list but have not
received any additional feedback after reworking to incorporate changes
recommended via that mailing list.  That thread ends here:

http://www.spinics.net/lists/linux-serial/msg00196.html

I'm now posting this reworked version to linux-kernel to move this along.

TIA for comments/feedback!

--
Regards,
George
