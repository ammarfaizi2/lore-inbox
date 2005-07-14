Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVGNTft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVGNTft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVGNTd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:33:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25104 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263106AbVGNTd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:33:28 -0400
Date: Thu, 14 Jul 2005 20:33:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux Serial List <linux-serial@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050714203321.E10410@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux Serial List <linux-serial@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20050623142335.A5564@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050623142335.A5564@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jun 23, 2005 at 02:23:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 02:23:35PM +0100, Russell King wrote:
> +
> +---------------------------
> +
> +What:	register_serial/unregister_serial
> +When:	December 2005
> +Why:	This interface does not allow serial ports to be registered against
> +	a struct device, and as such does not allow correct power management
> +	of such ports.  8250-based ports should use serial8250_register_port
> +	and serial8250_unregister_port instead.
> +Who:	Russell King <rmk@arm.linux.org.uk>

I think it's about time to make the build a little more vocal about the
expiry of these functions.  Due to recent discussions with problems in
the console initialisation vs power manglement, I'd like to move the
date forward to September.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/serial_core.h linux/include/linux/serial_core.h
--- orig/include/linux/serial_core.h	Sat May 28 20:58:34 2005
+++ linux/include/linux/serial_core.h	Thu Jul 14 16:54:36 2005
@@ -122,6 +122,7 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/spinlock.h>
@@ -359,8 +360,8 @@ struct tty_driver *uart_console_device(s
  */
 int uart_register_driver(struct uart_driver *uart);
 void uart_unregister_driver(struct uart_driver *uart);
-void uart_unregister_port(struct uart_driver *reg, int line);
-int uart_register_port(struct uart_driver *reg, struct uart_port *port);
+void __deprecated uart_unregister_port(struct uart_driver *reg, int line);
+int __deprecated uart_register_port(struct uart_driver *reg, struct uart_port *port);
 int uart_add_one_port(struct uart_driver *reg, struct uart_port *port);
 int uart_remove_one_port(struct uart_driver *reg, struct uart_port *port);
 int uart_match_port(struct uart_port *port1, struct uart_port *port2);
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/include/linux/serial.h linux/include/linux/serial.h
--- orig/include/linux/serial.h	Fri Dec 10 11:25:30 2004
+++ linux/include/linux/serial.h	Thu Jul 14 17:24:38 2005
@@ -174,9 +174,11 @@ struct serial_icounter_struct {
 
 
 #ifdef __KERNEL__
+#include <linux/compiler.h>
+
 /* Export to allow PCMCIA to use this - Dave Hinds */
-extern int register_serial(struct serial_struct *req);
-extern void unregister_serial(int line);
+extern int __deprecated register_serial(struct serial_struct *req);
+extern void __deprecated unregister_serial(int line);
 
 /* Allow architectures to override entries in serial8250_ports[] at run time: */
 struct uart_port;	/* forward declaration */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
