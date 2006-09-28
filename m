Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWI1Lv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWI1Lv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWI1Lv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:51:26 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:32230 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751856AbWI1LvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:51:25 -0400
Date: Thu, 28 Sep 2006 13:51:31 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] atmel_serial: Kill at91_register_uart_fns
Message-ID: <20060928135131.0d075ab5@cad-250-152.norway.atmel.com>
In-Reply-To: <1159442049.23157.94.camel@fuzzie.sanpeople.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	<115937628584-git-send-email-hskinnemoen@atmel.com>
	<11593762852168-git-send-email-hskinnemoen@atmel.com>
	<11593762851735-git-send-email-hskinnemoen@atmel.com>
	<11593762853931-git-send-email-hskinnemoen@atmel.com>
	<11593762851544-git-send-email-hskinnemoen@atmel.com>
	<11593762851494-git-send-email-hskinnemoen@atmel.com>
	<1159376285621-git-send-email-hskinnemoen@atmel.com>
	<11593762852950-git-send-email-hskinnemoen@atmel.com>
	<1159435315.23157.73.camel@fuzzie.sanpeople.com>
	<20060928113857.0e3e7c48@cad-250-152.norway.atmel.com>
	<1159442049.23157.94.camel@fuzzie.sanpeople.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Sep 2006 13:14:09 +0200
Andrew Victor <andrew@sanpeople.com> wrote:

> hi Haavard,
> 
> > Ok, I sort of suspected that. But I can't see any users in the
> > kernel tree, so perhaps we should leave the name of the function
> > alone too? (i.e. just drop the patch)
> 
> For consistency, the function name should be renamed (at91 -> atmel).
> I'm not up-to-date with the features of the AVR32-based boards, but
> this functionality might also be useful there.
> 
> Out-of-mainline users will just have to update their patches.  :)

Ok, here's a patch that does that. I've renamed at91_open and
at91_close to atmel_open_hook and atmel_close_hook as well to make it
more clear what they really are.

Haavard
---
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] atmel_serial: Rename at91_register_uart_fns

Rename at91_register_uart_fns and associated structs and variables
to make it consistent with the atmel_ prefix used by the rest of
the driver.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/atmel_serial.c        |   18 +++++++++---------
 include/asm-arm/mach/serial_at91.h   |    6 +++---
 include/asm-avr32/mach/serial_at91.h |    6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 43393de..4625541 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -101,8 +101,8 @@ #define UART_PUT_TCR(port,v)	writel(v, (
 //#define UART_PUT_TNPR(port,v)	writel(v, (port)->membase + ATMEL_PDC_TNPR)
 //#define UART_PUT_TNCR(port,v)	writel(v, (port)->membase + ATMEL_PDC_TNCR)
 
-static int (*at91_open)(struct uart_port *);
-static void (*at91_close)(struct uart_port *);
+static int (*atmel_open_hook)(struct uart_port *);
+static void (*atmel_close_hook)(struct uart_port *);
 
 /*
  * We wrap our port structure around the generic uart_port.
@@ -399,8 +399,8 @@ static int atmel_startup(struct uart_por
 	 * If there is a specific "open" function (to register
 	 * control line interrupts)
 	 */
-	if (at91_open) {
-		retval = at91_open(port);
+	if (atmel_open_hook) {
+		retval = atmel_open_hook(port);
 		if (retval) {
 			free_irq(port->irq, port);
 			return retval;
@@ -440,8 +440,8 @@ static void atmel_shutdown(struct uart_p
 	 * If there is a specific "close" function (to unregister
 	 * control line interrupts)
 	 */
-	if (at91_close)
-		at91_close(port);
+	if (atmel_close_hook)
+		atmel_close_hook(port);
 }
 
 /*
@@ -711,7 +711,7 @@ static void __devinit atmel_init_port(st
 /*
  * Register board-specific modem-control line handlers.
  */
-void __init at91_register_uart_fns(struct at91_port_fns *fns)
+void __init atmel_register_uart_fns(struct atmel_port_fns *fns)
 {
 	if (fns->enable_ms)
 		atmel_pops.enable_ms = fns->enable_ms;
@@ -719,8 +719,8 @@ void __init at91_register_uart_fns(struc
 		atmel_pops.get_mctrl = fns->get_mctrl;
 	if (fns->set_mctrl)
 		atmel_pops.set_mctrl = fns->set_mctrl;
-	at91_open		= fns->open;
-	at91_close		= fns->close;
+	atmel_open_hook		= fns->open;
+	atmel_close_hook	= fns->close;
 	atmel_pops.pm		= fns->pm;
 	atmel_pops.set_wake	= fns->set_wake;
 }
diff --git a/include/asm-arm/mach/serial_at91.h b/include/asm-arm/mach/serial_at91.h
index 239e1f6..55b317a 100644
--- a/include/asm-arm/mach/serial_at91.h
+++ b/include/asm-arm/mach/serial_at91.h
@@ -14,7 +14,7 @@ struct uart_port;
  * This is a temporary structure for registering these
  * functions; it is intended to be discarded after boot.
  */
-struct at91_port_fns {
+struct atmel_port_fns {
 	void	(*set_mctrl)(struct uart_port *, u_int);
 	u_int	(*get_mctrl)(struct uart_port *);
 	void	(*enable_ms)(struct uart_port *);
@@ -25,9 +25,9 @@ struct at91_port_fns {
 };
 
 #if defined(CONFIG_SERIAL_ATMEL)
-void at91_register_uart_fns(struct at91_port_fns *fns);
+void atmel_register_uart_fns(struct atmel_port_fns *fns);
 #else
-#define at91_register_uart_fns(fns) do { } while (0)
+#define atmel_register_uart_fns(fns) do { } while (0)
 #endif
 
 
diff --git a/include/asm-avr32/mach/serial_at91.h b/include/asm-avr32/mach/serial_at91.h
index 239e1f6..55b317a 100644
--- a/include/asm-avr32/mach/serial_at91.h
+++ b/include/asm-avr32/mach/serial_at91.h
@@ -14,7 +14,7 @@ struct uart_port;
  * This is a temporary structure for registering these
  * functions; it is intended to be discarded after boot.
  */
-struct at91_port_fns {
+struct atmel_port_fns {
 	void	(*set_mctrl)(struct uart_port *, u_int);
 	u_int	(*get_mctrl)(struct uart_port *);
 	void	(*enable_ms)(struct uart_port *);
@@ -25,9 +25,9 @@ struct at91_port_fns {
 };
 
 #if defined(CONFIG_SERIAL_ATMEL)
-void at91_register_uart_fns(struct at91_port_fns *fns);
+void atmel_register_uart_fns(struct atmel_port_fns *fns);
 #else
-#define at91_register_uart_fns(fns) do { } while (0)
+#define atmel_register_uart_fns(fns) do { } while (0)
 #endif
 
 
-- 
1.4.1.1

