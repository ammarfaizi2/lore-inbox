Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSFDNqQ>; Tue, 4 Jun 2002 09:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSFDNqP>; Tue, 4 Jun 2002 09:46:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63498 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290289AbSFDNqP>;
	Tue, 4 Jun 2002 09:46:15 -0400
Date: Tue, 4 Jun 2002 14:46:07 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Williamson <awilliam@fc.hp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Serial driver iomem fixes
Message-ID: <20020604144607.O10366@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch was written by Alex Williamson.  It fixes a few bugs in the
serial driver that are related to iomem.  Please apply for 2.4.

diff -urNX ../dontdiff linux-ia64/drivers/char/serial.c linux-generic/drivers/char/serial.c
--- linux-ia64/drivers/char/serial.c	Sat May 18 11:58:49 2002
+++ linux-generic/drivers/char/serial.c	Tue May 28 09:42:58 2002
@@ -2133,6 +2137,7 @@
 	if (new_serial.type) {
 		for (i = 0 ; i < NR_PORTS; i++)
 			if ((state != &rs_table[i]) &&
+			    (rs_table[i].io_type == SERIAL_IO_PORT) &&
 			    (rs_table[i].port == new_port) &&
 			    rs_table[i].type)
 				return -EADDRINUSE;
@@ -2195,7 +2200,7 @@
 
 	
 check_and_exit:
-	if (!state->port || !state->type)
+	if ((!state->port && !state->iomem_base) || !state->type)
 		return 0;
 	if (info->flags & ASYNC_INITIALIZED) {
 		if (((old_state.flags & ASYNC_SPD_MASK) !=
@@ -5486,7 +5652,7 @@
 		    && (state->port != 0 || state->iomem_base != 0))
 			state->irq = detect_uart_irq(state);
 		if (state->io_type == SERIAL_IO_MEM) {
-			printk(KERN_INFO"ttyS%02d%s at 0x%px (irq = %d) is a %s\n",
+			printk(KERN_INFO"ttyS%02d%s at 0x%p (irq = %d) is a %s\n",
 	 		       state->line + SERIAL_DEV_OFFSET,
 			       (state->flags & ASYNC_FOURPORT) ? " FourPort" : "",
 			       state->iomem_base, state->irq,

-- 
Revolutions do not require corporate support.
