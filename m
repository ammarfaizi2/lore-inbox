Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262755AbREONv1>; Tue, 15 May 2001 09:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262756AbREONvR>; Tue, 15 May 2001 09:51:17 -0400
Received: from inet.connecttech.com ([206.130.75.2]:35777 "EHLO
	inet.connecttech.com") by vger.kernel.org with ESMTP
	id <S262755AbREONu7>; Tue, 15 May 2001 09:50:59 -0400
Message-ID: <010001c0dd46$38fc9360$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Val Henson" <val@nmt.edu>
Cc: "Theodore Tso" <tytso@valinux.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010511182723.M18959@boardwalk> <033101c0dcaf$10557f40$294b82ce@connecttech.com> <20010514162010.G5060@boardwalk>
Subject: Re: [PATCH] drivers/char/serial.c bug in ST16C654 detection
Date: Tue, 15 May 2001 09:52:01 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Val Henson" <val@nmt.edu>
> Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI enabled

Hmm. I've been looking at 5.05 (from http://serial.sourceforge.net),
I'm getting 2.4.4 and 2.4.5-pre2 to see what's in there.

> "Go kablooey" means that all serial output stops and the kernel never
> finishes booting.  This patch makes it correctly detect the
> controller, continue to produce serial output, and finish booting.

Kernel version? Distribution? Are you using a serial console?

> I don't know why it doesn't work the way you describe.  If I comment
> out the section of code that sets the baud rate to 0, everything works
> fine.  Otherwise, it doesn't even finish booting.  The Exar datasheet
> at http://www.exar.com/products/st16c654.pdf doesn't define what
> happens if you set the baud rate registers to 0.

Yeah, I double checked the 654 and 864 sheets yesterday. No mention,
which is sorta odd for the 864, since they explicitly say to write the 0s
to get the revision. I'd have to assume that it's bad. This bit I copied
from one of our hardware guys, and it worked, so I never looked too
closely at it. My apologies.

> It's just sloppy programming.  There's no benefit from setting an
> invalid revision for the Exar and if the usage of state->revision
> changes it may introduce a bug.

I agree with you. However, the revision is Ted's code, and I've
generally found it easier to get our patches in to the driver if I
do what he's already doing. However, I agree with you.

> The comment above it should also be changed then.  If someone knows
> for sure whether the revision should be saved for the XR16C854 then
> the comment can be made clearer.  See patch below.

The revision should always be saved if it's available. Hmm.
I didn't look carefully yesterday. The DLL always contains the
revision for the 85x family. Why do you think it doesn't?

I think your patch below is good, I'm just mystified by this
kablooey thing.

..Stu

--- linux-2.4.5-pre1/drivers/char/serial.c Thu Apr 19 00:26:34 2001
+++ linux/drivers/char/serial.c Tue May 15 03:19:08 2001
@@ -3507,7 +3507,7 @@
        struct serial_state *state,
        unsigned long flags)
 {
- unsigned char scratch, scratch2, scratch3;
+ unsigned char scratch, scratch2, scratch3, scratch4;

  /*
  * First we check to see if it's an Oxford Semiconductor UART.
@@ -3548,20 +3548,33 @@
  * then reading back DLL and DLM.  If DLM reads back 0x10,
  * then the UART is a XR16C850 and the DLL contains the chip
  * revision.  If DLM reads back 0x14, then the UART is a
- * XR16C854.
- *
+ * XR16C854 and the DLL may or may not contain the revision.
  */
+
+ /* Save the DLL and DLM */
+
  serial_outp(info, UART_LCR, UART_LCR_DLAB);
+ scratch3 = serial_inp(info, UART_DLL);
+ scratch4 = serial_inp(info, UART_DLM);
+
  serial_outp(info, UART_DLL, 0);
  serial_outp(info, UART_DLM, 0);
- state->revision = serial_inp(info, UART_DLL);
+ scratch2 = serial_inp(info, UART_DLL);
  scratch = serial_inp(info, UART_DLM);
  serial_outp(info, UART_LCR, 0);
+
  if (scratch == 0x10 || scratch == 0x14) {
+ state->revision = scratch2;
  state->type = PORT_16850;
  return;
  }

+ /* Restore the DLL and DLM */
+
+ serial_outp(info, UART_LCR, UART_LCR_DLAB);
+ serial_outp(info, UART_DLL, scratch3);
+ serial_outp(info, UART_DLM, scratch4);
+ serial_outp(info, UART_LCR, 0);
  /*
  * We distinguish between the '654 and the '650 by counting
  * how many bytes are in the FIFO.  I'm using this for now,


