Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWEGIax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWEGIax (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 04:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWEGIax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 04:30:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63759 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932104AbWEGIaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 04:30:52 -0400
Date: Sun, 7 May 2006 09:30:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] Buggy uart (for 2.6.16)
Message-ID: <20060507083041.GB15039@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
References: <1144676225.12145.30.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144676225.12145.30.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 09:37:05AM -0400, Steven Rostedt wrote:
> I've noticed that you dropped my "buggy uart" patch.

Note that this isn't going to be merged into mainline because the
"buggy uart" test triggers inappropriately on some ports, so we
need to ensure that this patch doesn't rely upon that wrong behaviour.

Unfortunately, it's taking longer than I expected to get my serial
git tree into a state where it can be merged, so this will have to
wait.  Nevertheless, please test with the following patch applied.

# Base git commit: e0a515bc6a2188f02916e976f419a8640312e32a
#	(Merge branch 'merge' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc)
#
# Author:    Russell King (Tue May  2 16:04:29 BST 2006)
# Committer: Russell King (Tue May  2 16:04:29 BST 2006)
#	
#	[SERIAL] 8250: add locking to console write function
#	
#	x86 SMP breaks as a result of the previous change, we have no real
#	option other than to add locking to the 8250 console write function.
#	If an oops is in progress, try to acquire the lock.  If we fail to
#	do so, continue anyway.
#	
#	Signed-off-by: Russell King
#
#	 drivers/serial/8250.c |   10 ++++++++++
#	 1 files changed, 10 insertions(+), 0 deletions(-)
#
# Author:    Russell King (Sun Apr 30 11:30:15 BST 2006)
# Committer: Russell King (Sun Apr 30 11:30:15 BST 2006)
#	
#	[SERIAL] Remove unconditional enable of TX irq for console
#	
#	A bug report from Gerd Hoffmann has highlighted that unconditionally
#	enabling the transmit interrupt at the end of console writes is very
#	bad.
#	
#	In Gerd's case, it causes the test for buggy UARTs to give false
#	positives, incorrectly identifying ports as buggy when they are not.
#	
#	Moreover, if we unconditionally enable the interrupt, and the port
#	is sharing it's interrupt with other ports, there is the very real
#	possibility that we'll cause an interrupt storm.  (Not all ports use
#	OUT2 as an interrupt mask.)
#	
#	Hence, revert part of f91a3715db2bb44fcf08cec642e68f919b70f7f4 and
#	all of f5968b37b3ad35b682b574b578843a0361218aff until a better solution
#	can be found.
#	
#	Signed-off-by: Russell King
#
#	 drivers/serial/8250.c |    3 +--
#	 1 files changed, 1 insertions(+), 2 deletions(-)
#
# Author:    Jon Anders Haugum (Sun Apr 30 11:20:56 BST 2006)
# Committer: Russell King (Sun Apr 30 11:20:56 BST 2006)
#	
#	[SERIAL] 8250: set divisor register correctly for AMD Alchemy SoC uart
#	
#	Alchemy SoC uart have got a non-standard divisor register that needs some
#	special handling.
#	
#	This patch adds divisor read/write functions with test and special
#	handling for Alchemy internal uart.
#	
#	Signed-off-by: Jon Anders Haugum
#	Signed-off-by: Russell King
#
#	 drivers/serial/8250.c |   55 +++++++++++++++++++++++++++++++++++++------------
#	 1 files changed, 42 insertions(+), 13 deletions(-)
#
# Author:    Sergei Shtylyov (Sun Apr 30 11:15:58 BST 2006)
# Committer: Russell King (Sun Apr 30 11:15:58 BST 2006)
#	
#	[SERIAL] AMD Alchemy UART: claim memory range
#	
#	I've noticed that the 8250/Au1x00 driver (drivers/serial/8250_au1x00.c)
#	doesn't claim UART memory ranges and uses wrong (KSEG1-based) UART
#	addresses instead of the physical ones.
#	
#	Signed-off-by: Sergei Shtylyov
#	Signed-off-by: Russell King
#
#	 drivers/serial/8250.c        |    6 ++++++
#	 drivers/serial/8250_au1x00.c |    5 ++---
#	 2 files changed, 8 insertions(+), 3 deletions(-)
#
# Author:    Russell King (Sun Apr 30 11:13:50 BST 2006)
# Committer: Russell King (Sun Apr 30 11:13:50 BST 2006)
#	
#	[SERIAL] Clean up serial locking when obtaining a reference to a port
#	
#	The locking for the uart_port is over complicated, and can be
#	simplified if we introduce a flag to indicate that a port is "dead"
#	and will be removed.
#	
#	This also helps the validator because it removes a case of non-nested
#	unlock ordering.
#	
#	Signed-off-by: Russell King
#	Signed-off-by: Ingo Molnar
#	Signed-off-by: Andrew Morton
#
#	 drivers/serial/serial_core.c |  114 ++++++++++++++++++++++--------------------
#	 include/linux/serial_core.h  |    1 
#	 2 files changed, 61 insertions(+), 54 deletions(-)
#
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -362,6 +362,40 @@ serial_out(struct uart_8250_port *up, in
 #define serial_inp(up, offset)		serial_in(up, offset)
 #define serial_outp(up, offset, value)	serial_out(up, offset, value)
 
+/* Uart divisor latch read */
+static inline int _serial_dl_read(struct uart_8250_port *up)
+{
+	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
+}
+
+/* Uart divisor latch write */
+static inline void _serial_dl_write(struct uart_8250_port *up, int value)
+{
+	serial_outp(up, UART_DLL, value & 0xff);
+	serial_outp(up, UART_DLM, value >> 8 & 0xff);
+}
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+/* Au1x00 haven't got a standard divisor latch */
+static int serial_dl_read(struct uart_8250_port *up)
+{
+	if (up->port.iotype == UPIO_AU)
+		return __raw_readl(up->port.membase + 0x28);
+	else
+		return _serial_dl_read(up);
+}
+
+static void serial_dl_write(struct uart_8250_port *up, int value)
+{
+	if (up->port.iotype == UPIO_AU)
+		__raw_writel(value, up->port.membase + 0x28);
+	else
+		_serial_dl_write(up, value);
+}
+#else
+#define serial_dl_read(up) _serial_dl_read(up)
+#define serial_dl_write(up, value) _serial_dl_write(up, value)
+#endif
 
 /*
  * For the 16C950
@@ -494,7 +528,8 @@ static void disable_rsa(struct uart_8250
  */
 static int size_fifo(struct uart_8250_port *up)
 {
-	unsigned char old_fcr, old_mcr, old_dll, old_dlm, old_lcr;
+	unsigned char old_fcr, old_mcr, old_lcr;
+	unsigned short old_dl;
 	int count;
 
 	old_lcr = serial_inp(up, UART_LCR);
@@ -505,10 +540,8 @@ static int size_fifo(struct uart_8250_po
 		    UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 	serial_outp(up, UART_MCR, UART_MCR_LOOP);
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
-	old_dll = serial_inp(up, UART_DLL);
-	old_dlm = serial_inp(up, UART_DLM);
-	serial_outp(up, UART_DLL, 0x01);
-	serial_outp(up, UART_DLM, 0x00);
+	old_dl = serial_dl_read(up);
+	serial_dl_write(up, 0x0001);
 	serial_outp(up, UART_LCR, 0x03);
 	for (count = 0; count < 256; count++)
 		serial_outp(up, UART_TX, count);
@@ -519,8 +552,7 @@ static int size_fifo(struct uart_8250_po
 	serial_outp(up, UART_FCR, old_fcr);
 	serial_outp(up, UART_MCR, old_mcr);
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
-	serial_outp(up, UART_DLL, old_dll);
-	serial_outp(up, UART_DLM, old_dlm);
+	serial_dl_write(up, old_dl);
 	serial_outp(up, UART_LCR, old_lcr);
 
 	return count;
@@ -750,8 +782,7 @@ static void autoconfig_16550a(struct uar
 
 			serial_outp(up, UART_LCR, 0xE0);
 
-			quot = serial_inp(up, UART_DLM) << 8;
-			quot += serial_inp(up, UART_DLL);
+			quot = serial_dl_read(up);
 			quot <<= 3;
 
 			status1 = serial_in(up, 0x04); /* EXCR1 */
@@ -759,8 +790,7 @@ static void autoconfig_16550a(struct uar
 			status1 |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
 			serial_outp(up, 0x04, status1);
 			
-			serial_outp(up, UART_DLL, quot & 0xff);
-			serial_outp(up, UART_DLM, quot >> 8);
+			serial_dl_write(up, quot);
 
 			serial_outp(up, UART_LCR, 0);
 
@@ -1862,8 +1892,7 @@ serial8250_set_termios(struct uart_port 
 		serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
 	}
 
-	serial_outp(up, UART_DLL, quot & 0xff);		/* LS of divisor */
-	serial_outp(up, UART_DLM, quot >> 8);		/* MS of divisor */
+	serial_dl_write(up, quot);
 
 	/*
 	 * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
@@ -1906,6 +1935,9 @@ static int serial8250_request_std_resour
 	int ret = 0;
 
 	switch (up->port.iotype) {
+	case UPIO_AU:
+		size = 0x100000;
+		/* fall thru */
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
@@ -1938,6 +1970,9 @@ static void serial8250_release_std_resou
 	unsigned int size = 8 << up->port.regshift;
 
 	switch (up->port.iotype) {
+	case UPIO_AU:
+		size = 0x100000;
+		/* fall thru */
 	case UPIO_MEM:
 		if (!up->port.mapbase)
 			break;
@@ -2200,10 +2235,17 @@ static void
 serial8250_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
+	unsigned long flags;
 	unsigned int ier;
+	int locked = 1;
 
 	touch_nmi_watchdog();
 
+	if (oops_in_progress) {
+		locked = spin_trylock_irqsave(&up->port.lock, flags);
+	} else
+		spin_lock_irqsave(&up->port.lock, flags);
+
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
@@ -2221,8 +2263,10 @@ serial8250_console_write(struct console 
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, ier | UART_IER_THRI);
+	serial_out(up, UART_IER, ier);
+
+	if (locked)
+		spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)
diff --git a/drivers/serial/8250_au1x00.c b/drivers/serial/8250_au1x00.c
--- a/drivers/serial/8250_au1x00.c
+++ b/drivers/serial/8250_au1x00.c
@@ -30,13 +30,12 @@
 	{						\
 		.iobase		= _base,		\
 		.membase	= (void __iomem *)_base,\
-		.mapbase	= _base,		\
+		.mapbase	= CPHYSADDR(_base),	\
 		.irq		= _irq,			\
 		.uartclk	= 0,	/* filled */	\
 		.regshift	= 2,			\
 		.iotype		= UPIO_AU,		\
-		.flags		= UPF_SKIP_TEST | 	\
-				  UPF_IOREMAP,		\
+		.flags		= UPF_SKIP_TEST 	\
 	}
 
 static struct plat_serial8250_port au1x00_data[] = {
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1500,20 +1500,18 @@ uart_block_til_ready(struct file *filp, 
 static struct uart_state *uart_get(struct uart_driver *drv, int line)
 {
 	struct uart_state *state;
+	int ret = 0;
 
-	mutex_lock(&port_mutex);
 	state = drv->state + line;
 	if (mutex_lock_interruptible(&state->mutex)) {
-		state = ERR_PTR(-ERESTARTSYS);
-		goto out;
+		ret = -ERESTARTSYS;
+		goto err;
 	}
 
 	state->count++;
-	if (!state->port) {
-		state->count--;
-		mutex_unlock(&state->mutex);
-		state = ERR_PTR(-ENXIO);
-		goto out;
+	if (!state->port || state->port->flags & UPF_DEAD) {
+		ret = -ENXIO;
+		goto err_unlock;
 	}
 
 	if (!state->info) {
@@ -1531,15 +1529,17 @@ static struct uart_state *uart_get(struc
 			tasklet_init(&state->info->tlet, uart_tasklet_action,
 				     (unsigned long)state);
 		} else {
-			state->count--;
-			mutex_unlock(&state->mutex);
-			state = ERR_PTR(-ENOMEM);
+			ret = -ENOMEM;
+			goto err_unlock;
 		}
 	}
-
- out:
-	mutex_unlock(&port_mutex);
 	return state;
+
+ err_unlock:
+	state->count--;
+	mutex_unlock(&state->mutex);
+ err:
+	return ERR_PTR(ret);
 }
 
 /*
@@ -2085,45 +2085,6 @@ uart_configure_port(struct uart_driver *
 	}
 }
 
-/*
- * This reverses the effects of uart_configure_port, hanging up the
- * port before removal.
- */
-static void
-uart_unconfigure_port(struct uart_driver *drv, struct uart_state *state)
-{
-	struct uart_port *port = state->port;
-	struct uart_info *info = state->info;
-
-	if (info && info->tty)
-		tty_vhangup(info->tty);
-
-	mutex_lock(&state->mutex);
-
-	state->info = NULL;
-
-	/*
-	 * Free the port IO and memory resources, if any.
-	 */
-	if (port->type != PORT_UNKNOWN)
-		port->ops->release_port(port);
-
-	/*
-	 * Indicate that there isn't a port here anymore.
-	 */
-	port->type = PORT_UNKNOWN;
-
-	/*
-	 * Kill the tasklet, and free resources.
-	 */
-	if (info) {
-		tasklet_kill(&info->tlet);
-		kfree(info);
-	}
-
-	mutex_unlock(&state->mutex);
-}
-
 static struct tty_operations uart_ops = {
 	.open		= uart_open,
 	.close		= uart_close,
@@ -2270,6 +2231,7 @@ int uart_add_one_port(struct uart_driver
 	state = drv->state + port->line;
 
 	mutex_lock(&port_mutex);
+	mutex_lock(&state->mutex);
 	if (state->port) {
 		ret = -EINVAL;
 		goto out;
@@ -2304,7 +2266,13 @@ int uart_add_one_port(struct uart_driver
 	    port->cons && !(port->cons->flags & CON_ENABLED))
 		register_console(port->cons);
 
+	/*
+	 * Ensure UPF_DEAD is not set.
+	 */
+	port->flags &= ~UPF_DEAD;
+
  out:
+	mutex_unlock(&state->mutex);
 	mutex_unlock(&port_mutex);
 
 	return ret;
@@ -2322,6 +2290,7 @@ int uart_add_one_port(struct uart_driver
 int uart_remove_one_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct uart_state *state = drv->state + port->line;
+	struct uart_info *info;
 
 	BUG_ON(in_interrupt());
 
@@ -2332,11 +2301,48 @@ int uart_remove_one_port(struct uart_dri
 	mutex_lock(&port_mutex);
 
 	/*
+	 * Mark the port "dead" - this prevents any opens from
+	 * succeeding while we shut down the port.
+	 */
+	mutex_lock(&state->mutex);
+	port->flags |= UPF_DEAD;
+	mutex_unlock(&state->mutex);
+
+	/*
 	 * Remove the devices from devfs
 	 */
 	tty_unregister_device(drv->tty_driver, port->line);
 
-	uart_unconfigure_port(drv, state);
+	info = state->info;
+	if (info && info->tty)
+		tty_vhangup(info->tty);
+
+	/*
+	 * All users of this port should now be disconnected from
+	 * this driver, and the port shut down.  We should be the
+	 * only thread fiddling with this port from now on.
+	 */
+	state->info = NULL;
+
+	/*
+	 * Free the port IO and memory resources, if any.
+	 */
+	if (port->type != PORT_UNKNOWN)
+		port->ops->release_port(port);
+
+	/*
+	 * Indicate that there isn't a port here anymore.
+	 */
+	port->type = PORT_UNKNOWN;
+
+	/*
+	 * Kill the tasklet, and free resources.
+	 */
+	if (info) {
+		tasklet_kill(&info->tlet);
+		kfree(info);
+	}
+
 	state->port = NULL;
 	mutex_unlock(&port_mutex);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -254,6 +254,7 @@ struct uart_port {
 #define UPF_CONS_FLOW		((__force upf_t) (1 << 23))
 #define UPF_SHARE_IRQ		((__force upf_t) (1 << 24))
 #define UPF_BOOT_AUTOCONF	((__force upf_t) (1 << 28))
+#define UPF_DEAD		((__force upf_t) (1 << 30))
 #define UPF_IOREMAP		((__force upf_t) (1 << 31))
 
 #define UPF_CHANGE_MASK		((__force upf_t) (0x17fff))


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
