Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262539AbRENWVX>; Mon, 14 May 2001 18:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbRENWVE>; Mon, 14 May 2001 18:21:04 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:31504 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S262537AbRENWUn>;
	Mon, 14 May 2001 18:20:43 -0400
Date: Mon, 14 May 2001 16:20:11 -0600
From: Val Henson <val@nmt.edu>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Theodore Tso <tytso@valinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/char/serial.c bug in ST16C654 detection
Message-ID: <20010514162010.G5060@boardwalk>
In-Reply-To: <20010511182723.M18959@boardwalk> <033101c0dcaf$10557f40$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <033101c0dcaf$10557f40$294b82ce@connecttech.com>; from stuartm@connecttech.com on Mon, May 14, 2001 at 03:50:01PM -0400
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 03:50:01PM -0400, Stuart MacDonald wrote:

> What version of serial.c? I'm assuming 5.05.

Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled

> Define "go kablooey". We haven't noticed any problems, and we supplied
> this bit of code.

"Go kablooey" means that all serial output stops and the kernel never
finishes booting.  This patch makes it correctly detect the
controller, continue to produce serial output, and finish booting.

> The size_fifo() routine supplies its own baud rate divisor, and
> on any rs_open() change_speed() sets the baud rate properly.
> I can't figure what you might be seeing.

I don't know why it doesn't work the way you describe.  If I comment
out the section of code that sets the baud rate to 0, everything works
fine.  Otherwise, it doesn't even finish booting.  The Exar datasheet
at http://www.exar.com/products/st16c654.pdf doesn't define what
happens if you set the baud rate registers to 0.

> This isn't necessary. The revision field is only checked
> for 950s, so setting it here doesn't harm anything. If the
> current (only) example of checking it is followed as normal
> procedure, the port type will always be checked first, before
> checking the revision, ensuring only valid revisions are
> referenced.

It's just sloppy programming.  There's no benefit from setting an
invalid revision for the Exar and if the usage of state->revision
changes it may introduce a bug.

> Only saving the revision for 850s is probably wrong. It should
> be saved for all the 85x uarts.

The comment above it should also be changed then.  If someone knows
for sure whether the revision should be saved for the XR16C854 then
the comment can be made clearer.  See patch below.

-VAL

--- linux-2.4.5-pre1/drivers/char/serial.c	Thu Apr 19 00:26:34 2001
+++ linux/drivers/char/serial.c	Tue May 15 03:19:08 2001
@@ -3507,7 +3507,7 @@
 				      struct serial_state *state,
 				      unsigned long flags)
 {
-	unsigned char scratch, scratch2, scratch3;
+	unsigned char scratch, scratch2, scratch3, scratch4;
 
 	/*
 	 * First we check to see if it's an Oxford Semiconductor UART.
@@ -3548,20 +3548,33 @@
 	 * then reading back DLL and DLM.  If DLM reads back 0x10,
 	 * then the UART is a XR16C850 and the DLL contains the chip
 	 * revision.  If DLM reads back 0x14, then the UART is a
-	 * XR16C854.
-	 * 
+	 * XR16C854 and the DLL may or may not contain the revision.
 	 */
+
+	/* Save the DLL and DLM */
+
 	serial_outp(info, UART_LCR, UART_LCR_DLAB);
+	scratch3 = serial_inp(info, UART_DLL);
+	scratch4 = serial_inp(info, UART_DLM);
+
 	serial_outp(info, UART_DLL, 0);
 	serial_outp(info, UART_DLM, 0);
-	state->revision = serial_inp(info, UART_DLL);
+	scratch2 = serial_inp(info, UART_DLL);
 	scratch = serial_inp(info, UART_DLM);
 	serial_outp(info, UART_LCR, 0);
+
 	if (scratch == 0x10 || scratch == 0x14) {
+		state->revision = scratch2;
 		state->type = PORT_16850;
 		return;
 	}
 
+	/* Restore the DLL and DLM */
+
+	serial_outp(info, UART_LCR, UART_LCR_DLAB);
+	serial_outp(info, UART_DLL, scratch3);
+	serial_outp(info, UART_DLM, scratch4);
+	serial_outp(info, UART_LCR, 0);
 	/*
 	 * We distinguish between the '654 and the '650 by counting
 	 * how many bytes are in the FIFO.  I'm using this for now,
