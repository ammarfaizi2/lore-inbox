Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbUDFOvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbUDFOvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:51:15 -0400
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:49069 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263846AbUDFOvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:51:05 -0400
Date: Tue, 6 Apr 2004 16:51:02 +0200
From: Stelian Pop <stelian@popies.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <amitkale@emsyssoft.com>, ganzinger@mvista.com
Subject: Re: [Kgdb-bugreport] [KGDB] Make kgdb get in sync with it's I/O drivers for the breakpoint
Message-ID: <20040406145102.GQ2718@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Tom Rini <trini@kernel.crashing.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Amit S. Kale" <amitkale@emsyssoft.com>, ganzinger@mvista.com
References: <20040405233058.GV31152@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405233058.GV31152@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 04:30:58PM -0700, Tom Rini wrote:

> Hello.  The following interdiff, vs current kgdb-2 CVS makes kgdb core
> and I/O drivers get in sync in order to cause a breakpoint.  This kills
> off the init/main.c change, and makes way for doing things much earlier,
> if other support exists. 

And it works perfectly for me too (with the pcmcia net card, debug
started by sysrq+g).

There are however a couple of cleanups and a compile fix attached.

> What would be left, tangentally, is some sort
> of queue to register with, so we can handle the case of KGDBOE on a
> pcmcia card.  George? Amit? Comments ?

Maybe this could be done in a more kgdb-independent way in the
netpoll layer. There is already some code there who waits for
the carrier on a net card. Maybe this could be extended to also
wait for the network card to appear...

Stelian.


--- drivers/serial/kgdb_8250.c.ORIG	2004-04-06 12:44:01.000000000 +0200
+++ drivers/serial/kgdb_8250.c	2004-04-06 12:50:13.000000000 +0200
@@ -63,6 +63,9 @@
 static atomic_t kgdb8250_buf_in_cnt;
 static int kgdb8250_buf_out_inx;
 
+/* forward decl */
+struct kgdb_serial kgdb8250_serial_driver;
+
 /* Determine serial information. */
 static struct serial_state state = {
 	.magic = SSTATE_MAGIC,
@@ -131,7 +134,7 @@
 /*
  * Wait until the interface can accept a char, then write it.
  */
-void
+static void
 kgdb_put_debug_char(int chr)
 {
 	while (!(serial_inb(kgdb8250_port + (UART_LSR << reg_shift)) &
@@ -170,7 +173,7 @@
  * Empty the receive buffer first, then look at the interface hardware.
  */
 
-int
+static int
 kgdb_get_debug_char(void)
 {
 	int retchr;
@@ -393,7 +396,7 @@
 }
 module_init(kgdb8250_hookup_irq);
 
-int
+static int
 kgdb_hook_io(void)
 {
 	/* If we've already been initialized, return. */
-- 
Stelian Pop <stelian@popies.net>
