Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbULBOsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbULBOsz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbULBOsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:48:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10514 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261646AbULBOsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:48:52 -0500
Date: Thu, 2 Dec 2004 14:48:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Mock <kd6pag@qsl.net>
Cc: Andrew Morton <akpm@osdl.org>, zadiglist@zadig.ca,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-ID: <20041202144836.A7760@flint.arm.linux.org.uk>
Mail-Followup-To: John Mock <kd6pag@qsl.net>, Andrew Morton <akpm@osdl.org>,
	zadiglist@zadig.ca,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <E1CZmgM-0000Lb-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1CZmgM-0000Lb-00@penngrove.fdns.net>; from kd6pag@qsl.net on Thu, Dec 02, 2004 at 12:51:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 12:51:22AM -0800, John Mock wrote:
> A second crash involving software suspend looks
> like it might be 'UART' related, but i'm not sure if i can reproduce that
> one easily (as i'm not running that kernel).

Please try this patch.

--- linux-2.6-serial/drivers/serial/serial_core.c	Wed Dec  1 10:41:10 2004
+++ linux/drivers/serial/serial_core.c	Thu Dec  2 13:34:47 2004
@@ -1877,7 +1877,21 @@
 	 * Re-enable the console device after suspending.
 	 */
 	if (uart_console(port)) {
-		uart_change_speed(state, NULL);
+		struct termios termios;
+
+		/*
+		 * First try to use the console cflag setting.
+		 */
+		memset(&termios, 0, sizeof(struct termios));
+		termios.c_cflag = port->cons->cflag;
+
+		/*
+		 * If that's unset, use the tty termios setting.
+		 */
+		if (state->info && state->info->tty && termios.c_cflag == 0)
+			termios = *state->info->tty->termios;
+
+		port->ops->set_termios(port, &termios, NULL);
 		console_start(port->cons);
 	}
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
