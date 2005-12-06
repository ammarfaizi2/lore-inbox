Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbVLFGpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVLFGpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 01:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVLFGpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 01:45:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:24475 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751023AbVLFGpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 01:45:42 -0500
Message-ID: <43953440.9070102@in.ibm.com>
Date: Tue, 06 Dec 2005 12:18:32 +0530
From: Sachin Sant <sachinp@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
References: <438D8A3A.9030400@in.ibm.com> <20051130130429.GB25032@flint.arm.linux.org.uk>
In-Reply-To: <20051130130429.GB25032@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------010204080000050802000504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010204080000050802000504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> Why are you doing this and not using uart_handle_break()?
> 
> Do you realise that this enables sysrq support for _any_ 8250 serial
> port, be it console or not?
> 
At present we have ctrl-break that works over a serial connection. But 
there are few instances where the above does not works. Consider the 
following senarios

p615, power4, no-hmc configuration.

I attached an IBM 3153 (a "real" tty) to the serial port.I then observed
that neither ctrl-o or the tty's ctrl-SysRq_key worked. (but ctrl-o did 
still work with the patched kernel, of course).  However, the 
ctrl-Break_key does work on the native tty, taking the place of the 
ctrl-o on vterms.So in summary, ctrl-Break works. I then re-attached the 
cu cable (both are defined alike as ttyS0 and give login's) and 
re-verified that ctrl-Break stopped working.

In the future, if this configuration is found hung, then (provided sysrq 
was enabled), attach a physical tty and use ctrl-Break to debug.

2nd configuration: p630, hmc-attached, booted in "full-system partition" 
mode.Everything in the first configuration applied here too.There is 
only a slight diff in the way the console works.Since the hmc is 
attached, the "vterm" on the hmc will be the console.However, when it is 
booted in "full-system partition" mode, the OS sees that console as 
ttyS0 - just like a non-hmc attached connection.Unfortunately, neither 
the ctrl-o nor the ctrl-Break works on this either (just like the cu 
session above).The only way to get ctrl-Break to work is to "close the 
terminal" operation on the hmc, and then attach and turn on a real tty 
onto the lowest serial port (not the "HMC" port) on the p630.  You can't 
have both running at the same time, because they both configure as 
ttyS0.  Then with the real tty attached, you can use ctrl-Break to debug.

So the general idea behind this patch was to make the behaviour of 
invoking sysrq key more consistent over virtual and real consoles. It's 
not a must but would be nice to have this functionality.

> 
> We don't drop the lock when calling uart_handle_sysrq_char() further
> down in this function.  Why is this needed?  Also, why is this needed
> to be duplicated?
> 
You are correct. This is not needed. I have removed this piece of code.

How about the following patch.

--------------010204080000050802000504
Content-Type: text/plain;
 name="8250-magic-sysrq-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8250-magic-sysrq-support.patch"

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>

diff -Naurp a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	2005-11-11 11:03:12.000000000 +0530
+++ b/drivers/serial/8250.c	2005-12-06 11:52:40.000000000 +0530
@@ -1084,6 +1084,15 @@ receive_chars(struct uart_8250_port *up,
 			 */
 		}
 		ch = serial_inp(up, UART_RX);
+
+#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
+		/* Handle the SysRq ^O Hack */
+		if (ch == '\x0f') {
+			up->port.sysrq = jiffies + HZ*5;
+			goto ignore_char; 
+		}
+#endif /* CONFIG_MAGIC_SYSRQ && CONFIG_SERIAL_CORE_CONSOLE */
+
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 

--------------010204080000050802000504--
