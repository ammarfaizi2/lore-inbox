Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVC1RhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVC1RhA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVC1RhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:37:00 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:42257
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261962AbVC1Rgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:36:53 -0500
Date: Mon, 28 Mar 2005 09:36:52 -0800
From: Phil Oester <kernel@linuxace.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050328173652.GA31354@linuxace.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 26, 2005 at 03:10:05PM +0000, Russell King wrote:
> Doesn't matter. The problem is that dwmw2's NS16550A patch (from ages
> ago) changes the prescaler setting for this device so we can use the
> higher speed baud rates. This means any programmed divisor (programmed
> at early serial console initialisation time) suddenly becomes wrong as
> soon as we fiddle with the prescaler during normal UART initialisation
> time.

Seems like you are correct, given the below patch fixes the garbage
output for me.

Phil



--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-serial

--- linux-standard/drivers/serial/8250.c	2005-03-02 02:37:47.000000000 -0500
+++ linux-dellfw/drivers/serial/8250.c	2005-03-28 12:28:34.560032856 -0500
@@ -698,7 +698,7 @@
 		serial_outp(up, UART_MCR, status1);
 
 		if ((status2 ^ status1) & UART_MCR_LOOP) {
-#ifndef CONFIG_PPC
+#if 0
 			serial_outp(up, UART_LCR, 0xE0);
 			status1 = serial_in(up, 0x04); /* EXCR1 */
 			status1 &= ~0xB0; /* Disable LOCK, mask out PRESL[01] */

--VbJkn9YxBvnuCH5J--
