Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVC1TDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVC1TDD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVC1TDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:03:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33296 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262003AbVC1TCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:02:48 -0500
Date: Mon, 28 Mar 2005 20:02:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Phil Oester <kernel@linuxace.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050328200243.C2222@flint.arm.linux.org.uk>
Mail-Followup-To: Phil Oester <kernel@linuxace.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <20050328173652.GA31354@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050328173652.GA31354@linuxace.com>; from kernel@linuxace.com on Mon, Mar 28, 2005 at 09:36:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:36:52AM -0800, Phil Oester wrote:
> On Sat, Mar 26, 2005 at 03:10:05PM +0000, Russell King wrote:
> > Doesn't matter. The problem is that dwmw2's NS16550A patch (from ages
> > ago) changes the prescaler setting for this device so we can use the
> > higher speed baud rates. This means any programmed divisor (programmed
> > at early serial console initialisation time) suddenly becomes wrong as
> > soon as we fiddle with the prescaler during normal UART initialisation
> > time.
> 
> Seems like you are correct, given the below patch fixes the garbage
> output for me.

David,

Is this patch ok for you?

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


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
