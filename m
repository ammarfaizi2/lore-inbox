Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbREPWNh>; Wed, 16 May 2001 18:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262104AbREPWNR>; Wed, 16 May 2001 18:13:17 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:30735 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S262099AbREPWNM>;
	Wed, 16 May 2001 18:13:12 -0400
Date: Wed, 16 May 2001 16:12:45 -0600
From: Val Henson <val@nmt.edu>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: Theodore Tso <tytso@valinux.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/char/serial.c bug in ST16C654 detection
Message-ID: <20010516161245.O6892@boardwalk>
In-Reply-To: <20010511182723.M18959@boardwalk> <033101c0dcaf$10557f40$294b82ce@connecttech.com> <20010514162010.G5060@boardwalk> <010001c0dd46$38fc9360$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <010001c0dd46$38fc9360$294b82ce@connecttech.com>; from stuartm@connecttech.com on Tue, May 15, 2001 at 09:52:01AM -0400
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know where Ted Tso is?  He hasn't posted in several weeks.
Alan, will you put this in -ac?  This patch fixes a bug in serial.c
that causes a crash on machines with a ST16C654.

On Tue, May 15, 2001 at 09:52:01AM -0400, Stuart MacDonald wrote:

> Kernel version? Distribution? Are you using a serial console?

2.4.5-pre1 (see patch).

> The revision should always be saved if it's available. Hmm.
> I didn't look carefully yesterday. The DLL always contains the
> revision for the 85x family. Why do you think it doesn't?

Because the comment was ambiguous.  I don't have the data sheet for
the 85x family so I just wrote the code according to the comment.
I'll change the comment to make it clear.

> I think your patch below is good, I'm just mystified by this
> kablooey thing.

Thanks.  Corrected version of the patch is below.

-VAL

--- linux-2.4.5-pre1/drivers/char/serial.c	Thu Apr 19 00:26:34 2001
+++ linux/drivers/char/serial.c	Thu May 17 03:12:09 2001
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
+	 * XR16C854 and the DLL contains the chip revision.
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


